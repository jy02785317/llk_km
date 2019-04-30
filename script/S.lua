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
					{"结束游戏",nil,1,true},
					{"载入",nil,1,true},
					{"储存",nil,1,true},
					{"功能设定",nil,1,true},
					{"重载Lua",nil,1,true},
				}
	local r=ShowNewMenu(menu,0,0,1);
	lib.Delay(100);
	if r==1 then
		if TalkYesNo("",'结束游戏吗？',C_WHITE,true) then
			lib.Delay(100);
			if TalkYesNo("",'再玩一次吗？',C_WHITE,true) then
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
		NewPerson(JY.PID);	--初始化主角
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
					{"主角",nil,1,true},
					{"都市",nil,1,true},
					{"势力",nil,1,false},
					{"全部势力",nil,1,true},
					{"全部都市",nil,1,true},
					{"全部武将",nil,1,true},
          {"地图", nil, 1, true},
				}
	local fid = JY.Person[JY.PID]["势力"];
  if fid > 0 then
    menu[3][4] = true;
  end
  local r=ShowNewMenu(menu,0,0,1);
	lib.Delay(100);
	if r==1 then
		ReSetAttrib(JY.PID,true);
		PersonStatus({JY.PID},1);
	elseif r==2 then
		DrawCityStatus({JY.Person[JY.PID]["所在"]},1)
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
	local offset=CC.Base_S["章节名"][1]+100;
	local len=CC.Base_S["章节名"][3]+CC.Base_S["时间"][3];
	local data=Byte.create(8*len);
	Byte.loadfile(data,CC.R_GRPFilename[id],offset,len);
	local SectionName,SaveTime;
	SectionName=Byte.getstr(data,0,28);
	SaveTime=Byte.getstr(data,28,14);
					
	offset=CC.Base_S["战场存档"][1]+100;
	Byte.loadfile(data,CC.R_GRPFilename[id],offset,len);
	if Byte.get16(data,0)==1 then
		offset=CC.Base_S["战场名称"][1]+100;
		Byte.loadfile(data,CC.R_GRPFilename[id],offset,len);
		SectionName=Byte.getstr(data,0,28);
		
		offset=100+136;
		Byte.loadfile(data,CC.R_GRPFilename[id],offset,len);
		local turn=Byte.get8(data,0);
		local maxturn=Byte.get8(data,1);
		SectionName=string.gsub(SectionName,"    ","  ");
		if string.len(SectionName)<14 then
			SectionName=string.format(string.format("%%s%%%ds",14-string.len(SectionName)),SectionName,"")..string.format("第%02d回合",turn,maxturn);
		end
	end
					
	if CC.SrcCharSet==1 then
		SectionName=lib.CharSet(SectionName,0);
	end
	
	return id.."."..SectionName,SaveTime;
end
function ShowRecordMenu(kind)	--kind 0读取  1保存
	local num=8;
	local menu={};
	for id=1,num do
		menu[id]={"",nil,1,true};
		if not fileexist(CC.R_GRPFilename[id]) then
			menu[id][1],menu[id][2]=id..".".."未使用档案","";
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
			if string.sub(menu[r][1],5)~="未使用档案" then
				if WarDrawStrBoxYesNo(string.format("载入在硬碟的第%d进度，可以吗？",r),C_WHITE) then
					LoadRecord(r);
				end
			else
				WarDrawStrBoxConfirm("没有数据",C_WHITE,true);
			end
		elseif kind==1 then
			if WarDrawStrBoxYesNo(string.format("储存在硬碟的第%d号，可以吗？",r),C_WHITE) then
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
			if v["人物"]>=0 then
				local x,y=v["坐标X"],v["坐标Y"];
				local str=JY.Person[v["人物"]]["名称"];
				if JY.Tid==v["人物"] then
					lib.PicLoadCache(2,(JY.Person[v["人物"]]["容貌"]+4000)*2,x+4,y+4,1);
					lib.PicLoadCache(4,2*2,x,y,1);
					DrawStringEnhance(x+49-size*#str/4+1,y+141-size/2+1,str,C_Name,size);
					--DrawYJZBox(-1,12,str,C_WHITE);
				else
					lib.PicLoadCache(2,(JY.Person[v["人物"]]["容貌"]+4000)*2,x+3,y+3,1);
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
					DrawYJZBox(-1,12,"情报",C_WHITE);
				elseif i==2 then
					DrawYJZBox(-1,12,"功能",C_WHITE);
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
			if v["人物"]>=0 then
				local px,py=v["坐标X"],v["坐标Y"];
				if MOUSE.CLICK(px+4,py+4,px+93,py+150) then
					JY.Tid=v["人物"];
					PlayWavE(0);
					DoEvent(JY.EventID);
					if JY.Tid==-1 then
						JY.Tid=0;
						return;
					end
					JY.Tid=0;
					break;
				elseif MOUSE.IN(px+4,py+4,px+93,py+150) then
					JY.Tid=v["人物"];
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
				if WarDrawStrBoxYesNo("禁止的隐含命令模式*对执行结果不负任何责任．*而且对此的询问也不解答．可以吗？",C_WHITE,true) then--可以进入命令键入野ｉ状态吗？
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
	--3不能使用
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
			elseif str=='824826abab' then--↑↓←↑↓→ＡＢＡＢ
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
	local saveflag=false;	--战后提示保存标记
	JY.Status=GAME_START;  --游戏当前状态
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
		elseif JY.Status==GAME_WMAP2 then	--连续战斗
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
				{"开始新游戏",nil,1,true},
				{"读取存档",nil,1,true},
				{"功能设定",nil,1,true},
				{"战场重现",nil,0,true},
				{"比武大会",nil,1,true},
				{"观看剧情简介",nil,1,true},
				{"退出游戏",nil,1,true},
			}
		if CC.Debug==1 then
			menu[4][3]=1;
		end
		lib.Delay(200);
		local s=ShowNewMenu(menu,0,0,0);
		if s==1 then
			LoadRecord(0);
			JY.Person[1]["等级"]=3;
			JY.Person[2]["等级"]=3;
			JY.Person[3]["等级"]=3;
			for i=1,JY.PersonNum-1 do
				GetPic(i);
			end
			JY.Status=GAME_SMAP_AUTO;  --游戏当前状态
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
			JY.Status=GAME_SMAP_AUTO;  --游戏当前状态
			NewPerson();	--初始化主角
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
			if TalkYesNo("",'结束游戏吗？',C_WHITE,true) then
				lib.Delay(100);
				if TalkYesNo("",'再玩一次吗？',C_WHITE,true) then
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
function GenTalkString(str,n)              --产生对话显示需要的字符串
    local tmpstr=str;
	local num=0;
	local v,vv;
    local newstr="";
    while #tmpstr>0 do
		num=num+1;
		local w=0;
		while w<#tmpstr do
		    v=string.byte(tmpstr,w+1);          --当前字符的值
			vv=string.sub(tmpstr,w+1,w+2);
			if vv=="\\n" then
				break;
			elseif v>=128 then
			    w=w+2;
			else
			    w=w+1;
			end
			if w >= 2*n-1 then     --为了避免跨段中文字符
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
--	设置事件
--	eid 事件id
--	flag 事件状态
----------------------------------------------------------------
function SetFlag(eid,flag)
	JY.Base["事件"..eid]=flag;
