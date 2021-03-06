KM = {
	gameMode = 1,
	event = {
		category = 0,
		name = '',
	},
	-- scenario
	scenario = {},
	snrIdx = {
		chapter = 1,
		act = 1,
		scene = 1,
		section = 1,
		event = 1,
		skipTab = 1,
		jmpScene = nil,
		jmpSection = nil,
		jmpEvent = nil,
	},
	-- UI
	UI = {},
	-- game data
	role = {},
	city = {},
	unit = {},
	terrain = {},
	flag = {},
	misc = {},
}
function log(...)
	local fp = io.open(os.date('debug_%Y-%m-%d.txt'), 'a+')
	local msg = ''
	for k, v in ipairs({...}) do
		msg = msg .. '\t' .. tostring(v)
	end
	fp:write(os.date('%H:%M:%S '), msg, '\n')
	fp:close()
end
function logTable(t, tabPos)
	tabPos = tabPos or ''
	local tabPos2 = tabPos .. '  '
	if type(t) == 'table' then
		local s = '{'
		for k, v in pairs(t) do
			s = s .. string.format('\n%s%s = %s', tabPos2, tostring(k), logTable(v, tabPos2))
		end
		s = s .. '\n' .. tabPos .. '}'
		if tabPos == '' then
			log(s)
		else
			return s
		end
	else
		return tostring(t)
	end
end
function logTable(t, tabPos)
	tabPos = tabPos or ''
	local tabPos2 = tabPos .. '  '
	if type(t) == 'table' then
		-- local s = '{'
		for k, v in pairs(t) do
			if type(v) == 'table' then
				log(tabPos2 .. tostring(k) .. ' = {')
				logTable(v, tabPos2)
				log(tabPos .. '}')
			else
				log(tabPos2 .. tostring(k) .. ' = ' .. tostring(v))
			end
		end
	end
end
function km_mian()
	km_initStaticData()
	km_initWar()
	km_initUI()
    -- local co_view = coroutine.create(km_view)
    local co_gameLogic = coroutine.create(km_gameLogic)
    local co_uiLogic = coroutine.create(km_uiLogic)
	local t1
	-- CC.FrameNum = 20
	local alive, msg
    while true do
        t1 = lib.GetTime()
		km_view()
        ShowScreen()
		alive, msg = coroutine.resume(co_gameLogic)
		if not alive then
			error(msg)
		end
		alive, msg = coroutine.resume(co_uiLogic)
		if not alive then
			error(msg)
		end
		KM.event.name = ''
		-- collectgarbage()
		t1 = CC.FrameNum + t1 - lib.GetTime()
        if t1 > 0 then
            lib.Delay(t1)
        end
    end
