--[[
����AI  - ��������AI����
  - ����AI��Ϊ ���� ���� ����  ��������  ͳһ�� ��������  ��
����AI  - ���� ���� / ս��
  - ���ݳ���Ŀ��, ��������AI
    - ����Ŀ���Ϊ: ί��  ����  ����  ����XX
  - ����AI, �����ж��Ƿ����ս��
    - ս��  ��������Ŀ��
    - ����  �Զ�������������





]]--
function AI_Force()
	for fid, v in pairs(JY.Force) do
		if v["״̬"] > 0 then
      if v["ս��"] == 0 then  --ս����� ���� �޷����
        --������ս��
        local capital = JY.City[v["����"]];
        local leader = v["����"];
        --ս��code: 0,����  1,ͳһ��ԭ  2,ͳһ�ط�  3,ͳһ��   4,ά����״  5,��������  6,ӵ������
        local cityNum = 0;
        local atkCity = {};
        local atkZhou = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}; --���� ���� ���� ���� ���� ���� ԥ�� ˾�� ���� Ӻ�� ���� ���� ���� ���� ���� ����
        local atkArea = {0, 0, 0, 0, 0, 0, 0, 0}; --�ӱ� ��ԭ ���� ���� �G�� ��Խ
        for i = 1, JY.ConnectionNum - 1 do  --��ȡ�ɹ��������б�, ���������Ȼ������
          local cid, eid = JY.Connection[i]["����1"], JY.Connection[i]["����2"];
          if JY.City[cid]["����"] == fid and JY.City[eid]["����"] ~= fid and (not atkCity[eid]) then
            atkCity[eid] = true;
            local c = JY.City[eid];
            local zhou = c["��"];
            local area = c["�ط�"];
            local pt = 100;
            pt = pt + limitX(c["�˿�"], 500, 10000) / 100 + c["��ģ"] * 10;    --�˿� 500-10000 => 5-100 ��ģ 1-4 => 10-40
            if c["����"] == 0 then  --�ճ�
              pt = pt + 100;
            else
              pt = pt * limitX(1 - c["����"] / 10000 - c["����"] / 200000, 0.1, 1); --���� 0-2000 => 0-0.2 ���� 0-200000 => 0-1
              --�⽻
              if false then
                pt = pt * 1;
              end
            end
            if atkZhou[zhou] < pt then
              atkZhou[zhou] = pt;
            end
            if atkArea[area] < pt then
              atkArea[area] = pt;
            end
          end
        end
        --����������������/�ط�, pt����
        if atkZhou[capital["��"]] > 0 then
          atkZhou[capital["��"]] = atkZhou[capital["��"]] + 50;
          atkArea[capital["�ط�"]] = atkArea[capital["�ط�"]] + 50;
        end
        --����������ϵ����pt
        if fid == 1 or leader == 334 then --�ܲ�
          --���� ���� ԥ�� ��ԭ > �ӱ� > ���� > ��Խ > ���� > ����
          if atkZhou[6] > 0 then atkZhou[6] = atkZhou[6] + 100 end
          if atkZhou[5] > 0 then atkZhou[5] = atkZhou[5] + 50 end
          if atkZhou[7] > 0 then atkZhou[7] = atkZhou[7] + 30 end
          if atkArea[2] > 0 then atkArea[2] = atkArea[2] + 100 end
          if atkArea[1] > 0 then atkArea[1] = atkArea[1] + 80 end
          if atkArea[6] > 0 then atkArea[6] = atkArea[6] + 50 end
          if atkArea[3] > 0 then atkArea[3] = atkArea[3] + 30 end
        elseif fid == 2 or leader == 611 then --����
          --���� > ���� > ��ԭ
          if atkArea[4] > 0 then atkArea[4] = atkArea[4] + 100 end
          if atkArea[5] > 0 then atkArea[5] = atkArea[5] + 80 end
          if atkArea[2] > 0 then atkArea[2] = atkArea[2] + 50 end
        elseif leader == 356 or leader == 360 then --���/��
          --���� ����   ��Խ > ��ԭ > ����
          if atkZhou[16] > 0 then atkZhou[16] = atkZhou[16] + 100 end
          if atkZhou[9] > 0 then atkZhou[9] = atkZhou[9] + 80 end
          if atkArea[6] > 0 then atkArea[6] = atkArea[6] + 100 end
          if atkArea[2] > 0 then atkArea[2] = atkArea[2] + 80 end
          if atkArea[5] > 0 then atkArea[5] = atkArea[5] + 50 end
        elseif fid == 3 or leader == 357 then --��Ȩ
          --���� ����   ��Խ > ����
          if atkZhou[16] > 0 then atkZhou[16] = atkZhou[16] + 100 end
          if atkZhou[9] > 0 then atkZhou[9] = atkZhou[9] + 50 end
          if atkArea[6] > 0 then atkArea[6] = atkArea[6] + 100 end
          if atkArea[5] > 0 then atkArea[5] = atkArea[5] + 50 end
        elseif fid == 4 or leader == 19 then --Ԭ��
          --�����������ݲ��� �ӱ� > ��ԭ > ���� > ����
          if atkZhou[2] > 0 then atkZhou[2] = atkZhou[2] + 80 end
          if atkZhou[3] > 0 then atkZhou[3] = atkZhou[3] + 80 end
          if atkZhou[1] > 0 then atkZhou[1] = atkZhou[1] + 80 end
          if atkZhou[4] > 0 then atkZhou[4] = atkZhou[4] + 80 end
          if atkArea[1] > 0 then atkArea[1] = atkArea[1] + 80 end
          if atkArea[2] > 0 then atkArea[2] = atkArea[2] + 50 end
          if atkArea[3] > 0 then atkArea[3] = atkArea[3] + 30 end
        elseif fid == 5 or leader == 17 then --Ԭ��
          --���� ԥ�� ����
          if atkZhou[9] > 0 then atkZhou[9] = atkZhou[9] + 80 end
          if atkZhou[7] > 0 then atkZhou[7] = atkZhou[7] + 50 end
          if atkZhou[16] > 0 then atkZhou[16] = atkZhou[16] + 30 end
        elseif fid == 6 or leader == 481 then --��׿
          --Ӻ�� ˾�� ����
          if atkZhou[10] > 0 then atkZhou[10] = atkZhou[10] + 100 end
          if atkZhou[8] > 0 then atkZhou[8] = atkZhou[8] + 50 end
          if atkZhou[11] > 0 then atkZhou[11] = atkZhou[11] + 30 end
        elseif fid == 7 or leader == 636 then --����
          --Ӻ�� ���� ���� ����
          if atkZhou[10] > 0 then atkZhou[10] = atkZhou[10] + 80 end
          if atkZhou[4] > 0 then atkZhou[4] = atkZhou[4] + 80 end
          if atkZhou[5] > 0 then atkZhou[5] = atkZhou[5] + 80 end
          if atkZhou[6] > 0 then atkZhou[6] = atkZhou[6] + 80 end
        elseif fid == 8 or leader == 612 then --����
          --���� ���� ����
          if atkZhou[14] > 0 then atkZhou[14] = atkZhou[14] + 80 end
          if atkZhou[15] > 0 then atkZhou[15] = atkZhou[15] + 50 end
          if atkZhou[16] > 0 then atkZhou[16] = atkZhou[16] + 30 end
        elseif fid == 9 or leader == 601 then --���
          --����
          if atkZhou[12] > 0 then atkZhou[12] = atkZhou[12] + 30 end
        elseif fid == 10 or leader == 175 then --�����
          --���� ����
          if atkZhou[1] > 0 then atkZhou[1] = atkZhou[1] + 100 end
          if atkZhou[2] > 0 then atkZhou[2] = atkZhou[2] + 50 end
          if atkArea[1] > 0 then atkArea[1] = atkArea[1] + 80 end
        elseif fid == 13 or leader == 501 or leader == 499 then --����/��
          --���� Ӻ��
          if atkZhou[11] > 0 then atkZhou[11] = atkZhou[11] + 100 end
          if atkZhou[10] > 0 then atkZhou[10] = atkZhou[10] + 50 end
          if atkArea[3] > 0 then atkArea[3] = atkArea[3] + 80 end
        elseif fid == 16 or leader == 429 then --��³
          --����
          if atkZhou[12] > 0 then atkZhou[12] = atkZhou[12] + 30 end
        elseif fid == 32 or leader == 549 then --�ϻ�
          --���� ����
          if atkZhou[13] > 0 then atkZhou[13] = atkZhou[13] + 100 end
          if atkZhou[12] > 0 then atkZhou[12] = atkZhou[12] + 50 end
          if atkArea[4] > 0 then atkArea[4] = atkArea[4] + 80 end
        elseif fid == 33 or leader == 389 then --�Ž�
          --˾�� ���� ���� ����
          if atkZhou[8] > 0 then atkZhou[8] = atkZhou[8] + 50 end
          if atkZhou[1] > 0 then atkZhou[1] = atkZhou[1] + 50 end
          if atkZhou[3] > 0 then atkZhou[3] = atkZhou[3] + 50 end
          if atkZhou[6] > 0 then atkZhou[6] = atkZhou[6] + 50 end
        elseif fid == 35 or leader == 221 then --˾��ܲ
          --˾�� ��ԭ �ӱ� ���� ��Խ
          if atkZhou[8] > 0 then atkZhou[8] = atkZhou[8] + 50 end
          if atkArea[2] > 0 then atkArea[2] = atkArea[2] + 100 end
          if atkArea[1] > 0 then atkArea[1] = atkArea[1] + 80 end
          if atkArea[4] > 0 then atkArea[4] = atkArea[4] + 50 end
          if atkArea[6] > 0 then atkArea[6] = atkArea[6] + 30 end
        end
        
        v["ս��"] = 4;  --ά����״
        if false then --��Ϸ��ʼ��������
          v["ս��"] = 4;  --ά����״
        elseif v["�ǳ�"] > 24 then --�����㹻ǿ��
          v["ս��"] = 1;  --ͳһ��ԭ
        elseif false then --
          v["ս��"] = 6;  --ӵ������
        elseif v["�ǳ�"] > 9 then --����ǿ��
          v["ս��"] = 2;  --ͳһ�ط�
        elseif true then --����ǿ��
          local target = 0;
          local ptMax = 0;
          for i, v in ipairs(atkZhou) do
            if v > ptMax then
              ptMax = v;
              target = i;
            end
          end
          if target > 0 then
            v["ս��"] = 3;  --ͳһ��
            v["Ŀ��"] = target;
          end
        elseif false then --
          v["ս��"] = 5;  --�����ն�����
        else
          v["ս��"] = 4;  --ά����״
        end
      else
        
      end
      AI_ForceChief(fid);
		end
	end
  
