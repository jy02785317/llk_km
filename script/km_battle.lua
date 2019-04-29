-- view
function km_drawWar(isActive)
	local war = KM.war
	local x = math.floor((MOUSE.x - 0) / 48)
	local y = math.floor((MOUSE.y - 0) / 48)
	local gx, gy = war.gridX + x, war.gridY + y
	local curGrid = km_getGrid(gx, gy)
	--tile map
	if #KM.war.tileMap > 0 then
		km_drawTileMap()
	end
	-- atk area
	if isActive and war.isActive and (not war.isShowSelectArea) and (not war.isShowMoveArea) then
		if curGrid.pid and curGrid.pid > 0 then
			local area = km_calRoleAtkArea(curGrid.pid)
			for i, v in ipairs(area) do
				local sx, sy = km_gridToScreen(v.x, v.y)
				lib.PicLoadCache(4, 191 * 2, sx, sy, 1);
			end
		end
	end
	--move area
	if war.isShowMoveArea then
		for row = math.max(war.gridY, 1), math.min(war.gridY + war.screenH - 1, war.gridH) do
			for col = math.max(war.gridX, 1), math.min(war.gridX + war.screenW - 1, war.gridW) do
				local grid = km_getGrid(col, row)
				if grid then
					if grid.s == 2 then	-- move range
						local sx, sy = km_gridToScreen(col, row)
						-- lib.Background(x, y, x + 48, y + 48, 128, M_Blue)
						-- lib.Background(x, y, x + 48, y + 48, 128 + (0.5 - (col + row) % 2) * 2 * (KM.UI.frameT - 32), M_Blue)
						lib.Background(sx, sy, sx + 48, sy + 48, 160 + 32 * math.sin(KM.UI.frameT * 2 * math.pi / 63), M_DeepSkyBlue)
					end
				end
			end
		end
		-- move path
		local role = KM.role[war.pid]
		if isActive and curGrid and curGrid.s == 2 and role.isEnemy == false and (role['阵营'] == 1 or role['阵营'] == 7) then
			local grid = curGrid
			local x1, y1 = km_gridToScreen(grid.x, grid.y)
			grid = grid.parent
			while grid do
				local x2, y2 = km_gridToScreen(grid.x, grid.y)
				lib.FillColor(math.min(x1, x2) + 12, math.min(y1, y2) + 12, math.max(x1, x2) + 36, math.max(y1, y2) + 36, M_Wheat)
				grid = grid.parent
				x1, y1 = x2, y2
			end
		end
	end
	-- select area
	if war.isShowSelectArea then
		local x1, y1 = war.gridX, war.gridY
		local x2, y2 = war.gridX + war.screenW - 1, war.gridY + war.screenH - 1
		for i, v in ipairs(war.selectArea) do
			if km_isXYInArea(v.x, v.y, x1, y1, x2, y2) then
				local sx, sy = km_gridToScreen(v.x, v.y)
				lib.Background(sx, sy, sx + 48, sy + 48, 160 + 32 * math.sin(KM.UI.frameT * 2 * math.pi / 63), M_Red)
			end
		end
	end
	--box
	if isActive and war.isActive then
		lib.PicLoadCache(4, 190 * 2, 48 * x, 48 * y, 1);
	end
	--unit
	do
		local x1, y1 = war.gridX - 0.5, war.gridY - 0.5
		local x2, y2 = war.gridX + war.screenW - 0.5, war.gridY + war.screenH - 0.5
		for i, v in ipairs(war.role) do
			local role = KM.role[v]
			if role.status == 1 and km_isXYInArea(role.x, role.y, x1, y1, x2, y2) then
				km_drawUnit(v)
			end
		end
	end
	-- floating text
	do
		for i = #war.floatingText, 1, -1 do
			local v = war.floatingText[i]
			DrawStringEnhance(v.x, v.y, v.text, M_White, v.size, 0.5, 0.5, nil, v.alpha)
			if v.delay > 0 then
				v.delay = v.delay - 1
			elseif v.dur > 0 then
				v.dur = v.dur - 1
				v.size = v.size + v.dsize or 0
				v.alpha = v.alpha + v.dalpha or 0
				v.x = v.x + v.dx or 0
				v.y = v.y + v.dy or 0
			else
				table.remove(war.floatingText, i)
			end
		end
	end
	-- unit info
	if isActive and war.isActive then
		if curGrid and curGrid.pid > 0 then
			km_drawUnitBrief(curGrid.pid)
		elseif war.pid and war.pid > 0 then
			km_drawUnitBrief(war.pid, true)
		end
	end
	if isActive and war.isActive then
		-- if war.gridX > 1 and x == 0 then
		-- 	lib.PicLoadCache(4, 246 * 2, MOUSE.x, MOUSE.y);
		-- 	if MOUSE.HOLD(48 * x, 48 * y, 48 * (x + 1), 48 * (y + 1)) then
		-- 		war.gridX = war.gridX - 1
		-- 	end
		-- elseif war.gridX < war.gridW - war.screenW + 1 and x == war.screenW - 1 then
		-- 	lib.PicLoadCache(4, 242 * 2, MOUSE.x, MOUSE.y);
		-- 	if MOUSE.HOLD(48 * x, 48 * y, 48 * (x + 1), 48 * (y + 1)) then
		-- 		war.gridX = war.gridX + 1
		-- 	end
		-- -- elseif war.gridY > 1 and y == 0 then
		-- -- 	lib.PicLoadCache(4, 248 * 2, MOUSE.x, MOUSE.y);
		-- -- 		if MOUSE.HOLD(48 * x, 48 * y, 48 * (x + 1), 48 * (y + 1)) then
		-- -- 			war.gridY = war.gridY - 1
		-- -- 		end
		-- elseif war.gridY > 1 and y == 0 then
		-- 	lib.PicLoadCache(4, 248 * 2, MOUSE.x, MOUSE.y);
		-- 		if MOUSE.IN(48 * x, 48 * y, 48 * (x + 1), 48 * (y + 1)) then
		-- 			war.gridY = war.gridY - 1
		-- 		end
		-- -- elseif war.gridY < war.gridH - war.screenH + 1 and y == war.screenH - 1 then
		-- -- 	lib.PicLoadCache(4, 244 * 2, MOUSE.x, MOUSE.y);
		-- -- 	if MOUSE.HOLD(48 * x, 48 * y, 48 * (x + 1), 48 * (y + 1)) then
		-- -- 		war.gridY = war.gridY + 1
		-- -- 	end
		-- elseif war.gridY < war.gridH - war.screenH + 1 and y == war.screenH - 1 then
		-- 	lib.PicLoadCache(4, 244 * 2, MOUSE.x, MOUSE.y);
		-- 	if MOUSE.IN(48 * x, 48 * y, 48 * (x + 1), 48 * (y + 1)) then
		-- 		war.gridY = war.gridY + 1
		-- 	end
		-- else
		-- 	if curGrid and MOUSE.CLICK(48 * x, 48 * y, 48 * (x + 1), 48 * (y + 1)) then
		-- 		if war.isShowMoveArea then
		-- 			KM.event.category = 3
		-- 			KM.event.name = '选择移动目标'
		-- 			KM.event.grid = curGrid
		-- 		elseif curGrid.pid > 0 then
		-- 			KM.event.category = 3
		-- 			KM.event.name = '选择部队'
		-- 			KM.event.pid = curGrid.pid
		-- 		end
		-- 	end
		-- end
		if curGrid and MOUSE.CLICK(48 * x, 48 * y, 48 * (x + 1), 48 * (y + 1)) then
			-- if war.opStep == 0 then
			-- 	KM.event.name = '选择部队'
			-- 	KM.event.pid = curGrid.pid
			-- elseif war.opStep == 1 then
			-- 	KM.event.name = '选择移动目标'
			-- 	KM.event.grid = curGrid
			-- elseif war.opStep == 2 then
			-- 	KM.event.name = '选择作用目标'
			-- 	KM.event.grid = curGrid
			-- end
			KM.event.name = '选择地图网格'
			KM.event.grid = curGrid

			-- if war.isShowMoveArea then
			-- 	KM.event.category = 3
			-- 	KM.event.name = '选择移动目标'
			-- 	KM.event.grid = curGrid
			-- elseif war.isShowSelectArea then
			-- 	KM.event.category = 3
			-- 	KM.event.name = '选择作用目标'
			-- 	KM.event.grid = curGrid
			-- elseif curGrid.pid > 0 then
			-- 	KM.event.category = 3
			-- 	KM.event.name = '选择部队'
			-- 	KM.event.pid = curGrid.pid
			-- end
		elseif MOUSE.HOLD(0, 0, CC.ScreenW, CC.ScreenH) then
			KM.event.name = '地图拖动'
			KM.event.x = MOUSE.x
			KM.event.y = MOUSE.y
			-- log('地图拖动', KM.event.x, KM.event.y)
		else
			KM.event.dx = 0
			KM.event.dy = 0
			if war.gridX > 1 and MOUSE.x < 48 then
				KM.event.name = '地图卷动'
				KM.event.dx = -1
			elseif war.gridX < war.gridW - war.screenW + 1 and MOUSE.x > CC.ScreenW - 48 then
				KM.event.name = '地图卷动'
				KM.event.dx = 1
			end
			if war.gridY > 1 and MOUSE.y < 48 then
				KM.event.name = '地图卷动'
				KM.event.dy = -1
			elseif war.gridY < war.gridH - war.screenH + 1 and MOUSE.y > CC.ScreenH - 48 then
				KM.event.name = '地图卷动'
				KM.event.dy = 1
			end
		end
	end
	if true then
		-- DrawStringEnhance(4, 4, '[B]grid W, H = ' .. war.gridW .. ', ' .. war.gridH, M_White, CC.FontSize, 0, 0)
		-- DrawStringEnhance(4, 34, '[B]grid X, Y = ' .. war.gridX .. ', ' .. war.gridY, M_White, CC.FontSize, 0, 0)
		-- DrawStringEnhance(4, 64, '[B]cur X, Y = ' .. x .. ', ' .. y, M_White, CC.FontSize, 0, 0)
		DrawStringEnhance(4, 4, '[B]mouse x, y = ' .. MOUSE.x .. ', ' .. MOUSE.y, M_White, CC.FontSize, 0, 0)
		DrawStringEnhance(4, 34, '[B]mouse dx, dy = ' .. MOUSE.hx .. ', ' .. MOUSE.hy, M_White, CC.FontSize, 0, 0)
		-- DrawStringEnhance(4, 64, '[B]cur X, Y = ' .. x .. ', ' .. y, M_White, CC.FontSize, 0, 0)
		-- DrawStringEnhance(4, 64, '[B]num of roleCard = ' .. #ui.scene.role, M_White, CC.FontSize, 0, 0)
	end
end
function km_drawTileMap(x1, y1, x2, y2)
	local war = KM.war
	x1 = x1 or (war.gridX * 3 - 2)
	y1 = y1 or (war.gridY * 3 - 2)
	x2 = x2 or (x1 + war.screenW * 3 - 1)
	y2 = y2 or (y1 + war.screenH * 3 - 1)
	local x0, y0 = 0, 0
	if x1 < 1 then
		x0 = 16 * (1 - x1)
	end
	if y1 < 1 then
		y0 = 16 * (1 - y1)
	end
	local tile = war.tileMap
	local x, y = x0, y0
	y1 = math.max(y1, 1)
	y2 = math.min(y2, war.tileH)
	x1 = math.max(x1, 1)
	x2 = math.min(x2, war.tileW)
	for row = y1, y2 do
		x = x0
		local idx = war.tileW * (row - 1) 
		for col = x1, x2 do
			local pic = tile[idx + col] or 0
			if pic > 0 then
				lib.PicLoadCache(0, pic * 2, x, y, 1);
			end
			x = x + 16
		end
		y = y + 16
	end
	-- km_drawTileMapMini(0, 0, 4)
end
function km_drawTileMapMini(x, y, size)
	local war = KM.war
	local tile = war.tileMap
	for i, pic in ipairs(tile) do
		if pic > 0 then
			lib.PicLoadCache(0, pic * 2, x + (i - 1) % war.tileW * size, y + math.floor((i - 1) / war.tileW) * size, 1, nil, nil, size, size);
		end
	end
end
function km_drawUnit(pid, isActive)
	local role = KM.role[pid]
	if role == nil then
		return
	end
	local x, y = km_gridToScreen(role.x, role.y)
	x, y = x + 24, y + 24
	local d = 1
	if role.d == 1 then
		d = 2
	elseif role.d == 2 then
		d = 4
	elseif role.d == 3 then
		d = 1
	else
		d = 3
	end
	local pic = role.pic or 0
	local frame = role.frame or KM.UI.frame
	if role.anim == 0 then	-- 静止
		pic = pic + 16 + (d - 1)
	elseif role.anim == 1 then	-- 移动 / 正常
		pic = pic + 4 * (d - 1) + frame % 2
	elseif role.anim == 2 then	-- 攻击
		pic = pic + 30 + 4 * (d - 1) + frame
	elseif role.anim == 3 then	-- 防御
		pic = pic + 22 + (d - 1)
	elseif role.anim == 4 then	-- 被攻击
		pic = pic + 26 + (d - 1) % 2
	elseif role.anim == 5 then	-- 喘气
		pic = pic + 20 + frame % 2
	elseif role.anim == 6 then	-- 升级
		pic = pic + 28
	elseif role.anim == 7 then	-- 混乱
		if role.isEnemy then
			pic = 5012
		elseif role['阵营'] == 1 or role['阵营'] == 7 then
			pic = 5010
		else
			pic = 5014
		end
	end
	lib.PicLoadCache(1, pic * 2, x, y)
	if role.highlight > 0 then
		lib.PicLoadCache(1, pic * 2, x, y, 2+8, role.highlight)
	end
	if false then
		lib.PicLoadCache(4, 260 * 2, x, y - 32, 0, nil, nil, 64)
		lib.PicLoadCache(2, (role['头像'] + 6000) * 2, x - 20, y - 32, 0, nil, nil, 24)
		DrawStringEnhance(x + 8, y - 33, '[B]' .. tostring(role.HP), M_White, CC.FontSizeS, 0.5, 0.5)
	end
	if not isActive then
		return
	end
end
function km_drawUnitBrief(pid, isActive)
	local role = KM.role[pid]
	if role == nil then
		return
	end
	local uid = role['兵种']
	local x, y = 8, CC.ScreenH - 128
	if role.x - KM.war.gridX < KM.war.screenW / 2 then
		x = CC.ScreenW - 288 - 8
		lib.PicLoadCache(2, (role['头像2']) * 2, x + 108 - 32, y - 192, 1, nil, nil, 180, 256);
	else
		lib.PicLoadCache(2, (role['头像2']) * 2, x + 32, y - 192, 1, nil, nil, 180, 256);
	end
	LoadPicEnhance(115, x, y, 288, 128);
	x = x + 8
	y = y + 8
	DrawStringEnhance(x + CC.FontSize * 2, y, '[B]' .. role['名称'] .. '', M_White, CC.FontSize, 0.5, 0)
	DrawStringEnhance(x + 140, y + 4, '[B]级', M_White, CC.FontSizeM, 1, 0)
	DrawStringEnhance(x + 120, y, '[B]' .. role['等级'], M_White, CC.FontSize, 1, 0)
	DrawStringEnhance(x + 152, y + CC.FontSize - CC.FontSizeM, '[B]' .. KM.unit[uid]['名称'], M_White, CC.FontSizeM, 0, 0)
	-- if role.isEnemy then
	-- 	DrawStringEnhance(x + 152, y + CC.FontSize - CC.FontSizeM, '[Red]敌军', M_White, CC.FontSizeM, 0, 0)
	-- elseif role['阵营'] == 1 or role['阵营'] == 7 then
	-- 	DrawStringEnhance(x + 152, y + CC.FontSize - CC.FontSizeM, string.format('[B]经验 %3d', 108), M_White, CC.FontSizeM, 0, 0)
	-- 	DrawStringEnhance(x + 152 + CC.FontSizeM * 4, y + CC.FontSize - CC.FontSizeS, string.format('[B]/%d', 120), M_White, CC.FontSizeS, 0, 0)
	-- else
	-- 	DrawStringEnhance(x + 152, y + CC.FontSize - CC.FontSizeM, '[Orange]友军', M_White, CC.FontSizeM, 0, 0)
	-- end
	y = y + CC.FontSize + 4
	lib.Background(x, y + CC.FontSizeM, x + 140, y + CC.FontSizeM + 12, 128);
	lib.PicLoadCache(4, 216 * 2, x, y + CC.FontSizeM, 1, nil, nil, math.floor(140 * role.HP / role.maxHP), 12);
	DrawStringEnhance(x, y, string.format('兵力[B]%6d', role.HP), M_White, CC.FontSizeM, 0, 0)
	DrawStringEnhance(x + CC.FontSizeM * 5, y + 4, string.format('/%d', role.maxHP), M_White, CC.FontSizeS, 0, 0)
	x = x + 152
	lib.Background(x, y + CC.FontSizeM, x + 112, y + CC.FontSizeM + 12, 128);
	lib.PicLoadCache(4, 216 * 2, x, y + CC.FontSizeM, 1, nil, nil, 118 * math.floor(role.SP / role.maxSP), 12);
	DrawStringEnhance(x, y, string.format('策略[B]%4d', role.SP), M_White, CC.FontSizeM, 0, 0)
	DrawStringEnhance(x + CC.FontSizeM * 4, y + 4, string.format('/%d', role.maxSP), M_White, CC.FontSizeS, 0, 0)
	x = x - 152
	y = y + CC.FontSizeM + 12 + 4
	DrawStringEnhance(x + CC.FontSizeM * 9, y + CC.FontSizeM + 4 + 2, string.format('/%d', role.nextExp), M_White, CC.FontSizeS, 0, 0)
	DrawStringEnhance(x, y, "攻击      防御      移动[n]精神      经验", M_White, CC.FontSizeM, 0, 0)
	DrawStringEnhance(x + CC.FontSizeM * 2.5, y, string.format("[B]%-10d%-10d%d[n]%-10d%3d", role.atk, role.def, role.mov, role.mag, role['经验']), M_White, CC.FontSizeM, 0, 0)
	if not isActive then
		return
	end
	x = x + 220
	y = y + CC.FontSizeM
	if MOUSE.CLICK(x, y, x + 48, y + 28) then
		lib.PicLoadCache(4, 81 * 2, x, y, 1)
		PlayWavE(0)
		KM.event.name = '显示人物详情'
	elseif MOUSE.IN(x, y, x + 48, y + 28) then
		lib.PicLoadCache(4, 81 * 2, x, y, 1)
	else
		lib.PicLoadCache(4, 80 * 2, x, y, 1)
	end
	DrawStringEnhance(x + 24, y + 14, "详情", M_White, CC.FontSizeM, 0.5, 0.5)
	-- if MOUSE.CLICK()
	-- x = x + 204
	-- lib.PicLoadCache(4, 87 * 2, x, y, 1, nil, nil, 88, 60);
	-- DrawStringEnhance(x, y, '[B]经验', M_White, CC.FontSizeS, 0, 0)
	-- DrawStringEnhance(x + 64, y + 52, string.format('[B]/%3d', 120), M_White, CC.FontSizeS, 1, 1)
	-- DrawStringEnhance(x + 30, y + 25, string.format('[B]%3d', 108), M_White, CC.FontSize, 0.5, 0.5)
	-- DrawStringEnhance(x + 2, y + 2, string.format('[B]经验[n] [n]    /%3d', 140), M_White, CC.FontSizeS, 0, 0)
	-- DrawStringEnhance(x + 32, y + 24, '[B]' .. 108, M_White, CC.FontSize, 0.5, 0.5)
	-- DrawStringEnhance(x, y, string.format('[B]策略%4d', 500), M_White, CC.FontSizeM, 0, 0)
	-- DrawStringEnhance(x + CC.FontSizeM * 5, y + 4, string.format('[B]/%d', 800), M_White, CC.FontSizeS, 0, 0)
	-- DrawStringEnhance(x, y, '[B]' .. '兵力[n]策略', M_White, FontSizeS, 0, 0)
	-- x = x + FontSizeS * 2 + 8
	-- lib.Background(x, y, x + 128, y + 16, 128);
	-- lib.PicLoadCache(4, 216 * 2, x, y, 1, nil, nil, 100, 16);
	-- DrawStringEnhance(x + 54, y, '[B]500/500', M_White, FontSizeS, 0.5, 0)
	-- y = y + FontSizeS + 4
	-- lib.Background(x, y, x + 128, y + 16, 128);
	-- lib.PicLoadCache(4, 216 * 2, x, y, 1, nil, nil, 100, 16);
	-- DrawStringEnhance(x + 54, y, '[B]500/500', M_White, FontSizeS, 0.5, 0)
	-- y = CC.ScreenH - 128
	-- x = x + 128
	-- DrawStringEnhance(x, y, "攻击 200 防御 200 [n]精神 100 移动 5 [n]经验 50/150", M_White, FontSizeS, 0, 0)
end
--logic
function km_initWar(isRetreatable, maxTurn, inheritTurn, foeMarshal, ourMarshal)
	KM.war = {
		name = '',
		turn = 1,
		maxTurn = maxTurn,
		weather = 1,
		foeMarshal = foeMarshal,
		ourMarshal = ourMarshal,
		role = {},
		candidate = {},	-- 部署我军部队
		-- map related
		screenW = 21,
		screenH = 12,
		gridX = 1,
		gridY = 1,
		gridW = 1,
		gridH = 1,
		gridMap = {},
		tileW = 1,
		tileH = 1,
		tileMap = {},
		-- UI related
		opStep = 0,
		isActive = true,
		isShowMoveArea = false,
		isShowSelectArea = false,
		selectArea = {},
		floatingText = {},
	}
end
function km_handleWarUI()
	local ev = KM.event
	local war = KM.war
	if ev.name == 'XXXXX' then

	elseif ev.name == '地图拖动' then
		local gridX, gridY = war.gridX, war.gridY
		local ox, oy = ev.x, ev.y
		while true do
			km_waitFrame(1)
			if ev.name == '地图拖动' then
				if gridX > 0 then
					war.gridX = limitX(gridX + math.floor((ox - ev.x) / 48), 1, war.gridW - war.screenW + 1) 
				end
				war.gridY = limitX(gridY + math.floor((oy - ev.y) / 48), 1, war.gridH - war.screenH + 1) 
			else
				break
			end
		end
	elseif ev.name == '地图卷动' then
		war.gridX = war.gridX + ev.dx
		war.gridY = war.gridY + ev.dy
	end
end
function km_warOperate()
	local ev = KM.event
	local war = KM.war
	if ev.name == '选择地图网格' then
		local grid = ev.grid
		local pid = war.pid
		if war.isShowSelectArea then
			if not km_isXYInSelectArea(grid.x, grid.y, war.selectArea) then
				km_alert('不在攻击范围内．')
				war.isShowSelectArea = false
				km_warMenu(pid)
			elseif war.action == '攻击' then
				if grid.pid == 0 or KM.role[grid.pid].status ~= 1 then
					km_alert('没有敌人．')
				elseif not KM.role[grid.pid].isEnemy then
					km_alert('不能攻击我方．')
				else
					war.isShowSelectArea = false
					war.isActive = false
					km_atk(pid, grid.pid)
					war.isActive = true
				end
			elseif war.action == '技能' then
			elseif war.action == '策略' then
			end
		elseif war.isShowMoveArea then
			if grid.pid > 0 then
				if grid.pid == pid then
					local role = KM.role[pid]
					if role.isEnemy or (role['阵营'] ~= 1 and role['阵营'] ~= 7) then
						km_showRoleStatus(pid)
					else
						war.isShowMoveArea = false
						km_warMenu(pid)
					end
				else
					km_selectRole(grid.pid)
				end
			elseif grid.s ~= 2 then
				km_alert('不是在移动范围里．')
				war.isShowMoveArea = false
			else
				local role = KM.role[pid]
				if role.isEnemy then
					km_alert('不是我军部队．')
				elseif (role['阵营'] ~= 1 and role['阵营'] ~= 7) then
					km_alert('不能操作的部队．')
				else
					war.isShowMoveArea = false
					war.isActive = false
					km_moveRoleToGrid(pid, grid)
					war.isActive = true
					km_warMenu(pid)
				end
			end
		else
			if grid.pid > 0 then
				km_selectRole(grid.pid)
			end
		end
	elseif ev.name == '选择部队' then
		local pid = ev.pid
		war.pid = pid
		local role = KM.role[pid]
		km_calMoveArea(pid)
		war.selectArea = km_calRoleAtkArea(pid)
		war.isShowMoveArea = true
		if role.isEnemy == false and (role['阵营'] == 1 or role['阵营'] == 7) then
			war.opStep = 1
		end
	elseif ev.name == '战斗菜单_攻击' then
		local pid = war.pid
		war.selectArea = km_calRoleAtkArea(pid)
		if #war.selectArea >0 then
			km_hideWarMenu()
			war.action = '攻击'
			war.isShowSelectArea = true
		end
	elseif ev.name == '战斗菜单_休息' then
		km_hideWarMenu()
	elseif ev.name == '选择作用目标' then
		local pid = war.pid
		local grid = ev.grid
		if not km_isXYInSelectArea(grid.x, grid.y, war.selectArea) then
			km_alert('不在攻击范围内．')
			war.isShowSelectArea = false
			km_warMenu(pid)
		elseif war.action == '攻击' then
			if grid.pid == 0 or KM.role[grid.pid].status ~= 1 then
				km_alert('没有敌人．')
			elseif not KM.role[grid.pid].isEnemy then
				km_alert('不能攻击我方．')
			else
				war.isShowSelectArea = false
				war.isActive = false
				km_atk(pid, grid.pid)
				war.isActive = true
			end
		elseif war.action == '技能' then
		elseif war.action == '策略' then
		end
	end
	-- while true do
	-- 	km_waitFrame(1)
	-- 	ev.category = 0
	-- 	ev.name = ''
	-- end
end
function km_selectRole(pid)
	KM.war.pid = pid
	km_calMoveArea(pid)
	KM.war.isShowMoveArea = true
end
function km_warMenu(pid)
	local role = KM.role[pid]
	if role == nil then
		return
	end
	local menu = {
		{ text = '攻击', show = true, enable = true, name = '战斗菜单_攻击', },
		{ text = '技能', show = false, enable = true, name = '战斗菜单_技能', },
		{ text = '策略', show = true, enable = false, name = '战斗菜单_策略', },
		{ text = '道具', show = true, enable = false, name = '战斗菜单_道具', },
		{ text = '情报', show = true, enable = false, name = '战斗菜单_情报', },
		{ text = '休息', show = true, enable = true, name = '战斗菜单_休息', },
	}
	km_createMenu2(menu)
	local menu2 = KM.UI.menu2
	local x, y = km_gridToScreen(role.x, role.y)
	if x < CC.ScreenW2 then
		menu2.x = x + 48
	else
		menu2.x = x - menu2.width
	end
	if y < CC.ScreenH2 then
		menu2.y = y
	else
		menu2.y = y - menu2.height + 48
	end
	menu2.show = true
	-- km_waitEvent('选择结束')
	-- menu2.show = false
	-- km_waitFrame()
	-- return KM.event.selection
end
function km_hideWarMenu()
	KM.UI.menu2.show = false
end
function km_loadTMX(id)
	-- local xml = newParser()
	local file = string.format(CC.TmxFilename, id)
	local fp = io.open(file, 'r')
	if fp == nil then
		log(file .. ' is not existed.')
		return
	end
	local text = fp:read('*a')
	fp:close()
	local tmx = xml:ParseXmlText(text)
	if tmx.map == nil or tmx.map.layer == nil or tmx.map.layer[1].data == nil or tmx.map.layer[2].data == nil then
		log('parse file failed ' .. file)
		return
	end
	local width = tonumber(tmx.map['@width'])
	local height = tonumber(tmx.map['@height'])
	local gWidth = math.floor(width / 3)
	local gHeight = math.floor(height / 3)
	local dataEncode1 = tmx.map.layer[1].data['@encoding']
	local csvdata1 = tmx.map.layer[1].data:value()
	local dataEncode2 = tmx.map.layer[2].data['@encoding']
	local csvdata2 = tmx.map.layer[2].data:value()
	if width == nil or height == nil or dataEncode1 ~= 'csv' or csvdata1 == nil or dataEncode2 ~= 'csv' or csvdata2 == nil then
		log('parse file failed ' .. file)
		return
	end
	local tileData, terrainData = {}, {}
	for v in string.gmatch(csvdata1, '%d+') do
		table.insert(tileData, tonumber(v) or 0 )
	end
	for v in string.gmatch(csvdata2, '%d+') do
		local vv = tonumber(v) or 1000
		vv = vv - 1000
		table.insert(terrainData, vv )
	end
	local war = KM.war
	war.tileW = width
	war.tileH = height
	war.tileMap = tileData
	war.gridW = gWidth
	war.gridH =gHeight
	for y = 1, gHeight do
		for x = 1, gWidth do
			war.gridMap[ gWidth * (y - 1) + x ] = {
				x = x,
				y = y,
				tid = terrainData[ width * (y * 3 - 2) + x * 3 - 1  ] or 1,
				pid = 0,
				mov = 0,
				bgColor = 0,
			}
		end
	end
end
function km_getGrid(x, y)
	return KM.war.gridMap[ KM.war.gridW * (y - 1) + x ]
end
function km_isXYInArea(x, y, x1, y1, x2, y2)
	return x >= x1 and x <= x2 and y >= y1 and y <= y2
end
function km_insertRoleToWar(pid, x, y, d, isHide, isEnemy, ai, ai_x, ai_y)
	local role = KM.role[pid]
	role.x = x
	role.y = y
	role.d = d
	if isHide then
		role.status = 2
	else
		role.status = 1
	end
	role.anim = 1
	role.highlight = 0
	role.isEnemy = isEnemy
	km_calRoleWarAttribute(pid)
	km_calRoleUnitPic(pid)
	table.insert(KM.war.role, pid)
end
function km_calRoleWarAttribute(pid)
	local role = KM.role[pid]
	local uid = role['兵种']
	local unit = KM.unit[uid]
	local lv = role['等级']
	local str = role['武力']
	local int = role['智力']
	local con = role['统御']
	role.nextExp = CC.Exp[lv]
	role.maxHP = unit['基础兵力'] + unit['兵力'] * (lv - 1)
	if role.HP == nil then role.HP = role.maxHP end
	role.maxSP = math.floor( int / 40 * (lv + 10) )
	if role.SP == nil then role.SP = role.maxSP end
	role.spd = unit['速度']
	role.mov = unit['移动']
	role.atkRange = unit['攻击范围']
	role.atk = math.floor( (unit['攻击'] + 300 / math.max(130 - str, 20) - 1) * (lv + 10) )
	role.def = math.floor( (unit['防御'] + 300 / math.max(130 - con, 20) - 1) * (lv + 10) )
	role.mag = math.floor( (unit['精神'] + 300 / math.max(130 - int, 20) - 1) * (lv + 10) )

	role.movWav = unit['移动音效']
	role.atkWav = unit['攻击音效']
end
function km_calRoleUnitPic(pid)
	local role = KM.role[pid]
	local uid = role['兵种']
	local unit = KM.unit[uid]
	local pic = 0
	if role.isEnemy then
		pic = unit['敌军形象']
	elseif role['阵营'] == 1 or role['阵营'] == 7 then
		pic = unit['我军形象']
	else
		pic = unit['友军形象']
	end
	pic = pic or 0
	role.pic = pic * 50
	return pic
end
function km_gridToScreen(gx, gy)
	local sx = 48 * (gx - KM.war.gridX)
	local sy = 48 * (gy - KM.war.gridY)
	return sx, sy
end
function km_isXYInSelectArea(x, y, area)
	for i, v in ipairs(area) do
		if x == v.x and y == v.y then
			return true
		end
	end
	return false
end
function km_calSelectArea(x, y, kind, isIncludeSelfXY)
	local area = {}
	if isIncludeSelfXY then
		table.insert(area, {x = x, y = y} )
	end
	for i, v in ipairs(CC.AtkArea[kind] or {}) do
		table.insert(area, {
			x = x + v.x,
			y = y + v.y,
		} )
	end
	return area
end
function km_calRoleAtkArea(pid)
	local role = KM.role[pid]
	return km_calSelectArea(role.x, role.y, role.atkRange, false)
end
function km_calMoveArea(pid)
	local role = KM.role[pid]
	local uid = role['兵种']
	local unit = KM.unit[uid]
	-- local x, y, step = role.x, role.y, 5
	local step = role.mov
	local isZOC = true
	for i, v in ipairs(KM.war.gridMap) do
		v.s = 0
		v.g = 0
		v.parent = nil
		v.zoc = false
	end
	if isZOC then
		for i, v in ipairs(KM.war.role) do
			local gRole = KM.role[v]
			if gRole.status == 1 and gRole.isEnemy ~= role.isEnemy then
				for i = 1, 4 do
					local nx = gRole.x + CC.DirectX[i]
					local ny = gRole.y + CC.DirectY[i]
					if km_isXYInArea(nx, ny, 1, 1, KM.war.gridW, KM.war.gridH) then
						km_getGrid(nx, ny).zoc = true
					end
				end
			end
		end
		km_getGrid(role.x, role.y).zoc = false
	end
	local function MinHeapInsert(t, v)	--最小堆，新增元素
		table.insert(t,v);
		local n=#t;
		local f;
		while n>1 do
			f=math.floor(n/2);	--父节点
			if v.g < t[f].g then
				t[n],t[f]=t[f],t[n];
				n=f;
			else
				break;
			end
		end
	end
	local function MinHeapRemove(t)	--最小堆，移除第一位
		t[1], t[#t] = t[#t], t[1]
		table.remove(t)
		-- table.remove(t,1);
		local n=#t;
		local f=1;
		local c;
		while true do
			if f*2>n then
				break;
			elseif f*2+1>n then
				c=f*2;
            elseif t[f*2].g < t[f*2+1].g then
				c=f*2;
			else
				c=f*2+1;
			end
			if t[c].g < t[f].g then
				t[c],t[f]=t[f],t[c];
				f = c
			else
				break;
			end
		end
	end
	local open = { km_getGrid(role.x, role.y) }
	while #open > 0 do
		local node = open[1]
		MinHeapRemove(open)
		node.s = 2
		if not node.zoc then
			local x, y = node.x, node.y
			-- for i, v in ipairs(search[y % 2]) do
			for i = 1, 4 do
				local nx = x + CC.DirectX[i]
				local ny = y + CC.DirectY[i]
				-- if nx >= 0 and nx <= 62 and ny >= 0 and ny <= 64 then
				if km_isXYInArea(nx, ny, 1, 1, KM.war.gridW, KM.war.gridH) then
					local neibo = km_getGrid(nx, ny)
					if neibo.pid == 0 or KM.role[neibo.pid].isEnemy == role.isEnemy then
						local tid = neibo.tid
						local cost = unit.terrain[tid].cost
						if neibo.s == 2 then
							-- do nothing
						elseif neibo.s == 1 then
							local g = node.g + cost
							if g < neibo.g then
								neibo.g = g
								neibo.parent = node
							end
						else
							neibo.s = 1
							neibo.g = node.g + cost
							neibo.parent = node
							if neibo.g <= step then
								MinHeapInsert(open, neibo)
							end
						end
					end
				end
			end
		end
	end
end
function km_moveRoleToXY(pid, x, y)
	local grid = km_getGrid(x, y)
	km_moveRoleToGrid(pid, grid)
end
function km_moveRoleToGrid(pid, grid)
	local role = KM.role[pid]
	local oGrid = km_getGrid(role.x, role.y)
	local tGrid = grid
	local t = { tGrid }
	while true do
		local p = tGrid.parent
		if p then
			if p.pid == pid then
				break
			end
			table.insert(t, p)
			tGrid = p
		else
			log('人物移动错误, 无法找到正确的路径')
			break
		end
	end
	oGrid.pid = 0
	grid.pid = pid
	role.frame = 0
	local step = limitX( math.floor(21 / role.mov), 2, 10 )
	local num = 0
	for i = #t, 1, -1 do
		local g = t[i]
		local dx, dy = g.x - oGrid.x, g.y - oGrid.y
		role.d = km_calDirection(g.x - role.x, g.y - role.y)
		for n = 1, step do
			if num % 10 == 0 then
				PlayWavE(role.movWav)
			end
			if num % 2 == 0 then
				role.frame = role.frame + 1
			end
			num = num + 1
			role.x = oGrid.x + dx * n / step
			role.y = oGrid.y + dy * n / step
			km_waitFrame(1)
		end
		-- role.frame = i
		role.x = g.x
		role.y = g.y
		oGrid = g
	end
	role.frame = nil
end
function km_calDirection(dx, dy)
	-- CC.Direction = {'上','右','下','左'}
	if math.abs(dx) < math.abs(dy) then
		if dy > 0 then
			return 3
		else
			return 1
		end
	else
		if dx > 0 then
			return 2
		else
			return 4
		end
	end
end
function km_atk(pid, eid)
	if pid == 0 or eid == 0 then
		return
	end
	local pRole, eRole = KM.role[pid], KM.role[eid]
	if pRole.status ~= 1 or eRole.status ~= 1 then
		return
	end
	local isDouble = false
	if math.random() < (pRole.spd - eRole.spd + 1) / 15 then
		isDouble = true
	end
	-- 连击算法要求
	-- 	攻击速度见上边5-A条 (攻击方速度-防御方速度+1)>Random%15 可见同等速度的话，有1/15的概率连击 武术家速度A，有好几个兵种速度只有2，连击概率：(10-2+1)/15=60%，有点夸张
	-- 连击判定成功的话，写入连击标识，下次不能连击 可以改成0，无限随机连击噢，不必担心不能结束，一是有概率，二是看下一条
	-- 	即便连击判定成功，如果对方耐久力为0，则不会发生连击
	km_atkSub(pid, eid, 1)
	km_atkSub(eid, pid, 2)
	if isDouble and eRole.HP > 0 then
		km_atkSub(pid, eid, 2)
	end
end
-- category 1 普通 2 反击/穿刺等附带攻击
function km_atkSub(pid, eid, category)
	if pid == 0 or eid == 0 then
		return
	end
	local pRole, eRole = KM.role[pid], KM.role[eid]
	if pRole.status ~= 1 or eRole.status ~= 1 then
		return
	end
	local isMiss, isBlow, hurt = km_calAtkHurt(pid, eid, category)
	local dx, dy = eRole.x - pRole.x, eRole.y - pRole.y
	-- 预备 转向
	pRole.d = km_calDirection(dx, dy)
	pRole.anim = 0
	PlayWavE(6)
	km_waitFrame(4)
	-- 攻击
	pRole.anim = 2
	pRole.frame = 0
	if isBlow then	-- 暴击
		PlayWavE(6)
		-- WarAtkWords(pid)
	end
	PlayWavE(pRole.atkWav);	-- 攻击音效
	km_waitFrame(16)
	if isBlow then	-- 暴击
		PlayWavE(33)
		for highlight = 8, 192, 6 do
			pRole.highlight = highlight
			km_waitFrame(1)
		end
		pRole.highlight = 0
	end
	for i = 0, 3 do
		km_waitFrame(5)
		pRole.frame = i
	end
	--敌人
	eRole.d = km_calDirection(-dx, -dy)
	if isMiss then
		eRole.anim = 3
		if isBlow then
			eRole.highlight = 256
			PlayWavE(31)
		else
			PlayWavE(30)
		end
	elseif false then	-- 混乱
		PlayWavE(35)
	else
		eRole.anim = 4
		eRole.highlight = 240
		if isBlow then
			PlayWavE(36)
		else
			PlayWavE(35)
		end
	end
	if hurt > 0 then
		km_showRoleEffect(eid, '[B]' .. tostring(hurt))
	else
		km_showRoleEffect(eid, '[B]MISS')
	end
	km_waitFrame(16)
	-- 还原
	pRole.anim = 0
	pRole.highlight = 0
	pRole.frame = nil
	eRole.anim = 0
	eRole.highlight = 0
	eRole.frame = nil
end
function km_calAtkHurt(pid, eid, category)
	local pRole, eRole = KM.role[pid], KM.role[eid]
	local pUid = pRole['兵种']
	local eUid = eRole['兵种']
	local grid = km_getGrid(eRole.x, eRole.y)
	local defBuff = KM.unit[eUid].terrain[grid.tid].def
	local atk = pRole.atk
	local def = eRole.def * defBuff / 100
	local isMiss, isBlow = false, false
	local hurt = 0
	if false or math.random() < def / atk / 10 then	-- 敌军混乱时 必定命中
		isMiss = true
	end
	if pRole.spd > math.random(100) then
		isBlow = true
	end
	if not isMiss then
		hurt = math.max(atk * 2 - def, 1)
		-- 判断防御方兵种
		-- 	如果兵种代号为09，0A、0B时，伤害A=Ax75% 战车系, 象兵团
		-- 	如果兵种代号为1B、1C、1D时，伤害A=Ax150% 运粮队 物资队 军乐队
		-- 	如果兵种代号1E、1F时，伤害A=Ax50% 南蛮兵 南蛮骑兵 羌族兵 北狄兵
		-- 	如果兵种代号为22时，伤害A=1 藤甲兵
		--	判断是范围攻击类第一次攻击伤害还是反击，如果非第一次攻击，或者为反击，则上边计算的A=A/2
		if category ~= 1 then
			hurt = hurt / 2
		end
		if isBlow then
			hurt = hurt * 3 / 2
		end
		-- 等级相关的随机因素造成伤害变动
		if isBlow or math.random() < pRole['等级'] / (pRole['等级'] + eRole['等级']) then
			hurt = hurt + math.random( 1 + pRole['等级'] * 10 ) % 60
		else
			hurt = hurt - math.random( 1 + eRole['等级'] * 10 ) % 60
		end
		--难度
		if false then
			hurt = hurt * 0.8
		elseif false then
			hurt = hurt * 1.2
		end
		hurt = limitX(math.floor(hurt), 1, eRole.HP)
	end
	return isMiss, isBlow, hurt
	--[[
		如果Random%(攻方攻击力x攻方所在地形因素/10)<防御方防御力x防御方地形因素/10/10 并且防御方没有混乱，那么伤害A=0
		如果Random%(攻方攻击力x攻方所在地形因素/10)>=防御方防御力x防御方地形因素/10/10 那么又分为： 
			如果(防御力x地形因素/10+1)/2>攻击方攻击力x攻击方所在地形因素/10 那么伤害A=1
			如果(防御力x地形因素/10+1)/2<攻击方攻击力x攻击方所在地形因素/10 那么伤害A=攻击力x地形因素/10-防御力x地形因素/10/2
		判断防御方兵种
			如果兵种代号为09，0A、0B时，伤害A=Ax75%
			如果兵种代号为1B、1C、1D时，伤害A=Ax150%
			如果兵种代号1E、1F时，伤害A=Ax50%
			如果兵种代号为22时，伤害A=1
		判断是范围攻击类第一次攻击伤害还是反击，如果非第一次攻击，或者为反击，则上边计算的A=A/2； 
		注：如果到目前为止，伤害计算为0，则跳过下边5、6条过程
		无论前边攻击计算是否造成伤害，特效都会进行判断； 象兵和蛇兵的兵种攻击特效（附加异常状态跟策略附加异常状态调用的计算函数一样）如下： A、反击不会带特效
		已经混乱的不能被象兵再次混乱，已经有减血状态的不能被蛇兵再次附加减血状态
		有减轻策略伤害的buffer在的话，被附加异常状态buffer的几率减少，算法是仅仅增加跟随机数比较的“赌博”机会而已 2次都成功才可附加状态，意思就是说，第一次计算如果附加了状态，没有buffer的话就算是附加异常状态了，但如果有减轻策略损伤的buffer在，会再计算一次 如果成功才能附加异常状态，如果失败将不附加异常状态
		状态是否成功跟双方智力和随机数有关： 当Random%攻击方智力>=防御方智力/策略成功率基数时特效才能附加上 本次策略成功率基数=2
		判断是否会全力一击 A、取得兵种攻击速度GSPD
		确认是否全力一击 当GSPD>Random%100是全力一击； 全力一击伤害A=Ax3/2=Ax150%
		等级相关的随机因素造成伤害变动：
			前边计算出基础伤害Abase
			取得防御方等级Flevel，然后取得0~FLevel-1的随机值Frnd1
			取得攻击方等级Glevel，然后取得0~Glelev-1的随机值Grnd1
			比较Frnd1与Grnd1的大小
				如果Frnd1<Grnd1，或者产生了全力一击； 那么伤害会随机增加（0~Glevel-1）%6之间的随机值Grnd2，结果为Abase=Abase+Grnd2
				如果Frnd1>=Grnd1， 那么伤害随机减少（0~Flevel-1）%6的随机值Frnd2，如果伤害为1，减少了2，那只能取0和1-2的最大值，即保证伤害不能为负数，结果为Abase=Max(Abase-Frnd2,0)
		确认防御方是我军（15个部队）还是敌军； 如果是我军，那个会去确认游戏难度
			难度为初级的话，我军受伤害为Abase=Abasex80%
			难度为高级的话，我军受伤害为Abase=Abasex120%
			没有中级难度计算，那明显伤害为Abase=Abasex100%
		取得防御方当前耐久力，如果最终的ABase>=耐久力的话，伤害Abase=耐久力； 如果伤害<耐久力的哈，Abase不变，这个是为了防止打出比当前耐久力还大的数
		关于连击
			主动攻击的连击，还是主动攻击，反击的连击，还是反击，伤害按照上边的再次套用就行
			速度低于防御方的兵种，不会连击，至少跟防御方速度相等
			已经连击过的话，不能再连击
		连击算法要求
			攻击速度见上边5-A条 (攻击方速度-防御方速度+1)>Random%15 可见同等速度的话，有1/15的概率连击 武术家速度A，有好几个兵种速度只有2，连击概率：(10-2+1)/15=60%，有点夸张
		连击判定成功的话，写入连击标识，下次不能连击 可以改成0，无限随机连击噢，不必担心不能结束，一是有概率，二是看下一条
			即便连击判定成功，如果对方耐久力为0，则不会发生连击
	]]
end
function km_showRoleEffect(pid, text)
	local role = KM.role[pid]
	local sx, sy = km_gridToScreen(role.x, role.y)
	table.insert(KM.war.floatingText, {
		text = tostring(text),
		x = sx + 24,
		y = sy + 24,
		size = CC.FontSizeM,
		alpha = 255,
		dx = 0,
		dy = -1,
		dsize = 0,
		dalpha = 0,
		delay = 0,
		dur = 24,
	})
end