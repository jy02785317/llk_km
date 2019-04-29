function Config()
	lib.LoadConfig(	CC.MusicVolume,
					CC.SoundVolume,
					CONFIG.EnableSound,
					CC.ScreenW,
					CC.ScreenH,
					CONFIG.FullScreen);
end
function Config()

end
function SystemMenu()
	--PlayWavE(0);
	--lib.PicLoadCache(4,58*2,)
	local menu={
					{"������Ϸ",nil,1,true},
					{"����",nil,1,true},
					{"����",nil,1,true},
					{"�����趨",nil,1,true},
					{"����Lua",nil,1,true},
				}
	local r=ShowNewMenu(menu,0,0,1);
	lib.Delay(100);
	if r==1 then
		if TalkYesNo("",'������Ϸ��',C_WHITE,true) then
			lib.Delay(100);
			if TalkYesNo("",'����һ����',C_WHITE,true) then
				lib.Delay(100);
				JY.Status=GAME_START;
			else
				lib.Delay(100);
				JY.Status=GAME_END;
			end
		end
	elseif r==2 then
		ShowRecordMenu(0);
	elseif r==3 then
		ShowRecordMenu(1);
	elseif r==4 then
		--SettingMenu();
		NewPerson(JY.PID);	--��ʼ������
	elseif r==5 then
		dofile(CONFIG.ScriptPath .. "S.RPG.lua");
		dofile(CONFIG.ScriptPath .. "S.lua");
		dofile(CONFIG.ScriptPath .. "fight.lua");
		dofile(CONFIG.ScriptPath .. "UI.lua");
		dofile(CONFIG.ScriptPath .. "mouse.lua");
		dofile(CONFIG.ScriptPath .. "input.lua");
		dofile(CONFIG.ScriptPath .. "Asura.lua");
		dofile(CONFIG.ScriptPath .. "AI.lua");
		dofile(CONFIG.ScriptPath .. "kdef.lua");
		dofile(CONFIG.ScriptPath .. "LLK_III.lua");
    --dispathPrisoner(1, 356);
	end
	
	return false;
end
function InfoMenu()
	--PlayWavE(0);
	local menu={
					{"����",nil,1,true},
					{"����",nil,1,true},
					{"����",nil,1,false},
					{"ȫ������",nil,1,true},
					{"ȫ������",nil,1,true},
					{"ȫ���佫",nil,1,true},
          {"��ͼ", nil, 1, true},
				}
	local fid = JY.Person[JY.PID]["����"];
  if fid > 0 then
    menu[3][4] = true;
  end
  local r=ShowNewMenu(menu,0,0,1);
	lib.Delay(100);
	if r==1 then
		ReSetAttrib(JY.PID,true);
		PersonStatus({JY.PID},1);
	elseif r==2 then
		DrawCityStatus({JY.Person[JY.PID]["����"]},1)
	elseif r==3 then
		DrawForceStatus({fid}, 1);
	elseif r==4 then
    DrawForceStatus(GetAllForceList(), 1);
	elseif r==5 then
		ShowCityList(GetAllCityList(),0);
	elseif r==6 then
		ShowPersonList(GetMyList(),nil,PersonStatus);
  elseif r == 7 then
    CityMap:show();
	end
	return false;
end
function GetRecordInfo(id)
	local offset=CC.Base_S["�½���"][1]+100;
	local len=CC.Base_S["�½���"][3]+CC.Base_S["ʱ��"][3];
	local data=Byte.create(8*len);
	Byte.loadfile(data,CC.R_GRPFilename[id],offset,len);
	local SectionName,SaveTime;
	SectionName=Byte.getstr(data,0,28);
	SaveTime=Byte.getstr(data,28,14);
					
	offset=CC.Base_S["ս���浵"][1]+100;
	Byte.loadfile(data,CC.R_GRPFilename[id],offset,len);
	if Byte.get16(data,0)==1 then
		offset=CC.Base_S["ս������"][1]+100;
		Byte.loadfile(data,CC.R_GRPFilename[id],offset,len);
		SectionName=Byte.getstr(data,0,28);
		
		offset=100+136;
		Byte.loadfile(data,CC.R_GRPFilename[id],offset,len);
		local turn=Byte.get8(data,0);
		local maxturn=Byte.get8(data,1);
		SectionName=string.gsub(SectionName,"    ","  ");
		if string.len(SectionName)<14 then
			SectionName=string.format(string.format("%%s%%%ds",14-string.len(SectionName)),SectionName,"")..string.format("��%02d�غ�",turn,maxturn);
		end
	end
					
	if CC.SrcCharSet==1 then
		SectionName=lib.CharSet(SectionName,0);
	end
	
	return id.."."..SectionName,SaveTime;
end
function ShowRecordMenu(kind)	--kind 0��ȡ  1����
	local num=8;
	local menu={};
	for id=1,num do
		menu[id]={"",nil,1,true};
		if not fileexist(CC.R_GRPFilename[id]) then
			menu[id][1],menu[id][2]=id..".".."δʹ�õ���","";
			if kind==0 then
				menu[id][4]=false;
			end
		else
			menu[id][1],menu[id][2]=GetRecordInfo(id);
		end
	end
	local r=ShowNewMenu(menu,0,0,1);
	if r>0 then
		if kind==0 then
			if string.sub(menu[r][1],5)~="δʹ�õ���" then
				if WarDrawStrBoxYesNo(string.format("������Ӳ���ĵ�%d���ȣ�������",r),C_WHITE) then
					LoadRecord(r);
				end
			else
				WarDrawStrBoxConfirm("û������",C_WHITE,true);
			end
		elseif kind==1 then
			if WarDrawStrBoxYesNo(string.format("������Ӳ���ĵ�%d�ţ�������",r),C_WHITE) then
				if JY.Status==GAME_WMAP then
					--WarSave(r);
				else
					SaveRecord(r);
				end
			end
		end
	end
end
function SetSceneID(id,BGMID)
	JY.SubScene=id;
	Dark();
		if BGMID~=nil then
			PlayBGM(BGMID);
		end
		DrawGame();
	Light();
end
function isTalkTo(name)
	local pid=-1;
	if JY.NameList[name]~=nil then
		pid=JY.NameList[name];
	else
		lib.Debug("isTalkTo: "..name.." not exist");
		return false;
	end
	if pid==JY.Tid then
		return true;
	else
		return false;
	end