end
function AI_ForceChief(fid)
  --[[fid = 2;
	for pid = 0, 750 do
		if JY.Person[pid]["����"] == fid and JY.Person[pid]["����"] ~= 47 then
			JY.Person[pid]["����"] = 47;
      if JY.Person[pid]["���"] == 2 then
        JY.Person[pid]["���"] = 1;
      end
		end
	end]]--
  
  local function setCityChief(cid)
    local c = JY.City[cid];
    local pid = 0;
    local ptMax = 0;
    for i = 0, 750 do
      local p = JY.Person[i];
      if p["����"] == fid and p["���"] == 1 then
        --local pt = p["����"] + (p["ͳ��"] * c["ս�Լ�ֵ"] + p["����"] * c["���Լ�ֵ"]) / (c["ս�Լ�ֵ"] + c["���Լ�ֵ"]);
        local pt = (p["ͳ��"] * c["ս�Լ�ֵ"] + p["����"] * c["���Լ�ֵ"]) / (c["ս�Լ�ֵ"] + c["���Լ�ֵ"]);
        if p["�ҳ�"] < 90 then
          pt = pt / 4;
        elseif p["�ҳ�"] < 95 then
          pt = pt / 2;
        end
        
        if pt > ptMax then
          ptMax = pt;
          pid = i;
        end
      end
    end
    if pid > 0 then
      JY.Person[pid]["����"] = cid;
      JY.Person[pid]["���"] = 2;
      JY.City[cid]["̫��"] = pid;
      return true;
    else
      return false;
    end
  end
  local function adjustForceGenerals(fid)
    local clist = {};
    local cityGeneralsNum = {};
    local plist = {};
    for i = 1, JY.CityNum - 1 do
      if JY.City[i]["����"] == fid then
        table.insert(clist, i);
        cityGeneralsNum[i] = 2;
      end
    end
    for i = 0, 750 do
      local p = JY.Person[i];
      if p["����"] == fid and p["���"] == 1 then
        table.insert(plist, i);
      end
    end
    table.sort(plist, function(a, b)
      if JY.Person[a]["Ʒ��"] > JY.Person[b]["Ʒ��"] then
        return true;
      end
    end)
    for i, pid in ipairs(plist) do
      local id = 0;
      local ptMax = 0;
      local p = JY.Person[pid];
      for j, cid in ipairs(clist) do
        local c = JY.City[cid];
        local pt = (p["����"] * c["ս�Լ�ֵ"] + p["����"] * c["���Լ�ֵ"]) / (c["ս�Լ�ֵ"] + c["���Լ�ֵ"]) / cityGeneralsNum[cid];   -- / (c["ս�Լ�ֵ"] + c["���Լ�ֵ"]);
        if c["ǰ��"] > 0 then
          pt = pt * 2;
        end
        if isHate(c["̫��"], pid) then
          pt = pt / 2;
        elseif isLike(c["̫��"], pid) then
          pt = pt * 2;
        end
        if pt > ptMax then
          ptMax = pt;
          id = cid;
        end
      end
      if id > 0 then
        JY.Person[pid]["����"] = id;
        cityGeneralsNum[id] = cityGeneralsNum[id] + 1;
      end
    end
  end
  for i = 1, JY.CityNum - 1 do
    if JY.City[i]["����"] == fid and JY.City[i]["̫��"] == 0 then
      setCityChief(i);
    end
  end
  adjustForceGenerals(fid);
  
  --[[
    --����̫��
      ���ڿճ�
        �ж�����,ս�� ���� ����
        �ҳ����еķ�̫���佫, ����(����ս�Ի�������)
        ѡ��������ߵ���Ϊ̫��
    --��������
      ������Ͻ�ĳ��н�������, ս�Լ�ֵ �� ���Լ�ֵ
      ����,����ս�Լ�ֵ,������Լ�ֵ
      ���������佫��, ������, ��ֵ, �жϸ������е��佫����
      ɸѡ��̫��������佫, ���ڷ���
      ��һ���ȼ�, ����������, ��̫�������ϵ��佫, ѪԵ/����/־Ȥ
      �ڶ����ȼ�, ������������е�ս��/���Լ�ֵ,���������
    --һ������ô�������
      ���������³ǳ� => �ж��¾ɳ��е�ս�Լ�ֵ, ѡ��ߵĽ�פ; ���Ƕ���˿ճ�
      �ǳر��� => �ص�������; ����Ǿ������б���, �ƶ�����? û���Ǻ�
      �ǳ�ս��/���Լ�ֵ�䶯, ��Ҫ���·���̫�ص� => ����review�Ƿ��и��õķ�̫���佫, �����ֱ����������̫��120%
  ]]
