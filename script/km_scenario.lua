------ Scenario ------
function km_loadScenario(chapter, act)
	-- chapter 章, act 幕
	-- scene 场, section 节, event 事件, instruct 指令
	local file = string.format(CC.SnrFilename, chapter, act)
	local fp = io.open(file, 'r')
	if fp == nil then
		log('fail to load scenario file: ', file)
		return
	end
	local snr = {}
	KM.scenario = snr
	local scene, section, event
	local rowNo = 0
    while true do
        local str = fp:read()
        if str == nil then
            break
		end
		rowNo = rowNo + 1
		-- remove annotation
		str = string.gsub(str, '#.*', '')
		str = string.gsub(str, '<[^>]*>?', '')
		local tabPos = string.find(str, '%S')
		if tabPos ~= nil then
			str = string.sub(str, tabPos)
			local segPos = string.find(str, ':')
			local inst
			local parms = {}
			if segPos == nil then
				inst = trim(str)
			else
				inst = trim(string.sub(str, 1, segPos - 1))
				str = string.sub(str, segPos + 1)
				while true do
					local pos = string.find(str, ',')
					if pos == nil then
						table.insert(parms, trim(str))
						break
					else
						table.insert(parms, trim(string.sub(str, 1, pos - 1)))
						str = string.sub(str, pos + 1)
					end
				end
			end
			if '场' == inst then
				scene = {}
				section, event = nil, nil
				table.insert(snr, scene)
			elseif '节' == inst then
				if type(scene) == 'table' then
					section = {}
					event = nil
					table.insert(scene, section)
				else
					log(string.format('剧本错误于%s的第%d行, 节定义于场之前', file, rowNo))
				end
			elseif '事件' == inst then
				if type(section) == 'table' then
					for i = 2, #parms do
						parms[i] = tonumber(parms[i]) or 0
					end
					event = {
						trig = parms,
						content = {},
					}
					table.insert(section, event)
				else
					log(string.format('剧本错误于%s的第%d行, 事件定义于节之前', file, rowNo))
				end
			else
				if type(event) == 'table' then
					table.insert(event.content, {
						inst = inst,
						parms = parms,
						tabPos = tabPos,
					})
				else
					log(string.format('剧本错误于%s的第%d行, 指令出现于事件之前', file, rowNo))
				end
			end
		end
	end
	-- logTable(snr)
end
function km_playScenario(...)
	repeat
		local continue = km_playScenarioSub(...)
	until not continue
end
function km_playScenarioSub(...)
	local idx = KM.snrIdx
	idx.jmpScene = nil
	idx.nextSection = nil
	idx.event = 1
	local snr = KM.scenario
	local sid = idx.scene
	local ssid = idx.section
	local scene = snr[sid]
	if type(scene) ~= 'table' then
		log('剧本错误, 第' .. sid .. '场为空')
		return
	end
	local section = scene[ssid]
	if type(section) ~= 'table' then
		log('剧本错误, 第' .. ssid .. '节为空')
		return
	end
	local maxEvent = #section
	while idx.event <= maxEvent do
		local event = section[idx.event]
		if km_checkTrigger(event.trig, {...}) then
			km_executeInstruct(event.content)
			if idx.event == 1 then
				if event.trig[1] == '分支选择' then
					idx.event = idx.event + KM.event.selection
				elseif event.trig[1] == '自动' then
					idx.nextSection = true
					break
				else
					break
				end
			else
				break
			end
		else
			idx.event = idx.event + 1
		end
	end
	if idx.jmpScene then
		idx.scene = idx.jmpScene
		idx.nextSection = true
		idx.section = 1
	elseif idx.nextSection then
		idx.section = idx.section + 1
		if idx.section > #scene then
			idx.scene = idx.scene + 1
			idx.section = 1
		end
		if idx.scene > #snr then
			idx.act = idx.act + 1
			idx.scene = 1
			km_loadScenario(idx.chapter, idx.act)
		end
	end
	return idx.nextSection