end
function SMapEvent()
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
	local function redraw()
		DrawSMap();
		DrawGameStatus();
		for i,v in pairs(JY.Scene) do
			if v["����"]>=0 then
				local x,y=v["����X"],v["����Y"];
				local str=JY.Person[v["����"]]["����"];
				if JY.Tid==v["����"] then
					lib.PicLoadCache(2,(JY.Person[v["����"]]["��ò"]+4000)*2,x+4,y+4,1);
					lib.PicLoadCache(4,2*2,x,y,1);
					DrawStringEnhance(x+49-size*#str/4+1,y+141-size/2+1,str,C_Name,size);
					--DrawYJZBox(-1,12,str,C_WHITE);
				else
					lib.PicLoadCache(2,(JY.Person[v["����"]]["��ò"]+4000)*2,x+3,y+3,1);
					lib.PicLoadCache(4,1*2,x,y,1);
					DrawStringEnhance(x+49-size*#str/4,y+141-size/2,str,C_WHITE,size);
				end
			end
		end
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
				end
			else
				lib.PicLoadCache(4,v.pic*2,v.x1,v.y1,1);
			end
		end
	end
	while JY.Status==GAME_SMAP_MANUAL do
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
		JY.Tid=0;
		for i,v in pairs(JY.Scene) do
			if v["����"]>=0 then
				local px,py=v["����X"],v["����Y"];
				if MOUSE.CLICK(px+4,py+4,px+93,py+150) then
					JY.Tid=v["����"];
					PlayWavE(0);
					DoEvent(JY.EventID);
					if JY.Tid==-1 then
						JY.Tid=0;
						return;
					end
					JY.Tid=0;
					break;
				elseif MOUSE.IN(px+4,py+4,px+93,py+150) then
					JY.Tid=v["����"];
				end
			end
		end
		for i,v in pairs(bt) do
			if MOUSE.CLICK(v.x1,v.y1,v.x2,v.y2) then
				current=i;
				PlayWavE(0);
				if current==1 then
					InfoMenu();
				elseif current==2 then
					SystemMenu();
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
	end
	
	
	
	
	
	
		--[[
		local eventtype,keypress,x,y=getkey();
		if MOUSE.HOLD(673,321,710,366) then
			lib.PicLoadCache(4,220*2,673,321,1);
		elseif MOUSE.HOLD(713,321,750,366) then
			lib.PicLoadCache(4,221*2,713,321,1);
		elseif MOUSE.HOLD(673,369,710,414) then
			lib.PicLoadCache(4,222*2,673,369,1);
		elseif MOUSE.HOLD(713,369,750,414) then
			lib.PicLoadCache(4,223*2,713,369,1);
		end
		if MOUSE.CLICK(673,321,710,366) then
			PlayWavE(0);
			HirePerson();
		elseif MOUSE.CLICK(713,321,750,366) then
			PlayWavE(0);
			Person_Menu();
		elseif MOUSE.CLICK(673,369,710,414) then
			Shop();
		elseif MOUSE.CLICK(713,369,750,414) then
			SystemMenu();
		elseif MOUSE.CLICK(680,24,742,102) then
			JY.LLK_N=JY.LLK_N+1;
			if JY.LLK_N>99 then
				PlayWavE(0);
				if WarDrawStrBoxYesNo("��ֹ����������ģʽ*��ִ�н�������κ����Σ�*���ҶԴ˵�ѯ��Ҳ����𣮿�����",C_WHITE,true) then--���Խ����������Ұ��״̬��
					Game_Cycle();
				else
					JY.LLK_N=0;
				end
			end
		end]]--
end

function DoEvent(id,kind)
	JY.EventType=kind or 0;
	if type(Event[id])=='function' then
		Event[id]();
	else
		return;
	end
	if id>9999 then
		os.exit();
	end
	if id~=JY.EventID then
		return true;
	else
		return false;
	end
end
function NextEvent(id)
	if id==nil then
		JY.EventID=JY.EventID+1;
	else
		JY.EventID=id;
	end
end
function PicCacheIni()
	lib.PicInit(CC.PaletteFile)
	lib.PicLoadFile(CC.MMAPPicFile[1],CC.MMAPPicFile[2],0);
	lib.PicLoadFile(CC.WMAPPicFile[1],CC.WMAPPicFile[2],1);
	lib.PicLoadFile(CC.HeadPicFile[1],CC.HeadPicFile[2],2);
	--3����ʹ��
	lib.PicLoadFile(CC.UIPicFile[1],CC.UIPicFile[2],4);
	lib.PicLoadFile(CC.SMAPPicFile[1],CC.SMAPPicFile[2],5);
	lib.PicLoadFile(CC.EFT[1],CC.EFT[2],6);
	lib.PicLoadFile(CC.WMAPPicFile[1],CC.WMAPPicFile[2],11,200);
	lib.PicLoadFile(CC.WMAPPicFile[1],CC.WMAPPicFile[2],12,125);
end
function Password()
	local f=0;
	local T3={"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"};
	local str="";
	if filelength(	CC.PASCODE[53]..CC.PASCODE[54]..
					CC.PASCODE[29]..CC.PASCODE[8]..CC.PASCODE[5]..CC.PASCODE[14]..CC.PASCODE[50]..CC.PASCODE[53]..
					CC.PASCODE[4]..CC.PASCODE[5]..CC.PASCODE[2]..CC.PASCODE[21]..CC.PASCODE[7])==13 then--".\\ChenX.debug")==13 then
		CC.Debug=1;
		return;
	else
		return;
	end
	while true do
		JY.ReFreshTime=lib.GetTime();
		lib.PicLoadCache(4,83*2,0,0,1);
		if f==0 then
			lib.FillColor(40,14,49,16);
		end
		f=1-f;
		ReFresh();
		local key=getkey();
		if key==VK_ESCAPE then
			str="";
		elseif key==VK_RETURN then
			if str=='txdxmc' then
				CC.Debug=1;
			elseif str=='fps' then
				CC.FPS=true;
			elseif str=='exit' then
				os.exit();
			elseif str=='824826abab' then--���������������£���
				Game_Cycle();
				os.exit();
			elseif str=="fight" then
				--
				LoadRecord(0);
				for i=1,JY.PersonNum-1 do
					GetPic(i);
				end
				fight(3,5,1);
				--
			end
			break;
		elseif between(key,97,122) then
			str=str..T3[key-96];
		elseif key==SDLK_UP then
			str=str..'8';
		elseif key==SDLK_DOWN then
			str=str..'2';
		elseif key==SDLK_LEFT then
			str=str..'4';
		elseif key==SDLK_RIGHT then
			str=str..'6';
		end
	end
	Dark();
end
function YJZMain()
	local saveflag=false;	--ս����ʾ������
	JY.Status=GAME_START;  --��Ϸ��ǰ״̬
	PicCacheIni();
	
	--
	--LoadRecord(0);
	--for i=1,JY.PersonNum-1 do
	--	GetPic(i);
	--end
	--fight(3,5,1);
	--
	
	Password();
	LoadRecord(0);
	for i=1,JY.PersonNum-1 do
		GetPic(i);
	end
	while true do
		if JY.Status==GAME_START then
			StopBGM();
			SetSceneID(200,0);
			while JY.Status==GAME_START do
				YJZMain_sub();
			end
		elseif JY.Status==GAME_SMAP_AUTO then
			DoEvent(JY.EventID);
		elseif JY.Status==GAME_SMAP_MANUAL then
			SMapEvent();
		elseif JY.Status==GAME_MMAP then
			
		elseif JY.Status==GAME_WMAP then
			WarStart();
			if JY.Status==GAME_SMAP_AUTO or JY.Status==GAME_SMAP_MANUAL then
				saveflag=true;
			end
		elseif JY.Status==GAME_WMAP2 then	--����ս��
			JY.Status=GAME_WMAP;
			DoEvent(JY.EventID);
		elseif JY.Status==GAME_WARWIN then
			JY.Status=GAME_SMAP_AUTO;
		elseif JY.Status==GAME_WARLOSE then
			JY.Status=GAME_START;
		elseif JY.Status==GAME_DEAD then
			
		elseif JY.Status==GAME_END then
			Dark();
			lib.Delay(50)
			os.exit();
		end
	end
end
function YJZMain_sub()
	local menu={
				{"��ʼ����Ϸ",nil,1,true},
				{"��ȡ�浵",nil,1,true},
				{"�����趨",nil,1,true},
				{"ս������",nil,0,true},
				{"������",nil,1,true},
				{"�ۿ�������",nil,1,true},
				{"�˳���Ϸ",nil,1,true},
			}
		if CC.Debug==1 then
			menu[4][3]=1;
		end
		lib.Delay(200);
		local s=ShowNewMenu(menu,0,0,0);
		if s==1 then
			LoadRecord(0);
			JY.Person[1]["�ȼ�"]=3;
			JY.Person[2]["�ȼ�"]=3;
			JY.Person[3]["�ȼ�"]=3;
			for i=1,JY.PersonNum-1 do
				GetPic(i);
			end
			JY.Status=GAME_SMAP_AUTO;  --��Ϸ��ǰ״̬
			JY.EventID=1;
		elseif s==2 then
			ShowRecordMenu(0);
		elseif s==3 then
			SettingMenu();
		elseif s==4 then
			LoadRecord(0);
			for i=1,JY.PersonNum-1 do
				GetPic(i);
			end
			JY.Status=GAME_SMAP_AUTO;  --��Ϸ��ǰ״̬
			NewPerson();	--��ʼ������
			JY.EventID=12;
		elseif s==5 then
			PlayBGM(18);
			FightMenu();
		elseif s==6 then
			--
			--hash
			--[[
			local nidx=Byte.create(4*1236);
			local idxdata=Byte.create(4*1236);
			Byte.loadfile(idxdata,CC.EFT[1],0,4*1236);
			local idx={}
			for i=1,1236 do
				idx[i]=Byte.get32(idxdata,(i-1)*4);
			end
			local ngrp=Byte.create(4*idx[1236]);
			idx[0]=0;
			local oldhash=0;
			local newhash=0;
			local len=0;
			for i=0,1235 do
				local data=Byte.create(idx[i+1]-idx[i]);
				Byte.loadfile(data,CC.EFT[2],idx[i],idx[i+1]-idx[i]);
				newhash=Byte.hash(data,idx[i+1]-idx[i]);
				if newhash~=oldhash then
					Byte.savefile(data,'.\\data\\a.grp',len,idx[i+1]-idx[i]);
					len=len+idx[i+1]-idx[i];
					Byte.set32(nidx,i*4,len);
				else
					Byte.set32(nidx,i*4,len);
				end
				oldhash=newhash;
				lib.Debug(string.format("%04d	%s",i,newhash));
				
			end
			Byte.savefile(nidx,'.\\data\\a.idx',0,4*1236);
			]]--
			--
			lib.PicLoadFile(CC.EFT[1],CC.EFT[2],6);
			PlayBGM(2);
			local cx,cy=CC.ScreenW/2,CC.ScreenH/2;
			for picid=0,1236 do
				JY.ReFreshTime=lib.GetTime();
				lib.PicLoadCache(6,picid*2,cx,cy);
				ReFresh(8);
				local eventtype=lib.GetKey(1);
				if eventtype==1 or eventtype==3 then
					Dark();
					lib.Delay(1000);
					break;
				end
			end
			PicCacheIni();
		elseif s==7 then
			if TalkYesNo("",'������Ϸ��',C_WHITE,true) then
				lib.Delay(100);
				if TalkYesNo("",'����һ����',C_WHITE,true) then
					lib.Delay(100);
					JY.Status=GAME_START;
				else
					lib.Delay(100);
					JY.Status=GAME_END;
				end
			end
		end
end
function DrawStrBoxCenter(str)
	local size=24;
	local function redraw()
		DrawGame();
		lib.PicLoadCache(4,4*2,CC.ScreenW/2-137,CC.ScreenH/2-32,1);
		DrawStringEnhance(CC.ScreenW/2-size*#str/4,CC.ScreenH/2-size/2,str,C_WHITE,size);
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
		if MOUSE.CLICK(0,0,CC.ScreenW,CC.ScreenH) then
			break;
		end
	end
end
function GenTalkString(str,n)              --�����Ի���ʾ��Ҫ���ַ���
    local tmpstr=str;
	local num=0;
	local v,vv;
    local newstr="";
    while #tmpstr>0 do
		num=num+1;
		local w=0;
		while w<#tmpstr do
		    v=string.byte(tmpstr,w+1);          --��ǰ�ַ���ֵ
			vv=string.sub(tmpstr,w+1,w+2);
			if vv=="\\n" then
				break;
			elseif v>=128 then
			    w=w+2;
			else
			    w=w+1;
			end
			if w >= 2*n-1 then     --Ϊ�˱����������ַ�
			    break;
			end
		end

        if w<#tmpstr then
			if vv=="\\n" then
				if w>0 then
					newstr=newstr .. string.sub(tmpstr,1,w+2);
				end
				tmpstr=string.sub(tmpstr,w+3,-1);
		    elseif w==2*n-1 and string.byte(tmpstr,w+1)<128 then
				newstr=newstr .. string.sub(tmpstr,1,w+1) .. "\\n";
				tmpstr=string.sub(tmpstr,w+2,-1);
			else
				newstr=newstr .. string.sub(tmpstr,1,w)  .. "\\n";
				tmpstr=string.sub(tmpstr,w+1,-1);
			end
		else
		    newstr=newstr .. tmpstr;
			break;
		end
	end
    return newstr,num;
end
----------------------------------------------------------------
--	SetFlag(eid,flag)
--	�����¼�
--	eid �¼�id
--	flag �¼�״̬
----------------------------------------------------------------
function SetFlag(eid,flag)
	JY.Base["�¼�"..eid]=flag;
end
function WarSetFlag(eid,flag)
	JY.Base["ս���¼�"..eid]=flag;
end
----------------------------------------------------------------
--	GetFlag(eid)
--	����¼�
--	eid �¼�id
--	>0�����棬���򷵻ؼ�
----------------------------------------------------------------
function GetFlag(eid,flag)
	if flag then
		return JY.Base["�¼�"..eid];
	elseif JY.Base["�¼�"..eid]>0 then
		return true;
	else
		return false;
	end
end
function WarGetFlag(eid,flag)
	return JY.Base["ս���¼�"..eid];
end
function WarCheckFlag(eid,flag)
	if JY.Base["ս���¼�"..eid]>0 then
		return true;
	else
		return false;
	end
end
----------------------------------------------------------------
--	WarModifyTeamAI(tid,ai)
--	�޸ľ����佫AI
--	tid ����id
--	ai 
----------------------------------------------------------------
function WarModifyTeamAI(tid,ai,ai_x,ai_y)
	for i,v in ipairs(War.Person) do
		--??��û�б�Ҫ���Ʋ��ӱ������??
		if v.tid==tid and v.live and (not v.hide) then
			WarModifyAI(i,ai,ai_x,ai_y)
		end
	end
end
function WarModifyTeamLeaderAI(tid,ai,ai_x,ai_y)
	for i,v in ipairs(War.Person) do
		--??��û�б�Ҫ���Ʋ��ӱ������??
		if v.tid==tid and v.live and (not v.hide) then
			WarModifyAI(i,ai,ai_x,ai_y);
			return;
		end
	end
end
----------------------------------------------------------------
--	WarModifyAI(pid,ai)
--	�޸��佫AI
--	pid �佫id
--	ai 
----------------------------------------------------------------
function WarModifyAI(wid,ai,ai_x,ai_y)
	if not between(wid,1,War.PersonNum) then
		lib.Debug("WarModifyAI wid="..wid.." not exist.")
		return;
	end
	if ai=="����" then
		ai=0;
	elseif ai=="����" then
		if ai_y>0 then
			ai=4;
		elseif ai_x>0 then
			ai=3;
		else
			ai=1;
		end
	elseif ai=="����" then
		ai=2;
	elseif ai=="����" then
		ai=4;
		ai_x=War.Person[wid].x;
		ai_y=War.Person[wid].y;
	elseif ai=="�ƶ�" then
		if ai_y>0 then
			ai=6;
		elseif ai_x>0 then
			ai=5;
		else
			ai=0;
		end
	end
	if wid>0 then
		War.Person[wid].ai=ai;
		War.Person[wid].aitarget=0;
		War.Person[wid].ai_dx=0;
		War.Person[wid].ai_dy=0;
		if ai==3 or ai==5 then
			War.Person[wid].aitarget=ai_x;
		elseif ai==4 or ai==6 then
			War.Person[wid].ai_dx=ai_x;
			War.Person[wid].ai_dy=ai_y;
		end
	else
		lib.Debug("WarModifyAI_AI_Target: "..name.." wid not exist");
	end
end
----------------------------------------------------------------
--	ModifyForce(pid,fid)
--	�޸��佫��Ӫ
--	pid �佫id
--	fid ��Ӫid��Ĭ��Ϊ1
----------------------------------------------------------------
function ModifyForce(pid,fid)
	if pid==nil then
		return;
	end
	fid=fid or 1;
	--�޸��佫����ͳ��
	if JY.Person[pid]["����"]==1 and fid~=1 then
		--JY.Base["�佫����"]=JY.Base["�佫����"]-1;
	end
	if JY.Person[pid]["����"]~=1 and fid==1 then
		--JY.Base["�佫����"]=JY.Base["�佫����"]+1;
	end
	--��������ҷ�������ȷ�ϵȼ�
	if fid==1 then
		JY.Person[pid]["�ȼ�"]=limitX(JY.Person[pid]["�ȼ�"],1,99);
	end
	
	JY.Person[pid]["����"]=fid;
	local picid=GetPic(pid);
	if fid==1 and type(War.Person)=="table" then--ս��ʱ���������Ϊ����������Ҫ�����޸�ս����������
		for i,v in pairs(War.Person) do
			if v.id==pid then
				v.enemy=false;
				v.friend=false;
				v.pic=WarGetPic(i);
				break;
			end
		end
	end
end
----------------------------------------------------------------
--	ModifyBZ(pid,bzid)
--	�޸��佫����
--	pid �佫id
--	bzid ����id��Ĭ��Ϊ1
----------------------------------------------------------------
function ModifyBZ(pid,bzid)
	if pid==nil then
		return;
	end
	bzid=bzid or 1;
	JY.Person[pid]["����"]=bzid;
end
----------------------------------------------------------------
--	LoadPic(id,flag)
--	��ʾ����ͼƬ�����߿򣩣������뵭��Ч��
--	flag 0.��Ч�� 1.���� 2.����
----------------------------------------------------------------
function LoadPic(id,flag)
	local w,h=lib.PicGetXY(5,id*2);
	local x=(CC.ScreenW-w)/2;
	local y=(CC.ScreenH-h)/2-56;
	flag=flag or 0;
	if type(flag)=="string" then
		if flag=="����" then
			flag=1;
		elseif flag=="����" then
			flag=2;
		else
			flag=0;
		end
	end
	if true then
		JY.SubPic=-1;
		--DrawSMap();
		DrawGame();
		local sid=lib.SaveSur(x,y,x+w,y+h);
		if flag==0 then
			lib.PicLoadCache(5,id*2,x,y,1);
		elseif flag==1 then	--����
			for i=0,256,16 do
				JY.ReFreshTime=lib.GetTime();
				lib.LoadSur(sid,x,y);
				lib.PicLoadCache(5,id*2,x,y,1+2,i);
				lib.GetKey();
				ReFresh();
				JY.SubPic=id;
			end
		elseif flag==2 then	--����
			for i=0,256,16 do
				JY.ReFreshTime=lib.GetTime();
				lib.LoadSur(sid,x,y);
				lib.PicLoadCache(5,id*2,x,y,1+2,256-i);
				lib.GetKey();
				ReFresh();
			end
		end
		lib.FreeSur(sid);
	end
	for i=1,CC.OpearteSpeed*2 do
		JY.ReFreshTime=lib.GetTime();
		lib.GetKey();
		ReFresh();
	end
end
function Talk(p,str)
	local name="";
	local headid=-1;
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
	TalkEx(name,headid,str);
end
function TalkEx(name,headid,str)
	talk_sub(name,headid,str);
	WaitKey();
	lib.Delay(50);
	DrawGame();
end
function WarDrawStrBoxYesNo(str)
	return TalkYesNo("",str);
end
function Msgbox(s)
	local x1=CC.ScreenW/2-84;	--������x
	local y1=CC.ScreenH-81;		--������y
	local x2=x1+50;
	local y2=y1+8;
	talk_sub("",-1,s);
	local sid=lib.SaveSur(0,0,CC.ScreenW,CC.ScreenH);
	local function redraw(flag)
		JY.ReFreshTime=lib.GetTime();
		lib.LoadSur(sid,0,0);
		lib.PicLoadCache(4,10*2,x1,y1,1);
		if flag==10 then
			lib.PicLoadCache(4,20*2,x2,y2,1);
		elseif flag==11 then
			lib.PicLoadCache(4,19*2,x2,y2,1);
		else
			lib.PicLoadCache(4,18*2,x2,y2,1);
		end
		ReFresh();
	end
	local current=0;
	while true do
		redraw(current);
		getkey();
		if MOUSE.CLICK(x2+1,y2+1,x2+66,y2+46) then
			current=0;
			PlayWavE(0);
			redraw(current);
			lib.Delay(100);
			lib.FreeSur(sid);
			return true;
		elseif MOUSE.HOLD(x2+1,y2+1,x2+66,y2+46) then
			current=10;
		elseif MOUSE.IN(x2+1,y2+1,x2+66,y2+46) then
			current=11;
		else
			current=0;
		end
	end
end
function TalkYesNo(p,str)
	local x1=CC.ScreenW/2-108;	--������x	276
	local y1=CC.ScreenH-81;		--������y	351
	local x2=x1+40;				--316
	local y2=y1+8;				--359
	local x3=x1+110;			--386
	local y3=y1+8;				--359
	local name="";
	local headid=-1;
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
	local current=0;
	local hold=false;
	local function redraw(flag)
		DrawGame();
		talk_sub(name,headid,str);
		lib.PicLoadCache(4,11*2,x1,y1,1);
		if current==1 then
			if hold then
				lib.PicLoadCache(4,14*2,x2,y2,1);
			else
				lib.PicLoadCache(4,13*2,x2,y2,1);
			end
		else
			lib.PicLoadCache(4,12*2,x2,y2,1);
		end
		if current==2 then
			if hold then
				lib.PicLoadCache(4,17*2,x3,y3,1);
			else
				lib.PicLoadCache(4,16*2,x3,y3,1);
			end
		else
			lib.PicLoadCache(4,15*2,x3,y3,1);
		end
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
		current=0;
		hold=false;
		if MOUSE.CLICK(x2+1,y2+1,x2+66,y2+46) then
			PlayWavE(0);
			redraw();
			lib.Delay(100);
      DrawGame();
			return true;
		elseif MOUSE.CLICK(x3+1,y3+1,x3+66,y3+46) then
			PlayWavE(1);
			redraw();
			lib.Delay(100);
      DrawGame();
			return false;
		elseif MOUSE.HOLD(x2+1,y2+1,x2+66,y2+46) then
			current=1;
			hold=true;
		elseif MOUSE.HOLD(x3+1,y3+1,x3+66,y3+46) then
			current=2;
			hold=true;
		elseif MOUSE.IN(x2+1,y2+1,x2+66,y2+46) then
			current=1;
		elseif MOUSE.IN(x3+1,y3+1,x3+66,y3+46) then
			current=2;
		end
	end
end
function DrawMulitStrBox(str)         --��ʾ���о���
	talk_sub("",-1,str)
	WaitKey();
	DrawGame();
end
function talk_sub(name,headid,str)
	local talkxnum=20;         --�Ի�һ������
	local talkynum=3;          --�Ի�����
	local strarray={}
	local num;
	--��ʾͷ��ͶԻ�������
	local w,h=lib.PicGetXY(4,0*2);
	w,h=640,140;
	local mx,my=(CC.ScreenW-w)/2,CC.ScreenH-h;
	local tx,ty=mx+132,my+32;
    if CONFIG.KeyRepeat==0 then
	     lib.EnableKeyRepeat(0,CONFIG.KeyRepeatInterval);
	end
	local size=24;
    local startp=1
    local endp;
    local dy=0;
	if #name==0 then
		tx=tx-size*1;
	end
	local sid=lib.SaveSur(0,0,CC.ScreenW,CC.ScreenH);
	local pagenum,pagearray=Split(str,'*');
	local function redraw(nstr)
		--DrawGame();
		lib.LoadSur(sid,0,0);
		--[[local sid=lib.SaveSur(0,0,CC.ScreenW,CC.ScreenH);
		lib.LoadSur(sid,0,0);
		lib.FreeSur(sid);]]--
		if headid>0 then
			lib.PicLoadCache(2,headid*2,180+mx,CC.ScreenH/2,0);
			--lib.PicLoadCache(4,0*2,mx,my,1);
		else
			--Glass(mx,my+20,mx+640,my+120,C_BLACK,192);
		end
		LoadPicEnhance(207,mx,my,w,h);
		--LoadPicEnhance(205,mx,my,640,120);
		--DrawStringEnhance(tx-size*(0.5+#name/2),ty,name,C_Name,size);
		DrawStringEnhance(tx-36, ty ,name,C_ORANGE,size,0.5);
		DrawStringEnhance(tx, ty ,nstr,M_White,size);
	end
	for page=1,pagenum do
		redraw(pagearray[page]);
		if page<pagenum then
			WaitKey();
		end
	end
    if CONFIG.KeyRepeat==0 then
	     lib.EnableKeyRepeat(CONFIG.KeyRepeatDelay,CONFIG.KeyRepeatInterval);
	end
	lib.FreeSur(sid);
end
function WarAvailable(wid)
	if War.Person[wid]==nil or (not War.Person[wid].live) or War.Person[wid].hide then
		return false;
	end
	return true;
end
function WarTalk(pid,str)
	local wid=GetWarID(pid);
	if not WarAvailable(wid) then
		return;
	end
	local oldcy=War.CY;
	local name=JY.Person[pid]["����"];
	local headid=JY.Person[pid]["��ò"]+2000;
	WarPersonCenter(wid);
	--��ʾͷ��ͶԻ�������
	local mx,my=139,240;
	if wid>0 then
		if War.CY>oldcy or War.Person[wid].y-War.CY>4 then
			my=War.BoxDepth*(War.Person[wid].y-War.CY)-108-2;
		else
			my=War.BoxDepth*(War.Person[wid].y-War.CY+1)+2;
		end
		mx=limitX(War.BoxWidth*(War.Person[wid].x-War.CX+0.5)-256,0,CC.ScreenW-512)
	end
	local tx,ty=mx+120,my+11;
	if type(str)=="number" then
		str=AsuraGenTalkString(str,pid,0);
	end
    if CONFIG.KeyRepeat==0 then
	     lib.EnableKeyRepeat(0,CONFIG.KeyRepeatInterval);
	end
	local size=20;
    local startp=1
	local function redraw()
		DrawGame();
		lib.PicLoadCache(4,202*2,mx,my,1);
		lib.PicLoadCache(2,headid*2,mx+30,my-24,1);
		DrawStringEnhance(tx,ty,name.."[w][n]"..str,C_Name,size,0,0,size*18);
	end
	MOUSE.CLICK();
	while true do
		local t1=lib.GetTime();
		redraw();
		ShowScreen();
		local delay=CC.FrameNum-lib.GetTime()+t1;
		if delay>0 then
			lib.Delay(delay);
		end
		getkey();
		if MOUSE.CLICK() then
			break;
		end
	end
    if CONFIG.KeyRepeat==0 then
	     lib.EnableKeyRepeat(CONFIG.KeyRepeatDelay,CONFIG.KeyRepeatInterval);
	end
	War.CurID=0;
	War.InMap=false;
end

function Person_Menu()
	local menu={
					{" �佫�鱨",nil,1},
					{" ��������",nil,1},
					{"   ����",nil,1},
				}
	DrawYJZBox(32,32,"�佫",C_WHITE,true)
	local r=ShowMenu(menu,3,0,546,264,0,0,3,1,16,C_WHITE,C_WHITE);
	if r==1 then
		PersonStatus_Menu(1);
	elseif r==2 then
		ExchangeItem(1);
	elseif r==3 then
		Maidan(1);
	end
end
function PersonStatus_Menu(fid)
	local menu={};
	local n=0;
	for i=1,JY.PersonNum-1 do
		if JY.Person[i]["����"]==fid then
			menu[i]={fillblank(JY.Person[i]["����"],11),PersonStatus,1};
			n=n+1;
		else
			menu[i]={"",nil,0};
		end
	end
	DrawYJZBox(32,32,"�佫�鱨",C_WHITE,true)
	if n<=8 then
		ShowMenu(menu,JY.PersonNum-1,8,546,224,0,0,5,1,16,C_WHITE,C_WHITE);
	else
		ShowMenu(menu,JY.PersonNum-1,8,530,224,0,0,6,1,16,C_WHITE,C_WHITE);
	end
end

----------------------------------------------------------------
--	Maidan(fid)
--	���䳡
----------------------------------------------------------------
function Maidan(fid)
	fid=fid or 1;
	local lvup_flag=false;
	local m_pid={};
	local m_eid={};
	local num_pid,num_eid=0,0;
	local lv_max=math.floor((JY.Person[1]["�ȼ�"]+JY.Person[2]["�ȼ�"]+JY.Person[3]["�ȼ�"]+JY.Person[54]["�ȼ�"]+JY.Person[126]["�ȼ�"])/6)-5;
	lv_max=limitX(lv_max,3,60);
	for i=1,JY.PersonNum-1 do
		if JY.Person[i]["�ؼ�1"]>0 then
			if JY.Person[i]["����"]==fid then
				if JY.Person[i]["�ȼ�"]<lv_max then
					num_pid=num_pid+1;
					m_pid[num_pid]=i;
				end
			else
				num_eid=num_eid+1;
				m_eid[num_eid]=i;
			end
		end
	end
	if num_pid>0 and num_eid>10 then
		Talk(369,"����˭Ҫ���䣿");
		local pid=FightSelectMenu(m_pid);
		if pid<=0 then
			Talk(369,"��ô���´���˵�ɣ�");
			return;
		end
		local eid=m_eid[math.random(num_eid)];
		Talk(369,"��ô����ʼ�ɣ�");
			local magic={};
			for mid=1,JY.MagicNum-1 do
				magic[mid]=false;
				if HaveMagic(pid,mid) then
					magic[mid]=true;
				end
			end
		local s={0,1,2,4,6};
		if fight(pid,eid,s[math.random(5)])==1 then
			Talk(369,"�澫�ʣ�");
			PlayWavE(11);
			LvUp(pid);
			JY.Person[pid]["����"]=0;
			DrawStrBoxCenter(JY.Person[pid]["����"].."�ĵȼ������ˣ�");
			lvup_flag=true;
		else
			Talk(369,"̫��ϧ�ˣ�");
			DrawStrBoxCenter(JY.Person[pid]["����"].."�õ��������飮");
			JY.Person[pid]["����"]=JY.Person[pid]["����"]+24;
			if JY.Person[pid]["����"]>=100 then
				PlayWavE(11);
				LvUp(pid);
				JY.Person[pid]["����"]=0;
				DrawStrBoxCenter(JY.Person[pid]["����"].."�ĵȼ������ˣ�");
				lvup_flag=true;
			end
		end
		if lvup_flag then
			--��ʾ���ܲ���ϰ��
			for i=1,6 do
				if JY.Person[pid]["�ȼ�"]==CC.SkillExp[JY.Person[pid]["�ɳ�"]][i] then
					PlayWavE(11);
					DrawStrBoxCenter(JY.Person[pid]["����"].."ϰ�ü���"..JY.Skill[JY.Person[pid]["����"..i]]["����"].."��");
					break;
				end
			end
			local str="";
			for mid=1,JY.MagicNum-1 do
				if not magic[mid] then
					if HaveMagic(pid,mid) then
						if str=="" then
							str=JY.Magic[mid]["����"];
						else
							str=str.."��"..JY.Magic[mid]["����"];
						end
					end
				end
			end
			if #str>0 then
				PlayWavE(11);
				DrawStrBoxCenter(JY.Person[pid]["����"].."ϰ�ò���"..str.."��");
			end
		end
	else
		Talk(369,"û������Ҫ�����ˣ�");
	end
end

function Shop()
	local sid=JY.Base["������"];
	if sid<=0 then
		PlayWavE(2);
		WarDrawStrBoxConfirm("�˵�û�е����ݣ�",C_WHITE,true);
		return
	end
	local shopitem=	{
					[1]={41,28,31},			--��ˮ��֮սǰ,����
					[2]={28,31,44},			--���ι�֮ս��,��ƽ
					[3]={28,31,53,41,38,35},--�Ŷ���֮ս��,�Ŷ�
					[4]={28,31,53},			--�㴨֮ս��,�㴨
					--����֮սǰ,��ƽ/�Ŷ�
					[5]={28,31,53,41,38,35,34},		--����֮ս��,��ƽ/�Ŷ�/����,����ֻ���˱�����
					[6]={28,31,53,50,47},			--����I֮ս��,��ƽ/�Ŷ�/����/����/����������ֻ�е����ݵ�
					--������ 31,32,50,47,34
					[7]={20,22,24,26,41,38,35},			--С��
					[8]={20,22,24,26,28,29,31,53},			--���I
					[9]={31,32,50,47,34},			--����
					[10]={20,22,24,26,29,31,32,53},			--��
					[11]={41,38,39,35,44},			--����
					[12]={41,42,38,39,35,36},			--����
					[13]={20,22,24,26,29,32,53,34},				--����I
					[14]={42,39,36,44,45},				--����I
					--[15]={29,32,54,50,51,47},				--����I
					[15]={21,23,25,27,29,32,54,50,51,47},				--����I,���ǵ���Ϸʵ��,��Ҫ�ڽ���,����������II,������II�Ĳ��ֵ���Ҳ�ӽ���
					[16]={42,39,36,44,45,20,22,24},				--����II
					[17]={50,51,47,48,38,39},				--��ɳ
					[18]={21,23,25,27,29,42,39,36,34},				--����II
					[19]={21,23,25,27,29,30,32,54},				--�ɶ�I
					[20]={29,32,54,42,20,22,24,34},				--��
					[21]={21,23,25,27,29,30,32,33},				--�ɶ�II
					[22]={42,39,36,29,32,54,48,51},				--����
					[23]={42,39,40,36,37,48,51,52},				--����II
					[24]={21,23,25,27,43,30,33,55},				--����III
					[25]={30,33,55,43,40,37,45,46},				--��
					[26]={30,33,55,49,20,22,24,26},			--���II
--[[
�������ܹ�����ߣ�
�����������飬�ƣ�����
��ƽ���ƣ�����Ũ���顣
�Ŷ����ƣ�������ҩ�������飬�����飬��ʯ�顣
�㴨���ƣ�������ҩ��
�������ƣ�������ҩ�������飬�����飬��ʯ�飬ը����
���ݣ��ƣ�������ҩ��ƽ���飬Ԯ���顣
������������ƽ���飬Ԯ���飬ը����
С�棺��ǹ�������������������񣬽����飬�����飬��ʯ�顣
���I����ǹ�������������������񣬾ƣ��ؼ��ƣ�������ҩ��
���II���Ͼƣ��ף��裬Ԯ���飬��ǹ��������������������	����ʮ�˹أ����II֮ս��
������ǹ���������������������ؼ��ƣ���������ҩ��
���������飬�����飬�����飬��ʯ�飬Ũ���顣
���ϣ������飬�����飬�����飬�����飬��ʯ�飬ɽ���顣
����I����ǹ���������������������ؼ��ƣ�����ҩ��ը����
����II������������ʯ���������������徫�񣬻����飬�����飬ɽ���飬ը����	�ڶ�ʮ���أ�����֮ս��
����III������������ʯ���������������徫���ͻ��飬�Ͼƣ��ף��衣	����ʮ���أ�����II֮ս��
����I�������飬�����飬ɽ���飬Ũ���飬�������顣
����II�������飬�����飬ɽ���飬Ũ���飬�������飬��ǹ������������	�ڶ�ʮ��أ�������֮ս��
����I���ؼ��ƣ�����ҩ��ƽ���飬�����飬Ԯ���顣
����II�������飬�����飬��Х�飬ɽ���飬ɽ���飬Ԯ���飬�����飬�����顣	����ʮ�Źأ���֮ս��
��ɳ��ƽ���飬�����飬Ԯ���飬Ԯ���飬�����飬�����顣
�����ؼ��ƣ�����ҩ�������飬��ǹ������������ը����
�ɶ�I������������ʯ���������������徫���ؼ��ƣ��Ͼƣ�����ҩ��
�ɶ�II������������ʯ���������������徫���ؼ��ƣ��Ͼƣ����ס�		����ʮ�Źأ���֮ս��
���꣺�����飬�����飬ɽ���飬�ؼ��ƣ�����ҩ��Ԯ���飬�����顣
���Ͼƣ��ף��裬�ͻ��飬��Х�飬ɽ���飬�������飬�����顣
]]--
					}
	local shopitem2={	--������
					[1]={74,80,89,140,147},			--��ˮ��֮սǰ,����
					[2]={74,75,80,89,99,140,141,147},			--���ι�֮ս��,��ƽ
					[3]={80,81,85,89,95,117,120,141,148},--�Ŷ���֮ս��,�Ŷ�
					[4]={75,90,141,148},			--�㴨֮ս��,�㴨
					--����֮սǰ,��ƽ/�Ŷ�
					[5]={80,81,85,89,95,117,120,141,148},		--����֮ս��,��ƽ/�Ŷ�/����,����ֻ�����Ŷ���
					[6]={90,96,120,125,126,131,142,148},			--����I֮ս��,��ƽ/�Ŷ�/����/����/����������ֻ�е����ݵ�
					--������ 31,32,50,47,34
					[7]={81,85,100,117,135,142,152},			--С��
					[8]={86,90,101,104,105,117,135,142,152,148},			--���I
					[9]={86,90,101,105,142,152,148},			--����,��ʵû�У����༸��
					[10]={76,82,91,102,106,118,136,131,130},			--��
					[11]={140,141,142,147,148},			--����,��ʵû�У����༸��
					[12]={76,82,91,102,106,142},			--����,��ʵû�У����༸��
					[13]={91,97,127,131,141,143,152,149,150},				--����I
					[14]={76,82,86,106,109,110,118,121,123},				--����I
					[15]={103,107,111,114,132,133,142,144,153},				--����I
					[16]={76,82,86,106,109,110,118,121,123},				--����II
					[17]={76,82,86,103,107,110},				--��ɳ,��ʵû�У����༸��
					[18]={77,90,92,96,97,128},				--����II
					[19]={78,83,87,111,115,128,145,153,150},				--�ɶ�I
					[20]={92,97,102,106,139},				--��,��ʵû�У����༸��
					[21]={78,83,87,111,115,128,145,153,150},				--�ɶ�II
					[22]={78,83,87,92,97,102,106,111,115,139},				--����,��ʵû�У����༸��
					[23]={93,97,103,108,112,137,119,122,129},				--����II
					[24]={84,88,98,116,124,138,134,146,151},				--����III
					[25]={84,88,98,103,108},				--��
					[26]={79,94,113,139,132,154},			--���II
					}
	local shopid=1;	--1���� 2����
	local buysellmenu={
						{"  ����� ",nil,1},
						{"  ������ ",nil,1},
						{"    ��   ",nil,1},
					};
	local itemmenu={};
	local itemnum=0;
	local personmenu={};
	local personnum=0;
	for i=1,JY.PersonNum-1 do
		if JY.Person[i]["����"]==1 then
			personmenu[i]={fillblank(JY.Person[i]["����"],11),nil,1};
			personnum=personnum+1;
		else
			personmenu[i]={"",nil,0};
		end
	end
	PlayWavE(0);
	
	local status="SelectBuySell";
	local iid,pid;
	local function showbuysellmenu()
		talk_sub(375,"��ʲô���飿");
		local r=ShowMenu(buysellmenu,3,0,0,156,0,0,3,1,16,C_WHITE,C_WHITE);
		if r==1 then
			status="SelectItem";
			shopid=1;
			itemmenu={};
			itemnum=0;
			for i,v in pairs(shopitem[sid]) do
				itemnum=itemnum+1;
				itemmenu[itemnum]={fillblank(JY.Item[v]["����"],11),nil,1};
			end
		elseif r==2 then
			status="SelectItem";
			shopid=2;
			itemmenu={};
			itemnum=0;
			for i,v in pairs(shopitem2[sid]) do
				itemnum=itemnum+1;
				itemmenu[itemnum]={fillblank(JY.Item[v]["����"],11),nil,1};
			end
		elseif r==3 then
			status="SelectPersonSell";
		else
			status="Exit";
			PlayWavE(1);
		end
	end
	local function showitemmenu()
		talk_sub(375,"��ʲô��");
		local r=ShowMenu(itemmenu,itemnum,0,0,156,0,0,3,1,16,C_WHITE,C_WHITE);
		if r>0 then
			if shopid==1 then
				iid=shopitem[sid][r];
			elseif shopid==2 then
				iid=shopitem2[sid][r];
			else
				iid=1;
			end
			--showitem
			local x=145;
			local y=CC.ScreenH/2;
			local size=16;
			lib.PicLoadCache(4,50*2,x,y,1);
			DrawStringEnhance(x+16,y+16,JY.Item[iid]["����"],C_Name,size);
			DrawStr(x+16,y+36,GenTalkString(JY.Item[iid]["˵��"],18),C_WHITE,size);
			
			if TalkYesNo(375,JY.Item[iid]["����"].."�ƽ�"..JY.Item[iid]["��ֵ"].."0��*������") then
				--����ƽ𲻹�
				if JY.Item[iid]["��ֵ"]*10>JY.Base["�ƽ�"] then
					DrawSMap();
					PlayWavE(2);
					Talk(375,"�����ƽ𲻹��ˣ�");
					status="SelectItem";
				else
					status="SelectPerson";
				end
			end
		else
			status="SelectBuySell";
			PlayWavE(1);
		end
	end
	local function showpersonnum()
		talk_sub(375,JY.Item[iid]["����"].."��λҪ��");
		local r;
		if personnum<=10 then
			r=ShowMenu(personmenu,JY.PersonNum-1,10,0,156,0,0,5,1,16,C_WHITE,C_WHITE);
		else
			r=ShowMenu(personmenu,JY.PersonNum-1,8,0,156,0,0,6,1,16,C_WHITE,C_WHITE);
		end
		if r>0 then
			pid=r;
			if JY.Person[pid]["����8"]>0 then
				PlayWavE(2);
				if TalkYesNo(375,"��λ������*�������ˣ����˰ɣ�") then
					status="SelectPerson";
				else
					status="SelectItem";
				end
			else
				PersonStatus_sub(pid,108,156);
				if TalkYesNo(375,"���Խ���"..JY.Person[pid]["����"].."��") then
					GetMoney(-10*JY.Item[iid]["��ֵ"]);
					for i=1,8 do
						if JY.Person[pid]["����"..i]==0 then
							JY.Person[pid]["����"..i]=iid;
							break;
						end
					end
					DrawSMap();
					DrawYJZBox(32,32,"��������",C_WHITE,true);
					if TalkYesNo(375,"��л�ˣ���Ҫ�����������") then
						status="SelectItem";
					else
						status="SelectBuySell";
					end
				else
					status="SelectPerson";
				end
			end
		else
			status="SelectItem"
			PlayWavE(1);
		end
	end
	local function showpersonnumsell()
		talk_sub(375,"������λ�Ķ�����");
		local r;
		if personnum<=10 then
			r=ShowMenu(personmenu,JY.PersonNum-1,10,0,156,0,0,5,1,16,C_WHITE,C_WHITE);
		else
			r=ShowMenu(personmenu,JY.PersonNum-1,8,0,156,0,0,6,1,16,C_WHITE,C_WHITE);
		end
		if r>0 then
			pid=r;
			status="SelectItemSell";
		else
			status="SelectBuySell";
			PlayWavE(1);
		end
	end
	local function showitemmenusell()
		if JY.Person[pid]["����1"]==0 then
			PlayWavE(2);
			Talk(375,"��û��ʲô����������");
			status="SelectPersonSell";
		else
			local sellmenu={};
			for i=1,8 do
				iid=JY.Person[pid]["����"..i];
				if iid>0 then
					sellmenu[i]={fillblank(JY.Item[iid]["����"],11),nil,1};
				else
					sellmenu[i]={"",nil,0};
				end
			end
			talk_sub(375,"��ʲô��");
			local rr=ShowMenu(sellmenu,8,0,0,156,0,0,3,1,16,C_WHITE,C_WHITE);
			if rr>0 then
				iid=JY.Person[pid]["����"..rr];
				if TalkYesNo(375,"��"..(10*math.floor(JY.Item[iid]["��ֵ"]*0.75)).."�ƽ��չ�"..JY.Item[iid]["����"].."��������") then
					for i=rr,7 do
						JY.Person[pid]["����"..i]=JY.Person[pid]["����"..(i+1)]
					end
					JY.Person[pid]["����8"]=0;
					GetMoney(10*math.floor(JY.Item[iid]["��ֵ"]*0.75));
					DrawSMap();
					DrawYJZBox(32,32,"��������",C_WHITE,true);
					if TalkYesNo(375,"��л�ˣ���Ҫ����������ʲô��") then
						status="SelectPersonSell";--?
						status="SelectItemSell";--?
					else
						status="SelectBuySell";
					end
				else
					status="SelectItemSell";
				end
			else
				status="SelectPersonSell";
				PlayWavE(1);
			end
		end
	end
	Talk(375,"�������ˣ�");
	while true do
		JY.Tid=375;
		DrawSMap();
		DrawYJZBox(32,32,"��������",C_WHITE,true);
		if status=="SelectBuySell" then
			showbuysellmenu();
		elseif status=="SelectItem" then
			showitemmenu();
		elseif status=="SelectPerson" then
			showpersonnum();
		elseif status=="SelectPersonSell" then
			showpersonnumsell();
		elseif status=="SelectItemSell" then
			showitemmenusell();
		else
			Talk(375,"��ӭ������");
			break;
		end
	end
	
end
function WarIni()
	War={};
	SetWarConst();
end
function SetWarConst()
	War.tBrush={[0]="��",[1]="��·",[2]="ƽ��",[3]="�ĵ�",[4]="�ݵ�",[5]="ɭ��",[6]="ʪ��",[7]="ɽ",[8]="��ɽ",[9]="����",[10]="ǳ̲",[11]="��",[12]="��",[13]="��",[14]="��"}
	War.Frame=0;
	War.FrameT=0;
	War.x_off=0;
	War.y_off=0;
	War.mx=-1;
	War.my=-1;
	War.WavTimer=0;
	War.MAP={};	--�����������꣬���εȣ��������Ҫ����
	War.Asmap={};	--A*ʹ�õ�map����
	War.ArmyA1={};
	War.ArmyA2={};
	War.ArmyA3={};
	War.ArmyB1={};
	War.ArmyB2={};
	War.ArmyB3={};
	War.Person={};
	War.PersonNum=0;
  War.Building = {};
end
--������ս����ʵ���ǰѵо�ɾ��
function WarIni2()
	for i=War.PersonNum,1,-1 do
		if War.Person[i].enemy then
			table.remove(War.Person,i);
			War.PersonNum=War.PersonNum-1
		end
	end
end
function WarCleanEvent()
	--���ս���¼�
	for i=1,200 do
		JY.Base["ս���¼�"..i]=0;
	end
end

function SelectTeam(...)
	local arg={};
	for i,v in pairs({...}) do
		arg[i]=v;
	end
	local num=math.floor(#arg/4);
	local t_team=SelectArmy(num);
	for i=0,math.min(num,#t_team)-1 do
		InsertWarPerson(0,t_team[i+1],arg[4*i+1],arg[4*i+2],arg[4*i+3],0,"��",arg[4*i+4],"����",-1,-1)
	end
end
function GeyBaselineLv()
	return JY.Person[JY.PID]["�ȼ�"];
end
function Follower(pid,fid,n)
	--Pri.1
	
	--Pri.2
	if JY.Person[pid]["Ʒ��"]>=4 and n<1 then
		return GenClassC(pid,fid);
	end
	--Pri.3
	
	--others
	return fid;
end
function InsertWarTeam(team_id,plist,x0,y0,d,force,hide,order,kind,ai,ai_x,ai_y)
	--new x y,   x ������ y������
	--b 0 ��ս 1Զ��
	local n=#plist;
	if n==0 then
		return;
	end
	local pid;
	if order=="��" then
		pid=plist[n];
		table.remove(plist,n);
	else
		pid=plist[1];
		table.remove(plist,1);
	end
	if force=="��" then
		local jtnum=WarGetFlag(11)+1;
		WarSetFlag(11,jtnum);	--�о���������
		WarSetFlag(110+jtnum,pid);	--�з����ų�ID
	end
	local team={};
	local tmp_t={};
	local npcnum=JY.Person[pid]["Ʒ��"];
	local lv=1;
	local npclv=0;
	if JY.Person[pid]["Ʒ��"]<4 then
		npclv=npclv-1;
	end
	if order=="˧" then
		npcnum=npcnum+2;
		lv,npclv=lv+2,npclv+2;
	end
	if kind==1 then			--��������
		if npcnum>6 then
			npcnum=6;
		end
		if npcnum==1 then
			tmp_t={{x=1,y=0,b=0},				{x=-1,y=0,b=0},		}
			table.insert(team,TableRandom(tmp_t));
		elseif npcnum==2 then
			if RND(0.5) then
				tmp_t={	{x=-1,y=1,b=0},				{x=1,y=1,b=0},
						{x=-1,y=0,b=1},				{x=1,y=0,b=1},		}
				table.insert(team,{x=0,y=1,b=0});
				table.insert(team,TableRandom(tmp_t));
			else
				table.insert(team,{x=-1,y=0,b=0});
				table.insert(team,{x=1, y=0,b=0});
			end
		elseif npcnum==3 then
			tmp_t={	{x=-1,y=1,b=0},				{x=1,y=1,b=0},
					{x=-1,y=0,b=1},				{x=1,y=0,b=1},		}
			table.insert(team,{x=0,y=1,b=0});
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
		elseif npcnum==4 then
			if RND(0.5) then
				tmp_t={	{x=-2,y=0,b=1},				{x=2,y=0,b=1},
						{x=-1,y=1,b=0},				{x=1,y=1,b=0},		}
				table.insert(team,{x=0,y=1,b=0});
				table.insert(team,{x=-1,y=0,b=1});
				table.insert(team,{x=1,y=0,b=1});
				table.insert(team,TableRandom(tmp_t));
			else
				tmp_t={	{x=-1,y=0,b=1},				{x=1,y=0,b=1},
						{x=-2,y=1,b=0},				{x=2,y=1,b=0},		}
				table.insert(team,{x=0,y=1,b=0});
				table.insert(team,{x=-1,y=1,b=0});
				table.insert(team,{x=1,y=1,b=0});
				table.insert(team,TableRandom(tmp_t));
			end
		elseif npcnum==5 then
			if RND(0.5) then
				tmp_t={	{x=-2,y=0,b=1},				{x=2,y=0,b=1},
						{x=-1,y=1,b=0},				{x=1,y=1,b=0},		}
				table.insert(team,{x=0,y=1,b=0});
				table.insert(team,{x=-1,y=0,b=1});
				table.insert(team,{x=1,y=0,b=1});
				table.insert(team,TableRandom(tmp_t));
				table.insert(team,TableRandom(tmp_t));
			else
				tmp_t={	{x=-1,y=0,b=1},				{x=1,y=0,b=1},
						{x=-2,y=1,b=0},				{x=2,y=1,b=0},		}
				table.insert(team,{x=0,y=1,b=0});
				table.insert(team,{x=-1,y=1,b=0});
				table.insert(team,{x=1,y=1,b=0});
				table.insert(team,TableRandom(tmp_t));
				table.insert(team,TableRandom(tmp_t));
			end
		elseif npcnum==6 then
			if RND(0.5) then
				tmp_t={	{x=-2,y=0,b=1},				{x=2,y=0,b=1},
						{x=-1,y=1,b=0},				{x=1,y=1,b=0},		}
				table.insert(team,{x=0,y=1,b=0});
				table.insert(team,{x=-1,y=0,b=1});
				table.insert(team,{x=1,y=0,b=1});
				table.insert(team,TableRandom(tmp_t));
				table.insert(team,TableRandom(tmp_t));
				table.insert(team,TableRandom(tmp_t));
			else
				tmp_t={	{x=-1,y=0,b=1},				{x=1,y=0,b=1},
						{x=-2,y=1,b=0},				{x=2,y=1,b=0},		}
				table.insert(team,{x=0,y=1,b=0});
				table.insert(team,{x=-1,y=1,b=0});
				table.insert(team,{x=1,y=1,b=0});
				table.insert(team,TableRandom(tmp_t));
				table.insert(team,TableRandom(tmp_t));
				table.insert(team,TableRandom(tmp_t));
			end
		end
	elseif kind==2 then		--����Զ��
		if npcnum>6 then
			npcnum=6;
		end
		if npcnum==1 then
			tmp_t={{x=1,y=0,b=1},				{x=-1,y=0,b=1},		}
			table.insert(team,TableRandom(tmp_t));
		elseif npcnum==2 then
			tmp_t={	{x=-1,y=1,b=2},				{x=1,y=1,b=2},
					{x=-1,y=0,b=1},				{x=1,y=0,b=1},		}
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
		elseif npcnum==3 then
			tmp_t={	{x=-1,y=1,b=2},				{x=1,y=1,b=2},		{x=-0,y=1,b=2},	
					{x=-1,y=0,b=1},				{x=1,y=0,b=1},		}
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
		elseif npcnum==4 then
			tmp_t={	{x=-1,y=1,b=2},				{x=1,y=1,b=2},		{x=-0,y=1,b=2},	
					{x=-1,y=0,b=1},				{x=1,y=0,b=1},		
					{x=-2,y=0,b=1},				{x=2,y=0,b=1},		}
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
		elseif npcnum==5 then
			tmp_t={	{x=-1,y=1,b=2},				{x=1,y=1,b=2},		{x=-0,y=1,b=2},	
					{x=-1,y=0,b=1},				{x=1,y=0,b=1},		
					{x=-2,y=0,b=1},				{x=2,y=0,b=1},		}
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
		elseif npcnum==6 then
			tmp_t={	{x=-1,y=1,b=2},				{x=1,y=1,b=2},		{x=-0,y=1,b=2},	
					{x=-1,y=0,b=1},				{x=1,y=0,b=1},		
					{x=-2,y=0,b=1},				{x=2,y=0,b=1},		}
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
		end
	elseif kind==3 then		--ˮս�ܼ�
		if npcnum>6 then
			npcnum=6;
		end
		if npcnum==1 then
			tmp_t={	{x=-1,y=0,b=3},				{x=1,y=0,b=3},		}
			table.insert(team,TableRandom(tmp_t));
		elseif npcnum==2 then
			tmp_t={	{x=-1,y=0,b=4},				{x=1,y=0,b=4},
												{x=0,y=1,b=3},		}
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
		elseif npcnum==3 then
			tmp_t={	{x=-1,y=0,b=4},				{x=1,y=0,b=4},
					{x=-1,y=1,b=3},				{x=1,y=1,b=3},	
												{x=0,y=1,b=3},		}
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
		elseif npcnum==4 then
			tmp_t={	{x=-1,y=0,b=4},				{x=1,y=0,b=4},
					{x=-1,y=1,b=3},				{x=1,y=1,b=3},	
					{x=0,y=-1,b=3},				{x=0,y=1,b=3},		}
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
		elseif npcnum==5 then
			tmp_t={	{x=-1,y=0,b=4},				{x=1,y=0,b=4},
					{x=-1,y=1,b=3},				{x=1,y=1,b=3},	
					{x=-1,y=-1,b=4},			{x=1,y=-1,b=4},	
					{x=0,y=-1,b=4},				{x=0,y=1,b=3},		}
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
		elseif npcnum==6 then
			tmp_t={	{x=-1,y=0,b=4},				{x=1,y=0,b=4},
					{x=-1,y=1,b=3},				{x=1,y=1,b=3},	
					{x=-1,y=-1,b=4},			{x=1,y=-1,b=4},	
					{x=0,y=-1,b=4},				{x=0,y=1,b=3},		}
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
		end
	elseif kind==4 then		--ɽ���ܼ�
		if npcnum>6 then
			npcnum=6;
		end
		if npcnum==1 then
			tmp_t={	{x=-1,y=0,b=5},				{x=1,y=0,b=5},		}
			table.insert(team,TableRandom(tmp_t));
		elseif npcnum==2 then
			tmp_t={	{x=-1,y=0,b=6},				{x=1,y=0,b=6},
												{x=0,y=1,b=5},		}
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
		elseif npcnum==3 then
			tmp_t={	{x=-1,y=0,b=6},				{x=1,y=0,b=6},
					{x=-1,y=1,b=5},				{x=1,y=1,b=5},	
												{x=0,y=1,b=5},		}
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
		elseif npcnum==4 then
			tmp_t={	{x=-1,y=0,b=6},				{x=1,y=0,b=6},
					{x=-1,y=1,b=5},				{x=1,y=1,b=5},	
					{x=0,y=-1,b=5},				{x=0,y=1,b=5},		}
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
		elseif npcnum==5 then
			tmp_t={	{x=-1,y=0,b=6},				{x=1,y=0,b=6},
					{x=-1,y=1,b=5},				{x=1,y=1,b=5},	
					{x=-1,y=-1,b=6},			{x=1,y=-1,b=6},	
					{x=0,y=-1,b=6},				{x=0,y=1,b=5},		}
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
		elseif npcnum==6 then
			tmp_t={	{x=-1,y=0,b=6},				{x=1,y=0,b=6},
					{x=-1,y=1,b=5},				{x=1,y=1,b=5},	
					{x=-1,y=-1,b=6},			{x=1,y=-1,b=6},	
					{x=0,y=-1,b=6},				{x=0,y=1,b=5},		}
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
		end
	elseif kind==5 then		--����ܼ�
		if npcnum>6 then
			npcnum=6;
		end
		if npcnum==1 then
			tmp_t={	{x=-1,y=0,b=7},				{x=1,y=0,b=7},		}
			table.insert(team,TableRandom(tmp_t));
		elseif npcnum==2 then
			tmp_t={	{x=-1,y=0,b=8},				{x=1,y=0,b=8},
												{x=0,y=1,b=7},		}
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
		elseif npcnum==3 then
			tmp_t={	{x=-1,y=0,b=8},				{x=1,y=0,b=8},
					{x=-1,y=1,b=7},				{x=1,y=1,b=7},	
												{x=0,y=1,b=7},		}
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
		elseif npcnum==4 then
			tmp_t={	{x=-1,y=0,b=8},				{x=1,y=0,b=8},
					{x=-1,y=1,b=7},				{x=1,y=1,b=7},	
					{x=0,y=-1,b=7},				{x=0,y=1,b=7},		}
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
		elseif npcnum==5 then
			tmp_t={	{x=-1,y=0,b=8},				{x=1,y=0,b=8},
					{x=-1,y=1,b=7},				{x=1,y=1,b=7},	
					{x=-1,y=-1,b=8},			{x=1,y=-1,b=8},	
					{x=0,y=-1,b=8},				{x=0,y=1,b=7},		}
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
		elseif npcnum==6 then
			tmp_t={	{x=-1,y=0,b=8},				{x=1,y=0,b=8},
					{x=-1,y=1,b=7},				{x=1,y=1,b=7},	
					{x=-1,y=-1,b=8},			{x=1,y=-1,b=8},	
					{x=0,y=-1,b=8},				{x=0,y=1,b=7},		}
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
			table.insert(team,TableRandom(tmp_t));
		end
	end
	x0,y0=WarGetExistXY(x0,y0);
	InsertWarPerson(team_id,pid,x0,y0,d,lv,force,hide,ai,ai_x,ai_y);
	if CheckSkill(pid,4) then	--����
		npclv=npclv+1;
	end
	local fg=0;
	if npcnum>=4 then
		fg=math.random(1,npcnum);
	end
	for i,v in ipairs(team) do
		local nid;
		if v.b==0 then
			nid=GenPerson(RND(0.8),pid,"������","�����");
		elseif v.b==1 then
			nid=GenPerson(RND(0.9),pid,"������","�����");
		elseif v.b==2 then
			nid=GenPerson(true,pid,"������");
		elseif v.b==3 then
			nid=GenPerson(RND(0.5),pid,"������","������");
		elseif v.b==4 then
			nid=GenPerson(RND(0.5),pid,"������","������");
		elseif v.b==5 then
			nid=GenPerson(RND(0.5),pid,"����","������");
		elseif v.b==6 then
			nid=GenPerson(RND(0.5),pid,"����","������");
		elseif v.b==7 then
			nid=GenPerson(RND(0.5),pid,"�����","������");
		elseif v.b==8 then
			nid=GenPerson(RND(0.5),pid,"�����","������");
		end
		if i==fg then
			nid=GenClassC(pid,nid);
		end
		if JY.Person[pid]["ͳ��"]>0 then
			nid=BodyGuard(pid,nid);
		end
		local nx,ny;
		if d=="��" then
			nx,ny=x0+v.x,y0-v.y;
		elseif d=="��" then
			nx,ny=x0+v.x,y0+v.y;
		elseif d=="��" then
			nx,ny=x0-v.y,y0+v.x;
		elseif d=="��" then
			nx,ny=x0+v.y,y0+v.x;
		end
		nx,ny=WarGetExistXY(nx,ny,x0,y0);
		InsertWarPerson_sub(team_id,nid,nx,ny,d,npclv+math.random(0,1)-math.random(0,1),force,hide,ai,ai_x,ai_y);
	end
end
function InsertWarPerson(team_id,pid,x,y,d,lv,force,hide,ai,ai_x,ai_y)
	local nx,ny=WarGetExistXY(x,y);
	InsertWarPerson_sub(team_id,pid,nx,ny,d,lv,force,hide,ai,ai_x,ai_y);
end
function InsertWarPerson_sub(team_id,pid,x,y,d,lv,force,hide,ai,ai_x,ai_y)
	local direction=0;
	if d=="��" then
		direction=2;
	elseif d=="��" then
		direction=1;
	elseif d=="��" then
		direction=3;
	elseif d=="��" then
		direction=4;
	end
	if force~="��" then
		JY.Person[pid]["�ȼ�"]=limitX(GeyBaselineLv()+JY.Person[pid]["Ʒ��"]+lv,1,60);
		JY.Person[pid]["����"]=CC.Exp[JY.Person[pid]["�ȼ�"]];
		--for i=4,1,-1 do
		--	if JY.Person[pid]["�ȼ�"]>=20*(i-1) and JY.Person[pid]["����"..i]>0 then
		--		JY.Person[pid]["����"]=JY.Person[pid]["����"..i];
		--		break;
		--	end
		--end
	end
	JY.Person[pid]["��ս"]=1;
	War.PersonNum=War.PersonNum+1;
	table.insert(War.Person,	{
									id=pid,				--����ID
									tid=team_id,		--����ID
									x=x,					--����X
									y=y,					--����Y
									--pic=JY.Person[T[idx+1]]["ս������"],	--����ID
									action=1,				--���� 0��ֹ��1��·...
									effect=0,				--������ʾ
									hurt=-1,				--��ʾ�˺���ֵ
									bz=JY.Person[pid]["����"],
									movewav=JY.Bingzhong[JY.Person[pid]["����"]]["��Ч"],	--�ƶ���Ч
									atkwav=JY.Bingzhong[JY.Person[pid]["����"]]["������Ч"],	--������Ч
									movestep=JY.Bingzhong[JY.Person[pid]["����"]]["�ƶ�"],	--�ƶ���Χ
									movespeed=JY.Bingzhong[JY.Person[pid]["����"]]["�ƶ��ٶ�"],	--�ƶ��ٶ�
									atkfw=JY.Bingzhong[JY.Person[pid]["����"]]["������Χ"],	--������Χ
									sq=0,
									atk_buff=0,
									int_buff=0,
									def_buff=0,
									dex_buff=0,
									shi_buff=0,
									frame=-1,				--��ʾ֡��
									d=direction,					--����
									active=true,			--�ɷ��ж�
									enemy=false,			--�о��Ҿ�
									friend=false,			--�Ѿ���
									ai=0,					--AI����
									live=true,				--���
									hide=hide,				--����
									was_hide=hide,				--����
									troubled=false,			--����
									leader=false,
								})
	WarModifyAI(War.PersonNum,ai,ai_x,ai_y);
	if force=="��" then
		War.Person[War.PersonNum].enemy=true;
		if War.Leader2==pid then
			War.Person[War.PersonNum].leader=true;
		end
	elseif force=="��" then
		War.Person[War.PersonNum].friend=true;
	else
		if War.Leader1==pid then
			War.Person[War.PersonNum].leader=true;
		end
	end
	if not hide then
		SetWarMap(x,y,2,War.PersonNum);
	end
	ReSetAttrib(pid,true);
	War.Person[War.PersonNum].pic=WarGetPic(War.PersonNum);
	return War.PersonNum;
end
function DefineWarMap(id,warname,wartarget,maxturn,leader1,leader2)
	War.MapID=id;
	War.WarName=warname;
	War.WarTarget=wartarget;
	War.MaxTurn=maxturn;
	War.Leader1=-1;
	War.Leader2=-1;
	if JY.NameList[leader1]~=nil then
		War.Leader1=JY.NameList[leader1]
	end
	if JY.NameList[leader2]~=nil then
		War.Leader2=JY.NameList[leader2]
	end
	LoadWarMap(War.MapID);
end
function WarStart()
	CC.Person_S["��ò"]=CC.Person_S["ս����ò"];
	for i,v in ipairs(JY.Person) do
		v["��ս"]=0;
	end
	SRPG();
	CC.Person_S["��ò"]=CC.Person_S["������ò"];
end
----------------------------------------------------------------
--	WarSave()
--	����ս��
----------------------------------------------------------------
function WarSave(id)
	
	--War basic informaction
	Byte.set8(JY.Data_Base,128,War.MapID);
	Byte.set8(JY.Data_Base,129,War.Width);
	Byte.set8(JY.Data_Base,130,War.Depth);
	Byte.set8(JY.Data_Base,131,War.CX);
	Byte.set8(JY.Data_Base,132,War.CY);
	Byte.set16(JY.Data_Base,133,War.PersonNum);
	Byte.set8(JY.Data_Base,135,War.Weather);
	Byte.set8(JY.Data_Base,136,War.Turn);
	Byte.set8(JY.Data_Base,137,War.MaxTurn);
	Byte.set16(JY.Data_Base,138,War.Leader1);
	Byte.set16(JY.Data_Base,140,War.Leader2);
	Byte.set8(JY.Data_Base,142,War.EnemyNum);
	JY.Base["ս������"]=War.WarName;
	JY.Base["ս��Ŀ��"]=War.WarTarget;
	--[[
	if CC.SrcCharSet==1 then
		Byte.setstr(JY.Data_Base,150,50,lib.CharSet(War.WarName,1));
		Byte.setstr(JY.Data_Base,200,100,lib.CharSet(War.WarTarget,1));
	else
		Byte.setstr(JY.Data_Base,150,50,War.WarName);
		Byte.setstr(JY.Data_Base,200,100,War.WarTarget);
	end
	]]--
	--War.Person
	local offset=6200;
	for i=1,War.PersonNum do
		Byte.set16(JY.Data_Base,offset,War.Person[i].id);
		Byte.set8(JY.Data_Base,offset+2,War.Person[i].x);
		Byte.set8(JY.Data_Base,offset+3,War.Person[i].y);
		Byte.set8(JY.Data_Base,offset+4,War.Person[i].d);
		Byte.set8(JY.Data_Base,offset+5,War.Person[i].ai);
		Byte.set16(JY.Data_Base,offset+6,War.Person[i].aitarget);
		Byte.set8(JY.Data_Base,offset+8,War.Person[i].ai_dx);
		Byte.set8(JY.Data_Base,offset+9,War.Person[i].ai_dy);
		Byte.set8(JY.Data_Base,offset+10,War.Person[i].sq);
		local v=0;
		if War.Person[i].enemy then
			v=v+1;
		end
		if War.Person[i].friend then
			v=v+2;
		end
		if War.Person[i].active then
			v=v+4;
		end
		if War.Person[i].live then
			v=v+8;
		end
		if War.Person[i].hide then
			v=v+16;
		end
		if War.Person[i].was_hide then
			v=v+32;
		end
		if War.Person[i].troubled then
			v=v+64;
		end
		Byte.set8(JY.Data_Base,offset+11,v);
		offset=offset+12;
	end
	--Map
	offset=10000;
	for i=0,War.Width*War.Depth-1 do
		local v=War.Map[i]+32*War.Map[War.Width*War.Depth*(9-1)+i];
		Byte.set8(JY.Data_Base,offset+i,v);
	end
	--Save
	SaveRecord(id);
end
----------------------------------------------------------------
--	WarLoad()
--	��ȡս��
----------------------------------------------------------------
function WarLoad(id)
	--Load
	--LoadRecord(id);
	WarIni();
	--War basic informaction
	War.MapID=Byte.get8(JY.Data_Base,128);
	War.Width=Byte.get8(JY.Data_Base,129);
	War.Depth=Byte.get8(JY.Data_Base,130);
	War.CX=Byte.get8(JY.Data_Base,131);
	War.CY=Byte.get8(JY.Data_Base,132);
	War.PersonNum=Byte.get16(JY.Data_Base,133);
	War.Weather=Byte.get8(JY.Data_Base,135);
	War.Turn=Byte.get8(JY.Data_Base,136);
	War.MaxTurn=Byte.get8(JY.Data_Base,137);
	War.Leader1=Byte.get16(JY.Data_Base,138);
	War.Leader2=Byte.get16(JY.Data_Base,140);
	War.EnemyNum=Byte.get8(JY.Data_Base,142);
	War.WarName=JY.Base["ս������"];
	War.WarTarget=JY.Base["ս��Ŀ��"];
	--[[
	if CC.SrcCharSet==1 then
		War.WarName=lib.CharSet(Byte.getstr(JY.Data_Base,150,50),0);
		War.WarTarget=lib.CharSet(Byte.getstr(JY.Data_Base,200,100),0);
	else
		War.WarName=Byte.getstr(JY.Data_Base,150,50);
		War.WarTarget=Byte.getstr(JY.Data_Base,200,100);
	end
	]]--
	--Map
	War.MiniMapCX=888-War.Width*2;
	War.MiniMapCY=460+24-War.Depth*2;
	War.Map={};
	CleanWarMap(1,0);	--����
	CleanWarMap(2,0);	--wid
	CleanWarMap(3,0);	--
	CleanWarMap(4,1);	--ѡ��Χ
	CleanWarMap(5,-1);	--������ֵ
	CleanWarMap(6,-1);	--���Լ�ֵ
	CleanWarMap(7,0);	--ѡ��Ĳ���
	CleanWarMap(8,0);	--AIǿ���ã��Ҿ��Ĺ�����Χ
	CleanWarMap(9,0);	--ˮ�����
	CleanWarMap(10,0);	--������Χ����ʾ��
	local offset=10000;
	for i=0,War.Width*War.Depth-1 do
		local v=Byte.get8(JY.Data_Base,offset+i);
		local v1=v%32;
		local v2=math.floor(v/32);
		War.Map[i]=v1;
		War.Map[War.Width*War.Depth*(9-1)+i]=v2;
	end
	
	--War.Person
	offset=6200;
	for i=1,War.PersonNum do
		War.Person[i]={};
		War.Person[i].id=Byte.get16(JY.Data_Base,offset);
		War.Person[i].x=Byte.get8(JY.Data_Base,offset+2);
		War.Person[i].y=Byte.get8(JY.Data_Base,offset+3);
		War.Person[i].d=Byte.get8(JY.Data_Base,offset+4);
		War.Person[i].ai=Byte.get8(JY.Data_Base,offset+5);
		War.Person[i].aitarget=Byte.get16(JY.Data_Base,offset+6);
		War.Person[i].ai_dx=Byte.get8(JY.Data_Base,offset+8);
		War.Person[i].ai_dy=Byte.get8(JY.Data_Base,offset+9);
		War.Person[i].sq=Byte.get8(JY.Data_Base,offset+10);
		local v=Byte.get8(JY.Data_Base,offset+11);
		if v%2==1 then
			War.Person[i].enemy=true;
		else
			War.Person[i].enemy=false;
		end
		if (math.floor(v/2))%2==1 then
			War.Person[i].friend=true;
		else
			War.Person[i].friend=false;
		end
		if (math.floor(v/4))%2==1 then
			War.Person[i].active=true;
		else
			War.Person[i].active=false;
		end
		if (math.floor(v/8))%2==1 then
			War.Person[i].live=true;
		else
			War.Person[i].live=false;
		end
		if (math.floor(v/16))%2==1 then
			War.Person[i].hide=true;
		else
			War.Person[i].hide=false;
		end
		if (math.floor(v/32))%2==1 then
			War.Person[i].was_hide=true;
		else
			War.Person[i].was_hide=false;
		end
		if (math.floor(v/64))%2==1 then
			War.Person[i].troubled=true;
		else
			War.Person[i].troubled=false;
		end
		local pid=War.Person[i].id;
		War.Person[i].action=1;				--���� 0��ֹ��1��·...
		War.Person[i].effect=0;				--������ʾ
		War.Person[i].hurt=-1;				--��ʾ�˺���ֵ
		War.Person[i].bz=JY.Person[pid]["����"];
		War.Person[i].movewav=JY.Bingzhong[JY.Person[pid]["����"]]["��Ч"];	--�ƶ���Ч
		War.Person[i].atkwav=JY.Bingzhong[JY.Person[pid]["����"]]["������Ч"];	--������Ч
		War.Person[i].movestep=JY.Bingzhong[JY.Person[pid]["����"]]["�ƶ�"];	--�ƶ���Χ
		War.Person[i].movespeed=JY.Bingzhong[JY.Person[pid]["����"]]["�ƶ��ٶ�"];	--�ƶ��ٶ�
		War.Person[i].atkfw=JY.Bingzhong[JY.Person[pid]["����"]]["������Χ"];	--������Χ
		War.Person[i].atk_buff=0;
		War.Person[i].int_buff=0;
		War.Person[i].def_buff=0;
		War.Person[i].dex_buff=0;
		War.Person[i].shi_buff=0;
		War.Person[i].frame=-1;				--��ʾ֡��
		if pid==War.Leader1 or pid==War.Leader2 then
			War.Person[i].leader=true;
		else
			War.Person[i].leader=false;
		end
		if War.Person[i].live and (not War.Person[i].hide) then
			SetWarMap(War.Person[i].x,War.Person[i].y,2,i);
		end
		ReSetAttrib(pid,false);
		War.Person[i].pic=WarGetPic(i);
		WarResetStatus(i);
		offset=offset+12;
	end
end
----------------------------------------------------------------
--	RemindSave()
--	��ʾ�Ƿ񱣴�
--	flag, Ĭ��Ϊ1	1սǰ��ʾ 2ս����ʾ
----------------------------------------------------------------
function RemindSave(flag)
	flag=flag or 1;
	if flag==1 then
		DrawSMap();
	elseif flag==2 then
		JY.Status=GAME_START;	--������Ϊ�˷����Զ���������
	end
	if WarDrawStrBoxYesNo("���ڴ�����",C_WHITE,true) then
			local menu2={
						{" 1. ",nil,1},
						{" 2. ",nil,1},
						{" 3. ",nil,1},
						{" 4. ",nil,1},
						{" 5. ",nil,1},
					}
			for id=1,5 do
				if not fileexist(CC.R_GRPFilename[id]) then
					menu2[id][1]=menu2[id][1].."δʹ�õ���";
				else
					menu2[id][1]=menu2[id][1]..GetRecordInfo(id);
				end
			end
			DrawYJZBox(-1,100,"���������������",C_WHITE);
			local s2=ShowMenu(menu2,5,0,0,0,0,0,20,1,16,C_WHITE,C_WHITE);
			if between(s2,1,5) then
				if WarDrawStrBoxYesNo(string.format("������Ӳ���ĵ�%d�ţ�������",s2),C_WHITE,true) then
					if flag==2 then
						JY.Status=GAME_SMAP_AUTO;	--��ǰ���Ӧ���Ļ���
					end
					SaveRecord(s2);
				end
			end
	end
	if flag==1 then
		DrawSMap();
	elseif flag==2 then
		JY.Status=GAME_SMAP_AUTO;	--��ǰ���Ӧ���Ļ���
	end
end

----------------------------------------------------------------
--	WarTeamAI(tid)
--	ָ�����鿪ʼ�ж�
--	tid team id
----------------------------------------------------------------
function WarTeamAI(tid)
	if JY.Status~=GAME_WMAP then
		return;
	end
	for i,v in ipairs(War.Person) do
		if v.tid==tid and v.live and (not v.hide) and (not v.troubled) and v.active then
			AI_Sub(i);
		end
	end
end
----------------------------------------------------------------
--	LvUp(pid,n)
--	�ȼ�����
--	pid ����id, n Ĭ��Ϊ1
----------------------------------------------------------------
function LvUp(pid,n)
	n=n or 1;
	if pid>=0 then
		JY.Person[pid]["�ȼ�"]=limitX(JY.Person[pid]["�ȼ�"]+n,1,60);
	end
end
----------------------------------------------------------------
--	WarCheckLocation(pid,x,y)
--	���Ե���ս������
--	pid ����id, -1ʱΪ�����ҷ��佫
----------------------------------------------------------------
function WarCheckLocation(name,x,y)
	if War.SelID==0 then
		return false;
	end
	--pid=-1���������ҷ��ҽ�
	if JY.NameList[name]~=nil then
		pid=JY.NameList[name];
	else
		pid=-1;
	end
	local v=War.Person[War.SelID];
	if v.live and (not v.hide) and ((pid==-1 and (not v.enemy) and (not v.friend)) or pid==v.id) and x==v.x and y==v.y then
		return true;
	end
	return false;
end
----------------------------------------------------------------
--	WarLocationItem(x,y,item,event)
--	���Ե���ս������õ���Ʒ
--	x,y ����, item ��Ʒid, event ����¼�id
----------------------------------------------------------------
function WarLocationItem(x,y,event,item,num)
	if War.SelID==0 then
		return false;
	end
	if (not WarGetFlag(event)) then
		local v=War.Person[War.SelID];
		--for i,v in pairs(War.Person) do
			if v.live and (not v.hide) and (not v.enemy) and (not v.friend) and x==v.x and y==v.y then
				WarGetItem(War.SelID,item,num);
				WarSetFlag(event,1);
				--break;
			end
		--end
	end
end
----------------------------------------------------------------
--	WarCheckArea(wid,x1,y1,x2,y2)
--	���Ե���ս������
--	wid war_id, -1ʱΪ�����ҷ��佫
----------------------------------------------------------------
function WarCheckArea(wid,x1,y1,x2,y2)
	if War.SelID==0 then
		return false;
	end
	--wid=-1���������ҷ��ҽ�
	local v=War.Person[War.SelID];
	--for i,v in pairs(War.Person) do
	if v.live and (not v.hide) and ((wid==-1 and (not v.enemy)) or wid==War.SelID) and between(v.x,x1,x2) and between(v.y,y1,y2) then
		return true;
	end
	--end
	return false;
end
function GetWarID(pid)
	if type(War)=="table" then
		for i,v in pairs(War.Person) do
			if pid==v.id then
				return i;
			end
		end
	end
	return 0;
end
function WarMeet(name1,name2)
	if War.SelID==0 then
		return false;
	end
	local id1,id2=0,0;
	local pid1,pid2;
	if JY.NameList[name1]~=nil then
		pid1=JY.NameList[name1];
	else
		pid1=-1;
	end
	if JY.NameList[name2]~=nil then
		pid2=JY.NameList[name2];
	else
		lib.Debug("WarMeet: "..name2.." not exist");
		return false;
	end
	if pid1==-1 then	--���޶��ص�����
		if War.Person[War.SelID].enemy then	--���벻Ϊ�о�
			return false;
		else
			id1=War.SelID;
			pid1=War.Person[War.SelID].id;
		end
	elseif War.Person[War.SelID].id==pid1 then	--ָ������ ����Ϊ��ǰ�ж�����
		id1=War.SelID;
	else
		return false;
	end
	id2=GetWarID(pid2);
	if id1>0 and id2>0 and
		War.Person[id1].live and War.Person[id2].live and 
		(not War.Person[id1].hide) and (not War.Person[id2].hide) and 
		JY.Person[pid1]["����"]>0 and JY.Person[pid2]["����"]>0 then
		if math.abs(War.Person[id1].x-War.Person[id2].x)+math.abs(War.Person[id1].y-War.Person[id2].y)==1 then
			return true;
		end
	end
	return false;
end
----------------------------------------------------------------
--	WarMoveTo(pid,x,y)
--	�����ƶ���ָ������
--	pid ����id
----------------------------------------------------------------
function WarMoveTo(name,x,y)
	local pid=-1;
	if JY.NameList[name]~=nil then
		pid=JY.NameList[name];
	else
		lib.Debug("WarMoveTo: "..name.." not exist");
		return false;
	end
	local wid=GetWarID(pid);
	if wid>0 then
		War.SelID=wid;
		War_CalMoveStep(wid,256,true);
		x,y=WarGetExistXY(x,y,wid);
		War_MovePerson(x,y);
		CleanWarMap(4,1);
		War.LastID=War.SelID;
		War.SelID=0;
	end
end
----------------------------------------------------------------
--	WarShowArmy(name)
--	��������
--	wid ����ս��id
----------------------------------------------------------------
function WarShowTeamArmy(tid)
	for i,v in ipairs(War.Person) do
		if v.tid==tid and v.live and v.hide then
			WarShowArmy(i);
		end
	end
end
function WarShowArmy(wid)
	if not between(wid,1,War.PersonNum) then
		lib.Debug("WarModifyAI wid="..wid.." not exist.")
		return;
	end
	if (not War.Person[wid].hide) or (not War.Person[wid].live) then
		return;
	end
	local x,y=War.Person[wid].x,War.Person[wid].y;
	if WarCanExistXY(x,y,wid) then
		War.Person[wid].hide=false;
		WarPersonCenter(wid);
		SetWarMap(x,y,2,wid);
		PlayWavE(15);
		WarDelay(4);
		return;
	end
	local DX={0,0,-1,1};
	local DY={1,-1,0,0}
	local dx={1,-1,1,-1,};
	local dy={-1,1,1,-1}
	for n=1,8 do
		for d=1,4 do
			for i=1,n do
				local nx=x+DX[d]*n+dx[d]*i;
				local ny=y+DY[d]*n+dy[d]*i;
				if between(nx,1,War.Width) and between(ny,1,War.Depth) then
					if WarCanExistXY(nx,ny,wid) then
						War.Person[wid].x=nx;
						War.Person[wid].y=ny;
						War.Person[wid].hide=false;
						WarPersonCenter(wid);
						SetWarMap(nx,ny,2,wid);
						PlayWavE(15);
						WarDelay(4);
						return;
					end
				end
			end
		end
	end
end
----------------------------------------------------------------
--	WarGetExistXY(x,y)
--	Ѱ������Ŀ��Գ��ֵĵص�
--	x,yĿ��ص�
----------------------------------------------------------------
function WarGetExistXY(x,y,sx,sy)
	local DX={0,0,-1,1};
	local DY={1,-1,0,0}
	local dx={1,-1,1,-1,};
	local dy={-1,1,1,-1}
	if WarCanExistXY(x,y) then
		return x,y;
	end
	if sy==nil then
		sx,sy=x,y;
	else
		if WarCanExistXY(sx,sy) then
			return sx,sy;
		end
	end
	for n=1,12 do
		for d=1,4 do
			for i=1,n do
				local nx=sx+DX[d]*n+dx[d]*i;
				local ny=sy+DY[d]*n+dy[d]*i;
				if between(nx,1,War.Width) and between(ny,1,War.Depth) then
					if WarCanExistXY(nx,ny) then
						return nx,ny;
					end
				end
			end
		end
	end
	return x,y;
end
function WarCheckTurn(turn,kind,event)
	kind=kind or "��";
	if (not WarGetFlag(event)) then
		if turn==War.Turn then
			if (kind=="��" and JY.EventType==3) or (kind=="��" and JY.EventType==4) or (kind=="��" and JY.EventType==5) then
				WarSetFlag(event,1);
				return true;
			end
		end
	end
	return false;
end
----------------------------------------------------------------
--	GetMoney(money)
--	��ûƽ�
--	money �ƽ�����,Ϊ����ʱʧȥ�ƽ�����ʾ
----------------------------------------------------------------
function GetMoney(money)
	JY.Base["�ƽ�"]=limitX(JY.Base["�ƽ�"]+money,0,50000);
end
----------------------------------------------------------------
--	GetItem(pid,item)
--	��õ���
--	pid ����id
----------------------------------------------------------------
function GetItem(item,num)
	PlayWavE(11);
	if item==0 then
		DrawStrBoxWaitKey(string.format("����ʽ� X %d",num),C_WHITE);
		GetMoney(num);
	elseif item>0 then
		DrawStrBoxWaitKey(string.format("���%s X %d",JY.Item[item]["����"],num),C_WHITE);
		if between(JY.Item[item]["����"],1,10) then
			JY.Base["��Ʒ����"..item]=limitX(JY.Base["��Ʒ����"..item]+num,0,99);
		else
			JY.Base["��Ʒ����"..item]=limitX(num,0,1);
		end
	end
	return true;
end
----------------------------------------------------------------
--	WarGetItem(wid,item)
--	��õ���
--	wid ����wid
----------------------------------------------------------------
function WarGetItem(name,item,num)
	local wid=0;
	if type(name)=="number" then
		wid=name;
	elseif type(name)=="string" then
		if JY.NameList[name]~=nil then
			wid=JY.NameList[name];
		else
			lib.Debug("WarGetItem: "..name.." not exist");
		end
	end
	if wid>0 then
		War.Person[wid].action=6;
	end
	WarDelay(4);
	GetItem(item,num);
	if wid>0 then
		WarResetStatus(wid);
	end
	WarDelay(4);
	return true
end
----------------------------------------------------------------
--	WarGetExp(Exp)
--	�д沿�ӵõ�50�㾭��ֵ��
--	Exp ����ֵ,����
----------------------------------------------------------------
function WarGetExp(Exp)
	Exp=50;
	PlayWavE(0);
	lib.GetKey();
	local x,y;
    local w=288;
	local h=80;
	x=16+768/2-w/2;
	y=32+528/2-h/2;
	local x1=x+205;
	local y1=y+36;
	local x2=x1+52;
	local y2=y1+24
	local function redraw(flag)
		JY.ReFreshTime=lib.GetTime();
		DrawWarMap();
		lib.PicLoadCache(4,84*2,x,y,1);
		if flag==2 then
			lib.PicLoadCache(4,56*2,x1,y1,1);
		else
			lib.PicLoadCache(4,55*2,x1,y1,1);
		end
		ReFresh();
	end
	local current=0;
	while true do
		redraw(current);
		getkey();
		if MOUSE.HOLD(x1+1,y1+1,x2-1,y2-1) then
			current=2;
		elseif MOUSE.CLICK(x1+1,y1+1,x2-1,y2-1) then
			current=0;
			PlayWavE(0);
			redraw(current);
			WarDelay(4);
			break;
		else
			current=0;
		end
	end
	for i,v in pairs(War.Person) do
		if v.live and (not v.hide) then
			if (not v.enemy) and (not v.friend) then
				local pid=v.id;
				JY.Person[pid]["����"]=JY.Person[pid]["����"]+Exp;
				if JY.Person[pid]["����"]>=100 then
					JY.Person[pid]["����"]=JY.Person[pid]["����"]-100;
					WarLvUp(i);
				end
			end
		end
	end
end
----------------------------------------------------------------
--	WarGetTrouble(wid)
--	�ж��Ƿ�������״̬
--	wid war_id
--4.�������Ƿ���������
--���ǣ�ƺ󣬷�������ʿ���½���30���£��������㷨�ж��Ƿ��������ҡ�
--�����һ��0��4֮������������������С��3�������������������ҡ�
--��˵������������60���Ŀ�����������ҡ�
----------------------------------------------------------------
function WarGetTrouble(wid)
	local pid=War.Person[wid].id;
	if JY.Person[pid]["ʿ��"]<30 and JY.Person[pid]["����"]>0 then
		if math.random(5)-1<3 then
			if War.Person[wid].troubled then
				WarDrawStrBoxDelay(JY.Person[pid]["����"].."���ӻ����ˣ�",C_WHITE);
			else
				War.Person[wid].troubled=true
				War.Person[wid].action=7;
				WarDelay(2);
				WarDrawStrBoxDelay(JY.Person[pid]["����"].."�����ˣ�",C_WHITE);
			end
		end
	end
end
----------------------------------------------------------------
--	WarTroubleShooting(wid)
--	���ѻ����еĲ���
--	wid war_id
--	�ָ����ӣ�0��99�������������ָ�����С�ڣ�ͳ������ʿ������3����ô���ӱ����ѣ��ɴ˿�����ͳ��Խ�ߣ�ʿ��Խ�ߣ�Խ���״ӻ��������ѣ�
----------------------------------------------------------------
function WarTroubleShooting(wid)
	local pid=War.Person[wid].id;
	if War.Person[wid].troubled then
		local flag=false;
		if math.random(100)-1<(JY.Person[pid]["ͳ��"]+JY.Person[pid]["ʿ��"])/3 then
			flag=true;
		end
		if CC.Enhancement then
			if WarCheckSkill(wid,20) then	--����
				flag=true;
			end
		end
		if flag then
			WarPersonCenter(wid);
			War.Person[wid].troubled=false;
			WarDrawStrBoxDelay(JY.Person[pid]["����"].."�ӻ����лָ���",C_WHITE);
		end
	end
end
----------------------------------------------------------------
--	WarEnemyWeak(id,kind)
--	����ʿ������
--	id	1�Ҿ� 2�о�
--	kind 1���� 2ʿ��
----------------------------------------------------------------
function WarEnemyWeak(id,kind)
	for i,v in pairs(War.Person) do
		if v.live and (not v.hide) then
			if (id==1 and (not v.enemy)) or (id==2 and v.enemy) then
				local pid=v.id;
				if kind==1 then
					JY.Person[pid]["����"]=limitX(JY.Person[pid]["����"]/2,1,JY.Person[pid]["������"]);
				elseif kind==2 then
					JY.Person[pid]["ʿ��"]=limitX(JY.Person[pid]["ʿ��"]/2,1,v.sq);
					ReSetAttrib(pid,false);
					WarGetTrouble(i);
				end
			end
		end
	end
end
----------------------------------------------------------------
--	WarFireWater(x,y,kind)
--	ˮ�����
--	x,y����,����Ϊdos�����꣬ʵ����Ҫ+1����
--	kind 1�Ż� 2��ˮ 3ȡ����ˮ
----------------------------------------------------------------
function WarFireWater(x,y,kind)
	if kind==3 then
		SetWarMap(x,y,9,0)
	else
		if GetWarMap(x,y,2)==0 then
			SetWarMap(x,y,9,kind);
		end
		if kind==1 then
			--PlayWavE(51);
		elseif kind==2 then
			--PlayWavE(53);
		end
	end
	War.CX=limitX(x-math.floor(War.MW/2),0,War.Width-War.MW);
	War.CY=limitX(y-math.floor(War.MD/2),0,War.Depth-War.MD);
	WarDelay(CC.WarDelay);
end

----------------------------------------------------------------
--	WarCheckSkill(wid,skillid)
--	����Ƿ����ĳ���
----------------------------------------------------------------
function WarCheckSkill(wid,skillid)
	local pid=War.Person[wid].id;
	for i=1,6 do
		if JY.Person[pid]["����"..i]==skillid then
			if JY.Person[pid]["�ȼ�"]>=CC.SkillExp[JY.Person[pid]["�ɳ�"]][i] then
				return true;
			end
		end
	end
	return false;
end
function CheckSkill(pid,skillid)
	if pid<=0 then
		return false;
	end
	for i=1,6 do
		if JY.Person[pid]["����"..i]==skillid then
			if JY.Person[pid]["�ȼ�"]>=CC.SkillExp[JY.Person[pid]["�ɳ�"]][i] then
				return true;
			end
		end
	end
	return false;
end
function JoinUs(name,flag)
	flag=flag or "����";
	local pid=-1;
	if type(name)=="number" then
		pid=name;
	elseif type(name)=="string" then
		if JY.NameList[name]~=nil then
			pid=JY.NameList[name];
		else
			lib.Debug("JoinUs: "..name.." not exist");
			return false;
		end
	end
	if flag=="����" then
		JY.Person[pid]["����"]=1;
		--JY.Base["�佫����"]=JY.Base["�佫����"]+1;
		JY.Person[pid]["�ȼ�"]=limitX(JY.Person[pid]["�ȼ�"],1,99);
		if type(War.Person)=="table" then--ս��ʱ���������Ϊ����������Ҫ�����޸�ս����������
			for i,v in pairs(War.Person) do
				if v.id==pid then
					v.enemy=false;
					v.friend=false;
					v.pic=WarGetPic(i);
					break;
				end
			end
		end
	elseif flag=="�뿪" then
		JY.Person[pid]["����"]=0;
		--JY.Base["�佫����"]=JY.Base["�佫����"]-1;
	end
end
function SetEqp(name,tid)
	local pid=-1;
	if type(name)=="number" then
		pid=name;
	elseif type(name)=="string" then
		if JY.NameList[name]~=nil then
			pid=JY.NameList[name];
		else
			lib.Debug("SetEqp: "..name.." not exist");
			return false;
		end
	end
	if between(JY.Item[tid]["����"],11,20) then
		JY.Person[pid]["����"]=tid;
	elseif between(JY.Item[tid]["����"],21,30) then
		JY.Person[pid]["����"]=tid;
	elseif between(JY.Item[tid]["����"],31,40) then
		JY.Person[pid]["����"]=tid;
	end
	ReSetAttrib(pid,false);
end
function RemoveEqp(name,kind)
	local pid=-1;
	kind=kind or "ȫ��";
	if type(name)=="number" then
		pid=name;
	elseif type(name)=="string" then
		if JY.NameList[name]~=nil then
			pid=JY.NameList[name];
		else
			lib.Debug("RemoveEqp: "..name.." not exist");
			return false;
		end
	end
	if kind=="ȫ��" then
		JY.Person[pid]["����"]=0;
		JY.Person[pid]["����"]=0;
		JY.Person[pid]["����"]=0;
	elseif kind=="����" then
		JY.Person[pid]["����"]=0;
	elseif kind=="����" then
		JY.Person[pid]["����"]=0;
	elseif kind=="����" then
		JY.Person[pid]["����"]=0;
	end
	ReSetAttrib(pid,false);
end
function Selection(...)
	local menu={};
	for i,v in pairs({...}) do
		menu[i]={v,nil,1,true};
	end
	return ShowNewMenu(menu,0,0,0)
end
function ShowNewMenu(menuItem,x,y,isEsc)     --ͨ�ò˵�����
	
	local newMenu={};
	local newNumItem=0;
	for i,v in pairs(menuItem) do
		if menuItem[i][3]>0 then
			newNumItem=newNumItem+1;
            newMenu[newNumItem]={menuItem[i][1],menuItem[i][2],menuItem[i][3],menuItem[i][4],i};   --���������[5],�����ԭ����Ķ�Ӧ
		end
	end
	local self={};
	self.w=288;
	self.h=80;	-- +40*newNumItem
	self.position=0;
	for i,v in pairs(newMenu) do
		if v[3]==1 then	--����
			self.position=0;
			self.h=self.h+40;
		elseif v[3]==2 then	--��
			if self.position==1 then
				self.position=0;
			else
				self.position=1;
				self.h=self.h+40;
			end
		end
		v.enable=v[4];
	end
	if isEsc>0 then
		newNumItem=newNumItem+1;
        newMenu[newNumItem]={"[b]����",nil,1,true,0};
		self.h=self.h+24;
	end
	if x==0 then
		self.x=math.floor((CC.ScreenW-self.w)/2);
	else
		self.x=x;
	end
	if y==0 then
		self.y=math.floor((CC.ScreenH-self.h)/2);
	else
		self.y=y;
	end
	self.position=0;
	self.dy=self.y+3;
	for i,v in pairs(newMenu) do
		v.x1=self.x+42;
		self.dy=self.dy+40;
		if v[3]==1 then
			v.x2=v.x1+208;
			v.tx=v.x1+104;
			v.pic=38;
			self.position=0;
		elseif v[3]==2 then
			v.x1=v.x1+110*self.position;
			v.x2=v.x1+98;
			v.tx=v.x1+49;
			v.pic=30;
			if self.position==1 then
				self.position=0;
				self.dy=self.dy-40;
			else
				self.position=1;
			end
		end
		v.y1=self.dy;
		v.y2=v.y1+32;
	end
	if isEsc>0 then
		newMenu[newNumItem].x1=newMenu[newNumItem].x1+55;
		newMenu[newNumItem].x2=newMenu[newNumItem].x2-55;
		newMenu[newNumItem].tx=newMenu[newNumItem].x1+49;
		newMenu[newNumItem].pic=30;
		newMenu[newNumItem].enable=true;
	end
	local current=0;
	local hold=false;
	
	
	DrawGame();
	if JY.Talk.headid>0 then
		talk_sub(JY.Talk.name,JY.Talk.headid,JY.Talk.str);
	end
	local size=24;
	local sid=lib.SaveSur(0,0,CC.ScreenW,CC.ScreenH);
	local function redraw()
		lib.LoadSur(sid,0,0);
		lib.SetClip(self.x,self.y,self.x+self.w,self.y+self.h/2);
		lib.PicLoadCache(4,3*2,self.x,self.y,1);
		lib.SetClip(self.x,self.y+self.h/2,self.x+self.w,self.y+self.h);
		lib.PicLoadCache(4,3*2,self.x,self.y+self.h-300,1);
		lib.SetClip(0,0,0,0);
		for i,v in pairs(newMenu) do
			if not v.enable then
				lib.PicLoadCache(4,(v.pic+3)*2,v.x1,v.y1,1);
			elseif current==i then
				if hold then
					lib.PicLoadCache(4,(v.pic+2)*2,v.x1,v.y1,1);
				else
					lib.PicLoadCache(4,(v.pic+1)*2,v.x1,v.y1,1);
				end
			else
				lib.PicLoadCache(4,v.pic*2,v.x1,v.y1,1);
			end
		end
		for i,v in pairs(newMenu) do
			if v[2]==nil then
				if current==i then
					if hold then
						DrawStringEnhance(v.tx+1,v.y1+5+1,v[1],C_BLACK,size,0.5);
					else
						DrawStringEnhance(v.tx,v.y1+5,v[1],C_BLACK,size,0.5);
					end
				else
					DrawStringEnhance(v.tx,v.y1+5,v[1],C_BLACK,size,0.5);
				end
			else
				if current==i then
					if hold then
						DrawStringEnhance(v.x2-10-12*#v[2]/2+1,v.y1+17+1,v[2],C_BLACK,12);
						DrawStringEnhance(v.x1+8+1,v.y1+3+1,v[1],C_BLACK,16);
					else
						DrawStringEnhance(v.x2-10-12*#v[2]/2,v.y1+17,v[2],C_BLACK,12);
						DrawStringEnhance(v.x1+8,v.y1+3,v[1],C_BLACK,16);
					end
				else
					DrawStringEnhance(v.x2-10-12*#v[2]/2,v.y1+17,v[2],C_BLACK,12);
					DrawStringEnhance(v.x1+8,v.y1+3,v[1],C_BLACK,16);
				end
			end
		end
		if isEsc>0 then
			lib.PicLoadCache(4,44*2,newMenu[newNumItem].tx-96,newMenu[newNumItem].y1-6,1);
		end
	end
	while true do
		local t1=lib.GetTime();
		redraw();
		ShowScreen();
		local delay=CC.FrameNum-lib.GetTime()+t1;
		if delay>0 then
			lib.Delay(delay);
		end
		--DoEvent
		getkey();
		current=0;
		hold=false;
		if true then
			for i,v in pairs(newMenu) do
				if v.enable then
					if MOUSE.CLICK(v.x1,v.y1+1,v.x2,v.y2) then
						if v[5]==0 then
							PlayWavE(1);
						else
							PlayWavE(0);
						end
						lib.FreeSur(sid);
						return v[5];
					elseif MOUSE.HOLD(v.x1,v.y1+1,v.x2,v.y2) then
						current=i;
						hold=true;
					elseif MOUSE.IN(v.x1,v.y1+1,v.x2,v.y2) then
						current=i;
					end
				else
					if MOUSE.CLICK(v.x1,v.y1+1,v.x2,v.y2) then
						PlayWavE(2);
					end
				end
			end
			if isEsc then
				if MOUSE.ESC() then
					PlayWavE(1);
					lib.FreeSur(sid);
					return 0;
				end
			end
		end
	end
	lib.FreeSur(sid);
end
function ShowNewMenuBig(menuItem,x,y,isEsc)     --ͨ�ò˵�����
	local size=24;
	local RowPixel=8;
	local newMenu={};
	local newNumItem=0;
	for i,v in pairs(menuItem) do
		if menuItem[i][3]>0 then
			newNumItem=newNumItem+1;
            newMenu[newNumItem]={menuItem[i][1],menuItem[i][2],menuItem[i][3],menuItem[i][4],i};   --���������[5],�����ԭ����Ķ�Ӧ
		end
	end
	if isEsc>0 then
		newNumItem=newNumItem+1;
        newMenu[newNumItem]={"����",nil,1,true,0};
	end
	local self={};
	self.w=288;
	self.h=80;	-- +40*newNumItem
	self.position=0;
	for i,v in pairs(newMenu) do
		if v[3]==1 then	--����
			self.position=0;
			self.h=self.h+size+RowPixel*2;
		elseif v[3]==2 then	--��
			if self.position==1 then
				self.position=0;
			else
				self.position=1;
				self.h=self.h+size+RowPixel*2;
			end
		end
		v.enable=v[4];
	end
	if x==0 then
		self.x=math.floor((CC.ScreenW-self.w)/2);
	else
		self.x=x;
	end
	if y==0 then
		self.y=math.floor((CC.ScreenH-self.h)/2);
	else
		self.y=y;
	end
	self.position=0;
	self.dy=self.y+3;
	for i,v in pairs(newMenu) do
		v.x1=self.x+42;
		self.dy=self.dy+size+RowPixel*2;
		if v[3]==1 then
			v.x2=v.x1+208;
			v.tx=v.x1+104;
			v.pic=38;
			self.position=0;
		elseif v[3]==2 then
			v.x1=v.x1+110*self.position;
			v.x2=v.x1+98;
			v.tx=v.x1+49;
			v.pic=30;
			if self.position==1 then
				self.position=0;
				self.dy=self.dy-40;
			else
				self.position=1;
			end
		end
		v.y1=self.dy;
		v.y2=v.y1+size+RowPixel;
		v.ty=v.y1+(size+RowPixel)/2
	end
	local current=0;
	local hold=false;
	
	
	DrawGame();
	if JY.Talk.headid>0 then
		talk_sub(JY.Talk.name,JY.Talk.headid,JY.Talk.str);
	end
	local sid=lib.SaveSur(0,0,CC.ScreenW,CC.ScreenH);
	local function redraw()
		lib.LoadSur(sid,0,0);
		if true then
			Glass(self.x,self.y,self.x+self.w,self.y+self.h,C_BLACK,192);
			for i,v in pairs(newMenu) do
				if not v.enable then
					Glass(v.x1,v.y1,v.x2,v.y2,M_Gray,192);
				elseif current==i then
					if hold then
						Glass(v.x1-RowPixel+2,v.y1-RowPixel/2+2,v.x2+RowPixel-2,v.y2+RowPixel/2-2,M_Orange,64)
					else
						Glass(v.x1-RowPixel,v.y1-RowPixel/2,v.x2+RowPixel,v.y2+RowPixel/2,M_Orange,92)
					end
				else
					Glass(v.x1,v.y1,v.x2,v.y2,C_BLACK,192)
				end
			end
		else
			lib.Background(self.x+3,self.y+3,self.x+self.w-2,self.y+self.h-2,192,C_BLACK)
			for i,v in pairs(newMenu) do
				if current==i then
					lib.SetClip(v.x1,v.y1,v.x2,v.y2);
					lib.LoadSur(sid,0,0);
					lib.SetClip(0,0,0,0);
					if hold then
						lib.Background(v.x1,v.y1+RowPixel,v.x2,v.y2-RowPixel,32,M_DarkOrange)
					else
						lib.Background(v.x1,v.y1+RowPixel,v.x2,v.y2-RowPixel,64,M_Orange)
					end
					break;
				end
			end
			Glass(self.x,self.y,self.x+self.w,self.y+self.h);
		end
			
		for i,v in pairs(newMenu) do
			if v[2]==nil then
				if not v.enable then
					DrawStringEnhance(v.tx,v.ty,v[1],M_Silver,size,0.5,0.5);
				elseif current==i then
					if hold then
						DrawStringEnhance(v.tx,v.ty,"[b]"..v[1],C_BLACK,size,0.5,0.5);
					else
						DrawStringEnhance(v.tx,v.ty,"[B][w]"..v[1],C_BLACK,size,0.5,0.5);
					end
				else
					DrawStringEnhance(v.tx,v.ty,"[B][w]"..v[1],C_BLACK,size,0.5,0.5);
				end
			else
				if current==i then
					if hold then
						DrawStringEnhance(v.x2-10-12*#v[2]/2+1,v.y1+17+1,v[2],C_BLACK,12);
						DrawStringEnhance(v.x1+8+1,v.y1+3+1,v[1],C_BLACK,16);
					else
						DrawStringEnhance(v.x2-10-12*#v[2]/2,v.y1+17,v[2],C_BLACK,12);
						DrawStringEnhance(v.x1+8,v.y1+3,v[1],C_BLACK,16);
					end
				else
					DrawStringEnhance(v.x2-10-12*#v[2]/2,v.y1+17,v[2],C_BLACK,12);
					DrawStringEnhance(v.x1+8,v.y1+3,v[1],C_BLACK,16);
				end
			end
		end
		--if isEsc>0 then
			--lib.PicLoadCache(4,44*2,newMenu[newNumItem].tx-96,newMenu[newNumItem].y1-RowPixel/2,1);
		--end
	end
	while true do
		local t1=lib.GetTime();
		redraw();
		ShowScreen();
		local delay=CC.FrameNum-lib.GetTime()+t1;
		if delay>0 then
			lib.Delay(delay);
		end
		--DoEvent
		getkey();
		current=0;
		hold=false;
		if true then
			for i,v in pairs(newMenu) do
				if v.enable then
					if MOUSE.CLICK(v.x1,v.y1+1,v.x2,v.y2) then
						if v[5]==0 then
							PlayWavE(1);
						else
							PlayWavE(0);
						end
						lib.FreeSur(sid);
						return v[5];
					elseif MOUSE.HOLD(v.x1,v.y1+1,v.x2,v.y2) then
						current=i;
						hold=true;
					elseif MOUSE.IN(v.x1,v.y1+1,v.x2,v.y2) then
						current=i;
					end
				else
					if MOUSE.CLICK(v.x1,v.y1+1,v.x2,v.y2) then
						PlayWavE(2);
					end
				end
			end
			if isEsc then
				if MOUSE.ESC() then
					PlayWavE(1);
					lib.FreeSur(sid);
					return 0;
				end
			end
		end
	end
	lib.FreeSur(sid);
end
function ShowNewMenu2(menuItem,x,y)     --ͨ�ò˵�����2
	
	local newMenu={};
	local newNumItem=0;
	for i,v in pairs(menuItem) do
		if menuItem[i][2]>0 then
			newNumItem=newNumItem+1;
            newMenu[newNumItem]={menuItem[i][1],menuItem[i][2],i};   --���������[3],�����ԭ����Ķ�Ӧ
		end
	end
	local self={};
	self.w=156;
	self.h=80+32*newNumItem
	if x==-1 then
		self.x=math.floor((CC.ScreenW-self.w)/2);
	else
		self.x=x;
	end
	if y==-1 then
		self.y=math.floor((CC.ScreenH-self.h)/2);
	else
		self.y=y;
	end
	self.dy=self.y+34;
	for i,v in pairs(newMenu) do
		v.x1=self.x+28;
		v.x2=v.x1+98;
		v.y1=self.dy;
		v.y2=v.y1+32;
		v.tx=v.x1+49;
		v.pic=30;
		if v[2]==2 then
			v.enable=false;
		else
			v.enable=true;
		end
		self.dy=self.dy+32;
	end
	local current=0;
	local hold=false;
	local function redraw()
		local size=20;
		DrawGame();
		lib.SetClip(self.x,self.y,self.x+self.w,self.y+self.h/2);
		lib.PicLoadCache(4,5*2,self.x,self.y,1);
		lib.SetClip(self.x,self.y+self.h/2,self.x+self.w,self.y+self.h);
		lib.PicLoadCache(4,5*2,self.x,self.y+self.h-300,1);
		lib.SetClip(0,0,0,0);
		for i,v in pairs(newMenu) do
			if not v.enable then
				lib.PicLoadCache(4,(v.pic+3)*2,v.x1,v.y1,1);
			elseif current==i then
				if hold then
					lib.PicLoadCache(4,(v.pic+2)*2,v.x1,v.y1,1);
					DrawStringEnhance(v.tx-size*#v[1]/4+1,v.y1+16-size/2+1,v[1],C_BLACK,size);
				else
					lib.PicLoadCache(4,(v.pic+1)*2,v.x1,v.y1,1);
					DrawStringEnhance(v.tx-size*#v[1]/4,v.y1+16-size/2,v[1],C_BLACK,size);
				end
			else
				lib.PicLoadCache(4,v.pic*2,v.x1,v.y1,1);
				DrawStringEnhance(v.tx-size*#v[1]/4,v.y1+16-size/2,v[1],C_BLACK,size);
			end
		end
	end
	while true do
		local t1=lib.GetTime();
		redraw();
		ShowScreen();
		local delay=CC.FrameNum-lib.GetTime()+t1;
		if delay>0 then
			lib.Delay(delay);
		end
		--DoEvent
		getkey();
		current=0;
		hold=false;
		if true then
			for i,v in pairs(newMenu) do
				if v.enable then
					if MOUSE.CLICK(v.x1,v.y1+1,v.x2,v.y2) then
						if v[3]==0 then
							PlayWavE(1);
						else
							PlayWavE(0);
						end
						return v[3];
					elseif MOUSE.HOLD(v.x1,v.y1+1,v.x2,v.y2) then
						current=i;
						hold=true;
					elseif MOUSE.IN(v.x1,v.y1+1,v.x2,v.y2) then
						current=i;
					end
				else
					if MOUSE.CLICK(v.x1,v.y1+1,v.x2,v.y2) then
						PlayWavE(2);
					end
				end
			end
			if MOUSE.CLICK() then
				PlayWavE(1);
				return 0;
			end
			if MOUSE.ESC() then
				PlayWavE(1);
				return 0;
			end
		end
	end
end

function Equip(pid)
	--local pid=War.Person[wid].id;
	--local bz=JY.Person[pid]["����"];
	--local lv=JY.Person[pid]["�ȼ�"];
	local p=JY.Person[pid];
	local s={};
	local m={};
	local n=0;
	local size=20;
	local size2=18;
	local w={}
	w[7]={str="����",pic=203,x1=294+size*2.5,y1=112,x2=294+size*7.5,y2=132};
	w[8]={str="����",pic=203,x1=294+size*2.5,y1=134,x2=294+size*7.5,y2=154};
	w[9]={str="����",pic=203,x1=294+size*2.5,y1=156,x2=294+size*7.5,y2=176};
	s[4]={	str="��һҳ",
			txtdx=20,
			pic=30,
			x1=484,
			y1=380,
			enable=false;
			x2=484+98,
			y2=380+32}
	s[5]={	str="��һҳ",
			txtdx=20,
			pic=30,
			x1=588,
			y1=380,
			enable=false;
			x2=588+98,
			y2=380+32}
	s[6]={	str="",
			txtdx=0,
			pic=18,
			enable=true;
			x1=CC.ScreenW/2-84+50,
			y1=CC.ScreenH-81+8,
			x2=CC.ScreenW/2-84+50+66,
			y2=CC.ScreenH-81+8+46}
	local st={};
	local sheet=3;	--1 ���� 2 ���� 3 ���� 4 ����
		st[3]={	str="����",
				kind=3,
				txtdx=32,
				pic=75,
				x1=460,
				y1=8,
				x2=460+92,
				y2=8+28}
		st[2]={	str="����",
				kind=2,
				txtdx=32,
				pic=75,
				x1=552,
				y1=8,
				x2=552+92,
				y2=8+28}
		st[1]={	str="����",
				kind=1,
				txtdx=32,
				pic=75,
				x1=644,
				y1=8,
				x2=644+92,
				y2=8+28}
	local num_per_page=14;
	local max_page=1;
	local current_page=1;
	local function GetItemByPage()
		if current_page>1 then
			s[4].enable=true;
		else
			s[4].enable=false;
		end
		if current_page<max_page then
			s[5].enable=true;
		else
			s[5].enable=false;
		end
		for i,v in pairs(m) do
			if between(i,num_per_page*current_page-13,num_per_page*current_page) then
				v.show=true;
			else
				v.show=false;
			end
		end
	end
	local function GetItemByType()
		m={};
		n=0;
		local dx,dy=472,56;
		for i=1,JY.ItemNum-1 do
			if 	(st[sheet].kind==4 and between(JY.Item[i]["����"],1,10)) or
				(st[sheet].kind==3 and between(JY.Item[i]["����"],11,20)) or
				(st[sheet].kind==2 and between(JY.Item[i]["����"],21,30)) or
				(st[sheet].kind==1 and between(JY.Item[i]["����"],31,40)) then
				if JY.Base["��Ʒ����"..i]>0 then
					n=n+1;
					m[n]={};
					m[n].str=JY.Item[i]["����"];
					m[n].mid=i;
					if true then
						m[n].enable=true;
					else
						m[n].enable=false;
					end
					m[n].x1,m[n].y1=dx,dy;
					m[n].x2,m[n].y2=m[n].x1+118,m[n].y1+32;
					m[n].txtdx=dx+59;
					m[n].pic=45;
					m[n].show=false;
					dx=dx+140;
					if dx>640 then
						dx=472;
						dy=dy+40;
						if dy>320 then
							dy=56;
						end
					end
				end
			end
		end
		current_page=1;
		max_page=1+math.floor((n-1)/num_per_page);
		GetItemByPage();
	end
	local current=0;
	local hold=false;
	local function redraw()
		--DrawGame();
		lib.PicLoadCache(5,200*2,0,0,1);
			
		local cx,cy=24,24;
		lib.PicLoadCache(2,p["��ò"]*2,cx,cy,1);
		cx=cx+270;
		DrawStringEnhance(cx,cy,p["����"],C_BLACK,size);
		cy=cy+size+2;
		for i,v in pairs({"����","����","ͳ��"}) do
			DrawStringEnhance(cx,cy,v,C_BLACK,size);
			local str;
			if p[v]==p[v.."2"] then
				str=string.format("%d",p[v.."2"]);
			else
				str=string.format("%-4d(%+d)",p[v.."2"],p[v.."2"]-p[v]);
			end
			DrawStringEnhance(cx+size*2.5,cy,str,C_BLACK,size);
			cy=cy+size+2;
		end
		for i,v in pairs(w) do
			local color=C_BLACK;
			if current==i then
				lib.PicLoadCache(4,v.pic*2,v.x1-size,v.y1-1,1);
				color=C_WHITE;
			end
			if p[v.str]>0 then
				DrawStringEnhance(v.x1,v.y1,JY.Item[p[v.str]]["����"],color,size);
			else
				DrawStringEnhance(v.x1,v.y1,"��",color,size);
			end
		end
		for i,v in pairs({"����","����","����"}) do
			DrawStringEnhance(cx,cy,v,C_BLACK,size);
			local color=C_BLACK;
			--if MOUSE.IN(cx+size*2,cy,cx+size*7.5,cy+size) then
			--	lib.PicLoadCache(4,203*2,cx+size*1.5,cy,1);
			--	color=C_WHITE;
			--end
			cy=cy+size+2;
		end
		for i,v in pairs({"����","����"}) do
			DrawStringEnhance(cx,cy,v,C_BLACK,size);
			--DrawStringEnhance(cx+size*3,cy,p[v].."/"..p["���"..v],C_BLACK,size);
			local pic=213;
			if p[v]/p["���"..v]>=0.7 then
				pic=215;
			elseif p[v]/p["���"..v]>=0.3 then
				pic=214;
			end
			local len=80;
			if i==1 then
				len=len+math.floor(p["���"..v]/80);
			elseif i==2 then
				len=len+math.floor(p["���"..v]/4);
			end
			lib.Background(cx+size*2.5,cy+2,cx+size*2.5+len,cy+18,128);
			lib.SetClip(cx+size*2.5,cy,cx+size*2.5+len*p[v]/p["���"..v],cy+24);
			lib.PicLoadCache(4,pic*2,cx+size*2.5,cy+2,1);
			lib.SetClip(0,0,0,0);
			DrawNumPic(cx+size*2.5+40,cy+4,p[v],p["���"..v]);
			cy=cy+size+2;
		end
		for i,v in pairs({"����","����","����","����","����"}) do
			DrawStringEnhance(cx,cy,v,C_BLACK,size);
			--DrawStringEnhance(cx+size*3,cy,p[v],C_BLACK,size);
			local pic=213;
			if p[v]>=1200 then
				pic=215;
			elseif p[v]>=600 then
				pic=214;
			end
			local color="yellow";
			if p[v]>p[v..2] then
				color="blue";
			elseif p[v]<p[v..2] then
				color="red";
			end
			lib.SetClip(cx+size*2.5,cy,cx+size*2.5+p[v]/16+48,cy+24);
			lib.PicLoadCache(4,pic*2,cx+size*2.5,cy+2,1);
			lib.SetClip(0,0,0,0);
			DrawNumPic(cx+size*2.5+40,cy+4,p[v],nil,color);
			cy=cy+size+2;
		end
		---------------------------------------------------
		---------------------------------------------------
		lib.SetClip(0,0,CC.ScreenW,52);
		for i,v in pairs(st) do
			local color=C_WHITE;
			if current==i then
				color=C_ORANGE;
			end
			if i==sheet then
				lib.PicLoadCache(4,76*2,v.x1,v.y1,1);
			else
				lib.PicLoadCache(4,75*2,v.x1,v.y1,1);
			end
			DrawStringEnhance(v.x1+v.txtdx,v.y1+10,v.str,color,size);
		end
		lib.SetClip(0,0,0,0);
		lib.PicLoadCache(4,77*2,448,48,1);
		if current>10 then
			local mid=m[current-10].mid;
			DrawYJZBox(480,355,JY.Item[mid]["˵��"],C_WHITE,size2);
		end
		for i,v in pairs(m) do
			if v.show then
				if v.enable then
					if current==i+10 then
						if hold then
							lib.PicLoadCache(4,(v.pic+2)*2,v.x1,v.y1,1);
							DrawStringEnhance(v.txtdx-size*#v.str/4+1,v.y1+7,v.str,C_BLACK,size);
						else
							lib.PicLoadCache(4,(v.pic+1)*2,v.x1,v.y1,1);
							DrawStringEnhance(v.txtdx-size*#v.str/4,v.y1+6,v.str,C_BLACK,size);
						end
					else
						lib.PicLoadCache(4,v.pic*2,v.x1,v.y1,1);
						DrawStringEnhance(v.txtdx-size*#v.str/4,v.y1+6,v.str,C_BLACK,size);
					end
				else
					lib.PicLoadCache(4,(v.pic+3)*2,v.x1,v.y1,1);
					DrawStringEnhance(v.txtdx-size*#v.str/4,v.y1+6,v.str,C_WHITE,size);
				end
			end
		end
		lib.PicLoadCache(4,10*2,s[6].x1-50,s[6].y1-8,1);
		for i,v in pairs(s) do
			if i==6 or current<=10 then
				if v.enable then
					if current==i then
						if hold then
							lib.PicLoadCache(4,(v.pic+2)*2,v.x1,v.y1,1);
							DrawStringEnhance(v.x1+v.txtdx+1,v.y1+7,v.str,C_BLACK,size);
						else
							lib.PicLoadCache(4,(v.pic+1)*2,v.x1,v.y1,1);
							DrawStringEnhance(v.x1+v.txtdx,v.y1+6,v.str,C_BLACK,size);
						end
					else
						lib.PicLoadCache(4,v.pic*2,v.x1,v.y1,1);
						DrawStringEnhance(v.x1+v.txtdx,v.y1+6,v.str,C_BLACK,size);
					end
				else
					lib.PicLoadCache(4,(v.pic+3)*2,v.x1,v.y1,1);
					DrawStringEnhance(v.x1+v.txtdx,v.y1+6,v.str,C_WHITE,size);
				end
			end
		end
	end
	GetItemByType();
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
		for i,v in pairs(w) do
			if MOUSE.CLICK(v.x1,v.y1,v.x2,v.y2) then
				PlayWavE(1);
				local oid=0;
				if i==7 then
					oid=p["����"];
					p["����"]=0;
				elseif i==8 then
					oid=p["����"];
					p["����"]=0;
				elseif i==9 then
					oid=p["����"];
					p["����"]=0;
				end
				if oid>0 then
					JY.Base["��Ʒ����"..oid]=1;
				end
				GetItemByType();
				ReSetAttrib(pid);
			elseif MOUSE.HOLD(v.x1,v.y1,v.x2,v.y2) then
				current=i;
				hold=true;
				break;
			elseif MOUSE.IN(v.x1,v.y1,v.x2,v.y2) then
				current=i;
				break;
			end
		end
		for i,v in pairs(m) do
			if v.show then
				if v.enable then
					if MOUSE.CLICK(v.x1,v.y1,v.x2,v.y2) then
						--current=i+10;
						PlayWavE(0);
						local mid=m[i].mid;
						local oid=0;
						if JY.Item[mid]["����"]==11 then
							oid=p["����"];
							p["����"]=mid;
						elseif JY.Item[mid]["����"]==21 then
							oid=p["����"];
							p["����"]=mid;
						elseif JY.Item[mid]["����"]==31 then
							oid=p["����"];
							p["����"]=mid;
						end
						if oid>0 then
							JY.Base["��Ʒ����"..oid]=1;
						end
						JY.Base["��Ʒ����"..mid]=0;
						GetItemByType();
						ReSetAttrib(pid);
					elseif MOUSE.HOLD(v.x1,v.y1,v.x2,v.y2) then
						current=i+10;
						hold=true;
						break;
					elseif MOUSE.IN(v.x1,v.y1,v.x2,v.y2) then
						current=i+10;
						break;
					end
				else
					if MOUSE.CLICK(v.x1,v.y1,v.x2,v.y2) then
						current=i+10;
						PlayWavE(2);
						while true do
							local t2=lib.GetTime();
							redraw();
							DrawYJZBox(-1,-1,"�޷�ʹ�ã�",C_WHITE);
							ShowScreen();
							local delay=CC.FrameNum-lib.GetTime()+t2;
							if delay>0 then
								lib.Delay(delay);
							end
							getkey();
							if MOUSE.CLICK() then
								break;
							end
						end
						break;
					elseif MOUSE.IN(v.x1,v.y1,v.x2,v.y2) then
						current=i+10;
						break;
					end
				end
			end
		end
		for i,v in pairs(s) do
			if v.enable then
				if MOUSE.CLICK(v.x1,v.y1,v.x2,v.y2) then
					current=i;
					PlayWavE(99);
					if current==4 then
						current_page=limitX(current_page-1,1,max_page);
						GetItemByPage();
					elseif current==5 then
						current_page=limitX(current_page+1,1,max_page);
						GetItemByPage();
					elseif current==6 then
						return false;
					end
				elseif MOUSE.HOLD(v.x1,v.y1,v.x2,v.y2) then
					current=i;
					hold=true;
					break;
				elseif MOUSE.IN(v.x1,v.y1,v.x2,v.y2) then
					current=i;
					break;
				end
			else
				if MOUSE.CLICK(v.x1,v.y1,v.x2,v.y2) then
					PlayWavE(2);
				end
			end
		end
		for i,v in pairs(st) do
			if MOUSE.CLICK(v.x1+8,v.y1+4,v.x2,v.y2) then
				current=i;
				PlayWavE(0);
				if sheet~=i then
					sheet=i;
					GetItemByType();
				end
			elseif MOUSE.IN(v.x1+8,v.y1+4,v.x2,v.y2) then
				current=i;
				break;
			end
		end
	end
	return false;
end
function chinese_year_month()
	local c_num = {[0]="��","һ","��","��","��","��","��","��","��","��","ʮ","ʮһ","ʮ��"};
	local year=JY.Base["��ǰ��"];
	local month=JY.Base["��ǰ��"];
	local str="";
	if year>999 then
		str="������";
	else
		str=c_num[math.floor(year/100)]..c_num[math.floor((year%100)/10)]..c_num[year%10]
	end
	str=str.."�� "..c_num[month].."��"
	return str;
end
function chinese_number(i)
	local c_digit = { [0]="��","ʮ","��","ǧ","��","��","��" };
	local c_num = {[0]="��","һ","��","��","��","��","��","��","��","��","ʮ"};
	local sym_tian = { [0]="��","��","��","��","��","��","��","��","��","��" };
	local sym_di = { [0]="��","��","��","î","��","��","��","δ","��","��","��","��" };
	if (i < 0) then
		return "��" .. chinese_number(-i);
	elseif (i < 11) then
		return c_num[i];
	elseif (i < 20) then
		return c_digit[1] .. c_num[i - 10];
	elseif (i < 100) then
		if (i % 10)>0 then
			return c_num[math.floor(i / 10)] .. c_digit[1] .. c_num[i % 10];
		else
			return c_num[math.floor(i / 10)] .. c_digit[1];
		end
	elseif (i < 1000) then
		if (i % 100 == 0) then
			return c_num[math.floor(i / 100)] .. c_digit[2];
		elseif (i % 100 < 10) then
			return c_num[math.floor(i / 100)] .. c_digit[2] ..c_num[0] .. chinese_number(i % 100);
		elseif (i % 100 < 20) then
			return c_num[math.floor(i / 100)] .. c_digit[2] ..c_num[1] .. chinese_number(i % 100);
		else
			return c_num[math.floor(i / 100)] .. c_digit[2] ..chinese_number(i % 100);
		end
	elseif (i < 10000) then
		if (i % 1000 == 0) then
			return c_num[math.floor(i / 1000)] .. c_digit[3];
		elseif (i % 1000 < 100) then
			return c_num[math.floor(i / 1000)] .. c_digit[3] ..	c_num[0] .. chinese_number(i % 1000);
		else 
			return c_num[math.floor(i / 1000)] ..c_digit[3] ..	chinese_number(i % 1000);
		end
	elseif (i < 100000000) then
		if (i % 10000 == 0) then
			return chinese_number(math.floor(i / 10000)) .. c_digit[4];
		elseif (i % 10000 < 1000) then
			return chinese_number(math.floor(i / 10000)) .. c_digit[4] ..c_num[0] .. chinese_number(i % 10000);
		else
			return chinese_number(math.floor(i / 10000)) .. c_digit[4] ..chinese_number(i % 10000);
		end
	elseif (i < 1000000000000) then
		if (i % 100000000 == 0) then
			return chinese_number(math.floor(i / 100000000)) .. c_digit[5];
		elseif (i % 100000000 < 1000000) then
			return chinese_number(math.floor(i / 100000000)) .. c_digit[5] ..c_num[0] .. chinese_number(i % 100000000);
		else 
			return chinese_number(math.floor(i / 100000000)) .. c_digit[5] ..chinese_number(i % 100000000);
		end
	elseif (i % 1000000000000 == 0) then
		return chinese_number(math.floor(i / 1000000000000)) .. c_digit[6];
	elseif (i % 1000000000000 < 100000000) then
		return chinese_number(math.floor(i / 1000000000000)) .. c_digit[6] ..c_num[0] .. chinese_number(i % 1000000000000);
	else
		return chinese_number(math.floor(i / 1000000000000)) .. c_digit[6] ..chinese_number(i % 1000000000000);
	end
end
function ConnectCity_sub(cid,fid)
	if cid==0 or fid==0 then
		return;
	end
	for i=1,JY.ConnectionNum-1 do
		local id1,id2=JY.Connection[i]["����1"],JY.Connection[i]["����2"];
		local ncid=0;
		if id1==cid then
			ncid=id2;
		elseif id2==cid then
			ncid=id1;
		end
		if ncid>0 and JY.City[ncid]["����"]==0 then
			JY.City[ncid]["����"]=1;
			local nfid=JY.City[ncid]["����"];
			if nfid==fid then
				ConnectCity_sub(ncid,fid);
			end
		end
	end
end
function ConnectCity()
	local fid=JY.FID;
	local cid=JY.Base["��ǰ�ǳ�"];
	for i=1,JY.CityNum-1 do
		JY.City[i]["����"]=0;
	end
	JY.City[cid]["����"]=1;
	ConnectCity_sub(cid,fid);
end
function GetPath(cid_atk,cid_def)
	for i=1,JY.ConnectionNum-1 do
		if JY.Connection[i]["����1"]==cid_atk and JY.Connection[i]["����2"]==cid_def then
			return i;
		end
	end
	return 0;
end