end 
function AI_City()
  AI_Force();
	for cid = 1, JY.CityNum - 1 do
		if JY.City[cid]["̫��"] > 0 then
      local fid = JY.City[cid]["����"]
      local clist = {cid};
      local prob = {100};
      for i, v in pairs(JY.CityToCity[cid]) do
        local c = JY.City[i];
        if c["����"] ~= fid then
          table.insert(clist, i);
          local pt = (JY.City[cid]["����"] + 5000) / (c["����"] + 5000);
          table.insert(prob, pt);
        end
      end
      local r = PercentRandom(prob);
      if r == 1 then
        AI_City_Sub(cid);
      else
        local eid = clist[r];
				Talk("����",string.format("[Green]%s[Normal]���ˣ�[Red]%s[Normal]��[Red]%s[Normal]��[Red]%s[Normal]�����˽�����",JY.Person[JY.PID]["����"], JY.Force[fid]["����"], JY.City[cid]["����"], JY.City[eid]["����"]));
        local eForce = JY.City[eid]["����"];
        if eForce > 0 then
          WarIni();
          War.ArmyA1 = AutoSelectArmy(cid);
          War.ArmyB1 = AutoSelectArmy(eid);
          local warResult = LLK_III_Main(JY.CityToCity[cid][eid]); --skipWar(JY.CityToCity[cid][eid]);
          if warResult ~= 2 then  -- not win
            break;
          end
        end
        occupyCity(fid, eid);
      end
		end
	end