end
function km_checkTrigger(trig, e)
	local ev = KM.event
	if trig[1] == '自动' then
		return true
	elseif trig[1] == '分支选择' then
		return true
	elseif trig[1] == '选择人物时' then
		if e[1] == '选择人物卡片' and e[2] == trig[2]  then
			return true
		end
	elseif trig[1] == '进入建筑时' then
		if e[1] == '进入建筑' and e[2] == trig[2]  then
			return true
		end
	elseif trig[1] == '进入城市时' then
		if e[1] == '进入城市' and e[2] == trig[2]  then
			return true
		end
	elseif trig[1] == '回合开始时' then
		if e[1] == '回合开始' and ev.turnNum == trig[2]  then
			return true
		end
	elseif trig[1] == '部队相邻时' then
		if e[1] == '进入区域' and e[2] == trig[2]  then
			return true
		end
	elseif trig[1] == '进入坐标时' then
		if e[1] == '进入区域' and e[2] == trig[2]  then
			return true
		end
	elseif trig[1] == '进入区域时' then
		if e[1] == '进入区域' and e[2] == trig[2]  then
			return true
		end
	elseif trig[1] == '部队撤退时' then
		if e[1] == '部队撤退' and e[2] == trig[2]  then
			return true
		end
	elseif trig[1] == '战斗胜利时' then
		if e[1] == '战斗胜利' then
			return true
		end
	elseif trig[1] == '战斗失败时' then
		if e[1] == '战斗失败' then
			return true
		end
	end
	-- wait fulfill
	return false
end
function km_executeInstruct(content)
	KM.skipTab = 0
	for k, v in ipairs(content) do
		-- log('execute', k, v.inst)
		-- log(v.tabPos, ' ', KM.skipTab, ' ', v.inst, v.parms[1],v.parms[2])
		if v.tabPos <= KM.skipTab then
			KM.skipTab = 0
		end
		if KM.skipTab == 0 then
			local fun = Instruct[v.inst]
			if type(fun) == 'function' then
				local err = fun(v.parms, v.tabPos)
				if err then
					log(err)
				end
				if KM.snrIdx.nextSection then
					break
				end
			else
				log('指令错误, "' .. v.inst .. '"不存在')
			end
		end
	end
end
------ Instruct ------
function km_assert(parms, ...)
	local rv = {}
	for k, v in ipairs({...}) do
		local par = parms[k]
		if v == 0 then
			par = tonumber(par) or 0
		elseif v == 'int' then
			par = tonumber(par)
			if par == nil then
				return '指令参数错误, 参数' .. k .. '需要为整数'
			end
		else
			par = par or ''
		end
		table.insert(rv, par)
	end
	return false, table.unpack(rv)
end
function km_assertInt(parms)
	local rv = {}
	for k, v in ipairs(parms) do
		if v == nil then
			return '指令参数错误, 参数' .. k .. '不能为空值'
		else
			v = tonumber(v)
			if v == nil then
				return '指令参数错误, 参数' .. k .. '需要为整数'
			end
		end
		table.insert(rv, v)
	end
	return false, table.unpack(rv)
end
Instruct = {}
Instruct['设置模式'] = function(parms)
	local err, mode = km_assert(parms, 'int')
	if err then
		return err
	end
	KM.gameMode = mode
end
Instruct['设置章节名'] = function(parms)
	local err, text = km_assert(parms, 'string')
	if err then
		return err
	end
	-- wait fulfill
	KM.misc.cheaperName = text
end
Instruct['设置任务目标'] = function(parms)
	local err, text = km_assert(parms, 'string')
	if err then
		return err
	end
	-- wait fulfill
	KM.misc.mission = text
end
Instruct['结束本节'] = function(parms)
	-- KM.snrIdx.section = KM.snrIdx.section + 1
	KM.snrIdx.nextSection = true
end
Instruct['场跳转'] = function(parms)
	local err, scene = km_assert(parms, 'int')
	if err then
		return err
	end
	-- KM.snrIdx.scene = scene
	KM.snrIdx.jmpScene = scene
end
Instruct['结束本章'] = function(parms)
	-- wait fulfill
end
Instruct['播放音乐'] = function(parms)
	local err, music = km_assert(parms, 'int')
	if err then
		return err
	end
	PlayBGM(music)
end
Instruct['开启城市'] = function(parms)
	local err, city = km_assertInt(parms)
	if err then
		return err
	end
	-- wait fulfill
end
Instruct['修改阵营'] = function(parms)
	local err, role, force = km_assert(parms, 'int', 'int')
	if err then
		return err
	end
	-- wait fulfill
end
Instruct['切换城市'] = function(parms)
	local err, city = km_assert(parms, 'int')
	if err then
		return err
	end
	-- wait fulfill
