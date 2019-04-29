------ Scenario ------
function km_loadScenario(chapter, act)
	-- chapter ��, act Ļ
	-- scene ��, section ��, event �¼�, instruct ָ��
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
			if '��' == inst then
				scene = {}
				section, event = nil, nil
				table.insert(snr, scene)
			elseif '��' == inst then
				if type(scene) == 'table' then
					section = {}
					event = nil
					table.insert(scene, section)
				else
					log(string.format('�籾������%s�ĵ�%d��, �ڶ����ڳ�֮ǰ', file, rowNo))
				end
			elseif '�¼�' == inst then
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
					log(string.format('�籾������%s�ĵ�%d��, �¼������ڽ�֮ǰ', file, rowNo))
				end
			else
				if type(event) == 'table' then
					table.insert(event.content, {
						inst = inst,
						parms = parms,
						tabPos = tabPos,
					})
				else
					log(string.format('�籾������%s�ĵ�%d��, ָ��������¼�֮ǰ', file, rowNo))
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
		log('�籾����, ��' .. sid .. '��Ϊ��')
		return
	end
	local section = scene[ssid]
	if type(section) ~= 'table' then
		log('�籾����, ��' .. ssid .. '��Ϊ��')
		return
	end
	local maxEvent = #section
	while idx.event <= maxEvent do
		local event = section[idx.event]
		if km_checkTrigger(event.trig, {...}) then
			km_executeInstruct(event.content)
			if idx.event == 1 then
				if event.trig[1] == '��֧ѡ��' then
					idx.event = idx.event + KM.event.selection
				elseif event.trig[1] == '�Զ�' then
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
	if trig[1] == '�Զ�' then
		return true
	elseif trig[1] == '��֧ѡ��' then
		return true
	elseif trig[1] == 'ѡ������ʱ' then
		if e[1] == 'ѡ�����￨Ƭ' and e[2] == trig[2]  then
			return true
		end
	elseif trig[1] == '���뽨��ʱ' then
		if e[1] == '���뽨��' and e[2] == trig[2]  then
			return true
		end
	elseif trig[1] == '�������ʱ' then
		if e[1] == '�������' and e[2] == trig[2]  then
			return true
		end
	elseif trig[1] == '�غϿ�ʼʱ' then
		if e[1] == '�غϿ�ʼ' and ev.turnNum == trig[2]  then
			return true
		end
	elseif trig[1] == '��������ʱ' then
		if e[1] == '��������' and e[2] == trig[2]  then
			return true
		end
	elseif trig[1] == '��������ʱ' then
		if e[1] == '��������' and e[2] == trig[2]  then
			return true
		end
	elseif trig[1] == '��������ʱ' then
		if e[1] == '��������' and e[2] == trig[2]  then
			return true
		end
	elseif trig[1] == '���ӳ���ʱ' then
		if e[1] == '���ӳ���' and e[2] == trig[2]  then
			return true
		end
	elseif trig[1] == 'ս��ʤ��ʱ' then
		if e[1] == 'ս��ʤ��' then
			return true
		end
	elseif trig[1] == 'ս��ʧ��ʱ' then
		if e[1] == 'ս��ʧ��' then
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
				log('ָ�����, "' .. v.inst .. '"������')
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
				return 'ָ���������, ����' .. k .. '��ҪΪ����'
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
			return 'ָ���������, ����' .. k .. '����Ϊ��ֵ'
		else
			v = tonumber(v)
			if v == nil then
				return 'ָ���������, ����' .. k .. '��ҪΪ����'
			end
		end
		table.insert(rv, v)
	end
	return false, table.unpack(rv)
end
Instruct = {}
Instruct['����ģʽ'] = function(parms)
	local err, mode = km_assert(parms, 'int')
	if err then
		return err
	end
	KM.gameMode = mode
end
Instruct['�����½���'] = function(parms)
	local err, text = km_assert(parms, 'string')
	if err then
		return err
	end
	-- wait fulfill
	KM.misc.cheaperName = text
end
Instruct['��������Ŀ��'] = function(parms)
	local err, text = km_assert(parms, 'string')
	if err then
		return err
	end
	-- wait fulfill
	KM.misc.mission = text
end
Instruct['��������'] = function(parms)
	-- KM.snrIdx.section = KM.snrIdx.section + 1
	KM.snrIdx.nextSection = true
end
Instruct['����ת'] = function(parms)
	local err, scene = km_assert(parms, 'int')
	if err then
		return err
	end
	-- KM.snrIdx.scene = scene
	KM.snrIdx.jmpScene = scene