end
function WarSetFlag(eid,flag)
	JY.Base["战场事件"..eid]=flag;
end
----------------------------------------------------------------
--	GetFlag(eid)
--	检查事件
--	eid 事件id
--	>0返回真，否则返回假
----------------------------------------------------------------
function GetFlag(eid,flag)
	if flag then
		return JY.Base["事件"..eid];
	elseif JY.Base["事件"..eid]>0 then
		return true;
	else
		return false;
	end
end
function WarGetFlag(eid,flag)
	return JY.Base["战场事件"..eid];
end
function WarCheckFlag(eid,flag)
	if JY.Base["战场事件"..eid]>0 then
		return true;
	else
		return false;
	end
end
----------------------------------------------------------------
--	WarModifyTeamAI(tid,ai)
--	修改军团武将AI
--	tid 军团id
--	ai 
----------------------------------------------------------------
function WarModifyTeamAI(tid,ai,ai_x,ai_y)
	for i,v in ipairs(War.Person) do
		--??有没有必要限制部队必须出场??
		if v.tid==tid and v.live and (not v.hide) then
			WarModifyAI(i,ai,ai_x,ai_y)
		end
	end
end
function WarModifyTeamLeaderAI(tid,ai,ai_x,ai_y)
	for i,v in ipairs(War.Person) do
		--??有没有必要限制部队必须出场??
		if v.tid==tid and v.live and (not v.hide) then
			WarModifyAI(i,ai,ai_x,ai_y);
			return;
		end
	end
end
----------------------------------------------------------------
--	WarModifyAI(pid,ai)
--	修改武将AI
--	pid 武将id
--	ai 
----------------------------------------------------------------
function WarModifyAI(wid,ai,ai_x,ai_y)
	if not between(wid,1,War.PersonNum) then
		lib.Debug("WarModifyAI wid="..wid.." not exist.")
		return;
	end
	if ai=="待机" then
		ai=0;
	elseif ai=="出击" then
		if ai_y>0 then
			ai=4;
		elseif ai_x>0 then
			ai=3;
		else
			ai=1;
		end
	elseif ai=="坚守" then
		ai=2;
	elseif ai=="警戒" then
		ai=4;
		ai_x=War.Person[wid].x;
		ai_y=War.Person[wid].y;
	elseif ai=="移动" then
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
--	修改武将阵营
--	pid 武将id
--	fid 阵营id，默认为1
----------------------------------------------------------------
function ModifyForce(pid,fid)
	if pid==nil then
		return;
	end
	fid=fid or 1;
	--修改武将数量统计
	if JY.Person[pid]["势力"]==1 and fid~=1 then
		--JY.Base["武将数量"]=JY.Base["武将数量"]-1;
	end
	if JY.Person[pid]["势力"]~=1 and fid==1 then
		--JY.Base["武将数量"]=JY.Base["武将数量"]+1;
	end
	--如果加入我方，额外确认等级
	if fid==1 then
		JY.Person[pid]["等级"]=limitX(JY.Person[pid]["等级"],1,99);
	end
	
	JY.Person[pid]["势力"]=fid;
	local picid=GetPic(pid);
	if fid==1 and type(War.Person)=="table" then--战斗时如果势力改为刘备，还需要额外修改战斗部分属性
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
--	修改武将兵种
--	pid 武将id
--	bzid 兵种id，默认为1
----------------------------------------------------------------
function ModifyBZ(pid,bzid)
	if pid==nil then
		return;
	end
	bzid=bzid or 1;
	JY.Person[pid]["兵种"]=bzid;
end
----------------------------------------------------------------
--	LoadPic(id,flag)
--	显示过场图片（带边框），带淡入淡出效果
--	flag 0.无效果 1.淡入 2.淡出
----------------------------------------------------------------
function LoadPic(id,flag)
	local w,h=lib.PicGetXY(5,id*2);
	local x=(CC.ScreenW-w)/2;
	local y=(CC.ScreenH-h)/2-56;
	flag=flag or 0;
	if type(flag)=="string" then
		if flag=="淡入" then
			flag=1;
		elseif flag=="淡出" then
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
		elseif flag==1 then	--淡入
			for i=0,256,16 do
				JY.ReFreshTime=lib.GetTime();
				lib.LoadSur(sid,x,y);
				lib.PicLoadCache(5,id*2,x,y,1+2,i);
				lib.GetKey();
				ReFresh();
				JY.SubPic=id;
			end
		elseif flag==2 then	--淡出
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
	local x1=CC.ScreenW/2-84;	--背景栏x
	local y1=CC.ScreenH-81;		--背景栏y
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
	local x1=CC.ScreenW/2-108;	--背景栏x	276
	local y1=CC.ScreenH-81;		--背景栏y	351
	local x2=x1+40;				--316
	local y2=y1+8;				--359
	local x3=x1+110;			--386
	local y3=y1+8;				--359
	local name="";
	local headid=-1;
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
function DrawMulitStrBox(str)         --显示多行剧情
	talk_sub("",-1,str)
	WaitKey();
	DrawGame();
end
function talk_sub(name,headid,str)
	local talkxnum=20;         --对话一行字数
	local talkynum=3;          --对话行数
	local strarray={}
	local num;
	--显示头像和对话的坐标
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
	local name=JY.Person[pid]["名称"];
	local headid=JY.Person[pid]["容貌"]+2000;
	WarPersonCenter(wid);
	--显示头像和对话的坐标
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
					{" 武将情报",nil,1},
					{" 交换道具",nil,1},
					{"   修炼",nil,1},
				}
	DrawYJZBox(32,32,"武将",C_WHITE,true)
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
		if JY.Person[i]["势力"]==fid then
			menu[i]={fillblank(JY.Person[i]["名称"],11),PersonStatus,1};
			n=n+1;
		else
			menu[i]={"",nil,0};
		end
	end
	DrawYJZBox(32,32,"武将情报",C_WHITE,true)
	if n<=8 then
		ShowMenu(menu,JY.PersonNum-1,8,546,224,0,0,5,1,16,C_WHITE,C_WHITE);
	else
		ShowMenu(menu,JY.PersonNum-1,8,530,224,0,0,6,1,16,C_WHITE,C_WHITE);
	end
end

