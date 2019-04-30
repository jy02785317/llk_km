--[[
势力AI  - 决定城市AI类型
  - 势力AI分为 待定 政略 军备  攻击城市  统一州 击败势力  等
城市AI  - 决定 内政 / 战争
  - 根据长期目标, 决定当月AI
    - 长期目标分为: 委任  政略  军备  攻击XX
  - 当月AI, 首先判断是否进行战争
    - 战争  决定攻击目标
    - 内政  自动分配属下任务





]]--
function AI_Force()
	for fid, v in pairs(JY.Force) do
		if v["状态"] > 0 then
      if v["战略"] == 0 then  --战略完成 或者 无法达成
        --生成新战略
        local capital = JY.City[v["本城"]];
        local leader = v["君主"];
        --战略code: 0,待定  1,统一中原  2,统一地方  3,统一州   4,维持现状  5,击破势力  6,拥立汉帝
        local cityNum = 0;
        local atkCity = {};
        local atkZhou = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}; --幽州 冀州 青州 并州 徐州 兖州 豫州 司隶 淮南 雍州 凉州 益州 南中 荆北 荆南 扬州
        local atkArea = {0, 0, 0, 0, 0, 0, 0, 0}; --河北 中原 西北 巴蜀 荊楚 吴越
        for i = 1, JY.ConnectionNum - 1 do  --获取可攻击城市列表, 这个方法显然不够好
          local cid, eid = JY.Connection[i]["都市1"], JY.Connection[i]["都市2"];
          if JY.City[cid]["势力"] == fid and JY.City[eid]["势力"] ~= fid and (not atkCity[eid]) then
            atkCity[eid] = true;
            local c = JY.City[eid];
            local zhou = c["州"];
            local area = c["地方"];
            local pt = 100;
            pt = pt + limitX(c["人口"], 500, 10000) / 100 + c["规模"] * 10;    --人口 500-10000 => 5-100 规模 1-4 => 10-40
            if c["势力"] == 0 then  --空城
              pt = pt + 100;
            else
              pt = pt * limitX(1 - c["防御"] / 10000 - c["兵力"] / 200000, 0.1, 1); --防御 0-2000 => 0-0.2 兵力 0-200000 => 0-1
              --外交
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
        --自势力都城所在州/地方, pt上升
        if atkZhou[capital["州"]] > 0 then
          atkZhou[capital["州"]] = atkZhou[capital["州"]] + 50;
          atkArea[capital["地方"]] = atkArea[capital["地方"]] + 50;
        end
        --依据势力关系调整pt
        if fid == 1 or leader == 334 then --曹操
          --兖州 徐州 豫州 中原 > 河北 > 荆楚 > 吴越 > 西北 > 巴蜀
          if atkZhou[6] > 0 then atkZhou[6] = atkZhou[6] + 100 end
          if atkZhou[5] > 0 then atkZhou[5] = atkZhou[5] + 50 end
          if atkZhou[7] > 0 then atkZhou[7] = atkZhou[7] + 30 end
          if atkArea[2] > 0 then atkArea[2] = atkArea[2] + 100 end
          if atkArea[1] > 0 then atkArea[1] = atkArea[1] + 80 end
          if atkArea[6] > 0 then atkArea[6] = atkArea[6] + 50 end
          if atkArea[3] > 0 then atkArea[3] = atkArea[3] + 30 end
        elseif fid == 2 or leader == 611 then --刘备
          --巴蜀 > 荆楚 > 中原
          if atkArea[4] > 0 then atkArea[4] = atkArea[4] + 100 end
          if atkArea[5] > 0 then atkArea[5] = atkArea[5] + 80 end
          if atkArea[2] > 0 then atkArea[2] = atkArea[2] + 50 end
        elseif leader == 356 or leader == 360 then --孙坚/策
          --扬州 淮南   吴越 > 中原 > 荆楚
          if atkZhou[16] > 0 then atkZhou[16] = atkZhou[16] + 100 end
          if atkZhou[9] > 0 then atkZhou[9] = atkZhou[9] + 80 end
          if atkArea[6] > 0 then atkArea[6] = atkArea[6] + 100 end
          if atkArea[2] > 0 then atkArea[2] = atkArea[2] + 80 end
          if atkArea[5] > 0 then atkArea[5] = atkArea[5] + 50 end
        elseif fid == 3 or leader == 357 then --孙权
          --扬州 淮南   吴越 > 荆楚
          if atkZhou[16] > 0 then atkZhou[16] = atkZhou[16] + 100 end
          if atkZhou[9] > 0 then atkZhou[9] = atkZhou[9] + 50 end
          if atkArea[6] > 0 then atkArea[6] = atkArea[6] + 100 end
          if atkArea[5] > 0 then atkArea[5] = atkArea[5] + 50 end
        elseif fid == 4 or leader == 19 then --袁绍
          --冀州青州幽州并州 河北 > 中原 > 西北 > 荆楚
          if atkZhou[2] > 0 then atkZhou[2] = atkZhou[2] + 80 end
          if atkZhou[3] > 0 then atkZhou[3] = atkZhou[3] + 80 end
          if atkZhou[1] > 0 then atkZhou[1] = atkZhou[1] + 80 end
          if atkZhou[4] > 0 then atkZhou[4] = atkZhou[4] + 80 end
          if atkArea[1] > 0 then atkArea[1] = atkArea[1] + 80 end
          if atkArea[2] > 0 then atkArea[2] = atkArea[2] + 50 end
          if atkArea[3] > 0 then atkArea[3] = atkArea[3] + 30 end
        elseif fid == 5 or leader == 17 then --袁术
          --淮南 豫州 扬州
          if atkZhou[9] > 0 then atkZhou[9] = atkZhou[9] + 80 end
          if atkZhou[7] > 0 then atkZhou[7] = atkZhou[7] + 50 end
          if atkZhou[16] > 0 then atkZhou[16] = atkZhou[16] + 30 end
        elseif fid == 6 or leader == 481 then --董卓
          --雍州 司隶 凉州
          if atkZhou[10] > 0 then atkZhou[10] = atkZhou[10] + 100 end
          if atkZhou[8] > 0 then atkZhou[8] = atkZhou[8] + 50 end
          if atkZhou[11] > 0 then atkZhou[11] = atkZhou[11] + 30 end
        elseif fid == 7 or leader == 636 then --吕布
          --雍州 并州 徐州 兖州
          if atkZhou[10] > 0 then atkZhou[10] = atkZhou[10] + 80 end
          if atkZhou[4] > 0 then atkZhou[4] = atkZhou[4] + 80 end
          if atkZhou[5] > 0 then atkZhou[5] = atkZhou[5] + 80 end
          if atkZhou[6] > 0 then atkZhou[6] = atkZhou[6] + 80 end
        elseif fid == 8 or leader == 612 then --刘表
          --荆北 荆南 扬州
          if atkZhou[14] > 0 then atkZhou[14] = atkZhou[14] + 80 end
          if atkZhou[15] > 0 then atkZhou[15] = atkZhou[15] + 50 end
          if atkZhou[16] > 0 then atkZhou[16] = atkZhou[16] + 30 end
        elseif fid == 9 or leader == 601 then --刘璋
          --益州
          if atkZhou[12] > 0 then atkZhou[12] = atkZhou[12] + 30 end
        elseif fid == 10 or leader == 175 then --公孙瓒
          --幽州 冀州
          if atkZhou[1] > 0 then atkZhou[1] = atkZhou[1] + 100 end
          if atkZhou[2] > 0 then atkZhou[2] = atkZhou[2] + 50 end
          if atkArea[1] > 0 then atkArea[1] = atkArea[1] + 80 end
        elseif fid == 13 or leader == 501 or leader == 499 then --马腾/马超
          --凉州 雍州
          if atkZhou[11] > 0 then atkZhou[11] = atkZhou[11] + 100 end
          if atkZhou[10] > 0 then atkZhou[10] = atkZhou[10] + 50 end
          if atkArea[3] > 0 then atkArea[3] = atkArea[3] + 80 end
        elseif fid == 16 or leader == 429 then --张鲁
          --益州
          if atkZhou[12] > 0 then atkZhou[12] = atkZhou[12] + 30 end
        elseif fid == 32 or leader == 549 then --孟获
          --南中 益州
          if atkZhou[13] > 0 then atkZhou[13] = atkZhou[13] + 100 end
          if atkZhou[12] > 0 then atkZhou[12] = atkZhou[12] + 50 end
          if atkArea[4] > 0 then atkArea[4] = atkArea[4] + 80 end
        elseif fid == 33 or leader == 389 then --张角
          --司隶 冀州 青州 兖州
          if atkZhou[8] > 0 then atkZhou[8] = atkZhou[8] + 50 end
          if atkZhou[1] > 0 then atkZhou[1] = atkZhou[1] + 50 end
          if atkZhou[3] > 0 then atkZhou[3] = atkZhou[3] + 50 end
          if atkZhou[6] > 0 then atkZhou[6] = atkZhou[6] + 50 end
        elseif fid == 35 or leader == 221 then --司马懿
          --司隶 中原 河北 巴蜀 吴越
          if atkZhou[8] > 0 then atkZhou[8] = atkZhou[8] + 50 end
          if atkArea[2] > 0 then atkArea[2] = atkArea[2] + 100 end
          if atkArea[1] > 0 then atkArea[1] = atkArea[1] + 80 end
          if atkArea[4] > 0 then atkArea[4] = atkArea[4] + 50 end
          if atkArea[6] > 0 then atkArea[6] = atkArea[6] + 30 end
        end
        
        v["战略"] = 4;  --维持现状
        if false then --游戏开始六个月内
          v["战略"] = 4;  --维持现状
        elseif v["城池"] > 24 then --势力足够强大
          v["战略"] = 1;  --统一中原
        elseif false then --
          v["战略"] = 6;  --拥立汉帝
        elseif v["城池"] > 9 then --势力强大
          v["战略"] = 2;  --统一地方
        elseif true then --势力强大
          local target = 0;
          local ptMax = 0;
          for i, v in ipairs(atkZhou) do
            if v > ptMax then
              ptMax = v;
              target = i;
            end
          end
          if target > 0 then
            v["战略"] = 3;  --统一州
            v["目标"] = target;
          end
        elseif false then --
          v["战略"] = 5;  --击破险恶势力
        else
          v["战略"] = 4;  --维持现状
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
		if JY.Person[pid]["势力"] == fid and JY.Person[pid]["所在"] ~= 47 then
			JY.Person[pid]["所在"] = 47;
      if JY.Person[pid]["身份"] == 2 then
        JY.Person[pid]["身份"] = 1;
      end
		end
	end]]--
  
  local function setCityChief(cid)
    local c = JY.City[cid];
    local pid = 0;
    local ptMax = 0;
    for i = 0, 750 do
      local p = JY.Person[i];
      if p["势力"] == fid and p["身份"] == 1 then
        --local pt = p["魅力"] + (p["统率"] * c["战略价值"] + p["政务"] * c["政略价值"]) / (c["战略价值"] + c["政略价值"]);
        local pt = (p["统率"] * c["战略价值"] + p["魅力"] * c["政略价值"]) / (c["战略价值"] + c["政略价值"]);
        if p["忠诚"] < 90 then
          pt = pt / 4;
        elseif p["忠诚"] < 95 then
          pt = pt / 2;
        end
        
        if pt > ptMax then
          ptMax = pt;
          pid = i;
        end
      end
    end
    if pid > 0 then
      JY.Person[pid]["所在"] = cid;
      JY.Person[pid]["身份"] = 2;
      JY.City[cid]["太守"] = pid;
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
      if JY.City[i]["势力"] == fid then
        table.insert(clist, i);
        cityGeneralsNum[i] = 2;
      end
    end
    for i = 0, 750 do
      local p = JY.Person[i];
      if p["势力"] == fid and p["身份"] == 1 then
        table.insert(plist, i);
      end
    end
    table.sort(plist, function(a, b)
      if JY.Person[a]["品级"] > JY.Person[b]["品级"] then
        return true;
      end
    end)
    for i, pid in ipairs(plist) do
      local id = 0;
      local ptMax = 0;
      local p = JY.Person[pid];
      for j, cid in ipairs(clist) do
        local c = JY.City[cid];
        local pt = (p["武力"] * c["战略价值"] + p["政务"] * c["政略价值"]) / (c["战略价值"] + c["政略价值"]) / cityGeneralsNum[cid];   -- / (c["战略价值"] + c["政略价值"]);
        if c["前线"] > 0 then
          pt = pt * 2;
        end
        if isHate(c["太守"], pid) then
          pt = pt / 2;
        elseif isLike(c["太守"], pid) then
          pt = pt * 2;
        end
        if pt > ptMax then
          ptMax = pt;
          id = cid;
        end
      end
      if id > 0 then
        JY.Person[pid]["所在"] = id;
        cityGeneralsNum[id] = cityGeneralsNum[id] + 1;
      end
    end
  end
  for i = 1, JY.CityNum - 1 do
    if JY.City[i]["势力"] == fid and JY.City[i]["太守"] == 0 then
      setCityChief(i);
    end
  end
  adjustForceGenerals(fid);
  
  --[[
    --任命太守
      对于空城
        判断类型,战略 或者 政略
        找出所有的非太守武将, 评分(根据战略或者政略)
        选择评分最高的作为太守
    --分配人事
      给所管辖的城市进行评分, 战略价值 和 政略价值
      排序,优先战略价值,其次政略价值
      根据势力武将数, 城市数, 价值, 判断各个城市的武将数量
      筛选出太守以外的武将, 用于分配
      第一优先级, 分配少量的, 与太守最契合的武将, 血缘/相性/志趣
      第二优先级, 按照能力与城市的战略/政略价值,按次序分配
    --一般有这么几种情况
      攻打下了新城池 => 判断新旧城市的战略价值, 选择高的进驻; 于是多出了空城
      城池被夺 => 回到君主处; 如果是君主城市被夺, 移动到哪? 没考虑好
      城池战略/政略价值变动, 需要重新分配太守的 => 定期review是否有更好的非太守武将, 其评分必须高于现有太守120%
  ]]