end
--����ҳ϶�=sqrt(��������)*sqrt(��Ǯ)/sqrt(0x11-|0x4B-���Բ�ֵ|/5)
function AI_City_Sub(cid)
  local c = JY.City[cid];
	local plist=GetCityWujiang(cid);--,{JY.PID});
	local costs={	20, 0, 5, 0, 0,	0, 0, 0, 0, 0,	--	1 ļ��;	2 ѵ��;	3 ����;	
					5, 5, 5, 5, 0,	0, 0, 0, 0, 0,	--	11 ����;	12 ��ҵ;	13 ����;	14 �ΰ�;
					0, 0, 0, 0, 0,		0, 0, 0, 0, 0,
					0, 0, 0, 0, 0,		0, 0, 0, 0, 0,}
	local tasks={};
	local task=0;
	local function QueryTasks()
		tasks={	100, 0, 100, 0, 0,	0, 0, 0, 0, 0,	--	1 ļ��;	2 ѵ��;	3 ����;	
            100, 100, 100, 100, 0,	0, 0, 0, 0, 0,	--	11 ����;	12 ��ҵ;	13 ����;	14 �ΰ�;
            0, 0, 0, 0, 0,	0, 0, 0, 0, 0,
            0, 0, 0, 0, 0,	0, 0, 0, 0, 0,}
    --ļ����� ���й�ģ/ǰ��/����/��ǰ����
    if c["����"] >= 50000 * c["��ģ"] then
      tasks[1] = 0;
    else
      tasks[1] = tasks[1] * limitX(c["����"] / (24 * math.ceil(c["����"] / 500)) - 0.5, 0, 5);  --����
      tasks[1] = tasks[1] * limitX(c["�˿�"] / 2000, 0, 1); --�˿�
    end
    --������� ǰ��/��ǰ�Ƿ�
    tasks[3] = math.floor(tasks[3] * limitX((c["������"] - c["����"]) / c["������"], 0.1, 1));
    if false then --ǰ��
      tasks[3] = tasks[3] * 10;
    end
    --������� ������֧/��ǰ����
    if between(JY.Base["��ǰ��"], 1, 6) then
      tasks[11] = tasks[11] * 2;
    end
    if c["��󿪿�"] > c["����"] then
      tasks[11] = math.floor(tasks[11] * limitX((c["��󿪿�"] - c["����"]) / c["��󿪿�"], 0.1, 1));
    else
      tasks[11] = 0;
    end
    --��ҵ��� �ʽ���֧/��ǰ��ҵ
    if between(JY.Base["��ǰ��"], 7, 12) then
      tasks[12] = tasks[12] * 2;
    end
    if c["�����ҵ"] > c["��ҵ"] then
      tasks[12] = math.floor(tasks[12] * limitX((c["�����ҵ"] - c["��ҵ"]) / c["�����ҵ"], 0.1, 1));
    else
      tasks[12] = 0;
    end
    --������� 
    if c["�����"] > c["����"] then
      tasks[13] = math.floor(tasks[12] * limitX((c["�����"] - c["����"]) / c["�����"], 0.1, 1));
    else
      tasks[13] = 0;
    end
    --�ΰ���� ��ǰ�ΰ�
    if 1000 > c["�ΰ�"] then
      tasks[14] = math.floor(tasks[14] * limitX((1000 - c["�ΰ�"]) / 100, 0.1, 10));
    else
      tasks[14] = 0;
    end
    
		for i=1, #tasks do  --�ʽ���ģ�����Ϊ0
			if c["�ʽ�"] < costs[i] then
				tasks[i] = 0;
			end
		end
		task=PercentRandom(tasks);
		if task>0 and #plist>1 then
			if task==1 then			--ļ��
				table.sort(plist,	function(a,b)
										return JY.Person[a]["����"]>JY.Person[b]["����"];
									end)
			elseif task==2 then		--ѵ��
				table.sort(plist,	function(a,b)
										return JY.Person[a]["ͳ��"]>JY.Person[b]["ͳ��"];
									end)
			elseif task==3 then		--�޲�
				table.sort(plist,	function(a,b)
										return JY.Person[a]["����"]+JY.Person[a]["ͳ��"]>JY.Person[b]["����"]+JY.Person[b]["ͳ��"];
									end)
			elseif task==11 then	--����
				table.sort(plist,	function(a,b)
										return JY.Person[a]["����"]>JY.Person[b]["����"];
									end)
			elseif task==12 then	--��ҵ
				table.sort(plist,	function(a,b)
										return JY.Person[a]["����"]>JY.Person[b]["����"];
									end)
			elseif task==13 then	--����
				table.sort(plist,	function(a,b)
										return JY.Person[a]["��ı"]>JY.Person[b]["��ı"];
									end)
			elseif task==14 then	--�ΰ�
				table.sort(plist,	function(a,b)
										return JY.Person[a]["����"]>JY.Person[b]["����"];
									end)
			else
			
			end
		end
	end
	local function ExecuteTask()
		if task>0 and #plist>0 then
			local pid=plist[1];
			table.remove(plist,1);
			if c["�ʽ�"]>=costs[task] then
				if pid~=JY.PID then
					c["�ʽ�"]=c["�ʽ�"]-costs[task];
					CityDevelop(cid,pid,task);
				else
					local pid2=c["̫��"];
					local str;
					if task==1 then			--ļ��
						str=JY.Str[15300];
					elseif task==3 then		--�޲�
						str=JY.Str[math.random(15310,15311)];
					elseif task==11 then	--����
						str=JY.Str[math.random(15350,15351)];
					elseif task==12 then	--��ҵ
						str=JY.Str[math.random(15355,15356)];
					elseif task==13 then	--����
						str=JY.Str[15360];
					elseif task==14 then	--�ΰ�
						str=JY.Str[15365];
					else
						str="";
					end
					str=string.gsub(str,"s1","[Green]"..JY.Person[pid]["����"].."[Normal]");
					Talk(pid2,str);
					str=JY.Str[15499];
					str=string.gsub(str,"s1","[Green]"..JY.Person[pid2]["����"].."[Normal]");
					if task==1 then
						str=string.gsub(str,"s2","[Green]ļ��[Normal]");
					elseif task==3 then
						str=string.gsub(str,"s2","[Green]�޲�[Normal]");
					elseif task==11 then
						str=string.gsub(str,"s2","[Green]����[Normal]");
					elseif task==12 then
						str=string.gsub(str,"s2","[Green]��ҵ[Normal]");
					elseif task==13 then
						str=string.gsub(str,"s2","[Green]����[Normal]");
					elseif task==14 then
						str=string.gsub(str,"s2","[Green]�ΰ�[Normal]");
					end
					if TalkYesNo(JY.PID,str) then
						DrawGame();
						str=JY.Str[math.random(15500,15503)];
						Talk(JY.PID,str);
						--local add;
						--add,str=
						CityDevelop(cid,JY.PID,task);
						--if add>0 then
						--	DrawMulitStrBox(str);
						--end
					else
						DrawGame();
						str=JY.Str[math.random(15510,15513)];
						Talk(JY.PID,str);
						str=JY.Str[math.random(15520,15522)];
						Talk(pid2,str);
					end
				end
			end
		end
	end
	--��������̬�ȣ����˵�һ�����佫
	local pnum=#plist;
	for i=pnum,1,-1 do
		local pid=plist[i];
		local ratio=0.50;
		if JY.Person[pid]["����"]>10 then			--����
			ratio=0.90;
		elseif JY.Person[pid]["����̬��"]==1 then	--����
			ratio=0.50;
		elseif JY.Person[pid]["����̬��"]==2 then	--�ʵ�
			ratio=0.30;
		elseif JY.Person[pid]["����̬��"]==3 then	--��ͨ
			ratio=0.15;
		elseif JY.Person[pid]["����̬��"]==4 then	--Ŭ��
			ratio=0.05;
		end
		if math.random()<ratio then
			table.remove(plist,i);
		end
	end
	pnum=#plist;
	if pnum==0 then		--���˺���û����...
		return false;
	end
	for i=1,math.min(pnum,10) do	--��������������������
		QueryTasks();	--��ȡ����
		ExecuteTask();	--ִ������
	end