----------------------------------------------------------------
--	Maidan(fid)
--	练武场
----------------------------------------------------------------
function Maidan(fid)
	fid=fid or 1;
	local lvup_flag=false;
	local m_pid={};
	local m_eid={};
	local num_pid,num_eid=0,0;
	local lv_max=math.floor((JY.Person[1]["等级"]+JY.Person[2]["等级"]+JY.Person[3]["等级"]+JY.Person[54]["等级"]+JY.Person[126]["等级"])/6)-5;
	lv_max=limitX(lv_max,3,60);
	for i=1,JY.PersonNum-1 do
		if JY.Person[i]["特技1"]>0 then
			if JY.Person[i]["势力"]==fid then
				if JY.Person[i]["等级"]<lv_max then
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
		Talk(369,"请问谁要练武？");
		local pid=FightSelectMenu(m_pid);
		if pid<=0 then
			Talk(369,"那么，下次再说吧．");
			return;
		end
		local eid=m_eid[math.random(num_eid)];
		Talk(369,"那么，开始吧．");
			local magic={};
			for mid=1,JY.MagicNum-1 do
				magic[mid]=false;
				if HaveMagic(pid,mid) then
					magic[mid]=true;
				end
			end
		local s={0,1,2,4,6};
		if fight(pid,eid,s[math.random(5)])==1 then
			Talk(369,"真精彩！");
			PlayWavE(11);
			LvUp(pid);
			JY.Person[pid]["经验"]=0;
			DrawStrBoxCenter(JY.Person[pid]["名称"].."的等级上升了！");
			lvup_flag=true;
		else
			Talk(369,"太可惜了．");
			DrawStrBoxCenter(JY.Person[pid]["名称"].."得到了少许经验．");
			JY.Person[pid]["经验"]=JY.Person[pid]["经验"]+24;
			if JY.Person[pid]["经验"]>=100 then
				PlayWavE(11);
				LvUp(pid);
				JY.Person[pid]["经验"]=0;
				DrawStrBoxCenter(JY.Person[pid]["名称"].."的等级上升了！");
				lvup_flag=true;
			end
		end
		if lvup_flag then
			--提示技能策略习得
			for i=1,6 do
				if JY.Person[pid]["等级"]==CC.SkillExp[JY.Person[pid]["成长"]][i] then
					PlayWavE(11);
					DrawStrBoxCenter(JY.Person[pid]["名称"].."习得技能"..JY.Skill[JY.Person[pid]["技能"..i]]["名称"].."！");
					break;
				end
			end
			local str="";
			for mid=1,JY.MagicNum-1 do
				if not magic[mid] then
					if HaveMagic(pid,mid) then
						if str=="" then
							str=JY.Magic[mid]["名称"];
						else
							str=str.."、"..JY.Magic[mid]["名称"];
						end
					end
				end
			end
			if #str>0 then
				PlayWavE(11);
				DrawStrBoxCenter(JY.Person[pid]["名称"].."习得策略"..str.."！");
			end
		end
	else
		Talk(369,"没有人需要练武了．");
	end
end