end
Instruct['指定地图'] = function(parms)
	local err, category, id = km_assert(parms, 'int', 0)
	if err then
		return err
	end
	-- wait fulfill
	km_waitFrame(4)
	Dark()
	KM.UI.scene.role = {}
	if category == 0 then	-- 大地图
		km_setScene(201)
	elseif category == 1 then	-- 城市
		local city = KM.city[id]
		if city ~= nil then
			km_setScene(city['地图'])
		end
	elseif category == 2 then
		if id == 0 then -- 议事厅
			km_setScene(54)
		elseif id == 1 then -- 集会所
			km_setScene(67)
		elseif id == 2 then -- 酒馆
			km_setScene(68)
		elseif id == 5 then -- 宫殿
			km_setScene(53)
		elseif id == 6 then -- 官邸
			km_setScene(69)
		elseif id == 7 then -- 民宅
			km_setScene(69)
		elseif id == 8 then -- 营帐
			km_setScene(55)
		elseif id == 9 then -- ??
			km_setScene(52)
		elseif id == 10 then -- ??
			km_setScene(55)
		elseif id == 11 then -- ??
			km_setScene(55)
		elseif id == 15 then -- 郊外
			km_setScene(62)
		elseif id == 18 then -- ??
			km_setScene(70)
		end
	elseif category == 3 then
		KM.war.name = CC.WarName[id] or '未指定的战役名'
		km_loadTMX(id)
	end
end
Instruct['显示选单'] = function(parms)
	local err, text = km_assert(parms, 'string')
	if err then
		return err
	end
	text = string.gsub(text, '\\n', '\n')
	local r = km_select(text, CC.ScreenW2, CC.ScreenH2)
	-- KM.snrIdx.event = KM.snrIdx.event + r
end
Instruct['显示信息'] = function(parms)
	local err, text = km_assert(parms, 'string')
	if err then
		return err
	end
	km_notice(text)
end
Instruct['显示多行信息'] = function(parms)
	local err, text = km_assert(parms, 'string')
	if err then
		return err
	end
	text = string.gsub(text, '\\n', '[n]')
	km_mutliText(text)
end
Instruct['对话'] = function(parms)
	local err, role, text = km_assert(parms, 'int', 'string')
	if err then
		return err
	end
	local num, talkArrary = Split(text, '\\n')
	for i = 1, num, 3 do
		km_talk(role, table.concat(talkArrary, '[n]', i, math.min(i + 2, num)))
	end
end
Instruct['人物出现'] = function(parms)
	local err, role, x, y = km_assert(parms, 'int', 'int', 'int')
	if err then
		return err
	end
	if role > 1 then -- bypass kongming
		km_insertRole(role, x, y)
	end
end
Instruct['人物移动'] = function(parms)
	-- wait fulfill
end
Instruct['人物消失'] = function(parms)
	local err, role = km_assert(parms, 'int')
	if err then
		return err
	end
	km_removeRole(role)
end
Instruct['人物动作'] = function(parms)
	-- wait fulfill
end
Instruct['人物表情'] = function(parms)
	-- wait fulfill
end
Instruct['显示场景'] = function(parms)
	-- wait fulfill
end
Instruct['设置标记'] = function(parms)
	local err, id, v = km_assert(parms, 'int', 'string')
	if err then
		return err
	end
	KM.flag[id] = v == '真'
end
Instruct['判断标记'] = function(parms, tabPos)
	local flags = {}
	for k, v in ipairs(parms) do
		local id = tonumber(v)
		if id ~= nil then
			table.insert(flags, id)
		else
			local cond = v == '真'
			for kk, id in ipairs(flags) do
				if KM.flag[id] ~= cond then
					KM.skipTab = tabPos
					return false
				end
			end
			flags = {}
		end
	end
	if #flags > 0 then
		KM.skipTab = tabPos
	end
end
Instruct['询问是否'] = function(parms, tabPos)
	local err, cond = km_assert(parms, 0)
	if cond ~= km_confirm() then
		KM.skipTab = tabPos
	end
end
Instruct['升级'] = function(parms)
	local err, pid, num = km_assert(parms, 'int', 'int')
	if err then
		return err
	end
	local role = KM.role[pid]
	role['等级'] = limitX(role['等级'] + num, 1, CC.MaxLv)
end
Instruct['转职'] = function(parms)
	local err, pid, uid = km_assert(parms, 'int', 'int')
	if err then
		return err
	end
	local role = KM.role[pid]
	if role == nil or KM.unit[uid] == nil then
		return string.format('指令[转职]参数错误, 人物 = %d 或 兵种 = %d 不存在', pid, uid)
	end
	role['兵种'] = uid