end 
function AI_City()
  AI_Force();
	for cid = 1, JY.CityNum - 1 do
		if JY.City[cid]["太守"] > 0 then
      local fid = JY.City[cid]["势力"]
      local clist = {cid};
      local prob = {100};
      for i, v in pairs(JY.CityToCity[cid]) do
        local c = JY.City[i];
        if c["势力"] ~= fid then
          table.insert(clist, i);
          local pt = (JY.City[cid]["兵力"] + 5000) / (c["兵力"] + 5000);
          table.insert(prob, pt);
        end
      end
      local r = PercentRandom(prob);
      if r == 1 then
        AI_City_Sub(cid);
      else
        local eid = clist[r];
				Talk("傳令",string.format("[Green]%s[Normal]大人，[Red]%s[Normal]的[Red]%s[Normal]对[Red]%s[Normal]发起了进攻。",JY.Person[JY.PID]["名称"], JY.Force[fid]["名称"], JY.City[cid]["名称"], JY.City[eid]["名称"]));
        local eForce = JY.City[eid]["势力"];
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
--提高忠诚度=sqrt(君主魅力)*sqrt(金钱)/sqrt(0x11-|0x4B-相性差值|/5)
function AI_City_Sub(cid)
  local c = JY.City[cid];
	local plist=GetCityWujiang(cid);--,{JY.PID});
	local costs={	20, 0, 5, 0, 0,	0, 0, 0, 0, 0,	--	1 募兵;	2 训练;	3 修筑;	
					5, 5, 5, 5, 0,	0, 0, 0, 0, 0,	--	11 开垦;	12 商业;	13 技术;	14 治安;
					0, 0, 0, 0, 0,		0, 0, 0, 0, 0,
					0, 0, 0, 0, 0,		0, 0, 0, 0, 0,}
	local tasks={};
	local task=0;
	local function QueryTasks()
		tasks={	100, 0, 100, 0, 0,	0, 0, 0, 0, 0,	--	1 募兵;	2 训练;	3 修筑;	
            100, 100, 100, 100, 0,	0, 0, 0, 0, 0,	--	11 开垦;	12 商业;	13 技术;	14 治安;
            0, 0, 0, 0, 0,	0, 0, 0, 0, 0,
            0, 0, 0, 0, 0,	0, 0, 0, 0, 0,}
    --募兵相关 城市规模/前线/物资/当前兵力
    if c["兵力"] >= 50000 * c["规模"] then
      tasks[1] = 0;
    else
      tasks[1] = tasks[1] * limitX(c["物资"] / (24 * math.ceil(c["兵力"] / 500)) - 0.5, 0, 5);  --物资
      tasks[1] = tasks[1] * limitX(c["人口"] / 2000, 0, 1); --人口
    end
    --修筑相关 前线/当前城防
    tasks[3] = math.floor(tasks[3] * limitX((c["最大防御"] - c["防御"]) / c["最大防御"], 0.1, 1));
    if false then --前线
      tasks[3] = tasks[3] * 10;
    end
    --开垦相关 物资收支/当前开垦
    if between(JY.Base["当前月"], 1, 6) then
      tasks[11] = tasks[11] * 2;
    end
    if c["最大开垦"] > c["开垦"] then
      tasks[11] = math.floor(tasks[11] * limitX((c["最大开垦"] - c["开垦"]) / c["最大开垦"], 0.1, 1));
    else
      tasks[11] = 0;
    end
    --商业相关 资金收支/当前商业
    if between(JY.Base["当前月"], 7, 12) then
      tasks[12] = tasks[12] * 2;
    end
    if c["最大商业"] > c["商业"] then
      tasks[12] = math.floor(tasks[12] * limitX((c["最大商业"] - c["商业"]) / c["最大商业"], 0.1, 1));
    else
      tasks[12] = 0;
    end
    --技术相关 
    if c["最大技术"] > c["技术"] then
      tasks[13] = math.floor(tasks[12] * limitX((c["最大技术"] - c["技术"]) / c["最大技术"], 0.1, 1));
    else
      tasks[13] = 0;
    end
    --治安相关 当前治安
    if 1000 > c["治安"] then
      tasks[14] = math.floor(tasks[14] * limitX((1000 - c["治安"]) / 100, 0.1, 10));
    else
      tasks[14] = 0;
    end
    
		for i=1, #tasks do  --资金不足的，概率为0
			if c["资金"] < costs[i] then
				tasks[i] = 0;
			end
		end
		task=PercentRandom(tasks);
		if task>0 and #plist>1 then
			if task==1 then			--募兵
				table.sort(plist,	function(a,b)
										return JY.Person[a]["魅力"]>JY.Person[b]["魅力"];
									end)
			elseif task==2 then		--训练
				table.sort(plist,	function(a,b)
										return JY.Person[a]["统率"]>JY.Person[b]["统率"];
									end)
			elseif task==3 then		--修补
				table.sort(plist,	function(a,b)
										return JY.Person[a]["武力"]+JY.Person[a]["统率"]>JY.Person[b]["武力"]+JY.Person[b]["统率"];
									end)
			elseif task==11 then	--开垦
				table.sort(plist,	function(a,b)
										return JY.Person[a]["政务"]>JY.Person[b]["政务"];
									end)
			elseif task==12 then	--商业
				table.sort(plist,	function(a,b)
										return JY.Person[a]["政务"]>JY.Person[b]["政务"];
									end)
			elseif task==13 then	--技术
				table.sort(plist,	function(a,b)
										return JY.Person[a]["智谋"]>JY.Person[b]["智谋"];
									end)
			elseif task==14 then	--治安
				table.sort(plist,	function(a,b)
										return JY.Person[a]["武力"]>JY.Person[b]["武力"];
									end)
			else
			
			end
		end
	end
	local function ExecuteTask()
		if task>0 and #plist>0 then
			local pid=plist[1];
			table.remove(plist,1);
			if c["资金"]>=costs[task] then
				if pid~=JY.PID then
					c["资金"]=c["资金"]-costs[task];
					CityDevelop(cid,pid,task);
				else
					local pid2=c["太守"];
					local str;
					if task==1 then			--募兵
						str=JY.Str[15300];
					elseif task==3 then		--修补
						str=JY.Str[math.random(15310,15311)];
					elseif task==11 then	--开垦
						str=JY.Str[math.random(15350,15351)];
					elseif task==12 then	--商业
						str=JY.Str[math.random(15355,15356)];
					elseif task==13 then	--技术
						str=JY.Str[15360];
					elseif task==14 then	--治安
						str=JY.Str[15365];
					else
						str="";
					end
					str=string.gsub(str,"s1","[Green]"..JY.Person[pid]["名称"].."[Normal]");
					Talk(pid2,str);
					str=JY.Str[15499];
					str=string.gsub(str,"s1","[Green]"..JY.Person[pid2]["名称"].."[Normal]");
					if task==1 then
						str=string.gsub(str,"s2","[Green]募兵[Normal]");
					elseif task==3 then
						str=string.gsub(str,"s2","[Green]修补[Normal]");
					elseif task==11 then
						str=string.gsub(str,"s2","[Green]开垦[Normal]");
					elseif task==12 then
						str=string.gsub(str,"s2","[Green]商业[Normal]");
					elseif task==13 then
						str=string.gsub(str,"s2","[Green]技术[Normal]");
					elseif task==14 then
						str=string.gsub(str,"s2","[Green]治安[Normal]");
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
	--根据任务态度，过滤掉一部分武将
	local pnum=#plist;
	for i=pnum,1,-1 do
		local pid=plist[i];
		local ratio=0.50;
		if JY.Person[pid]["理想"]>10 then			--隐遁
			ratio=0.90;
		elseif JY.Person[pid]["任务态度"]==1 then	--无视
			ratio=0.50;
		elseif JY.Person[pid]["任务态度"]==2 then	--适当
			ratio=0.30;
		elseif JY.Person[pid]["任务态度"]==3 then	--普通
			ratio=0.15;
		elseif JY.Person[pid]["任务态度"]==4 then	--努力
			ratio=0.05;
		end
		if math.random()<ratio then
			table.remove(plist,i);
		end
	end
	pnum=#plist;
	if pnum==0 then		--过滤后，若没人了...
		return false;
	end
	for i=1,math.min(pnum,10) do	--限制了做任务的最大人数
		QueryTasks();	--获取任务
		ExecuteTask();	--执行任务
	end
