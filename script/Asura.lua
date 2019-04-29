function AsuraMain()
	JY.Status=GAME_START;  --游戏当前状态
	PicCacheIni();
	LoadRecord(0);
	while true do
		if JY.Status==GAME_START then
			if JY.CurrentBGM~=1 then
				StopBGM();
				PlayBGM(2);
			end
			if JY.SubScene~=200 then
				SetSceneID(200);
			end
			--while JY.Status==GAME_START do
				Asura_MainMenu();
			--end
		elseif JY.Status==GAME_SMAP_MANUAL then
			Asura_Manual();
		elseif JY.Status==GAME_MMAP then
			JY.Status=GAME_SMAP_MANUAL;
		elseif JY.Status==GAME_WMAP then
			WarStart();
		elseif JY.Status==GAME_WMAP2 then	--连续战斗
			JY.Status=GAME_WMAP;
			ShowScreen();
			DoEvent(JY.EventID);
		elseif JY.Status==GAME_WARWIN then
			JY.Status=GAME_SMAP_MANUAL;
		elseif JY.Status==GAME_WARLOSE then
			JY.Status=GAME_SMAP_MANUAL;
		elseif JY.Status==GAME_DEAD then
			
		elseif JY.Status==GAME_END then
			Dark();
			lib.Delay(100)
			os.exit();
		end
	end
end

function Asura_MainMenu()
	--CC.Debug=1
	local menu={
				{"开始游戏",nil,1,true},
				{"读取存档",nil,1,true},
				{"功能设定",nil,0,true},
				{"战场重现",nil,1,true},
				{"全武将",nil,1,true},
				{"比武大会",nil,1,true},
				{"五子连珠",nil,1,true},
				{"三国问答",nil,1,true},
				{"华容道",nil,1,true},
				{"连连看",nil,1,true},
				{"三国杀",nil,1,true},
				{"退出游戏",nil,1,true},
				{"重载Lua",nil,0,true},
			}
		if CC.Debug==1 then
			menu[4][3]=1;
			menu[10][3]=1;
		end
		lib.Delay(200);
		local s=ShowNewMenu(menu,0,0,0);
		if s==1 then
			Asura_Start()
		elseif s==2 then
			ShowRecordMenu(0);
		elseif s==3 then
			SettingMenu();
		elseif s==4 then
			WarIni();
			War.ArmyA1=SelectArmy(0);
			War.ArmyB1=SelectArmy(0);
      --skipWar(math.random(1,172));
			LLK_III_Main(math.random(1,172));
		elseif s==5 then
			SetSceneID(61);
			ShowPersonList(GetAllList(),nil,1);
		elseif s==6 then
			PlayBGM(18);
			Fight(95,499);
			--FightMenu();
		elseif s==7 then
			Five();
		elseif s==8 then
			SanQA();
		elseif s==9 then
			HuaRongD();
		elseif s==10 then
			lianliankan(19);
		elseif s==11 then
			ShaMain();
		elseif s==12 then
			if WarDrawStrBoxYesNo('结束游戏吗？',C_WHITE,true) then
				lib.Delay(100);
				if WarDrawStrBoxYesNo('再玩一次吗？',C_WHITE,true) then
					lib.Delay(100);
					JY.Status=GAME_START;
				else
					lib.Delay(100);
					JY.Status=GAME_END;
				end
			end
		elseif s==13 then
			dofile(CONFIG.ScriptPath .. "S.RPG.lua");
			dofile(CONFIG.ScriptPath .. "S.lua");
			dofile(CONFIG.ScriptPath .. "fight.lua");
			dofile(CONFIG.ScriptPath .. "UI.lua");
			dofile(CONFIG.ScriptPath .. "mouse.lua");
			dofile(CONFIG.ScriptPath .. "input.lua");
			dofile(CONFIG.ScriptPath .. "Asura.lua");
			dofile(CONFIG.ScriptPath .. "kdef.lua");
		end
end
function Asura_Start()
	LoadRecord(0);
	local gid=TableRandom({1194,1195,1196,1197,1198,1199,1200,1201,1202,1203,1204,1205,1224,1225,1226,1227,1228,1258,1259,1260,1261,1262,1263,1264});
	local Scenario={	{"184年  "..JY.Str[9121],			nil,1,true};	--01
						{"190年  "..JY.Str[9122],			nil,1,true};	--02
						{"195年  "..JY.Str[9123],			nil,1,true};	--03
						{"200年  "..JY.Str[9124],			nil,1,true};	--04
						{"207年  "..JY.Str[9125],			nil,1,true};	--05
						{"214年  "..JY.Str[9126],			nil,1,true};	--06
						{"???年  "..JY.Str[9127],			nil,0,true};	--07
						{"???年  "..JY.Str[9128],			nil,0,true};	--08
						{"???年  "..JY.Str[9129],			nil,0,true};	--09
						{"???年  "..JY.Str[9130],			nil,0,true};	--10
						{"252年  "..JY.Str[9131],			nil,1,true};	--11
						{"???年  "..JY.Str[9132],			nil,0,true};	--12
						{"???年  "..JY.Str[9133],			nil,0,true};	--13
						{"???年  "..JY.Str[9134],			nil,0,true};	--14
						{"???年  "..JY.Str[9135],			nil,0,true};	--15
						{"???年  "..JY.Str[9136],			nil,0,true};	--16
						{"???年  "..JY.Str[9137],			nil,0,true};	--17
						{"???年  "..JY.Str[9138],			nil,0,true};	--18
						{"???年  "..JY.Str[9139],			nil,0,true};	--19
						{"???年  "..JY.Str[9140],			nil,0,true};	}	--20
	local gtype={		{"使用新势力",						nil,1,true};
						{"使用史实势力",					nil,1,true};	}
	local step=1;
	
	SetSceneID(201);
	while step<6 do
		if step==1 then	--剧本
			local r=TalkMenuEx("姑娘",gid,"欢迎。[n]请选择一个剧本。",Scenario);
			if r>0 then
				JY.Base["当前剧本"]=r;
				Confirm("[Orange][b]"..JY.Str[9120+r],JY.Str[9140+r])
				step=2;
			else
				step=9;
			end
		elseif step==2 then	--角色
			ScenarioInit();
			local pid=ShowPersonList(GetAllList(),nil,2);
			if pid>0 then
				JY.PID=pid;
				step=5;
			else
				step=1;
			end
			--[[
		elseif step==2 then	--脚色
			local r=TalkMenuEx("姑娘",gid,"请选择是使用新势力，[n]还是使用史实势力",gtype);
			if r==1 then
				step=3;
			elseif r==2 then
				step=4;
			else
				step=1
			end
		elseif step==3 then
			ScenarioInit();
			local npid=901;
			local nfid=50;
			JY.Person[npid]["名称"]=IniName();
			JY.Person[npid]["等级"]=4;
			--JY.Person[npid]["功绩"]=CC.Exp[4];
			NewPerson(npid);	--初始化主角
			local cid=SelectCity(1,1);
			if cid>0 then
				NewForce(nfid,npid,cid)
				SelectForce(nfid);
				step=5;
			else
				step=2;
			end
		elseif step==4 then
			ScenarioInit();
			local fid=SelectCity(0,3);
			if fid>0 then
				SelectForce(fid);
				step=5;
			else
				step=2;
			end]]--
		elseif step==5 then
			JY.SubScene=-1;
			JY.EventID=1;
			JY.Status=GAME_SMAP_MANUAL;  --游戏当前状态
			DoEvent(0100+JY.Base["当前剧本"]);
			SetSceneID(0);
			--Asura_Build();
			step=9;
		end
	end