function Shop()
	local sid=JY.Base["道具屋"];
	if sid<=0 then
		PlayWavE(2);
		WarDrawStrBoxConfirm("此地没有道具屋．",C_WHITE,true);
		return
	end
	local shopitem=	{
					[1]={41,28,31},			--汜水关之战前,陈留
					[2]={28,31,44},			--虎牢关之战后,北平
					[3]={28,31,53,41,38,35},--信都城之战后,信都
					[4]={28,31,53},			--广川之战后,广川
					--北海之战前,北平/信都
					[5]={28,31,53,41,38,35,34},		--北海之战后,北平/信都/北海,这里只列了北海的
					[6]={28,31,53,50,47},			--徐州I之战后,北平/信都/北海/徐州/下邳，这里只列的徐州的
					--下邳的 31,32,50,47,34
					[7]={20,22,24,26,41,38,35},			--小沛
					[8]={20,22,24,26,28,29,31,53},			--许昌I
					[9]={31,32,50,47,34},			--下邳
					[10]={20,22,24,26,29,31,32,53},			--邺
					[11]={41,38,39,35,44},			--白马
					[12]={41,42,38,39,35,36},			--汝南
					[13]={20,22,24,26,29,32,53,34},				--襄阳I
					[14]={42,39,36,44,45},				--江夏I
					--[15]={29,32,54,50,51,47},				--江陵I
					[15]={21,23,25,27,29,32,54,50,51,47},				--江陵I,考虑到游戏实际,主要在江陵,而不再襄阳II,将襄阳II的部分道具也加进来
					[16]={42,39,36,44,45,20,22,24},				--江夏II
					[17]={50,51,47,48,38,39},				--长沙
					[18]={21,23,25,27,29,42,39,36,34},				--襄阳II
					[19]={21,23,25,27,29,30,32,54},				--成都I
					[20]={29,32,54,42,20,22,24,34},				--涪
					[21]={21,23,25,27,29,30,32,33},				--成都II
					[22]={42,39,36,29,32,54,48,51},				--西陵
					[23]={42,39,40,36,37,48,51,52},				--江陵II
					[24]={21,23,25,27,43,30,33,55},				--襄阳III
					[25]={30,33,55,43,40,37,45,46},				--宛
					[26]={30,33,55,49,20,22,24,26},			--许昌II
--[[
各地所能购买道具：
陈留：焦热书，酒，豆。
北平：酒，豆，浓雾书。
信都：酒，豆，伤药，焦热书，漩涡书，落石书。
广川：酒，豆，伤药。
北海：酒，豆，伤药，焦热书，漩涡书，落石书，炸弹。
徐州：酒，豆，伤药，平气书，援队书。
下邳：豆，麦，平气书，援队书，炸弹。
小沛：长枪，连弩，马铠，无赖精神，焦热书，漩涡书，落石书。
许昌I：长枪，连弩，马铠，无赖精神，酒，特级酒，豆，伤药。
许昌II：老酒，米，茶，援军书，长枪，连弩，马铠，无赖精神。	第四十八关，许昌II之战后
邺：长枪，连弩，马铠，无赖精神，特级酒，豆，麦，伤药。
白马：焦热书，漩涡书，浊流书，落石书，浓雾书。
汝南：焦热书，火龙书，漩涡书，浊流书，落石书，山崩书。
襄阳I：长枪，连弩，马铠，无赖精神，特级酒，麦，伤药，炸弹。
襄阳II：步兵车，发石车，近卫铠，侠义精神，火龙书，浊流书，山崩书，炸弹。	第二十六关，江陵之战后
襄阳III：步兵车，发石车，近卫铠，侠义精神，猛火书，老酒，米，茶。	第四十二关，襄阳II之战后
江夏I：火龙书，浊流书，山崩书，浓雾书，雷阵雨书。
江夏II：火龙书，浊流书，山崩书，浓雾书，雷阵雨书，长枪，连弩，马铠。	第二十五关，长阪坡之战后
江陵I：特级酒，麦，中药，平气书，活气书，援队书。
江陵II：火龙书，浊流书，海啸书，山崩书，山洪书，援部书，活气书，勇气书。	第三十九关，麦之战后
长沙：平气书，活气书，援队书，援部书，漩涡书，浊流书。
涪：特级酒，麦，中药，火龙书，长枪，连弩，马铠，炸弹。
成都I：步兵车，发石车，近卫铠，侠义精神，特级酒，老酒，麦，中药。
成都II：步兵车，发石车，近卫铠，侠义精神，特级酒，老酒，麦，米。		第三十九关，麦之战后
西陵：火龙书，浊流书，山崩书，特级酒，麦，中药，援部书，活气书。
宛：老酒，米，茶，猛火书，海啸书，山洪书，雷阵雨书，豪雨书。
]]--
					}
	local shopitem2={	--武器店
					[1]={74,80,89,140,147},			--汜水关之战前,陈留
					[2]={74,75,80,89,99,140,141,147},			--虎牢关之战后,北平
					[3]={80,81,85,89,95,117,120,141,148},--信都城之战后,信都
					[4]={75,90,141,148},			--广川之战后,广川
					--北海之战前,北平/信都
					[5]={80,81,85,89,95,117,120,141,148},		--北海之战后,北平/信都/北海,这里只列了信都的
					[6]={90,96,120,125,126,131,142,148},			--徐州I之战后,北平/信都/北海/徐州/下邳，这里只列的徐州的
					--下邳的 31,32,50,47,34
					[7]={81,85,100,117,135,142,152},			--小沛
					[8]={86,90,101,104,105,117,135,142,152,148},			--许昌I
					[9]={86,90,101,105,142,152,148},			--下邳,其实没有，随便编几个
					[10]={76,82,91,102,106,118,136,131,130},			--邺
					[11]={140,141,142,147,148},			--白马,其实没有，随便编几个
					[12]={76,82,91,102,106,142},			--汝南,其实没有，随便编几个
					[13]={91,97,127,131,141,143,152,149,150},				--襄阳I
					[14]={76,82,86,106,109,110,118,121,123},				--江夏I
					[15]={103,107,111,114,132,133,142,144,153},				--江陵I
					[16]={76,82,86,106,109,110,118,121,123},				--江夏II
					[17]={76,82,86,103,107,110},				--长沙,其实没有，随便编几个
					[18]={77,90,92,96,97,128},				--襄阳II
					[19]={78,83,87,111,115,128,145,153,150},				--成都I
					[20]={92,97,102,106,139},				--涪,其实没有，随便编几个
					[21]={78,83,87,111,115,128,145,153,150},				--成都II
					[22]={78,83,87,92,97,102,106,111,115,139},				--西陵,其实没有，随便编几个
					[23]={93,97,103,108,112,137,119,122,129},				--江陵II
					[24]={84,88,98,116,124,138,134,146,151},				--襄阳III
					[25]={84,88,98,103,108},				--宛
					[26]={79,94,113,139,132,154},			--许昌II
					}
	local shopid=1;	--1道具 2武器
	local buysellmenu={
						{"  买道具 ",nil,1},
						{"  买武器 ",nil,1},
						{"    卖   ",nil,1},
					};
	local itemmenu={};
	local itemnum=0;
	local personmenu={};
	local personnum=0;
	for i=1,JY.PersonNum-1 do
		if JY.Person[i]["势力"]==1 then
			personmenu[i]={fillblank(JY.Person[i]["名称"],11),nil,1};
			personnum=personnum+1;
		else
			personmenu[i]={"",nil,0};
		end
	end
	PlayWavE(0);
	
	local status="SelectBuySell";
	local iid,pid;
	local function showbuysellmenu()
		talk_sub(375,"有什么事情？");
		local r=ShowMenu(buysellmenu,3,0,0,156,0,0,3,1,16,C_WHITE,C_WHITE);
		if r==1 then
			status="SelectItem";
			shopid=1;
			itemmenu={};
			itemnum=0;
			for i,v in pairs(shopitem[sid]) do
				itemnum=itemnum+1;
				itemmenu[itemnum]={fillblank(JY.Item[v]["名称"],11),nil,1};
			end
		elseif r==2 then
			status="SelectItem";
			shopid=2;
			itemmenu={};
			itemnum=0;
			for i,v in pairs(shopitem2[sid]) do
				itemnum=itemnum+1;
				itemmenu[itemnum]={fillblank(JY.Item[v]["名称"],11),nil,1};
			end
		elseif r==3 then
			status="SelectPersonSell";
		else
			status="Exit";
			PlayWavE(1);
		end
	end
	local function showitemmenu()
		talk_sub(375,"买什么？");
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
			DrawStringEnhance(x+16,y+16,JY.Item[iid]["名称"],C_Name,size);
			DrawStr(x+16,y+36,GenTalkString(JY.Item[iid]["说明"],18),C_WHITE,size);
			
			if TalkYesNo(375,JY.Item[iid]["名称"].."黄金"..JY.Item[iid]["价值"].."0，*可以吗？") then
				--如果黄金不够
				if JY.Item[iid]["价值"]*10>JY.Base["黄金"] then
					DrawSMap();
					PlayWavE(2);
					Talk(375,"看来黄金不够了．");
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
		talk_sub(375,JY.Item[iid]["名称"].."哪位要？");
		local r;
		if personnum<=10 then
			r=ShowMenu(personmenu,JY.PersonNum-1,10,0,156,0,0,5,1,16,C_WHITE,C_WHITE);
		else
			r=ShowMenu(personmenu,JY.PersonNum-1,8,0,156,0,0,6,1,16,C_WHITE,C_WHITE);
		end
		if r>0 then
			pid=r;
			if JY.Person[pid]["道具8"]>0 then
				PlayWavE(2);
				if TalkYesNo(375,"那位不能再*带东西了，别人吧？") then
					status="SelectPerson";
				else
					status="SelectItem";
				end
			else
				PersonStatus_sub(pid,108,156);
				if TalkYesNo(375,"可以交给"..JY.Person[pid]["名称"].."吗？") then
					GetMoney(-10*JY.Item[iid]["价值"]);
					for i=1,8 do
						if JY.Person[pid]["道具"..i]==0 then
							JY.Person[pid]["道具"..i]=iid;
							break;
						end
					end
					DrawSMap();
					DrawYJZBox(32,32,"道具买卖",C_WHITE,true);
					if TalkYesNo(375,"多谢了，还要……再买点吗？") then
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
		talk_sub(375,"想卖哪位的东西？");
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
		if JY.Person[pid]["道具1"]==0 then
			PlayWavE(2);
			Talk(375,"您没有什么东西可卖。");
			status="SelectPersonSell";
		else
			local sellmenu={};
			for i=1,8 do
				iid=JY.Person[pid]["道具"..i];
				if iid>0 then
					sellmenu[i]={fillblank(JY.Item[iid]["名称"],11),nil,1};
				else
					sellmenu[i]={"",nil,0};
				end
			end
			talk_sub(375,"卖什么？");
			local rr=ShowMenu(sellmenu,8,0,0,156,0,0,3,1,16,C_WHITE,C_WHITE);
			if rr>0 then
				iid=JY.Person[pid]["道具"..rr];
				if TalkYesNo(375,"用"..(10*math.floor(JY.Item[iid]["价值"]*0.75)).."黄金收购"..JY.Item[iid]["名称"].."，可以吗？") then
					for i=rr,7 do
						JY.Person[pid]["道具"..i]=JY.Person[pid]["道具"..(i+1)]
					end
					JY.Person[pid]["道具8"]=0;
					GetMoney(10*math.floor(JY.Item[iid]["价值"]*0.75));
					DrawSMap();
					DrawYJZBox(32,32,"道具买卖",C_WHITE,true);
					if TalkYesNo(375,"多谢了，还要……想卖点什么吗？") then
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
	Talk(375,"我是商人．");
	while true do
		JY.Tid=375;
		DrawSMap();
		DrawYJZBox(32,32,"道具买卖",C_WHITE,true);
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
			Talk(375,"欢迎再来．");
			break;
		end
	end
	
end
function WarIni()
	War={};
	SetWarConst();
