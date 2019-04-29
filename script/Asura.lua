function AsuraMain()
	JY.Status=GAME_START;  --��Ϸ��ǰ״̬
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
		elseif JY.Status==GAME_WMAP2 then	--����ս��
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
				{"��ʼ��Ϸ",nil,1,true},
				{"��ȡ�浵",nil,1,true},
				{"�����趨",nil,0,true},
				{"ս������",nil,1,true},
				{"ȫ�佫",nil,1,true},
				{"������",nil,1,true},
				{"��������",nil,1,true},
				{"�����ʴ�",nil,1,true},
				{"���ݵ�",nil,1,true},
				{"������",nil,1,true},
				{"����ɱ",nil,1,true},
				{"�˳���Ϸ",nil,1,true},
				{"����Lua",nil,0,true},
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
			if WarDrawStrBoxYesNo('������Ϸ��',C_WHITE,true) then
				lib.Delay(100);
				if WarDrawStrBoxYesNo('����һ����',C_WHITE,true) then
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
	local Scenario={	{"184��  "..JY.Str[9121],			nil,1,true};	--01
						{"190��  "..JY.Str[9122],			nil,1,true};	--02
						{"195��  "..JY.Str[9123],			nil,1,true};	--03
						{"200��  "..JY.Str[9124],			nil,1,true};	--04
						{"207��  "..JY.Str[9125],			nil,1,true};	--05
						{"214��  "..JY.Str[9126],			nil,1,true};	--06
						{"???��  "..JY.Str[9127],			nil,0,true};	--07
						{"???��  "..JY.Str[9128],			nil,0,true};	--08
						{"???��  "..JY.Str[9129],			nil,0,true};	--09
						{"???��  "..JY.Str[9130],			nil,0,true};	--10
						{"252��  "..JY.Str[9131],			nil,1,true};	--11
						{"???��  "..JY.Str[9132],			nil,0,true};	--12
						{"???��  "..JY.Str[9133],			nil,0,true};	--13
						{"???��  "..JY.Str[9134],			nil,0,true};	--14
						{"???��  "..JY.Str[9135],			nil,0,true};	--15
						{"???��  "..JY.Str[9136],			nil,0,true};	--16
						{"???��  "..JY.Str[9137],			nil,0,true};	--17
						{"???��  "..JY.Str[9138],			nil,0,true};	--18
						{"???��  "..JY.Str[9139],			nil,0,true};	--19
						{"???��  "..JY.Str[9140],			nil,0,true};	}	--20
	local gtype={		{"ʹ��������",						nil,1,true};
						{"ʹ��ʷʵ����",					nil,1,true};	}
	local step=1;
	
	SetSceneID(201);
	while step<6 do
		if step==1 then	--�籾
			local r=TalkMenuEx("����",gid,"��ӭ��[n]��ѡ��һ���籾��",Scenario);
			if r>0 then
				JY.Base["��ǰ�籾"]=r;
				Confirm("[Orange][b]"..JY.Str[9120+r],JY.Str[9140+r])
				step=2;
			else
				step=9;
			end
		elseif step==2 then	--��ɫ
			ScenarioInit();
			local pid=ShowPersonList(GetAllList(),nil,2);
			if pid>0 then
				JY.PID=pid;
				step=5;
			else
				step=1;
			end
			--[[
		elseif step==2 then	--��ɫ
			local r=TalkMenuEx("����",gid,"��ѡ����ʹ����������[n]����ʹ��ʷʵ����",gtype);
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
			JY.Person[npid]["����"]=IniName();
			JY.Person[npid]["�ȼ�"]=4;
			--JY.Person[npid]["����"]=CC.Exp[4];
			NewPerson(npid);	--��ʼ������
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
			JY.Status=GAME_SMAP_MANUAL;  --��Ϸ��ǰ״̬
			DoEvent(0100+JY.Base["��ǰ�籾"]);
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
		if JY.Person[i]["����"]==JY.FID and i~=JY.PID then
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
		--	if v["����"]>0 then
		--		local x,y=v["����X"],v["����Y"];
		--		local str=JY.Person[v["����"]]["����"];
		--		if JY.Tid==v["����"] then
		--			lib.PicLoadCache(2,(JY.Person[v["����"]]["��ò"]+4000)*2,x+4,y+4,1);
		--			lib.PicLoadCache(4,2*2,x,y,1);
		--			DrawStringEnhance(x+49-size*#str/4+1,y+141-size/2+1,str,C_Name,size);
		--		else
		--			lib.PicLoadCache(2,(JY.Person[v["����"]]["��ò"]+4000)*2,x+3,y+3,1);
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
					DrawYJZBox(-1,12,"�鱨",C_WHITE);
				elseif i==2 then
					DrawYJZBox(-1,12,"����",C_WHITE);
				elseif i==3 then
					DrawYJZBox(-1,12,"��ͼ",C_WHITE);
				end
			else
				lib.PicLoadCache(4,v.pic*2,v.x1,v.y1,1);
			end
		end
	end
	DrawGame();
	PlayCityBGM(JY.Person[JY.PID]["����"], false);
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
			if v["����"]>0 then
				local px,py=v["����X"],v["����Y"];
				if MOUSE.CLICK(px+4,py+4,px+93,py+150) then
					JY.Tid=v["����"];
					PlayWavE(0);
					Asura_Manual_ActionMenu(JY.Tid,v["����"]);
					if JY.Tid==-1 then
						JY.Tid=0;
						return;
					end
					JY.Tid=-1;
					break;
				elseif MOUSE.IN(px+4,py+4,px+93,py+150) then
					JY.Tid=v["����"];
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
	local cid=JY.Person[pid]["����"];
	local fid=JY.City[cid]["����"];
	if false then
	
  elseif command == 105 then
    AI_ForceChief(1)
  elseif command == 101 then  --����
    Assignment();
	elseif command==102 then	--�˹�
		local str=JY.Str[15000];	
		str=string.gsub(str,"s1","[Green]"..JY.Force[fid]["����"].."[Normal]");
		if TalkYesNo(JY.PID,str) then
      Asura_ApplyOffer(pid, fid);
		end
	elseif command==103 then	--����
		local tstr="[name]����[normal]��[Green]%s[Normal][n][name]Ч��[normal]�������佫�ø�����[n][name]����[normal]������ -100[n][name]���[normal]��[wheat]����[normal]��[wheat]ͳ��[normal]������[n]����������[wheat]����[normal]�����ߣ�Ч������"
		local eid=ShowPersonList(GetCityXianyi(JY.Person[JY.PID]["����"],{JY.PID}));
		if eid>0 and ConfirmYesNo("[B][wheat]����",string.format(tstr,JY.Person[eid]["����"])) then
			JY.Base["�ж���"]=limitX(JY.Base["�ж���"]-1,0,9);
			DrawGame();
			Visit(eid);
			return;
		end
	elseif command==104 then	--�پ�
		TitleManual(fid);
	elseif command==111 then	--����
						local tstr="[name]����[normal]��[Red]%s[Normal][n][name]Ч��[normal]��������ռ��ǳ�[n][name]����[normal]������ -%d[n][name]��·[normal]��%s[n][name]����[normal]��%s"
						local cid2=ShowCityList(GetAtkCity(JY.Person[JY.PID]["����"]),1);
						if cid2>0 then
							--if TalkYesNo(pid,"����[Red]"..JY.City[cid2]["����"].."[Normal]����Ҫ����[Orange]"..GetPath(cid2,JY.FID).."[Normal]\\n������") then
							local wid=GetPath(JY.Person[JY.PID]["����"],cid2);
							local jl,dl=1,1;
							local cost=500;
							WarIni();
							War.ArmyA1=SelectArmy(JY.Person[JY.PID]["����"]);
							War.ArmyB1=AutoSelectArmy(cid2);
							if #War.ArmyA1>0 then
								JY.Base["�ж���"]=limitX(JY.Base["�ж���"]-1,0,9);
								JY.Base["����ǳ�"]=cid2;
								LLK_III_Main(wid);
								return;
							end
						end
	elseif command==201 then	--����
		local tstr="[name]����[normal]��[Red]%s[Normal][n][name]�佫[normal]��%s[n][name]Ч��[normal]��ָ�����п�������[n][name]����[normal]���ж��� -1"
		if cid>0 and ConfirmYesNo("[B][wheat]����",string.format(tstr,JY.City[cid]["����"],JY.Person[JY.PID]["����"])) then
			JY.Base["�ж���"]=limitX(JY.Base["�ж���"]-1,0,9);
			PlayWavE(3);
			DrawGame();
			--local add,str=
			CityDevelop(cid,JY.PID,11);
			--if add>0 then
			--	DrawMulitStrBox(str);
			--end
			return;
		end
	elseif command==301 then	--��ҵ
		local tstr="[name]����[normal]��[Red]%s[Normal][n][name]�佫[normal]��%s[n][name]Ч��[normal]��ָ��������ҵ����[n][name]����[normal]���ж��� -1"
		if cid>0 and ConfirmYesNo("[B][wheat]��ҵ",string.format(tstr,JY.City[cid]["����"],JY.Person[JY.PID]["����"])) then
			JY.Base["�ж���"]=limitX(JY.Base["�ж���"]-1,0,9);
			PlayWavE(3);
			DrawGame();
			--local add,str=
			CityDevelop(cid,JY.PID,12);
			--if add>0 then
			--	DrawMulitStrBox(str);
			--end
			return;
		end
	elseif command == 401 then	--����
		local tstr="[name]����[normal]��[Red]%s[Normal][n][name]�佫[normal]��%s[n][name]Ч��[normal]��ָ�����м�������[n][name]����[normal]���ж��� -1"
		if cid>0 and ConfirmYesNo("[B][wheat]����",string.format(tstr,JY.City[cid]["����"],JY.Person[JY.PID]["����"])) then
			JY.Base["�ж���"]=limitX(JY.Base["�ж���"]-1,0,9);
			PlayWavE(3);
			DrawGame();
			--local add,str=
			CityDevelop(cid,JY.PID,13);
			--if add>0 then
			--	DrawMulitStrBox(str);
			--end
			return;
		end
	elseif command == 501 then	--�ΰ�
		local tstr="[name]����[normal]��[Red]%s[Normal][n][name]�佫[normal]��%s[n][name]Ч��[normal]��ָ�������ΰ�����[n][name]����[normal]���ж��� -1"
		if cid>0 and ConfirmYesNo("[B][wheat]�ΰ�",string.format(tstr,JY.City[cid]["����"],JY.Person[JY.PID]["����"])) then
			JY.Base["�ж���"]=limitX(JY.Base["�ж���"]-1,0,9);
			PlayWavE(3);
			DrawGame();
			--local add,str=
			CityDevelop(cid,JY.PID,14);
			--if add>0 then
			--	DrawMulitStrBox(str);
			--end
			return;
		end
	elseif command==601 then	--�޲�
		local tstr="[name]����[normal]��[Red]%s[Normal][n][name]�佫[normal]��%s[n][name]Ч��[normal]��ָ�����з�������[n][name]����[normal]���ж��� -1"
		if cid>0 and ConfirmYesNo("[B][wheat]�޲�",string.format(tstr,JY.City[cid]["����"],JY.Person[JY.PID]["����"])) then
			JY.Base["�ж���"]=limitX(JY.Base["�ж���"]-1,0,9);
			PlayWavE(3);
			DrawGame();
			--local add,str=
			CityDevelop(cid,JY.PID,3);
			--if add>0 then
			--	DrawMulitStrBox(str);
			--end
			return;
		end
	elseif command==703 then	--����
		local tstr="[name]����[normal]��[Green]%s[Normal][n][name]Ч��[normal]�������佫�ø�����[n][name]����[normal]������ -100[n][name]���[normal]��[wheat]����[normal]��[wheat]ͳ��[normal]������[n]����������[wheat]����[normal]�����ߣ�Ч������"
		local eid=ShowPersonList(GetCityZaiye(JY.Person[JY.PID]["����"],{JY.PID}));
		if eid>0 and ConfirmYesNo("[B][wheat]����",string.format(tstr,JY.Person[eid]["����"])) then
			JY.Base["�ж���"]=limitX(JY.Base["�ж���"]-1,0,9);
			PlayWavE(3);
			DrawGame();
			Talk(eid,"�����˻Ự");
			return;
		end
  elseif command == 209 then -- ����, ũ��
    Asura_Survey(2);
  elseif command == 309 then -- ����, �г�
    Asura_Survey(3);
  elseif command == 409 then -- ����, ����
    Asura_Survey(4);
  elseif command == 509 then -- ����, פ��
    Asura_Survey(5);
  elseif command == 609 then -- ����, ����
    Asura_Survey(6);
  elseif command == 709 then -- ����, �Ƽ�
    Asura_Survey(7);
  elseif command == 809 then -- ����, ��Ӫ
    Asura_Survey(8);
	elseif command==901 then	--����
		Train();
	elseif command==903 then	--Ǩ��
		local tstr="[name]����[normal]��[Red]%s[Normal][n][name]�佫[normal]��%s[n][name]Ч��[normal]���ƶ���ָ������[n][name]����[normal]���ж��� -1"
		--local cid2=ShowCityList(GetMoveCity(JY.Person[JY.PID]["����"]),1);
    local cid2 = CityMap:selectNearbyCity() or 0;
		if cid2>0 and ConfirmYesNo("[B][wheat]Ǩ��",string.format(tstr,JY.City[cid2]["����"],JY.Person[JY.PID]["����"])) then
			JY.Base["�ж���"]=limitX(JY.Base["�ж���"]-1,0,9);
			JY.Person[JY.PID]["����"]=cid2;
			Dark();
			DrawGame();
			PlayWavE(3);
      PlayCityBGM(JY.Person[JY.PID]["����"], false);
			Light();
			DrawMulitStrBox(string.format("[Green]%s[Normal]��[Red]%s[Normal]�ƶ�����", JY.Person[JY.PID]["����"], JY.City[cid2]["����"]));
			return;
		end
	elseif command==909 then	--��Ϣ
		if TalkYesNo(JY.PID,"������ǰ�غϣ�ȷ����") then
			Dark();
			JY.Base["��ǰ��"]=JY.Base["��ǰ��"]+1;
			if JY.Base["��ǰ��"]>12 then
				JY.Base["��ǰ��"]=1;
				JY.Base["��ǰ��"]=JY.Base["��ǰ��"]+1;
			end
      JY.Base["�ж���"] = 3 + JY.Force[JY.FID]["�پ�"];
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
  local eid = JY.Force[fid]["����"];
  local pass = false;
  if hireRate(eid, pid) > 75 + math.random(10) then
    pass = true;
  end
  if JY.PID == pid or JY.PID == eid then
  local t_str = {0, 0, 0, 0, 0, 10}
    local str = "";
    for i,v in ipairs({"ͳ��", "����", "��ı", "����", "����"}) do
      t_str[i] = math.max(JY.Person[pid][v]-70, 0);
    end
    local r = PercentRandom(t_str);
    if r == 1 then
      str = TableRandom({ "�Ҷ�ָ�Ӿ����������ţ�[n]��������Ϊ����Ч���ɣ�",
                          "����������ӡ�������[n]�����ñ�֮����"});
    elseif r == 2 then
      str = TableRandom({ "�Ҷ������������ţ�[n]��������Ϊ����Ч���ɣ�",
                          "�ѵ��˴���仨��ˮ��[n]��������ʶ��ʶ����[n]�ͻ���ľ�����",
                          "��������ʯ��[n]ԸΪ[Green]" .. JY.Person[eid]["����"] .. "[Normal]����Ч����"});
    elseif r == 3 then
      str = TableRandom({ "�Ҷ������������ţ�[n]��������Ϊ���³��˰ɣ�",
                          "���ҵĻ��Ǻ�ı�ԣ�[n]������һ��֮����"});
    elseif r == 4 then
      str = TableRandom({ "�Ҷ������������ţ�[n]��������Ϊ���³��˰ɣ�",
                          "���������ι�����츣����[n]Ŭ������������ʯ�Ĺ��ҡ�"});
    elseif r == 5 then
      str = TableRandom({ "�ҶԽ���֮���������ţ�[n]��������Ϊ���³��˰ɣ�",
                          "�������������Ϥ���ط������顣[n]ԸΪ��Ч����"});
    else
      str = TableRandom({ "��Ȼ��΢��֮��������ϧЧȮ��֮�ͣ�[n]�������ڴ�������Ч���ɡ�",
                          "��������������֮�ţ�[n]������ͬ�������˹١�",
                          "�����������֣�[n]ԸΪ��Ч����",
                          "���������[Green]" .. JY.Person[eid]["����"] .. "[Normal]����������������[n]�����������°ɡ�"});
    end
    SetSceneID(54);
    DrawGame();
    Talk(pid, str);
    if JY.PID == eid then
      pass = TalkYesNo(eid, "Ҫ¼��[Green]" .. JY.Person[pid]["����"] .. "[Normal]��");
      DrawGame();
    end
    if pass then
      str = TableRandom({ "�Ҿ����ڵȸ��£�[n]�ڴ�����Ļ�ԾӴ��",
                          "��������֮����֮�£��ҽ���Ȼ���ܡ�",
                          "��л����ô���ĳ��Ρ�[n]ϣ�����ú�Ŭ��������",
                          "������������ĳ��Ρ�[n]���ҵ����ֶ���һλ���������ˡ�"});
    else
      str = TableRandom({ "������ڹ����ϣ��Ҿ����׵ظ���˵�ɡ�[n]����Ҫ��Ϊ�Ҿ�֮���Ļ�������������ѽ��",
                          "��������Һ����͡�[n]���ǣ����µ��������Ҿ������ô���",
                          "���ź���Ŀǰ�Ҿ�û�и��µ�λ�á�"});
    end
    Talk(eid, str);
    if pass then
      str = TableRandom({ "����������ң�[n]�һ�߾�������Ч���ġ�",
                          "�ǳ���л��[n]�ӽ��Ժ󣬽���[Green]" .. JY.Person[eid]["����"] .. "[Normal]���˲��µ���ݣ�[n]����������Ч����",
                          "������Ȼ��ŵ�������˸м�������[n]Ϊ�˲����������ڴ����������������ϧ��",
                          "�ţ�[n]�Ǿ��ڴ��ҵı��ְɣ�",
                          "�ǵģ�[n]�����ౡ֮������Ŭ���ġ�"});
    else
      str = TableRandom({ "ԭ�����ŵ�������һ�£��Ǽٵİ�����",
                          "��Ȼ�ܾ����ҡ�[n]û����ʶ�˲ŵ��۹�Ҳ���и��޶ȡ�",
                          "���������������ź���"});
    end
    Talk(pid, str);
    if JY.PID == eid then
      if pass then
        DrawMulitStrBox("¼��[Green]" .. JY.Person[pid]["����"] .. "[Normal]��.");
      else
        DrawMulitStrBox("�ܾ���[Green]" .. JY.Person[eid]["����"] .. "[Normal]��Ͷ��.");
      end
    else
      if pass then
        DrawMulitStrBox("Ͷ��[Green]" .. JY.Person[eid]["����"] .. "[Normal]�ɹ���.");
      else
        DrawMulitStrBox("��[Green]" .. JY.Person[eid]["����"] .. "[Normal]�ܾ�¼��.");
      end
    end
    SetSceneID(0);
  end
  if pass then
    JY.Person[pid]["����"] = fid;
    JY.Person[pid]["���"] = 1;
  end
end
function Asura_Survey()
  local p = JY.Person[JY.PID];
  local name = p["����"];
  local t_actions = {0, 0, 0, 0, 0, 10};
  local r = PercentRandom(t_actions);
  DrawGame();
  if r == 1 then  --����
    local headID = TableRandom({1072, 1073, 1074, 1075});
    TalkEx("��ʿ", headID, "�����[n]�ֵ��Ͼ����е�����û��");
    if TalkYesNo(JY.PID, "Ҫ���Գ�������������") then
      Talk(JY.PID, "֪���ˣ�[n]������ȥ�������ǡ�");
      --ͼƬ
      DrawMulitStrBox("���������ܣ�[n]��ҲΪ�������ˡ�");
    else
      Talk(JY.PID, TableRandom({"�Բ���ȥ�������˰ɡ�", "�����ں�æ��[n]ȥ�ұ��˰ɡ�"}));
    end
  elseif r == 2 then  --ʩ��
    local headID = TableRandom({1077, 1081});
    local money = 92;
    TalkEx("����", headID, TableRandom({ "�����Ǽ����ꤣ��໴�����[n]��ȴûǮ���ס�",
                              "��Ϊ�ɷ�Զ��ɳ����[n]���������Ͷ�������[n]���������޷��ģ��������ࡣ"}));
    TalkEx("����", headID, TableRandom({ "[Green]" .. name .. "[Normal]���ˣ�[n]����ʩ����" .. money .."�ƽ���",
                              "[Green]" .. name .. "[Normal]���ˣ�[n]�������,����ʩ����" .. money .."�ƽ�ɡ�"}));
    if TalkYesNo(JY.PID, "Ҫʩ��ƽ�" .. money .. "��") then
      Talk(JY.PID, "�Ҳ��ܲ��Ų��ʣ�[n]����ȥ�ðɡ�");
    else
      Talk(JY.PID, TableRandom({"�治���ɣ���û���ֽ�[n]ȥ�ұ��˰ɡ�",
                                "�Բ���[n]����ͷҲ����ԣ��",
                                "�����ֻ�ȼ���һ���ˣ�[n]�������˾ͺܲ���ƽ��[n]��ɲ��С�"}));
    end
  elseif r == 3 then --����
    local headID = TableRandom({1076, 1080});
    TalkEx("����", headID, TableRandom({"[Green]" .. name .. "[Normal]���ˣ�[n]������Ƕ���ʶ�ְɣ�",
                              "�ٸ��ĸ�ʾ������˿�������[n]������Ƕ���ʶ�ְɣ�"}));
    if TalkYesNo(JY.PID, "Ҫ���콲��γ���") then
      Talk(JY.PID, TableRandom({"���ǵ��뷨�ܺã�[n]�����ǸϿ쿪ʼ�ɡ�[n]����ѧϰ�����ټ�������",
                                "�ã������������ǽ��⡣"}));
      --show pic
      DrawMulitStrBox("�����ܵ�������[n]����������顣");
    else
      Talk(JY.PID, TableRandom({"���ţ��Բ��������ڹ��·�æ��[n]����Ժ��л��ᣬ��Ϊ�����ڿΰɡ�",
                                "���ǵ��뷨�ܺã�[n]ֻ�Ǻܲ����ɣ�[n]������ûʱ�䣬�Բ���",
                                "�Բ���[n]ȥ�������˰ɡ�"}));
    end
  elseif r == 4 then --���
    Talk("����", "[Green]" .. name .. "[Normal]���ˣ�[n]���е�����Ҫ��ʼ�ˣ�[n]��Ҳһ�����μӰɣ�");
    if TalkYesNo(JY.PID, "Ҫ�μ������") then
      Talk(JY.PID, TableRandom({"Ŷ����ô�Ҿʹ����ˡ�",
                                "�����пգ�[n]��Ϊ�Ҵ�·�ɡ�"}));
      --show pic
      DrawMulitStrBox(name .. "�����һ��[n]������Ͼ��鳩����");
    else
      Talk(JY.PID, TableRandom({"�ǳ���л���ǵ����룬[n]ֻ��������û��ʱ�䣬[n]�´��л����������Ұɡ�",
                                "�ǳ���л���ǵ����룬[n]ֻ����������������",
                                "�����ȥ�Ļ������һ��æ���к��ҡ�[n]���һ������ҾͶ��޷������ˣ�[n]����ҾͲ�ȥ�ˡ�",
                                "���ܲμ����ǵ���ᣬ[n]���Ǿ��鳩���ɡ�"}));
    end
  elseif r == 5 then --���ռ���
    Talk("ͯ��", "[Green]" .. name .. "[Normal]���ˣ�������Ҫ���м��䣬[n]��������ճɺ�����ķ��գ�[n]��Ҳһ�����μ���");
    --�μӼ��� / ȡ������
    if TalkYesNo(JY.PID, "Ҫ�μ������") then
      Talk(JY.PID, TableRandom({"����ר��ǰ����Լ��[n]�Ҳ��ܹ������ǵ�ʢ�顣",
                                "��ô�ѵõķ�����䣬[n]��������Ҳμӡ�"}));
      --show pic
      DrawMulitStrBox(name .. "�����һ��[n]�˸߲��ҵؾ����˼��䡣");
    else
      Talk(JY.PID, "���ھ������㣬[n]�Բ���[n]�뽫�������ʳ��������");
      --XX�ľ���������XX
    end
  elseif r == 6 then  --�ʹ�����
    Talk("����", "[Green]" .. name .. "[Normal]���ˣ�[n]��˵��һЩ��Ф��Ա��[n]�������ݣ��б�˽�ҡ���");
    if TalkYesNo(JY.PID, "Ҫ�����Ա�Ĳ�����Ϊ��") then
      Talk(JY.PID, TableRandom({"���ܽ������������ң����úܺá�[n]������ȥ����ʵ�顣",
                                "���ȷ�����£�[n]���Ǽ����£�[n]������ȥ���е��顣"}));
      -- load pic
      DrawMulitStrBox(name .. "�ҷ���[n]��˽�����Ĺ�Ա��");
    else
      Talk(JY.PID, TableRandom({"��û��˵������£�[n]�Ƿ����ˣ�",
                                "�����������������ˡ�",
                                "�Һ�æ�����������˰ɡ�"}));
    end
  elseif r == 7 then  --���±�
    Talk("����", TableRandom({"[Green]" .. name .. "[Normal]���ˣ�[n]����ļ����־ͬ����֮�ˣ�[n]��������¾���[n]�������ǳ�Ϊ�������¡���",
                              "���Ƕ�����Ľ[Green]" .. name .. "[Normal]���ˣ�[n]���������������Ϊ��Ч����"}));
    if TalkYesNo(JY.PID, "Ҫ�������±�Ϊ������") then
      Talk(JY.PID, TableRandom({"���ܹ������ǵĺ��⣬[n]��������ҵľ��Ӱɡ�",
                                "��������֮�����ء�[n]ǰ���·ǧ����࣬[n]�Ͱ��и�λ�ˡ�"}));
      -- load pic
      DrawMulitStrBox(name .. "�������±�Ϊ���¡�");
    else
      Talk(JY.PID, TableRandom({"���ڲ���Ҫ����ʿ����[n]���ǵ����⣬�������ˡ�",
                                "���ǵ������ҽ����ˡ�[n]��ս��������[n]Ҫ����ʿ���ٰ��и�λ�ɡ�"}));
    end
  elseif r == 8 then --л�� - ��
    Talk("����", "�������Ǵ���Ϊ�˸���[n][Green]" .. name .. "[Normal]����ƽ�������չˣ�[n]���ճ�����һ��ƽ�");
    --"xx���ˣ�[n]�����������ʱ���������������[n]������Ҳû��ʲô�ô���"   "xx���ˣ�[n]�����Ҽ������ഫ�ر��[n]Ϊ�˸�л��ƽ�ն����ǵ��չˣ�"
    --"��Ը�����׸�xx���ˡ�"   ��xx���ˣ�[n]�뽫������Ϊл�����°ɡ���
    Talk("����", "����Ϊл��[n]�����������һ��Ҫ���¡�");
    if TalkYesNo(JY.PID, "���ܴ������ϵ�������") then
      Talk(JY.PID, TableRandom({"���Ҿ͹�����������ˣ�[n]�һ�ú���ϧ����",
                                "Ŷ����������֮���ã�[n]��ô�ҾͲ������������ˡ�"}));
      -- load pic
      DrawMulitStrBox(name .. "������[n]�ƽ�XXX��");
      --���ܴ������ϵ�����
    else
      Talk(JY.PID, TableRandom({"�ܸ�л������������⣬[n]�����Ҳ��ܽ���������",
                                "��̫�����ˣ��Ҳ��ܽ��ܡ�"}));
    end
  else  --��Ϣ
    local str = TableRandom({ "ÿ��һ���ġ��ߡ�ʮ�»����ʽ����롣[n]������ֻ��ÿ�����²Ż������롣",
                              "��ǽ�ٸߣ�[n]Ҳ�޷�Ԥ���ֺ��ķ�����",
                              "�����������͵���Ļ���[n]Ҳ���ᱻ��ְ��",
                              "������һ��������ֵ��·ݡ�[n]�ջ�֮�󣬿��ֵ���ף���ա�",
                              "��ֲ�и�Ķ�����[n]�����������Ŷ��",
                              "��ѧ�����ڽ��ز�Ʒ���������[n]����������ǿ����������"})
  end
end
function Asura_Manual_ActionMenu(pid,kind)
	--[[
		����
			����
			����
			����
			����
			����		//���񵣵�for current city	����λ	̫��	��ʦ	����
			����
			�⽻
			����
		����
			��������
			�̼�
			����֧������
		�ݷ�
		����
	]]
	if kind==0 then
		local m={
					{"����",nil,1,JY.Base["�ж���"]>0};
					{"����",nil,1,JY.Base["�ж���"]>0};
					{"����",nil,1,JY.Base["�ж���"]>0};
					{"�ݷ�",nil,1,JY.Base["�ж���"]>0};
					{"�Լ�",nil,1,JY.Base["�ж���"]>0};
					{"��Ϣ",nil,1,true};
				}
		while true do
			local r=TalkMenu(pid,"��һ��Ҫ��ô�죿",m);
			if r==0 then
				return;
			elseif r==4 then
				local tstr="[name]����[normal]��[Green]%s[Normal][n][name]Ч��[normal]��ִ���佫�ȼ�����[n][name]����[normal]������ -100[n][name]���[normal]��[wheat]����[normal]��[wheat]ͳ��[normal]������[n]����������[wheat]����[normal]�����ߣ�Ч������"
				local eid=ShowPersonList(GetCityWujiang(JY.Person[JY.PID]["����"],{JY.PID}));
				if eid>0 and ConfirmYesNo("[B][wheat]�ݷ�",string.format(tstr,JY.Person[eid]["����"])) then
					JY.Base["�ж���"]=limitX(JY.Base["�ж���"]-1,0,9);
					PlayWavE(3);
					DrawGame();
					Talk(eid,"������ѵ��");
					return;
				end
			elseif r==6 then
				if TalkYesNo(pid,"������ǰ�غϣ�ȷ����") then
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
								{"����",nil,1,true};
								{"����",nil,1,true};
								{"����",nil,1,true};
								{"�⽻",nil,1,true};
								{"����",nil,1,true};
							}
					str2="�Բ��´������";
				elseif r==2 then
					m2={
								{"N/A",nil,1,true};
								{"N/A",nil,1,true};
								{"N/A",nil,1,true};
								{"N/A",nil,0,true};
								{"N/A",nil,0,true};
								{"N/A",nil,1,true};
							}
					str2="ִ�о����´������";
				elseif r==3 then
					m2={
							{"ũ��",nil,1,true};
							{"�г�",nil,1,true};
							{"����",nil,1,true};
							{"��Ӫ",nil,1,true};
							{"פ��",nil,1,true};
							{"��ǽ",nil,1,true};
							{"�Ƽ�",nil,1,true};
							}
					str2="���š�";
				elseif r==5 then
					m2={
							{"����",nil,1,true};
							{"��Ұ",nil,1,true};
							{"�˹�",nil,1,true};
							{"����",nil,1,true};
							{"����",nil,1,true};
							{"�ƶ�",nil,1,true};
							}
					str2="���š�";
				end
				while true do
					r2=TalkMenu(pid,str2,m2);
					if r2==0 then
						break;
					elseif 10*r+r2==11 then	--����
						local tstr="[name]����[normal]��[Red]%s[Normal][n][name]Ч��[normal]��������ռ��ǳ�[n][name]����[normal]������ -%d[n][name]��·[normal]��%s[n][name]����[normal]��%s"
						local cid=ShowCityList(GetAtkCity(JY.Person[JY.PID]["����"]),1);
						if cid>0 then
							--if TalkYesNo(pid,"����[Red]"..JY.City[cid]["����"].."[Normal]����Ҫ����[Orange]"..GetPath(cid,JY.FID).."[Normal]\\n������") then
							local wid=GetPath(JY.Person[JY.PID]["����"],cid);
							local jl,dl=1,1;
							local cost=500;
							WarIni();
							War.ArmyA1=SelectArmy(JY.Person[JY.PID]["����"]);
							War.ArmyB1=AutoSelectArmy(cid);
							if #War.ArmyA1>0 then
								JY.Base["�ж���"]=limitX(JY.Base["�ж���"]-1,0,9);
								JY.Base["����ǳ�"]=cid;
								LLK_III_Main(wid);
								return;
							end
						end
					elseif 10*r+r2==12 then	--����
						
					elseif 10*r+r2==13 then	--����
						local cid=JY.Person[JY.PID]["����"];
						if Assign(cid) then
							JY.Base["�ж���"]=limitX(JY.Base["�ж���"]-1,0,9);
							return;
						end
					elseif 10*r+r2==15 then	--����
						local tstr="[name]����[normal]��[Green]%s[Normal][n][name]Ч��[normal]���������б�������[n][name]����[normal]������ -100[n][name]���[normal]��[wheat]����[normal]��[wheat]ͳ��[normal]������[n]����������[wheat]����[normal]�����ߣ�Ч������"
						local eid=ShowPersonList(GetCityWujiang(JY.Person[JY.PID]["����"],{JY.PID}));
						if eid>0 and ConfirmYesNo("[B][wheat]����",string.format(tstr,JY.Person[eid]["����"])) then
							JY.Base["�ж���"]=limitX(JY.Base["�ж���"]-1,0,9);
							PlayWavE(3);
							DrawGame();
							Talk(eid,JY.Str[math.random(6271,6274)]);
							local cid=JY.Person[JY.PID]["����"];
							local old=JY.City[cid]["����"];
							JY.City[cid]["����"]=limitX(JY.City[cid]["����"]+20*ValueAdjust(JY.Person[eid]["ͳ��"],100),0,500000);
							local new=JY.City[cid]["����"];
							Talk(eid,string.format("[name]ʿ����[normal]�� %5d  �� %5d (%+d)",old,new,new-old));
							return;
						end
					elseif 10*r+r2==56 then	--�ƶ�
					elseif r==3 then
						
					end
				end
			end
		end
	elseif between(kind,7001,7117) then
		DrawGame()
		Talk(pid,AsuraGenTalkString(kind,pid,JY.PID));
	else
		Talk(pid,"��ã�����"..JY.Person[pid]["����"]);
	end
end
function Asura_Manual_Action(pid,kind)
	local str={	"1","2","3","4","5","6","7","8","9","10",
				"�����ƶ��ǳ�","ѵ��ָ���佫������侭�顣","��ѵָ���佫���������侭�顣","ѵ��ȫ���佫������侭�顣","��ѵȫ���佫���������侭�顣","5","6","7","8","9","10",
				"̽����Ұ�佫��Ҳ�������������֡�","���ͣ����ܷ��ֶ�λ�佫��","����ָ���佫�����ָֻ���ƣ�Ͷȡ�","Ȭ��ָ���佫����ȫ�ָ���ƣ�Ͷȡ�","����ȫ���佫�����ָֻ���ƣ�Ͷȡ�","15","16","17","18","19","20",
				"ָ�����������ˡ�","���н��ף��Ի�ȡ��Ǯ�Լ����ʡ�","�������ʣ��Ի�ȡ������Ǯ��","�����������Ի�ȡ������Ǯ�Լ����ʡ�","��ʩ���ʣ���������ġ�","��ʩ��Ǯ�Լ����ʣ��Դ��������ġ�","26","27","28","29","30",
				"�����佫�����ְ��","����ָ���佫�������һ�ꡣ","����ָ���佫��","34","35","36","37","38","39","40",
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
		headid=JY.Person[p]["��ò"];
		name=JY.Person[p]["����"];
	elseif type(name)=='string' then
		local pid=JY.NameList[p];
		if pid~=nil then
			headid=JY.Person[pid]["��ò"];
			name=JY.Person[pid]["����"];
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
		v["����"]=-1;
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
		if JY.Scene[i]["����"]==-1 then
			JY.Scene[i]["����"]=pid;
			JY.Scene[i]["����X"]=36+110*(column-1);
			JY.Scene[i]["����Y"]=36+172*(row-1);
			JY.Scene[i]["����"]=event;
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
		if v["����"]==pid then
			v["����"]=-1;
			break;
		end
	end
	for i=1,20 do
		if JY.Scene[i]["����"]<=0 then
			JY.Scene[i]["����"]=JY.Scene[i+1]["����"];
			JY.Scene[i]["����"]=JY.Scene[i+1]["����"];
			JY.Scene[i+1]["����"]=-1;
		end
	end
end
function Search(pid,t)
	for i=1,t do
		local p={};
		for i=1,JY.PersonNum-1 do
			if JY.Person[i]["�ǳ�"]==1 and JY.Person[i]["����"]==0 then
				if math.random(2,5)>JY.Person[i]["Ʒ��"] then
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
			Talk(pid,"�ҵ���һ�����ʡ�");
		else
			PlayWavE(3);
			JY.Person[eid]["�ǳ�"]=2;
			Talk(pid,AsuraGenTalkString(42,pid,eid));
			JY.DG.pid=eid;
			local zm=TalkYesNo(pid,"Ҫ��ļ[Green]"..JY.Person[eid]["����"].."[Normal]��")
			JY.DG.pid=-1;
			DrawGame();
			if zm then
				Hire(pid,eid);
			else
				Talk(pid,"��ã��ټ���");
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
		JY.Person[eid]["����"]=JY.FID;
		JY.Person[eid]["�ǳ�"]=3;
		UpdateForcePersonNum(JY.FID);
	else
		PlayWavE(2);
		Talk(eid,AsuraGenTalkString(45,eid,pid));
	end
end
function GetXX(id1,id2)
	local xx=math.abs(JY.Person[id1]["����"]-JY.Person[id2]["����"]);
	xx=math.min(xx,149-xx);	--So, the range is 0~74;
	return xx;
end
function hireRate(pid, eid)
  --pid��eid��hire rate
  --�����ж�: 1.pid�Ƿ�ȥ����eid; 2.pid�Ƿ�ͳһeid���˹�����; 3.pid�Ƿ����eid������
  --����, A��ļB, ѡӴ��hireRate(A,B)(�Ƿ�ȥ����),Ȼ����ҪhireRate(B,A)(�Ƿ����)
  local v1, v2, v3, v4 = 0, 0, 0, 0;
  v1 = getRelationship(pid, eid);
  if v1 < 0 then
    return 0;
  end
  if JY.Person[pid]["����"] > 0 then
    v2 = (75 - GetXX(pid, eid)) * 4 / 3 * (0.6 + JY.Person[pid]["����"] / 5);
  end
  if JY.Person[pid]["����"] > 0 then
    v3 = (JY.Person[eid]["����"] + JY.Person[eid]["ͳ��"]) / 2 * (0.6 + JY.Person[pid]["����"] / 5);
  end
  if JY.Person[pid]["����"] > 0 then
    v4 = (JY.Person[eid]["��ı"] + JY.Person[eid]["����"]) / 2 * (0.6 + JY.Person[pid]["����"] / 5);
  end
      lib.Debug("hire " .. v1 .. ", " .. v2 .. ", " .. v3 .. ", " .. v4)
  return math.max(v1, v2, v3, v4);
end
function getRelationship(pid, eid)
  --pid��eid�Ĺ�ϵ/�ƺ�/���ܵ�
  --return pid��eid�� ���ܶ�,��ν
  local title = "";
  local feeling = 0;
  local p = JY.Person[pid];
  local e = JY.Person[eid];
  
  if p["���"] > 0 and eid == p["���"] then  --���
    feeling = -100;
    title = e["����"];
  elseif p["����"] > 0 and e["����"] == p["����"] then  --���ֵ�
    feeling = 100;
    if eid == p["����"] then
      if e["�Ա�"] == 0 then
        title = "���";
      else
        title = "���";
      end
    else
      title = e["��"];
    end
  elseif (p["��ż"] > 0 and eid == p["��ż"]) or (e["��ż"] > 0 and pid == e["��ż"]) then --��ż
    feeling = 80;
    if e["�Ա�"] == 0 then
      title = "���";
    else
      title = "����";
    end
  elseif p["����"] > 0 and eid == p["����"] then  --����
    feeling = 70;
    title = "����";
  elseif p["ĸ��"] > 0 and eid == p["ĸ��"] then --ĸ��
    feeling = 70;
    title = "ĸ��";
  elseif (p["����"] > 0 and p["����"] == e["����"]) or (p["ĸ��"] > 0 and p["ĸ��"] == e["ĸ��"]) then  --�ֵ�
    feeling = 60;
    if e["����"] == p["����"] then
      if e["�Ա�"] == 0 then
        title = "�ֳ�";
      else
        title = "���";
      end
    else
      title = e["��"];
    end
  else
    feeling = e["�ø�"] / 2;
    feeling = 0;
    title = e["����"];
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
	local attr={"ͳ��","����","��ı","����","����"};
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
	button_mainbt_2(bt, "����", "����", 1, 2, CC.ScreenH - y0 - 58);
  table.insert(bt, button_creat(1, 10, x0 + 40, y0 + 10, "�Զ�", true, true));
  table.insert(bt, button_creat(1, 11, x0 + 40, y0 + 50, "����", true, true));
  table.insert(bt, button_creat(1, 12, x0 + 40, y0 + 90, "��ҵ", true, true));
  table.insert(bt, button_creat(1, 13, x0 + 40, y0 + 130, "����", true, true));
  table.insert(bt, button_creat(1, 14, x0 + 40, y0 + 170, "�ΰ�", true, true));
  table.insert(bt, button_creat(1, 15, x0 + 40, y0 + 210, "�޲�", true, true));
  table.insert(bt, button_creat(1, 16, x0 + 40, y0 + 250, "ļ��", true, true));
  table.insert(bt, button_creat(1, 17, x0 + 40, y0 + 290, "ѵ��", true, true));
	local function redraw()
		DrawGame();
		LoadPicEnhance(73,x0,y0,width,height);
		local x,y=x0+40,y0-30;
		x=x+360;
		for i=1,#attr do
			local par=attr[i];
			DrawStringEnhance(x,y+60*i,"[B]"..p[par],C_WHITE,24);
			DrawStringEnhance(x+40,y+60*i,par.."����",C_Name,24);
			local expstr;
			if expmax[i]>0 then
				expstr=string.format("%3d",math.floor(100*JY.Base[par.."����"]/expmax[i]));
				if i==sel then
					expstr=expstr.."[green]+"..(math.floor(100*(JY.Base[par.."����"]+add)/expmax[i])-math.floor(100*JY.Base[par.."����"]/expmax[i]));
				end
			else
				expstr="--"
			end
			DrawStringEnhance(x+200,y+60*i,expstr,C_WHITE,24);
			drawbar(x+40,y+24+60*i,1000*JY.Base[par.."����"]/expmax[i]);
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
				local old=math.floor(100*JY.Base[par.."����"]/expmax[sel]);
				JY.Base[par.."����"]=JY.Base[par.."����"]+add;
				local new=math.floor(100*JY.Base[par.."����"]/expmax[sel]);
				DrawGame();
				if new>=100 then
					JY.Base[par.."����"]=JY.Base[par.."����"]-expmax[sel];
					p[par]=p[par]+1;
					Talk(JY.PID,par.."����Ϊ"..(p[par]).."��");
				else
					Talk(JY.PID,par.."����������"..(new-old).."��");
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
	if JY.Person[pid]["�ø�"]==0 then
		ratio=0.7;
	else
		ratio=1;
	end
	if math.random()<ratio then
		SetSceneID(69);
		local old=JY.Person[pid]["�ø�"];
		local xx=GetXX(JY.PID,pid)+math.floor(old/2);
		if JY.Person[pid]["�ø�"]==0 then
			str=JY.Str[math.random(15110,15111)];
			str=string.gsub(str,"s2","[Green]"..JY.Person[JY.PID]["����"].."[Normal]");
			Talk(JY.PID,str);
			str=JY.Str[math.random(15115,15116)];
			str=string.gsub(str,"s1","[Green]"..JY.Person[pid]["����"].."[Normal]");
			str=string.gsub(str,"s2","[Green]"..JY.Person[JY.PID]["����"].."[Normal]");
			Talk(pid,str);
			str=JY.Str[math.random(15120,15122)];
			Talk(JY.PID,str);
			JY.Person[pid]["�ø�"]=limitX(JY.Person[pid]["�ø�"]+math.max(1,math.floor(10-10*xx/100)+math.random(5)-math.random(5)),1,100);
		else
			str=JY.Str[math.random(15125,15127)];
			str=string.gsub(str,"s2","[Green]"..JY.Person[JY.PID]["����"].."[Normal]");
			Talk(pid,str);
			str=JY.Str[math.random(15130,15134)];
			str=string.gsub(str,"s1","[Green]"..JY.Person[pid]["����"].."[Normal]");
			Talk(JY.PID,str);
			local t_str={0,0,0,0,0,30}
			for i,v in ipairs({"ͳ��","����","��ı","����","����"}) do
				t_str[i]=math.max(JY.Person[pid][v]-70,0);
			end
			local kind=PercentRandom(t_str);
			if kind==6 then
				str=JY.Str[math.random(15180,15186)];
			else
				str=JY.Str[15135+8*kind+math.random(1,8)];
			end
			Talk(pid,str);
			JY.Person[pid]["�ø�"]=limitX(JY.Person[pid]["�ø�"]+math.max(1,math.floor(20-20*xx/100)+math.random(3)-math.random(3)),1,100);
		end
		local new=JY.Person[pid]["�ø�"];
		if new>old then
			PlayWavE(3);
			DrawMulitStrBox(string.format("[green]%s [name]�ø� [white]%3d -> %3d",JY.Person[pid]["����"],old,new))
		end
		SetSceneID(0);
	else
		str=JY.Str[math.random(15100,15103)];
		str=string.gsub(str,"s1","[Green]"..JY.Person[pid]["����"].."[Normal]");
		Talk(800,str);
		str=JY.Str[math.random(15105,15108)];
		str=string.gsub(str,"s1","[Green]"..JY.Person[pid]["����"].."[Normal]");
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
	local attr={"ͳ��","����","��ı","����","����"};
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
	button_mainbt_2(bt,"����","����",1,2,CC.ScreenH-y0-58);
	for i=1,#attr do
		table.insert(bt,button_creat(1,10+i,x0+280,y0-32+60*i,attr[i],true,p[attr[i]] < 100));
	end
	local function redraw()
		DrawGame();
		LoadPicEnhance(73,x0,y0,width,height);
		local x,y=x0+40,y0-30;
		lib.PicLoadCache(2,(p["��ò"])*2,x,y+50,1,0,nil,nil,320);
		x=x+360;
		for i=1,#attr do
			local par=attr[i];
			DrawStringEnhance(x,y+60*i,"[B]"..p[par],C_WHITE,24);
			DrawStringEnhance(x+40,y+60*i,par.."����",C_Name,24);
			local expstr;
      if p[par] < 100 then
        expstr = string.format("%3d", getExpPercent(p[par], JY.Base[par .. "����"]));
        if i == sel  then
          expstr = expstr .. "[green]+" .. (getExpPercent(p[par], JY.Base[par .. "����"] + add) - getExpPercent(p[par], JY.Base[par .. "����"]))
        end
      else
        expstr = "--";
      end
			DrawStringEnhance(x+200,y+60*i,expstr,C_WHITE,24);
			drawbar(x+40,y+24+60*i, 10 * getExpPercent(p[par], JY.Base[par.."����"]));
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
				local old = getExpPercent(p[par], JY.Base[par.."����"]);
				JY.Base[par.."����"]=JY.Base[par.."����"]+add;
				local new = getExpPercent(p[par], JY.Base[par.."����"]);
				DrawGame();
        local str = TableRandom({ "ƽ�յĿ����Ƿǳ���Ҫ�ġ�",
                                  "Ϊ�˲�����������ҵ�ʹ����[n]����ӱ�Ŭ���������С�",
                                  "Ϊ����������������ȥ��[n]ֻ��ÿ�ղ��Ͽ������У�[n]�������һ��¥��",
                                  "����֮����[n]�ջ�������Ϊ��Ҫ��",
                                  "����֮����[n]Ψ��ÿ�տ������ѡ�",
                                  "��������͵���Ϊֹ�ɣ�"});
				Talk(JY.PID, str)
        if new>=100 then
					JY.Base[par.."����"]=JY.Base[par.."����"] - getNextExp(p[par]);
					p[par]=p[par]+1;
					DrawMulitStrBox(string.format("[Green]%s[Normal]��%s��Ϊ%d�ˣ�", p["����"], par, p[par]));
				else
					DrawMulitStrBox(string.format("[Green]%s[Normal]��%s�����Ϊ%d��%+d���ˡ�", p["����"], par, new, new - old));
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
	button_mainbt_2(bt,"����","����",1,2,CC.ScreenH-y0-58);
	table.insert(bt,button_creat(1,11,320,y0-32,"�Զ�����",true,true));
	table.insert(bt,button_creat(1,12,520,y0-32,"��������",true,true));
	table.insert(bt,button_creat(1,13,620,y0-32,"ȫ���",true,true));
	local plist={};
	for i=1,JY.PersonNum-1 do
		if JY.Person[i]["�ǳ�"]==3 and JY.Person[i]["����"]==fid and JY.Person[i]["���"]<=2 then
			table.insert(plist,i);
			JY.Person[i]["�¹پ�"]=JY.Person[i]["�پ�"];
		end
	end
	local function redraw()
		DrawGame();
		LoadPicEnhance(73,x0,y0,width,height);
		local x,y=x0+64,y0+32;
		for i,pid in ipairs(plist) do
			if JY.Person[pid]["�پ�"]~=JY.Person[pid]["�¹پ�"] then
				local gj1,gj2=JY.Person[pid]["�پ�"],JY.Person[pid]["�¹پ�"];
				DrawStringEnhance(x,y,JY.Person[pid]["����"],C_WHITE,24);
				DrawStringEnhance(x+128,y,JY.Title[gj1]["����"],C_WHITE,24);
				DrawStringEnhance(x+256,y,JY.Title[gj2]["����"],C_WHITE,24);
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
					if JY.Person[pid]["�پ�"]~=JY.Person[pid]["�¹پ�"] then
						JY.Person[pid]["�پ�"]=JY.Person[pid]["�¹پ�"];
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
					JY.Person[pid]["�¹پ�"]=0;
				end
			end
		end
	end
end
function TitleAuto(fid,preview)
	local par;
	if preview then
		par="�¹پ�";
	else
		par="�پ�";
	end
	local plist1={};
	local plist2={};
	for i=1,JY.PersonNum-1 do
		if JY.Person[i]["�ǳ�"]==3 and JY.Person[i]["����"]==fid and JY.Person[i]["���"]<=2 then
			if JY.Person[i]["����"]==0 then
				table.insert(plist1,i);
			else
				table.insert(plist2,i);
			end
		end
	end
	table.sort(plist1,	function(a,b)
							return JY.Person[a]["ͳ��"]+JY.Person[a]["����"]+JY.Person[a]["����"]*0.5>JY.Person[b]["ͳ��"]+JY.Person[b]["����"]+JY.Person[b]["����"]*0.5;
						end)
	table.sort(plist2,	function(a,b)
							return JY.Person[a]["��ı"]+JY.Person[a]["����"]+JY.Person[a]["����"]*0.5>JY.Person[b]["��ı"]+JY.Person[b]["����"]+JY.Person[b]["����"]*0.5;
						end)
	for i=1,JY.TitleNum-1 do
		local plist;
		if JY.Title[i]["����"]==0 then
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
	button_mainbt_1(bt,"ȷ��",1,CC.ScreenH-y0-58);
	local ml;
	local plist={};
	local glist={};
	local sortlist={};
	local strlist={};
	local offset={0,90,180,270,360,450};
	local title={"�پ�","�ٽ�","����","����","����","����",};
	for i=1,JY.TitleNum-1 do
		glist[i]=i;
		sortlist[i]={i,JY.Title[i]["�ٽ�"],0,0,0,0};
		strlist[i]={JY.Title[i]["����"],""..JY.Title[i]["�ٽ�"],"--","--","--",""}
	end
	for i=1,JY.PersonNum-1 do
		if JY.Person[i]["�ǳ�"]==3 and JY.Person[i]["����"]==fid and JY.Person[i]["���"]<=2 then
			table.insert(plist,i);
			local tid=JY.Person[i]["�¹پ�"];
			if tid>0 then
				sortlist[tid][6]=i;
				strlist[tid][6]=JY.Person[i]["����"];
			end
		end
	end
	ml=creatMultiList(x0+32,y0+16,704,height-64,glist,sortlist,strlist,title,offset)
	local ml2;
	local sortlist2={};
	local strlist2={};
	local offset2={0,90,180,270,360,450,540,630,720};
	local title2={"����","�ø�","ͳ","��","��","��","��","����","�پ�"};
	for i,pid in ipairs(plist) do
		local p=JY.Person[pid];
		sortlist2[pid]={i,p["�ø�"],p["ͳ��"],p["����"],p["��ı"],p["����"],p["����"],0,JY.Title[p["�پ�"]]["Rank"]};
		strlist2[pid]={p["����"],""..p["�ø�"],""..p["ͳ��"],""..p["����"],""..p["��ı"],""..p["����"],""..p["����"],"",JY.Title[p["�¹پ�"]]["����"]}
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
		JY.Title[i]["����"]=0;
	end
	for i=1,JY.PersonNum-1 do
		if JY.Person[i]["�ǳ�"]==3 and JY.Person[i]["����"]==fid and JY.Person[i]["���"]<=2 then
			local tid=JY.Person[i]["�پ�"];
			if tid>0 then
				JY.Title[tid]["����"]=i;
			end
		end
	end
end
function Assign(cid)
	local c=JY.City[cid];
	local s={};
	s[1]={	str="���ѵ�����",
			txtdx=60,
			pic=45,
			left=180,
			top=100,
			right=180+118,
			bottom=100+32,}
	s[2]={	str="��ҵ������",
			txtdx=60,
			pic=45,
			left=180,
			top=252,
			right=180+118,
			bottom=252+32,}
	s[3]={	str="����������",
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
		owner[i]=c["���ѵ���"..i];
		owner[10+i]=c["��ҵ����"..i];
		owner[20+i]=c["��������"..i];
	end
	local sum={}
	local function getsum()
		sum["����"]=0;
		for i=1,10 do
			local pid=owner[i];
			if pid>0 then
				sum["����"]=sum["����"]+JY.Person[pid]["����"];
			end
		end
		sum["����"]=0;
		for i=11,20 do
			local pid=owner[i];
			if pid>0 then
				sum["����"]=sum["����"]+JY.Person[pid]["����"];
			end
		end
		sum["ͳ��"]=0;
		for i=21,30 do
			local pid=owner[i];
			if pid>0 then
				sum["ͳ��"]=sum["ͳ��"]+JY.Person[pid]["ͳ��"];
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
				lib.PicLoadCache(2,(JY.Person[pid]["��ò"]+2000)*2,s[1].right+16+90*(i-1),s[1].bottom-80,1);
				DrawStringEnhance(s[1].right+16+90*(i-1)+45,s[1].bottom+48,JY.Person[pid]["����"],C_WHITE,size,0.5);
				DrawNumPic(s[1].right+16+90*(i-1)+70,s[1].bottom+32,JY.Person[pid]["����"]);
			end
			pid=owner[i+10];
			if pid>0 then
				lib.PicLoadCache(2,(JY.Person[pid]["��ò"]+2000)*2,s[2].right+16+90*(i-1),s[2].bottom-80,1);
				DrawStringEnhance(s[2].right+16+90*(i-1)+45,s[2].bottom+48,JY.Person[pid]["����"],C_WHITE,size,0.5);
				DrawNumPic(s[2].right+16+90*(i-1)+70,s[2].bottom+32,JY.Person[pid]["����"]);
			end
			pid=owner[i+20];
			if pid>0 then
				lib.PicLoadCache(2,(JY.Person[pid]["��ò"]+2000)*2,s[3].right+16+90*(i-1),s[3].bottom-80,1);
				DrawStringEnhance(s[3].right+16+90*(i-1)+45,s[3].bottom+48,JY.Person[pid]["����"],C_WHITE,size,0.5);
				DrawNumPic(s[3].right+16+90*(i-1)+70,s[3].bottom+32,JY.Person[pid]["ͳ��"]);
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
		DrawStringEnhance(s[1].left+s[1].txtdx,s[1].bottom+6,"������",C_WHITE,size,0.9);	DrawNumPicBig(s[1].left+90,s[1].bottom+5,sum["����"]);
		DrawStringEnhance(s[2].left+s[2].txtdx,s[2].bottom+6,"������",C_WHITE,size,0.9);	DrawNumPicBig(s[2].left+90,s[2].bottom+5,sum["����"]);
		DrawStringEnhance(s[3].left+s[3].txtdx,s[3].bottom+6,"��ͳ��",C_WHITE,size,0.9);	DrawNumPicBig(s[3].left+90,s[3].bottom+5,sum["ͳ��"]);
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
		local order={"����","����","ͳ��"};
		for i,v in pairs(s) do
			if MOUSE.CLICK(v.left,v.top,v.right,v.bottom) then
				current=i;
				PlayWavE(0);
				if between(current,1,3) then
					plist={}
					for id,v in pairs(JY.Person) do
						if id~=JY.PID and v["����"]==JY.FID and v["����"]==cid then
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
						c["���ѵ���"..i]=owner[i];
						c["��ҵ����"..i]=owner[10+i];
						c["��������"..i]=owner[20+i];
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
		local fid = city["����"];
    local pid = city["̫��"];
    --�˿�ÿ������  ���������˿�ƽ��������(�����������˿����Ӷ�����)�����ΰ��½����½�����������������
    --�˿� 500��00 ~ 30000��00
    if true then  --��δ���ǵ���
      local grow = math.floor( (city["�˿�"] ^ 0.5) / 10 * limitX((city["�ΰ�"] - 600) / 400, -1.5, 1) * (2 + math.random() - math.random()) );
      city["�˿�"] = limitX( city["�˿�"] + grow, 500, 30000 );
    end
    --��ÿ��������
    --������= (��ҵֵ + 100)*(10+̫������+����)/200
    if pid > 0 and JY.Base["��ǰ��"] % 3 == 1 then
      local grow = city["��ҵ"] / 10 * (1 + limitX(city["�˿�"] / 5000, 0, 2) +  15/ limitX(110 - JY.Person[pid]["����"], 10, 110));
      if city["����"] == 3 then --���׶���
        grow = grow * 1.2;
      end
      grow = math.floor(grow);
      city["�ʽ�"] = limitX(city["�ʽ�"] + grow, 0, 10000);
    end
    --����ÿ��7������
    if pid > 0 and JY.Base["��ǰ��"] == 7 then
      local grow = 4 * city["����"] / 10 * (1 + limitX(city["�˿�"] / 5000, 0, 2) +  15/ limitX(110 - JY.Person[pid]["����"], 10, 110));
      grow = math.floor(grow);
      city["����"] = limitX(city["����"] + grow, 0, 10000);
    end
    --ٺ», ÿ��֧��
    if fid > 0 and city["����"] > 0 then
      city["�ʽ�"] = city["�ʽ�"] - city["����"] * 1;
      if city["�ʽ�"] < 0 then
        city["�ʽ�"] = 0;
      end
    end
    --����, ÿ��֧��
    if fid > 0 and city["����"] > 0 then
      city["����"] = city["����"] - math.ceil(city["����"] / 500);
      if city["����"] < 0 then
        city["����"] = 0;
      end
    end
	end
end
function AsuraGenTalkString(index,pid,eid)
	local id=JY.Person[pid]["̨��"];
	local txt_id;
	local str;
	if index==01 then
		
	elseif index==14 then			--������ת
		txt_id=math.random(6261,6280);
	elseif index==20 then			--ͻ��
		txt_id=math.random(6381,6390);
	elseif index==21 then			--����
		txt_id=math.random(6401,6410);
	elseif index==29 then			--���
		txt_id=math.random(6561,6580);
	elseif index==30 then			--ս����ʼ ����
		txt_id=math.random(6581,6587);
	elseif index==31 then			--ս����ʼ ����
		txt_id=math.random(6601,6609);
	elseif index==40 then			--����
		txt_id=math.random(6781,6788);
	elseif index==41 then		--̽��-ʧ��
		txt_id=math.random(6801,6815);
	elseif index==42 then		--̽��-�ɹ�
		txt_id=math.random(6821,6827);
	elseif index==43 then		--����
		txt_id=math.random(6841,6851);
	elseif index==44 then		--����-�ɹ�
		txt_id=math.random(6861,6875);
	elseif index==45 then		--����-ʧ��
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
	str=string.gsub(str,"$N","[Green]"..JY.Person[pid]["����"].."[Normal]");
	str=string.gsub(str,"$C","[Red]"..JY.Person[pid]["���"].."[Normal]");
	str=string.gsub(str,"$n","[Green]"..JY.Person[eid]["����"].."[Normal]");
	str=string.gsub(str,"$c","[Red]"..JY.Person[eid]["���"].."[Normal]");
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
	pt=pt+4*JY.City[cid]["��ģ"];
	pt=pt+2*JY.City[cid]["��ģ"];
	return pt;
end
function FilterPerson(fid,pt,bc_flag)
	local plist={};
	local rndlist={}
	local rlist={};
	local snum=20;
	local cpt=0;
	local jid=JY.Force[fid]["����"];
	JY.Person[jid]["��ս"]=1;
	for i=1,JY.PersonNum-1 do
		if JY.Person[i]["����"]==fid and JY.Person[i]["��ս"]==0 then
			table.insert(plist,i);
		end
	end
	if #plist>snum then
		table.sort(plist,function(a,b) if JY.Person[a]["����"]>JY.Person[b]["����"] then return true end end)
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
		if JY.Person[pid]["����"]==1 then
			table.insert(rndlist,JY.Person[pid]["����"]);
		else
			table.insert(rndlist,JY.Person[pid]["����"]/2);
		end
	end
	for i=1,snum do
		local r=PercentRandom(rndlist);
		local pid=plist[r];
		rndlist[r]=0;
		cpt=cpt+1+JY.Person[pid]["Ʒ��"];
		table.insert(rlist,pid);
		if cpt>pt then
			break;
		end
	end
	--table.sort(rlist,function(a,b) if JY.Person[a]["����"]>JY.Person[b]["����"] then return true end end)
	table.sort(rlist,function(a,b)
						local av,bv=JY.Person[a]["����"]+JY.Person[a]["ͳ��"],JY.Person[b]["����"]+JY.Person[b]["ͳ��"];
						if between(JY.Person[a]["����"],24,29) then
							av=av/4;
						elseif between(JY.Person[a]["����"],7,12) then
							av=av/2;
						end
						if between(JY.Person[b]["����"],24,29) then
							bv=bv/4;
						elseif between(JY.Person[b]["����"],7,12) then
							bv=bv/2;
						end
						if av>bv then
							return true;
						end
					end)
	--table.sort(rlist,function(a,b) if JY.Person[a]["����"]<JY.Person[b]["����"] then return true end end)
	if bc_flag then
		table.insert(rlist,1,jid);
	end
	for i,v in ipairs(rlist) do
		JY.Person[v]["��ս"]=1;
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
		if JY.Person[i]["��ս"]==0 and JY.Person[i]["����"]==JY.Person[leader]["����"] then --and GetXX(i,leader)<30 then
			if JY.Person[i]["Ʒ��"]==1 then
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
	local kid=JY.Person[pid]["ͳ��"];
	local str=JY.Person[oid]["����"];
	if kid==1 then	--����תΪ����
		if str=="������" then
			oid=GenPerson(true,pid,"����");
		end
	end
	return oid;
end
function GenPerson(flag,leader,name,name2)
	local plist={};
	local function basecheck(pid)
		if JY.Person[pid]["�ǳ�"]>=0 and JY.Person[pid]["��ս"]==0 and JY.Person[pid]["����"]==JY.Person[leader]["����"] and GetXX(pid,leader)<30 then
			return true;
		else
			return false;
		end
	end
	if not flag then
		if name2==nil then
			if name=="ͳ��" then
				name=TableRandom({"������","������","������","������","�����"});
			elseif name=="����" then
				name=TableRandom({"�����","�����","�����","�����","������"});
			elseif name=="��ı" then
				name=TableRandom({"������","������","������","������","����"});
			elseif name=="����" then
				name=TableRandom({"������","������","�����","����","������"});
			elseif name=="����" then
				name=TableRandom({"������","������","������","������","������"});
			elseif name=="�ｫ" then
				name=TableRandom({"�����","�����","�����","�����","�����"});
			elseif name=="����" then
				name=TableRandom({"������","������","������","������","������"});
			elseif name=="����" then
				name=TableRandom({"����","����","����","����","����"});
			elseif name=="ı��" then
				name=TableRandom({"������","������","������","������","����"});
			elseif name=="�ؽ�" then
				name=TableRandom({"������","������","�����","����","������"});
			else
				name="";
				return -1;
			end
		else
			name=name2;
		end
	end
	if name=="ͳ��" then
		plist={};
		for id=1,JY.PersonNum-1 do
			if basecheck(id) and between(JY.Person[id]["����"],60,85) and math.max(JY.Person[id]["ͳ��"],JY.Person[id]["��ı"])<JY.Person[id]["����"] then
				table.insert(plist,id);
			end
		end
		if #plist>0 then
			return TableRandom(plist);
		end
	elseif name=="����" then
		plist={};
		for id=1,JY.PersonNum-1 do
			if basecheck(id) and between(JY.Person[id]["����"],60,85) and math.max(JY.Person[id]["ͳ��"],JY.Person[id]["��ı"])<JY.Person[id]["����"] then
				table.insert(plist,id);
			end
		end
		if #plist>0 then
			return TableRandom(plist);
		end
	elseif name=="��ı" then
		plist={};
		for id=1,JY.PersonNum-1 do
			if basecheck(id) and between(JY.Person[id]["��ı"],60,85) and math.max(JY.Person[id]["ͳ��"],JY.Person[id]["����"])<JY.Person[id]["��ı"] then
				table.insert(plist,id);
			end
		end
		if #plist>0 then
			return TableRandom(plist);
		end
	elseif name=="����" then
		plist={};
		for id=1,JY.PersonNum-1 do
			if basecheck(id) and between(math.max(JY.Person[id]["ͳ��"],JY.Person[id]["��ı"],JY.Person[id]["����"]),60,80) and between(math.min(JY.Person[id]["ͳ��"],JY.Person[id]["��ı"],JY.Person[id]["����"]),60,80) then
				table.insert(plist,id);
			end
		end
		if #plist>0 then
			return TableRandom(plist);
		end
	elseif name=="����" then
		plist={};
		for id=1,JY.PersonNum-1 do
			if basecheck(id) and between(JY.Person[id]["����"],1,6) and between(math.max(JY.Person[id]["ͳ��"],JY.Person[id]["����"]),60,90) then
				table.insert(plist,id);
			end
		end
		if #plist>0 then
			return TableRandom(plist);
		end
	elseif name=="�ｫ" then
		plist={};
		for id=1,JY.PersonNum-1 do
			if basecheck(id) and between(JY.Person[id]["����"],13,18) and between(math.max(JY.Person[id]["ͳ��"],JY.Person[id]["����"]),60,90) then
				table.insert(plist,id);
			end
		end
		if #plist>0 then
			return TableRandom(plist);
		end
	elseif name=="����" then
		plist={};
		for id=1,JY.PersonNum-1 do
			if basecheck(id) and between(JY.Person[id]["����"],7,12) and between(math.max(JY.Person[id]["ͳ��"],JY.Person[id]["����"]),60,90) then
				table.insert(plist,id);
			end
		end
		if #plist>0 then
			return TableRandom(plist);
		end
	elseif name=="����" then
		plist={};
		for id=1,JY.PersonNum-1 do
			if basecheck(id) and between(JY.Person[id]["����"],19,23) and between(math.max(JY.Person[id]["ͳ��"],JY.Person[id]["����"]),60,90) then
				table.insert(plist,id);
			end
		end
		if #plist>0 then
			return TableRandom(plist);
		end
	elseif name=="ı��" then
		plist={};
		for id=1,JY.PersonNum-1 do
			if basecheck(id) and between(JY.Person[id]["����"],24,29) and between(math.max(JY.Person[id]["ͳ��"],JY.Person[id]["��ı"]),60,90) then
				table.insert(plist,id);
			end
		end
		if #plist>0 then
			return TableRandom(plist);
		end
	elseif name=="�ؽ�" then
		plist={};
		for id=1,JY.PersonNum-1 do
			if basecheck(id) and (between(JY.Person[id]["����"],30,32) or between(JY.Person[id]["����"],35,48)) and between(math.max(JY.Person[id]["ͳ��"],JY.Person[id]["��ı"],JY.Person[id]["����"]),60,90) then
				table.insert(plist,id);
			end
		end
		if #plist>0 then
			return TableRandom(plist);
		end
	elseif #name>0 then
		for id=1001,JY.PersonNum-1 do
			if JY.Person[id]["����"]==name and JY.Person[id]["��ս"]==0 then
				return id;
			end
		end
	end
	--for others
	plist={};
	for id=1001,JY.PersonNum-1 do
		if JY.Person[id]["��ս"]==0 then
			table.insert(plist,id);
		end
	end
	return TableRandom(plist);




end
function PlayCityBGM(cid, war)
  if cid > 0 then
    local mid = JY.City[cid]["����"];
    if war then
      mid = mid + 10;
    end
    PlayBGM(mid);
  end
end
function isLike(pid, eid)
  for i = 1, 5 do
    local id = JY.Person[pid]["�׽��佫" .. i];
    if id == 0 then
      break;
    elseif id == eid then
      return true;
    end
  end
  for i = 1, 5 do
    local id = JY.Person[eid]["�׽��佫" .. i];
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
    local id = JY.Person[pid]["����佫" .. i];
    if id == 0 then
      break;
    elseif id == eid then
      return true;
    end
  end
  for i = 1, 5 do
    local id = JY.Person[eid]["����佫" .. i];
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
	local sid=JY.Base["��ǰ�籾"];
	JY.Base["��ǰ��"]=252;
	JY.Base["��ǰ��"]=3;
	for fid=1,52 do
		JY.Force[fid]["״̬"]=JY.Force[fid]["״̬-�籾"..sid];
		JY.Force[fid]["����"]=JY.Force[fid]["����-�籾"..sid];
		JY.Force[fid]["�پ�"]=JY.Force[fid]["�پ�-�籾"..sid];
		JY.Force[fid]["����"]=JY.Force[fid]["����-�籾"..sid];
		JY.Force[fid]["����"]=JY.Person[JY.Force[fid]["����"]]["����"].."��"
	end
	for pid=1,1000 do
		JY.Person[pid]["�ǳ�"]=JY.Person[pid]["�ǳ�-�籾"..sid];
		JY.Person[pid]["����"]=JY.Person[pid]["����-�籾"..sid];
		JY.Person[pid]["����"]=JY.Person[pid]["����-�籾"..sid];
		JY.Person[pid]["�ҳ�"]=JY.Person[pid]["�ҳ�-�籾"..sid];
		JY.Person[pid]["����"]=JY.Person[pid]["����-�籾"..sid];
		if JY.Person[pid]["����"]==0 then
			JY.Person[pid]["����"]=math.random(1,50);
		end
		if JY.Person[pid]["����"]>0 then
			JY.Person[pid]["���"]=1;	--һ��
		else
			JY.Person[pid]["���"]=0;	--��Ұ
		end
	end
	for cid=1,50 do
		JY.City[cid]["����"]=JY.City[cid]["����-�籾"..sid];
		JY.City[cid]["̫��"]=JY.City[cid]["̫��-�籾"..sid];
		local pid=JY.City[cid]["̫��"];
		if pid>0 then
			JY.Person[pid]["���"]=2;	--̫��
		end
	end
	for fid=1,52 do
		local pid=JY.Force[fid]["����"];
		if pid>0 then
			JY.Person[pid]["���"]=3;	--����
		end
	end
	UpdateForce();
	for i,c in ipairs(JY.City) do
		--c["����"]=c["��ģ"]*100+math.random(10)-math.random(10);
	end
	if sid==3 then
		--JY.City[18]["����"]=10;
	end
	for fid=1,52 do
		local zj,wz=0,0;
		zj=zj+JY.Force[fid]["�پ�"]*10;
		wz=wz+JY.Force[fid]["�پ�"]*10;
		if zj>0 then
			JY.Force[fid]["�ʽ�"]=80+math.floor(zj*10);
		end
		if wz>0 then
			JY.Force[fid]["����"]=80+math.floor(wz*10);
		end
	end
end
--Force Relate
function NewForce(fid,pid,cid)
	local f=JY.Force[fid];
	f["����"]=JY.Person[pid]["����"].."��";
	f["״̬"]=1;
	f["����"]=pid;
	JY.Person[pid]["�ǳ�"]=3;
	f["�پ�"]=0;
	f["����"]=cid;
	JY.City[cid]["����"]=fid;
	f["ս��"]=0;
	f["�ʽ�"]=80+math.floor((3+JY.City[cid]["��ҵ"])*JY.City[cid]["����"]/20);
	f["����"]=80+math.floor((3+JY.City[cid]["ũҵ"])*JY.City[cid]["����"]/20);
end
function SelectForce(fid)
	local f=JY.Force[fid];
	JY.PID=f["����"];
	JY.FID=fid;
	JY.Base["��ǰ�ǳ�"]=f["����"];
	JY.Base["�ж���"]=3+f["�پ�"];
end
function UpdateCity(cid)
  local c = JY.City[cid];
  local fid = c["����"];
  local frontLine = 0;
  local ptA = 0;
  local ptB = 0;
  if fid > 0 then
    ptA = ptA + c["��ģ"] * 5;
    for i, v in pairs(JY.CityToCity[cid]) do
      ptA = ptA + 20;
      if JY.City[i]["����"] > 0 and JY.City[i]["����"] ~= fid then
        ptA = ptA + JY.City[i]["����"] / 2000;
        frontLine = 1;
      end
    end
    ptB = ptB + limitX(c["�˿�"] / 10, 0, 1000);
    if frontLine > 0 then
      ptB = ptB / 2;
    else
    end
    if c["����"] == 1 or c["����"] == 2 then
      ptB = ptB * 1.2;
    elseif c["����"] == 4 then
      ptA = ptA * 1.2;
    elseif c["����"] == 5 then
      ptA = ptA * 1.1;
    end
    if JY.Force[fid]["����"] == cid then
      ptA = ptA * 1.5;
      ptB = ptB * 1.5;
    end
    ptA = math.floor(ptA);
    ptB = math.floor(ptB);
  end
  c["ǰ��"] = frontLine;
  c["ս�Լ�ֵ"] = ptA;
  c["���Լ�ֵ"] = ptB;
end
function UpdateForcePersonNum(fid)
	local num=0;
	for pid,v in ipairs(JY.Person) do
		if v["����"]==fid then
			num=num+1;
		end
	end
	JY.Force[fid]["����"]=num;
end
function UpdateForce()
	--Reset all
	for fid,v in pairs(JY.Force) do
		v["�ǳ�"]=0;
		v["����"]=0;
	end
	for cid,v in ipairs(JY.City) do
		local fid=v["����"];
		v["����"]=0;
		v["��Ұ"]=0;
    UpdateCity(cid);
	end
	ConnectCity();
	--Person
	for pid,v in ipairs(JY.Person) do
		if v["�ǳ�"]==2 or v["�ǳ�"]==3 then
			local cid=v["����"];
			if cid>0 then
				local fid=v["����"];
				if fid>0 then
					JY.City[cid]["����"]=JY.City[cid]["����"]+1;
				else
					JY.City[cid]["��Ұ"]=JY.City[cid]["��Ұ"]+1;
				end
			end
		end
	end
	--City
	for cid,v in ipairs(JY.City) do
		local fid=v["����"];
		if fid>0 then
			JY.Force[fid]["�ǳ�"]=JY.Force[fid]["�ǳ�"]+1;
			JY.Force[fid]["����"]=JY.Force[fid]["����"]+v["����"];
		end
	end
	--Force
	for fid,v in pairs(JY.Force) do
		if v["״̬"]>0 then
			if v["�ǳ�"]==0 then
				Talk("����",string.format("[Green]%s[Normal]���ˣ�[Red]%s[Normal]�����ˡ�",JY.Person[JY.PID]["����"],JY.Force[fid]["����"]));
				v["״̬"]=0;
				break;
			else
				local bcid=v["����"];
				if JY.City[bcid]["����"]~=fid then
					local t_city={};
					for j,w in ipairs(JY.City) do
						if w["����"]==fid then
							table.insert(t_city,j);
						end
					end
					table.sort(t_city,function(a,b) if JY.City[a]["��ģ"]+JY.City[a]["����"]>JY.City[b]["��ģ"]+JY.City[b]["����"] then return true end end)
					local nbc=t_city[1];
					v["����"]=nbc;
					Talk("����",string.format("[Green]%s[Normal]���ˣ�[Red]%s[Normal]Ǩ�Ʊ�����[Red]%s[Normal]�ˡ�",JY.Person[JY.PID]["����"],JY.Force[fid]["����"],JY.City[nbc]["����"]));
				end
			end
		end
	end
	--ZhongCheng
	for fid,v in pairs(JY.Force) do
		if v["״̬"]>0 then
			ZhongCheng(fid);
		end
	end
end
function ZhongCheng(fid)
	local t={};
	for i,v in ipairs(JY.Person) do
		if v["����"]==fid then
			if i~=JY.Force[fid]["����"] then
				table.insert(t,{id=i,v=v["����"]});
			end
		end
	end
	table.sort(t,function(a,b) return a.v>b.v end);
	local n=#t;
	for i=1,6 do
		JY.Force[fid]["�س�"..i]=0;
	end
	for i=1,math.min(n,6) do
		JY.Force[fid]["�س�"..i]=t[i].id;
	end
end
function occupyCity(fid, cid)
  local c = JY.City[cid];
  local eForce = c["����"];
  
  c["����"] = fid;
  c["̫��"] = 0;
  if eForce == 0 then
    return;
  end
  
  local retreatCityList = {};
  for i, v in pairs(JY.CityToCity[cid]) do
    if JY.City[i]["����"] == c["����"] then
      table.insert(retreatCityList, i);
    end
  end
  local retreatCity = 0;
  if #retreatCityList > 0 then
    retreatCity = TableRandom(retreatCityList);
  end
  local master = JY.Force[fid]["����"];
  for i = 1, 750 do
    if JY.Person[i]["����"] == eForce and JY.Person[i]["����"] == cid then
      JY.Person[i]["���"] = 1;
      if retreatCity > 0 and math.random() < 0.1 + math.max(JY.Person[i]["����"], JY.Person[i]["��ı"]) / 125 then  -- ���˳ɹ�����
        JY.Person[i]["����"] = retreatCity;
      elseif true then
        dispathPrisoner(fid, i);
      elseif GetXX(i, master) < math.random(100) then --����
        JY.Person[i]["����"] = fid;
      else
        JY.Person[i]["����"] = 0;
        JY.Person[i]["���"] = 0;
      end
    end
  end
  
end
function dispathPrisoner(fid, pid)
  local bt = {};
  local width, height = 800, 360;
  local x0, y0 = (CC.ScreenW - width) / 2, (CC.ScreenH - height) / 2;
  table.insert(bt, button_creat(1, 1, CC.ScreenW / 2 + 0, CC.ScreenH - y0 - 72, "Ȱ��", true, true));
  table.insert(bt, button_creat(1, 2, CC.ScreenW / 2 + 104, CC.ScreenH - y0 - 72, "��ն", true, true));
  table.insert(bt, button_creat(1, 3, CC.ScreenW / 2 + 208, CC.ScreenH - y0 - 72, "�ͷ�", true, true));
  local p = JY.Person[pid];
  local str = genPrisonerString(pid);
  local function redraw()
		DrawGame();
    local size = 20;
    local x, y = x0, y0;
    LoadPicEnhance(73, x, y, width, height);
    x = x + 96; y = y + 10;
    lib.PicLoadCache(2, p["��ò"] * 2, x, y, 1, nil, nil, nil, 340);
    x = x - 32; y = y0 + height - 80;
		LoadPicEnhance(207, x - 40, y - 16, 320 + 80, 96);
		DrawStringEnhance(x + 36, y ,p["����"], C_ORANGE, size, 0.5);
		DrawStringEnhance(x + 72, y ,str, M_White, size);
    --drawAttribute
    x = x0 + width / 2; y = y0 + 32;
    DrawStringEnhance(x, y, p["����"] .. " " .. p["��"], C_WHITE, size);
    y = y + size + 4;
    DrawStringEnhance(x, y, string.format("ͳ�� [w]%3d[name] ���� [w]%3d[name] ��ı [w]%3d[n][name]���� [w]%3d[name] ���� [w]%3d", p["ͳ��"], p["����"], p["��ı"], p["����"], p["����"]), C_Name, size);
    y = y + (size + 2) * 2;
    DrawStringEnhance(x, y, "����  [w]" .. JY.Str[p["��������"] + 9160] .. " [name]����  [w]" .. JY.Str[p["��������"] + 9160] .. " [name]���  [w]" .. JY.Str[p["�������"] + 9160], C_Name, size);
    y = y + (size + 4);
    DrawSkillTable(pid, x, y);
    
    x, y = CC.ScreenW / 2, y0 - 36;
    lib.PicLoadCache(4, 4 * 2, x, y);
    DrawStringEnhance(x, y, "���÷�²", C_WHITE, 36, 0.5, 0.5);
		button_redraw(bt);
  end
  local master = JY.Force[fid]["����"];
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
    "ƫƫ��" .. JY.Person[pid]["����"] .. "����",
    "�ܷ����Ҽ����ֳ���[n]�����������",
    "���ˣ�[n]����һ�����������ԡ�",
    "����",
    "�ҳ����̶�����[n]���Ѿ�����ˡ�",
    "��ڰ�����",
    "���ɣ�",
    "���ֻ�������������ѣ�[n]�´β���ܸ��㡣",
    "�ߣ�Ϊʲô�һ������",
    "������Ҳʧȥ�����ˡ�",
    "�������ˣ�[n]ֻ�����������ˡ�",
    "�ܻ�����[n]����Թ�޻ڡ���",
    "������ҵ�ĩ����[n]�治��񫡭��",
  };
  return TableRandom(str);
end
function genPrisonerApproveString(pid)
  local str = {
    "���ܾ�����[n]̫���ˡ�",
    "�����Ҳ��Ե�֣�[n]Ը��Ϊ��Ч�͡�",
    "֪���ˡ�[n]�ӽ���Ը������Ȩ���ˡ�",
    "�������������̷����£�[n]Ը����Ч�͡�",
    "��Ҳ��Ϊ�����°�����[n]�ҽ��������ˡ�",
    "���ֳ���ͬս��Ҳ������[n]Ը��Ч�͡�",
    "����ʵ�������ѣ�[n]�������ƴ�֮��",
    "�ҿ����Ĳ�ֻ��ս��������[n]ϣ����������������",
  };
  return TableRandom(str);
end
function genPrisonerRejectString(pid)
  local str = {
    "�Ҳ��ܺ����޳ܵ����棡",
    "��˵������ ���룬[n]���������İɣ�",
    "���ǲ����ܵ��¡�",
    "�ҳ����̶�����",
  };
  return TableRandom(str);
end
function genPrisonerReleaseString(pid)
  local str = {
    "�����ѵã������ס��[n]ս���ϲ������顣",
    "��˵Ҫ�ͷ�����[n]������л��",
    "��л�ˡ�",
    "�´β���ͬ���Դ���",
    "�´��ټ��ɡ�",
    "�����������[n]����û��ɱ���ҡ�",
    "���𣬿ɱ���Ŷ��",
  };
  return TableRandom(str);
end
function genPrisonerKillString(pid)
  local fid = JY.Person[pid]["����"];
  local id = JY.Force[fid]["����"];
  local name = JY.Person[id]["����"];
  local str = {
    "�Բ���" .. name .."���ˣ�[n]������Ϊ��Ч���ˡ�",
    name .."���ˣ���ԭ�¡�",
    "��һ����ʲô�ط�����ˡ�",
    "�ܹ�Ϊ��" .. name .."��������������Ч�͹���[n]����ڡ�",
    "����Ϊֹ��[n]" .. name .."���ˣ��Բ���",
  };
  return TableRandom(str);
end