end
function CityDevelop(cid,pid,task)
	local c=JY.City[cid];
	local p=JY.Person[pid];
	local old,new,str,str2;
	if task==1 then			--ļ��
		old=math.floor(c["����"]);
    local value = 1;
    if c["�˿�"] > 1000 then
      value = 1 + limitX((c["�˿�"] - 1000) / 10000, 0, 1);
    else
      value = limitX((c["�˿�"] - 400) / 600, 0, 1);
    end
    value = math.floor(20 * ValueAdjust(p["����"], 100) * value);
		c["����"]=limitX(c["����"] + value, 0, c["��ģ"] * 50000);
    c["�˿�"] = limitX(c["�˿�"] - math.ceil(value / 100), 400, 30000);
    c["�ΰ�"] = limitX(c["�ΰ�"] - 100 - math.random(50), 0, 1000);
		new=math.floor(c["����"]);
		str2="����";
	elseif task==2 then		--ѵ��
		old,new=0,0;
		str2="����";
	elseif task==3 then		--�޲�
		old=math.floor(c["����"]/2);
		c["����"]=limitX(c["����"]+ValueAdjust(p["ͳ��"]*0.5+p["����"]*0.5,100)/10,0,c["������"]);
    c["�ΰ�"] = limitX(c["�ΰ�"] - 1 - math.random(10), 0, 1000);
		new=math.floor(c["����"]/2);
		str2="����";
	elseif task==11 then	--����
		old=math.floor(c["����"]/2);
		c["����"]=limitX(c["����"]+ValueAdjust(p["����"]*0.7+p["����"]*0.3,100)/10,0,c["��󿪿�"]);
    c["�ΰ�"] = limitX(c["�ΰ�"] - 1 - math.random(10), 0, 1000);
		new=math.floor(c["����"]/2);
		str2="����";
	elseif task==12 then	--��ҵ
		old=math.floor(c["��ҵ"]/2);
		c["��ҵ"]=limitX(c["��ҵ"]+ValueAdjust(p["����"]*0.7+p["��ı"]*0.3,100)/10,0,c["�����ҵ"]);
    c["�ΰ�"] = limitX(c["�ΰ�"] - 1 - math.random(10), 0, 1000);
		new=math.floor(c["��ҵ"]/2);
		str2="��ҵ";
	elseif task==13 then	--����
		old=math.floor(c["����"]/2);
		c["����"]=limitX(c["����"]+ValueAdjust(p["��ı"]*0.7+p["����"]*0.3,100)/10,0,c["�����"]);
    c["�ΰ�"] = limitX(c["�ΰ�"] - 1 - math.random(10), 0, 1000);
		new=math.floor(c["����"]/2);
		str2="����";
	elseif task==14 then	--�ΰ�
		old=math.floor(c["�ΰ�"]/10);
		c["�ΰ�"]=limitX(c["�ΰ�"]+ValueAdjust(p["����"]*0.7+p["��ı"]*0.3,100)/5,0,1000);
		new=math.floor(c["�ΰ�"]/10);
		str2="�ΰ�";
	else
		old,new=0,0;
	end
	if pid==JY.PID then
		local pic=1000;
		if task==1 then
			str=JY.Str[math.random(15500,15503)];
		elseif task==3 then
			pic=1046;
			str=JY.Str[math.random(15410,15411)];
		elseif task==11 then
			pic=1056;
			str=JY.Str[math.random(15450,15451)];
		elseif task==12 then
			pic=1057;
			str=JY.Str[15455];
		elseif task==13 then
			pic=1058;
			str=JY.Str[math.random(15460,15461)];
		elseif task==14 then
			pic=1058;
			str=JY.Str[math.random(15465,15466)];
		end
		--LoadPic(pic,1);
		--pic=500;
		--for i=0,7*8 do
		--	DrawGame();
		--	lib.PicLoadCache(4,(pic+i%8)*2,CC.ScreenW/2,CC.ScreenH/2);
		--	ShowScreen();
		--	lib.Delay(100);
		--	getkey();
		--end
		DrawGame();
		Talk(pid,str);
		--LoadPic(pic,2);
		DrawMulitStrBox(string.format("[name]%s[normal]�� %3d  �� %3d (%+d)",str2,old,new,new-old));
	end
end