end
function SetWarConst()
	War.tBrush={[0]="无",[1]="道路",[2]="平地",[3]="荒地",[4]="草地",[5]="森林",[6]="湿地",[7]="山",[8]="高山",[9]="断崖",[10]="浅滩",[11]="川",[12]="湖",[13]="砦",[14]="城"}
	War.Frame=0;
	War.FrameT=0;
	War.x_off=0;
	War.y_off=0;
	War.mx=-1;
	War.my=-1;
	War.WavTimer=0;
	War.MAP={};	--部队所处坐标，地形等，这个表需要保存
	War.Asmap={};	--A*使用的map数据
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
--用于连战，其实就是把敌军删掉
function WarIni2()
	for i=War.PersonNum,1,-1 do
		if War.Person[i].enemy then
			table.remove(War.Person,i);
			War.PersonNum=War.PersonNum-1
		end
	end
end
function WarCleanEvent()
	--清空战场事件
	for i=1,200 do
		JY.Base["战场事件"..i]=0;
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
		InsertWarPerson(0,t_team[i+1],arg[4*i+1],arg[4*i+2],arg[4*i+3],0,"我",arg[4*i+4],"出击",-1,-1)
	end
end
function GeyBaselineLv()
	return JY.Person[JY.PID]["等级"];
end
function Follower(pid,fid,n)
	--Pri.1
	
	--Pri.2
	if JY.Person[pid]["品级"]>=4 and n<1 then
		return GenClassC(pid,fid);
	end
	--Pri.3
	
	--others
	return fid;
end
function InsertWarTeam(team_id,plist,x0,y0,d,force,hide,order,kind,ai,ai_x,ai_y)
	--new x y,   x 在两边 y在上下
	--b 0 近战 1远程
	local n=#plist;
	if n==0 then
		return;
	end
	local pid;
	if order=="文" then
		pid=plist[n];
		table.remove(plist,n);
	else
		pid=plist[1];
		table.remove(plist,1);
	end
	if force=="敌" then
		local jtnum=WarGetFlag(11)+1;
		WarSetFlag(11,jtnum);	--敌军军团数量
		WarSetFlag(110+jtnum,pid);	--敌方军团长ID
	end
	local team={};
	local tmp_t={};
	local npcnum=JY.Person[pid]["品级"];
	local lv=1;
	local npclv=0;
	if JY.Person[pid]["品级"]<4 then
		npclv=npclv-1;
	end
	if order=="帅" then
		npcnum=npcnum+2;
		lv,npclv=lv+2,npclv+2;
	end
	if kind==1 then			--步兵守卫
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
	elseif kind==2 then		--弓兵远射
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
	elseif kind==3 then		--水战密集
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
	elseif kind==4 then		--山林密集
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
	elseif kind==5 then		--骑兵密集
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
	if CheckSkill(pid,4) then	--练兵
		npclv=npclv+1;
	end
	local fg=0;
	if npcnum>=4 then
		fg=math.random(1,npcnum);
	end
	for i,v in ipairs(team) do
		local nid;
		if v.b==0 then
			nid=GenPerson(RND(0.8),pid,"步兵队","骑兵队");
		elseif v.b==1 then
			nid=GenPerson(RND(0.9),pid,"弓兵队","骑兵队");
		elseif v.b==2 then
			nid=GenPerson(true,pid,"弓兵队");
		elseif v.b==3 then
			nid=GenPerson(RND(0.5),pid,"武术家","步兵队");
		elseif v.b==4 then
			nid=GenPerson(RND(0.5),pid,"武术家","弓兵队");
		elseif v.b==5 then
			nid=GenPerson(RND(0.5),pid,"贼兵","步兵队");
		elseif v.b==6 then
			nid=GenPerson(RND(0.5),pid,"贼兵","弓兵队");
		elseif v.b==7 then
			nid=GenPerson(RND(0.5),pid,"骑兵队","步兵队");
		elseif v.b==8 then
			nid=GenPerson(RND(0.5),pid,"骑兵队","弓兵队");
		end
		if i==fg then
			nid=GenClassC(pid,nid);
		end
		if JY.Person[pid]["统兵"]>0 then
			nid=BodyGuard(pid,nid);
		end
		local nx,ny;
		if d=="上" then
			nx,ny=x0+v.x,y0-v.y;
		elseif d=="下" then
			nx,ny=x0+v.x,y0+v.y;
		elseif d=="左" then
			nx,ny=x0-v.y,y0+v.x;
		elseif d=="右" then
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
	if d=="上" then
		direction=2;
	elseif d=="下" then
		direction=1;
	elseif d=="左" then
		direction=3;
	elseif d=="右" then
		direction=4;
	end
	if force~="我" then
		JY.Person[pid]["等级"]=limitX(GeyBaselineLv()+JY.Person[pid]["品级"]+lv,1,60);
		JY.Person[pid]["功绩"]=CC.Exp[JY.Person[pid]["等级"]];
		--for i=4,1,-1 do
		--	if JY.Person[pid]["等级"]>=20*(i-1) and JY.Person[pid]["兵种"..i]>0 then
		--		JY.Person[pid]["兵种"]=JY.Person[pid]["兵种"..i];
		--		break;
		--	end
		--end
	end
	JY.Person[pid]["出战"]=1;
	War.PersonNum=War.PersonNum+1;
	table.insert(War.Person,	{
									id=pid,				--人物ID
									tid=team_id,		--军团ID
									x=x,					--坐标X
									y=y,					--坐标Y
									--pic=JY.Person[T[idx+1]]["战斗动作"],	--形象ID
									action=1,				--动作 0静止，1走路...
									effect=0,				--高亮显示
									hurt=-1,				--显示伤害数值
									bz=JY.Person[pid]["兵种"],
									movewav=JY.Bingzhong[JY.Person[pid]["兵种"]]["音效"],	--移动音效
									atkwav=JY.Bingzhong[JY.Person[pid]["兵种"]]["攻击音效"],	--攻击音效
									movestep=JY.Bingzhong[JY.Person[pid]["兵种"]]["移动"],	--移动范围
									movespeed=JY.Bingzhong[JY.Person[pid]["兵种"]]["移动速度"],	--移动速度
									atkfw=JY.Bingzhong[JY.Person[pid]["兵种"]]["攻击范围"],	--攻击范围
									sq=0,
									atk_buff=0,
									int_buff=0,
									def_buff=0,
									dex_buff=0,
									shi_buff=0,
									frame=-1,				--显示帧数
									d=direction,					--方向
									active=true,			--可否行动
									enemy=false,			--敌军我军
									friend=false,			--友军？
									ai=0,					--AI类型
									live=true,				--存活
									hide=hide,				--伏兵
									was_hide=hide,				--伏兵
									troubled=false,			--混乱
									leader=false,
								})
	WarModifyAI(War.PersonNum,ai,ai_x,ai_y);
	if force=="敌" then
		War.Person[War.PersonNum].enemy=true;
		if War.Leader2==pid then
			War.Person[War.PersonNum].leader=true;
		end
	elseif force=="友" then
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
	CC.Person_S["容貌"]=CC.Person_S["战斗容貌"];
	for i,v in ipairs(JY.Person) do
		v["出战"]=0;
	end
	SRPG();
	CC.Person_S["容貌"]=CC.Person_S["内政容貌"];