end
function km_view()
	local ui = KM.UI
	KM.event.category = 0
	getkey()
	if MOUSE.EXIT() then
		os.exit()
	end
	if ui.frameT >= 63 then
		ui.frameT = 0
	else
		ui.frameT = ui.frameT + 1
	end
	ui.frame = math.floor(ui.frameT / 16)
	local isGlobalActive = not( ui.notice.show or ui.multiText.show or ui.talk.show or ui.menu.show or ui.menu2.show or ui.table.show or ui.confirm.show or ui.alert.show or ui.showRoleStatus > 0 )
	lib.FillColor(0,0,0,0);
	if KM.gameMode < 2 then
		if ui.scene.map > 0 then
			lib.PicLoadCache(5, ui.scene.map * 2, CC.ScreenW2, CC.ScreenH2, 0)
		end
		-- if not ui.talk.show then
		if true then
			local isActive = isGlobalActive and KM.gameMode == 0
			local x = 24
			local y = 80
			for k, card in ipairs(ui.scene.role) do
				-- km_drawRoleCard(card, card.x, card.y, isActive)
				if k == 1 then
					km_drawRoleCard(card, CC.ScreenW - CC.CardWidth - 32, 24, isActive)
				else
					km_drawRoleCard(card, x, y, isActive)
					y = y + CC.CardHeight + 16
					if y > CC.ScreenH - CC.CardHeight then
						x = x + CC.CardWidth + 12
						y = 80
						if math.floor(x / (CC.CardWidth + 12)) % 2 == 1 then
							y = y - CC.CardHeight / 3
						end
					end
				end
			end
		end
		-- if KM.gameMode == 0 then
			km_drawSceneUI()
		-- end
	elseif KM.gameMode == 2 then
		for i = #KM.war.unitAnimation, 1, -1 do
			local co = KM.war.unitAnimation[i]
			if 'dead' == coroutine.status(co) then
				table.remove(KM.war.unitAnimation, i)
			else
				coroutine.resume(co)
			end
		end
		km_drawWar(isGlobalActive)
	end
	if ui.notice.show then
		local isActive = true
		km_drawNotice(ui.notice.text, isActive)
	end
	if ui.multiText.show then
		local isActive = true
		km_drawMutliText(ui.multiText.text, isActive)
	end
	if ui.talk.show then
		local isActive = not ui.confirm.show
		km_drawTalk(ui.talk.head, ui.talk.name, ui.talk.text, isActive)
	end
	if ui.menu.show then
		local isActive = true
		km_drawMenu(ui.menu, isActive)
	end
	if ui.menu2.show then
		local isActive = true
		km_drawMenu2(ui.menu2, isActive)
	end
	if ui.table.show then
		local isActive = true
		km_drawTable(ui.table, isActive)
	end
	if ui.confirm.show then
		local isActive = true
		km_drawConfirm(isActive)
	end
	if ui.alert.show then
		local isActive = true
		km_drawAlert(ui.alert.text, isActive)
	end
	if ui.showRoleStatus > 0 then
		km_drawRoleStatus(ui.showRoleStatus)
	end
	if MOUSE.status ~= 'HOLD' then
		MOUSE.status = 'IDLE'
	end
	---- Debug ----
	if true then
		DrawStringEnhance(4, 4, '[B]KM.gameMode = ' .. KM.gameMode, M_White, CC.FontSize, 0, 0)
		DrawStringEnhance(4, 134, '[B]KM.event.name = ' .. tostring(KM.event.name), M_White, CC.FontSize, 0, 0)
		DrawStringEnhance(4, 64, '[B]num of roleCard = ' .. #ui.scene.role, M_White, CC.FontSize, 0, 0)
	end
end
function km_gameLogic()
	km_loadScenario(1, 1)
	km_playScenario()
	km_showTrickTable()
	while true do
		if KM.gameMode == 0 then
			km_operate()
		elseif KM.gameMode == 2 then
			km_warOperate()
		end
		coroutine.yield()
	end
	os.exit()
end
function km_uiLogic()
	while true do
		if KM.gameMode == 0 then
			
		elseif KM.gameMode == 2 then
			km_handleWarUI()
		end
		coroutine.yield()
	end
end
function km_operate()
	local ev = KM.event
	if ev.name == '选择人物卡片' then
		km_playScenario('选择人物卡片', ev.pid)
	end
	-- while true do
	-- 	km_waitFrame(1)
	-- 	if ev.category == 2 then

	-- 	elseif ev.category == 1 then
	-- 		return
	-- 	end
	-- end
end
function km_waitFrame(num)
	num = num or 0
	for i = 1, num do
		coroutine.yield()
	end
end
function km_waitTime(t)
	local n = math.ceil(t / CC.FrameNum)
	km_waitFrame(n)
end
function km_waitEvent(...)
	KM.event.name = ''
	if #{...} == 0 then
		km_waitFrame(1)
		return 0
	end
	while true do
		km_waitFrame(1)
		if #KM.event.name> 0 then
			for i, v in ipairs({...}) do
				if KM.event.name == v then
					return i
				end
			end
		end
	end
end
--------------
function km_setScene(mapID)
	KM.UI.scene.map = mapID
	km_waitFrame(4)
end
function km_insertRole(pid, x, y)
	-- local sx = (x + y) * 16 - 1200
	-- local sy = (x - y) * 8 + 240
	local role = KM.role[pid] or {}
	local card = {
		id = pid,
		-- x = sx,
		-- y = sy,
		bgpic = 1051,
		border = 1202,
		head = role['头像'] or 0,
		name = '[W]' .. role['名称'] or '',
		enable = true,
		on = false,
		ontime = 128,
	}
	table.insert(KM.UI.scene.role, card)
end
function km_removeRole(id)
	local role = KM.UI.scene.role
	for k, v in ipairs(role) do
		if v.id == id then
			table.remove(role, k)
			return
		end
	end
	log('remove role fail, id = ' .. id .. ' not existed')
end
function km_notice(text)
	local notice = KM.UI.notice
	km_waitFrame(4)
	notice.text = text
	notice.show = true
	km_waitEvent('通知结束')
	notice.show = false
	km_waitFrame(4)
end
function km_mutliText(text)
	local multiText = KM.UI.multiText
	km_waitFrame(4)
	multiText.text = text
	multiText.show = true
	km_waitEvent('多行文本结束')
	multiText.show = false
	km_waitFrame(4)
end
function km_talk(pid, text)
	local role = KM.role[pid] or {}
	local talk = KM.UI.talk
	talk.head = role['头像'] or 0
	talk.name = role['名称'] or ''
	talk.text = text
	talk.show = true
	km_waitEvent('对话结束')
	talk.show = false
	km_waitFrame()
end
function km_table(tHead, tBody, title, quorum, sortKey)
	local tb = {
		show = true,
		x = 0,
		y = 0,
		w = 640,
		h = 480,
		rowHight = 31,
		rowShowNum = 1,
		rowNum = #tBody,
		top = 1,
		on = 0,
		sel = {},
		quorum = quorum or 0,
		title = title or '',
		sortKey = sortKey or 0,
		xoff = {},
		head = tHead,
		body = {},
		--ScrollBar
		sb = {
			show = false,
			hold = false,
			bw = 18,
			bh = 36,
			h = 480,
			v = 0,
			old = 0,
		},
	}
	tb.rowShowNum = math.floor(tb.h / tb.rowHight) - 1
	tb.h = tb.rowHight * (tb.rowShowNum + 1)
	tb.x = (CC.ScreenW - tb.w) / 2
	tb.y = (CC.ScreenH - tb.h) / 2
	for i, v in ipairs(tHead) do
		local t = {}
		if type(v) == 'table' then
			t.str = v.str or '属性'
			t.w = v.w or 64
			t.xoff = v.xoff or 0.5
			t.sortKey = v.sortKey or i
		else
			t.str = tostring(v)
			t.w = 64
			t.xoff = 0.5
			t.sortKey = i
		end
		tb.head[i] = t
	end
	for id, row in ipairs(tBody) do
		local t = { [0] = id }
		for i, v in ipairs(tHead) do
			t[i] = row[i]
		end
		tb.body[id] = t
	end
	if sortKey ~= 0 then
	end
	if tb.rowShowNum < tb.rowNum then
		local sb = tb.sb
		sb.h = tb.h - tb.rowHight
		sb.bh = sb.h * tb.rowShowNum / (tb.rowNum + 1)
		sb.bh = math.ceil(limitX(sb.bh, 36, sb.h * 0.75))
		sb.show = true
	end
	KM.UI.table = tb
	--confirm
	KM.UI.confirm.x = tb.x + tb.w / 2
	KM.UI.confirm.y = tb.y + tb.h
	if quorum > 0 then
		KM.UI.confirm.text = {'决定', '返回'}
	else
		KM.UI.confirm.text = {'关闭'}
	end
	KM.UI.confirm.show = true
end
function km_sortStable(tb, sortKey)
	table.sort(tb, function(a, b)
		local va, vb
		if sortKey >= 0 then
			va, vb = a[sortKey], b[sortKey]
		else
			va, vb = b[-sortKey], a[-sortKey]
		end
		if va == nil then
			return false
		else
			return va < vb
		end
	end)
end
function km_drawTable(tb, isActive)
	local x = tb.x
	local y = tb.y
	local sb = tb.sb
	LoadPicEnhance(73, x - 32, y - 8, tb.w + 64, tb.h + 16)
	LoadPicEnhance(74, x, y, tb.w)
	for i, v in ipairs(tb.head) do
		local str = v.str
		if MOUSE.CLICK(x, y, x + v.w, y + 30) then
			PlayWavE(0)
			if tb.sortKey == v.sortKey then
				tb.sortKey = -v.sortKey
			else
				tb.sortKey = v.sortKey
			end
			km_sortStable(tb.body, tb.sortKey)
		elseif MOUSE.IN(x, y, x + v.w, y + 30) then
			str = '[Yellow]' .. str
		end
		DrawStringEnhance(x + v.w * 0.5, y + 14, str, C_BLACK, CC.FontSize, 0.5, 0.5)
		x = x + v.w
	end
	x = tb.x
	local w = tb.w
	if sb.show then
		w = w - sb.bw - 4
	end
	local cur = 0
	if MOUSE.IN(x, y + tb.rowHight, x + w, y + tb.h) then
		cur = tb.top + math.floor((MOUSE.y - y) / tb.rowHight) - 1
		if cur <= tb.rowNum then
			if MOUSE.CLICK(x, y + tb.rowHight * (cur - tb.top + 1), x + w, y + tb.rowHight * (cur - tb.top + 2)) then
				local row = tb.body[cur]
				local isSel = false
				for i, v in ipairs(tb.sel) do
					if v == row[0] then
						isSel = true
						table.remove(tb.sel, i)
						PlayWavE(1)
						break
					end
				end
				if not isSel then
					if tb.quorum > 1 then
						if #tb.sel < tb.quorum then
							table.insert(tb.sel, row[0])
							PlayWavE(0)
						else
							PlayWavE(2)
						end
					elseif tb.quorum == 1 then
						tb.sel[1] = row[0]
						PlayWavE(0)
					else
						PlayWavE(0)
					end
				end
			end
		end
	end
	for i = 1, math.min(tb.rowShowNum, tb.rowNum - tb.top + 1) do
		y = y + tb.rowHight
		local idx = tb.top + i - 1
		local row = tb.body[idx]
		local isSel = false
		for ii, v in ipairs(tb.sel) do
			if v == row[0] then
				isSel = true
				break
			end
		end
		if idx == cur then
			if isSel then
				LoadPicEnhance(71, x, y - 5, w)
			else
				LoadPicEnhance(70, x, y - 5, w)
			end
		end
		LoadPicEnhance(72, x, y + 27, w)
		local x1 = x
		for j = 1, #row do
			local v = row[j]
			local str = tostring(v)
			if isSel then
				str = '[Red]' .. str
			end
			local colW = tb.head[j].w
			local xoff = tb.head[j].xoff
			DrawStringEnhance(x1 + colW * xoff, y + 16, str, M_White, CC.FontSizeM, xoff, 0.5)
			x1 = x1 + colW
		end
	end
	--ScrollBar
	if sb.show then
		x = x + w
		y = tb.y + tb.rowHight
		lib.FillColor(x + 6, y, x + sb.bw - 6, y + sb.h, M_Gray)
		local x1, y1 = x, y + sb.v * (sb.h - sb.bh)
		local x2, y2 = x1 + sb.bw, y1 + sb.bh
		local col = 0xd8d6ca
		if sb.hold then
			col = M_White
		elseif MOUSE.IN(x1, y1, x2, y2) then
			col = C_WHITE
		end
		if sb.hold then
			if MOUSE.status == 'HOLD' then
				sb.v = limitX(sb.old + (MOUSE.y - MOUSE.hy) / (sb.h - sb.bh), 0, 1)
				tb.top = 1 + math.floor((tb.rowNum - tb.rowShowNum) * sb.v + 0.5)
			else
				sb.hold = false
			end
		else
			if MOUSE.HOLD(x1, y1, x2, y2) then
				sb.old = sb.v
				sb.hold = true
			end
		end
		lib.FillColor(x1 - 1, y1 - 1, x2 + 1, y2 + 1, 0x5e5c57)
		lib.FillColor(x1, y1, x2, y2, col)
	end
end
function km_confirm()
	local ui = KM.UI
	ui.talk.show = true
	ui.confirm.x = CC.ScreenW2
	ui.confirm.y = CC.ScreenH - 81
	ui.confirm.text = {'是', '否'}
	ui.confirm.show = true
	km_waitEvent('确认结束')
	ui.confirm.show = false
	ui.talk.show = false
	km_waitFrame()
	return KM.event.selection
end
function km_alert(text)
	local alert = KM.UI.alert
	km_waitFrame(4)
	alert.text = text
	alert.show = true
	km_waitEvent('警告结束')
	alert.show = false
	km_waitFrame(4)
end
function km_select(str, x, y)
	x = x or CC.ScreenW2
	y = y or CC.ScreenH2
	local menu = KM.UI.menu
	menu.item = {}
	local maxlen = 0
	for s in string.gmatch(str, '[^\n]+') do
		table.insert(menu.item, {
			enable = true,
			text = s,
		})
		maxlen = math.max(maxlen, #s)
	end
	menu.itemNum = #menu.item
	menu.x = x
	menu.y = y
	menu.width = 288
	menu.height = 80 + 40 * menu.itemNum
	for k, v in ipairs(menu.item) do
		v.x = x
		v.y = y + 40 * (k - menu.itemNum / 2 - 0.5)
		v.x1 = v.x - 104
		v.y1 = v.y - 18
		v.x2 = v.x + 104
		v.y2 = v.y + 18
	end
	menu.show = true
	km_waitEvent('选择结束')
	menu.show = false
	km_waitFrame()
	return KM.event.selection
end
function km_showRoleStatus(pid)
	KM.UI.showRoleStatus = pid
	km_waitEvent('关闭人物详情')
	KM.UI.showRoleStatus = 0
end
--------------
function km_initUI()
	PicCacheIni()
	KM.UI = {
		mode = 0,	-- 0: auto mode, 1: manual mode, 2: battle mode
		frame = 0,
		frameT = 0,
		scene = {	-- 场景
			map = 0,
			showRole = false,
			role = {},	-- 人物卡片
		},
		notice = {	-- 居中显示的提示文本
			show = false,
			text = '',
		},
		multiText = {	-- 多行信息
			show = false,
			text = '',
		},
		talk = {	-- 剧情对话
			show = false,
			head = 0,
			name = '',
			text = '',
		},
		menu = {	-- 菜单
			show = false,
			x = 0,
			y = 0,
			item = {},
		},
		menu2 = {	-- 菜单 另一种风格
			show = false,
			x = 0,
			y = 0,
			width = 0,
			height = 0,
			item = {},
		},
		table = {	-- 多功能表格
			show = false,
		},
		confirm = {	-- 是/否 确认
			show = false,
			x = CC.ScreenW2,
			y = CC.ScreenH - 81,
			text = {},
		},
		alert = {
			show = false,
			text = '',
		},
		showRoleStatus = 0,
	}
end
function km_drawRoleCard(card, x, y, isActive)
	local w, h = CC.CardWidth, CC.CardHeight
	local x2, y2 = x + w, y + h
	--card background
	lib.PicLoadCache(4, card.bgpic * 2, x, y, 1, nil, nil, w, h);
	-- if card.ontime ~= 128 then
		-- lib.PicLoadCache(4, card.bgpic * 2, x, y, 1+2+8, math.abs(card.ontime - 128), nil, w, h);
	-- end
	--card head
	lib.PicLoadCache(2, card.head * 2 + 4000, x, y, 1, nil, nil, w, h);
	if card.ontime ~= 128 then
		lib.PicLoadCache(2, card.head * 2 + 4000, x, y, 1+2+8, math.abs(card.ontime - 128), nil, w, h);
	end
	--card border
	lib.PicLoadCache(4, card.border * 2, x, y, 1, nil, nil, w, h);
	--name
	DrawStringEnhance(x + w / 2, y + h - 16, card.name, C_BLACK, 20, 0.5, 0.5);
	if not card.enable then
		lib.Background(x, y, x2, y2, 128);
    end
	if not isActive then
		card.on = false
		card.ontime = 128
		return
	end
	x, y, x2, y2 = x + 4, y + 4, x2 - 4, y2 - 4
	if MOUSE.CLICK(x, y, x2, y2) then
		if card.enable then
			PlayWavE(0)
			KM.event.category = 1
			KM.event.name = '选择人物卡片'
			KM.event.pid = card.id
		else
			PlayWavE(2)
		end
	elseif MOUSE.IN(x, y, x2, y2) then
		card.on = true
	else
		card.on = false
	end
	if card.on then
		card.ontime = card.ontime + 4
		if card.ontime >= 256 then
			card.ontime = 0
		end
	else
		if card.ontime == 128 then
			
		elseif card.ontime >= 136 then
			card.ontime = card.ontime - 8
		elseif card.ontime <= 120 then
			card.ontime = card.ontime + 8
		else
			card.ontime = 128
		end
	end
end
function km_drawNotice(text, isActive)
	local x, y = CC.ScreenW2, CC.ScreenH2;
	-- DrawStringEnhance(x, y, text, M_White, CC.FontSize, 0.5);
	local dt, w, h = DrawStringEnhanceInit(text, M_White, CC.FontSize, 0.5, 0.5);
	w = w + 64
	h = h + 40
	LoadPicEnhance(4, x, y, w, h, true)
	DrawStringEnhanceSub(x, y, dt, CC.FontSize);
	if not isActive then
		return
	end
	if MOUSE.CLICK() then
		KM.event.name = '通知结束'
	end
end
function km_drawMutliText(text, isActive)
	local x, y = CC.ScreenW2, CC.ScreenH2;
	LoadPicEnhance(78, x, y, 640, 200, true)
	DrawStringEnhance(x - 264, y, text, M_White, CC.FontSize, 0, 0.5);
	if not isActive then
		return
	end
	if MOUSE.CLICK() then
		KM.event.name = '多行文本结束'
	end
end
function km_drawTalk(head, name, text, isActive)
	local mx, my = CC.ScreenW2 - 140, CC.ScreenH - 160
	if head > 0 then
		-- lib.PicLoadCache(2, head * 2, mx, CC.ScreenH2, 0)
		if KM.UI.scene.role[1] and KM.role[KM.UI.scene.role[1].id]['头像'] == head then
			lib.PicLoadCache(2, head * 2, CC.ScreenW2 + 96, CC.ScreenH2, 0)
		else
			lib.PicLoadCache(2, head * 2, CC.ScreenW2 - 96, CC.ScreenH2, 0)
		end
	end
	LoadPicEnhance(207, CC.ScreenW2 - 320, my, 640, 140);
	my = my + 32
	DrawStringEnhance(mx - CC.FontSize * 1.5, my, name, C_ORANGE, CC.FontSize, 1)
	DrawStringEnhance(mx - CC.FontSize * 1, my, text, M_White, CC.FontSize)
	if not isActive then
		return
	end
	if MOUSE.CLICK() then
		KM.event.name = '对话结束'
	end
end
function km_drawConfirm(isActive)
	local ui = KM.UI.confirm
	local x = ui.x
	local y = ui.y
	local n = #ui.text
	if n == 1 then
		lib.PicLoadCache(4, 10 * 2, x - 84, y, 1)
	elseif n == 2 then
		lib.PicLoadCache(4, 11 * 2, x - 108, y, 1)
	end
	y = y + 8
	x = x + 2 - 35 * n
	for i, v in ipairs(ui.text) do
		local pic = CC.ConfirmPic[v] or 27
		if MOUSE.CLICK(x, y, x + 66, y + 44) then
			lib.PicLoadCache(4, (pic + 2) * 2, x, y, 1)
			KM.event.name = '确认结束'
			KM.event.selection = i
		elseif MOUSE.HOLD(x, y, x + 66, y + 44) then
			lib.PicLoadCache(4, (pic + 2) * 2, x, y, 1)
		elseif MOUSE.IN(x, y, x + 66, y + 44) then
			lib.PicLoadCache(4, (pic + 1) * 2, x, y, 1)
		else
			lib.PicLoadCache(4, pic * 2, x, y, 1)
		end
		x = x + 70
	end
end
function km_drawAlert(text, isActive)
	local x, y = CC.ScreenW2, CC.ScreenH2;
	local dt, w, h = DrawStringEnhanceInit(text, M_White, CC.FontSize, 0.5, 0.5);
	w = w + 96
	h = h + 40
	LoadPicEnhance(202, x, y, w, h, true)
	DrawStringEnhanceSub(x, y, dt, CC.FontSize);
	if not isActive then
		return
	end
	if MOUSE.CLICK() then
		KM.event.name = '警告结束'
	end
end
function km_drawMenu(menu, isActive)
	-- local menu = KM.UI.menu
	LoadPicEnhance(3, menu.x, menu.y, menu.width, menu.height, true)
	for k, v in pairs(menu.item) do
		if not v.enable then
			lib.PicLoadCache(4, 41 * 2, v.x1, v.y1, 1);
		elseif menu.current == k then
			if menu.hold then
				lib.PicLoadCache(4, 40 * 2, v.x1, v.y1, 1);
			else
				lib.PicLoadCache(4, 39 * 2, v.x1, v.y1, 1);
			end
		else
			lib.PicLoadCache(4, 38 * 2, v.x1, v.y1, 1);
		end
		if menu.current == k and menu.hold then
			DrawStringEnhance(v.x + 1, v.y + 1, v.text, C_BLACK, CC.FontSize, 0.5, 0.5);
		else
			DrawStringEnhance(v.x, v.y, v.text, C_BLACK, CC.FontSize, 0.5, 0.5);
		end
	end
	menu.current = 0
	menu.hold = false
	if not isActive then
		return
	end
	for k, v in pairs(menu.item) do
		if v.enable then
			if MOUSE.CLICK(v.x1, v.y1, v.x2, v.y2) then
				PlayWavE(0)
				KM.event.name = '选择结束'
				KM.event.selection = k
			elseif MOUSE.HOLD(v.x1, v.y1, v.x2, v.y2) then
				menu.current = k
				menu.hold = true
			elseif MOUSE.IN(v.x1, v.y1, v.x2, v.y2) then
				menu.current = k
			end
		else
			if MOUSE.CLICK(v.x1, v.y1, v.x2, v.y2) then
				PlayWavE(2)
			end
		end
	end
end
function km_drawMenu2(menu, isActive)
	LoadPicEnhance(78, menu.x, menu.y, menu.width, menu.height)
	-- Glass(menu.x, menu.y, menu.x + menu.width, menu.y + menu.height, M_Black, 128)
	local x = menu.x + menu.width / 2
	local y = menu.y + 18
	local x1 = menu.x + CC.FontSize / 2
	local x2 = x1 + menu.width - CC.FontSize
	menu.current = 0
	for i = 1, #menu.item do
		local v = menu.item[i]
		if v.show then
			if isActive then
				if MOUSE.CLICK(x1, y - CC.FontSize / 2, x2, y + CC.FontSize / 2) then
					menu.current = i
					if v.enable then
						PlayWavE(0)
						KM.event.name = v.name or '选择结束'
						KM.event.selection = i
					else
						PlayWavE(2)
					end
				elseif MOUSE.IN(x1, y - CC.FontSize / 2, x2, y + CC.FontSize / 2) then
					menu.current = i
				end
			end
			if not v.enable then
				DrawStringEnhance(x, y, v.text, M_Gray, CC.FontSize - 2, 0.5, 0.5)
				lib.FillColor(x1, y + CC.FontSize / 2, x2, y + CC.FontSize / 2 + 1, M_Gray)
			elseif menu.current == i then
				DrawStringEnhance(x, y, v.text, M_Yellow, CC.FontSize, 0.5, 0.5)
				lib.FillColor(x1, y + CC.FontSize / 2, x2, y + CC.FontSize / 2 + 1, M_Yellow)
			else
				DrawStringEnhance(x, y, v.text, C_WHITE, CC.FontSize - 2, 0.5, 0.5)
				lib.FillColor(x1, y + CC.FontSize / 2, x2, y + CC.FontSize / 2 + 1, C_WHITE)
			end
			y = y + CC.FontSize * 1.5
		end
	end
end
function km_createMenu2(menu, x, y)
	x = x or CC.ScreenW2
	y = y or CC.ScreenH2
	local menu2 = KM.UI.menu2
	local width = 0
	local num = 0
	for i, v in ipairs(menu) do
		if v.show then
			num = num + 1
			width = math.max(width, #v.text)
		end
	end
	menu2.item = menu
	menu2.width = (width + 1) * CC.FontSize * 2 / 3
	menu2.height = 8 + CC.FontSize * num * 1.5
	menu2.x = x or CC.ScreenW2 - menu2.width / 2
	menu2.y = y or CC.ScreenH2 - menu2.height / 2
end
function km_drawRoleStatus(pid)
	local role = KM.role[pid]
	local x, y = 128, CC.ScreenH2 - 240
	LoadPicEnhance(73, x, y, 640, 480)
	x = x + 32
	y = y + 16
	--
	lib.PicLoadCache(4, 79 * 2, x, y, 1)
	DrawStringEnhance(x + 128, y + 6, '人物', M_White, CC.FontSize, 0.5)
	y = y + CC.FontSize + 16
	km_drawbar(x, y, 240, '武力', 0, 100, role['武力'], role['武力'])
	y = y + CC.FontSize + 8
	km_drawbar(x, y, 240, '统御', 0, 100, role['统御'], role['统御'])
	y = y + CC.FontSize + 8
	km_drawbar(x, y, 240, '智力', 0, 100, role['智力'], role['智力'])

	y = y + CC.FontSize * 2

	lib.PicLoadCache(4, 79 * 2, x, y, 1)
	DrawStringEnhance(x + 128, y + 6, '部队', M_White, CC.FontSize, 0.5)
	y = y + CC.FontSize + 16
	km_drawbar(x, y, 240, '兵力', 1, role.maxHP, role.HP, role.HP)
	y = y + CC.FontSize + 8
	km_drawbar(x, y, 240, '策略', 1, role.maxSP, role.SP, role.SP)
	y = y + CC.FontSize + 8
	km_drawbar(x, y, 240, '攻击', 0, 1200, role.atk, role.atk)
	y = y + CC.FontSize + 8
	km_drawbar(x, y, 240, '防御', 0, 1200, role.def, role.def)
	y = y + CC.FontSize + 8
	km_drawbar(x, y, 240, '精神', 0, 1200, role.mag, role.mag)
	y = y + CC.FontSize + 8
	km_drawbar(x, y, 240, '移动', 0, 9, role.mov, role.mov)
	y = y + CC.FontSize + 8
	km_drawbar(x, y, 240, '速度', 0, 15, role.spd, role.spd)
	y = y + CC.FontSize + 8
	km_drawbar(x, y, 240, '经验', 1, role.nextExp, role['经验'], role['经验'])
	y = y + CC.FontSize + 8
	--
	y = CC.ScreenH2 - 240 + 16
	x = x + 300
	lib.PicLoadCache(4, 79 * 2, x, y, 1)
	DrawStringEnhance(x + 128, y + 6, '装备', M_White, CC.FontSize, 0.5)

	
	y = 300
	lib.PicLoadCache(4, 79 * 2, x, y, 1)
	DrawStringEnhance(x + 128, y + 6, '技能', M_White, CC.FontSize, 0.5)

	x = x + 240
	y = 416
	lib.PicLoadCache(2, (role['头像']) * 2, x, y - 360, 1, nil, nil, 320)
	LoadPicEnhance(115, x, y, 288, 128);
	x = x + 8
	y = y + 8
	DrawStringEnhance(x + CC.FontSize * 2, y, '[B]' .. role['名称'] .. '', M_White, CC.FontSize, 0.5, 0)
	DrawStringEnhance(x + 140, y + 4, '[B]级', M_White, CC.FontSizeM, 1, 0)
	DrawStringEnhance(x + 120, y, '[B]' .. role['等级'], M_White, CC.FontSize, 1, 0)
	DrawStringEnhance(x + 152, y + CC.FontSize - CC.FontSizeM, '[B]' .. KM.unit[role['兵种']]['名称'], M_White, CC.FontSizeM, 0, 0)
	y = y + CC.FontSize
	--
	x = 128 + 320 - 32
	y = CC.ScreenH - 80
	lib.PicLoadCache(4, 10 * 2, x - 50, y - 8, 1)
	if MOUSE.CLICK(x, y, x + 64, y + 48) then
		lib.PicLoadCache(4, 20 * 2, x, y, 1)
		KM.event.name = '关闭人物详情'
		PlayWavE(0)
	elseif MOUSE.HOLD(x, y, x + 64, y + 48) then
		lib.PicLoadCache(4, 20 * 2, x, y, 1)
	elseif MOUSE.IN(x, y, x + 64, y + 48) then
		lib.PicLoadCache(4, 19 * 2, x, y, 1)
	else
		lib.PicLoadCache(4, 18 * 2, x, y, 1)
	end

end
function km_drawbar(x, y, w, str, flag, vMax, vOrigin, vActual)
	local x0 = x
	local x1 = x + w - CC.FontSizeS * 2.5
	local y0 = y + CC.FontSize
	local y1 = y0 + 5
	local c1 = RGB(187, 180, 182)
	local c2 = RGB(247, 242, 231)
	local splitNum = 4
	lib.Background(x0, y0, x0 + w, y0 + 7, 128)
	if vActual == nil then
		vActual = vOrigin
	end
	lib.SetClip(x0, y0, x0 + w, y1)
	lib.FillColor(x0, y0, x0 + w * vOrigin / vMax, y1, c2)
	if vActual > vOrigin then
		lib.FillColor(x0 + w * vOrigin / vMax, y0, x0 + w * vActual / vMax, y1, M_PaleGreen)
	elseif vActual < vOrigin then
		lib.FillColor(x0 + w * vActual / vMax, y0, x0 + w * vOrigin / vMax, y1, M_DarkRed)
	end
	lib.SetClip(0, 0, 0, 0)
	for i = 1, splitNum do
		lib.DrawRect(x0 + (i - 1) * w / splitNum, y1, x0 + i * w / splitNum - 2, y1, c1)
	end
	for i = 1, splitNum - 1 do
		lib.DrawRect(x0 + i * w / splitNum - 2, y0, x0 + i * w / splitNum - 2, y1, c1)
		lib.DrawRect(x0 + i * w / splitNum - 1, y0, x0 + i * w / splitNum - 1, y1, 0)
	end
	DrawStringEnhance(x0, y0, str, C_Name, CC.FontSizeM, 0, 1)
	DrawStringEnhance(x1, y0, '[B]' .. vActual, M_White, CC.FontSize, 1, 1)
	if flag > 0 then
		DrawStringEnhance(x1, y0, '/' .. vMax, M_White, CC.FontSizeS, 0, 1)
	end
end
function km_drawSceneUI()
	local role = KM.role[1] or {}
	local head = role['头像'] or 0
	local x, y = CC.ScreenW2, CC.ScreenH - 16
	lib.PicLoadCache(4, 6 * 2, x, y, 0);
	lib.PicLoadCache(2, (head + 6000) * 2, x - 350, y - 32);
	-- if gs.ontime~=128 then
	-- 	lib.PicLoadCache(2,(p["容貌"]+6000)*2,x,y,2+8,math.abs(gs.ontime-128));
	-- end
	-- x=x+128;y=y+18;
	-- DrawStringEnhance(x,y,chinese_year_month(),C_Name,24,0.5);
	-- x=x+120;
	-- DrawStringEnhance(x,y,JY.Str[9170+p["身份"]],C_Name,24,0.5);
	-- x=x+180;
	-- DrawStringEnhance(x,y,"资金",C_Name,24,1);
	-- DrawStringEnhance(x,y," ".."500",C_WHITE,24);
	-- x=x+180;
	-- DrawStringEnhance(x,y,"行动力",C_Name,24,1);
	-- DrawStringEnhance(x,y," "..JY.Base["行动力"],C_WHITE,24);
end
--------------
-- local dt, w, h = DrawStringEnhanceInit(str,C_BLACK,size);
-- DrawStringEnhanceSub(tx, ty-1, dt, size);
function creatCard(x, y, kind, id)
	local width, height=112, 156;
	local card={
				x1=x,y1=y,x2=x+width,y2=y+height,w=width,h=height,
				id=id,kind=kind,	--0 身份卡, 1 武将卡, 2 基本卡,
				pt=0,col=0,cid=0,	--点数/花色/卡片类型(手牌)
				pic=1300,bgpic=1061,fpic=1201,hpic=1111,txt="",
				hide=false,enable=true,on=false,sel=false,ontime=128,
				}
	-- if kind==0 then
	-- 	local str={[0]="[B]主[n]公","[B]忠[n]臣","[B]反[n]贼","[B]内[n]奸"};
	-- 	card.txt=str[id];
	-- elseif kind==1 then
	-- 	card.txt=SHA.Person[id]["名称"];
	-- 	card.pic=430+id;
	-- 	card.fpic=1202;
	-- elseif kind==2 then
	-- 	card.txt=SHA.Card[id]["名称"];
	-- 	card.pt=SHA.Card[id]["点数"];
	-- 	card.col=SHA.Card[id]["花色"];
	-- 	card.cid=SHA.Card[id]["类型"];
	-- 	if card.cid==21 then
	-- 		card.pic=1316;
	-- 	elseif card.cid==31 then
	-- 		card.pic=1315;
	-- 	elseif card.cid==501 then
	-- 		card.pic=1314;
	-- 	end
    -- end
    card.kind = 1
    card.txt = '诸葛亮'
    card.pic=430+id;
    card.fpic=1202;
	return card;
end
function drawCard(card, isActive)
	if card.on then
		card.ontime=card.ontime+4;
		if card.ontime>=256 then
			card.ontime=0;
		end
	else
		if card.ontime==128 then
			
		elseif card.ontime>=136 then
			card.ontime=card.ontime-8;
		elseif card.ontime<=120 then
			card.ontime=card.ontime+8;
		else
			card.ontime=128;
		end
	end
	local picsource=4;
	if card.kind==1 then
		picsource=2;
	end
	local y_off=0;
	if card.sel then
		-- y_off=-SHA.cardHeight/8;
	end
	if card.hide then
		--card background
		lib.PicLoadCache(4,card.hpic*2,card.x1,card.y1+y_off,1,nil,nil,card.w,card.h);
		if card.ontime~=128 then
			lib.PicLoadCache(4,card.hpic*2,card.x1,card.y1+y_off,1+2+8,math.abs(card.ontime-128),nil,card.w,card.h);
		end
		--card frame
		lib.PicLoadCache(4,7*2,card.x1-3,card.y1-3+y_off,1,nil,nil,card.w+6,card.h+6);
	else
		--card background
		lib.PicLoadCache(4,card.bgpic*2,card.x1,card.y1+y_off,1,nil,nil,card.w,card.h);
		if card.ontime~=128 then
			lib.PicLoadCache(4,card.bgpic*2,card.x1,card.y1+y_off,1+2+8,math.abs(card.ontime-128),nil,card.w,card.h);
		end
		--card pic
		lib.PicLoadCache(picsource,card.pic*2,card.x1,card.y1+y_off,1,nil,nil,card.w,card.h);
		if card.ontime~=128 then
			lib.PicLoadCache(picsource,card.pic*2,card.x1,card.y1+y_off,1+2+8,math.abs(card.ontime-128),nil,card.w,card.h);
		end
		--card frame
		lib.PicLoadCache(4,card.fpic*2,card.x1,card.y1+y_off,1,nil,nil,card.w,card.h);
		--txt
		if card.kind==0 then
			DrawStringEnhance((card.x1+card.x2)/2,(card.y1+card.y2)/2+y_off,card.txt,C_WHITE,48,0.5,0.5);
		elseif card.kind==1 then
			DrawStringEnhance(card.x1+16,card.y1+16+y_off,"[W]"..card.txt,C_BLACK,20,0.5,nil,20);
		elseif card.kind==2 then
			local t_col={[0]=C_BLACK,M_Red,C_BLACK,M_Red}
			lib.PicLoadCache(4,(1291+card.col)*2,card.x1+16,card.y1+16+y_off,0,nil,t_col[card.col],20);
			DrawStringEnhance(card.x1+16,card.y1+26+y_off,SHA.Str[card.pt],t_col[card.col],20,0.5);
			DrawStringEnhance(card.x1+16,card.y1+46+y_off,"[W]"..card.txt,C_BLACK,20,0.5,nil,20);
		end
	end
	if not card.enable then
		lib.Background(card.x1,card.y1+y_off,card.x2,card.y2+y_off,128);
    end
    -- event
	-- local y_off=0;
	if card.sel then
		-- y_off=-SHA.cardHeight/8;
	end
	if not isActive then
		return
	end
	if MOUSE.CLICK(card.x1,card.y1+y_off,card.x2,card.y2+y_off) then
		if card.enable then
			PlayWavE(0);
			card.sel=not card.sel;
			return 2;
		else
			PlayWavE(2);
			return 1;
		end
	elseif MOUSE.IN(card.x1,card.y1+y_off,card.x2,card.y2+y_off) then
		card.on=true;
		return 1;
	else
		card.on=false;
		return 0;
	end
end
------ Game Data ------
function trim(str, kind)
    kind = kind or 0
    -- 0 both, 1 st only, 2 ed only
    local len = #str
    local st = 1
    local ed = len
    if kind ~= 2 then
        st = string.find(str, '%S') or st
    end
    if kind ~= 1 then
        ed = string.find(str, '%s*$') - 1
    end
    -- print(str, st, ed)
    if st > 1 or ed < len then
        return string.sub(str, st, ed)
    else
        return str
    end
end
function km_loadTXT(file)
	local t = {}
    local typedef = {}
    local fp = io.open(file, 'r')
	if fp == nil then
		log(file .. ' is not existed.')
		return
	end
	local num, heads = Split(fp:read(), '\t')
	-- for w in string.gmatch(fp:read(), '[^\t]*[\t$]') do
	for i, v in ipairs(heads) do
        local kind, name
        local str = trim(v)
        if #str > 0 then
            local idx = string.find(str, '_')
            if idx then
                kind = string.sub(str, 1, idx - 1)
                name = string.sub(str, idx + 1)
                if #kind == 0 then
                    kind = 'auto'
                end
                if #name == 0 then
                    name = nil
                end
            else
                kind = 'auto'
                name = str
            end
        end
        table.insert(typedef, {
            kind = kind,
            name = name,
        })
	end
    while true do
        local line = fp:read()
        if line == nil then
            break
        end
        local idx = 1
        local maxIdx = #typedef
        local doc = {}
		local num, cells = Split(line, '\t')
		-- for w in string.gmatch(line, '[^\t]*[\t$]') do
		for i, v in ipairs(cells) do
            if i > maxIdx then
                break
            end
            local str = trim(v)
            local kind = typedef[i].kind
            local name = typedef[i].name
            if name ~= nil then
                local v
                if kind == 'int' then
                    v = math.floor(tonumber(str) or 0)
                elseif kind == 'float' then
                    v = tonumber(str) or 0
                elseif kind == 'string' then
					v = str
				elseif kind == 'array' then
					v = {}
					local num, t = Split(str, ',')
					for ii, vv in ipairs(t) do
						local val = tonumber(trim(vv))
						if val ~= nil then
							table.insert(v, val)
						end
					end
                else
                    v = tonumber(str) or str
                end
                doc[name] = v
            end
        end
        local docId = doc['编号'] or doc.id or (#t + 1)
        -- print(docId, doc)
        t[docId] = doc
    end
	fp:close()
	return t
end
function km_initStaticData()
	CC.Font = {}
	local font = km_loadTXT(CC.FontTxtFilename)
	for i, v in ipairs(font) do
		CC.Font[v['文字']] = v['贴图']
	end
	CC.Font[' '] = 13624
	KM.role = km_loadTXT(CC.RoleTxtFilename)
	KM.trick = km_loadTXT(CC.TrickTxtFilename)
	KM.city = km_loadTXT(CC.CityTxtFilename)
	KM.unit = km_loadTXT(CC.UnitTxtFilename)
	KM.terrain = km_loadTXT(CC.TerrainTxtFilename)
	KM.skin = km_loadTXT(CC.UnitSkinTxtFilename)
	do
		for k, v in pairs(KM.unit) do
			local t = {}
			for kk, vv in pairs(KM.terrain) do
				t[kk] = {
					cost = vv['移动消耗'],
					def = vv['防御'],
				}
			end
			v.terrain = t
		end
		local unit_terrain = km_loadTXT(CC.UnitTerrainTxtFilename)
		for k, v in pairs(unit_terrain) do
			local tid = v['地形']
			local cost = v['移动消耗']
			local def = v['防御']
			if tid > 0 then
				for i, uid in ipairs(v['兵种']) do
					local unit = KM.unit[uid]
					if unit then
						if cost > 0 then
							unit.terrain[tid].cost = cost
						end
						if def > 0 then
							unit.terrain[tid].def = def
						end
					end
				end
			end
		end
	end
end