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
	local msg = ''
	for k, v in ipairs({...}) do
		msg = msg .. '\t' ..tostring(v)
	end
	lib.Debug(msg)
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
	if ui.frameT >= 63 then
		ui.frameT = 0
	else
		ui.frameT = ui.frameT + 1
	end
	ui.frame = math.floor(ui.frameT / 16)
	local isGlobalActive = not( ui.notice.show or ui.multiText.show or ui.talk.show or ui.menu.show or ui.menu2.show or ui.confirm.show or ui.alert.show )
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
function km_confirm()
	local ui = KM.UI
	ui.talk.show = true
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
		confirm = {	-- 是/否 确认
			show = false,
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
	local x = CC.ScreenW2 - 108
	local y = CC.ScreenH - 81
	lib.PicLoadCache(4, 11 * 2, CC.ScreenW2 - 108, y, 1)
	y = y + 8
	x = x + 40
	local pic = 12
	for i = 0, 1 do
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
		pic = 15
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
				PlayWavE(1)
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
						PlayWavE(1)
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
	menu2.width = (width + 1) * CC.FontSize
	menu2.height = 8 + CC.FontSize * num * 1.5
	menu2.x = x or CC.ScreenW2 - menu2.width / 2
	menu2.y = y or CC.ScreenH2 - menu2.height / 2
end
function km_drawRoleStatus(pid)
	local function drawbar(x, y, v, max_v)
		local w = 60
		max_v = max_v or 100
		max_v = max_v / 4
		local c1 = RGB(187, 180, 182)
		local c2 = RGB(247, 242, 231)
		lib.Background(x, y, x + w * 4, y + 7, 128)
		lib.DrawRect(x, y + 5, x + w - 2, y + 5, c1)
		lib.DrawRect(x + w, y + 5, x + w * 2 - 2, y + 5, c1)
		lib.DrawRect(x + w * 2, y + 5, x + w * 3 - 2, y + 5, c1)
		lib.DrawRect(x + w * 3, y + 5, x + w * 4 - 2, y + 5, c1)
		
		lib.DrawRect(x + w - 2, y, x + w - 2, y + 4, c1)
		lib.DrawRect(x + w * 2 - 2, y, x + w * 2 - 2, y + 4, c1)
		lib.DrawRect(x + w * 3 - 2, y, x + w * 3 - 2, y + 4, c1)
		for i = 0, 3 do
			if v - max_v * i > 0 then
				lib.FillColor(x + w * i, y, x + w * i + math.floor((w - 2) * limitX((v - max_v * i) / max_v, 0, 1)), y + 5, c2);
			end
		end
	end
	local role = KM.role[pid]
	local x, y = 128, 64
	LoadPicEnhance(73, x, y, 640, 480)
	x = x + 32
	y = y + 32
	--
	lib.PicLoadCache(4, 79 * 2, x, y, 1)
	DrawStringEnhance(x + 128, y + 6, '属性', M_White, CC.FontSize, 0.5)
	y = y + CC.FontSize + 16
	DrawStringEnhance(x, y, string.format('兵力[B][w]%12d', role.HP), C_Name, CC.FontSize, 0, 0)
	DrawStringEnhance(x + CC.FontSize * 8, y + 8, string.format('/%d', role.maxHP), M_White, CC.FontSizeS, 0, 0)
	y = y + CC.FontSize
	drawbar(x, y, role.HP, math.max(role.maxHP, 3000))
	y = y + 8
	DrawStringEnhance(x, y, string.format('策略[B][w]%12d', role.SP), C_Name, CC.FontSize, 0, 0)
	DrawStringEnhance(x + CC.FontSize * 8, y + 8, string.format('/%d', role.maxSP), M_White, CC.FontSizeS, 0, 0)
	y = y + CC.FontSize
	drawbar(x, y, role.SP, math.max(role.maxSP, 100))
	y = y + 8
	DrawStringEnhance(x, y, string.format("攻击[B][w]%12d", role.atk), C_Name, CC.FontSize)
	y = y + CC.FontSize
	drawbar(x, y, role.atk, 1200)
	y = y + 8
	DrawStringEnhance(x, y, string.format("防御[B][w]%12d", role.def), C_Name, CC.FontSize)
	y = y + CC.FontSize
	drawbar(x, y, role.def, 1200)
	y = y + 8
	DrawStringEnhance(x, y, string.format("精神[B][w]%12d", role.mag), C_Name, CC.FontSize)
	y = y + CC.FontSize
	drawbar(x, y, role.mag, 1200)
	y = y + 8
	DrawStringEnhance(x, y, string.format("移动[B][w]%12d", role.mov), C_Name, CC.FontSize)
	y = y + CC.FontSize
	drawbar(x, y, role.mov, 9)
	y = y + 8
	DrawStringEnhance(x, y, string.format("速度[B][w]%12d", role.spd), C_Name, CC.FontSize)
	y = y + CC.FontSize
	drawbar(x, y, role.spd, 15)
	y = y + 8
	DrawStringEnhance(x, y, string.format('经验[B][w]%12d', role['经验']), C_Name, CC.FontSize, 0, 0)
	DrawStringEnhance(x + CC.FontSize * 8, y + 8, string.format('/%d', role.nextExp), M_White, CC.FontSizeS, 0, 0)
	y = y + CC.FontSize
	drawbar(x, y, role['经验'], role.nextExp)
	y = y + 8
	--
	y = 96
	x = x + 300
	lib.PicLoadCache(4, 79 * 2, x, y, 1)
	DrawStringEnhance(x + 128, y + 6, '技能', M_White, CC.FontSize, 0.5)

	
	y = 300
	lib.PicLoadCache(4, 79 * 2, x, y, 1)
	DrawStringEnhance(x + 128, y + 6, '装备', M_White, CC.FontSize, 0.5)

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
	for i, v in ipairs({"武力", "统御", "智力"}) do
		DrawStringEnhance(x, y, string.format("%s[B][w]%12d", v, role[v]), C_Name, CC.FontSizeM)
		y = y + CC.FontSizeM
		drawbar(x, y, role[v])
		y = y + 8
	end


	--
	x = 128 + 320 - 32
	y = CC.ScreenH - 80
	lib.PicLoadCache(4, 10 * 2, x - 50, y - 8, 1)
	if MOUSE.CLICK(x, y, x + 64, y + 48) then
		lib.PicLoadCache(4, 20 * 2, x, y, 1)
		KM.event.name = '关闭人物详情'
	elseif MOUSE.HOLD(x, y, x + 64, y + 48) then
		lib.PicLoadCache(4, 20 * 2, x, y, 1)
	elseif MOUSE.IN(x, y, x + 64, y + 48) then
		lib.PicLoadCache(4, 19 * 2, x, y, 1)
	else
		lib.PicLoadCache(4, 18 * 2, x, y, 1)
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
                elseif kind == 'string' or kind == 'array' then
                    v = str
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
	KM.role = km_loadTXT(CC.RoleTxtFilename)
	KM.city = km_loadTXT(CC.CityTxtFilename)
	KM.unit = km_loadTXT(CC.UnitTxtFilename)
	KM.terrain = km_loadTXT(CC.TerrainTxtFilename)
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
				local num, units = Split(v['兵种'], ',')
				for i, vv in ipairs(units) do
					local uid = tonumber(trim(vv))
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