end
----------------------------------------------------------------
--	WarSave()
--	保存战场
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
	JY.Base["战场名称"]=War.WarName;
	JY.Base["战场目标"]=War.WarTarget;
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
--	读取战场
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
	War.WarName=JY.Base["战场名称"];
	War.WarTarget=JY.Base["战场目标"];
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
	CleanWarMap(1,0);	--地形
	CleanWarMap(2,0);	--wid
	CleanWarMap(3,0);	--
	CleanWarMap(4,1);	--选择范围
	CleanWarMap(5,-1);	--攻击价值
	CleanWarMap(6,-1);	--策略价值
	CleanWarMap(7,0);	--选择的策略
	CleanWarMap(8,0);	--AI强化用，我军的攻击范围
	CleanWarMap(9,0);	--水火控制
	CleanWarMap(10,0);	--攻击范围，显示用
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
		War.Person[i].action=1;				--动作 0静止，1走路...
		War.Person[i].effect=0;				--高亮显示
		War.Person[i].hurt=-1;				--显示伤害数值
		War.Person[i].bz=JY.Person[pid]["兵种"];
		War.Person[i].movewav=JY.Bingzhong[JY.Person[pid]["兵种"]]["音效"];	--移动音效
		War.Person[i].atkwav=JY.Bingzhong[JY.Person[pid]["兵种"]]["攻击音效"];	--攻击音效
		War.Person[i].movestep=JY.Bingzhong[JY.Person[pid]["兵种"]]["移动"];	--移动范围
		War.Person[i].movespeed=JY.Bingzhong[JY.Person[pid]["兵种"]]["移动速度"];	--移动速度
		War.Person[i].atkfw=JY.Bingzhong[JY.Person[pid]["兵种"]]["攻击范围"];	--攻击范围
		War.Person[i].atk_buff=0;
		War.Person[i].int_buff=0;
		War.Person[i].def_buff=0;
		War.Person[i].dex_buff=0;
		War.Person[i].shi_buff=0;
		War.Person[i].frame=-1;				--显示帧数
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
--	提示是否保存
--	flag, 默认为1	1战前提示 2战后提示
----------------------------------------------------------------
function RemindSave(flag)
	flag=flag or 1;
	if flag==1 then
		DrawSMap();
	elseif flag==2 then
		JY.Status=GAME_START;	--仅仅是为了方便自动计算坐标
	end
	if WarDrawStrBoxYesNo("现在储存吗？",C_WHITE,true) then
			local menu2={
						{" 1. ",nil,1},
						{" 2. ",nil,1},
						{" 3. ",nil,1},
						{" 4. ",nil,1},
						{" 5. ",nil,1},
					}
			for id=1,5 do
				if not fileexist(CC.R_GRPFilename[id]) then
					menu2[id][1]=menu2[id][1].."未使用档案";
				else
					menu2[id][1]=menu2[id][1]..GetRecordInfo(id);
				end
			end
			DrawYJZBox(-1,100,"将档案储存在哪里？",C_WHITE);
			local s2=ShowMenu(menu2,5,0,0,0,0,0,20,1,16,C_WHITE,C_WHITE);
			if between(s2,1,5) then
				if WarDrawStrBoxYesNo(string.format("储存在硬碟的第%d号，可以吗？",s2),C_WHITE,true) then
					if flag==2 then
						JY.Status=GAME_SMAP_AUTO;	--与前面对应，改回来
					end
					SaveRecord(s2);
				end
			end
	end
	if flag==1 then
		DrawSMap();
	elseif flag==2 then
		JY.Status=GAME_SMAP_AUTO;	--与前面对应，改回来
	end
end

----------------------------------------------------------------
--	WarTeamAI(tid)
--	指定队伍开始行动
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
--	等级上升
--	pid 人物id, n 默认为1
----------------------------------------------------------------
function LvUp(pid,n)
	n=n or 1;
	if pid>=0 then
		JY.Person[pid]["等级"]=limitX(JY.Person[pid]["等级"]+n,1,60);
	end
end
----------------------------------------------------------------
--	WarCheckLocation(pid,x,y)
--	测试到达战场坐标
--	pid 人物id, -1时为任意我方武将
----------------------------------------------------------------
function WarCheckLocation(name,x,y)
	if War.SelID==0 then
		return false;
	end
	--pid=-1代表任意我方我将
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
--	测试到达战场坐标得到物品
--	x,y 坐标, item 物品id, event 检查事件id
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
--	测试到达战场坐标
--	wid war_id, -1时为任意我方武将
----------------------------------------------------------------
function WarCheckArea(wid,x1,y1,x2,y2)
	if War.SelID==0 then
		return false;
	end
	--wid=-1代表任意我方我将
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
	if pid1==-1 then	--不限定特点人物
		if War.Person[War.SelID].enemy then	--必须不为敌军
			return false;
		else
			id1=War.SelID;
			pid1=War.Person[War.SelID].id;
		end
	elseif War.Person[War.SelID].id==pid1 then	--指定人物 必须为当前行动人物
		id1=War.SelID;
	else
		return false;
	end
	id2=GetWarID(pid2);
	if id1>0 and id2>0 and
		War.Person[id1].live and War.Person[id2].live and 
		(not War.Person[id1].hide) and (not War.Person[id2].hide) and 
		JY.Person[pid1]["兵力"]>0 and JY.Person[pid2]["兵力"]>0 then
		if math.abs(War.Person[id1].x-War.Person[id2].x)+math.abs(War.Person[id1].y-War.Person[id2].y)==1 then
			return true;
		end
	end
	return false;
end
----------------------------------------------------------------
--	WarMoveTo(pid,x,y)
--	人物移动到指定坐标
--	pid 人物id
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
--	伏兵出现
--	wid 人物战场id
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
--	寻找最近的可以出现的地点
--	x,y目标地点
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
	kind=kind or "我";
	if (not WarGetFlag(event)) then
		if turn==War.Turn then
			if (kind=="我" and JY.EventType==3) or (kind=="友" and JY.EventType==4) or (kind=="敌" and JY.EventType==5) then
				WarSetFlag(event,1);
				return true;
			end
		end
	end
	return false;
end
----------------------------------------------------------------
--	GetMoney(money)
--	获得黄金
--	money 黄金数量,为负数时失去黄金，无提示
----------------------------------------------------------------
function GetMoney(money)
	JY.Base["黄金"]=limitX(JY.Base["黄金"]+money,0,50000);
end
----------------------------------------------------------------
--	GetItem(pid,item)
--	获得道具
--	pid 人物id
----------------------------------------------------------------
function GetItem(item,num)
	PlayWavE(11);
	if item==0 then
		DrawStrBoxWaitKey(string.format("获得资金 X %d",num),C_WHITE);
		GetMoney(num);
	elseif item>0 then
		DrawStrBoxWaitKey(string.format("获得%s X %d",JY.Item[item]["名称"],num),C_WHITE);
		if between(JY.Item[item]["类型"],1,10) then
			JY.Base["物品数量"..item]=limitX(JY.Base["物品数量"..item]+num,0,99);
		else
			JY.Base["物品数量"..item]=limitX(num,0,1);
		end
	end
	return true;
end
----------------------------------------------------------------
--	WarGetItem(wid,item)
--	获得道具
--	wid 人物wid
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
--	残存部队得到50点经验值．
--	Exp 经验值,无用
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
				JY.Person[pid]["经验"]=JY.Person[pid]["经验"]+Exp;
				if JY.Person[pid]["经验"]>=100 then
					JY.Person[pid]["经验"]=JY.Person[pid]["经验"]-100;
					WarLvUp(i);
				end
			end
		end
	end