end
function CityDevelop(cid,pid,task)
	local c=JY.City[cid];
	local p=JY.Person[pid];
	local old,new,str,str2;
	if task==1 then			--募兵
		old=math.floor(c["兵力"]);
    local value = 1;
    if c["人口"] > 1000 then
      value = 1 + limitX((c["人口"] - 1000) / 10000, 0, 1);
    else
      value = limitX((c["人口"] - 400) / 600, 0, 1);
    end
    value = math.floor(20 * ValueAdjust(p["魅力"], 100) * value);
		c["兵力"]=limitX(c["兵力"] + value, 0, c["规模"] * 50000);
    c["人口"] = limitX(c["人口"] - math.ceil(value / 100), 400, 30000);
    c["治安"] = limitX(c["治安"] - 100 - math.random(50), 0, 1000);
		new=math.floor(c["兵力"]);
		str2="兵力";
	elseif task==2 then		--训练
		old,new=0,0;
		str2="兵力";
	elseif task==3 then		--修补
		old=math.floor(c["防御"]/2);
		c["防御"]=limitX(c["防御"]+ValueAdjust(p["统率"]*0.5+p["武力"]*0.5,100)/10,0,c["最大防御"]);
    c["治安"] = limitX(c["治安"] - 1 - math.random(10), 0, 1000);
		new=math.floor(c["防御"]/2);
		str2="防御";
	elseif task==11 then	--开垦
		old=math.floor(c["开垦"]/2);
		c["开垦"]=limitX(c["开垦"]+ValueAdjust(p["政务"]*0.7+p["魅力"]*0.3,100)/10,0,c["最大开垦"]);
    c["治安"] = limitX(c["治安"] - 1 - math.random(10), 0, 1000);
		new=math.floor(c["开垦"]/2);
		str2="开垦";
	elseif task==12 then	--商业
		old=math.floor(c["商业"]/2);
		c["商业"]=limitX(c["商业"]+ValueAdjust(p["政务"]*0.7+p["智谋"]*0.3,100)/10,0,c["最大商业"]);
    c["治安"] = limitX(c["治安"] - 1 - math.random(10), 0, 1000);
		new=math.floor(c["商业"]/2);
		str2="商业";
	elseif task==13 then	--技术
		old=math.floor(c["技术"]/2);
		c["技术"]=limitX(c["技术"]+ValueAdjust(p["智谋"]*0.7+p["政务"]*0.3,100)/10,0,c["最大技术"]);
    c["治安"] = limitX(c["治安"] - 1 - math.random(10), 0, 1000);
		new=math.floor(c["技术"]/2);
		str2="技术";
	elseif task==14 then	--治安
		old=math.floor(c["治安"]/10);
		c["治安"]=limitX(c["治安"]+ValueAdjust(p["武力"]*0.7+p["智谋"]*0.3,100)/5,0,1000);
		new=math.floor(c["治安"]/10);
		str2="治安";
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
		DrawMulitStrBox(string.format("[name]%s[normal]： %3d  → %3d (%+d)",str2,old,new,new-old));
	end
end