end
Instruct['��������'] = function(parms)
	-- wait fulfill
end
Instruct['��������'] = function(parms)
	local err, music = km_assert(parms, 'int')
	if err then
		return err
	end
	PlayBGM(music)
end
Instruct['��������'] = function(parms)
	local err, city = km_assertInt(parms)
	if err then
		return err
	end
	-- wait fulfill
end
Instruct['�޸���Ӫ'] = function(parms)
	local err, role, force = km_assert(parms, 'int', 'int')
	if err then
		return err
	end
	-- wait fulfill
end
Instruct['�л�����'] = function(parms)
	local err, city = km_assert(parms, 'int')
	if err then
		return err
	end
	-- wait fulfill
end
Instruct['ָ����ͼ'] = function(parms)
	local err, category, id = km_assert(parms, 'int', 0)
	if err then
		return err
	end
	-- wait fulfill
	km_waitFrame(4)
	Dark()
	KM.UI.scene.role = {}
	if category == 0 then	-- ���ͼ
		km_setScene(201)
	elseif category == 1 then	-- ����
		local city = KM.city[id]
		if city ~= nil then
			km_setScene(city['��ͼ'])
		end
	elseif category == 2 then
		if id == 0 then -- ������
			km_setScene(54)
		elseif id == 1 then -- ������
			km_setScene(67)
		elseif id == 2 then -- �ƹ�
			km_setScene(68)
		elseif id == 5 then -- ����
			km_setScene(53)
		elseif id == 6 then -- ��ۡ
			km_setScene(69)
		elseif id == 7 then -- ��լ
			km_setScene(69)
		elseif id == 8 then -- Ӫ��
			km_setScene(55)
		elseif id == 9 then -- ??
			km_setScene(52)
		elseif id == 10 then -- ??
			km_setScene(55)
		elseif id == 11 then -- ??
			km_setScene(55)
		elseif id == 15 then -- ����
			km_setScene(62)
		elseif id == 18 then -- ??
			km_setScene(70)
		end
	elseif category == 3 then
		KM.war.name = CC.WarName[id] or 'δָ����ս����'
		km_loadTMX(id)
	end
end
Instruct['��ʾѡ��'] = function(parms)
	local err, text = km_assert(parms, 'string')
	if err then
		return err
	end
	text = string.gsub(text, '\\n', '\n')
	local r = km_select(text, CC.ScreenW2, CC.ScreenH2)
	-- KM.snrIdx.event = KM.snrIdx.event + r
end
Instruct['��ʾ��Ϣ'] = function(parms)
	local err, text = km_assert(parms, 'string')
	if err then
		return err
	end
	km_notice(text)
end
Instruct['��ʾ������Ϣ'] = function(parms)
	local err, text = km_assert(parms, 'string')
	if err then
		return err
	end
	text = string.gsub(text, '\\n', '[n]')
	km_mutliText(text)
end
Instruct['�Ի�'] = function(parms)
	local err, role, text = km_assert(parms, 'int', 'string')
	if err then
		return err
	end
	local num, talkArrary = Split(text, '\\n')
	for i = 1, num, 3 do
		km_talk(role, table.concat(talkArrary, '[n]', i, math.min(i + 2, num)))
	end
end
Instruct['�������'] = function(parms)
	local err, role, x, y = km_assert(parms, 'int', 'int', 'int')
	if err then
		return err
	end
	if role > 1 then -- bypass kongming
		km_insertRole(role, x, y)
	end
end
Instruct['�����ƶ�'] = function(parms)
	-- wait fulfill
end
Instruct['������ʧ'] = function(parms)
	local err, role = km_assert(parms, 'int')
	if err then
		return err
	end
	km_removeRole(role)
end
Instruct['���ﶯ��'] = function(parms)
	-- wait fulfill
end
Instruct['�������'] = function(parms)
	-- wait fulfill
end
Instruct['��ʾ����'] = function(parms)
	-- wait fulfill
end
Instruct['���ñ��'] = function(parms)
	local err, id, v = km_assert(parms, 'int', 'string')
	if err then
		return err
	end
	KM.flag[id] = v == '��'
end
Instruct['�жϱ��'] = function(parms, tabPos)
	local flags = {}
	for k, v in ipairs(parms) do
		local id = tonumber(v)
		if id ~= nil then
			table.insert(flags, id)
		else
			local cond = v == '��'
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
Instruct['ѯ���Ƿ�'] = function(parms, tabPos)
	local err, cond = km_assert(parms, 0)
	if cond ~= km_confirm() then
		KM.skipTab = tabPos
	end