end
----------------------------------------------------------------
--	WarGetTrouble(wid)
--	判断是否进入混乱状态
--	wid war_id
--4.防御方是否会陷入混乱
--如果牵制后，防御方的士气下降到30以下，则按以下算法判断是否会陷入混乱。
--计算出一个0－4之间的随机数，如果随机数小于3，则防御方部队陷入混乱。
--『说明』防御方有60％的可能性陷入混乱。
----------------------------------------------------------------
function WarGetTrouble(wid)
	local pid=War.Person[wid].id;
	if JY.Person[pid]["士气"]<30 and JY.Person[pid]["兵力"]>0 then
		if math.random(5)-1<3 then
			if War.Person[wid].troubled then
				WarDrawStrBoxDelay(JY.Person[pid]["名称"].."更加混乱了！",C_WHITE);
			else
				War.Person[wid].troubled=true
				War.Person[wid].action=7;
				WarDelay(2);
				WarDrawStrBoxDelay(JY.Person[pid]["名称"].."混乱了！",C_WHITE);
			end
		end
	end
end
----------------------------------------------------------------
--	WarTroubleShooting(wid)
--	唤醒混乱中的部队
--	wid war_id
--	恢复因子＝0～99的随机数，如果恢复因子小于（统御力＋士气）÷3，那么部队被唤醒．由此看出，统御越高，士气越高，越容易从混乱中苏醒．
----------------------------------------------------------------
function WarTroubleShooting(wid)
	local pid=War.Person[wid].id;
	if War.Person[wid].troubled then
		local flag=false;
		if math.random(100)-1<(JY.Person[pid]["统率"]+JY.Person[pid]["士气"])/3 then
			flag=true;
		end
		if CC.Enhancement then
			if WarCheckSkill(wid,20) then	--沉着
				flag=true;
			end
		end
		if flag then
			WarPersonCenter(wid);
			War.Person[wid].troubled=false;
			WarDrawStrBoxDelay(JY.Person[pid]["名称"].."从混乱中恢复！",C_WHITE);
		end
	end
end
----------------------------------------------------------------
--	WarEnemyWeak(id,kind)
--	兵力士气减半
--	id	1我军 2敌军
--	kind 1兵力 2士气
----------------------------------------------------------------
function WarEnemyWeak(id,kind)
	for i,v in pairs(War.Person) do
		if v.live and (not v.hide) then
			if (id==1 and (not v.enemy)) or (id==2 and v.enemy) then
				local pid=v.id;
				if kind==1 then
					JY.Person[pid]["兵力"]=limitX(JY.Person[pid]["兵力"]/2,1,JY.Person[pid]["最大兵力"]);
				elseif kind==2 then
					JY.Person[pid]["士气"]=limitX(JY.Person[pid]["士气"]/2,1,v.sq);
					ReSetAttrib(pid,false);
					WarGetTrouble(i);
				end
			end
		end
	end
end
----------------------------------------------------------------
--	WarFireWater(x,y,kind)
--	水火控制
--	x,y坐标,输入为dos版坐标，实际需要+1修正
--	kind 1放火 2放水 3取消放水
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
--	检查是否具有某项技能
----------------------------------------------------------------
function WarCheckSkill(wid,skillid)
	local pid=War.Person[wid].id;
	for i=1,6 do
		if JY.Person[pid]["技能"..i]==skillid then
			if JY.Person[pid]["等级"]>=CC.SkillExp[JY.Person[pid]["成长"]][i] then
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
		if JY.Person[pid]["技能"..i]==skillid then
			if JY.Person[pid]["等级"]>=CC.SkillExp[JY.Person[pid]["成长"]][i] then
				return true;
			end
		end
	end
	return false;
end
function JoinUs(name,flag)
	flag=flag or "加入";
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
	if flag=="加入" then
		JY.Person[pid]["加入"]=1;
		--JY.Base["武将数量"]=JY.Base["武将数量"]+1;
		JY.Person[pid]["等级"]=limitX(JY.Person[pid]["等级"],1,99);
		if type(War.Person)=="table" then--战斗时如果势力改为刘备，还需要额外修改战斗部分属性
			for i,v in pairs(War.Person) do
				if v.id==pid then
					v.enemy=false;
					v.friend=false;
					v.pic=WarGetPic(i);
					break;
				end
			end
		end
	elseif flag=="离开" then
		JY.Person[pid]["加入"]=0;
		--JY.Base["武将数量"]=JY.Base["武将数量"]-1;
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
	if between(JY.Item[tid]["类型"],11,20) then
		JY.Person[pid]["武器"]=tid;
	elseif between(JY.Item[tid]["类型"],21,30) then
		JY.Person[pid]["防具"]=tid;
	elseif between(JY.Item[tid]["类型"],31,40) then
		JY.Person[pid]["辅助"]=tid;
	end
	ReSetAttrib(pid,false);