end
Instruct['修改阵营'] = function(parms)
	local err, pid, fid = km_assert(parms, 'int', 'int')
	if err then
		return err
	end
	local role = KM.role[pid]
	if role == nil then
		return string.format('指令[修改阵营]参数错误, 人物 = %d 或 阵营 = %d 不存在', pid, fid)
	end
	role['阵营'] = fid
end
Instruct['获得道具'] = function(parms)
	local err, iid = km_assert(parms, 'int')
	if err then
		return err
	end
	local pid = 1
	local role = KM.role[pid]
	if role == nil or false then
		return string.format('指令[获得道具]参数错误, 道具 = %d 不存在', iid)
	end
	for i = 1, CC.MaxItemNum do
		if role['道具' .. i] == -1 then
			role['道具' .. i] = iid
		end
	end
end
------ War ------
Instruct['战斗初始化'] = function(parms)
	local err, isRetreatable, maxTurn, inheritTurn, foeMarshal, ourMarshal = km_assert(parms, 0, 0, 0, 0, 0)
	if err then
		return err
	end
	if maxTurn == 0 then
		maxTurn = 20
	end
	km_initWar(isRetreatable, maxTurn, inheritTurn, foeMarshal, ourMarshal)
end
Instruct['部署我军'] = function(parms)
	local err, pid, x, y, isCheckFlag, flag, d, isHide = km_assert(parms, 0, 0, 0, 0, 0, 0, 0)
	if err then
		return err
	end
	if isCheckFlag == 1 and KM.flag[flag] == false then
		return
	end
	if pid > 0 and KM.role[pid] == nil then
		return string.format('指令[部署我军]参数错误, 人物 = %d 不存在', pid)
	end
	table.insert(KM.war.candidate, {
		pid = pid,
		x = x,
		y = y,
		d = limitX(d, 1, 4),
		isHide = isHide == 1,
	})
	
end
Instruct['选择部队'] = function(parms)
	local err = km_assert(parms)
	if err then
		return err
	end
	for k, v in ipairs(KM.war.candidate) do
		if v.pid > 0 then
			km_insertRoleToWar(v.pid, v.x, v.y, v.d, v.isHide, false, 1)
		end
	end
	KM.war.candidate = {}
end
Instruct['部署敌军'] = function(parms)
	local err, pid, x, y, isCheckFlag, flag, d, isHide, uid, lv, ai, ai_x, ai_y = km_assert(parms, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	if err then
		return err
	end
	if isCheckFlag == 1 and KM.flag[flag] == false then
		return
	end
	local role = KM.role[pid]
	if role == nil then
		return string.format('指令[部署敌军]参数错误, 人物 = %d 不存在', pid)
	end
	if KM.unit[uid] == nil then
		log(string.format('指令[部署敌军]参数错误, 兵种 = %d 不存在', uid))
		uid = 1
	end
	role['兵种'] = uid
	role['等级'] = limitX(lv, 1, CC.MaxLv)
	km_insertRoleToWar(pid, x, y, limitX(d, 1, 4), isHide == 1, true, limitX(ai, 1, 7), ai_x, ai_y)
end
Instruct['进入战斗'] = function(parms)
	local err = km_assert(parms)
	if err then
		return err
	end
	if #KM.war.gridMap <= 0 then
		return '指令[进入战斗]失败, 战场地图未指定'
	end
	if KM.war.gridW < KM.war.screenW then
		KM.war.gridX = math.floor((KM.war.gridW - KM.war.screenW) / 2)
	end
	for k, pid in ipairs(KM.war.role) do
		local role = KM.role[pid]
		if role.status == 1 and km_isXYInArea(role.x, role.y, 1, 1, KM.war.gridW, KM.war.gridH) then
			local grid = km_getGrid(role.x, role.y)
			if grid then
				grid.pid = pid
			end
		end
	end
	KM.gameMode = 2
end

-- 部署我军: 1<诸葛亮>, <坐标>6, 22, <判断标记出场>0<否>, <标记>0, <方向>1<右>, <伏兵>0<否>
-- 部署我军: 3<关羽>, <坐标>5, 10, <判断标记出场>0<否>, <标记>0, <方向>3<左>, <伏兵>1<是>
-- 部署我军: 4<张飞>, <坐标>6, 10, <判断标记出场>0<否>, <标记>0, <方向>3<左>, <伏兵>1<是>
-- 部署我军: 7<赵云>, <坐标>6, 9, <判断标记出场>0<否>, <标记>0, <方向>3<左>, <伏兵>0<否>
-- 部署我军: 0<自选>, <坐标>2, 22, <判断标记出场>0<否>, <标记>0, <方向>1<右>, <伏兵>0<否>