end
function Asura_Build()
	--CleanSmap();
	--local row,col=1,1;
	--AddPerson(JY.PID,row,col,0);
	--row=row+1;
	--col=1;
	--local pl={};
	--[[
	for i=1,JY.PersonNum-1 do
		if JY.Person[i]["势力"]==JY.FID and i~=JY.PID then
			table.insert(pl,i);
		end
	end
	for i=1,math.min(5,#pl) do
		local pid=TableRandom(pl);
		if pid>0 then
			AddPerson(pid,row,i,math.random(7001,7117))
		else
			break;
		end
	end
	row=row+1;
	for i=1,math.min(5,#pl) do
		local pid=TableRandom(pl);
		if pid>0 then
			AddPerson(pid,row,i,math.random(7001,7117))
		else
			break;
		end
	end]]--	
end
function Asura_Manual()
	local size=20;
	local current=0;
	local hold=false;
	local bt={};
	bt[1]={
			x1=CC.ScreenW-64*2,
			y1=2,
			x2=CC.ScreenW-64*2+61,
			y2=2+41,
			pic=64
			}
	bt[2]={
			x1=CC.ScreenW-64*1,
			y1=2,
			x2=CC.ScreenW-64*1+61,
			y2=2+41,
			pic=67
			}
	bt[3]={
			x1 = 203,
			y1 = 1,
			x2 = 203 + 46,
			y2 = 40,
			pic = 161
			}
	local function redraw()
		DrawGame();
		drawCityMenu(JY.CityMenu);
		drawGameStatus(JY.GameStatus);
		--for i,v in pairs(JY.Scene) do
		--	if v["人物"]>0 then
		--		local x,y=v["坐标X"],v["坐标Y"];
		--		local str=JY.Person[v["人物"]]["名称"];
		--		if JY.Tid==v["人物"] then
		--			lib.PicLoadCache(2,(JY.Person[v["人物"]]["容貌"]+4000)*2,x+4,y+4,1);
		--			lib.PicLoadCache(4,2*2,x,y,1);
		--			DrawStringEnhance(x+49-size*#str/4+1,y+141-size/2+1,str,C_Name,size);
		--		else
		--			lib.PicLoadCache(2,(JY.Person[v["人物"]]["容貌"]+4000)*2,x+3,y+3,1);
		--			lib.PicLoadCache(4,1*2,x,y,1);
		--			DrawStringEnhance(x+49-size*#str/4,y+141-size/2,str,C_WHITE,size);
		--		end
		--	end
		--end
		for i,v in pairs(bt) do
			if current==i then
				if hold then
					lib.PicLoadCache(4,(v.pic+2)*2,v.x1,v.y1,1);
				else
					lib.PicLoadCache(4,(v.pic+1)*2,v.x1,v.y1,1);
				end
				if i==1 then
					DrawYJZBox(-1,12,"情报",C_WHITE);
				elseif i==2 then
					DrawYJZBox(-1,12,"功能",C_WHITE);
				elseif i==3 then
					DrawYJZBox(-1,12,"地图",C_WHITE);
				end
			else
				lib.PicLoadCache(4,v.pic*2,v.x1,v.y1,1);
			end
		end
	end
	DrawGame();
	PlayCityBGM(JY.Person[JY.PID]["所在"], false);
	ShowScreen();
	UpdateForce();
	while JY.Status==GAME_SMAP_MANUAL do
		local t1=lib.GetTime();
		redraw();
		ShowScreen();
		local delay=CC.FrameNum-lib.GetTime()+t1;
		if delay>0 then
			lib.Delay(delay);
		end
		getkey();
		--[[
		JY.Tid=-1;
		for i,v in pairs(JY.Scene) do
			if v["人物"]>0 then
				local px,py=v["坐标X"],v["坐标Y"];
				if MOUSE.CLICK(px+4,py+4,px+93,py+150) then
					JY.Tid=v["人物"];
					PlayWavE(0);
					Asura_Manual_ActionMenu(JY.Tid,v["类型"]);
					if JY.Tid==-1 then
						JY.Tid=0;
						return;
					end
					JY.Tid=-1;
					break;
				elseif MOUSE.IN(px+4,py+4,px+93,py+150) then
					JY.Tid=v["人物"];
				end
			end
		end]]--
		current=0;
		hold=false;
		for i,v in pairs(bt) do
			if MOUSE.CLICK(v.x1,v.y1,v.x2,v.y2) then
				current=i;
				PlayWavE(0);
				if current==1 then
					InfoMenu();
				elseif current==2 then
					SystemMenu();
				elseif current == 3 then
					CityMap:show();
				end
				break;
			elseif MOUSE.HOLD(v.x1,v.y1,v.x2,v.y2) then
				current=i;
				hold=true;
				break;
			elseif MOUSE.IN(v.x1,v.y1,v.x2,v.y2) then
				current=i;
				break;
			end
		end
		if MOUSE.EXIT() then
			SystemMenu();
		end
		local r=eventCityMenu(JY.CityMenu);
		if r>0 then
			Asura_Command(r);
		else
			eventGameStatus(JY.GameStatus);
		end
	end
end
function Asura_Command(command,par1,par2,par3,par4)
	local pid=JY.PID;
	local cid=JY.Person[pid]["所在"];
	local fid=JY.City[cid]["势力"];
	if false then
	
  elseif command == 105 then
    AI_ForceChief(1)
  elseif command == 101 then  --政厅
    Assignment();
	elseif command==102 then	--仕官
		local str=JY.Str[15000];	
		str=string.gsub(str,"s1","[Green]"..JY.Force[fid]["名称"].."[Normal]");
		if TalkYesNo(JY.PID,str) then
      Asura_ApplyOffer(pid, fid);
		end
	elseif command==103 then	--访问
		local tstr="[name]对象[normal]：[Green]%s[Normal][n][name]效果[normal]：对象武将好感上升[n][name]消耗[normal]：物资 -100[n][name]相关[normal]：[wheat]武力[normal]、[wheat]统率[normal]高有利[n]　　　持有[wheat]练兵[normal]技能者，效果上升"
		local eid=ShowPersonList(GetCityXianyi(JY.Person[JY.PID]["所在"],{JY.PID}));
		if eid>0 and ConfirmYesNo("[B][wheat]访问",string.format(tstr,JY.Person[eid]["名称"])) then
			JY.Base["行动力"]=limitX(JY.Base["行动力"]-1,0,9);
			DrawGame();
			Visit(eid);
			return;
		end
	elseif command==104 then	--官爵
		TitleManual(fid);
	elseif command==111 then	--出征
						local tstr="[name]对象[normal]：[Red]%s[Normal][n][name]效果[normal]：出征以占领城池[n][name]消耗[normal]：物资 -%d[n][name]道路[normal]：%s[n][name]距离[normal]：%s"
						local cid2=ShowCityList(GetAtkCity(JY.Person[JY.PID]["所在"]),1);
						if cid2>0 then
							--if TalkYesNo(pid,"攻打[Red]"..JY.City[cid2]["名称"].."[Normal]，需要经过[Orange]"..GetPath(cid2,JY.FID).."[Normal]\\n可以吗？") then
							local wid=GetPath(JY.Person[JY.PID]["所在"],cid2);
							local jl,dl=1,1;
							local cost=500;
							WarIni();
							War.ArmyA1=SelectArmy(JY.Person[JY.PID]["所在"]);
							War.ArmyB1=AutoSelectArmy(cid2);
							if #War.ArmyA1>0 then
								JY.Base["行动力"]=limitX(JY.Base["行动力"]-1,0,9);
								JY.Base["攻打城池"]=cid2;
								LLK_III_Main(wid);
								return;
							end
						end
	elseif command==201 then	--开垦
		local tstr="[name]对象[normal]：[Red]%s[Normal][n][name]武将[normal]：%s[n][name]效果[normal]：指定都市开垦上升[n][name]消耗[normal]：行动力 -1"
		if cid>0 and ConfirmYesNo("[B][wheat]开垦",string.format(tstr,JY.City[cid]["名称"],JY.Person[JY.PID]["名称"])) then
			JY.Base["行动力"]=limitX(JY.Base["行动力"]-1,0,9);
			PlayWavE(3);
			DrawGame();
			--local add,str=
			CityDevelop(cid,JY.PID,11);
			--if add>0 then
			--	DrawMulitStrBox(str);
			--end
			return;
		end
	elseif command==301 then	--商业
		local tstr="[name]对象[normal]：[Red]%s[Normal][n][name]武将[normal]：%s[n][name]效果[normal]：指定都市商业上升[n][name]消耗[normal]：行动力 -1"
		if cid>0 and ConfirmYesNo("[B][wheat]商业",string.format(tstr,JY.City[cid]["名称"],JY.Person[JY.PID]["名称"])) then
			JY.Base["行动力"]=limitX(JY.Base["行动力"]-1,0,9);
			PlayWavE(3);
			DrawGame();
			--local add,str=
			CityDevelop(cid,JY.PID,12);
			--if add>0 then
			--	DrawMulitStrBox(str);
			--end
			return;
		end
	elseif command == 401 then	--技术
		local tstr="[name]对象[normal]：[Red]%s[Normal][n][name]武将[normal]：%s[n][name]效果[normal]：指定都市技术上升[n][name]消耗[normal]：行动力 -1"
		if cid>0 and ConfirmYesNo("[B][wheat]技术",string.format(tstr,JY.City[cid]["名称"],JY.Person[JY.PID]["名称"])) then
			JY.Base["行动力"]=limitX(JY.Base["行动力"]-1,0,9);
			PlayWavE(3);
			DrawGame();
			--local add,str=
			CityDevelop(cid,JY.PID,13);
			--if add>0 then
			--	DrawMulitStrBox(str);
			--end
			return;
		end
	elseif command == 501 then	--治安
		local tstr="[name]对象[normal]：[Red]%s[Normal][n][name]武将[normal]：%s[n][name]效果[normal]：指定都市治安上升[n][name]消耗[normal]：行动力 -1"
		if cid>0 and ConfirmYesNo("[B][wheat]治安",string.format(tstr,JY.City[cid]["名称"],JY.Person[JY.PID]["名称"])) then
			JY.Base["行动力"]=limitX(JY.Base["行动力"]-1,0,9);
			PlayWavE(3);
			DrawGame();
			--local add,str=
			CityDevelop(cid,JY.PID,14);
			--if add>0 then
			--	DrawMulitStrBox(str);
			--end
			return;
		end
	elseif command==601 then	--修补
		local tstr="[name]对象[normal]：[Red]%s[Normal][n][name]武将[normal]：%s[n][name]效果[normal]：指定都市防御上升[n][name]消耗[normal]：行动力 -1"
		if cid>0 and ConfirmYesNo("[B][wheat]修补",string.format(tstr,JY.City[cid]["名称"],JY.Person[JY.PID]["名称"])) then
			JY.Base["行动力"]=limitX(JY.Base["行动力"]-1,0,9);
			PlayWavE(3);
			DrawGame();
			--local add,str=
			CityDevelop(cid,JY.PID,3);
			--if add>0 then
			--	DrawMulitStrBox(str);
			--end
			return;
		end
	elseif command==703 then	--访问
		local tstr="[name]对象[normal]：[Green]%s[Normal][n][name]效果[normal]：对象武将好感上升[n][name]消耗[normal]：物资 -100[n][name]相关[normal]：[wheat]武力[normal]、[wheat]统率[normal]高有利[n]　　　持有[wheat]练兵[normal]技能者，效果上升"
		local eid=ShowPersonList(GetCityZaiye(JY.Person[JY.PID]["所在"],{JY.PID}));
		if eid>0 and ConfirmYesNo("[B][wheat]访问",string.format(tstr,JY.Person[eid]["名称"])) then
			JY.Base["行动力"]=limitX(JY.Base["行动力"]-1,0,9);
			PlayWavE(3);
			DrawGame();
			Talk(eid,"进行了会话");
			return;
		end
  elseif command == 209 then -- 见闻, 农田
    Asura_Survey(2);
  elseif command == 309 then -- 见闻, 市场
    Asura_Survey(3);
  elseif command == 409 then -- 见闻, 技术
    Asura_Survey(4);
  elseif command == 509 then -- 见闻, 驻所
    Asura_Survey(5);
  elseif command == 609 then -- 见闻, 城门
    Asura_Survey(6);
  elseif command == 709 then -- 见闻, 酒家
    Asura_Survey(7);
  elseif command == 809 then -- 见闻, 兵营
    Asura_Survey(8);
	elseif command==901 then	--锻炼
		Train();
	elseif command==903 then	--迁居
		local tstr="[name]对象[normal]：[Red]%s[Normal][n][name]武将[normal]：%s[n][name]效果[normal]：移动到指定都市[n][name]消耗[normal]：行动力 -1"
		--local cid2=ShowCityList(GetMoveCity(JY.Person[JY.PID]["所在"]),1);
    local cid2 = CityMap:selectNearbyCity() or 0;
		if cid2>0 and ConfirmYesNo("[B][wheat]迁居",string.format(tstr,JY.City[cid2]["名称"],JY.Person[JY.PID]["名称"])) then
			JY.Base["行动力"]=limitX(JY.Base["行动力"]-1,0,9);
			JY.Person[JY.PID]["所在"]=cid2;
			Dark();
			DrawGame();
			PlayWavE(3);
      PlayCityBGM(JY.Person[JY.PID]["所在"], false);
			Light();
			DrawMulitStrBox(string.format("[Green]%s[Normal]向[Red]%s[Normal]移动到了", JY.Person[JY.PID]["名称"], JY.City[cid2]["名称"]));
			return;
		end
	elseif command==909 then	--休息
		if TalkYesNo(JY.PID,"结束当前回合，确定吗？") then
			Dark();
			JY.Base["当前月"]=JY.Base["当前月"]+1;
			if JY.Base["当前月"]>12 then
				JY.Base["当前月"]=1;
				JY.Base["当前年"]=JY.Base["当前年"]+1;
			end
      JY.Base["行动力"] = 3 + JY.Force[JY.FID]["官爵"];
			--Asura_Build();
			DrawGame();
			Light();
			Asura_CityGrow();
			AI_City();
			UpdateForce();
			return;
		end
	end
end
function Asura_ApplyOffer(pid, fid)
  local eid = JY.Force[fid]["君主"];
  local pass = false;
  if hireRate(eid, pid) > 75 + math.random(10) then
    pass = true;
  end
  if JY.PID == pid or JY.PID == eid then
  local t_str = {0, 0, 0, 0, 0, 10}
    local str = "";
    for i,v in ipairs({"统率", "武力", "智谋", "政务", "魅力"}) do
      t_str[i] = math.max(JY.Person[pid][v]-70, 0);
    end
    local r = PercentRandom(t_str);
    if r == 1 then
      str = TableRandom({ "我对指挥军队略有自信，[n]请允许我为阁下效力吧！",
                          "我熟读《孙子》兵法，[n]擅于用兵之道。"});
    elseif r == 2 then
      str = TableRandom({ "我对武艺略有自信，[n]请允许我为阁下效力吧！",
                          "把敌人打得落花流水，[n]让我主见识见识我这[n]猛虎般的绝技。",
                          "我力能碎石，[n]愿为[Green]" .. JY.Person[eid]["名称"] .. "[Normal]大人效力。"});
    elseif r == 3 then
      str = TableRandom({ "我对智略略有自信，[n]请允许我为阁下出仕吧！",
                          "用我的机智和谋略，[n]助我主一臂之力。"});
    elseif r == 4 then
      str = TableRandom({ "我对政略略有自信，[n]请允许我为阁下出仕吧！",
                          "尽我所能治国安邦、造福于民[n]努力建设稳如磐石的国家。"});
    elseif r == 5 then
      str = TableRandom({ "我对交涉之术略有自信，[n]请允许我为阁下出仕吧！",
                          "我云游诸国，熟悉各地风土人情。[n]愿为您效力。"});
    else
      str = TableRandom({ "虽然是微博之力，但不惜效犬马之劳，[n]请让我在大人旗下效力吧。",
                          "听闻您广求天下之才，[n]还请您同意让我仕官。",
                          "赶来试试身手，[n]愿为您效力。",
                          "早就想找像[Green]" .. JY.Person[eid]["名称"] .. "[Normal]大人这样的明主，[n]请收我做部下吧。"});
    end
    SetSceneID(54);
    DrawGame();
    Talk(pid, str);
    if JY.PID == eid then
      pass = TalkYesNo(eid, "要录用[Green]" .. JY.Person[pid]["名称"] .. "[Normal]吗？");
      DrawGame();
    end
    if pass then
      str = TableRandom({ "我就是在等阁下！[n]期待着你的活跃哟。",
                          "那真是求之不得之事，我将欣然接受。",
                          "感谢你这么有心出任。[n]希望今后好好努力工作。",
                          "感念你如此有心出任。[n]庆幸的是又多了一位可信赖的人。"});
    else
      str = TableRandom({ "在这个节骨眼上，我就明白地跟你说吧。[n]阁下要成为我军之将的话，能力还不足呀。",
                          "这份意气我很欣赏。[n]但是，阁下的能力对我军毫无用处。",
                          "很遗憾，目前我军没有阁下的位置。"});
    end
    Talk(eid, str);
    if pass then
      str = TableRandom({ "真是万分荣幸，[n]我会竭尽所能来效力的。",
                          "非常感谢。[n]从今以后，将以[Green]" .. JY.Person[eid]["名称"] .. "[Normal]大人部下的身份，[n]赌上性命来效力。",
                          "您的欣然允诺真是令人感激不尽。[n]为了不辜负您的期待，粉身碎骨在所不惜！",
                          "嗯！[n]那就期待我的表现吧！",
                          "是的！[n]会以绵薄之力尽心努力的。"});
    else
      str = TableRandom({ "原来听闻到的招贤一事，是假的啊……",
                          "居然拒绝了我。[n]没有赏识人才的眼光也该有个限度。",
                          "这样啊……真是遗憾。"});
    end
    Talk(pid, str);
    if JY.PID == eid then
      if pass then
        DrawMulitStrBox("录用[Green]" .. JY.Person[pid]["名称"] .. "[Normal]了.");
      else
        DrawMulitStrBox("拒绝了[Green]" .. JY.Person[eid]["名称"] .. "[Normal]的投奔.");
      end
    else
      if pass then
        DrawMulitStrBox("投奔[Green]" .. JY.Person[eid]["名称"] .. "[Normal]成功了.");
      else
        DrawMulitStrBox("被[Green]" .. JY.Person[eid]["名称"] .. "[Normal]拒绝录用.");
      end
    end
    SetSceneID(0);
  end
  if pass then
    JY.Person[pid]["势力"] = fid;
    JY.Person[pid]["身份"] = 1;
  end
end
function Asura_Survey()
  local p = JY.Person[JY.PID];
  local name = p["名称"];
  local t_actions = {0, 0, 0, 0, 0, 10};
  local r = PercentRandom(t_actions);
  DrawGame();
  if r == 1 then  --盗贼
    local headID = TableRandom({1072, 1073, 1074, 1075});
    TalkEx("兵士", headID, "最近，[n]街道上经常有盗贼出没。");
    if TalkYesNo(JY.PID, "要亲自出马消灭贼寇吗？") then
      Talk(JY.PID, "知道了，[n]我马上去消灭他们。");
      --图片
      DrawMulitStrBox("消灭了贼寇，[n]但也为贼寇所伤。");
    else
      Talk(JY.PID, TableRandom({"对不起，去找其他人吧。", "我现在很忙，[n]去找别人吧。"}));
    end
  elseif r == 2 then  --施舍
    local headID = TableRandom({1077, 1081});
    local money = 92;
    TalkEx("百姓", headID, TableRandom({ "孩子们饥肠辘辘，嗷嗷待哺，[n]我却没钱买米。",
                              "因为丈夫远赴沙场，[n]家中无人劳动工作，[n]我现在身无分文，生活困苦。"}));
    TalkEx("百姓", headID, TableRandom({ "[Green]" .. name .. "[Normal]大人，[n]您能施舍我" .. money .."黄金吗？",
                              "[Green]" .. name .. "[Normal]大人，[n]无论如何,请您施舍我" .. money .."黄金吧。"}));
    if TalkYesNo(JY.PID, "要施舍黄金" .. money .. "吗？") then
      Talk(JY.PID, "我不能不闻不问，[n]你拿去用吧。");
    else
      Talk(JY.PID, TableRandom({"真不凑巧，我没带现金，[n]去找别人吧。",
                                "对不起，[n]我手头也布宽裕。",
                                "如果我只救济你一个人，[n]对其他人就很不公平，[n]这可不行。"}));
    end
  elseif r == 3 then --讲课
    local headID = TableRandom({1076, 1080});
    TalkEx("村民", headID, TableRandom({"[Green]" .. name .. "[Normal]大人，[n]请教我们读书识字吧！",
                              "官府的告示有许多人看不懂，[n]请教我们读书识字吧！"}));
    if TalkYesNo(JY.PID, "要开办讲义课程吗？") then
      Talk(JY.PID, TableRandom({"你们的想法很好，[n]让我们赶快开始吧。[n]把想学习的人召集起来。",
                                "好，我立即给你们讲解。"}));
      --show pic
      DrawMulitStrBox("讲义受到好评，[n]村民满意而归。");
    else
      Talk(JY.PID, TableRandom({"唔嗯，对不起。我现在公事繁忙，[n]如果以后有机会，再为你们授课吧。",
                                "你们的想法很好，[n]只是很不凑巧，[n]我现在没时间，对不起。",
                                "对不起，[n]去找其他人吧。"}));
    end
  elseif r == 4 then --宴会
    Talk("百姓", "[Green]" .. name .. "[Normal]大人，[n]村中的宴会就要开始了，[n]您也一起来参加吧？");
    if TalkYesNo(JY.PID, "要参加宴会吗？") then
      Talk(JY.PID, TableRandom({"哦，那么我就打扰了。",
                                "正好有空，[n]请为我带路吧。"}));
      --show pic
      DrawMulitStrBox(name .. "与村民一起[n]在宴会上尽情畅饮。");
    else
      Talk(JY.PID, TableRandom({"非常感谢你们的邀请，[n]只是我现在没有时间，[n]下次有机会再邀请我吧。",
                                "非常感谢你们的邀请，[n]只是我现在有事在身。",
                                "如果我去的话，大家一定忙着招呼我。[n]如此一来，大家就都无法尽兴了，[n]这次我就不去了。",
                                "不能参加你们的宴会，[n]你们尽情畅饮吧。"}));
    end
  elseif r == 5 then --丰收祭典
    Talk("童子", "[Green]" .. name .. "[Normal]大人，今天大家要举行祭典，[n]祈祷今年的收成和明年的丰收，[n]您也一起来参加吗？");
    --参加祭典 / 取消祭典
    if TalkYesNo(JY.PID, "要参加宴会吗？") then
      Talk(JY.PID, TableRandom({"你们专程前来邀约，[n]我不能辜负你们的盛情。",
                                "这么难得的丰收庆典，[n]请务必让我参加。"}));
      --show pic
      DrawMulitStrBox(name .. "与村民一起[n]兴高彩烈地举行了祭典。");
    else
      Talk(JY.PID, "现在军粮不足，[n]对不起，[n]请将多余的粮食交出来。");
      --XX的军粮上升了XX
    end
  elseif r == 6 then  --惩处不法
    Talk("百姓", "[Green]" .. name .. "[Normal]大人，[n]据说有一些不肖官员，[n]侵吞粮草，中饱私囊……");
    if TalkYesNo(JY.PID, "要调查官员的不法行为吗？") then
      Talk(JY.PID, TableRandom({"你能将此事禀报给我，做得很好。[n]我立即去调查实情。",
                                "如果确有其事，[n]可是件大事，[n]我立即去进行调查。"}));
      -- load pic
      DrawMulitStrBox(name .. "揭发了[n]徇私枉法的官员。");
    else
      Talk(JY.PID, TableRandom({"我没听说过这件事，[n]是否搞错了？",
                                "这件事我想是你多虑了。",
                                "我很忙，你找其他人吧。"}));
    end
  elseif r == 7 then  --义勇兵
    Talk("百姓", TableRandom({"[Green]" .. name .. "[Normal]大人，[n]我们募集了志同道合之人，[n]结成了义勇军。[n]请让我们成为您的属下。！",
                              "我们都很仰慕[Green]" .. name .. "[Normal]大人，[n]无论如何请让我们为您效力。"}));
    if TalkYesNo(JY.PID, "要接纳义勇兵为属下吗？") then
      Talk(JY.PID, TableRandom({"不能辜负你们的好意，[n]就请加入我的军队吧。",
                                "这正是求之不得呢。[n]前面的路千辛万苦，[n]就拜托各位了。"}));
      -- load pic
      DrawMulitStrBox(name .. "接纳义勇兵为属下。");
    else
      Talk(JY.PID, TableRandom({"现在不需要增加士兵，[n]你们的心意，我心领了。",
                                "你们的心意我接受了。[n]等战斗降至，[n]要征召士兵再拜托各位吧。"}));
    end
  elseif r == 8 then --谢礼 - 金
    Talk("百姓", "这是我们村民为了感念[n][Green]" .. name .. "[Normal]大人平日来的照顾，[n]而凑出来的一点黄金，");
    --"xx大人，[n]我在田里耕作时发现了这个东西，[n]我拿着也没有什么用处，"   "xx大人，[n]这是我家世代相传地宝物，[n]为了感谢您平日对我们地照顾，"
    --"我愿将它献给xx大人。"   ”xx大人，[n]请将它以作为谢礼收下吧。“
    Talk("百姓", "以作为谢礼。[n]请您无论如何一定要收下。");
    if TalkYesNo(JY.PID, "接受村民献上的礼物吗？") then
      Talk(JY.PID, TableRandom({"那我就恭敬不如从命了，[n]我会好好珍惜它的",
                                "哦，这真是求之不得，[n]那么我就不客气地收下了。"}));
      -- load pic
      DrawMulitStrBox(name .. "接受了[n]黄金XXX。");
      --接受村民献上地礼物
    else
      Talk(JY.PID, TableRandom({"很感谢你们有如此心意，[n]可是我不能接受这份礼物。",
                                "这太贵重了，我不能接受。"}));
    end
  else  --信息
    local str = TableRandom({ "每年一、四、七、十月会有资金收入。[n]而物质只有每年七月才会有收入。",
                              "城墙再高，[n]也无法预防灾害的发生。",
                              "如果工作过度偷懒的话，[n]也许还会被贬职。",
                              "七月是一年中最快乐的月份。[n]收货之后，快乐地庆祝丰收。",
                              "坚持不懈的锻炼，[n]就能提高能力哦。",
                              "有学者正在将特产品组合起来，[n]以制作更加强力的武器。"})
  end
end
function Asura_Manual_ActionMenu(pid,kind)
	--[[
		命令
			方针
			调动
			出征
			征兵
			任命		//政务担当for current city	将军位	太守	军师	流放
			延揽
			外交
			谍报
		任务
			主命任务
			商家
			其他支线任务
		拜访
		见闻
	]]
	if kind==0 then
		local m={
					{"命令",nil,1,JY.Base["行动力"]>0};
					{"任务",nil,1,JY.Base["行动力"]>0};
					{"见闻",nil,1,JY.Base["行动力"]>0};
					{"拜访",nil,1,JY.Base["行动力"]>0};
					{"自己",nil,1,JY.Base["行动力"]>0};
					{"休息",nil,1,true};
				}
		while true do
			local r=TalkMenu(pid,"下一步要怎么办？",m);
			if r==0 then
				return;
			elseif r==4 then
				local tstr="[name]对象[normal]：[Green]%s[Normal][n][name]效果[normal]：执行武将等级上升[n][name]消耗[normal]：物资 -100[n][name]相关[normal]：[wheat]武力[normal]、[wheat]统率[normal]高有利[n]　　　持有[wheat]练兵[normal]技能者，效果上升"
				local eid=ShowPersonList(GetCityWujiang(JY.Person[JY.PID]["所在"],{JY.PID}));
				if eid>0 and ConfirmYesNo("[B][wheat]拜访",string.format(tstr,JY.Person[eid]["名称"])) then
					JY.Base["行动力"]=limitX(JY.Base["行动力"]-1,0,9);
					PlayWavE(3);
					DrawGame();
					Talk(eid,"进行了训练");
					return;
				end
			elseif r==6 then
				if TalkYesNo(pid,"结束当前回合，确定吗？") then
					--Asura_Build();
					Asura_Report();
					return;
				end
			else
				local m2={};
				local r2;
				local str2="";
				if  r==1 then
					m2={
								{"出征",nil,1,true};
								{"调动",nil,1,true};
								{"任命",nil,1,true};
								{"外交",nil,1,true};
								{"征兵",nil,1,true};
							}
					str2="对部下传达命令。";
				elseif r==2 then
					m2={
								{"N/A",nil,1,true};
								{"N/A",nil,1,true};
								{"N/A",nil,1,true};
								{"N/A",nil,0,true};
								{"N/A",nil,0,true};
								{"N/A",nil,1,true};
							}
					str2="执行君主下达的任务。";
				elseif r==3 then
					m2={
							{"农地",nil,1,true};
							{"市场",nil,1,true};
							{"工房",nil,1,true};
							{"兵营",nil,1,true};
							{"驻所",nil,1,true};
							{"城墙",nil,1,true};
							{"酒家",nil,1,true};
							}
					str2="见闻。";
				elseif r==5 then
					m2={
							{"引退",nil,1,true};
							{"下野",nil,1,true};
							{"仕官",nil,1,true};
							{"购买",nil,1,true};
							{"锻炼",nil,1,true};
							{"移动",nil,1,true};
							}
					str2="见闻。";
				end
				while true do
					r2=TalkMenu(pid,str2,m2);
					if r2==0 then
						break;
					elseif 10*r+r2==11 then	--出征
						local tstr="[name]对象[normal]：[Red]%s[Normal][n][name]效果[normal]：出征以占领城池[n][name]消耗[normal]：物资 -%d[n][name]道路[normal]：%s[n][name]距离[normal]：%s"
						local cid=ShowCityList(GetAtkCity(JY.Person[JY.PID]["所在"]),1);
						if cid>0 then
							--if TalkYesNo(pid,"攻打[Red]"..JY.City[cid]["名称"].."[Normal]，需要经过[Orange]"..GetPath(cid,JY.FID).."[Normal]\\n可以吗？") then
							local wid=GetPath(JY.Person[JY.PID]["所在"],cid);
							local jl,dl=1,1;
							local cost=500;
							WarIni();
							War.ArmyA1=SelectArmy(JY.Person[JY.PID]["所在"]);
							War.ArmyB1=AutoSelectArmy(cid);
							if #War.ArmyA1>0 then
								JY.Base["行动力"]=limitX(JY.Base["行动力"]-1,0,9);
								JY.Base["攻打城池"]=cid;
								LLK_III_Main(wid);
								return;
							end
						end
					elseif 10*r+r2==12 then	--调动
						
					elseif 10*r+r2==13 then	--任命
						local cid=JY.Person[JY.PID]["所在"];
						if Assign(cid) then
							JY.Base["行动力"]=limitX(JY.Base["行动力"]-1,0,9);
							return;
						end
					elseif 10*r+r2==15 then	--征兵
						local tstr="[name]对象[normal]：[Green]%s[Normal][n][name]效果[normal]：所属都市兵力上升[n][name]消耗[normal]：物资 -100[n][name]相关[normal]：[wheat]武力[normal]、[wheat]统率[normal]高有利[n]　　　持有[wheat]练兵[normal]技能者，效果上升"
						local eid=ShowPersonList(GetCityWujiang(JY.Person[JY.PID]["所在"],{JY.PID}));
						if eid>0 and ConfirmYesNo("[B][wheat]征兵",string.format(tstr,JY.Person[eid]["名称"])) then
							JY.Base["行动力"]=limitX(JY.Base["行动力"]-1,0,9);
							PlayWavE(3);
							DrawGame();
							Talk(eid,JY.Str[math.random(6271,6274)]);
							local cid=JY.Person[JY.PID]["所在"];
							local old=JY.City[cid]["兵力"];
							JY.City[cid]["兵力"]=limitX(JY.City[cid]["兵力"]+20*ValueAdjust(JY.Person[eid]["统率"],100),0,500000);
							local new=JY.City[cid]["兵力"];
							Talk(eid,string.format("[name]士兵数[normal]： %5d  → %5d (%+d)",old,new,new-old));
							return;
						end
					elseif 10*r+r2==56 then	--移动
					elseif r==3 then
						
					end
				end
			end
		end
	elseif between(kind,7001,7117) then
		DrawGame()
		Talk(pid,AsuraGenTalkString(kind,pid,JY.PID));
	else
		Talk(pid,"你好，我是"..JY.Person[pid]["名称"]);
	end
end
function Asura_Manual_Action(pid,kind)
	local str={	"1","2","3","4","5","6","7","8","9","10",
				"攻打制定城池","训练指定武将，提高其经验。","特训指定武将，大幅提高其经验。","训练全军武将，提高其经验。","特训全军武将，大幅提高其经验。","5","6","7","8","9","10",
				"探索在野武将，也可能有其它发现。","求贤，可能发现多位武将。","治愈指定武将，部分恢复其疲劳度。","痊愈指定武将，完全恢复其疲劳度。","治愈全军武将，部分恢复其疲劳度。","15","16","17","18","19","20",
				"指派内政负责人。","进行交易，以获取金钱以及物资。","贩卖物资，以获取大量金钱。","横征暴敛，以获取大量金钱以及物资。","布施物资，以提高民心。","布施金钱以及物资，以大幅提高民心。","26","27","28","29","30",
				"任命武将负责的职务。","命令指定武将外出修行一年。","放逐指定武将。","34","35","36","37","38","39","40",
				"41","42","43","44","45","46","47","48","49","50"}
	if TalkYesNo(pid,str[kind]) then
		
		return true;
	else
		return false;
	end
end
function TalkMenu(p,str,m)
	local name="";
	local headid=0;
	if type(p)=='number' then
		headid=JY.Person[p]["容貌"];
		name=JY.Person[p]["名称"];
	elseif type(name)=='string' then
		local pid=JY.NameList[p];
		if pid~=nil then
			headid=JY.Person[pid]["容貌"];
			name=JY.Person[pid]["名称"];
		else
			name=p;
		end
	end
	return TalkMenuEx(name,headid,str,m);
end
function TalkMenuEx(name,headid,str,m)
	JY.Talk={headid=headid,name=name,str=str};
	local r=ShowNewMenu(m,CC.ScreenW/2+128,0,1,1);
	JY.Talk={headid=0,name="",str=""};
	DrawGame();
	return r;
end

function CleanSmap()
	for i,v in pairs(JY.Scene) do
		v["人物"]=-1;
	end
end
function AddPerson(name,row,column,event)
	local pid=-1;
	if type(name)=="number" then
		pid=name;
	elseif JY.NameList[name]~=nil then
		pid=JY.NameList[name];
	else
		lib.Debug("AddPerson: "..name.." not exist");
		return false;
	end
	for i=0,100 do
		if JY.Scene[i]["人物"]==-1 then
			JY.Scene[i]["人物"]=pid;
			JY.Scene[i]["坐标X"]=36+110*(column-1);
			JY.Scene[i]["坐标Y"]=36+172*(row-1);
			JY.Scene[i]["类型"]=event;
			break;
		end
	end
end
function DecPerson(name)
	local pid=-1;
	if type(name)=="number" then
		pid=name;
	elseif JY.NameList[name]~=nil then
		pid=JY.NameList[name];
	else
		lib.Debug("DecPerson: "..name.." not exist");
		return false;
	end
	for i,v in pairs(JY.Scene) do
		if v["人物"]==pid then
			v["人物"]=-1;
			break;
		end
	end
	for i=1,20 do
		if JY.Scene[i]["人物"]<=0 then
			JY.Scene[i]["人物"]=JY.Scene[i+1]["人物"];
			JY.Scene[i]["类型"]=JY.Scene[i+1]["类型"];
			JY.Scene[i+1]["人物"]=-1;
		end
	end
end
function Search(pid,t)
	for i=1,t do
		local p={};
		for i=1,JY.PersonNum-1 do
			if JY.Person[i]["登场"]==1 and JY.Person[i]["势力"]==0 then
				if math.random(2,5)>JY.Person[i]["品级"] then
					table.insert(p,i);
				end
			end
		end
		local r=math.random();
		local eid=TableRandom(p);
		SetSceneID(67);
		if eid<=0 or r<0.25 then
			PlayWavE(2);
			Talk(pid,AsuraGenTalkString(41,0,0));
		elseif r<0.45 then
			Talk(pid,"找到了一点物资。");
		else
			PlayWavE(3);
			JY.Person[eid]["登场"]=2;
			Talk(pid,AsuraGenTalkString(42,pid,eid));
			JY.DG.pid=eid;
			local zm=TalkYesNo(pid,"要招募[Green]"..JY.Person[eid]["名称"].."[Normal]吗？")
			JY.DG.pid=-1;
			DrawGame();
			if zm then
				Hire(pid,eid);
			else
				Talk(pid,"你好，再见。");
			end
		end
	end
end
function Hire(pid,eid)
	local xx=GetXX(pid,eid);
	local sucess_ratio=0.3;
	sucess_ratio=(1-xx*0.01)-sucess_ratio;	--So, the range is (100%~26%)-0.3;
	SetSceneID(69);
	Talk(pid,AsuraGenTalkString(43,pid,eid));
	if RND(sucess_ratio) then
		PlayWavE(3);
		Talk(eid,AsuraGenTalkString(44,eid,pid));
		JY.Person[eid]["势力"]=JY.FID;
		JY.Person[eid]["登场"]=3;
		UpdateForcePersonNum(JY.FID);
	else
		PlayWavE(2);
		Talk(eid,AsuraGenTalkString(45,eid,pid));
	end
end
function GetXX(id1,id2)
	local xx=math.abs(JY.Person[id1]["相性"]-JY.Person[id2]["相性"]);
	xx=math.min(xx,149-xx);	--So, the range is 0~74;
	return xx;
end
function hireRate(pid, eid)
  --pid对eid的hire rate
  --用于判断: 1.pid是否去招揽eid; 2.pid是否统一eid的仕官申请; 3.pid是否接受eid的招揽
  --所以, A招募B, 选哟先hireRate(A,B)(是否去招揽),然后还需要hireRate(B,A)(是否接受)
  local v1, v2, v3, v4 = 0, 0, 0, 0;
  v1 = getRelationship(pid, eid);
  if v1 < 0 then
    return 0;
  end
  if JY.Person[pid]["义理"] > 0 then
    v2 = (75 - GetXX(pid, eid)) * 4 / 3 * (0.6 + JY.Person[pid]["义理"] / 5);
  end
  if JY.Person[pid]["爱勇"] > 0 then
    v3 = (JY.Person[eid]["武力"] + JY.Person[eid]["统率"]) / 2 * (0.6 + JY.Person[pid]["爱勇"] / 5);
  end
  if JY.Person[pid]["爱才"] > 0 then
    v4 = (JY.Person[eid]["智谋"] + JY.Person[eid]["政务"]) / 2 * (0.6 + JY.Person[pid]["爱才"] / 5);
  end
      lib.Debug("hire " .. v1 .. ", " .. v2 .. ", " .. v3 .. ", " .. v4)
  return math.max(v1, v2, v3, v4);
end
function getRelationship(pid, eid)
  --pid对eid的关系/称呼/亲密等
  --return pid对eid的 亲密度,称谓
  local title = "";
  local feeling = 0;
  local p = JY.Person[pid];
  local e = JY.Person[eid];
  
  if p["仇敌"] > 0 and eid == p["仇敌"] then  --仇敌
    feeling = -100;
    title = e["名称"];
  elseif p["义兄"] > 0 and e["义兄"] == p["义兄"] then  --义兄弟
    feeling = 100;
    if eid == p["义兄"] then
      if e["性别"] == 0 then
        title = "大哥";
      else
        title = "姐姐";
      end
    else
      title = e["字"];
    end
  elseif (p["配偶"] > 0 and eid == p["配偶"]) or (e["配偶"] > 0 and pid == e["配偶"]) then --配偶
    feeling = 80;
    if e["性别"] == 0 then
      title = "夫君";
    else
      title = "娘子";
    end
  elseif p["父亲"] > 0 and eid == p["父亲"] then  --父亲
    feeling = 70;
    title = "父亲";
  elseif p["母亲"] > 0 and eid == p["母亲"] then --母亲
    feeling = 70;
    title = "母亲";
  elseif (p["父亲"] > 0 and p["父亲"] == e["父亲"]) or (p["母亲"] > 0 and p["母亲"] == e["母亲"]) then  --兄弟
    feeling = 60;
    if e["生年"] == p["生年"] then
      if e["性别"] == 0 then
        title = "兄长";
      else
        title = "姐姐";
      end
    else
      title = e["字"];
    end
  else
    feeling = e["好感"] / 2;
    feeling = 0;
    title = e["名称"];
  end
  return feeling, title;
end
function Assignment()
	local width=800;
	local height=360;
	local x0=(CC.ScreenW-width)/2;
	local y0=(CC.ScreenH-height)/2;
	local p=JY.Person[JY.PID];
	local add=50;
	local attr={"统率","武力","智谋","政务","魅力"};
	local expmax={};
	for i=1,#attr do
		local par=attr[i];
		local val=p[par];
		if val>=100 then
			expmax[i]=0;
		else
			expmax[i]=50+math.floor(4000/(109-val));
		end
	end
	local sel=0;
	local bt={};
	button_mainbt_2(bt, "决定", "返回", 1, 2, CC.ScreenH - y0 - 58);
  table.insert(bt, button_creat(1, 10, x0 + 40, y0 + 10, "自动", true, true));
  table.insert(bt, button_creat(1, 11, x0 + 40, y0 + 50, "开发", true, true));
  table.insert(bt, button_creat(1, 12, x0 + 40, y0 + 90, "商业", true, true));
  table.insert(bt, button_creat(1, 13, x0 + 40, y0 + 130, "技术", true, true));
  table.insert(bt, button_creat(1, 14, x0 + 40, y0 + 170, "治安", true, true));
  table.insert(bt, button_creat(1, 15, x0 + 40, y0 + 210, "修补", true, true));
  table.insert(bt, button_creat(1, 16, x0 + 40, y0 + 250, "募兵", true, true));
  table.insert(bt, button_creat(1, 17, x0 + 40, y0 + 290, "训练", true, true));
	local function redraw()
		DrawGame();
		LoadPicEnhance(73,x0,y0,width,height);
		local x,y=x0+40,y0-30;
		x=x+360;
		for i=1,#attr do
			local par=attr[i];
			DrawStringEnhance(x,y+60*i,"[B]"..p[par],C_WHITE,24);
			DrawStringEnhance(x+40,y+60*i,par.."经验",C_Name,24);
			local expstr;
			if expmax[i]>0 then
				expstr=string.format("%3d",math.floor(100*JY.Base[par.."经验"]/expmax[i]));
				if i==sel then
					expstr=expstr.."[green]+"..(math.floor(100*(JY.Base[par.."经验"]+add)/expmax[i])-math.floor(100*JY.Base[par.."经验"]/expmax[i]));
				end
			else
				expstr="--"
			end
			DrawStringEnhance(x+200,y+60*i,expstr,C_WHITE,24);
			drawbar(x+40,y+24+60*i,1000*JY.Base[par.."经验"]/expmax[i]);
		end
		if sel>0 then
			bt[3+sel].on=2;
		end
		button_redraw(bt);
	end
	bt[2].enable=false;
	while true do
		local t1=lib.GetTime();
		redraw();
		ShowScreen();
		local delay=CC.FrameNum-lib.GetTime()+t1;
		if delay>0 then
			lib.Delay(delay);
		end
		getkey();
		local event,btid=button_event(bt);
		if event==3 then
			if btid==1 then
				local par=attr[sel];
				local old=math.floor(100*JY.Base[par.."经验"]/expmax[sel]);
				JY.Base[par.."经验"]=JY.Base[par.."经验"]+add;
				local new=math.floor(100*JY.Base[par.."经验"]/expmax[sel]);
				DrawGame();
				if new>=100 then
					JY.Base[par.."经验"]=JY.Base[par.."经验"]-expmax[sel];
					p[par]=p[par]+1;
					Talk(JY.PID,par.."上升为"..(p[par]).."。");
				else
					Talk(JY.PID,par.."经验上升了"..(new-old).."。");
				end
				return true;
			elseif btid==2 then
				return false;
			elseif between(btid,11,10+#attr) then
				sel=btid-10;
				bt[2].enable=true;
			end
		end
	end  
end
function Visit(pid)
	local ratio;
	local str;
	if JY.Person[pid]["好感"]==0 then
		ratio=0.7;
	else
		ratio=1;
	end
	if math.random()<ratio then
		SetSceneID(69);
		local old=JY.Person[pid]["好感"];
		local xx=GetXX(JY.PID,pid)+math.floor(old/2);
		if JY.Person[pid]["好感"]==0 then
			str=JY.Str[math.random(15110,15111)];
			str=string.gsub(str,"s2","[Green]"..JY.Person[JY.PID]["名称"].."[Normal]");
			Talk(JY.PID,str);
			str=JY.Str[math.random(15115,15116)];
			str=string.gsub(str,"s1","[Green]"..JY.Person[pid]["名称"].."[Normal]");
			str=string.gsub(str,"s2","[Green]"..JY.Person[JY.PID]["名称"].."[Normal]");
			Talk(pid,str);
			str=JY.Str[math.random(15120,15122)];
			Talk(JY.PID,str);
			JY.Person[pid]["好感"]=limitX(JY.Person[pid]["好感"]+math.max(1,math.floor(10-10*xx/100)+math.random(5)-math.random(5)),1,100);
		else
			str=JY.Str[math.random(15125,15127)];
			str=string.gsub(str,"s2","[Green]"..JY.Person[JY.PID]["名称"].."[Normal]");
			Talk(pid,str);
			str=JY.Str[math.random(15130,15134)];
			str=string.gsub(str,"s1","[Green]"..JY.Person[pid]["名称"].."[Normal]");
			Talk(JY.PID,str);
			local t_str={0,0,0,0,0,30}
			for i,v in ipairs({"统率","武力","智谋","政务","魅力"}) do
				t_str[i]=math.max(JY.Person[pid][v]-70,0);
			end
			local kind=PercentRandom(t_str);
			if kind==6 then
				str=JY.Str[math.random(15180,15186)];
			else
				str=JY.Str[15135+8*kind+math.random(1,8)];
			end
			Talk(pid,str);
			JY.Person[pid]["好感"]=limitX(JY.Person[pid]["好感"]+math.max(1,math.floor(20-20*xx/100)+math.random(3)-math.random(3)),1,100);
		end
		local new=JY.Person[pid]["好感"];
		if new>old then
			PlayWavE(3);
			DrawMulitStrBox(string.format("[green]%s [name]好感 [white]%3d -> %3d",JY.Person[pid]["名称"],old,new))
		end
		SetSceneID(0);
	else
		str=JY.Str[math.random(15100,15103)];
		str=string.gsub(str,"s1","[Green]"..JY.Person[pid]["名称"].."[Normal]");
		Talk(800,str);
		str=JY.Str[math.random(15105,15108)];
		str=string.gsub(str,"s1","[Green]"..JY.Person[pid]["名称"].."[Normal]");
		Talk(JY.PID,str);
	end
end
function Train()
	local width=800;
	local height=360;
	local x0=(CC.ScreenW-width)/2;
	local y0=(CC.ScreenH-height)/2;
	local p=JY.Person[JY.PID];
	local add=50;
	local attr={"统率","武力","智谋","政务","魅力"};
  local function getNextExp(val)
    return 20 + math.ceil(10000 / (110 - val));
  end
  local function getExpPercent(val, curExp)
    local maxExp = getNextExp(val);
    if curExp > maxExp then
      return 100 + getExpPercent(val + 1, curExp - maxExp);
    else
      return math.floor(100 * curExp / maxExp);
    end
  end
	local sel=0;
	local bt={};
	button_mainbt_2(bt,"决定","返回",1,2,CC.ScreenH-y0-58);
	for i=1,#attr do
		table.insert(bt,button_creat(1,10+i,x0+280,y0-32+60*i,attr[i],true,p[attr[i]] < 100));
	end
	local function redraw()
		DrawGame();
		LoadPicEnhance(73,x0,y0,width,height);
		local x,y=x0+40,y0-30;
		lib.PicLoadCache(2,(p["容貌"])*2,x,y+50,1,0,nil,nil,320);
		x=x+360;
		for i=1,#attr do
			local par=attr[i];
			DrawStringEnhance(x,y+60*i,"[B]"..p[par],C_WHITE,24);
			DrawStringEnhance(x+40,y+60*i,par.."经验",C_Name,24);
			local expstr;
      if p[par] < 100 then
        expstr = string.format("%3d", getExpPercent(p[par], JY.Base[par .. "经验"]));
        if i == sel  then
          expstr = expstr .. "[green]+" .. (getExpPercent(p[par], JY.Base[par .. "经验"] + add) - getExpPercent(p[par], JY.Base[par .. "经验"]))
        end
      else
        expstr = "--";
      end
			DrawStringEnhance(x+200,y+60*i,expstr,C_WHITE,24);
			drawbar(x+40,y+24+60*i, 10 * getExpPercent(p[par], JY.Base[par.."经验"]));
		end
		if sel>0 then
			bt[3+sel].on=2;
		end
		button_redraw(bt);
	end
	bt[2].enable=false;
	while true do
		local t1=lib.GetTime();
		redraw();
		ShowScreen();
		local delay=CC.FrameNum-lib.GetTime()+t1;
		if delay>0 then
			lib.Delay(delay);
		end
		getkey();
		local event,btid=button_event(bt);
		if event==3 then
			if btid==1 then
				local par = attr[sel];
				local old = getExpPercent(p[par], JY.Base[par.."经验"]);
				JY.Base[par.."经验"]=JY.Base[par.."经验"]+add;
				local new = getExpPercent(p[par], JY.Base[par.."经验"]);
				DrawGame();
        local str = TableRandom({ "平日的苦练是非常重要的。",
                                  "为了不负众望完成我的使命，[n]必须加倍努力锻炼修行。",
                                  "为了在乱世中生存下去，[n]只有每日不断苦练修行，[n]以求更上一层楼。",
                                  "进修之道，[n]日积月累尤为重要。",
                                  "精进之道，[n]唯有每日苦练而已。",
                                  "呼，今天就到此为止吧！"});
				Talk(JY.PID, str)
        if new>=100 then
					JY.Base[par.."经验"]=JY.Base[par.."经验"] - getNextExp(p[par]);
					p[par]=p[par]+1;
					DrawMulitStrBox(string.format("[Green]%s[Normal]的%s成为%d了！", p["名称"], par, p[par]));
				else
					DrawMulitStrBox(string.format("[Green]%s[Normal]的%s经验成为%d（%+d）了。", p["名称"], par, new, new - old));
				end
				return true;
			elseif btid==2 then
				return false;
			elseif between(btid,11,10+#attr) then
				sel=btid-10;
				bt[2].enable=true;
			end
		end
	end
end
function TitleManual(fid)
	local width=800;
	local height=360;
	local x0=(CC.ScreenW-width)/2;
	local y0=(CC.ScreenH-height)/2;
	local bt={};
	button_mainbt_2(bt,"决定","返回",1,2,CC.ScreenH-y0-58);
	table.insert(bt,button_creat(1,11,320,y0-32,"自动任命",true,true));
	table.insert(bt,button_creat(1,12,520,y0-32,"各别任命",true,true));
	table.insert(bt,button_creat(1,13,620,y0-32,"全解除",true,true));
	local plist={};
	for i=1,JY.PersonNum-1 do
		if JY.Person[i]["登场"]==3 and JY.Person[i]["势力"]==fid and JY.Person[i]["身份"]<=2 then
			table.insert(plist,i);
			JY.Person[i]["新官爵"]=JY.Person[i]["官爵"];
		end
	end
	local function redraw()
		DrawGame();
		LoadPicEnhance(73,x0,y0,width,height);
		local x,y=x0+64,y0+32;
		for i,pid in ipairs(plist) do
			if JY.Person[pid]["官爵"]~=JY.Person[pid]["新官爵"] then
				local gj1,gj2=JY.Person[pid]["官爵"],JY.Person[pid]["新官爵"];
				DrawStringEnhance(x,y,JY.Person[pid]["名称"],C_WHITE,24);
				DrawStringEnhance(x+128,y,JY.Title[gj1]["名称"],C_WHITE,24);
				DrawStringEnhance(x+256,y,JY.Title[gj2]["名称"],C_WHITE,24);
				y=y+24;
			end
		end
		button_redraw(bt);
	end
	--bt[2].enable=false;
	while true do
		local t1=lib.GetTime();
		redraw();
		ShowScreen();
		local delay=CC.FrameNum-lib.GetTime()+t1;
		if delay>0 then
			lib.Delay(delay);
		end
		getkey();
		local event,btid=button_event(bt);
		if event==3 then
			if btid==1 then
				for i,pid in ipairs(plist) do
					if JY.Person[pid]["官爵"]~=JY.Person[pid]["新官爵"] then
						JY.Person[pid]["官爵"]=JY.Person[pid]["新官爵"];
					end
				end
				return true;
			elseif btid==2 then
				return false;
			elseif btid==11 then
				TitleAuto(fid,true);
			elseif btid==12 then
				TitleSingle(fid);
			elseif btid==13 then
				for i,pid in ipairs(plist) do
					JY.Person[pid]["新官爵"]=0;
				end
			end
		end
	end
end
function TitleAuto(fid,preview)
	local par;
	if preview then
		par="新官爵";
	else
		par="官爵";
	end
	local plist1={};
	local plist2={};
	for i=1,JY.PersonNum-1 do
		if JY.Person[i]["登场"]==3 and JY.Person[i]["势力"]==fid and JY.Person[i]["身份"]<=2 then
			if JY.Person[i]["文武"]==0 then
				table.insert(plist1,i);
			else
				table.insert(plist2,i);
			end
		end
	end
	table.sort(plist1,	function(a,b)
							return JY.Person[a]["统率"]+JY.Person[a]["武力"]+JY.Person[a]["魅力"]*0.5>JY.Person[b]["统率"]+JY.Person[b]["武力"]+JY.Person[b]["魅力"]*0.5;
						end)
	table.sort(plist2,	function(a,b)
							return JY.Person[a]["智谋"]+JY.Person[a]["政务"]+JY.Person[a]["魅力"]*0.5>JY.Person[b]["智谋"]+JY.Person[b]["政务"]+JY.Person[b]["魅力"]*0.5;
						end)
	for i=1,JY.TitleNum-1 do
		local plist;
		if JY.Title[i]["文武"]==0 then
			plist=plist1;
		else
			plist=plist2;
		end
		for id,pid in ipairs(plist) do
			if true then
				JY.Person[pid][par]=i;
				table.remove(plist,id);
				break;
			end
		end
	end
end
function TitleSingle(fid)
	local width=800;
	local height=360;
	local x0=(CC.ScreenW-width)/2;
	local y0=(CC.ScreenH-height)/2;
	local bt={};
	button_mainbt_1(bt,"确认",1,CC.ScreenH-y0-58);
	local ml;
	local plist={};
	local glist={};
	local sortlist={};
	local strlist={};
	local offset={0,90,180,270,360,450};
	local title={"官爵","官阶","保留","保留","保留","人物",};
	for i=1,JY.TitleNum-1 do
		glist[i]=i;
		sortlist[i]={i,JY.Title[i]["官阶"],0,0,0,0};
		strlist[i]={JY.Title[i]["名称"],""..JY.Title[i]["官阶"],"--","--","--",""}
	end
	for i=1,JY.PersonNum-1 do
		if JY.Person[i]["登场"]==3 and JY.Person[i]["势力"]==fid and JY.Person[i]["身份"]<=2 then
			table.insert(plist,i);
			local tid=JY.Person[i]["新官爵"];
			if tid>0 then
				sortlist[tid][6]=i;
				strlist[tid][6]=JY.Person[i]["名称"];
			end
		end
	end
	ml=creatMultiList(x0+32,y0+16,704,height-64,glist,sortlist,strlist,title,offset)
	local ml2;
	local sortlist2={};
	local strlist2={};
	local offset2={0,90,180,270,360,450,540,630,720};
	local title2={"姓名","好感","统","武","智","政","魅","功绩","官爵"};
	for i,pid in ipairs(plist) do
		local p=JY.Person[pid];
		sortlist2[pid]={i,p["好感"],p["统率"],p["武力"],p["智谋"],p["政务"],p["魅力"],0,JY.Title[p["官爵"]]["Rank"]};
		strlist2[pid]={p["名称"],""..p["好感"],""..p["统率"],""..p["武力"],""..p["智谋"],""..p["政务"],""..p["魅力"],"",JY.Title[p["新官爵"]]["名称"]}
	end
	ml2=creatMultiList(x0+32,y0+16,704,height-64,plist,sortlist2,strlist2,title2,offset2)
	local page=2;
	local function redraw()
		DrawGame();
		LoadPicEnhance(73,x0,y0,width,height);
		if page==1 then
			drawMultiList(ml);
		else
			drawMultiList(ml2);
		end
		button_redraw(bt);
	end
	while true do
		local t1=lib.GetTime();
		redraw();
		ShowScreen();
		local delay=CC.FrameNum-lib.GetTime()+t1;
		if delay>0 then
			lib.Delay(delay);
		end
		getkey();
		if page==1 then
			if eventMultiList(ml) then
				local sel=glist[ml.select];
				page=2;
			end
		else
			if eventMultiList(ml2) then
				page=1;
			end
		end
		local event,btid=button_event(bt);
		if event==3 then
			if btid==1 then
				return true;
			elseif btid==2 then
				return false;
			end
		end
	end
end
function TitleInit(fid)
	for i=1,JY.TitleNum-1 do
		JY.Title[i]["人物"]=0;
	end
	for i=1,JY.PersonNum-1 do
		if JY.Person[i]["登场"]==3 and JY.Person[i]["势力"]==fid and JY.Person[i]["身份"]<=2 then
			local tid=JY.Person[i]["官爵"];
			if tid>0 then
				JY.Title[tid]["人物"]=i;
			end
		end
	end
end
function Assign(cid)
	local c=JY.City[cid];
	local s={};
	s[1]={	str="开垦担当官",
			txtdx=60,
			pic=45,
			left=180,
			top=100,
			right=180+118,
			bottom=100+32,}
	s[2]={	str="商业担当官",
			txtdx=60,
			pic=45,
			left=180,
			top=252,
			right=180+118,
			bottom=252+32,}
	s[3]={	str="防御担当官",
			txtdx=60,
			pic=45,
			left=180,
			top=400,
			right=180+118,
			bottom=400+32,}
	s[98]={	str="",	--yes
			txtdx=0,
			pic=24,
			left=CC.ScreenW/2-108+40,
			top=CC.ScreenH-81+8,
			right=CC.ScreenW/2-108+40+66,
			bottom=CC.ScreenH-81+8+46,}
	s[99]={	str="",	--no
			txtdx=0,
			pic=21,
			left=CC.ScreenW/2-108+110,
			top=CC.ScreenH-81+8,
			right=CC.ScreenW/2-108+110+66,
			bottom=CC.ScreenH-81+8+46,}
	local current=0;
	local hold=false;
	local size=20;
	local plist={};
	local t_select={}
	local owner={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}
	for i=1,5 do
		owner[i]=c["开垦担当"..i];
		owner[10+i]=c["商业担当"..i];
		owner[20+i]=c["防御担当"..i];
	end
	local sum={}
	local function getsum()
		sum["政务"]=0;
		for i=1,10 do
			local pid=owner[i];
			if pid>0 then
				sum["政务"]=sum["政务"]+JY.Person[pid]["政务"];
			end
		end
		sum["魅力"]=0;
		for i=11,20 do
			local pid=owner[i];
			if pid>0 then
				sum["魅力"]=sum["魅力"]+JY.Person[pid]["魅力"];
			end
		end
		sum["统率"]=0;
		for i=21,30 do
			local pid=owner[i];
			if pid>0 then
				sum["统率"]=sum["统率"]+JY.Person[pid]["统率"];
			end
		end
	end
	local function redraw()
		DrawGame();
		LoadPicEnhance(73,(CC.ScreenW-800)/2,(CC.ScreenH-480)/2,800,480);
		--yesno
		lib.PicLoadCache(4,11*2,s[98].left-40,s[98].top-8,1);
		--head id
		for i=1,5 do
			local pid=owner[i];
			if pid>0 then
				lib.PicLoadCache(2,(JY.Person[pid]["容貌"]+2000)*2,s[1].right+16+90*(i-1),s[1].bottom-80,1);
				DrawStringEnhance(s[1].right+16+90*(i-1)+45,s[1].bottom+48,JY.Person[pid]["名称"],C_WHITE,size,0.5);
				DrawNumPic(s[1].right+16+90*(i-1)+70,s[1].bottom+32,JY.Person[pid]["政务"]);
			end
			pid=owner[i+10];
			if pid>0 then
				lib.PicLoadCache(2,(JY.Person[pid]["容貌"]+2000)*2,s[2].right+16+90*(i-1),s[2].bottom-80,1);
				DrawStringEnhance(s[2].right+16+90*(i-1)+45,s[2].bottom+48,JY.Person[pid]["名称"],C_WHITE,size,0.5);
				DrawNumPic(s[2].right+16+90*(i-1)+70,s[2].bottom+32,JY.Person[pid]["魅力"]);
			end
			pid=owner[i+20];
			if pid>0 then
				lib.PicLoadCache(2,(JY.Person[pid]["容貌"]+2000)*2,s[3].right+16+90*(i-1),s[3].bottom-80,1);
				DrawStringEnhance(s[3].right+16+90*(i-1)+45,s[3].bottom+48,JY.Person[pid]["名称"],C_WHITE,size,0.5);
				DrawNumPic(s[3].right+16+90*(i-1)+70,s[3].bottom+32,JY.Person[pid]["统率"]);
			end
		end
		--buttle
		for i,v in pairs(s) do
			if current==i then
				if hold then
					lib.PicLoadCache(4,(v.pic+2)*2,v.left,v.top,1);
					DrawStringEnhance(v.left+v.txtdx+1,v.top+7,v.str,C_BLACK,size,0.5);
				else
					lib.PicLoadCache(4,(v.pic+1)*2,v.left,v.top,1);
					DrawStringEnhance(v.left+v.txtdx,v.top+6,v.str,C_BLACK,size,0.5);
				end
			else
				lib.PicLoadCache(4,v.pic*2,v.left,v.top,1);
				DrawStringEnhance(v.left+v.txtdx,v.top+6,v.str,C_BLACK,size,0.5);
			end
		end
		DrawStringEnhance(s[1].left+s[1].txtdx,s[1].bottom+6,"总政务",C_WHITE,size,0.9);	DrawNumPicBig(s[1].left+90,s[1].bottom+5,sum["政务"]);
		DrawStringEnhance(s[2].left+s[2].txtdx,s[2].bottom+6,"总魅力",C_WHITE,size,0.9);	DrawNumPicBig(s[2].left+90,s[2].bottom+5,sum["魅力"]);
		DrawStringEnhance(s[3].left+s[3].txtdx,s[3].bottom+6,"总统率",C_WHITE,size,0.9);	DrawNumPicBig(s[3].left+90,s[3].bottom+5,sum["统率"]);
	end
	getsum();
	while true do
		local t1=lib.GetTime();
		redraw();
		ShowScreen();
		local delay=CC.FrameNum-lib.GetTime()+t1;
		if delay>0 then
			lib.Delay(delay);
		end
		getkey();
		current=0;
		hold=false;
		local order={"政务","魅力","统率"};
		for i,v in pairs(s) do
			if MOUSE.CLICK(v.left,v.top,v.right,v.bottom) then
				current=i;
				PlayWavE(0);
				if between(current,1,3) then
					plist={}
					for id,v in pairs(JY.Person) do
						if id~=JY.PID and v["势力"]==JY.FID and v["所在"]==cid then
							local flag=true;
							for ii,vv in pairs(owner) do
								if vv>0 and (not between(ii,1+10*(current-1),10+10*(current-1))) and vv==id then
									flag=false;
									break;
								end
							end
							if flag then
								table.insert(plist,id);
							end
						end
					end
					t_select={};
					for ii=1,10 do
						if owner[ii+10*(current-1)]>0 then
							t_select[ii]=owner[ii+10*(current-1)];
						else
							break;
						end
					end
					t_select=ShowPersonList(plist,order[i],nil,5,t_select);
					for ii=1,10 do
						if ii<=#t_select then
							owner[ii+10*(current-1)]=t_select[ii];
						else
							owner[ii+10*(current-1)]=0;
						end
					end
					getsum();
				elseif current==4 then
				elseif current==98 then
					for i=1,5 do
						c["开垦担当"..i]=owner[i];
						c["商业担当"..i]=owner[10+i];
						c["防御担当"..i]=owner[20+i];
					end
					return true;
				elseif current==99 then
					return false;
				end
			elseif MOUSE.HOLD(v.left,v.top,v.right,v.bottom) then
				current=i;
				hold=true;
				break;
			elseif MOUSE.IN(v.left,v.top,v.right,v.bottom) then
				current=i;
				break;
			end
		end
	end
end
function ValueAdjust(v, maxv)
	local adj = 0.2;
	local a = 1 / maxv / ((1 + adj) * (1 + adj) - adj * adj);
	local b = maxv * adj;
	local c = a * b * b;
	return a * (v + b) * (v + b) - c;
end
function Asura_CityGrow()
	for cid = 1, JY.CityNum - 1 do
    local city = JY.City[cid];
		local fid = city["势力"];
    local pid = city["太守"];
    --人口每月增长  增长量和人口平方根正比(增长率随随人口增加而降低)，随治安下降而下降，盗贼出现则不增长
    --人口 500‘00 ~ 30000’00
    if true then  --暂未考虑盗贼
      local grow = math.floor( (city["人口"] ^ 0.5) / 10 * limitX((city["治安"] - 600) / 400, -1.5, 1) * (2 + math.random() - math.random()) );
      city["人口"] = limitX( city["人口"] + grow, 500, 30000 );
    end
    --金，每季度增长
    --金收入= (商业值 + 100)*(10+太守魅力+民忠)/200
    if pid > 0 and JY.Base["当前月"] % 3 == 1 then
      local grow = city["商业"] / 10 * (1 + limitX(city["人口"] / 5000, 0, 2) +  15/ limitX(110 - JY.Person[pid]["魅力"], 10, 110));
      if city["特征"] == 3 then --交易都市
        grow = grow * 1.2;
      end
      grow = math.floor(grow);
      city["资金"] = limitX(city["资金"] + grow, 0, 10000);
    end
    --粮，每年7月增长
    if pid > 0 and JY.Base["当前月"] == 7 then
      local grow = 4 * city["开垦"] / 10 * (1 + limitX(city["人口"] / 5000, 0, 2) +  15/ limitX(110 - JY.Person[pid]["魅力"], 10, 110));
      grow = math.floor(grow);
      city["物资"] = limitX(city["物资"] + grow, 0, 10000);
    end
    --俸禄, 每月支付
    if fid > 0 and city["现役"] > 0 then
      city["资金"] = city["资金"] - city["现役"] * 1;
      if city["资金"] < 0 then
        city["资金"] = 0;
      end
    end
    --军饷, 每月支付
    if fid > 0 and city["兵力"] > 0 then
      city["物资"] = city["物资"] - math.ceil(city["兵力"] / 500);
      if city["物资"] < 0 then
        city["物资"] = 0;
      end
    end
	end
end
function AsuraGenTalkString(index,pid,eid)
	local id=JY.Person[pid]["台词"];
	local txt_id;
	local str;
	if index==01 then
		
	elseif index==14 then			--形势逆转
		txt_id=math.random(6261,6280);
	elseif index==20 then			--突击
		txt_id=math.random(6381,6390);
	elseif index==21 then			--死守
		txt_id=math.random(6401,6410);
	elseif index==29 then			--埋伏
		txt_id=math.random(6561,6580);
	elseif index==30 then			--战斗开始 优势
		txt_id=math.random(6581,6587);
	elseif index==31 then			--战斗开始 劣势
		txt_id=math.random(6601,6609);
	elseif index==40 then			--流放
		txt_id=math.random(6781,6788);
	elseif index==41 then		--探索-失败
		txt_id=math.random(6801,6815);
	elseif index==42 then		--探索-成功
		txt_id=math.random(6821,6827);
	elseif index==43 then		--登用
		txt_id=math.random(6841,6851);
	elseif index==44 then		--登用-成功
		txt_id=math.random(6861,6875);
	elseif index==45 then		--登用-失败
		txt_id=math.random(6881,6896);
	else
		txt_id=index;
	end
	if id>=0 then
		if index==01 then
			
		elseif index==14 then
			txt_id=50*id+14;
		elseif index==20 then
			txt_id=50*id+20;
		elseif index==21 then
			txt_id=50*id+21;
		elseif index==29 then
			txt_id=50*id+29;
		elseif index==30 then
			txt_id=50*id+30;
		elseif index==31 then
			txt_id=50*id+31;
		elseif index==43 then
			txt_id=50*id+10;
		elseif index==44 then
			txt_id=50*id+4;
		end
	end
	str=JY.Str[txt_id];
	str=string.gsub(str,"$N","[Green]"..JY.Person[pid]["名称"].."[Normal]");
	str=string.gsub(str,"$C","[Red]"..JY.Person[pid]["外号"].."[Normal]");
	str=string.gsub(str,"$n","[Green]"..JY.Person[eid]["名称"].."[Normal]");
	str=string.gsub(str,"$c","[Red]"..JY.Person[eid]["外号"].."[Normal]");
	--str=string.gsub(str,"*","\\n");
	return str;
end
function TableRandom(t)
	local n=#t;
	local r=-1;
	if n==1 then
		r=t[1];
		table.remove(t,1);
	elseif n>1 then
		n=math.random(n);
		r=t[n];
		table.remove(t,n);
	end
	return r;
end
function Sample(t,n)
  if n >= #t then
    return t;
  else
    local r = {};
    for i = 1, n do
      table.insert(r, TableRandom(t))
    end
    return r;
  end
end
function PercentRandom(t)
	local pt = {};
	local pv = 0;
	pt[0] = pv;
	for i, v in ipairs(t) do
    if v > 0 then
      pv = pv + v;
    end
		pt[i] = pv;
	end
	if pv == 0 then
		return 0;
	end
	local v = math.random() * pv;
	for i = 1, #t do
		if v >= pt[i-1] and v < pt[i] then
			return i;
		end
	end
	return 1;
end
function GetCityPT(cid)
	local pt=4;
	pt=pt+4*JY.City[cid]["规模"];
	pt=pt+2*JY.City[cid]["规模"];
	return pt;
end
function FilterPerson(fid,pt,bc_flag)
	local plist={};
	local rndlist={}
	local rlist={};
	local snum=20;
	local cpt=0;
	local jid=JY.Force[fid]["君主"];
	JY.Person[jid]["出战"]=1;
	for i=1,JY.PersonNum-1 do
		if JY.Person[i]["势力"]==fid and JY.Person[i]["出战"]==0 then
			table.insert(plist,i);
		end
	end
	if #plist>snum then
		table.sort(plist,function(a,b) if JY.Person[a]["名声"]>JY.Person[b]["名声"] then return true end end)
	end
	if bc_flag then
		for rpt=1,2 do
			local pid=plist[1];
			if pid~=nil then
				table.insert(rlist,pid);
				table.remove(plist,1);
			end
		end
	end
	snum=math.min(#plist,snum)
	for i=1,snum do
		local pid=plist[i];
		if JY.Person[pid]["文武"]==1 then
			table.insert(rndlist,JY.Person[pid]["名声"]);
		else
			table.insert(rndlist,JY.Person[pid]["名声"]/2);
		end
	end
	for i=1,snum do
		local r=PercentRandom(rndlist);
		local pid=plist[r];
		rndlist[r]=0;
		cpt=cpt+1+JY.Person[pid]["品级"];
		table.insert(rlist,pid);
		if cpt>pt then
			break;
		end
	end
	--table.sort(rlist,function(a,b) if JY.Person[a]["名声"]>JY.Person[b]["名声"] then return true end end)
	table.sort(rlist,function(a,b)
						local av,bv=JY.Person[a]["武力"]+JY.Person[a]["统率"],JY.Person[b]["武力"]+JY.Person[b]["统率"];
						if between(JY.Person[a]["兵种"],24,29) then
							av=av/4;
						elseif between(JY.Person[a]["兵种"],7,12) then
							av=av/2;
						end
						if between(JY.Person[b]["兵种"],24,29) then
							bv=bv/4;
						elseif between(JY.Person[b]["兵种"],7,12) then
							bv=bv/2;
						end
						if av>bv then
							return true;
						end
					end)
	--table.sort(rlist,function(a,b) if JY.Person[a]["文武"]<JY.Person[b]["文武"] then return true end end)
	if bc_flag then
		table.insert(rlist,1,jid);
	end
	for i,v in ipairs(rlist) do
		JY.Person[v]["出战"]=1;
	end
	return rlist;
end
function RND(v)
	if math.random()>v then
		return false;
	else
		return true;
	end
end
function GenClassC(leader,oid)
	local plistC={};
	for i=1,JY.PersonNum-1 do
		if JY.Person[i]["出战"]==0 and JY.Person[i]["势力"]==JY.Person[leader]["势力"] then --and GetXX(i,leader)<30 then
			if JY.Person[i]["品级"]==1 then
				table.insert(plistC,i);
			end
		end
	end
	if #plistC>0 then
		return TableRandom(plistC);
	else
		return oid;
	end
end
function BodyGuard(pid,oid);
	local kid=JY.Person[pid]["统兵"];
	local str=JY.Person[oid]["名称"];
	if kid==1 then	--步兵转为贼兵
		if str=="步兵队" then
			oid=GenPerson(true,pid,"贼兵");
		end
	end
	return oid;
end
function GenPerson(flag,leader,name,name2)
	local plist={};
	local function basecheck(pid)
		if JY.Person[pid]["登场"]>=0 and JY.Person[pid]["出战"]==0 and JY.Person[pid]["势力"]==JY.Person[leader]["势力"] and GetXX(pid,leader)<30 then
			return true;
		else
			return false;
		end
	end
	if not flag then
		if name2==nil then
			if name=="统率" then
				name=TableRandom({"步兵队","步兵队","步兵队","步兵队","骑兵队"});
			elseif name=="武力" then
				name=TableRandom({"骑兵队","骑兵队","骑兵队","骑兵队","步兵队"});
			elseif name=="智谋" then
				name=TableRandom({"弓兵队","弓兵队","弓兵队","弓兵队","贼兵"});
			elseif name=="万能" then
				name=TableRandom({"步兵队","弓兵队","骑兵队","贼兵","步兵队"});
			elseif name=="步将" then
				name=TableRandom({"步兵队","步兵队","步兵队","步兵队","步兵队"});
			elseif name=="骑将" then
				name=TableRandom({"骑兵队","骑兵队","骑兵队","骑兵队","骑兵队"});
			elseif name=="弓将" then
				name=TableRandom({"弓兵队","弓兵队","弓兵队","弓兵队","弓兵队"});
			elseif name=="贼将" then
				name=TableRandom({"贼兵","贼兵","贼兵","贼兵","贼兵"});
			elseif name=="谋将" then
				name=TableRandom({"弓兵队","弓兵队","弓兵队","弓兵队","贼兵"});
			elseif name=="特将" then
				name=TableRandom({"步兵队","弓兵队","骑兵队","贼兵","步兵队"});
			else
				name="";
				return -1;
			end
		else
			name=name2;
		end
	end
	if name=="统率" then
		plist={};
		for id=1,JY.PersonNum-1 do
			if basecheck(id) and between(JY.Person[id]["武力"],60,85) and math.max(JY.Person[id]["统率"],JY.Person[id]["智谋"])<JY.Person[id]["武力"] then
				table.insert(plist,id);
			end
		end
		if #plist>0 then
			return TableRandom(plist);
		end
	elseif name=="武力" then
		plist={};
		for id=1,JY.PersonNum-1 do
			if basecheck(id) and between(JY.Person[id]["武力"],60,85) and math.max(JY.Person[id]["统率"],JY.Person[id]["智谋"])<JY.Person[id]["武力"] then
				table.insert(plist,id);
			end
		end
		if #plist>0 then
			return TableRandom(plist);
		end
	elseif name=="智谋" then
		plist={};
		for id=1,JY.PersonNum-1 do
			if basecheck(id) and between(JY.Person[id]["智谋"],60,85) and math.max(JY.Person[id]["统率"],JY.Person[id]["武力"])<JY.Person[id]["智谋"] then
				table.insert(plist,id);
			end
		end
		if #plist>0 then
			return TableRandom(plist);
		end
	elseif name=="万能" then
		plist={};
		for id=1,JY.PersonNum-1 do
			if basecheck(id) and between(math.max(JY.Person[id]["统率"],JY.Person[id]["智谋"],JY.Person[id]["武力"]),60,80) and between(math.min(JY.Person[id]["统率"],JY.Person[id]["智谋"],JY.Person[id]["武力"]),60,80) then
				table.insert(plist,id);
			end
		end
		if #plist>0 then
			return TableRandom(plist);
		end
	elseif name=="步将" then
		plist={};
		for id=1,JY.PersonNum-1 do
			if basecheck(id) and between(JY.Person[id]["兵种"],1,6) and between(math.max(JY.Person[id]["统率"],JY.Person[id]["武力"]),60,90) then
				table.insert(plist,id);
			end
		end
		if #plist>0 then
			return TableRandom(plist);
		end
	elseif name=="骑将" then
		plist={};
		for id=1,JY.PersonNum-1 do
			if basecheck(id) and between(JY.Person[id]["兵种"],13,18) and between(math.max(JY.Person[id]["统率"],JY.Person[id]["武力"]),60,90) then
				table.insert(plist,id);
			end
		end
		if #plist>0 then
			return TableRandom(plist);
		end
	elseif name=="弓将" then
		plist={};
		for id=1,JY.PersonNum-1 do
			if basecheck(id) and between(JY.Person[id]["兵种"],7,12) and between(math.max(JY.Person[id]["统率"],JY.Person[id]["武力"]),60,90) then
				table.insert(plist,id);
			end
		end
		if #plist>0 then
			return TableRandom(plist);
		end
	elseif name=="贼将" then
		plist={};
		for id=1,JY.PersonNum-1 do
			if basecheck(id) and between(JY.Person[id]["兵种"],19,23) and between(math.max(JY.Person[id]["统率"],JY.Person[id]["武力"]),60,90) then
				table.insert(plist,id);
			end
		end
		if #plist>0 then
			return TableRandom(plist);
		end
	elseif name=="谋将" then
		plist={};
		for id=1,JY.PersonNum-1 do
			if basecheck(id) and between(JY.Person[id]["兵种"],24,29) and between(math.max(JY.Person[id]["统率"],JY.Person[id]["智谋"]),60,90) then
				table.insert(plist,id);
			end
		end
		if #plist>0 then
			return TableRandom(plist);
		end
	elseif name=="特将" then
		plist={};
		for id=1,JY.PersonNum-1 do
			if basecheck(id) and (between(JY.Person[id]["兵种"],30,32) or between(JY.Person[id]["兵种"],35,48)) and between(math.max(JY.Person[id]["统率"],JY.Person[id]["智谋"],JY.Person[id]["武力"]),60,90) then
				table.insert(plist,id);
			end
		end
		if #plist>0 then
			return TableRandom(plist);
		end
	elseif #name>0 then
		for id=1001,JY.PersonNum-1 do
			if JY.Person[id]["名称"]==name and JY.Person[id]["出战"]==0 then
				return id;
			end
		end
	end
	--for others
	plist={};
	for id=1001,JY.PersonNum-1 do
		if JY.Person[id]["出战"]==0 then
			table.insert(plist,id);
		end
	end
	return TableRandom(plist);




end
function PlayCityBGM(cid, war)
  if cid > 0 then
    local mid = JY.City[cid]["音乐"];
    if war then
      mid = mid + 10;
    end
    PlayBGM(mid);
  end
end
function isLike(pid, eid)
  for i = 1, 5 do
    local id = JY.Person[pid]["亲近武将" .. i];
    if id == 0 then
      break;
    elseif id == eid then
      return true;
    end
  end
  for i = 1, 5 do
    local id = JY.Person[eid]["亲近武将" .. i];
    if id == 0 then
      break;
    elseif id == pid then
      return true;
    end
  end
  return false;
end
function isHate(pid, eid)
  for i = 1, 5 do
    local id = JY.Person[pid]["厌恶武将" .. i];
    if id == 0 then
      break;
    elseif id == eid then
      return true;
    end
  end
  for i = 1, 5 do
    local id = JY.Person[eid]["厌恶武将" .. i];
    if id == 0 then
      break;
    elseif id == pid then
      return true;
    end
  end
  return false;
end
--Scenario
function ScenarioInit()
	local sid=JY.Base["当前剧本"];
	JY.Base["当前年"]=252;
	JY.Base["当前月"]=3;
	for fid=1,52 do
		JY.Force[fid]["状态"]=JY.Force[fid]["状态-剧本"..sid];
		JY.Force[fid]["君主"]=JY.Force[fid]["君主-剧本"..sid];
		JY.Force[fid]["官爵"]=JY.Force[fid]["官爵-剧本"..sid];
		JY.Force[fid]["本城"]=JY.Force[fid]["本城-剧本"..sid];
		JY.Force[fid]["名称"]=JY.Person[JY.Force[fid]["君主"]]["名称"].."军"
	end
	for pid=1,1000 do
		JY.Person[pid]["登场"]=JY.Person[pid]["登场-剧本"..sid];
		JY.Person[pid]["势力"]=JY.Person[pid]["势力-剧本"..sid];
		JY.Person[pid]["所在"]=JY.Person[pid]["所在-剧本"..sid];
		JY.Person[pid]["忠诚"]=JY.Person[pid]["忠诚-剧本"..sid];
		JY.Person[pid]["功绩"]=JY.Person[pid]["功绩-剧本"..sid];
		if JY.Person[pid]["所在"]==0 then
			JY.Person[pid]["所在"]=math.random(1,50);
		end
		if JY.Person[pid]["势力"]>0 then
			JY.Person[pid]["身份"]=1;	--一般
		else
			JY.Person[pid]["身份"]=0;	--在野
		end
	end
	for cid=1,50 do
		JY.City[cid]["势力"]=JY.City[cid]["势力-剧本"..sid];
		JY.City[cid]["太守"]=JY.City[cid]["太守-剧本"..sid];
		local pid=JY.City[cid]["太守"];
		if pid>0 then
			JY.Person[pid]["身份"]=2;	--太守
		end
	end
	for fid=1,52 do
		local pid=JY.Force[fid]["君主"];
		if pid>0 then
			JY.Person[pid]["身份"]=3;	--君主
		end
	end
	UpdateForce();
	for i,c in ipairs(JY.City) do
		--c["繁荣"]=c["规模"]*100+math.random(10)-math.random(10);
	end
	if sid==3 then
		--JY.City[18]["繁荣"]=10;
	end
	for fid=1,52 do
		local zj,wz=0,0;
		zj=zj+JY.Force[fid]["官爵"]*10;
		wz=wz+JY.Force[fid]["官爵"]*10;
		if zj>0 then
			JY.Force[fid]["资金"]=80+math.floor(zj*10);
		end
		if wz>0 then
			JY.Force[fid]["物资"]=80+math.floor(wz*10);
		end
	end
end
--Force Relate
function NewForce(fid,pid,cid)
	local f=JY.Force[fid];
	f["名称"]=JY.Person[pid]["名称"].."军";
	f["状态"]=1;
	f["君主"]=pid;
	JY.Person[pid]["登场"]=3;
	f["官爵"]=0;
	f["本城"]=cid;
	JY.City[cid]["势力"]=fid;
	f["战略"]=0;
	f["资金"]=80+math.floor((3+JY.City[cid]["商业"])*JY.City[cid]["繁荣"]/20);
	f["物资"]=80+math.floor((3+JY.City[cid]["农业"])*JY.City[cid]["繁荣"]/20);
end
function SelectForce(fid)
	local f=JY.Force[fid];
	JY.PID=f["君主"];
	JY.FID=fid;
	JY.Base["当前城池"]=f["本城"];
	JY.Base["行动力"]=3+f["官爵"];
end
function UpdateCity(cid)
  local c = JY.City[cid];
  local fid = c["势力"];
  local frontLine = 0;
  local ptA = 0;
  local ptB = 0;
  if fid > 0 then
    ptA = ptA + c["规模"] * 5;
    for i, v in pairs(JY.CityToCity[cid]) do
      ptA = ptA + 20;
      if JY.City[i]["势力"] > 0 and JY.City[i]["势力"] ~= fid then
        ptA = ptA + JY.City[i]["兵力"] / 2000;
        frontLine = 1;
      end
    end
    ptB = ptB + limitX(c["人口"] / 10, 0, 1000);
    if frontLine > 0 then
      ptB = ptB / 2;
    else
    end
    if c["特征"] == 1 or c["特征"] == 2 then
      ptB = ptB * 1.2;
    elseif c["特征"] == 4 then
      ptA = ptA * 1.2;
    elseif c["特征"] == 5 then
      ptA = ptA * 1.1;
    end
    if JY.Force[fid]["本城"] == cid then
      ptA = ptA * 1.5;
      ptB = ptB * 1.5;
    end
    ptA = math.floor(ptA);
    ptB = math.floor(ptB);
  end
  c["前线"] = frontLine;
  c["战略价值"] = ptA;
  c["政略价值"] = ptB;
end
function UpdateForcePersonNum(fid)
	local num=0;
	for pid,v in ipairs(JY.Person) do
		if v["势力"]==fid then
			num=num+1;
		end
	end
	JY.Force[fid]["现役"]=num;
end
function UpdateForce()
	--Reset all
	for fid,v in pairs(JY.Force) do
		v["城池"]=0;
		v["现役"]=0;
	end
	for cid,v in ipairs(JY.City) do
		local fid=v["势力"];
		v["现役"]=0;
		v["在野"]=0;
    UpdateCity(cid);
	end
	ConnectCity();
	--Person
	for pid,v in ipairs(JY.Person) do
		if v["登场"]==2 or v["登场"]==3 then
			local cid=v["所在"];
			if cid>0 then
				local fid=v["势力"];
				if fid>0 then
					JY.City[cid]["现役"]=JY.City[cid]["现役"]+1;
				else
					JY.City[cid]["在野"]=JY.City[cid]["在野"]+1;
				end
			end
		end
	end
	--City
	for cid,v in ipairs(JY.City) do
		local fid=v["势力"];
		if fid>0 then
			JY.Force[fid]["城池"]=JY.Force[fid]["城池"]+1;
			JY.Force[fid]["现役"]=JY.Force[fid]["现役"]+v["现役"];
		end
	end
	--Force
	for fid,v in pairs(JY.Force) do
		if v["状态"]>0 then
			if v["城池"]==0 then
				Talk("传令",string.format("[Green]%s[Normal]大人，[Red]%s[Normal]灭亡了。",JY.Person[JY.PID]["名称"],JY.Force[fid]["名称"]));
				v["状态"]=0;
				break;
			else
				local bcid=v["本城"];
				if JY.City[bcid]["势力"]~=fid then
					local t_city={};
					for j,w in ipairs(JY.City) do
						if w["势力"]==fid then
							table.insert(t_city,j);
						end
					end
					table.sort(t_city,function(a,b) if JY.City[a]["规模"]+JY.City[a]["防御"]>JY.City[b]["规模"]+JY.City[b]["防御"] then return true end end)
					local nbc=t_city[1];
					v["本城"]=nbc;
					Talk("传令",string.format("[Green]%s[Normal]大人，[Red]%s[Normal]迁移本城至[Red]%s[Normal]了。",JY.Person[JY.PID]["名称"],JY.Force[fid]["名称"],JY.City[nbc]["名称"]));
				end
			end
		end
	end
	--ZhongCheng
	for fid,v in pairs(JY.Force) do
		if v["状态"]>0 then
			ZhongCheng(fid);
		end
	end
end
function ZhongCheng(fid)
	local t={};
	for i,v in ipairs(JY.Person) do
		if v["势力"]==fid then
			if i~=JY.Force[fid]["君主"] then
				table.insert(t,{id=i,v=v["名声"]});
			end
		end
	end
	table.sort(t,function(a,b) return a.v>b.v end);
	local n=#t;
	for i=1,6 do
		JY.Force[fid]["重臣"..i]=0;
	end
	for i=1,math.min(n,6) do
		JY.Force[fid]["重臣"..i]=t[i].id;
	end
end
function occupyCity(fid, cid)
  local c = JY.City[cid];
  local eForce = c["势力"];
  
  c["势力"] = fid;
  c["太守"] = 0;
  if eForce == 0 then
    return;
  end
  
  local retreatCityList = {};
  for i, v in pairs(JY.CityToCity[cid]) do
    if JY.City[i]["势力"] == c["势力"] then
      table.insert(retreatCityList, i);
    end
  end
  local retreatCity = 0;
  if #retreatCityList > 0 then
    retreatCity = TableRandom(retreatCityList);
  end
  local master = JY.Force[fid]["君主"];
  for i = 1, 750 do
    if JY.Person[i]["势力"] == eForce and JY.Person[i]["所在"] == cid then
      JY.Person[i]["身份"] = 1;
      if retreatCity > 0 and math.random() < 0.1 + math.max(JY.Person[i]["武力"], JY.Person[i]["智谋"]) / 125 then  -- 撤退成功几率
        JY.Person[i]["所在"] = retreatCity;
      elseif true then
        dispathPrisoner(fid, i);
      elseif GetXX(i, master) < math.random(100) then --降伏
        JY.Person[i]["势力"] = fid;
      else
        JY.Person[i]["势力"] = 0;
        JY.Person[i]["身份"] = 0;
      end
    end
  end
  
end
function dispathPrisoner(fid, pid)
  local bt = {};
  local width, height = 800, 360;
  local x0, y0 = (CC.ScreenW - width) / 2, (CC.ScreenH - height) / 2;
  table.insert(bt, button_creat(1, 1, CC.ScreenW / 2 + 0, CC.ScreenH - y0 - 72, "劝降", true, true));
  table.insert(bt, button_creat(1, 2, CC.ScreenW / 2 + 104, CC.ScreenH - y0 - 72, "处斩", true, true));
  table.insert(bt, button_creat(1, 3, CC.ScreenW / 2 + 208, CC.ScreenH - y0 - 72, "释放", true, true));
  local p = JY.Person[pid];
  local str = genPrisonerString(pid);
  local function redraw()
		DrawGame();
    local size = 20;
    local x, y = x0, y0;
    LoadPicEnhance(73, x, y, width, height);
    x = x + 96; y = y + 10;
    lib.PicLoadCache(2, p["容貌"] * 2, x, y, 1, nil, nil, nil, 340);
    x = x - 32; y = y0 + height - 80;
		LoadPicEnhance(207, x - 40, y - 16, 320 + 80, 96);
		DrawStringEnhance(x + 36, y ,p["名称"], C_ORANGE, size, 0.5);
		DrawStringEnhance(x + 72, y ,str, M_White, size);
    --drawAttribute
    x = x0 + width / 2; y = y0 + 32;
    DrawStringEnhance(x, y, p["名称"] .. " " .. p["字"], C_WHITE, size);
    y = y + size + 4;
    DrawStringEnhance(x, y, string.format("统率 [w]%3d[name] 武力 [w]%3d[name] 智谋 [w]%3d[n][name]政务 [w]%3d[name] 魅力 [w]%3d", p["统率"], p["武力"], p["智谋"], p["政务"], p["魅力"]), C_Name, size);
    y = y + (size + 2) * 2;
    DrawStringEnhance(x, y, "步兵  [w]" .. JY.Str[p["步兵适性"] + 9160] .. " [name]弓兵  [w]" .. JY.Str[p["弓兵适性"] + 9160] .. " [name]骑兵  [w]" .. JY.Str[p["骑兵适性"] + 9160], C_Name, size);
    y = y + (size + 4);
    DrawSkillTable(pid, x, y);
    
    x, y = CC.ScreenW / 2, y0 - 36;
    lib.PicLoadCache(4, 4 * 2, x, y);
    DrawStringEnhance(x, y, "处置俘虏", C_WHITE, 36, 0.5, 0.5);
		button_redraw(bt);
  end
  local master = JY.Force[fid]["君主"];
  local obeyFlag = false;
  if GetXX(pid, master) < math.random(100) then
    obeyFlag = true;
  end
	while true do
		local t1 = lib.GetTime();
		redraw();
		ShowScreen();
		local delay = CC.FrameNum - lib.GetTime() + t1;
		if delay > 0 then
			lib.Delay(delay);
		end
		getkey();
		local event, btid = button_event(bt);
		if event == 3 then
			if btid == 1 then
        if obeyFlag then
          DrawGame();
          Talk(pid, genPrisonerApproveString(pid));
          return;
        else
          str = genPrisonerRejectString(pid);
        end
			elseif btid == 2 then
        DrawGame();
        Talk(pid, genPrisonerKillString(pid));
        return;
			elseif btid == 3 then
        DrawGame();
        Talk(pid, genPrisonerReleaseString(pid));
				return;
			end
		end
	end 
end
function genPrisonerString(pid)
  local str = {
    "偏偏是" .. JY.Person[pid]["名称"] .. "……",
    "能否让我见见兄长，[n]我想与他告别。",
    "若此，[n]但求一死，别无他言。",
    "……",
    "忠臣不侍二主，[n]我已经想好了。",
    "后悔啊……",
    "随便吧！",
    "这次只不过是运气不佳，[n]下次不会败给你。",
    "哼，为什么我会在这里？",
    "终于我也失去了武运。",
    "事已至此，[n]只好听天由命了。",
    "能活至今，[n]已无怨无悔……",
    "这就是我的末日吗，[n]真不过瘾……",
  };
  return TableRandom(str);
end
function genPrisonerApproveString(pid)
  local str = {
    "您能救我吗？[n]太好了。",
    "这或许也是缘分，[n]愿意为您效劳。",
    "知道了。[n]从今我愿帮助孙权大人。",
    "有生于世才能侍奉天下，[n]愿舍身效劳。",
    "这也是为了天下安宁，[n]我降伏于您了。",
    "与兄长共同战斗也不坏，[n]愿意效劳。",
    "这样实属不得已，[n]但求妥善处之。",
    "我渴望的不只是战斗……，[n]希望对您有所帮助。",
  };
  return TableRandom(str);
end
function genPrisonerRejectString(pid)
  local str = {
    "我不能厚颜无耻地生存！",
    "想说服我吗， 休想，[n]死了这条心吧！",
    "那是不可能的事。",
    "忠臣不侍二主。",
  };
  return TableRandom(str);
end
function genPrisonerReleaseString(pid)
  local str = {
    "事虽难得，但请记住，[n]战场上不讲人情。",
    "是说要释放我吗？[n]……感谢。",
    "致谢了。",
    "下次不会同样对待。",
    "下次再见吧。",
    "早晚会让你后悔[n]今天没能杀掉我。",
    "是吗，可别后悔哦。",
  };
  return TableRandom(str);
end
function genPrisonerKillString(pid)
  local fid = JY.Person[pid]["势力"];
  local id = JY.Force[fid]["君主"];
  local name = JY.Person[id]["名称"];
  local str = {
    "对不起" .. name .."大人，[n]不能再为您效劳了。",
    name .."大人，请原谅。",
    "这一定是什么地方搞错了。",
    "能够为像" .. name .."大人那样的先生效劳过，[n]不后悔。",
    "到此为止吗，[n]" .. name .."大人，对不起。",
  };
  return TableRandom(str);
end