end
function RemoveEqp(name,kind)
	local pid=-1;
	kind=kind or "全部";
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
	if kind=="全部" then
		JY.Person[pid]["武器"]=0;
		JY.Person[pid]["防具"]=0;
		JY.Person[pid]["辅助"]=0;
	elseif kind=="武器" then
		JY.Person[pid]["武器"]=0;
	elseif kind=="防具" then
		JY.Person[pid]["防具"]=0;
	elseif kind=="辅助" then
		JY.Person[pid]["辅助"]=0;
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
function ShowNewMenu(menuItem,x,y,isEsc)     --通用菜单函数
	
	local newMenu={};
	local newNumItem=0;
	for i,v in pairs(menuItem) do
		if menuItem[i][3]>0 then
			newNumItem=newNumItem+1;
            newMenu[newNumItem]={menuItem[i][1],menuItem[i][2],menuItem[i][3],menuItem[i][4],i};   --新数组多了[5],保存和原数组的对应
		end
	end
	local self={};
	self.w=288;
	self.h=80;	-- +40*newNumItem
	self.position=0;
	for i,v in pairs(newMenu) do
		if v[3]==1 then	--长条
			self.position=0;
			self.h=self.h+40;
		elseif v[3]==2 then	--短
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
        newMenu[newNumItem]={"[b]返回",nil,1,true,0};
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
function ShowNewMenuBig(menuItem,x,y,isEsc)     --通用菜单函数
	local size=24;
	local RowPixel=8;
	local newMenu={};
	local newNumItem=0;
	for i,v in pairs(menuItem) do
		if menuItem[i][3]>0 then
			newNumItem=newNumItem+1;
            newMenu[newNumItem]={menuItem[i][1],menuItem[i][2],menuItem[i][3],menuItem[i][4],i};   --新数组多了[5],保存和原数组的对应
		end
	end
	if isEsc>0 then
		newNumItem=newNumItem+1;
        newMenu[newNumItem]={"返回",nil,1,true,0};
	end
	local self={};
	self.w=288;
	self.h=80;	-- +40*newNumItem
	self.position=0;
	for i,v in pairs(newMenu) do
		if v[3]==1 then	--长条
			self.position=0;
			self.h=self.h+size+RowPixel*2;
		elseif v[3]==2 then	--短
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
function ShowNewMenu2(menuItem,x,y)     --通用菜单函数2
	
	local newMenu={};
	local newNumItem=0;
	for i,v in pairs(menuItem) do
		if menuItem[i][2]>0 then
			newNumItem=newNumItem+1;
            newMenu[newNumItem]={menuItem[i][1],menuItem[i][2],i};   --新数组多了[3],保存和原数组的对应
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
	--local bz=JY.Person[pid]["兵种"];
	--local lv=JY.Person[pid]["等级"];
	local p=JY.Person[pid];
	local s={};
	local m={};
	local n=0;
	local size=20;
	local size2=18;
	local w={}
	w[7]={str="武器",pic=203,x1=294+size*2.5,y1=112,x2=294+size*7.5,y2=132};
	w[8]={str="防具",pic=203,x1=294+size*2.5,y1=134,x2=294+size*7.5,y2=154};
	w[9]={str="辅助",pic=203,x1=294+size*2.5,y1=156,x2=294+size*7.5,y2=176};
	s[4]={	str="上一页",
			txtdx=20,
			pic=30,
			x1=484,
			y1=380,
			enable=false;
			x2=484+98,
			y2=380+32}
	s[5]={	str="下一页",
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
	local sheet=3;	--1 辅助 2 防具 3 武器 4 道具
		st[3]={	str="武器",
				kind=3,
				txtdx=32,
				pic=75,
				x1=460,
				y1=8,
				x2=460+92,
				y2=8+28}
		st[2]={	str="防具",
				kind=2,
				txtdx=32,
				pic=75,
				x1=552,
				y1=8,
				x2=552+92,
				y2=8+28}
		st[1]={	str="辅助",
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
			if 	(st[sheet].kind==4 and between(JY.Item[i]["类型"],1,10)) or
				(st[sheet].kind==3 and between(JY.Item[i]["类型"],11,20)) or
				(st[sheet].kind==2 and between(JY.Item[i]["类型"],21,30)) or
				(st[sheet].kind==1 and between(JY.Item[i]["类型"],31,40)) then
				if JY.Base["物品数量"..i]>0 then
					n=n+1;
					m[n]={};
					m[n].str=JY.Item[i]["名称"];
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
		lib.PicLoadCache(2,p["容貌"]*2,cx,cy,1);
		cx=cx+270;
		DrawStringEnhance(cx,cy,p["名称"],C_BLACK,size);
		cy=cy+size+2;
		for i,v in pairs({"武力","智力","统率"}) do
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
				DrawStringEnhance(v.x1,v.y1,JY.Item[p[v.str]]["名称"],color,size);
			else
				DrawStringEnhance(v.x1,v.y1,"无",color,size);
			end
		end
		for i,v in pairs({"武器","防具","辅助"}) do
			DrawStringEnhance(cx,cy,v,C_BLACK,size);
			local color=C_BLACK;
			--if MOUSE.IN(cx+size*2,cy,cx+size*7.5,cy+size) then
			--	lib.PicLoadCache(4,203*2,cx+size*1.5,cy,1);
			--	color=C_WHITE;
			--end
			cy=cy+size+2;
		end
		for i,v in pairs({"兵力","策略"}) do
			DrawStringEnhance(cx,cy,v,C_BLACK,size);
			--DrawStringEnhance(cx+size*3,cy,p[v].."/"..p["最大"..v],C_BLACK,size);
			local pic=213;
			if p[v]/p["最大"..v]>=0.7 then
				pic=215;
			elseif p[v]/p["最大"..v]>=0.3 then
				pic=214;
			end
			local len=80;
			if i==1 then
				len=len+math.floor(p["最大"..v]/80);
			elseif i==2 then
				len=len+math.floor(p["最大"..v]/4);
			end
			lib.Background(cx+size*2.5,cy+2,cx+size*2.5+len,cy+18,128);
			lib.SetClip(cx+size*2.5,cy,cx+size*2.5+len*p[v]/p["最大"..v],cy+24);
			lib.PicLoadCache(4,pic*2,cx+size*2.5,cy+2,1);
			lib.SetClip(0,0,0,0);
			DrawNumPic(cx+size*2.5+40,cy+4,p[v],p["最大"..v]);
			cy=cy+size+2;
		end
		for i,v in pairs({"攻击","精神","防御","敏捷","运气"}) do
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
			DrawYJZBox(480,355,JY.Item[mid]["说明"],C_WHITE,size2);
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
					oid=p["武器"];
					p["武器"]=0;
				elseif i==8 then
					oid=p["防具"];
					p["防具"]=0;
				elseif i==9 then
					oid=p["辅助"];
					p["辅助"]=0;
				end
				if oid>0 then
					JY.Base["物品数量"..oid]=1;
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
						if JY.Item[mid]["类型"]==11 then
							oid=p["武器"];
							p["武器"]=mid;
						elseif JY.Item[mid]["类型"]==21 then
							oid=p["防具"];
							p["防具"]=mid;
						elseif JY.Item[mid]["类型"]==31 then
							oid=p["辅助"];
							p["辅助"]=mid;
						end
						if oid>0 then
							JY.Base["物品数量"..oid]=1;
						end
						JY.Base["物品数量"..mid]=0;
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
							DrawYJZBox(-1,-1,"无法使用．",C_WHITE);
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
	local c_num = {[0]="零","一","二","三","四","五","六","七","八","九","十","十一","十二"};
	local year=JY.Base["当前年"];
	local month=JY.Base["当前月"];
	local str="";
	if year>999 then
		str="－－－";
	else
		str=c_num[math.floor(year/100)]..c_num[math.floor((year%100)/10)]..c_num[year%10]
	end
	str=str.."年 "..c_num[month].."月"
	return str;
end
function chinese_number(i)
	local c_digit = { [0]="零","十","百","千","万","亿","兆" };
	local c_num = {[0]="零","一","二","三","四","五","六","七","八","九","十"};
	local sym_tian = { [0]="甲","乙","丙","丁","戊","己","庚","辛","壬","癸" };
	local sym_di = { [0]="子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥" };
	if (i < 0) then
		return "负" .. chinese_number(-i);
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
		local id1,id2=JY.Connection[i]["都市1"],JY.Connection[i]["都市2"];
		local ncid=0;
		if id1==cid then
			ncid=id2;
		elseif id2==cid then
			ncid=id1;
		end
		if ncid>0 and JY.City[ncid]["接壤"]==0 then
			JY.City[ncid]["接壤"]=1;
			local nfid=JY.City[ncid]["势力"];
			if nfid==fid then
				ConnectCity_sub(ncid,fid);
			end
		end
	end
end
function ConnectCity()
	local fid=JY.FID;
	local cid=JY.Base["当前城池"];
	for i=1,JY.CityNum-1 do
		JY.City[i]["接壤"]=0;
	end
	JY.City[cid]["接壤"]=1;
	ConnectCity_sub(cid,fid);
end
function GetPath(cid_atk,cid_def)
	for i=1,JY.ConnectionNum-1 do
		if JY.Connection[i]["都市1"]==cid_atk and JY.Connection[i]["都市2"]==cid_def then
			return i;
		end
	end
	return 0;
end