end
Instruct['����'] = function(parms)
	local err, pid, num = km_assert(parms, 'int', 'int')
	if err then
		return err
	end
	local role = KM.role[pid]
	role['�ȼ�'] = limitX(role['�ȼ�'] + num, 1, CC.MaxLv)
end
Instruct['תְ'] = function(parms)
	local err, pid, uid = km_assert(parms, 'int', 'int')
	if err then
		return err
	end
	local role = KM.role[pid]
	if role == nil or KM.unit[uid] == nil then
		return string.format('ָ��[תְ]��������, ���� = %d �� ���� = %d ������', pid, uid)
	end
	role['����'] = uid
end
Instruct['�޸���Ӫ'] = function(parms)
	local err, pid, fid = km_assert(parms, 'int', 'int')
	if err then
		return err
	end
	local role = KM.role[pid]
	if role == nil then
		return string.format('ָ��[�޸���Ӫ]��������, ���� = %d �� ��Ӫ = %d ������', pid, fid)
	end
	role['��Ӫ'] = fid
end
Instruct['��õ���'] = function(parms)
	local err, iid = km_assert(parms, 'int')
	if err then
		return err
	end
	local pid = 1
	local role = KM.role[pid]
	if role == nil or false then
		return string.format('ָ��[��õ���]��������, ���� = %d ������', iid)
	end
	for i = 1, CC.MaxItemNum do
		if role['����' .. i] == -1 then
			role['����' .. i] = iid
		end
	end
end
------ War ------
Instruct['ս����ʼ��'] = function(parms)
	local err, isRetreatable, maxTurn, inheritTurn, foeMarshal, ourMarshal = km_assert(parms, 0, 0, 0, 0, 0)
	if err then
		return err
	end
	if maxTurn == 0 then
		maxTurn = 20
	end
	km_initWar(isRetreatable, maxTurn, inheritTurn, foeMarshal, ourMarshal)
end
Instruct['�����Ҿ�'] = function(parms)
	local err, pid, x, y, isCheckFlag, flag, d, isHide = km_assert(parms, 0, 0, 0, 0, 0, 0, 0)
	if err then
		return err
	end
	if isCheckFlag == 1 and KM.flag[flag] == false then
		return
	end
	if pid > 0 and KM.role[pid] == nil then
		return string.format('ָ��[�����Ҿ�]��������, ���� = %d ������', pid)
	end
	table.insert(KM.war.candidate, {
		pid = pid,
		x = x,
		y = y,
		d = limitX(d, 1, 4),
		isHide = isHide == 1,
	})
	
end
Instruct['ѡ�񲿶�'] = function(parms)
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
Instruct['����о�'] = function(parms)
	local err, pid, x, y, isCheckFlag, flag, d, isHide, uid, lv, ai, ai_x, ai_y = km_assert(parms, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
	if err then
		return err
	end
	if isCheckFlag == 1 and KM.flag[flag] == false then
		return
	end
	local role = KM.role[pid]
	if role == nil then
		return string.format('ָ��[����о�]��������, ���� = %d ������', pid)
	end
	if KM.unit[uid] == nil then
		log(string.format('ָ��[����о�]��������, ���� = %d ������', uid))
		uid = 1
	end
	role['����'] = uid
	role['�ȼ�'] = limitX(lv, 1, CC.MaxLv)
	km_insertRoleToWar(pid, x, y, limitX(d, 1, 4), isHide == 1, true, limitX(ai, 1, 7), ai_x, ai_y)
end
Instruct['����ս��'] = function(parms)
	local err = km_assert(parms)
	if err then
		return err
	end
	if #KM.war.gridMap <= 0 then
		return 'ָ��[����ս��]ʧ��, ս����ͼδָ��'
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

-- �����Ҿ�: 1<�����>, <����>6, 22, <�жϱ�ǳ���>0<��>, <���>0, <����>1<��>, <����>0<��>
-- �����Ҿ�: 3<����>, <����>5, 10, <�жϱ�ǳ���>0<��>, <���>0, <����>3<��>, <����>1<��>
-- �����Ҿ�: 4<�ŷ�>, <����>6, 10, <�жϱ�ǳ���>0<��>, <���>0, <����>3<��>, <����>1<��>
-- �����Ҿ�: 7<����>, <����>6, 9, <�жϱ�ǳ���>0<��>, <���>0, <����>3<��>, <����>0<��>
-- �����Ҿ�: 0<��ѡ>, <����>2, 22, <�жϱ�ǳ���>0<��>, <���>0, <����>1<��>, <����>0<��>