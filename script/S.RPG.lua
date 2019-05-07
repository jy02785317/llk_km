function SRPG()
	local step=4;
	JY.ReFreshTime=lib.GetTime();
	DrawWarMap(War.CX,War.CY);
	Light();
	ReFresh();
	WarCheckStatus();
	local WEA={[0]="晴","晴","晴","雲","雨","雨","？"}
  local restFlag = false;
	while JY.Status==GAME_WMAP and War.Turn<=War.MaxTurn do
		--第X回合 X
		WarDrawStrBoxDelay(string.format('第%d回合 %s',War.Turn,WEA[War.Weather]),C_WHITE);
		WarCheckStatus();
		--我军操作
		if JY.Status==GAME_WMAP then
			WarDrawStrBoxDelay('玩家军队状况',C_WHITE);
      --恢复
      if restFlag then
        WarRest(0);
        restFlag = false;
      end
			War.ControlStatus='select';
		end
		while JY.Status==GAME_WMAP do
			JY.ReFreshTime=lib.GetTime();
			DrawWarMap(War.CX,War.CY);
			if CC.Debug==1 then
				DrawString(8,CC.ScreenH-24,string.format("%d,%d",War.MX,War.MY),C_WHITE,16);
			end
			ReFresh();
			if opn() then
				break;
			end
		end
		--AI行动
		if JY.Status==GAME_WMAP then
			War.ControlStatus='AI';
			AI();
		end
		
		War.Turn=War.Turn+1;	--回合+1
		if JY.Status==GAME_WMAP and War.Turn<=War.MaxTurn then
			--Weather
			local wea=math.random(6)-1;
			if War.Weather<wea then
				War.Weather=War.Weather+1;
			elseif War.Weather>wea then
				War.Weather=War.Weather-1;
			end
			if War.Weather==0 then
				War.Weather=5;
			elseif War.Weather==5 then
				War.Weather=0;
			end
			--全军可操作
			for i,v in pairs(War.Person) do
				if v.live then
					v.active=true;
					WarResetStatus(i);
				end
			end
      restFlag = true;
		end
	end
	if JY.Status==GAME_WMAP and War.Turn>War.MaxTurn then
		if War.Leader1==1 then
			WarLastWords(GetWarID(1));
			WarAction(18,GetWarID(1));
		end
		JY.Status=GAME_WARLOSE;
		if DoEvent(JY.EventID) then
			if JY.Status==GAME_WMAP or JY.Status==GAME_WARWIN then
				DoEvent(JY.EventID);
			end
		end
	end
	Dark();
end

function ReFresh(n)
	n=n or 1;
	local frame_t=CC.FrameNum*n;
	local t1,t2;
	t1=JY.ReFreshTime;
	t2=lib.GetTime();
	if CC.FPS or CC.Debug==1 then
		if t2-t1<frame_t then
			DrawString(4,4,string.format("[B]FPS=%d",30),C_WHITE,16);
		else
			DrawString(4,4,string.format("[B]FPS=%d",1050/(t2-t1)),C_WHITE,16);
		end
	end
	ShowScreen();
	if t2-t1<frame_t then
		lib.Delay(frame_t+t1-t2);
	end
end
function control()
	local eventtype,keypress,x,y=getkey();
	x,y=MOUSE.x,MOUSE.y;
	if eventtype==3 and keypress==3 then
		return -1;
	end
	local pid=0;
	if War.SelID>0 then
		pid=War.Person[War.SelID].id;
	elseif War.CurID>0 then
		pid=War.Person[War.CurID].id;
	elseif War.LastID>0 then
		pid=War.Person[War.LastID].id;
	end
	if MOUSE.EXIT() then
		PlayWavE(0);
		if WarDrawStrBoxYesNo('结束游戏吗？',C_WHITE) then
			WarDelay(CC.WarDelay);
			if WarDrawStrBoxYesNo('再玩一次吗？',C_WHITE) then
				WarDelay(CC.WarDelay);
				JY.Status=GAME_START;
			else
				WarDelay(CC.WarDelay);
				JY.Status=GAME_END;
			end
		end
	elseif War.CY>1 and MOUSE.HOLD(16+War.BoxWidth*1,32+War.BoxDepth*0,16+War.BoxWidth*(War.MW-1),32+War.BoxDepth*1) then
		War.CY=War.CY-1;
		War.MY=War.MY-1;
		MOUSE.enableclick=false;
	elseif War.CY<War.Depth-War.MD+1 and MOUSE.HOLD(16+War.BoxWidth*1,32+War.BoxDepth*(War.MD-1),16+War.BoxWidth*(War.MW-1),32+War.BoxDepth*War.MD) then
		War.CY=War.CY+1;
		War.MY=War.MY+1;
		MOUSE.enableclick=false;
	elseif War.CX>1 and MOUSE.HOLD(16+War.BoxWidth*0,32+War.BoxDepth*1,16+War.BoxWidth*1,32+War.BoxDepth*(War.MD-1)) then
		War.CX=War.CX-1;
		War.MX=War.MX-1;
		MOUSE.enableclick=false;
	elseif War.CX<War.Width-War.MW+1 and MOUSE.HOLD(16+War.BoxWidth*(War.MW-1),32+War.BoxDepth*1,16+War.BoxWidth*War.MW,32+War.BoxDepth*(War.MD-1)) then
		War.CX=War.CX+1;
		War.MX=War.MX+1;
		MOUSE.enableclick=false;
	elseif MOUSE.HOLD(War.MiniMapCX,War.MiniMapCY,War.MiniMapCX+War.Width*4,War.MiniMapCY+War.Depth*4) then
		War.CX=limitX(math.modf((x-War.MiniMapCX)/4-War.MW/2)+1,1,War.Width-War.MW+1);
		War.CY=limitX(math.modf((y-War.MiniMapCY)/4-War.MD/2)+1,1,War.Depth-War.MD+1);
	elseif MOUSE.CLICK(820,92,884,172) then
		--[[
		if War.CurID>0 then
			War.MX=War.Person[War.CurID].x;
			War.MY=War.Person[War.CurID].y;
			War.CX=limitX(War.MX-math.modf(War.MW/2),1,War.Width-War.MW+1);
			War.CY=limitX(War.MY-math.modf(War.MD/2),1,War.Depth-War.MD+1);
		end
		]]--
		local name=JY.Person[pid]["姓名"];
		if type(CC.LieZhuan[name])=='string' then
			DrawLieZhuan(name);
		end
	elseif CC.Enhancement and pid>0 and MOUSE.CLICK(862,325,896,343) then
				if JY.Person[pid]["等级"]>=CC.SkillExp[JY.Person[pid]["成长"]][1] then
					DrawSkillStatus(JY.Person[pid]["特技1"])
				end
	elseif CC.Enhancement and pid>0 and MOUSE.CLICK(898,325,932,343) then
				if JY.Person[pid]["等级"]>=CC.SkillExp[JY.Person[pid]["成长"]][2] then
					DrawSkillStatus(JY.Person[pid]["特技2"])
				end
	elseif CC.Enhancement and pid>0 and MOUSE.CLICK(934,325,968,343) then
				if JY.Person[pid]["等级"]>=CC.SkillExp[JY.Person[pid]["成长"]][3] then
					DrawSkillStatus(JY.Person[pid]["特技3"])
				end
	elseif CC.Enhancement and pid>0 and MOUSE.CLICK(862,345,896,363) then
				if JY.Person[pid]["等级"]>=CC.SkillExp[JY.Person[pid]["成长"]][4] then
					DrawSkillStatus(JY.Person[pid]["特技4"])
				end
	elseif CC.Enhancement and pid>0 and MOUSE.CLICK(898,345,932,363) then
				if JY.Person[pid]["等级"]>=CC.SkillExp[JY.Person[pid]["成长"]][5] then
					DrawSkillStatus(JY.Person[pid]["特技5"])
				end
	elseif CC.Enhancement and pid>0 and MOUSE.CLICK(934,345,968,363) then
				if JY.Person[pid]["等级"]>=CC.SkillExp[JY.Person[pid]["成长"]][6] then
					DrawSkillStatus(JY.Person[pid]["特技6"])
				end
	elseif MOUSE.IN(16,32,16+War.BoxWidth*War.MW,32+War.BoxDepth*War.MD) and War.ControlStatus~="checkDX" then
		--x>16 and y>32 and mx>=0 and mx<War.MW and my>=0 and my<War.MD and War.ControlStatus~="checkDX" then
		local mx,my=math.modf((x-16)/War.BoxWidth),math.modf((y-32)/War.BoxDepth);
		War.InMap=true;
		War.MX=mx+War.CX;
		War.MY=my+War.CY;
		War.CurID=GetWarMap(War.MX,War.MY,2);
		if War.CurID>0 then
			War.LastID=War.CurID;
		end
		if MOUSE.CLICK(16+War.BoxWidth*mx+1,32+War.BoxDepth*my+1,16+War.BoxWidth*(mx+1)-1,32+War.BoxDepth*(my+1)-1) then
			return 2,x,y;
		else
			return 1,x,y;
		end
	else
		War.InMap=false;
	end
	return 0;
end
function BoxBack()
	if War.SelID>0 then
		War.MX=War.Person[War.SelID].x;
		War.MY=War.Person[War.SelID].y;
		local x,y;
		x=War.MX-math.modf(War.MW/2);
		y=War.MY-math.modf(War.MD/2);
		x=limitX(x,1,War.Width-War.MW+1);
		y=limitX(y,1,War.Depth-War.MD+1);
		if War.CX<x and War.MX>War.CX+War.MW-4 then
			for i=War.CX,x do
				War.CX=i;
				WarDelay();
			end
		elseif War.CX>x and War.MX<War.CX+3 then
			for i=War.CX,x,-1 do
				War.CX=i;
				WarDelay();
			end
		end
		if War.CY<y and War.MY>War.CY+War.MD-4 then
			for i=War.CY,y do
				War.CY=i;
				WarDelay();
			end
		elseif War.CY>y and War.MY<War.CY+3 then
			for i=War.CY,y,-1 do
				War.CY=i;
				WarDelay();
			end
		end
		War.InMap=true;
		War.CurID=War.SelID;
		--War.CurID=0;
		WarDelay(CC.WarDelay);
	end
end
function opn()
	local event,x,y=control();
	if War.ControlStatus=="select" then
		if event>0 then
			if between(x,16,79) and between(y,8,23) then
				War.FunButtom=1;
			else
				War.FunButtom=0;
			end
		end
		if event==-1 then
			return ESCMenu();
		elseif event==2 then
			if War.CurID>0 then	--选择人
				if War.Person[War.CurID].enemy and CC.Debug==0 then
          War.ControlStatus = 'warning';
					PlayWavE(2);
					JY.ReFreshTime=lib.GetTime();
					War.SelID=War.CurID;
					CleanWarMap(4,0);
					CleanWarMap(10,0);
					War_CalMoveStep(War.CurID,War.Person[War.CurID].movestep);
					War_CalAtkFW(War.CurID);
					DrawWarMap();
					ReFresh();
					WarDrawStrBoxWaitKey('不是我军部队．',C_WHITE);
					CleanWarMap(4,1);
					CleanWarMap(10,0);
					War.SelID=0;
          War.ControlStatus = "select";
				elseif War.Person[War.CurID].friend and CC.Debug==0 then
          War.ControlStatus = 'warning';
					PlayWavE(2);
					JY.ReFreshTime=lib.GetTime();
					War.SelID=War.CurID;
					CleanWarMap(4,0);
					CleanWarMap(10,0);
					War_CalMoveStep(War.CurID,War.Person[War.CurID].movestep);
					War_CalAtkFW(War.CurID);
					DrawWarMap();
					ReFresh();
					WarDrawStrBoxWaitKey('不能操作的部队．',C_WHITE);
					CleanWarMap(4,1);
					CleanWarMap(10,0);
					War.SelID=0;
          War.ControlStatus = "select";
				elseif not War.Person[War.CurID].active and CC.Debug==0 then
          War.ControlStatus = 'warning';
					PlayWavE(2);
					JY.ReFreshTime=lib.GetTime();
					War.SelID=War.CurID;
					CleanWarMap(4,0);
					CleanWarMap(10,0);
					War_CalMoveStep(War.CurID,War.Person[War.CurID].movestep);
					War_CalAtkFW(War.CurID);
					DrawWarMap();
					ReFresh();
					WarDrawStrBoxWaitKey('命令已执行完毕．',C_WHITE);
					CleanWarMap(4,1);
					CleanWarMap(10,0);
					War.SelID=0;
          War.ControlStatus = "select";
				elseif War.Person[War.CurID].troubled and CC.Debug==0 then
          War.ControlStatus = 'warning';
					PlayWavE(2);
					JY.ReFreshTime=lib.GetTime();
					War.SelID=War.CurID;
					CleanWarMap(4,0);
					CleanWarMap(10,0);
					War_CalMoveStep(War.CurID,War.Person[War.CurID].movestep);
					War_CalAtkFW(War.CurID);
					DrawWarMap();
					ReFresh();
					WarDrawStrBoxWaitKey('混乱中不听指挥．',C_WHITE);
					CleanWarMap(4,1);
					CleanWarMap(10,0);
					War.SelID=0;
          War.ControlStatus = "select";
				else
					PlayWavE(0);
					War.SelID=War.CurID;
					CleanWarMap(4,0);
					CleanWarMap(10,0);
					War_CalMoveStep(War.CurID,War.Person[War.CurID].movestep);
					War_CalAtkFW(War.CurID);
					War.ControlStatus="move";
				end
			elseif War.InMap then	--非人，但是在地图范围内
				PlayWavE(0);
				War.DXpic=lib.SaveSur(16+War.BoxWidth*(War.MX-War.CX),32+War.BoxDepth*(War.MY-War.CY),16+War.BoxWidth*(War.MX-War.CX+1),32+War.BoxDepth*(War.MY-War.CY+1));
				--War.ControlStatus="checkDX";
				while true do
					JY.ReFreshTime=lib.GetTime();
					DrawWarMap();
					WarCheckDX();
					ReFresh();
					local eventtype,keypress=getkey();
					if (eventtype==3 and keypress==3) or MOUSE.CLICK(16,32,16+War.BoxWidth*War.MW,32+War.BoxDepth*War.MD) then
						break;
					end
				end
				PlayWavE(1);
				lib.FreeSur(War.DXpic);
			end
		end
	elseif War.ControlStatus=="checkDX" then
		if event==2 or event==-1 then
			PlayWavE(1);
			lib.FreeSur(War.DXpic);
			War.ControlStatus = "select";
		end
	elseif War.ControlStatus=="move" then
		if event==2 then
			if not War.InMap then	--不在地图范围内
				
			elseif War.Person[War.SelID].enemy and CC.Debug==0 then
				--不是我军部队．
        War.ControlStatus = 'warning';
				PlayWavE(2);
				WarDrawStrBoxWaitKey('不是我军部队．',C_WHITE);
				War.SelID=0;
				War.ControlStatus="select";
				CleanWarMap(4,1);
				CleanWarMap(10,0);
			elseif War.Person[War.SelID].friend and CC.Debug==0 then
				--不能操作的部队．
        War.ControlStatus = 'warning';
				PlayWavE(2);
				WarDrawStrBoxWaitKey('不能操作的部队．',C_WHITE);
				War.SelID=0;
				War.ControlStatus="select";
				CleanWarMap(4,1);
				CleanWarMap(10,0);
			elseif GetWarMap(War.MX,War.MY,4)==0 or (GetWarMap(War.MX,War.MY,2)>0 and GetWarMap(War.MX,War.MY,2)~=War.SelID) then
				--不是在移动范围里．
        War.ControlStatus = 'warning';
				PlayWavE(2);
				WarDrawStrBoxWaitKey('不是在移动范围里．',C_WHITE);
        War.ControlStatus = "move"
			else
				CleanWarMap(10,0);
				PlayWavE(0);
				War.OldX=War.Person[War.SelID].x;
				War.OldY=War.Person[War.SelID].y;
				War_MovePerson(War.MX,War.MY);
				War.ControlStatus="actionMenu";
				CleanWarMap(4,1);
			end
		elseif event==-1 then
			PlayWavE(1);
			War.SelID=0;
			War.ControlStatus="select";
			CleanWarMap(4,1);
			CleanWarMap(10,0);
		end
	elseif War.ControlStatus=="actionMenu" then
		local scl=War.SelID;
		local pid=War.Person[scl].id;
		BoxBack();
		local menux,menuy=0,0;
		local mx=War.Person[War.SelID].x;
		local my=War.Person[War.SelID].y;
		if mx-War.CX>math.modf(War.MW/2) then
			menux=16+War.BoxWidth*(mx-War.CX)-80;
		else
			menux=16+War.BoxWidth*(mx-War.CX+1);
		end
		local m = {
					{"  攻击",nil,1},
					{"  乱射",nil,0},
					{"  天变",nil,0},
					{"  大喝",nil,0},
					{"  保留",nil,0},
					{"  保留",nil,0},
					{"  保留",nil,0},
					{"  保留",nil,0},
					{"  保留",nil,0},
					{"  保留",nil,0},
					{"  策略",WarMagicMenu,1},
					{"  道具",WarItemMenu,1},
					{"  休息",nil,1},
					{"  Lv+1",nil,0},
					{"  Lv-1",nil,0},
					{"兵种变更",nil,0},
				}
		local menu_num=4;
		if CC.Debug==1 then
			m[14][3]=1;
			m[15][3]=1;
			m[16][3]=1;
			menu_num=menu_num+3;
		end
		if (between(War.Person[scl].bz,4,6) or War.Person[scl].bz==22) and WarCheckSkill(scl,44) then	--乱射
			m[2][1]="  "..JY.Skill[44]["名称"];
			m[2][3]=1;
			menu_num=menu_num+1;
		end
		if not (between(War.Person[scl].bz,4,6) or between(War.Person[scl].bz,21,22)) and WarCheckSkill(scl,48) then	--乱舞
			m[2][1]="  "..JY.Skill[48]["名称"];
			if m[2][3]==0 then
				menu_num=menu_num+1;
			end
			m[2][3]=1;
		end
		if WarCheckSkill(scl, 5) then	--天变
			m[3][3] = 1;
			menu_num = menu_num + 1;
		end
		if WarCheckSkill(scl, 73) then	--大喝
			m[4][3] = 1;
			menu_num = menu_num + 1;
		end
		menuy=math.min(32+War.BoxDepth*(my-War.CY),CC.ScreenH-32-24*menu_num);
		local r=WarShowMenu(m,16,0,menux,menuy,0,0,1,1,16,C_WHITE,C_WHITE);
		WarDelay(CC.WarDelay);
		if r == 1 then
			WarSetAtkFW(War.SelID,War.Person[War.SelID].atkfw);
			--War.ControlStatus="selectAtk";
			local eid=WarSelectAtk(false,11);
			if eid>0 then
				WarAtk(scl,eid);
				WarResetStatus(eid);
				--反击
				if JY.Person[War.Person[eid].id]["兵力"]>0 and (not War.Person[eid].troubled) then
					--只有贼兵（山贼、恶贼、义贼）和武术家能反击敌军的物理攻击。
					--敌军兵种为骑兵、贼兵、猛兽兵团、武术家、异民族时，才可能产生反击。敌军兵种为步兵、弓兵、军乐队、妖术师、运输队时，不可能发生反击。
					local fj_flag=false;
					if JY.Bingzhong[War.Person[eid].bz]["可反击"]==1 and JY.Bingzhong[War.Person[scl].bz]["被反击"]==1 then
						fj_flag=true;
					elseif CC.Enhancement then
						if WarCheckSkill(eid,42) then	--反击(特技)
							fj_flag=true;
						end
					end
					if fj_flag then
						--检查是否在攻击范围内
						fj_flag=false;
						local fj_arrary=WarGetAtkFW(War.Person[eid].x,War.Person[eid].y,War.Person[eid].atkfw);
						for n=1,fj_arrary.num do
							if between(fj_arrary[n][1],1,War.Width) and between(fj_arrary[n][2],1,War.Depth) then
								if GetWarMap(fj_arrary[n][1],fj_arrary[n][2],2)==scl then
									fj_flag=true;
									break;
								end
							end
						end
					end
					
					if fj_flag then
						--反击概率＝我军武将武力÷150
						if CC.Enhancement and WarCheckSkill(eid,19)	then	--报复
							if math.random(100)<=JY.Person[War.Person[eid].id]["武力2"] then
								WarAtk(eid,scl,1);
								WarResetStatus(scl);
							end
						else
							if math.random(150)<=JY.Person[War.Person[eid].id]["武力2"] then
								WarAtk(eid,scl,1);
								WarResetStatus(scl);
							end
						end
					end
				end
				--
				if War.Person[scl].live then
					War.Person[scl].active=false;
					War.Person[scl].action=0;
				end
				WarResetStatus(scl);
				War.SelID=scl;
				WarCheckStatus();
				War.LastID=scl;
				War.CurID=0;
				War.SelID=0;
				War.ControlStatus="select";
				return CheckActive();
			end
		elseif r == 2 then
			--War_CalAtkFW(scl);
			local skillid=44;
			if m[2][1]=="  "..JY.Skill[48]["名称"] then
				skillid=48;
			end
			WarSetAtkFW(scl,War.Person[scl].atkfw);
			WarDelay(CC.WarDelay);
			if WarDrawStrBoxYesNo(string.format("%s将使用技能『%s』，可以吗？",JY.Person[pid]["姓名"],JY.Skill[skillid]["名称"]),C_WHITE) then
				--CleanWarMap(10,0);
				CleanWarMap(4,1);
				local atkarray=WarGetAtkFW(War.Person[scl].x,War.Person[scl].y,War.Person[scl].atkfw);
				local eidarray={};
				local eidnum=0;
				for i=1,atkarray.num do
					local ex=atkarray[i][1];
					local ey=atkarray[i][2];
					if between(ex,1,War.Width) and between(ey,1,War.Depth) then
						local eid=GetWarMap(ex,ey,2);
						if eid>0 then
							if War.Person[scl].enemy~=War.Person[eid].enemy then
								if (not War.Person[eid].hide) and War.Person[eid].live then
									eidnum=eidnum+1;
									eidarray[eidnum]=eid;
								end
							end
						end
					end
				end
				if eidnum==0 then
					PlayWavE(2);
					WarDrawStrBoxWaitKey('攻击范围内没有敌军．',C_WHITE);
				else
					local n=math.random(2);
					if skillid==44 then
						n=n+math.modf(eidnum/2)+math.random(3)-math.random(4);
					elseif skillid==48 then
						n=n+eidnum-1+math.random(3)-math.random(4);
					end
					n=limitX(n,2,JY.Skill[skillid]["参数1"]);
					for t=1,n do
						local eid,index;
						if eidnum==0 then
							break;
						elseif eidnum==1 then
							index=1;
						else
							index=math.random(eidnum);
						end
						eid=eidarray[index];
						if War.Person[eid].live and War.Person[scl].live and (not War.Person[scl].troubled) then
							if skillid==44 then
								WarAtk(scl,eid,2);
							elseif skillid==48 then
								WarAtk(scl,eid,3);
							end
							WarResetStatus(eid);
						end
						if not War.Person[eid].live then
							table.remove(eidarray,index);
							eidnum=eidnum-1;
						end
					end
					--
					if War.Person[scl].live then
						War.Person[scl].active=false;
						War.Person[scl].action=0;
					end
					WarResetStatus(scl);
					War.SelID=scl;
					WarCheckStatus();
					War.LastID=scl;
					War.CurID=0;
					War.SelID=0;
					War.ControlStatus="select";
					return CheckActive();
				end
			else
				--CleanWarMap(10,0);
				CleanWarMap(4,1);
			end
		elseif r == 3 then
			WarDelay(CC.WarDelay);
			if WarDrawStrBoxYesNo(JY.Person[pid]["姓名"].."将使用技能『天变』，可以吗？",C_WHITE) then
				local wzmenu={
								{"   晴",nil,1},
								{"   雲",nil,1},
								{"   雨",nil,1},
							};
				if between(War.Weather,0,2) then
					wzmenu[1][3]=0;
				elseif between(War.Weather,4,5) then
					wzmenu[3][3]=0;
				else
					wzmenu[2][3]=0;
				end
				local r=ShowMenu(wzmenu,3,0,0,0,0,0,1,1,16,C_WHITE,C_WHITE);
				if r>0 then
					local str1={"万能的神灵啊！*答应我们的祈求，改变天气吧！",
								"向上天传达我们的心愿，*请满足我们的愿望，*出现我们所期待的天气吧．",
								"开始变天了．*全体将士注意，*准备行动．",
								"准备进行祈雨．*全体站好，现在开始祈雨．",
								"上天啊！听听我的呼声吧！*下场大雨，施恩人间吧！"}
					local str2={"大家看见了吧？*这就是我的秘术！*平日修炼的成果．",
								"成功了！*这就是超常人的能力，*能控制天气的神奇力量！",
								"进行的很顺利，*大家对此都很惊讶！",
								"大雨倾盆而下．",
								"哈！大雨！*老天开眼了，*老天站在我们这边．"}
					if r==3 then
						talk(pid,str1[math.random(5)]);
					else
						talk(pid,str1[math.random(3)]);
					end
					if math.random(100)<JY.Person[pid]["智力2"] then
						if r==1 then
							War.Weather=math.random(3)-1;
						elseif r==2 then
							War.Weather=3;
						else
							War.Weather=math.random(2)+3;
						end
						PlayWavE(11);
						WarDrawStrBoxWaitKey('成功了．',C_WHITE);
						if r==3 then
							talk(pid,str2[math.random(5)]);
						else
							talk(pid,str2[math.random(3)]);
						end
					else
						PlayWavE(2);
						WarDrawStrBoxWaitKey('失败了．',C_WHITE);
					end
					--
					WarAddExp(scl, 4);
					--WarAddExp(scl,8);
					War.Person[scl].active=false;
					War.Person[scl].action=0;
					WarResetStatus(scl);
					War.SelID=scl;
					WarCheckStatus();
					War.LastID=scl;
					War.CurID=0;
					War.SelID=0;
					War.ControlStatus="select";
					return CheckActive();
				end
			end
		elseif r == 4 then  --大喝
			WarSetAtkFW(scl, 3);
			WarDelay(CC.WarDelay);
			if WarDrawStrBoxYesNo(JY.Person[pid]["姓名"] .. "将使用技能『大喝』，可以吗？", C_WHITE) then
        PlayWavE(87);
        talk(pid, "我乃" .. JY.Person[pid]["外号"] .."也，谁敢与我决一死战！");
				CleanWarMap(4, 1);
				local atkarray = WarGetAtkFW(War.Person[scl].x, War.Person[scl].y, 3);
				for i = 1, atkarray.num do
					local ex = atkarray[i][1];
					local ey = atkarray[i][2];
					if between(ex, 1, War.Width) and between(ey, 1, War.Depth) then
						local eid = GetWarMap(ex, ey, 2);
						if eid > 0 then
							if War.Person[scl].enemy ~= War.Person[eid].enemy then
								if (not War.Person[eid].hide) and War.Person[eid].live then
                  local id2 = War.Person[eid].id;
                  local sq_hurt = (JY.Person[pid]["武力2"] - JY.Person[id2]["武力2"]);
                  if sq_hurt <= 1 then
                    sq_hurt = 1;
                  elseif sq_hurt <= 10 then
                    sq_hurt = sq_hurt;
                  elseif sq_hurt <= 30 then
                    sq_hurt = 10 + math.ceil((sq_hurt - 10) / 2);
                  elseif sq_hurt <= 60 then
                    sq_hurt = 20 + math.ceil((sq_hurt - 30) / 3);
                  else
                    sq_hurt = 30 + math.ceil((sq_hurt - 60) / 4);
                  end
                  sq_hurt = math.min(sq_hurt, JY.Person[id2]["士气"])
									PlayWavE(88);
                  War.Person[eid].hurt = sq_hurt;
                  WarDelay(8);
                  War.Person[eid].hurt = -1;
                  local t = 16;
                  t = math.min(16, math.floor(math.max(2, math.abs(sq_hurt))));
                  local oldsq = JY.Person[id2]["士气"];
                  for i = 1, t do
                    JY.Person[id2]["士气"] = oldsq - sq_hurt * i / t;
                    JY.ReFreshTime = lib.GetTime();
                    DrawWarMap();
                    DrawStatusMini(eid);
                    lib.GetKey();
                    ReFresh();
                  end
                  JY.ReFreshTime = lib.GetTime();
                  ReFresh(CC.OpearteSpeed * 4);
                  WarDelay(4);
                  
                  if (math.random(50) + 10 < sq_hurt) or (JY.Person[id2]["士气"] < 50 and math.random(5) < 3) then
                    if War.Person[eid].troubled then
                      WarDrawStrBoxDelay(JY.Person[id2]["姓名"] .. "更加混乱了！", C_WHITE);
                    else
                      War.Person[eid].troubled = true
                      War.Person[eid].action = 7;
                      WarDelay(2);
                      WarDrawStrBoxDelay(JY.Person[id2]["姓名"] .. "混乱了！", C_WHITE);
                    end
                  end
                  ReSetAttrib(id2, false);
                  
                  
								end
							end
						end
					end
				end
        WarAddExp(scl, 4);
        War.Person[scl].active = false;
        War.Person[scl].action = 0;
        WarResetStatus(scl);
        War.SelID = scl;
        WarCheckStatus();
        War.LastID = scl;
        War.CurID = 0;
        War.SelID = 0;
        War.ControlStatus = "select";
        return CheckActive();
			else
				--CleanWarMap(10,0);
				CleanWarMap(4,1);
			end
    elseif r == 11 then	--策略
			War.Person[scl].active=false;
			War.Person[scl].action=0;
			WarResetStatus(scl);
			War.SelID=scl;
			WarCheckStatus();
			War.LastID=scl;
			War.CurID=0;
			War.SelID=0;
			War.ControlStatus="select";
			WarDelay(CC.WarDelay);
			return CheckActive();
		elseif r == 12 then	--道具
			War.Person[scl].active=false;
			War.Person[scl].action=0;
			WarResetStatus(scl);
			War.SelID=scl;
			WarCheckStatus();
			War.LastID=scl;
			War.CurID=0;
			War.SelID=0;
			War.ControlStatus="select";
			WarDelay(CC.WarDelay);
			return CheckActive();
		elseif r == 13 then	--休息
			--if CC.Debug~=1 then
			War.Person[scl].active=false;
			--end
			War.Person[scl].action=0;
			WarResetStatus(scl);
			War.SelID=scl;
			WarCheckStatus();
			War.LastID=scl;
			War.CurID=0;
			War.SelID=0;
			War.ControlStatus="select";
			WarDelay(CC.WarDelay);
			return CheckActive();
		elseif r == 14 then
			JY.Person[pid]["等级"]=limitX(JY.Person[pid]["等级"]+1,1,99);
			--WarLvUp(scl)
			ReSetAttrib(pid,false);
			--WarCheckStatus();
			--War.SelID=scl;
		elseif r == 15 then
			JY.Person[pid]["等级"]=limitX(JY.Person[pid]["等级"]-10,1,99);
			ReSetAttrib(pid,false);
			--WarCheckStatus();
		elseif r == 16 then
			local bz=War.Person[scl].bz;
			local bzmenu={};
			for index=1,JY.BingzhongNum-1 do
				bzmenu[index]={fillblank(JY.Bingzhong[index]["名称"],11),nil,0}
				if JY.Bingzhong[index]["有效"]==1 then
					bzmenu[index][3]=1;
				end
			end
			local r=ShowMenu(bzmenu,JY.BingzhongNum-1,8,0,0,0,0,6,1,16,C_WHITE,C_WHITE);
			if r>0 then
				bz=r;
				WarBingZhongUp(War.SelID,bz);
			end
		elseif r == 0 then
			CleanWarMap(4,1);
			CleanWarMap(10,0);
			SetWarMap(War.Person[scl].x,War.Person[scl].y,2,0);
			SetWarMap(War.OldX,War.OldY,2,War.SelID);
			War.Person[scl].x=War.OldX;
			War.Person[scl].y=War.OldY;
			BoxBack();
			ReSetAttrib(pid,false);
			War.SelID=0;
			War.ControlStatus="select";
		end
	else	--异常控制状态回复
		War.ControlStatus="select";
	end
	return false;
end
function WarSelectAtk(flag,fw)
	--flag true: select us or friend
	--flag fasle: select enemy
	flag=flag or false;
	fw=fw or 0;
	local tmp=JY.MenuPic.num;
	JY.MenuPic.num=0;
	while true do
		JY.ReFreshTime=lib.GetTime();
		DrawWarMap(War.CX,War.CY);
		ReFresh()
		local event,x,y=control();
		if event==1 then
			CleanWarMap(10,0);
			if GetWarMap(War.MX,War.MY,4)>0 and fw>0 then
				local array=WarGetAtkFW(War.MX,War.MY,fw);
				for i=1,array.num do
					local mx,my=array[i][1],array[i][2];
					if between(mx,1,War.Width) and between(my,1,War.Depth) then
						if flag then
							SetWarMap(mx,my,10,2);
						else
							SetWarMap(mx,my,10,1);
						end
					end
				end
			end
		elseif event==2 then
			--if not War.InMap then	--地图范围外
				
			--else
			if GetWarMap(War.MX,War.MY,4)>0 then
				local eid=GetWarMap(War.MX,War.MY,2);
				if eid>0 then--and eid~=War.SelID then
					if flag then	--select us or friend
						if War.Person[eid].enemy==War.Person[War.SelID].enemy then
							PlayWavE(0);
							CleanWarMap(4,1);
							CleanWarMap(10,0);
							BoxBack();
							JY.MenuPic.num=tmp;
							return eid;
						else
							PlayWavE(2);
							WarDrawStrBoxWaitKey('是敌方部队．',C_WHITE);
						end
					else	--select enemy
						if War.Person[eid].enemy~=War.Person[War.SelID].enemy then
							PlayWavE(0);
							CleanWarMap(4,1);
							CleanWarMap(10,0);
							BoxBack();
							JY.MenuPic.num=tmp;
							return eid;
						else
							PlayWavE(2);
							WarDrawStrBoxWaitKey('不能攻击我方．',C_WHITE);
						end
					end
				else
					PlayWavE(2);
					--WarDrawStrBoxWaitKey('没有敌人．',C_WHITE);
				end
			else
				PlayWavE(2);
				if flag then
					WarDrawStrBoxWaitKey('不在范围内．',C_WHITE);
				else
					WarDrawStrBoxWaitKey('不在攻击范围内．',C_WHITE);
				end
			end
		elseif event==-1 then
			PlayWavE(1);
			CleanWarMap(4,1);
			CleanWarMap(10,0);
			BoxBack();
			JY.MenuPic.num=tmp;
			return 0;
		end
	end
	JY.MenuPic.num=tmp;
end
function WarCheckDX()
		local menux,menuy;
		local dx=GetWarMap(War.MX,War.MY,1);
			--size = 16
			--w/h = 112 / 60
		if War.MX-War.CX>math.modf(War.MW/2) then
			menux=16+War.BoxWidth*(War.MX-War.CX)-136;
		else
			menux=16+War.BoxWidth*(War.MX-War.CX+1);
		end
		if War.MY-War.CY>math.modf(War.MD/2) then
			menuy=32+War.BoxWidth*(War.MY-War.CY)-40;
		else
			menuy=32+War.BoxWidth*(War.MY-War.CY);
		end
		lib.Background(menux,menuy,menux+136,menuy+86,160);
		menux=menux+8;
		menuy=menuy+8;
		lib.LoadSur(War.DXpic,menux,menuy);
		DrawGameBox(menux,menuy,menux+War.BoxWidth,menuy+War.BoxDepth,C_WHITE,-1);
		DrawString(menux+56,menuy+8,"防御效果",C_WHITE,16);
		local T={[0]="０％","２０％","３０％","－％","０％","－％","０％","５％",
					"５％","－％","－％","０％","－％","３０％","１０％","０％",
					"０％","－％","－％","－％",}
		DrawString(menux+88-#T[dx]*4,menuy+32,T[dx],C_WHITE,16);
--森林  20  山地  30   村庄   5
--草原   5  鹿寨  30  兵营  10
		--		00 平原  01 森林  02 山地  03 河流  04 桥梁  05  城墙  06  城池  07  草原
        --		08 村庄  09 悬崖  0A 城门  0B 荒地  0C 栅栏  0D 鹿砦  0E  兵营  0F  粮仓
        --		10 宝物库  11 房舍  12 火焰  13 浊流
		DrawString(menux,menuy+56,War.DX[dx],C_WHITE,16);
		if dx==8 or dx==13 or dx==14 then
			DrawString(menux+56,menuy+56,"有恢复",C_WHITE,16);
		end
		--村庄、鹿砦可以恢复士气和兵力．兵营可以恢复兵力，但不能恢复士气．
       --玉玺可以恢复兵力和士气，援军报告可以恢复兵力，赦命书可以恢复士气．
       --地形和宝物的恢复能力不能叠加，也就是说，处于村庄地形上再持有恢复性宝物，与没有持有恢复性宝物效果相同．但如果地形只能恢复兵力（如兵营），但宝物可以恢复兵力，这种情况下，兵力士气都能得到自动恢复．
end
function fillblank(s,num)
	local len=num-string.len(s);
	if len<=0 then
		return string.sub(s,1,num);
	else
		local left,right;
		left=math.modf(len/2);
		right=len-left;
		return string.format(string.format("%%%ds%%s%%%ds",left,right),"",s,"")
	end
end
function WarMagicMenu()
	local id=War.SelID;
	local pid=War.Person[id].id;
	local bz=JY.Person[pid]["兵种"];
	local lv=JY.Person[pid]["等级"];
	local menux,menuy=0,0;
	local menu_off=16;
	local mx=War.Person[id].x;
	local my=War.Person[id].y;
	if mx-War.CX>math.modf(War.MW/2) then
		menux=16+War.BoxWidth*(mx-War.CX)-104-menu_off;
	else
		menux=16+War.BoxWidth*(mx-War.CX+1)+menu_off;
	end
	local m={};
	local n=0;
	for i=1,JY.MagicNum-1 do
		--if between(JY.Bingzhong[bz]["策略"..i],1,lv) then
		if WarHaveMagic(id,i) then
			n=n+1;
			m[i]={fillblank(JY.Magic[i]["名称"],8)..string.format("% 2d",JY.Magic[i]["消耗"]),nil,1};
		else
			m[i]={"",nil,0};
		end
	end
	menuy=math.min(32+War.BoxDepth*(my-War.CY)+menu_off,CC.ScreenH-16-(16+8+20*math.min(n,8))-menu_off);
	local r;
	if n==0 then
		PlayWavE(2);
		WarDrawStrBoxWaitKey("没有可用策略．",C_WHITE);
		return 0;
	elseif n<=8 then
		r=WarShowMenu(m,JY.MagicNum-1,0,menux,menuy,0,0,5,1,16,C_WHITE,C_WHITE);
	else
		r=WarShowMenu(m,JY.MagicNum-1,8,menux,menuy,0,0,6,1,16,C_WHITE,C_WHITE);
	end
	if r>0 then
		if JY.Person[pid]["策略"]<JY.Magic[r]["消耗"] then
			PlayWavE(2);
			WarDrawStrBoxWaitKey("策略值不足．",C_WHITE);
		else
			local MenuPicNum=JY.MenuPic.num;
			JY.MenuPic.num=0;
			if WarMagicMenu_sub(id,r,false) then
				JY.Person[pid]["策略"]=JY.Person[pid]["策略"]-JY.Magic[r]["消耗"];
				JY.MenuPic.num=MenuPicNum;
				return 1;
			end
			JY.MenuPic.num=MenuPicNum;
		end
	end
	return 0;
end
function WarMagicMenu_sub(id,r,ItemFlag)
	local kind=JY.Magic[r]["类型"];
	if kind==1 then			--火系
		if between(War.Weather,4,5) then
			WarDrawStrBoxConfirm("雨天不能使用火攻．",C_WHITE);
		else
			WarDrawStrBoxDelay("用火攻攻击敌人．",C_WHITE);
			WarSetAtkFW(id,JY.Magic[r]["施展范围"]);
			local eid=WarSelectAtk(false,JY.Magic[r]["效果范围"]);
			if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) then
				if WarMagicCheck(id,eid,r) then
					WarDrawStrBoxDelay(JY.Magic[r]["名称"].."之计",C_WHITE);
					WarMagic(id,eid,r,ItemFlag);
					return true;
				else
					WarDrawStrBoxConfirm("敌人在森林、草原、平原、城池，*存在的场合才能使用．",C_WHITE);
				end
			end
		end
	elseif kind==2 then		--水系
		WarDrawStrBoxDelay("用水攻攻击敌人．",C_WHITE);
		WarSetAtkFW(id,JY.Magic[r]["施展范围"]);
		local eid=WarSelectAtk(false,JY.Magic[r]["效果范围"]);
		if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) then
			if WarMagicCheck(id,eid,r) then
				WarDrawStrBoxDelay(JY.Magic[r]["名称"].."之计",C_WHITE);
				WarMagic(id,eid,r,ItemFlag);
				return true;
			else
				WarDrawStrBoxConfirm("敌人在桥梁、平原，*存在的场合才能使用．",C_WHITE);
			end
		end
	elseif kind==3 then		--落石系
		WarDrawStrBoxDelay("用落石攻击敌人．",C_WHITE);
		WarSetAtkFW(id,JY.Magic[r]["施展范围"]);
		local eid=WarSelectAtk(false,JY.Magic[r]["效果范围"]);
		if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) then
			if WarMagicCheck(id,eid,r) then
				WarDrawStrBoxDelay(JY.Magic[r]["名称"].."之计",C_WHITE);
				WarMagic(id,eid,r,ItemFlag);
				return true;
			else
				WarDrawStrBoxConfirm("敌人在山地、荒地，*存在的场合才能使用．",C_WHITE);
			end
		end
	elseif kind==4 then		--假情报系
		WarDrawStrBoxDelay("使敌人混乱．",C_WHITE);
		WarSetAtkFW(id,JY.Magic[r]["施展范围"]);
		local eid=WarSelectAtk(false,JY.Magic[r]["效果范围"]);
		if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) then
			WarMagic(id,eid,r,ItemFlag);
			return true;
		end
	elseif kind==5 then		--牵制系
		WarDrawStrBoxDelay("重挫敌人士气．",C_WHITE);
		WarSetAtkFW(id,JY.Magic[r]["施展范围"]);
		local eid=WarSelectAtk(false,JY.Magic[r]["效果范围"]);
		if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) then
			WarMagic(id,eid,r,ItemFlag);
			return true;
		end
	elseif kind==6 then		--激励系
		WarDrawStrBoxDelay("恢复士气值．",C_WHITE);
		--恢复范围内的士气值部队．
		WarSetAtkFW(id,JY.Magic[r]["施展范围"]);
		local eid=WarSelectAtk(true,JY.Magic[r]["效果范围"]);
		if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) then
      local p = JY.Person[War.Person[eid].id];
      if JY.Magic[r]["效果范围"] == 11 and War.Person[eid].sq_limited <= p["士气"] and (not War.Person[eid].troubled) then
        WarDrawStrBoxConfirm("不能再恢复了．",C_WHITE);
      else
        WarMagic(id,eid,r,ItemFlag);
        return true;
      end
		end
	elseif kind==7 then		--援助系
		WarDrawStrBoxDelay("恢复兵力．",C_WHITE);
		--恢复范围内的兵力部队
		WarSetAtkFW(id,JY.Magic[r]["施展范围"]);
		local eid=WarSelectAtk(true,JY.Magic[r]["效果范围"]);
		if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) then
      local p = JY.Person[War.Person[eid].id];
      if JY.Magic[r]["效果范围"] == 11 and p["最大兵力"] <= p["兵力"] then
        WarDrawStrBoxConfirm("不能再恢复了．",C_WHITE);
      else
        WarMagic(id,eid,r,ItemFlag);
        return true;
      end
		end
	elseif kind==8 then		--看护系
		WarDrawStrBoxDelay("恢复兵力和士气值．",C_WHITE);
		WarSetAtkFW(id,JY.Magic[r]["施展范围"]);
		local eid=WarSelectAtk(true,JY.Magic[r]["效果范围"]);
		if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) then
      local p = JY.Person[War.Person[eid].id];
      if JY.Magic[r]["效果范围"] == 11 and p["最大兵力"] <= p["兵力"] and War.Person[eid].sq_limited <= p["士气"] and (not War.Person[eid].troubled) then
        WarDrawStrBoxConfirm("不能再恢复了．",C_WHITE);
      else
        WarMagic(id,eid,r,ItemFlag);
        return true;
      end
		end
	elseif kind==9 then		--毒系
		WarDrawStrBoxDelay("用毒攻击敌人．",C_WHITE);
		WarSetAtkFW(id,JY.Magic[r]["施展范围"]);
		local eid=WarSelectAtk(false,JY.Magic[r]["效果范围"]);
		if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) then
			if WarMagicCheck(id,eid,r) then
				WarDrawStrBoxDelay(JY.Magic[r]["名称"].."之计",C_WHITE);
				WarMagic(id,eid,r,ItemFlag);
				return true;
			else
				WarDrawStrBoxConfirm("未知错误引起的无法使用．",C_WHITE);
			end
		end
	elseif kind==10 then		--落雷系
		if between(War.Weather,3,5) then
			WarDrawStrBoxDelay("用落雷攻击敌人．",C_WHITE);
			WarSetAtkFW(id,JY.Magic[r]["施展范围"]);
			local eid=WarSelectAtk(false,JY.Magic[r]["效果范围"]);
			if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) then
				if WarMagicCheck(id,eid,r) then
					WarDrawStrBoxDelay(JY.Magic[r]["名称"].."之计",C_WHITE);
					WarMagic(id,eid,r,ItemFlag);
					return true;
				else
					WarDrawStrBoxConfirm("晴天不能使用落雷．",C_WHITE);
				end
			end
		else
			WarDrawStrBoxConfirm("晴天不能使用落雷．",C_WHITE);
		end
	elseif kind==11 then	--炸弹
		WarDrawStrBoxDelay("用炸弹攻击敌人．",C_WHITE);
		WarSetAtkFW(id,JY.Magic[r]["施展范围"]);
		local eid=WarSelectAtk(false,JY.Magic[r]["效果范围"]);
		if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) then
			if WarMagicCheck(id,eid,r) then
				WarDrawStrBoxDelay("投掷炸弹．",C_WHITE);
				WarMagic(id,eid,r,ItemFlag);
				return true;
			else
				WarDrawStrBoxConfirm("未知错误引起的无法使用．",C_WHITE);
			end
		end
	elseif kind == 12 then	--激将
		WarDrawStrBoxDelay("使部队再次行动．", C_WHITE);
		WarSetAtkFW(id, JY.Magic[r]["施展范围"]);
		local eid = WarSelectAtk(true, JY.Magic[r]["效果范围"]);
		if eid > 0 and War.Person[eid].live and (not War.Person[eid].hide) then
      local p = JY.Person[War.Person[eid].id];
      if false then
        WarDrawStrBoxConfirm("不能再恢复了．", C_WHITE);
      else
        WarMagic(id, eid, r, ItemFlag);
        return true;
      end
		end
	end
	return false;
end
function WarMagicHitRatio(wid,eid,mid)
	if between(JY.Magic[mid]["类型"],6,8) then
		return 1;
	end
	local p1=JY.Person[War.Person[wid].id];
	local p2=JY.Person[War.Person[eid].id];
	local a=p1["智力2"]*p1["等级"]/100+p1["智力2"];
	local b=(p2["智力2"]*p2["等级"]/100+p2["智力2"])/4;
	if CC.Enhancement then
		if JY.Magic[mid]["类型"]==2 and (WarCheckSkill(eid,3) or WarCheckSkill(eid,23)) then	--水神/藤甲
			a=1;
			b=2;
		end
		if JY.Magic[mid]["类型"]==1 and WarCheckSkill(eid,4) then	--火神
			a=1;
			b=2;
		end
		if JY.Magic[mid]["类型"]==4 and WarCheckSkill(eid,20) then	--沉着
			a=1;
			b=2;
		end
		if WarCheckSkill(wid,17) then	--神算
			--a=a+p1["智力"];
			a=a*2;
		end
		if WarCheckSkill(eid,18) then	--识破
			--b=b+p2["智力"]/4;
			b=b*2;
		end
	end
	if JY.Magic[mid]["类型"]==4 then
		b=b*2;
	end
	if p2["兵种"]==13 or p2["兵种"]==16 or p2["兵种"]==19 then
		--b=b*2;
		b=b*1.5;
	end
	local v=1-b/a;
	v=limitX(v,0,1);
	return v;
end
function WarMagic(wid,eid,mid,ItemFlag)
	ItemFlag=ItemFlag or false;
	local mx=War.Person[eid].x;
	local my=War.Person[eid].y;
	local d1,d2=WarAutoD(wid,eid);
	local atkarray=WarGetAtkFW(mx,my,JY.Magic[mid]["效果范围"]);
	War.Person[wid].action=2;
	War.Person[wid].frame=0;
	War.Person[wid].d=d1;
	WarDelay(4);
	PlayWavE(8);
	WarDelay(8);
	PlayWavE(39);
	WarDelay(12);
	War.Person[wid].action=0;
	for i=atkarray.num,1,-1 do
		local x,y=atkarray[i][1],atkarray[i][2];
		local id=GetWarMap(x,y,2);
		if id>0 and War.Person[id].live and (not War.Person[id].hide) then
			if War.Person[id].enemy==War.Person[eid].enemy then
			
			else
				table.remove(atkarray,i);
				atkarray.num=atkarray.num-1;
			end
		else
			table.remove(atkarray,i);
			atkarray.num=atkarray.num-1;
		end
	end
	
	
	for i=1,atkarray.num do
		local x,y=atkarray[i][1],atkarray[i][2];
		local id=GetWarMap(x,y,2);
		if id>0 and War.Person[id].live and (not War.Person[id].hide) then	--table.remove后必然为true
			if War.Person[id].enemy==War.Person[eid].enemy then	--table.remove后必然为true
				local id1=War.Person[wid].id;
				local id2=War.Person[id].id;
				local hitratio=WarMagicHitRatio(wid,id,mid);
				if ItemFlag then
					hitratio=1;
				end
				local hurt,sq_hurt,jy,jy2=WarMagicHurt(wid,id,mid,ItemFlag);
				d1,d2=WarAutoD(wid,id);
				if between(JY.Magic[mid]["类型"],6,8) then
					if JY.Magic[mid]["类型"]==6 then
						--基本士气恢复值＝策略基本威力＋补给方等级÷10
						--士气恢复随机修正值是一个随机整数，在0到（基本士气恢复值÷10－1）之间。
						--补给效果＝基本士气恢复值＋士气恢复随机修正值
						if ItemFlag then
							sq_hurt=JY.Magic[mid]["效果"];
						else
							sq_hurt=JY.Magic[mid]["效果"]+JY.Person[id1]["等级"]/10;
						end
						sq_hurt=math.modf(sq_hurt*(1+math.random()/10));
						sq_hurt=limitX(sq_hurt,0,War.Person[id].sq_limited-JY.Person[id2]["士气"]);
						hurt=-1;
						if atkarray.num==1 then
							WarDrawStrBoxDelay(JY.Person[id2]["姓名"].."的士气值上升．",C_WHITE);
						end
					elseif JY.Magic[mid]["类型"]==7 then
						--基本兵力恢复值＝策略基本威力＋补给方智力×补给方等级÷20
						--兵力恢复随机修正值是一个随机整数，在0到（基本兵力恢复值÷10－1）之间。
						--补给效果＝基本兵力恢复值＋兵力恢复随机修正值
						if ItemFlag then
							hurt=JY.Magic[mid]["效果"];
						else
							hurt=JY.Magic[mid]["效果"]+JY.Person[id1]["智力2"]*JY.Person[id1]["等级"]/20;
							if CC.Enhancement then
								if WarCheckSkill(eid,41) then	--补给
									hurt=math.modf(hurt*(100+JY.Skill[41]["参数1"])/100)
								end
							end
						end
						hurt=math.modf(hurt*(1+math.random()/10));
						hurt=limitX(hurt,0,JY.Person[id2]["最大兵力"]-JY.Person[id2]["兵力"]);
						sq_hurt=-1;
						if atkarray.num==1 then
							WarDrawStrBoxDelay(JY.Person[id2]["姓名"].."的兵力上升．",C_WHITE);
						end
					elseif JY.Magic[mid]["类型"]==8 then
						local hp={600,1200,1800};
						local sp={30,40,50};
						if ItemFlag then
							hurt=hp[JY.Magic[mid]["效果"]];
							sq_hurt=sp[JY.Magic[mid]["效果"]];
						else
							hurt=hp[JY.Magic[mid]["效果"]]+JY.Person[id1]["智力2"]*JY.Person[id1]["等级"]/20;
							sq_hurt=sp[JY.Magic[mid]["效果"]]+JY.Person[id1]["等级"]/10;
							if CC.Enhancement then
								if WarCheckSkill(eid,41) then	--补给
									hurt=math.modf(hurt*(100+JY.Skill[41]["参数1"])/100)
								end
							end
						end
						hurt=math.modf(hurt*(1+math.random()/10));
						hurt=limitX(hurt,0,JY.Person[id2]["最大兵力"]-JY.Person[id2]["兵力"]);
						sq_hurt=math.modf(sq_hurt*(1+math.random()/10));
						sq_hurt=limitX(sq_hurt,0,War.Person[id].sq_limited-JY.Person[id2]["士气"]);
						if atkarray.num==1 then
							WarDrawStrBoxDelay(JY.Person[id2]["姓名"].."的兵力和士气值上升．",C_WHITE);
						end
					end
					PlayMagic(mid,x,y,id1);
					if hurt>=0 then
						War.Person[id].hurt=hurt;
						WarDelay(8);
						War.Person[id].hurt=-1;
					end
					if sq_hurt>=0 then
						War.Person[id].hurt=sq_hurt;
						WarDelay(8);
						War.Person[id].hurt=-1;
					end
          if hurt > 0 or sq_hurt > 0 then
            local t=16;
            t=math.min(16,(math.modf(math.max(	2,math.abs(hurt)/50,math.abs(sq_hurt)))));
            local oldbl=JY.Person[id2]["兵力"];
            local oldsq=JY.Person[id2]["士气"];
            for ii=0,t do
              if hurt>0 then
                JY.Person[id2]["兵力"]=oldbl+hurt*ii/t;
              end
              if sq_hurt>0 then
                JY.Person[id2]["士气"]=oldsq+sq_hurt*ii/t;
              end
              JY.ReFreshTime=lib.GetTime();
              DrawWarMap();
              DrawStatusMini(id);
              lib.GetKey();
              ReFresh();
            end
            JY.ReFreshTime=lib.GetTime();
            ReFresh(CC.OpearteSpeed*4);
            WarDelay(4);
          end
					if JY.Magic[mid]["类型"]==6 or JY.Magic[mid]["类型"]==8 then
						WarTroubleShooting(id);
					end
					if i==atkarray.num then
						if atkarray.num>1 then
							if JY.Magic[mid]["类型"]==6 then
								if War.Person[id].enemy then
									WarDrawStrBoxDelay("敌军的士气值恢复了．",C_WHITE);
								else
									WarDrawStrBoxDelay("我军的士气值恢复了．",C_WHITE);
								end
							elseif JY.Magic[mid]["类型"]==7 then
								if War.Person[id].enemy then
									WarDrawStrBoxDelay("敌军的兵力恢复了．",C_WHITE);
								else
									WarDrawStrBoxDelay("我军的兵力恢复了．",C_WHITE);
								end
							elseif JY.Magic[mid]["类型"]==8 then
								if War.Person[id].enemy then
									WarDrawStrBoxDelay("敌军的兵力和士气值恢复了．",C_WHITE);
								else
									WarDrawStrBoxDelay("我军的兵力和士气值恢复了．",C_WHITE);
								end
							end
						end
						if (JY.Person[id1]["兵种"]==13 or JY.Person[id1]["兵种"]==19) then
							jy=12;
						else
							jy=8;
						end
						if not (War.Person[wid].enemy or ItemFlag) then
							WarAddExp(wid,jy);
						end
					end
					ReSetAttrib(id1,false);
					ReSetAttrib(id2,false);
					WarResetStatus(id);
				elseif JY.Magic[mid]["类型"]==4 then	--假情报系
					if math.random()<hitratio then
						jy=8;
						War.Person[id].action=4;
						War.Person[id].frame=0;
						War.Person[id].d=d2;
						PlayMagic(mid,x,y,id1);
						War.Person[id].hurt=-1;
						if War.Person[id].troubled then
							WarDelay(2);
							WarDrawStrBoxDelay(JY.Person[id2]["姓名"].."更加混乱了！",C_WHITE);
						else
							War.Person[id].troubled=true
							War.Person[id].action=7
							WarDelay(2);
							WarDrawStrBoxDelay(JY.Person[id2]["姓名"].."混乱了！",C_WHITE);
						end
					else
						jy=8;
						War.Person[id].action=3;
						War.Person[id].frame=0;
						War.Person[id].d=d2;
						PlayMagic(mid,x,y,id1);
						PlayWavE(81);
						WarDelay(8);
						War.Person[id].hurt=-1;
						WarDrawStrBoxDelay(JY.Person[id1]["姓名"].."的计谋失败了！",C_WHITE);
					end
					if i==atkarray.num then
						if not (War.Person[wid].enemy or ItemFlag) then
							WarAddExp(wid,jy);
						end
					end
					ReSetAttrib(id1,false);
					ReSetAttrib(id2,false);
					WarResetStatus(id);
					
				elseif JY.Magic[mid]["类型"]==5 then	--牵制系
					if math.random()<hitratio then
						hurt=0;
						--士气损伤＝策略基本士气损伤＋攻击方等级÷10－防御方等级÷10
						if ItemFlag then
							sq_hurt=math.modf(JY.Magic[mid]["效果"]-JY.Person[id2]["等级"]/10);
						else
							sq_hurt=math.modf(JY.Magic[mid]["效果"]+JY.Person[id1]["等级"]/10-JY.Person[id2]["等级"]/10);
						end
						sq_hurt=limitX(sq_hurt,0,JY.Person[id2]["士气"]);
						jy=8;
						War.Person[id].action=4;
						War.Person[id].frame=0;
						War.Person[id].d=d2;
						WarDrawStrBoxDelay(JY.Person[id2]["姓名"].."的士气值下降．",C_WHITE);
						PlayMagic(mid,x,y,id1);
						War.Person[id].hurt=sq_hurt;
						WarDelay(8);
						War.Person[id].hurt=-1;
						local t=16;
						t=math.min(16,(math.modf(math.max(2,math.abs(hurt)/50,math.abs(sq_hurt)))));
						local oldbl=JY.Person[id2]["兵力"];
						local oldsq=JY.Person[id2]["士气"];
						for i=1,t do
							JY.Person[id2]["兵力"]=oldbl-hurt*i/t;
							JY.Person[id2]["士气"]=oldsq-sq_hurt*i/t;
							JY.ReFreshTime=lib.GetTime();
							DrawWarMap();
							DrawStatusMini(eid);
							lib.GetKey();
							ReFresh();
						end
						JY.ReFreshTime=lib.GetTime();
						ReFresh(CC.OpearteSpeed*4);
						WarDelay(4);
						WarGetTrouble(id);
					else
						jy=8;
						War.Person[id].action=3;
						War.Person[id].frame=0;
						War.Person[id].d=d2;
						PlayMagic(mid,x,y,id1);
						War.Person[id].hurt=0;
						PlayWavE(81);
						WarDelay(8);
						War.Person[id].hurt=-1;
						WarDrawStrBoxDelay(JY.Person[id1]["姓名"].."的计谋失败了！",C_WHITE);
					end
					if i==atkarray.num then
						if not (War.Person[wid].enemy or ItemFlag) then
							WarAddExp(wid,jy);
						end
					end
					ReSetAttrib(id1,false);
					ReSetAttrib(id2,false);
					WarResetStatus(id);
				elseif JY.Magic[mid]["类型"] == 12 then	--激将系
          if math.random()<hitratio then
						War.Person[id].action = 6;
            PlayMagic(mid, x, y, id1);
						WarDelay(8);
						War.Person[id].d = 1;
						War.Person[id].action = 1;
						War.Person[id].frame = -1;
						War.Person[id].active = true;
            PlayWavE(83);
            PlayEFT(x, y, 255);
						WarDelay(8);
						WarDrawStrBoxDelay(JY.Person[id2]["姓名"].."可以再次行动了！", C_WHITE);
						if not (War.Person[wid].enemy) then
							WarAddExp(wid,jy2);
						end
						ReSetAttrib(id1, false);
						ReSetAttrib(id2, false);
						WarResetStatus(id);
          else
						War.Person[id].action = 3;
						War.Person[id].frame = 0;
						War.Person[id].d = d2;
						PlayMagic(mid, x, y, id1);
						PlayWavE(81);
						WarDelay(8);
						WarDrawStrBoxDelay(JY.Person[id1]["姓名"].."的计策失败了！", C_WHITE);
						if not (War.Person[wid].enemy) then
							WarAddExp(wid,jy2);
						end
						ReSetAttrib(id1, false);
						ReSetAttrib(id2, false);
						WarResetStatus(id);
          end
				elseif WarMagicCheck(wid,id,mid) then
					if math.random()<hitratio then
						War.Person[id].action=4;
						War.Person[id].frame=0;
						War.Person[id].d=d2;
						PlayMagic(mid,x,y,id1);
						War.Person[id].hurt=hurt;
						WarDelay(8);
						War.Person[id].hurt=-1;
						local t=16;
						t=math.min(16,(math.modf(math.max(2,math.abs(hurt)/50,math.abs(sq_hurt)))));
						local oldbl=JY.Person[id2]["兵力"];
						local oldsq=JY.Person[id2]["士气"];
						for i=1,t do
							JY.Person[id2]["兵力"]=oldbl-hurt*i/t;
							JY.Person[id2]["士气"]=oldsq-sq_hurt*i/t;
							JY.ReFreshTime=lib.GetTime();
							DrawWarMap();
							DrawStatusMini(id);
							lib.GetKey();
							ReFresh();
						end
						JY.ReFreshTime=lib.GetTime();
						ReFresh(CC.OpearteSpeed*4);
						WarDelay(4);
						WarGetTrouble(id);
						
						if CC.Enhancement then
							if JY.Magic[mid]["类型"]==3 then	--落石系
								if WarCheckSkill(wid,15) then	--落沙
									if math.random(100)<=JY.Skill[15]["参数1"] then
										if JY.Person[id2]["兵力"]>0 then
											if not War.Person[id].troubled then
												War.Person[id].troubled=true
												War.Person[id].action=7
												WarDelay(2);
												WarDrawStrBoxDelay(JY.Person[id2]["姓名"].."混乱了！",C_WHITE);
											end
										end
									end
								end
							end
						end
							
						if not (War.Person[wid].enemy) then
							WarAddExp(wid,jy);
						end
						ReSetAttrib(id1,false);
						ReSetAttrib(id2,false);
						WarResetStatus(id);
					else
						War.Person[id].action=3;
						War.Person[id].frame=0;
						War.Person[id].d=d2;
						PlayMagic(mid,x,y,id1);
						War.Person[id].hurt=0;
						PlayWavE(81);
						WarDelay(8);
						War.Person[id].hurt=-1;
						WarDrawStrBoxDelay(JY.Person[id1]["姓名"].."的计策失败了！",C_WHITE);
						if not (War.Person[wid].enemy) then
							WarAddExp(wid,jy2);
						end
						ReSetAttrib(id1,false);
						ReSetAttrib(id2,false);
						WarResetStatus(id);
					end
				end
			end
		end
	end
	WarResetStatus(wid);
end
function PlayMagic(mid,x,y,pid)
	if not War.PlayMagic then
		return;
	end
	local eft=JY.Magic[mid]["动画"];
	local str=JY.Person[pid]["姓名"]..'的策略';
	local rpt=2;
	if between(JY.Magic[mid]["类型"],4,8) then
		rpt=1;
	end
	PlayWavE(JY.Magic[mid]["音效"]);
  PlayEFT(x, y, eft, rpt, str);
end
function PlayEFT(x, y, eft, rpt, str)
  rpt = rpt or 2;
	local pic_w, pic_h = lib.PicGetXY(0, eft * 2);
	local frame = pic_h / pic_w;
	if eft == 241 then
		frame = 7;
	elseif eft == 242 then
		frame = 13;
	elseif eft == 243 then
		frame = 13;
	elseif eft == 246 or eft == 27 then
		frame = 14;
	end
	pic_h = pic_h / frame;
	local sx,sy;
	local sx = 16 + War.BoxWidth * (x - War.CX + 0.5) - pic_w / 2;
	local sy = 32 + War.BoxDepth * (y - War.CY + 1) - pic_h;
	for i = 1, frame do
		for n = 1, rpt do
			JY.ReFreshTime = lib.GetTime();
			DrawWarMap();
      if str then
        DrawYJZBox2(-256, 64, str, C_WHITE);
      end
			lib.SetClip(sx, sy, sx + pic_w, sy + pic_h);
			lib.PicLoadCache(0, eft * 2, sx, sy - pic_h * (i - 1), 1);
			lib.SetClip(0, 0, 0, 0);
			lib.GetKey();
			ReFresh();
		end
	end
end
function WarMagicCheck(wid,eid,mid)
	local kind=JY.Magic[mid]["类型"];
	local dx=GetWarMap(War.Person[eid].x,War.Person[eid].y,1);
	if between(kind,4,8) or kind==9 or kind==11 then
		return true;
	end
	--weather
	if kind==1 and between(War.Weather,4,5) then
		return false;
	end
	if kind==10 and between(War.Weather,3,5) then
		return true;
	end
	--dx
	if CC.Enhancement then
		if WarCheckSkill(wid,46) then	--地理
			return true;
		end
	end
	if kind==1 and (dx==0 or dx==1 or dx==6 or dx==7) then
		return true;
	end
	if kind==2 and (dx==0 or dx==4) then
		return true;
	end
	if kind==3 and (dx==2 or dx==11) then
		return true;
	end
	return false;
end
function WarMagicHurt(wid,eid,mid,ItemFlag)
	ItemFlag=ItemFlag or false;
	local id1=War.Person[wid].id;
	local id2=War.Person[eid].id;
	local p1=JY.Person[id1];
	local p2=JY.Person[id2];
	local hurt=JY.Magic[mid]["效果"];
	if ItemFlag then
		--hurt=hurt-(p2["智力"]*p2["等级"]/50+p2["智力"]);
		hurt=hurt-(p2["智力2"]*p2["等级"]/25+p2["智力2"]);
	else
		--hurt=hurt+(p1["智力"]*p1["等级"]/50+p1["智力"])*2-(p2["智力"]*p2["等级"]/50+p2["智力"]);
		hurt=hurt+(p1["智力2"]*p1["等级"]/25+p1["智力2"])*2-(p2["智力2"]*p2["等级"]/25+p2["智力2"]);
	end
	if p2["兵种"]==13 or p2["兵种"]==16 or p2["兵种"]==19 then
		hurt=hurt/2;
	end
	--[[
	如果被防御方在树林中，且策略是焦热系策略
		策略攻击杀伤＝策略攻击杀伤＋策略攻击杀伤÷4
	如果当前天气是雨天，且策略是漩涡系策略
		策略攻击杀伤＝策略攻击杀伤＋策略攻击杀伤÷4
	]]--
	local dx=GetWarMap(War.Person[eid].x,War.Person[eid].y,1);
	if JY.Magic[mid]["类型"]==1 and dx==1 then
		hurt=hurt*1.25;
	end
	if JY.Magic[mid]["类型"]==2 and between(War.Weather,4,5) then
		hurt=hurt*1.25;
	end
	if JY.Magic[mid]["类型"]==10 and between(War.Weather,4,5) then
		hurt=hurt*1.1;
	end
	local item_atk=0;
	if p1["武器"]>0 then
		item_atk=item_atk+JY.Item[p1["武器"]]["策略攻击"];
	end
	if p1["防具"]>0 then
		item_atk=item_atk+JY.Item[p1["防具"]]["策略攻击"];
	end
	if p1["辅助"]>0 then
		item_atk=item_atk+JY.Item[p1["辅助"]]["策略攻击"];
	end
	if item_atk~=0 then
		hurt=hurt*(100+item_atk)/100;
	end
	if CC.Enhancement then
		if JY.Magic[mid]["类型"]==1 and WarCheckSkill(wid,54) then	--烈焰
			hurt=hurt*(100+JY.Skill[54]["参数1"])/100;
		end
		if JY.Magic[mid]["类型"]==2 and WarCheckSkill(wid,55) then	--激流
			hurt=hurt*(100+JY.Skill[55]["参数1"])/100;
		end
		--[[if JY.Magic[mid]["类型"]==3 and WarCheckSkill(wid,14) then	--落石
			hurt=hurt*(100+JY.Skill[14]["参数1"])/100;
		end]]--
		--[[if (between(JY.Magic[mid]["类型"],1,3) or between(JY.Magic[mid]["类型"],9,10)) and WarCheckSkill(wid,39) then	--毒计
			hurt=hurt*(100+JY.Skill[39]["参数1"])/100;
		end]]--
		
		if JY.Magic[mid]["类型"]==1 and WarCheckSkill(eid,13) then	--灭火
			hurt=hurt*(100-JY.Skill[13]["参数1"])/100;
		end
		if JY.Magic[mid]["类型"]==2 and WarCheckSkill(eid,56) then	--治水
			hurt=hurt*(100-JY.Skill[56]["参数1"])/100;
		end
		if JY.Magic[mid]["类型"]==1 and WarCheckSkill(eid,4) then	--火神
			hurt=1;
		end
		if JY.Magic[mid]["类型"]==2 and WarCheckSkill(eid,3) then	--水神
			hurt=1;
		end
		if (between(JY.Magic[mid]["类型"],1,3) or between(JY.Magic[mid]["类型"],9,10)) then
			if WarCheckSkill(eid,16) then	--明镜
				hurt=hurt*(100-JY.Skill[16]["参数1"])/100;
			end
			--[[if WarCheckSkill(eid,45) then	--霸气
				hurt=hurt*(100-JY.Skill[45]["参数2"])/100;
			end]]--
		end
		if WarCheckSkill(eid,23) then	--藤甲
			if JY.Magic[mid]["类型"]==1 then
				hurt=hurt*(100+JY.Skill[23]["参数2"])/100;
			end
			if JY.Magic[mid]["类型"]==2 then
				hurt=1;
			end
		end
	end
	hurt=math.modf(hurt*(1+math.random()/50));
	if hurt<1 then
		hurt=1;
	end
	-- 如果攻击伤害大于防御方兵力，则攻击伤害=防御方兵力
	if hurt>p2["兵力"] then
		hurt=p2["兵力"];
	end
	--士气降幅＝攻击伤害÷（防御方等级＋5）÷3
	local sq_hurt=math.modf(hurt/(p2["等级"]+5)/3);
	if sq_hurt==0 then
		if hurt>0 then
			sq_hurt=1;
		else
			sq_hurt=0;
		end
	end
  if (not ItemFlag) and WarCheckSkill(wid, 43) then	--狼顾
    sq_hurt = sq_hurt + JY.Skill[43]["参数1"];
  end
	sq_hurt=limitX(sq_hurt,0,p2["士气"]);
	--经验值获得
	local jy=0;
	local jy2=0;	--策略失败时的经验
	--敌军部队不能获得经验值．
	if p1["等级"]<99 and (not War.Person[wid].enemy) then--and (not War.Person[wid].friend) then
	--经验值由两部分构成：基本经验值和奖励经验值．
		local part1,part2=0,0;
		--当攻击方等级低于等于防御方等级时：
		if p1["等级"]<=p2["等级"] then
			--基本经验值＝（防御方等级－攻击方等级＋3）×2
			part1=(p2["等级"]-p1["等级"]+3)*2;
			--如果基本经验值大于16，则基本经验值＝16．
			if part1>16 then
				part1=16;
			end
			--提高获取经验
			--[[part1=(p2["等级"]-p1["等级"]+5)*2;
			if part1>24 then
				part1=24;
			end]]--
		--当攻击方等级高于防御方等级时：
		else
			--基本经验值＝4
			part1=4;
			--part1=8;	--提高获取经验
		end
		--如果杀死敌人，可以获得奖励经验值：
		if hurt==p2["兵力"] then
			--如果杀死敌军主将
			if War.Person[eid].leader then
				--奖励经验值＝48
				part2=48;
			--如果杀死的不是敌军主将，且敌军等级高于我军
			elseif p2["等级"]>p1["等级"] then
				--奖励经验值＝32
				part2=32;
			--如果杀死的不是敌军主将，且敌军等级低于等于我军
			else
				--奖励经验值＝64÷（攻击方等级－防御方等级＋2）
				part2=math.floor(64/(p1["等级"]-p2["等级"]+2));
				--提高获取经验
				--[[part2=32-(p1["等级"]-p2["等级"])*4;
				part2=limitX(part2,8,48);]]--
			end
		end
		--最终获得的经验值＝基本经验值＋奖励经验值．
		jy=part1+part2;
		jy2=part1;
	end
	
	if JY.Magic[mid]["类型"]==11 then
		hurt=limitX((math.random(15)+90)*15,0,p2["兵力"]);
		sq_hurt=limitX(math.random(10)+30,0,p2["士气"]);
		jy=0;
		jy2=0;
	end
	
	return hurt,sq_hurt,jy,jy2;
end
function WarItemMenu()
	local id=War.SelID;
	local pid=War.Person[id].id;
	if JY.Person[pid]["道具1"]==0 then
		--PlayWavE(2);
		WarDrawStrBoxWaitKey("没有道具！",C_WHITE);
		return;
	end
	local menux,menuy=0,0;
	local menu_off=16;
	local mx=War.Person[id].x;
	local my=War.Person[id].y;
	if mx-War.CX>math.modf(War.MW/2) then
		menux=16+War.BoxWidth*(mx-War.CX)-80-menu_off;
	else
		menux=16+War.BoxWidth*(mx-War.CX+1)+menu_off;
	end
	menuy=math.min(32+War.BoxDepth*(my-War.CY)+menu_off,CC.ScreenH-16-112-menu_off);
	local m={
					{"  使用",WarItemMenu_sub,1},
					{"  交给",WarItemMenu_sub,1},
					{"  丢掉",WarItemMenu_sub,1},
					{"  观看",WarItemMenu_sub,1},
			};
	local r=WarShowMenu(m,4,0,menux,menuy,menux+80,menuy+112,1,1,16,C_WHITE,C_WHITE);
	if r>0 then
		return 1;
	else
		return 0;
	end
end
function WarItemMenu_sub(kind)
	local id=War.SelID;
	local pid=War.Person[id].id;
	local menux,menuy=0,0;
	local menu_off=16;
	local mx=War.Person[id].x;
	local my=War.Person[id].y;
	if mx-War.CX>math.modf(War.MW/2) then
		menux=16+War.BoxWidth*(mx-War.CX)-80-menu_off*2;
	else
		menux=16+War.BoxWidth*(mx-War.CX+1)+menu_off*2;
	end
	menuy=math.min(32+War.BoxDepth*(my-War.CY)+menu_off*2,CC.ScreenH-16-112-menu_off*2);
	local m={};
	for i=1,8 do
		local itemid=JY.Person[pid]["道具"..i];
		if itemid>0 then
			if kind==1 then
				m[i]={fillblank(JY.Item[itemid]["名称"],10),Item_Use,1};
			elseif kind==2 then
				m[i]={fillblank(JY.Item[itemid]["名称"],10),Item_Send,1};
			elseif kind==3 then
				m[i]={fillblank(JY.Item[itemid]["名称"],10),Item_Scrap,1};
			elseif kind==4 then
				m[i]={fillblank(JY.Item[itemid]["名称"],10),Item_Check,1};
			else
				m[i]={fillblank(JY.Item[itemid]["名称"],10),nil,1};
			end
		else
			m[i]={"",nil,0};
		end
	end
	local r=WarShowMenu(m,8,0,menux,menuy,0,0,4,1,16,C_WHITE,C_WHITE);
	if r>0 then
		return 1;
	else
		return 0;
	end
end
function Item_Use(i)
	local id=War.SelID;
	local pid=War.Person[id].id;
	local itemid=JY.Person[pid]["道具"..i];
	local kind=JY.Item[itemid]["类型"];
	if between(kind,1,2) then
		local mid=JY.Item[itemid]["效果"];
		local MenuPicNum=JY.MenuPic.num;
		JY.MenuPic.num=0;
		if WarMagicMenu_sub(id,mid,true) then
			JY.MenuPic.num=MenuPicNum;
			for n=i,7 do
				JY.Person[pid]["道具"..n]=JY.Person[pid]["道具"..(n+1)];
			end
			JY.Person[pid]["道具8"]=0;
			return 1;
		end
		JY.MenuPic.num=MenuPicNum;
	elseif kind==3 then
		--confirm
		if not WarDrawStrBoxYesNo(string.format('将部队变成%s．',JY.Bingzhong[JY.Item[itemid]["效果"]]["名称"]),C_WHITE) then
			return 0;
		elseif JY.Item[itemid]["需兵种"]>0 and JY.Person[pid]["兵种"]~=JY.Item[itemid]["需兵种"] then
			PlayWavE(2);
			WarDrawStrBoxDelay("需要"..JY.Bingzhong[JY.Item[itemid]["需兵种"]]["名称"].."．",C_WHITE);
			return 0;
		elseif JY.Person[pid]["等级"]<JY.Item[itemid]["需等级"] then
			PlayWavE(2);
			WarDrawStrBoxDelay("等级不足．",C_WHITE);
			return 0;
		else
			WarBingZhongUp(War.SelID,JY.Item[itemid]["效果"]);
			for n=i,7 do
				JY.Person[pid]["道具"..n]=JY.Person[pid]["道具"..(n+1)];
			end
			JY.Person[pid]["道具8"]=0;
			return 1;
		end
	else
		PlayWavE(2);
		WarDrawStrBoxDelay("没有能使用的道具．",C_WHITE);
		return 0;
	end
end
--交出了．
function Item_Send(i)
	local id=War.SelID;
	local pid=War.Person[id].id;
	local itemid=JY.Person[pid]["道具"..i];
	WarSetAtkFW(War.SelID,21);
	local eid=WarSelectAtk(true,11);
	if eid>0 then
		local EID=War.Person[eid].id;
		if JY.Person[EID]["道具8"]>0 then
			PlayWavE(2);
			WarDrawStrBoxDelay("携带品已经满了，不能再给了．",C_WHITE);
			return 0;
		else
			for n=1,8 do
				if JY.Person[EID]["道具"..n]==0 then
					JY.Person[EID]["道具"..n]=itemid;
					break;
				end
			end
			for n=i,7 do
				JY.Person[pid]["道具"..n]=JY.Person[pid]["道具"..(n+1)];
			end
			JY.Person[pid]["道具8"]=0;
			WarDrawStrBoxWaitKey("交出了"..JY.Item[itemid]["名称"].."．",C_WHITE);
			ReSetAttrib(pid,false);
			ReSetAttrib(EID,false);
			return 1;
		end
	else
		return 0;
	end
end
function Item_Scrap(i)
	local id=War.SelID;
	local pid=War.Person[id].id;
	local itemid=JY.Person[pid]["道具"..i];
	WarDrawStrBoxWaitKey("丢掉了"..JY.Item[itemid]["名称"].."．",C_WHITE);
	for n=i,7 do
		JY.Person[pid]["道具"..n]=JY.Person[pid]["道具"..(n+1)];
	end
	JY.Person[pid]["道具8"]=0;
	ReSetAttrib(id,false);
	return 1;
end
function Item_Check(i)
	local id=War.SelID;
	local pid=War.Person[id].id;
	local itemid=JY.Person[pid]["道具"..i];
	DrawItemStatus(itemid);
	return 0;
end
function WarAutoD(id1,id2)
	local x1,y1=War.Person[id1].x,War.Person[id1].y;
	local x2,y2=War.Person[id2].x,War.Person[id2].y;
	local dx=math.abs(x1-x2);
	local dy=math.abs(y1-y2);
	if dx==0 and dy==0 then
		return War.Person[id1].d,War.Person[id1].d;
	end
	if dy>dx then
		if y1>y2 then
			return 2,1;
		else
			return 1,2;
		end
	else
		if x1>x2 then
			return 3,4;
		else
			return 4,3;
		end
	end
end
----------------------------------------------------------------
--	BZSuper(bz1,bz2)
--	返回兵种克制关系
--	true 克制 false 不被克制
----------------------------------------------------------------
function BZSuper(bz1,bz2)
	for i=1,9 do
		if JY.Bingzhong[bz1]["克制"..i]==bz2 then
			return true;	--bz1 克制 bz2
		end
	end
	return false;	--不被克制
end
function WarAtkHurt(pid,eid,flag)
	flag=flag or 0;
	local id1=War.Person[pid].id;
	local id2=War.Person[eid].id;
	local p1=JY.Person[id1];
	local p2=JY.Person[id2];
	--攻击防御
	local atk=p1["攻击"];
	local def=p2["防御"];
	--防御修正，兵种克制
	--[[
	if (p1["兵种"]>=1 and p1["兵种"]<=3 and p2["兵种"]>=4 and p2["兵种"]<=6) or
		(p1["兵种"]>=4 and p1["兵种"]<=6 and p2["兵种"]>=7 and p2["兵种"]<=9) or
		(p1["兵种"]>=7 and p1["兵种"]<=9 and p2["兵种"]>=1 and p2["兵种"]<=3) then
		def=def*3/4;
	elseif (p1["兵种"]>=1 and p1["兵种"]<=3 and p2["兵种"]>=7 and p2["兵种"]<=9) or
			(p1["兵种"]>=4 and p1["兵种"]<=6 and p2["兵种"]>=1 and p2["兵种"]<=3) or
			(p1["兵种"]>=7 and p1["兵种"]<=9 and p2["兵种"]>=4 and p2["兵种"]<=6) then
		def=def*5/4;
	end]]--
	if BZSuper(p1["兵种"],p2["兵种"]) then	--克制
		def=def*3/4;
	elseif BZSuper(p2["兵种"],p1["兵种"]) then	--被克制
		def=def*5/4;
	end
	
	--地形杀伤修正
	local T={[0]=0,20,30,0,0,	--森林　20　山地　30
				0,0,5,5,0,		--村庄　 5	草原　 5
				0,0,0,30,10,		--鹿寨　30　兵营　10
				0,0,0,0,0,
				0,0,0,0,0,
				0,0,0,0,0}
	local dx=GetWarMap(War.Person[eid].x,War.Person[eid].y,1);
	--基本物理杀伤＝（攻击方攻击力－防御力修正值÷2）×（100－地形杀伤修正）÷100
	local hurt=(atk-def/2);
	if CC.Enhancement then
		hurt=hurt*limitX(100+War.Person[pid].atk_buff-War.Person[eid].def_buff,10,200)/100;
		if WarCheckSkill(eid,23) then	--藤甲
			hurt=hurt*(100-JY.Skill[23]["参数1"])/100;
		end
		if WarCheckSkill(eid,47) then	--倾国
			hurt=hurt*(100-JY.Skill[47]["参数1"])/100;
		end
	else
		hurt=hurt*(100-T[dx])/100;
	end
	
	if flag==1 then	--反击？
		hurt=hurt/2;
	elseif flag==2 then	--乱射？
		hurt=hurt/3;
	elseif flag==3 then	--乱舞？
		hurt=hurt/2;
	elseif flag==4 then	--连击？
		hurt=hurt*0.8;
	end
	hurt = math.floor(hurt);
	if hurt<atk/20 then
		hurt=math.ceil(atk/20);
	end
	--如果攻击伤害<=0，则攻击伤害=1．
	if hurt<1 then
		hurt=1;
	end
	local flag2=0;
	if hurt>=p2["最大兵力"]*0.4 then
		flag2=2;	--暴击
	elseif hurt>=p2["兵力"]+p2["最大兵力"]/5 then
		flag2=2;	--暴击
	elseif hurt<=p2["最大兵力"]/5 then
		flag2=1;	--格挡
	end
	-- 如果攻击伤害大于防御方兵力，则攻击伤害=防御方兵力
	if hurt>p2["兵力"] then
		hurt=p2["兵力"];
	end
	--士气降幅＝攻击伤害÷（防御方等级＋5）÷3
	local sq_hurt=math.modf(hurt/(p2["等级"]+5)/3);
	if sq_hurt==0 then
		if hurt>0 then
			sq_hurt=1;
		else
			sq_hurt=0;
		end
	end
	sq_hurt=limitX(sq_hurt,0,p2["士气"]);
	--经验值获得
	local jy=0;
	--敌军部队不能获得经验值．
	if p1["等级"]<99 and (not War.Person[pid].enemy) then--and (not War.Person[pid].friend) then
	--经验值由两部分构成：基本经验值和奖励经验值．
		local part1,part2=0,0;
		--当攻击方等级低于等于防御方等级时：
		if p1["等级"]<=p2["等级"] then
			--基本经验值＝（防御方等级－攻击方等级＋3）×2
			part1=(p2["等级"]-p1["等级"]+3)*2
			--如果基本经验值大于16，则基本经验值＝16．
			if part1>16 then
				part1=16;
			end
			--提高获取经验
			--[[part1=(p2["等级"]-p1["等级"]+5)*2;
			if part1>24 then
				part1=24;
			end]]--
		--当攻击方等级高于防御方等级时：
		else
			--基本经验值＝4
			part1=4;
			--part1=8;	--提高获取经验
		end
		--如果杀死敌人，可以获得奖励经验值：
		if hurt==p2["兵力"] then
			--如果杀死敌军主将
			if War.Person[eid].leader then
				--奖励经验值＝48
				part2=48;
			--如果杀死的不是敌军主将，且敌军等级高于我军
			elseif p2["等级"]>p1["等级"] then
				--奖励经验值＝32
				part2=32;
			--如果杀死的不是敌军主将，且敌军等级低于等于我军
			else
				--奖励经验值＝64÷（攻击方等级－防御方等级＋2）
				part2=math.modf(64/(p1["等级"]-p2["等级"]+2));
				--提高获取经验
				--[[part2=32-(p1["等级"]-p2["等级"])*4;
				part2=limitX(part2,8,48);]]--
			end
		end
		--最终获得的经验值＝基本经验值＋奖励经验值．
		jy=part1+part2;
	end
	
	return hurt,sq_hurt,jy,flag2;
end
function WarAtk(pid,eid,flag)
	flag=flag or 0;
	War.ControlEnableOld=War.ControlEnable;
	War.ControlEnable=false;
	War.InMap=false;
	local hurt,sq_hurt,jy,flag2=WarAtkHurt(pid,eid,flag);
	--flag2 0 普通 1格挡 2暴击
	local id1=War.Person[pid].id;
	local id2=War.Person[eid].id;
	local str;
	if flag==1 then
		str=JY.Person[id1]["姓名"]..'的反击';
	elseif flag==2 then
		str=JY.Person[id1]["姓名"]..'的乱射';
	elseif flag==3 then
		str=JY.Person[id1]["姓名"]..'的乱舞';
	elseif flag==4 then
		str=JY.Person[id1]["姓名"]..'的连击';
	else
		str=JY.Person[id1]["姓名"]..'的攻击';
	end
	local n=CC.OpearteSpeed;
	local d1,d2=WarAutoD(pid,eid);
	War.Person[pid].d=d1;
	WarDelay();
	if flag2==2 then
		PlayWavE(6);
		WarAtkWords(pid);
	end
	War.Person[pid].action=2;
	War.Person[pid].frame=0;
	WarDelay();
	PlayWavE(War.Person[pid].atkwav);
	for i=1,n*2 do
		JY.ReFreshTime=lib.GetTime();
		DrawWarMap();
		DrawYJZBox2(-256,64,str,C_WHITE);
		ReFresh();
	end
	for i=0,3 do
		War.Person[pid].frame=i;
		if i==0 and flag2==2 then
			PlayWavE(33);
			for t=8,192,8 do
				JY.ReFreshTime=lib.GetTime();
				War.Person[pid].effect=t;
				DrawWarMap();
				DrawYJZBox2(-256,64,str,C_WHITE);
				ReFresh();
			end
			War.Person[pid].effect=0;
		end
		if i==3 then
			War.Person[eid].hurt=hurt;
			War.Person[eid].frame=0;
			War.Person[eid].d=d2;
			if War.Person[eid].troubled then
				PlayWavE(35);
			elseif flag2==1 then
				War.Person[eid].action=3;
				PlayWavE(30);
			elseif flag2==2 then
				War.Person[eid].effect=240;
				War.Person[eid].action=4;
				PlayWavE(36);
			else
				War.Person[eid].effect=240;
				War.Person[eid].action=4;
				PlayWavE(35);
			end
			for t=1,n do
				JY.ReFreshTime=lib.GetTime();
				DrawWarMap();
				DrawYJZBox2(-256,64,str,C_WHITE);
				ReFresh();
			end
		end
		for t=1,n do
			JY.ReFreshTime=lib.GetTime();
			DrawWarMap();
			DrawYJZBox2(-256,64,str,C_WHITE);
			ReFresh();
		end
	end
	War.Person[eid].effect=0;
	for i=1,n*2 do
		JY.ReFreshTime=lib.GetTime();
		DrawWarMap();
		DrawYJZBox2(-256,64,str,C_WHITE);
		ReFresh();
	end
	War.Person[eid].hurt=-1;
	--敌军兵力减少 显示
	local t=16;
	t=math.min(16,(math.modf(math.max(2,math.abs(hurt)/50,math.abs(sq_hurt)))));
	local oldbl=JY.Person[id2]["兵力"];
	local oldsq=JY.Person[id2]["士气"];
	for i=0,t do
		JY.ReFreshTime=lib.GetTime();
		JY.Person[id2]["兵力"]=oldbl-hurt*i/t;
		JY.Person[id2]["士气"]=oldsq-sq_hurt*i/t;
		DrawWarMap();
		DrawStatusMini(eid);
		lib.GetKey();
		ReFresh();
	end
	JY.ReFreshTime=lib.GetTime();
	ReFresh(CC.OpearteSpeed*4);
	WarDelay(4);
	WarGetTrouble(eid);
	--攻心 显示
	if CC.Enhancement then
		if WarCheckSkill(pid,33) then	--攻心
			if hurt>0 and JY.Person[id1]["兵力"]<JY.Person[id1]["最大兵力"] then
				local t=16;
				hurt=math.modf(hurt*JY.Skill[33]["参数1"]/100);
				hurt=limitX(hurt,1,JY.Person[id1]["最大兵力"]-JY.Person[id1]["兵力"])
				t=math.min(16,(math.modf(math.max(2,math.abs(hurt)/25))));
				local oldbl=JY.Person[id1]["兵力"];
				for i=0,t do
					JY.ReFreshTime=lib.GetTime();
					JY.Person[id1]["兵力"]=oldbl+hurt*i/t;
					DrawWarMap();
					DrawStatusMini(pid);
					lib.GetKey();
					ReFresh();
				end
				JY.ReFreshTime=lib.GetTime();
				ReFresh(CC.OpearteSpeed*4);
				WarDelay(4);
			end
		end
	end
	
	--经验以及升级
	WarAddExp(pid,jy);
	if War.Person[pid].active then
		War.Person[pid].action=1;
	else
		War.Person[pid].action=0;
	end
	if War.Person[eid].active then
		War.Person[eid].action=1;
	else
		War.Person[eid].action=0;
	end
	ReSetAttrib(id1,false);
	ReSetAttrib(id2,false);
	War.Person[pid].frame=-1;
	War.Person[eid].frame=-1;
	--War.ControlEnable=true----War.ControlEnableOld;
	
	if CC.Enhancement then
		if flag == 0 and JY.Person[id2]["兵力"]>0 then
      local canDouble = false;
      if War.Person[pid].bz == 27 then
        canDouble = true;
      --elseif CheckSkill(id1, 68) and math.random(JY.Skill[68]["参数1"]) <= JY.Person[id1]["武力2"] then
      elseif CheckSkill(id1, 68) then
        canDouble = true;
      end
			if canDouble then
				WarAtk(pid, eid, 4);
			end
		end
	end
end
----------------------------------------------------------------
--	WarAction(kind,id1,id2)
--	战场上显示各种动作	id一般为人物id
--	kind:	0.转向	id1人物id, id2 方向id 1234下上左右
--			1.自动转向
--			3.攻击|无	4.攻击|被击中	5.攻击|防御	6.攻击|攻击
--			7.暴击|无	8.暴击|被击中	9.暴击|防御	10.暴击|暴击
--			11.双击|无	12.底力
--			15.防御		16.撤退(含防御)	17.败退		18.死亡
--			19.喘气
----------------------------------------------------------------
function WarAction(kind,id1,id2)
	if JY.Status~=GAME_WMAP and JY.Status~=GAME_WARWIN and JY.Status~=GAME_WARLOSE then
		return;
	end
	local controlstatus=War.ControlEnable;
	War.ControlEnable=false;
	War.InMap=false;
	id1=id1 or 1;
	id2=id2 or id1;
	local pid=GetWarID(id1);
	local eid=GetWarID(id2);
	local n=CC.OpearteSpeed;
	WarPersonCenter(pid);
	if (not War.Person[pid].live) or War.Person[pid].hide then
		
	elseif kind==0 then
		if between(id2,1,4) then
			War.Person[pid].action=0;
			War.Person[pid].frame=0;
			WarDelay(n);
			if War.Person[pid].d~=id2 then
				War.Person[pid].d=id2;
				PlayWavE(6);
				WarDelay(n*2);
			end
		end
	elseif kind==1 then
		local d1,d2=WarAutoD(pid,eid);
		WarAction(0,id1,d1);
		WarAction(0,id2,d2);
	elseif kind==2 then
		
	elseif kind==3 then
		War.Person[pid].action=2;
		War.Person[pid].frame=0;
		PlayWavE(War.Person[pid].atkwav);
		WarDelay(n);
		for i=0,3 do
			War.Person[pid].frame=i;
			if i==3 then
				PlayWavE(7);
				WarDelay(n);
			end
			WarDelay(n);
		end
		War.Person[eid].effect=0;
		WarDelay(n*2);
	elseif kind==4 then
		local d1,d2=WarAutoD(pid,eid);
		--War.Person[pid].d=d1;
		WarAction(0,id1,d1);
		War.Person[pid].action=2;
		War.Person[pid].frame=0;
		PlayWavE(War.Person[pid].atkwav);
		WarDelay(n);
		for i=0,3 do
			War.Person[pid].frame=i;
			if i==3 then
				War.Person[eid].frame=0;
				War.Person[eid].d=d2;
				War.Person[eid].effect=240;
				War.Person[eid].action=4;
				PlayWavE(35);
				WarDelay(n);
			end
			WarDelay(n);
		end
		War.Person[eid].effect=0;
		WarDelay(n*2);
	elseif kind==5 then
		local d1,d2=WarAutoD(pid,eid);
		--War.Person[pid].d=d1;
		WarAction(0,id1,d1);
		War.Person[pid].action=2;
		War.Person[pid].frame=0;
		PlayWavE(War.Person[pid].atkwav);
		for t=1,n do
			JY.ReFreshTime=lib.GetTime();
			DrawWarMap();
			ReFresh();
		end
		lib.GetKey();
		for i=0,3 do
			War.Person[pid].frame=i;
			if i==3 then
				War.Person[eid].frame=0;
				War.Person[eid].d=d2;
				War.Person[eid].action=3;
				PlayWavE(30);
				WarDelay(n);
			end
			WarDelay(n);
		end
		War.Person[eid].effect=0;
		WarDelay(n*2);
	elseif kind==6 then
		WarAction(1,id1,id2);
		War.Person[pid].action=2;
		War.Person[eid].action=2;
		for i=0,3 do
			War.Person[pid].frame=i;
			War.Person[eid].frame=i;
			if i==3 then
				PlayWavE(30);
				WarDelay(n);
			end
			WarDelay(n);
		end
		WarDelay(n*2);
	elseif kind==7 then
		War.Person[pid].action=2;
		War.Person[pid].frame=0;
		PlayWavE(War.Person[pid].atkwav);
		WarDelay(n);
		for i=0,3 do
			War.Person[pid].frame=i;
			if i==0 then
				PlayWavE(33);
				for t=8,192,8 do
					War.Person[pid].effect=t;
					WarDelay(1);
				end
				War.Person[pid].effect=0;
			end
			if i==3 then
				PlayWavE(7);
				WarDelay(n);
			end
			WarDelay(n);
		end
		War.Person[eid].effect=0;
		WarDelay(n*2);
	elseif kind==8 then
		local d1,d2=WarAutoD(pid,eid);
		WarAction(0,id1,d1);
		--War.Person[pid].d=d1;
		War.Person[pid].action=2;
		War.Person[pid].frame=0;
		PlayWavE(War.Person[pid].atkwav);
		WarDelay(n);
		for i=0,3 do
			War.Person[pid].frame=i;
			if i==0 then
				PlayWavE(33);
				for t=8,192,8 do
					War.Person[pid].effect=t;
					WarDelay(1);
				end
				War.Person[pid].effect=0;
			end
			if i==3 then
				War.Person[eid].frame=0;
				War.Person[eid].d=d2;
				War.Person[eid].effect=240;
				War.Person[eid].action=4;
				PlayWavE(36);
				WarDelay(n);
			end
			WarDelay(n);
		end
		War.Person[eid].effect=0;
		WarDelay(n*2);
	elseif kind==9 then
		local d1,d2=WarAutoD(pid,eid);
		WarAction(0,id1,d1);
		--War.Person[pid].d=d1;
		War.Person[pid].action=2;
		War.Person[pid].frame=0;
		PlayWavE(War.Person[pid].atkwav);
		WarDelay(n);
		lib.GetKey();
		for i=0,3 do
			War.Person[pid].frame=i;
			if i==0 then
				PlayWavE(33);
				for t=8,192,8 do
					War.Person[pid].effect=t;
					WarDelay(1);
				end
				lib.GetKey();
				War.Person[pid].effect=0;
			end
			if i==3 then
				War.Person[eid].frame=0;
				War.Person[eid].d=d2;
				War.Person[eid].action=3;
				War.Person[eid].effect=256;
				PlayWavE(31);
				WarDelay(n);
			end
			War.Person[eid].effect=0;
			WarDelay(n);
		end
		War.Person[eid].effect=0;
		WarDelay(n*2);
		lib.GetKey();
	elseif kind==10 then
		WarAction(1,id1,id2);
		War.Person[pid].action=2;
		War.Person[eid].action=2;
		for i=0,3 do
			War.Person[pid].frame=i;
			War.Person[eid].frame=i;
			if i==0 then
				PlayWavE(33);
				for t=8,192,8 do
					War.Person[pid].effect=t;
					War.Person[eid].effect=t;
					WarDelay(1);
				end
				lib.GetKey();
				War.Person[pid].effect=0;
				War.Person[eid].effect=0;
			end
			if i==3 then
				War.Person[pid].effect=192;
				War.Person[eid].effect=192;
				PlayWavE(31);
				WarDelay(n);
			end
			WarDelay(n);
		end
		War.Person[pid].effect=0;
		War.Person[eid].effect=0;
		WarDelay(n*2);
	elseif kind==11 then
	
	elseif kind==12 then
		War.Person[pid].action = 2;
		for i = 0, 3 do
			War.Person[pid].frame = i;
			if i == 3 then
				PlayWavE(7);
			end
			JY.ReFreshTime = lib.GetTime();
			DrawWarMap();
			ReFresh();
		end
    JY.ReFreshTime = lib.GetTime();
    DrawWarMap();
		ReFresh(3);
    
		ReFresh(4);
		for t = 1, 3 do
			for i = 0, 3 do
				War.Person[pid].frame = i;
				if i == 3 then
					PlayWavE(7);
				end
        JY.ReFreshTime = lib.GetTime();
        DrawWarMap();
				ReFresh();
				lib.GetKey();
			end
		end
	
	elseif kind==13 then
	
	elseif kind==14 then
	
	elseif kind==15 then
		War.Person[pid].action=3;
		War.Person[pid].frame=0;
		WarDelay(n*2);
	elseif kind==16 then
		War.Person[pid].action=0;
		War.Person[pid].frame=0;
		WarDelay(n);
		War.Person[pid].d=1;
		PlayWavE(6);
		WarDelay(n*2);
		War.Person[pid].action=3;
		War.Person[pid].frame=0;
		WarDelay(n*2);
		PlayWavE(17);
		for t=0,-256,-8 do
			War.Person[pid].effect=t;
			WarDelay(1);
		end
		WarDelay(n*2);
		War.Person[pid].action=9;
		War.Person[pid].live=false;
		SetWarMap(War.Person[pid].x,War.Person[pid].y,2,0);
		WarDelay(n*4);
		--WarDrawStrBoxDelay(JY.Person[War.Person[pid].id]["姓名"].."撤退了！",C_WHITE);
		if War.Person[pid].enemy then
			War.EnemyNum=War.EnemyNum-1;
		end
	elseif kind==17 then
		War.Person[pid].action=5;
		WarDelay(n);
		for i=1,5 do
			War.Person[pid].frame=0;
			if War.Person[pid].action==9 then
				War.Person[pid].action=5;
				PlayWavE(16);
			else
				War.Person[pid].action=9;
			end
			WarDelay(n);
		end
		War.Person[pid].frame=-1;
		War.Person[pid].action=9;
		War.Person[pid].live=false;
		SetWarMap(War.Person[pid].x,War.Person[pid].y,2,0);
		WarDelay(n*2);
		WarDrawStrBoxDelay(JY.Person[War.Person[pid].id]["姓名"].."撤退了！",C_WHITE);
		if War.Person[pid].enemy then
			War.EnemyNum=War.EnemyNum-1;
		end
	elseif kind==18 then
		War.Person[pid].frame=0;
		War.Person[pid].action=5;
		for i=1,6 do
			if War.Person[pid].action==9 then
				War.Person[pid].action=5;
			else
				War.Person[pid].action=9;
			end
			WarDelay(n-1);
			lib.GetKey();
		end
		for i=1,16 do
			if War.Person[pid].action==9 then
				War.Person[pid].action=5;
			else
				War.Person[pid].action=9;
			end
			WarDelay(n-2);
			lib.GetKey();
		end
		PlayWavE(22);
		War.Person[pid].action=5;
		for i=128,256,12 do
			War.Person[pid].effect=i
			WarDelay(n);
		end
		WarDelay(n*2);
		War.Person[pid].frame=-1;
		War.Person[pid].action=9;
		War.Person[pid].live=false;
		SetWarMap(War.Person[pid].x,War.Person[pid].y,2,0);
		WarDelay(n*4);
		WarDrawStrBoxDelay(JY.Person[War.Person[pid].id]["姓名"].."阵亡了！",C_WHITE);
		if War.Person[pid].enemy then
			War.EnemyNum=War.EnemyNum-1;
		end
	elseif kind==19 then
		War.Person[pid].action=5;
		War.Person[pid].frame=0;
		for i=0,5 do
			War.Person[pid].frame=1-War.Person[pid].frame;
			WarDelay(n*2);
		end
		WarDelay(n*2);
	end
	WarResetStatus(pid);
	WarResetStatus(eid);
	War.ControlEnable=controlstatus;
end

----------------------------------------------------------------
--	WarLastWords(wid)
--	战场人物遗言
----------------------------------------------------------------
function WarLastWords(wid)
	local wp=War.Person[wid];
	local name=JY.Person[wp.id]["姓名"];
	if true then--not wp.enemy then
		if type(CC.LastWords[name])=='string' then
			if wp.id==1 then
				PlayBGM(4);
			end
			talk(	wp.id,CC.LastWords[name]);
		end
	end
end
----------------------------------------------------------------
--	WarAtkWords(wid)
--	战场人物暴击台词
----------------------------------------------------------------
function WarAtkWords(wid)
	local wp=War.Person[wid];
	local name=JY.Person[wp.id]["姓名"];
	if true then--not wp.enemy then
		if type(CC.AtkWords[name])=='string' then
			talk(	wp.id,CC.AtkWords[name]);
		else
			local str={
							"喔喔喔……！",	"哈啊啊……！",	"呀啊啊……！",	"喝……！",	"唔喔喔……！",
							"杀啊啊……！",	"看招啊……！",	"吃我一记！！",	"杀……！",	"去死吧！！！",
							"唷呵……！",		"呀呔……！",		"嗯嗯嗯……！",	"唔唔唔……！",	"呼呼呼……！",
							"嗯嗯！？",		"哼！！",		"嗯嗯嗯！",		"讨厌！！",	"哎呀！！",
							"………………。",		"…………！",	"准备接招吧！！",	"准备受死吧！",	"着！！"
						}
			local n=math.random(40);
			if type(str[n])=='string' then
				talk(	wp.id,str[n]);
			end
		end
	end
end
----------------------------------------------------------------
--	WarResetStatus(wid)
--	用于各种行动后，使战场人物动作回复默认状态
----------------------------------------------------------------
function WarResetStatus(wid)
	if between(wid,1,War.PersonNum) then
		local v=War.Person[wid];
		v.frame=-1;
		if v.live then
			local id=v.id;
			if JY.Person[id]["兵力"]<=0 then
				if v.action~=9 then
					v.action=5;
					WarDelay(4);
					JY.Death=id;
					DoEvent(JY.EventID);
					JY.Death=0;
					if v.action~=9 then
						WarLastWords(wid);
						if id==1 then
							WarAction(18,id);
						else
							WarAction(17,id);
						end
					end
				end
			elseif v.troubled then
				v.action=7;
			elseif JY.Person[id]["兵力"]/JY.Person[id]["最大兵力"]<=0.30 then
				v.action=5;
			elseif v.active then
				v.action=1;
			else
				v.action=0;
			end
			if v.ai==6 then
				if v.x==v.ai_dx and v.y==v.ai_dy then
					v.ai=4;
				end
			end
			if CC.Enhancement then
				ReSetAttrib(id,false);	
			end
		end
	end
	ReSetAllBuff();
end
function WarAddExp(wid,Exp)
	if Exp<=0 then
		return;
	end
	local pid=War.Person[wid].id;
	if JY.Person[pid]["等级"]>=99 then
		return;
	end
  WarPersonCenter(wid);
	local oldExp=JY.Person[pid]["经验"];
	for i=0,Exp do
		JY.Person[pid]["经验"]=oldExp+i;
		for t=1,1 do
			JY.ReFreshTime=lib.GetTime();
			DrawWarMap();
			DrawStatusMini(wid,true);
			lib.GetKey();
			ReFresh();
		end
		if JY.Person[pid]["经验"]==100 then
			break;
		end
	end
	JY.ReFreshTime=lib.GetTime();
	ReFresh(CC.OpearteSpeed*3);
	WarDelay(4);
	local lvupflag=false;
	JY.Person[pid]["经验"]=oldExp+Exp;
	if JY.Person[pid]["经验"]>=100 then
		JY.Person[pid]["经验"]=JY.Person[pid]["经验"]-100;
		lvupflag=true;
	end
	if lvupflag then
		WarLvUp(wid);
	end
end
function WarAddExp2(id,Exp)--经验以及升级，但是无任何显示
end
function WarLvUp(id)--升级，以及动画
	if id==0 then
		return;
	end
	War.SelID=id;
	BoxBack();
	local pid=War.Person[id].id;
	War.Person[id].action=0;
	for t=1,2 do
		War.Person[id].d=3;
		WarDelay(3);
		War.Person[id].d=2;
		WarDelay(3);
		War.Person[id].d=4;
		WarDelay(3);
		War.Person[id].d=1;
		WarDelay(3);
	end
	PlayWavE(11);
	War.Person[id].action=6;
	WarDelay(16);
	WarDrawStrBoxWaitKey(JY.Person[pid]["姓名"].."的等级上升了！",C_WHITE);
	local magic={};
	for mid=1,JY.MagicNum-1 do
		magic[mid]=false;
		if WarHaveMagic(id,mid) then
			magic[mid]=true;
		end
	end
	JY.Person[pid]["等级"]=limitX(JY.Person[pid]["等级"]+1,1,99);
	ReSetAttrib(pid,false);
	WarResetStatus(id);
	WarDelay(4);
	--提示技能策略习得
	for i=1,6 do
		if JY.Person[pid]["等级"]==CC.SkillExp[JY.Person[pid]["成长"]][i] then
			PlayWavE(11);
			WarDrawStrBoxWaitKey(JY.Person[pid]["姓名"].."习得技能"..JY.Skill[JY.Person[pid]["特技"..i]]["名称"].."！",C_WHITE);
			break;
		end
	end
	local str="";
	for mid=1,JY.MagicNum-1 do
		if not magic[mid] then
			if WarHaveMagic(id,mid) then
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
		WarDrawStrBoxWaitKey(JY.Person[pid]["姓名"].."习得策略"..str.."！",C_WHITE);
	end
	War.LastID=War.SelID;
	War.SelID=0;
end
function WarBingZhongUp(id,bzid)--兵种变更，动画
	if id==0 then
		return;
	end
	local MenuPicNum=JY.MenuPic.num;
	JY.MenuPic.num=0;
	local pid=War.Person[id].id;
	local oldaction=War.Person[id].action;
	--使用物品动作
	War.Person[id].action=0;
	War.Person[id].d=1;
	WarDelay(2);
	PlayWavE(41);
	War.Person[id].action=6;
	WarDelay(16);
	--转圈，升级动作
	War.Person[id].action=0;
	for t=1,2 do
		War.Person[id].d=3;
		WarDelay(3);
		War.Person[id].d=2;
		WarDelay(3);
		War.Person[id].d=4;
		WarDelay(3);
		War.Person[id].d=1;
		WarDelay(3);
	end
	PlayWavE(12);
	War.Person[id].action=6;
	for i=0,256,8 do
		War.Person[id].effect=i;
		WarDelay(1);
	end
	JY.Person[pid]["兵种"]=bzid;
	War.Person[id].bz=bzid;
	War.Person[id].movewav=JY.Bingzhong[bzid]["音效"];	--移动音效
	War.Person[id].atkwav=JY.Bingzhong[bzid]["攻击音效"];	--攻击音效
	War.Person[id].movestep=JY.Bingzhong[bzid]["移动"];	--移动范围
	War.Person[id].movespeed=JY.Bingzhong[bzid]["移动速度"];	--移动速度
	War.Person[id].atkfw=JY.Bingzhong[bzid]["攻击范围"];	--攻击范围
	War.Person[id].pic=WarGetPic(id);
	for i=240,0,-8 do
		War.Person[id].effect=i;
		WarDelay(1);
	end
	WarDrawStrBoxWaitKey(JY.Person[pid]["姓名"].."的兵种成为"..JY.Bingzhong[bzid]["名称"].."了！",C_WHITE);
	ReSetAttrib(pid,false);
	War.Person[id].action=oldaction;
	JY.MenuPic.num=MenuPicNum;
end
--
function SetWarConst()
	War.DX={[0]="平原","森林","山地","河流","桥梁",
				"城墙","城池","草原","村庄","悬崖",
				"城门","荒地","栅栏","鹿砦","兵营",
				"粮仓","宝物库","房舍","火焰","浊流"}
		--		00 平原  01 森林  02 山地  03 河流  04 桥梁  05  城墙  06  城池  07  草原
        --		08 村庄  09 悬崖  0A 城门  0B 荒地  0C 栅栏  0D 鹿砦  0E  兵营  0F  粮仓
        --		10 宝物库  11 房舍  12 火焰  13 浊流
	War.Width=64;	--地图尺寸
	War.Depth=64;
	War.MW=16;		--old game 13
	War.MD=11;		--old game 11
	War.BoxWidth=48;	--地图方格尺寸
	War.BoxDepth=48;
	War.CX=1;		--左上角方格位置
	War.CY=1;
	War.MX=1;		--方格所在位置
	War.MY=1;
	War.OldX=0;	--记录人物移动前坐标
	War.OldY=0;
	War.InMap=false;	--标记鼠标是否在地图范围内
	War.OldMX=-1; --记录MXMY for 鼠标操作 移动窗口用
	War.OldMY=-1;
	War.DXpic=0;	--记录当前地形图片
	War.FrameT=0;
	War.Frame=0;
	War.MoveSpeed=0;
	War.MoveScreenFrame=0;
	War.ControlStatus="AI"
	War.PersonNum=0;
	War.Weather=math.random(6)-1;
	War.Turn=1;		--当前回合
	War.MaxTurn=30;	--最大回合
	War.Leader1=-1;
	War.Leader2=-1;
	War.CurID=0;
	War.SelID=0;
	War.LastID=0;	--就是CurID，当移动到非人物时，保持上一个人物ID
	War.EnemyNum=0;
	War.FunButtom=0;	--当前所处于的按钮
	War.ControlEnableOld=true;
	War.ControlEnable=true;
	War.PlayMagic=true;
end

----------------------------------------------------------------
--	DrawWarMap()
--	显示战场地图
----------------------------------------------------------------
function DrawWarMap()
	local x,y=War.CX,War.CY;
	lib.FillColor(0,0,0,0,0);
	local x0,y0=x,y;
	local cx,cy=16,32
	x0=limitX(x0,0,War.Width);
	y0=limitX(y0,0,War.Depth);
	local xoff=x-math.modf(x);
	local yoff=y-math.modf(y);
	--Ground
	lib.SetClip(cx,cy,cx+War.BoxWidth*War.MW,cy+War.BoxDepth*War.MD);
	lib.PicLoadCache(0,War.MapID*2,cx-War.BoxWidth*(x-1),cy-War.BoxDepth*(y-1),1);
	--Building
	
	--fire & water
	for i=x,x+War.MW-1 do
		for j=y,y+War.MD-1 do
			local v=GetWarMap(i,j,1);
			if v==18 then
				lib.PicLoadCache(4,(250+War.Frame%2)*2,cx+War.BoxWidth*(i-x),cy+War.BoxDepth*(j-y),1);
			elseif v==19 then
				lib.PicLoadCache(4,(252+War.Frame%2)*2,cx+War.BoxWidth*(i-x),cy+War.BoxDepth*(j-y),1);
			end
		end
	end
	
	for x=War.CX,math.min(War.CX+War.MW,War.Width) do
		for y=War.CY,math.min(War.CY+War.MD,War.Depth) do
			if GetWarMap(x,y,4)==0 then		--不可移动
				lib.Background(cx+War.BoxWidth*(x-War.CX),cy+War.BoxDepth*(y-War.CY),cx+War.BoxWidth*(x-War.CX+1),cy+War.BoxDepth*(y-War.CY+1),128);
			end
			if GetWarMap(x,y,10)==1 then	--攻击范围
				--lib.Background(cx+War.BoxWidth*(x-War.CX),cy+War.BoxDepth*(y-War.CY),cx+War.BoxWidth*(x-War.CX+1),cy+War.BoxDepth*(y-War.CY+1),160,M_Red);
				--WarFillColor(cx+War.BoxWidth*(x-War.CX),cy+War.BoxDepth*(y-War.CY),cx+War.BoxWidth*(x-War.CX+1),cy+War.BoxDepth*(y-War.CY+1),128,M_Red,2);
				lib.PicLoadCache(4,261*2,cx+War.BoxWidth*(x-War.CX),cy+War.BoxDepth*(y-War.CY),1);
			elseif GetWarMap(x,y,10)==2 then	--治疗范围
				--lib.Background(cx+War.BoxWidth*(x-War.CX),cy+War.BoxDepth*(y-War.CY),cx+War.BoxWidth*(x-War.CX+1),cy+War.BoxDepth*(y-War.CY+1),160,M_Cyan);
				--WarFillColor(cx+War.BoxWidth*(x-War.CX),cy+War.BoxDepth*(y-War.CY),cx+War.BoxWidth*(x-War.CX+1),cy+War.BoxDepth*(y-War.CY+1),128,M_Cyan,2);
				lib.PicLoadCache(4,262*2,cx+War.BoxWidth*(x-War.CX),cy+War.BoxDepth*(y-War.CY),1);
			end
		end
	end
	
	--Grid
	--[[
	for i=0,12 do
		lib.Background(0,cy+War.BoxDepth*i,CC.ScreenW,cy+War.BoxDepth*i+1,128,C_WHITE);
	end
	for i=0,16 do
		lib.Background(cx+War.BoxWidth*i,0,cx+War.BoxWidth*i+1,CC.ScreenH,128,C_WHITE);
	end]]--
	--DrawBox(cx,cy,cx+War.BoxWidth,cy+War.BoxDepth,C_GOLD);
	
	--CurrentBox
	--if War.ControlEnable then
		if War.InMap then
		--if between(War.MX,1,War.MW) and between(War.MY,1,War.MD) then
			DrawGameBox(cx+War.BoxWidth*(War.MX-War.CX),cy+War.BoxDepth*(War.MY-War.CY),cx+War.BoxWidth*(War.MX-War.CX+1),cy+War.BoxDepth*(War.MY-War.CY+1),C_WHITE,-1);
		end
	--end
	--Person
	local size=48;
	local size2=64;
	for i,v in pairs(War.Person) do
		if v.live and (not v.hide) then
			if between(v.x,x,x+War.MW-1) and between(v.y,y,y+War.MD-1) then--limit XY
				local frame;
				if v.frame>=0 then
					frame=v.frame;
				else
					frame=War.Frame;
				end
				local left=cx+War.BoxWidth*(v.x-x);
				local top=cy+War.BoxDepth*(v.y-y);
				--0静止 1移动 2攻击 3防御 4被攻击 5喘气 7混乱 9不存在
				--v.action=7 测试混乱图片用
				if v.action==0 then
					if v.effect==0 then
						lib.PicLoadCache(1,(v.pic+16+v.d-1)*2,left,top,1);
						if not v.active then
							lib.PicLoadCache(1,(v.pic+16+v.d-1)*2,left,top,1+2+4,128);
						end
					elseif v.effect>0 then
						lib.PicLoadCache(1,(v.pic+16+v.d-1)*2,left,top,1);
						lib.PicLoadCache(1,(v.pic+16+v.d-1)*2,left,top,1+2+8,v.effect);
					elseif v.effect<0 then
						lib.PicLoadCache(1,(v.pic+16+v.d-1)*2,left,top,1+2,256+v.effect);
					end
				elseif v.action==1 then
					if v.effect==0 then
						lib.PicLoadCache(1,(v.pic+frame%2+(v.d-1)*4)*2,left,top,1);
					elseif v.effect>0 then
						lib.PicLoadCache(1,(v.pic+frame%2+(v.d-1)*4)*2,left,top,1);
						lib.PicLoadCache(1,(v.pic+frame%2+(v.d-1)*4)*2,left,top,1+2+8,v.effect);
					elseif v.effect<0 then
						lib.PicLoadCache(1,(v.pic+frame%2+(v.d-1)*4)*2,left,top,1+2,256+v.effect);
					end
				elseif v.action==2 then
					if v.effect==0 then
						lib.PicLoadCache(1,(v.pic+30+frame+4*(v.d-1))*2,left+(size-size2)/2,top+(size-size2)/2,1);
					elseif v.effect>0 then
						lib.PicLoadCache(1,(v.pic+30+frame+4*(v.d-1))*2,left+(size-size2)/2,top+(size-size2)/2,1);
						lib.PicLoadCache(1,(v.pic+30+frame+4*(v.d-1))*2,left+(size-size2)/2,top+(size-size2)/2,1+2+8,v.effect);	
					elseif v.effect<0 then
						lib.PicLoadCache(1,(v.pic+30+frame+4*(v.d-1))*2,left+(size-size2)/2,top+(size-size2)/2,1+2,256+v.effect);	
					end
				elseif v.action==3 then
					if v.effect==0 then
						lib.PicLoadCache(1,(v.pic+22+(v.d-1))*2,left,top,1);
					elseif v.effect>0 then
						lib.PicLoadCache(1,(v.pic+22+(v.d-1))*2,left,top,1);
						lib.PicLoadCache(1,(v.pic+22+(v.d-1))*2,left,top,1+2+8,v.effect);
					elseif v.effect<0 then
						lib.PicLoadCache(1,(v.pic+22+(v.d-1))*2,left,top,1+2,256+v.effect);
					end
				elseif v.action==4 then
					if v.effect==0 then
						lib.PicLoadCache(1,(v.pic+26+(v.d-1)%2)*2,left,top,1);
					elseif v.effect>0 then
						lib.PicLoadCache(1,(v.pic+26+(v.d-1)%2)*2,left,top,1);
						lib.PicLoadCache(1,(v.pic+26+(v.d-1)%2)*2,left,top,1+2+8,v.effect);
					elseif v.effect<0 then
						lib.PicLoadCache(1,(v.pic+26+(v.d-1)%2)*2,left,top,1+2,256+v.effect);
					end
				elseif v.action==5 then
					if v.effect==0 then
						if v.active then
							lib.PicLoadCache(1,(v.pic+20+frame%2)*2,left,top,1);
						else
							lib.PicLoadCache(1,(v.pic+20)*2,left,top,1);
							lib.PicLoadCache(1,(v.pic+20)*2,left,top,1+2+4,128);
						end
					elseif v.effect>0 then
						lib.PicLoadCache(1,(v.pic+20+frame%2)*2,left,top,1);
						lib.PicLoadCache(1,(v.pic+20+frame%2)*2,left,top,1+2+8,v.effect);
					elseif v.effect<0 then
						lib.PicLoadCache(1,(v.pic+20+frame%2)*2,left,top,1+2,256+v.effect);
					end
				elseif v.action==6 then
					if v.effect==0 then
						lib.PicLoadCache(1,(v.pic+28)*2,left,top,1);
					elseif v.effect>0 then
						lib.PicLoadCache(1,(v.pic+28)*2,left,top,1);
						lib.PicLoadCache(1,(v.pic+28)*2,left,top,1+2+8,v.effect);
					elseif v.effect<0 then
						lib.PicLoadCache(1,(v.pic+28)*2,left,top,1+2,256+v.effect);
					end
				elseif v.action==7 then	--混乱
					local hlpic=5010;
					if v.enemy then
						hlpic=5012;
					elseif v.friend then
						hlpic=5014;
					else
						hlpic=5010;
					end
					lib.PicLoadCache(1,(hlpic+frame%2)*2,left,top,1);
				end
				if v.hurt>=0 then
					DrawString2(left+size/2-#(v.hurt.."")*5,top,""..v.hurt,C_WHITE,20);
				end
			
			--[[
				local picid=v.pic;
				local left=cx+War.BoxWidth*(v.x-x)+War.BoxWidth/2-Pic[picid].w/2-Pic[picid].w*(math.modf(War.Frame/8));
				local top=cy+War.BoxDepth*(v.y-y)+War.BoxDepth/2-Pic[picid].h/2-Pic[picid].h*(v.d-1);
				lib.SetClip(cx+War.BoxWidth*(v.x-x)+(War.BoxWidth-Pic[picid].w)/2,cy+War.BoxDepth*(v.y-y)+(War.BoxDepth-Pic[picid].h)/2,
							cx+War.BoxWidth*(v.x-x)+(War.BoxWidth+Pic[picid].w)/2,cy+War.BoxDepth*(v.y-y)+(War.BoxDepth+Pic[picid].h)/2);
				lib.PicLoadCache(2,picid*2,left,top,1);]]--
				lib.SetClip(0,0,0,0);
			end
		end
	end
	--[[
	for x=War.CX,math.min(War.CX+War.MW,War.Width) do
		for y=War.CY,math.min(War.CY+War.MD,War.Depth) do
			if GetWarMap(x,y,4)==0 then
				lib.Background(cx+War.BoxWidth*(x-War.CX),cy+War.BoxDepth*(y-War.CY),cx+War.BoxWidth*(x-War.CX+1),cy+War.BoxDepth*(y-War.CY+1),128);
			end
			if War.ControlStatus=="mapedit" then
				DrawString(cx+War.BoxWidth*(x-War.CX),cy+War.BoxDepth*(y-War.CY),War.DX[GetWarMap(x,y,1)],C_WHITE,16);
				if GetWarMap(x,y,1)>=12 then
					lib.Background(cx+War.BoxWidth*(x-War.CX),cy+War.BoxDepth*(y-War.CY),cx+War.BoxWidth*(x-War.CX+1),cy+War.BoxDepth*(y-War.CY+1),128);
				end
			end
		end
	end
	]]--
	if War.InMap then
		if War.CY>1 and between(War.MX-War.CX,1,War.MW-2) and War.MY==War.CY then
			lib.PicLoadCache(4,240*2,16+War.BoxWidth*(War.MX-War.CX)+13,32+War.BoxDepth*(War.MY-War.CY)+12,1);
		elseif War.CY<War.Depth-War.MD+1 and between(War.MX-War.CX,1,War.MW-2) and War.MY==War.CY+War.MD-1 then
			lib.PicLoadCache(4,244*2,16+War.BoxWidth*(War.MX-War.CX)+13,32+War.BoxDepth*(War.MY-War.CY)+12,1);
		elseif War.CX>1 and between(War.MY-War.CY,1,War.MD-2) and War.MX==War.CX then
			lib.PicLoadCache(4,246*2,16+War.BoxWidth*(War.MX-War.CX)+12,32+War.BoxDepth*(War.MY-War.CY)+13,1);
		elseif War.CX<War.Width-War.MW+1 and between(War.MY-War.CY,1,War.MD-2) and War.MX==War.CX+War.MW-1 then
			lib.PicLoadCache(4,242*2,16+War.BoxWidth*(War.MX-War.CX)+12,32+War.BoxDepth*(War.MY-War.CY)+13,1);
		end
	end
	if War.ControlStatus=="select" then
		--if War.ControlEnable and War.CurID>0 then
    if War.ControlStatus=="select" and War.CurID>0 then
			DrawStatusMini(War.CurID)
		end
	elseif War.ControlStatus=="checkDX" then
		local menux,menuy;
		local dx=GetWarMap(War.MX,War.MY,1);
			--size = 16
			--w/h = 112 / 60
		if War.MX-War.CX>math.modf(War.MW/2) then
			menux=16+War.BoxWidth*(War.MX-War.CX)-136;
		else
			menux=16+War.BoxWidth*(War.MX-War.CX+1);
		end
		if War.MY-War.CY>math.modf(War.MD/2) then
			menuy=32+War.BoxWidth*(War.MY-War.CY)-40;
		else
			menuy=32+War.BoxWidth*(War.MY-War.CY);
		end
		lib.Background(menux,menuy,menux+136,menuy+86,160);
		menux=menux+8;
		menuy=menuy+8;
		lib.LoadSur(War.DXpic,menux,menuy);
		DrawString(menux+56,menuy+8,"防御效果",C_WHITE,16);
		local T={[0]="０％","２０％","３０％","－％","０％","－％","０％","５％",
					"５％","－％","－％","０％","－％","３０％","１０％","０％",
					"０％","－％","－％","－％",}
		DrawString(menux+88-#T[dx]*4,menuy+32,T[dx],C_WHITE,16);
--森林  20  山地  30   村庄   5
--草原   5  鹿寨  30  兵营  10
		--		00 平原  01 森林  02 山地  03 河流  04 桥梁  05  城墙  06  城池  07  草原
        --		08 村庄  09 悬崖  0A 城门  0B 荒地  0C 栅栏  0D 鹿砦  0E  兵营  0F  粮仓
        --		10 宝物库  11 房舍  12 火焰  13 浊流
		DrawString(menux,menuy+56,War.DX[dx],C_WHITE,16);
		if dx==8 or dx==13 or dx==14 then
			DrawString(menux+56,menuy+56,"有恢复",C_WHITE,16);
		end
		--村庄、鹿砦可以恢复士气和兵力．兵营可以恢复兵力，但不能恢复士气．
       --玉玺可以恢复兵力和士气，援军报告可以恢复兵力，赦命书可以恢复士气．
       --地形和宝物的恢复能力不能叠加，也就是说，处于村庄地形上再持有恢复性宝物，与没有持有恢复性宝物效果相同．但如果地形只能恢复兵力（如兵营），但宝物可以恢复兵力，这种情况下，兵力士气都能得到自动恢复．
	end
	--Status
	lib.SetClip(0,0,0,0);
	if CC.Enhancement then
		lib.PicLoadCache(4,200*2,0,0,1);
	else
		lib.PicLoadCache(4,204*2,0,0,1);
	end
	DrawString(493-#War.WarName*16/2/2,8,War.WarName,C_WHITE,16);
	--weather
	if War.Weather<3 then	--晴
		lib.PicLoadCache(4,190*2,948,35,1);
	elseif War.Weather>3 then	--雨
		lib.PicLoadCache(4,192*2,948,35,1);
	else	--云
		lib.PicLoadCache(4,191*2,948,35,1);
	end
	if War.ControlStatus=="select" then
		if War.FunButtom==1 then
			lib.PicLoadCache(4,57*2,15,7,1);
		end
	end
	lib.SetClip(0+War.BoxWidth*War.MW,0,CC.ScreenW,CC.ScreenH);
	DrawStatus();
	--minimap
	lib.PicLoadCache(0,200+War.MapID*2,888,460+24);
	for i=1,War.Width do
		for j=1,War.Depth do
			if GetWarMap(i,j,9)~=0 then
				local x=War.MiniMapCX+(i-1)*4;
				local y=War.MiniMapCY+(j-1)*4;
				lib.FillColor(x,y,x+4,y+4,M_DarkOrchid);
			end
		end
	end
	for i,v in pairs(War.Person) do
		if v.live and (not v.hide) then
			local color=M_Blue;
			if v.enemy then
				color=M_Red;
			elseif v.friend then
				color=M_DarkOrange;
			end
			local x=War.MiniMapCX+(v.x-1)*4;
			local y=War.MiniMapCY+(v.y-1)*4;
			lib.FillColor(x,y,x+4,y+4,color);
		end
	end
	lib.DrawRect(War.MiniMapCX+(War.CX-1)*4,War.MiniMapCY+(War.CY-1)*4,War.MiniMapCX+(War.CX+War.MW-1)*4,War.MiniMapCY+(War.CY+War.MD-1)*4,M_Yellow);
	lib.SetClip(0,0,0,0);
	
			for i=1,JY.MenuPic.num do
				lib.LoadSur(JY.MenuPic.pic[i],JY.MenuPic.x[i],JY.MenuPic.y[i]);
			end
  
	War.FrameT=War.FrameT+1;
	if War.FrameT>=32 then
		War.FrameT=0;
	end
	War.Frame=math.modf(War.FrameT/8);
end

function DrawStatusMini(id,flag)
	flag=flag or false;
			local pid=War.Person[id].id;
			local x,y=War.Person[id].x,War.Person[id].y
			local bz=JY.Person[pid]["兵种"];
			local menux,menuy;
			--size = 16
			--w/h = 180 / 80
			if x-War.CX>math.modf(War.MW/2) then
				menux=16+War.BoxWidth*(x-War.CX)-180;
			else
				menux=16+War.BoxWidth*(x-War.CX+1);
			end
			if y-War.CY>math.modf(War.MD/2) then
				menuy=32+War.BoxWidth*(y-War.CY)-32;
			else
				menuy=32+War.BoxWidth*(y-War.CY);
			end
			--DrawBox(16+War.BoxWidth*(x-War.CX),32+War.BoxDepth*(y-War.CY),16+War.BoxWidth*(x-War.CX+1),32+War.BoxDepth*(y-War.CY+1),C_WHITE,-1);
			lib.Background(menux,menuy,menux+180,menuy+80,160);
			menux=menux+2;
			menuy=menuy+2;
			local color=M_Cyan;
			local str="我军";
			if War.Person[id].enemy then
				color=M_Red;
				str="敌军";
			elseif War.Person[id].friend then
				color=M_DarkOrange;
				str="友军";
			end
			if War.Person[id].troubled then
				--color=M_Purple;
			end
      DrawString(menux,menuy,string.format("%-8s[w]%-8s%2s 级", JY.Person[pid]["姓名"], JY.Bingzhong[bz]["名称"], JY.Person[pid]["等级"]),color,16);
			--DrawString(menux,menuy,JY.Person[pid]["姓名"],color,16);
			--DrawString(menux+64,menuy,JY.Bingzhong[bz]["名称"].." "..JY.Person[pid]["等级"].."级",C_WHITE,16);
			
			
			local len=120;
			local T={
						100*JY.Person[pid]["兵力"]/JY.Person[pid]["最大兵力"],
						--100*JY.Person[pid]["策略"]/JY.Person[pid]["最大策略"],
						math.min(100*JY.Person[pid]["士气"]/100,100),
						100*JY.Person[pid]["经验"]/100,
					}
			local n=2;
			if flag then
				n=3;
			end
			for i=1,n do
				local color;
				if T[i]<30 then
					color=210;
				elseif T[i]<70 then
					color=211;
				else
					color=212;
				end
				lib.FillColor(menux+48,menuy+4+i*20,menux+48+len,menuy+4+10+i*20,C_BLACK);
				lib.SetClip(menux+47,menuy+4+i*20,menux+48+len*T[i]/100,menuy+4+10+i*20);
				lib.PicLoadCache(4,color*2,menux+48,menuy+4+i*20,1);
				lib.SetClip(0,0,0,0);
			end
			menuy=menuy+20;
			DrawString(menux,menuy,string.format("兵力     %4d/%d",JY.Person[pid]["兵力"],JY.Person[pid]["最大兵力"]),C_WHITE,16);
			menuy=menuy+20;
			DrawString(menux,menuy,string.format("士气     %4d/100",JY.Person[pid]["士气"]),C_WHITE,16);
			--DrawString(menux,menuy,string.format("策略     %4d/%d",JY.Person[pid]["策略"],JY.Person[pid]["最大策略"]),C_WHITE,16);
			menuy=menuy+20;
		if flag then
			DrawString(menux,menuy,string.format("经验     %4d/100",JY.Person[pid]["经验"]),C_WHITE,16);
		else
			local T={[0]="","＋２０％","＋３０％","","","","","＋５％",
						"＋５％","","","","","＋３０％","＋１０％","",
						"","","","",}
			local dx=GetWarMap(x,y,1);
			--DrawString(menux,menuy,str,color,16);
			--DrawString(menux,menuy,string.format("        %s %s",War.DX[dx],T[dx]),C_WHITE,16);
			DrawString(menux,menuy,string.format("%s    %s %s",str,War.DX[dx],T[dx]),C_WHITE,16);
		end
end
--旧风格
function DrawStatus()
	local id;
	if War.SelID>0 then
		id=War.SelID;
	elseif War.CurID>0 then
		id=War.CurID;
	elseif War.LastID>0 then
		id=War.LastID;
	else
		return;
	end
	local pid=War.Person[id].id;
	local p=JY.Person[pid];
	local x=805;
	local y=140;
	local size=16;
	local len=100;
	local T={
				{"兵  力","士气值","攻击力","防御力","策略值","经验值"},
				{100*p["兵力"]/p["最大兵力"],p["士气"],math.min(p["攻击"]/20,100),math.min(p["防御"]/20,100),100*p["策略"]/p["最大策略"],p["经验"]},
				{p["兵力"].."/"..p["最大兵力"],""..p["士气"],""..p["攻击"],""..p["防御"],p["策略"].."/"..p["最大策略"],""..p["经验"]},
			}
	local x_off=x-785;
	DrawString(785+x_off,78,p["姓名"].."  "..JY.Bingzhong[p["兵种"]]["名称"],C_WHITE,size);
	DrawString(900+x_off,78,"等级"..p["等级"],C_WHITE,size);
	DrawString(820+x_off,105,p["武力"],C_WHITE,size);
	DrawString(875+x_off,105,p["智力"],C_WHITE,size);
	DrawString(930+x_off,105,p["统率"],C_WHITE,size);
	for i=1,6 do
		DrawString(x,y,T[1][i],C_WHITE,size);
		local color;
		if T[2][i]<30 then
			color=210;
		elseif T[2][i]<70 then
			color=211;
		else
			color=212;
		end
		lib.FillColor(x+64,y+3,x+64+len,y+3+10,C_BLACK);
		lib.SetClip(x+63,y+3,x+64+len*T[2][i]/100,y+3+10);
		lib.PicLoadCache(4,color*2,x+64,y+3,1);
		lib.SetClip(0,0,0,0);
		DrawString(x+64+len/2-size*#T[3][i]/4,y,T[3][i],C_WHITE,size);
		y=y+size+12;
	end
end
--新风格
function DrawStatus()
	local id;
	if War.SelID>0 then
		id=War.SelID;
	elseif War.CurID>0 then
		id=War.CurID;
	elseif War.LastID>0 then
		id=War.LastID;
	else
		return;
	end
	local wp=War.Person[id];
	local pid=War.Person[id].id;
	local p=JY.Person[pid];
	local x=805;
	local y=204;
	local size=16;
	local len=100;
	local T={
				{"兵  力","士气值","攻击力","防御力","策略值","经验值"},
				{math.min(100*p["兵力"]/p["最大兵力"],100),math.min(p["士气"],100),math.min(p["攻击"]/20,100),math.min(p["防御"]/20,100),math.min(100*p["策略"]/math.max(p["最大策略"],1),100),p["经验"]},
				{p["兵力"].."/"..p["最大兵力"],""..p["士气"],""..p["攻击"],""..p["防御"],p["策略"].."/"..p["最大策略"],""..p["经验"]},
			}
	local x_off=x-785;
	lib.PicLoadCache(4,230*2,804,76,1);
	lib.PicLoadCache(2,p["头像代号"]*2,812,84,1);
	lib.PicLoadCache(4,227*2,900,82,1);
	lib.PicLoadCache(4,228*2,900,112,1);
	lib.PicLoadCache(4,229*2,900,142,1);
	DrawString(x,y-size-8,p["姓名"].."  "..JY.Bingzhong[p["兵种"]]["名称"],C_WHITE,size);
	DrawString(x+115,y-size-8,"等级"..p["等级"],C_WHITE,size);
	for i,v in pairs({"武力2","智力2","统率2"}) do
		DrawString2(932,57+i*30,""..p[v],C_WHITE,size);
	end
	for i=1,6 do
		DrawString(x,y,T[1][i],C_WHITE,size);
		local color;
		if T[2][i]<30 then
			color=210;
		elseif T[2][i]<70 then
			color=211;
		else
			color=212;
		end
		lib.FillColor(x+64,y+3,x+64+len,y+3+10,C_BLACK);
		lib.SetClip(x+63,y+3,x+64+len*T[2][i]/100,y+3+10);
		lib.PicLoadCache(4,color*2,x+64,y+3,1);
		lib.SetClip(0,0,0,0);
		DrawString2(x+64+len/2-size*#T[3][i]/4,y,T[3][i],C_WHITE,size);
		y=y+size+4;
	end
	local leader=0;
	local forcename="";
	leader=p["君主"];	--默认就是自己的君主
	if leader==0 then	--当没有设定时
		if wp.enemy then	--敌人 就用敌人主帅的君主
			leader=JY.Person[War.Leader2]["君主"];
		end
	end
	if leader>0 then
		forcename=JY.Person[leader]["姓名"].."军";
	else
		if wp.enemy then
			forcename="敌军";
		elseif wp.friend then
			forcename="友军";
		else
			forcename="我军";
		end
	end
	
	DrawString(840-#forcename*16/2/2,40,forcename,C_WHITE,16);
	
	
	if CC.Enhancement then
		DrawString(x,y,"技  能",C_WHITE,size);
		DrawSkillTable(pid,x+56,y);
		y=y+44;
		DrawString(x,y,string.format("攻击 %+03d％ 防御 %+03d％",wp.atk_buff,wp.def_buff),C_WHITE,size);
		y=y+24;
	end
	
	if CC.Debug==1 then
		y=y-4;
		if wp.ai==0 then
			DrawString(x,y,"AI: 被动出击",C_WHITE,size);
		elseif wp.ai==1 then
			DrawString(x,y,"AI: 主动出击",C_WHITE,size);
		elseif wp.ai==2 then
			DrawString(x,y,"AI: 坚守原地",C_WHITE,size);
		elseif wp.ai==3 then
			DrawString(x,y,"AI: 攻击 "..JY.Person[wp.aitarget]["姓名"],C_WHITE,size);
		elseif wp.ai==4 then
			DrawString(x,y,"AI: 攻击 "..wp.ai_dx..","..wp.ai_dy,C_WHITE,size);
		elseif wp.ai==5 then
			DrawString(x,y,"AI: 跟随 "..JY.Person[wp.aitarget]["姓名"],C_WHITE,size);
		elseif wp.ai==6 then
			DrawString(x,y,"AI: 移至 "..wp.ai_dx..","..wp.ai_dy,C_WHITE,size);
		else
			DrawString(x,y,"AI: 其他 "..wp.aitarget.." "..wp.ai_dx..","..wp.ai_dy,C_WHITE,size);
		end
	end
end

function DrawSkillTable(pid,x,y)
	local p=JY.Person[pid];
	local cx,cy
	local box_w=36;
	local box_h=20;
	for i=1,6 do
		local cx=x+box_w*((i-1)%3);
		local cy=y+box_h*math.modf((i-1)/3);
		lib.DrawRect(cx,cy,cx+box_w,cy,C_WHITE);
		lib.DrawRect(cx,cy+box_h,cx+box_w,cy+box_h,C_WHITE);
		lib.DrawRect(cx,cy,cx,cy+box_h,C_WHITE);
		lib.DrawRect(cx+box_w,cy,cx+box_w,cy+box_h,C_WHITE);
		lib.Background(cx+1,cy+1,cx+box_w,cy+box_h,240,M_Blue);
		if p["等级"]>=CC.SkillExp[p["成长"]][i] then
			DrawString(cx+2,cy+2,JY.Skill[p["特技"..i]]["名称"],C_WHITE,16);
		else
			DrawString(cx+2,cy+2,"？？",M_Gray,16);
		end
	end
end

function CleanWarMap(lv,v)
	for x=1,War.Width do
		for y=1,War.Depth do
			SetWarMap(x,y,lv,v);
		end
	end
end
function GetWarMap(x,y,lv)
	if x>0 and x<=War.Width and y>0 and y<=War.Depth then
		if lv==1 then
			if War.Map[War.Width*War.Depth*(9-1)+War.Width*(y-1)+x]==1 then
				return 18;
			elseif War.Map[War.Width*War.Depth*(9-1)+War.Width*(y-1)+x]==2 then
				return 19;
			else
				return War.Map[War.Width*War.Depth*(lv-1)+War.Width*(y-1)+x];
			end
		else
			return War.Map[War.Width*War.Depth*(lv-1)+War.Width*(y-1)+x];
		end
	else
		--JY.Person[999]["XX"]=1
		lib.Debug(string.format("error!GetWarMap x=%d,y=%d,width=%d,depth=%d",x,y,War.Width,War.Depth));
		--WarDrawStrBoxConfirm("error!GetWarMap",C_WHITE,true);
		return 0;
	end
end
function SetWarMap(x,y,lv,v)
	if x>0 and x<=War.Width and y>0 and y<=War.Depth then
		War.Map[War.Width*War.Depth*(lv-1)+War.Width*(y-1)+x]=v;
		return 1;
	else
		lib.Debug(string.format("error!SetWarMap x=%d,y=%d,v=%d,width=%d,depth=%d",x,y,v,War.Width,War.Depth));
		return 0;
	end
end
function filelength(filename)         --得到文件长度
    local inp=io.open(filename,"rb");
	if inp==nil then
		return -1;
	end
    local l= inp:seek("end");
	inp:close();
    return l;
end
function LoadWarMap(id)
	local len=filelength(CC.MapFile);
	local data=Byte.create(len);
	Byte.loadfile(data,CC.MapFile,0,len);
	local map_num=58;
	local idx1,idx2,idx3,idx4=Byte.get8(data,16+256+12*id+8),Byte.get8(data,16+256+12*id+9),Byte.get8(data,16+256+12*id+10),Byte.get8(data,16+256+12*id+11);
	if idx1<0 then
		idx1=idx1+256
	end
	if idx2<0 then
		idx2=idx2+256
	end
	if idx3<0 then
		idx3=idx3+256
	end
	if idx4<0 then
		idx4=idx4+256
	end
	local idx=idx4+256*idx3+256^2*idx2+256^3*idx1;
	War.Width=Byte.get8(data,idx)/2;
	War.Depth=Byte.get8(data,idx+1)/2;
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
	idx=idx+2+4*War.Width*War.Depth;
	for i=1,War.Width*War.Depth do
		local v=Byte.get8(data,idx+(i-1));
		if v<0 or v>19 then
			lib.Debug(string.format("!!Error, MapID=%d,idx=%d,v=%d",id,i,v))
			v=0;
		end
		War.Map[i]=v;--Byte.get8(data,idx+(i-1));
	end
end
----------------------------------------------------------------
--	WarSearchMove(id,x,y)
--	寻找移动到x,y的最近路径
--	flag,为true时无视敌人拦路
----------------------------------------------------------------
function WarSearchMove(id,x,y,flag)
	flag=flag or false
	local stepmax=256;
	CleanWarMap(4,0);           --第4层坐标用来设置移动，先都设为0
	local steparray={};     --用数组保存第n步的坐标．
	for i=0,stepmax do
	    steparray[i]={};
        steparray[i].num=0;
        steparray[i].x={};
        steparray[i].y={};
        steparray[i].m={};
	end
	SetWarMap(x,y,4,stepmax+1);
    steparray[0].num=1;
	steparray[0].x[1]=x;
	steparray[0].y[1]=y;
	steparray[0].m[1]=stepmax;
	for i=0,stepmax-1 do       --根据第0步的坐标找出第1步，然后继续找
	    WarSearchMove_sub(steparray,i,id,flag);
		if steparray[i+1].num==0 then
		    break;
		end
    end
	return;
end
function WarSearchMove_sub(steparray,step,id,flag)      --设置下一步可移动的坐标
    local num=0;
	local step1=step+1;
	local pid=War.Person[id].id;
	local bz=JY.Person[pid]["兵种"];
	for i=1,steparray[step].num do
		if steparray[step].m[i]>0 then
			local x=steparray[step].x[i];
			local y=steparray[step].y[i];
			for d=1,4 do--当前步数的相邻格
				local nx,ny=x+CC.DirectX[d],y+CC.DirectY[d];
				if nx>0 and nx<=War.Width and ny>0 and ny<=War.Depth then
					local v=GetWarMap(nx,ny,4);
					local dx=GetWarMap(nx,ny,1);
					if v==0 and steparray[step].m[i]>=JY.Bingzhong[bz]["地形"..dx] and War_CanMoveXY(nx,ny,id,flag) then
						num=num+1;
						steparray[step1].x[num]=nx;
						steparray[step1].y[num]=ny;
						if CheckZOC(id,nx,ny) then
							steparray[step1].m[num]=steparray[step].m[i]-JY.Bingzhong[bz]["地形"..dx]-JY.Bingzhong[bz]["移动"];
						else
							steparray[step1].m[num]=steparray[step].m[i]-JY.Bingzhong[bz]["地形"..dx];
						end
						SetWarMap(nx,ny,4,steparray[step1].m[num]+1);
					end
				end
			end
		end
	end
    steparray[step1].num=num;
end
----------------------------------------------------------------
--	WarSearchBZ(id)
--	寻找最近我方指定兵种
----------------------------------------------------------------
function WarSearchBZ(id,bzid)
	local stepmax=256;
	CleanWarMap(4,0);           --第4层坐标用来设置移动，先都设为0，
    local x=War.Person[id].x;
    local y=War.Person[id].y;
	local steparray={};     --用数组保存第n步的坐标．
	for i=0,stepmax do
	    steparray[i]={};
        steparray[i].num=0;
        steparray[i].x={};
        steparray[i].y={};
        steparray[i].m={};
	end
	SetWarMap(x,y,4,stepmax+1);
    steparray[0].num=1;
	steparray[0].x[1]=x;
	steparray[0].y[1]=y;
	steparray[0].m[1]=stepmax;
	for i=0,stepmax-1 do       --根据第0步的坐标找出第1步，然后继续找
	    local eid=WarSearchBZ_sub(steparray,i,id,bzid,true);
		if eid>0 then
			return eid;
		end
		if steparray[i+1].num==0 then
		    break;
		end
    end
	return 0;
end
function WarSearchBZ_sub(steparray,step,id,bzid,flag)      --设置下一步可移动的坐标
    local num=0;
	local step1=step+1;
	local pid=War.Person[id].id;
	local bz=JY.Person[pid]["兵种"];
	for i=1,steparray[step].num do
		if steparray[step].m[i]>0 then
			local x=steparray[step].x[i];
			local y=steparray[step].y[i];
			for d=1,4 do--当前步数的相邻格
				local nx,ny=x+CC.DirectX[d],y+CC.DirectY[d];
				if nx>0 and nx<=War.Width and ny>0 and ny<=War.Depth then
					local v=GetWarMap(nx,ny,4);
					local dx=GetWarMap(nx,ny,1);
					if v==0 and steparray[step].m[i]>=JY.Bingzhong[bz]["地形"..dx] and War_CanMoveXY(nx,ny,id,flag) then
						num=num+1;
						steparray[step1].x[num]=nx;
						steparray[step1].y[num]=ny;
						steparray[step1].m[num]=steparray[step].m[i]-JY.Bingzhong[bz]["地形"..dx];
						SetWarMap(nx,ny,4,steparray[step1].m[num]+1);
						local eid=GetWarMap(nx,ny,2);
						if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) and War.Person[id].enemy==War.Person[eid].enemy then
						-- 有人               活着                        非伏兵                      
							if bzid==War.Person[eid].bz and JY.Person[War.Person[eid].id]["策略"]>=6 then
								return eid;
							end
						end
					end
				end
			end
		end
	end
    steparray[step1].num=num;
	return 0;
end
----------------------------------------------------------------
--	WarSearchEnemy(id)
--	寻找最近敌人
----------------------------------------------------------------
function WarSearchEnemy(id)
	local stepmax=256;
	CleanWarMap(4,0);           --第4层坐标用来设置移动，先都设为0，
    local x=War.Person[id].x;
    local y=War.Person[id].y;
	local steparray={};     --用数组保存第n步的坐标．
	for i=0,stepmax do
	    steparray[i]={};
        steparray[i].num=0;
        steparray[i].x={};
        steparray[i].y={};
        steparray[i].m={};
	end
	SetWarMap(x,y,4,stepmax+1);
    steparray[0].num=1;
	steparray[0].x[1]=x;
	steparray[0].y[1]=y;
	steparray[0].m[1]=stepmax;
	local eidbk=0;
	for i=0,stepmax-1 do       --根据第0步的坐标找出第1步，然后继续找
	    local eid=WarSearchEnemy_sub(steparray,i,id,true);
		if eid>0 then
			return eid;
		end
		if eidbk==0 and eid<0 then
			eidbk=-eid;
		end
		if steparray[i+1].num==0 then
		    break;
		end
    end
	return eidbk;
end
function WarSearchEnemy_sub(steparray,step,id,flag)      --设置下一步可移动的坐标
    local num=0;
	local step1=step+1;
	local pid=War.Person[id].id;
	local bz=JY.Person[pid]["兵种"];
	local eidbk=0;
	for i=1,steparray[step].num do
		if steparray[step].m[i]>0 then
			local x=steparray[step].x[i];
			local y=steparray[step].y[i];
			for d=1,4 do--当前步数的相邻格
				local nx,ny=x+CC.DirectX[d],y+CC.DirectY[d];
				if nx>0 and nx<=War.Width and ny>0 and ny<=War.Depth then
					local v=GetWarMap(nx,ny,4);
					local dx=GetWarMap(nx,ny,1);
					if v==0 and steparray[step].m[i]>=JY.Bingzhong[bz]["地形"..dx] and War_CanMoveXY(nx,ny,id,flag) then
						num=num+1;
						steparray[step1].x[num]=nx;
						steparray[step1].y[num]=ny;
						steparray[step1].m[num]=steparray[step].m[i]-JY.Bingzhong[bz]["地形"..dx];
						SetWarMap(nx,ny,4,steparray[step1].m[num]+1);
						local eid=GetWarMap(nx,ny,2);
						if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) and War.Person[id].enemy~=War.Person[eid].enemy then
						-- 有人               活着                        非伏兵                      敌人	
							--在已经搜寻过的坐标里，存在可以攻击的坐标
							local array=WarGetAtkFW(nx,ny,War.Person[id].atkfw);
							for n=1,array.num do
								if between(array[n][1],1,War.Width) and between(array[n][2],1,War.Depth) then
									if GetWarMap(array[n][1],array[n][2],4)>0 and GetWarMap(array[n][1],array[n][2],2)==0 then
										return eid;
									end
								end
							end
							eidbk=-eid;
							--return eid;
						end
					end
				end
			end
		end
	end
    steparray[step1].num=num;
	return 0;
end
----------------------------------------------------------------
--	War_CalAtkFW(wid)
--	显示wid的攻击范围
----------------------------------------------------------------
function War_CalAtkFW(wid)
	local array=WarGetAtkFW(War.Person[wid].x,War.Person[wid].y,War.Person[wid].atkfw);
	for i=1,array.num do
		local mx,my=array[i][1],array[i][2];
		if between(mx,1,War.Width) and between(my,1,War.Depth) then
			SetWarMap(mx,my,10,1);
		end
	end
end

--计算可移动步数
--id 战斗人id，
--stepmax 最大步数，
--flag=0  移动，物品不能绕过，1 武功，用毒医疗等，不考虑挡路．
function War_CalMoveStep(id,stepmax,flag)                   --计算可移动步数

  	CleanWarMap(4,0);           --第4层坐标用来设置移动，先都设为0，

    local x=War.Person[id].x;
    local y=War.Person[id].y;

	local steparray={};     --用数组保存第n步的坐标．
	for i=0,stepmax do
	    steparray[i]={};
        steparray[i].num=0;
        steparray[i].x={};
        steparray[i].y={};
        steparray[i].m={};
	end

	--SetWarMap(x,y,4,1);
	SetWarMap(x,y,4,stepmax+1);
    steparray[0].num=1;
	steparray[0].x[1]=x;
	steparray[0].y[1]=y;
	steparray[0].m[1]=stepmax;
	for i=0,stepmax-1 do       --根据第0步的坐标找出第1步，然后继续找
	    War_FindNextStep(steparray,i,id,flag);
		if steparray[i+1].num==0 then
		    break;
		end
    end

	return steparray;

end

function War_FindNextStep(steparray,step,id,flag)      --设置下一步可移动的坐标
    local num=0;
	local step1=step+1;
	local pid=War.Person[id].id;
	local bz=JY.Person[pid]["兵种"];
	for i=1,steparray[step].num do
		if steparray[step].m[i]>0 then
			local x=steparray[step].x[i];
			local y=steparray[step].y[i];
			for d=1,4 do--当前步数的相邻格
				local nx,ny=x+CC.DirectX[d],y+CC.DirectY[d];
				if nx>0 and nx<=War.Width and ny>0 and ny<=War.Depth then
					local v=GetWarMap(nx,ny,4);
					local dx=GetWarMap(nx,ny,1);
					if v==0 and steparray[step].m[i]>=JY.Bingzhong[bz]["地形"..dx] and War_CanMoveXY(nx,ny,id,flag) then
						num=num+1;
						steparray[step1].x[num]=nx;
						steparray[step1].y[num]=ny;
						if (not flag) and CheckZOC(id,nx,ny) then
							steparray[step1].m[num]=0;
						else
							steparray[step1].m[num]=steparray[step].m[i]-JY.Bingzhong[bz]["地形"..dx];
						end
						SetWarMap(nx,ny,4,steparray[step1].m[num]+1);
					end
				end
			end
		end
	end
    steparray[step1].num=num;
end
function CheckZOC(id,x,y)
	if CC.Enhancement then
		if WarCheckSkill(id, 34) or WarCheckSkill(id, 71) then	--强行 血路
			return false;
		end
	end
  local dx = GetWarMap(x, y, 1);--		08 村庄  0D 鹿砦  0E  兵营  0F  粮仓		10 宝物库
  if dx == 8 or dx == 13 or dx == 14 or dx == 15 or dx == 16 then
    return true;
  end
	for d=1,4 do--当前步数的相邻格
		local nx,ny=x+CC.DirectX[d],y+CC.DirectY[d];
		if nx>0 and nx<=War.Width and ny>0 and ny<=War.Depth then
			local eid=GetWarMap(nx,ny,2);
			if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) and War.Person[id].enemy~=War.Person[eid].enemy then
				return true;
			end
		end
	end
	return false;
end
function War_CanMoveXY(x,y,pid,flag)  --坐标是否可以通过，判断移动时使用
	local id1=War.Person[pid].id;
	local bz=JY.Person[id1]["兵种"];
	local dx=GetWarMap(x,y,1);
	if JY.Bingzhong[bz]["地形"..dx]==0 then
		return false;
	end
	local eid=GetWarMap(x,y,2);
	if eid>0 and (not flag) and War.Person[eid].live and (not War.Person[eid].hide) and War.Person[pid].enemy~=War.Person[eid].enemy then
		return false;
	end
	return true;
end
function WarCanExistXY(x,y,pid)  --坐标是否可以通过
	local id1=War.Person[pid].id;
	local bz=JY.Person[id1]["兵种"];
	local dx=GetWarMap(x,y,1);
	if JY.Bingzhong[bz]["地形"..dx]==0 then
		return false;
	end
	local eid=GetWarMap(x,y,2);
	if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) then
		return false;
	end
	return true;
end
function War_MovePerson(x,y,flag)            --移动人物到位置x,y
	War.ControlEnableOld=War.ControlEnable;
	War.ControlEnable=false;
	War.InMap=false;
	flag=flag or 0;
    local movenum=GetWarMap(x,y,4);
	local dx,dy=x,y;
    local movetable={};  --   记录每步移动
	local mx,my=War.Person[War.SelID].x,War.Person[War.SelID].y;
	local dm=GetWarMap(mx,my,4);
	local start=dm;
	local str=JY.Person[War.Person[War.SelID].id]["姓名"]..'的移动';
	for i=1,dm do
		if mx==x and my==y then
			start=i-1;
			break;
		end
		movetable[i]={};
        movetable[i].x=x;
        movetable[i].y=y;
		local fx,fy;
		for d=1,4 do
			local nx,ny=x-CC.DirectX[d],y-CC.DirectY[d];
			if between(nx,1,War.Width) and between(ny,1,War.Depth) then
				local v=GetWarMap(nx,ny,4);
				if v>movenum then
					movenum=v;
					fx,fy=nx,ny;
					movetable[i].direct=d;
				end
			end
		end
		x,y=fx,fy;
	end
	--8是标准速度，6偏快，4很快,3极快，12慢,16
	local step=War.Person[War.SelID].movespeed;
	--if War.MoveSpeed==1 or true then
	--	step=step*3/4
	--end
	SetWarMap(War.Person[War.SelID].x,War.Person[War.SelID].y,2,0);
	SetWarMap(dx,dy,2,War.SelID);
	War.ControlEnable=false;
	War.InMap=false;
	War.Person[War.SelID].action=1;
	local sframe=0;
    for i=start,1,-1 do
		War.Person[War.SelID].d=movetable[i].direct;
		local cx=War.Person[War.SelID].x+CC.DirectX[movetable[i].direct];
		local cy=War.Person[War.SelID].y+CC.DirectY[movetable[i].direct];
		if War.SelID>0 then
			if not between(War.CX,cx-War.MW+1,cx-1) then
				War.CX=limitX(War.CX,cx-War.MW+3,cx-3);
				War.CX=limitX(War.CX,1,War.Width-War.MW+1);
			end
			if not between(War.CY,cy-War.MD+1,cy-1) then
				War.CY=limitX(War.CY,cy-War.MD+2,cy-2);
				War.CY=limitX(War.CY,1,War.Depth-War.MD+1);
			end
		end
		for t=1,step do
			War.Person[War.SelID].x=War.Person[War.SelID].x+CC.DirectX[movetable[i].direct]/step;
			War.Person[War.SelID].y=War.Person[War.SelID].y+CC.DirectY[movetable[i].direct]/step;
			lib.GetKey(1);
			--War.Person[War.SelID].frame=math.modf((step*(i-1)+t)/2)%2;
			War.Person[War.SelID].frame=math.modf(sframe/4)%2;
			--[[
			if (step*(i-1)+t)%8==1 then
				PlayWavE(War.Person[War.SelID].movewav);
			end]]--
			if sframe==0 then
				PlayWavE(War.Person[War.SelID].movewav);
			end
			if sframe==7 then
				sframe=0;
			else
				sframe=sframe+1;
			end
			JY.ReFreshTime=lib.GetTime();
			DrawWarMap();
			DrawYJZBox2(-256,64,str,C_WHITE);
			ReFresh();
		end
		War.Person[War.SelID].x=cx;
		War.Person[War.SelID].y=cy;
    end
	--PlayWavE(War.Person[War.SelID].movewav);
	if War.Person[War.SelID].active then
		War.Person[War.SelID].action=1;
	else
		War.Person[War.SelID].action=0;
	end
	War.Person[War.SelID].frame=-1;
	War.Person[War.SelID].x=dx;
	War.Person[War.SelID].y=dy;
	BoxBack();
	local pid=War.Person[War.SelID].id;
	ReSetAttrib(pid,false);
	ReSetAllBuff();
	--War.CurID=War.SelID;
	War.CurID=0;
	--War.ControlEnable=true----War.ControlEnableOld;
end

function ReSetAttrib(id,flag)
	local p = JY.Person[id];
	local wid = GetWarID(id);
  local dx = 0;
	if wid > 0 then
		War.Person[wid].sq_limited = 100;
		dx = GetWarMap(War.Person[wid].x, War.Person[wid].y, 1);
	else
		p["士气"] = 100;
	end
	if CC.Enhancement then
		if CheckSkill(id,7) then	--威风
			if wid>0 then
				War.Person[wid].sq_limited=JY.Skill[7]["参数1"];
			else
				p["士气"]=JY.Skill[7]["参数1"];
			end
		end
	end
	if wid>0 and flag then
		p["士气"]=War.Person[wid].sq_limited;
	end
	if CC.Enhancement and wid>0 then
		if CheckSkill(id,31) then	--精兵
			if p["士气"]<JY.Skill[31]["参数1"] then
				p["士气"]=math.min(War.Person[wid].sq_limited,JY.Skill[31]["参数1"]);
			end
		end
	end
	local bid=p["兵种"];
	local b=JY.Bingzhong[bid];
	p["最大兵力"]=b["基础兵力"]+b["兵力增长"]*(p["等级"]-1);
	if CC.Enhancement then
		if CheckSkill(id,6) or CheckSkill(id,37) then	--雄师/魏武
			p["最大兵力"]=b["基础兵力"]+JY.Skill[6]["参数1"]+(b["兵力增长"]+JY.Skill[6]["参数2"])*(p["等级"]-1);
		end
	end
	if wid>0 and CC.Enhancement then
		if CheckSkill(id,45) then	--霸气
			War.Person[wid].atkfw=JY.Skill[45]["参数1"];
    elseif (between(bid,4,6) or bid==22) and CheckSkill(id,65) then	--乱射
      War.Person[wid].atkfw=JY.Bingzhong[bid]["攻击范围"] + 1;	--攻击范围
    end
	end
	
	--Get Weapon
	local weapon1=0;
	local weapon2=0;
	local weapon3=0;
	for i=1,8 do
		local item=p["道具"..i]
		if item>0 then
			local canuse=false;
			if JY.Item[item]["需兵种1"]==0 then
				canuse=true;
			else
				for n=1,7 do
					if JY.Item[item]["需兵种"..n]==p["兵种"] then
						canuse=true;
						break;
					end
				end
			end
			if p["等级"]<JY.Item[item]["需等级"] then
				canuse=false;
			end
			if canuse then
				if JY.Item[item]["装备位"]==1 then
					if weapon1==0 or JY.Item[item]["优先级"]>JY.Item[weapon1]["优先级"] then
						weapon1=item;
					end
				elseif JY.Item[item]["装备位"]==2 then
					if weapon2==0 or JY.Item[item]["优先级"]>JY.Item[weapon2]["优先级"] then
						weapon2=item;
					end
				elseif JY.Item[item]["装备位"]==3 then
					if weapon3==0 or JY.Item[item]["优先级"]>JY.Item[weapon3]["优先级"] then
						weapon3=item;
					end
				end
			end
		end
	end
	p["武器"]=weapon1;
	p["防具"]=weapon2;
	p["辅助"]=weapon3;
	
	--计算武器加成后的属性
	local p_wuli=p["武力"];
	local p_tongshuai=p["统率"];
	local p_zhili=p["智力"];
	local atk,def,mov=0,0,0;
	mov=b["移动"];
	if weapon1>0 then
		p_wuli=p_wuli+JY.Item[weapon1]["武力"];
		p_zhili=p_zhili+JY.Item[weapon1]["智力"];
		p_tongshuai=p_tongshuai+JY.Item[weapon1]["统率"];
		atk=atk+JY.Item[weapon1]["攻击"];
		def=def+JY.Item[weapon1]["防御"];
		mov=mov+JY.Item[weapon1]["移动"];
	end
	if weapon2>0 then
		p_wuli=p_wuli+JY.Item[weapon2]["武力"];
		p_zhili=p_zhili+JY.Item[weapon2]["智力"];
		p_tongshuai=p_tongshuai+JY.Item[weapon2]["统率"];
		atk=atk+JY.Item[weapon2]["攻击"];
		def=def+JY.Item[weapon2]["防御"];
		mov=mov+JY.Item[weapon2]["移动"];
	end
	if weapon3>0 then
		p_wuli=p_wuli+JY.Item[weapon3]["武力"];
		p_zhili=p_zhili+JY.Item[weapon3]["智力"];
		p_tongshuai=p_tongshuai+JY.Item[weapon3]["统率"];
		atk=atk+JY.Item[weapon3]["攻击"];
		def=def+JY.Item[weapon3]["防御"];
		mov=mov+JY.Item[weapon3]["移动"];
	end
	p["武力2"]=p_wuli;
	p["智力2"]=p_zhili;
	p["统率2"]=p_tongshuai;
	--p["最大策略"]=math.modf(p["智力"]*(p["等级"]+10)/40);
	p["最大策略"]=math.modf(p_zhili*(p["等级"]+10)/40)--+b["策略成长"]*p["等级"];
	if flag then
		p["兵力"]=p["最大兵力"];
		p["策略"]=p["最大策略"];
	else
		p["兵力"]=limitX(p["兵力"],0,p["最大兵力"]);
    p["策略"]=limitX(p["策略"],0,p["最大策略"]);
	end
  
	--（（4000÷（140－武力）＋兵种基本攻击力×2＋士气）×（等级＋10）÷10）×（100＋宝物攻击加成）÷100
	p["攻击"]=math.modf(((4000/math.max(140-p_wuli,30))*(p["等级"]+10)/10+(b["攻击"]+p["士气"])*(p["等级"]+10)/10)*(100+atk)/100);
	p["防御"]=math.modf(((4000/math.max(140-p_tongshuai,30))*(p["等级"]+10)/10+(b["防御"]+p["士气"])*(p["等级"]+10)/10)*(100+def)/100);
	if CC.Enhancement then
		if CheckSkill(id,30) then	--无双
			p["攻击"]=p["攻击"] + JY.Skill[30]["参数1"] * (p["等级"] + 10);
			p["防御"]=p["防御"] + JY.Skill[30]["参数1"] * (p["等级"] + 10);
		else	--有无双，则不考虑勇武和坚韧
			if CheckSkill(id,8) then	--勇武
				p["攻击"]=p["攻击"] + JY.Skill[8]["参数1"] * (p["等级"] + 10);
			end
			if CheckSkill(id,9) then	--坚韧
				p["防御"]=p["防御"] + JY.Skill[9]["参数1"] * (p["等级"] + 10);
			end
		end
    for skillID = 57, 62 do
      if CheckSkill(id, skillID) then	--奋战坚守舍身谨慎勇武铁壁
        p["攻击"] = p["攻击"] + JY.Skill[skillID]["参数1"] * (p["等级"] + 10);
        p["防御"] = p["防御"] + JY.Skill[skillID]["参数2"] * (p["等级"] + 10);
      end
    end
		if JY.Bingzhong[p["兵种"]]["远程"]>0 and CheckSkill(id,24) then	--强弓
			p["攻击"]=p["攻击"]+JY.Skill[24]["参数1"] * (p["等级"] + 10);
			p["防御"]=p["防御"]+JY.Skill[24]["参数2"] * (p["等级"] + 10);
		end
		if JY.Bingzhong[p["兵种"]]["骑马"]>0 and CheckSkill(id,25) then	--强骑
			p["攻击"]=p["攻击"]+JY.Skill[25]["参数1"] * (p["等级"] + 10);
			p["防御"]=p["防御"]+JY.Skill[25]["参数2"] * (p["等级"] + 10);
		end
		if p["兵种"] == 14 and CheckSkill(id, 66) then	--驱兽
			p["攻击"] = p["攻击"] + JY.Skill[66]["参数1"] * (p["等级"] + 10);
			p["防御"] = p["防御"] + JY.Skill[66]["参数2"] * (p["等级"] + 10);
			mov = mov + JY.Skill[66]["参数3"];
		end
		if CheckSkill(id,10) then	--速攻
			mov=mov+JY.Skill[10]["参数1"];
		end
		if 100 * p["兵力"] / p["最大兵力"] < JY.Skill[63]["参数1"] and CheckSkill(id, 63) then	--遁走
			mov = mov + JY.Skill[63]["参数2"];
		end
		if (dx == 1 or dx == 2 or dx == 11) and CheckSkill(id, 69) then	--好汉
			mov = mov + JY.Skill[69]["参数3"];
		end
	end
	p["移动"] = mov;
	if wid>0 then
		War.Person[wid].movestep = mov;
	end
	
	--Buff
	if wid > 0 then
		ReSetBuff(wid);
	end
end
function ReSetAllBuff()
	for wid,wp in pairs(War.Person) do
		if wp.live and (not wp.hide) then
			ReSetBuff(wid);
		end
	end
end
function ReSetBuff(wid)
	if wid>0 and CC.Enhancement then
    local wp = War.Person[wid]
		local pid=wp.id;
		local p=JY.Person[pid];
		wp.atk_buff=0;
		wp.def_buff=0;
		--地形
		local T={[0]=0,20,30,0,0,	--森林　20　山地　30
					0,0,5,5,0,		--村庄　 5	草原　 5
					0,0,0,30,10,		--鹿寨　30　兵营　10
					0,0,0,0,0,
					0,0,0,0,0,
					0,0,0,0,0}
		local dx = GetWarMap(wp.x, wp.y, 1);
		wp.def_buff=wp.def_buff+T[dx];
		--背水
		if WarCheckSkill(wid,28) then
			wp.atk_buff=wp.atk_buff+JY.Skill[28]["参数2"]*math.modf(100*(p["最大兵力"]-p["兵力"])/p["最大兵力"]/JY.Skill[28]["参数1"]);
			wp.def_buff=wp.def_buff+JY.Skill[28]["参数2"]*math.modf(100*(p["最大兵力"]-p["兵力"])/p["最大兵力"]/JY.Skill[28]["参数1"]);
		else
			--猛者
			if WarCheckSkill(wid,27) then
				wp.atk_buff=wp.atk_buff+JY.Skill[27]["参数2"]*math.modf(100*(p["最大兵力"]-p["兵力"])/p["最大兵力"]/JY.Skill[27]["参数1"]);
			end
			--不屈
			if WarCheckSkill(wid,26) then
				wp.def_buff=wp.def_buff+JY.Skill[26]["参数2"]*math.modf(100*(p["最大兵力"]-p["兵力"])/p["最大兵力"]/JY.Skill[26]["参数1"]);
			end
		end
		
		--伏兵
		if wp.was_hide then
			if WarCheckSkill(wid,21) then
				wp.atk_buff=wp.atk_buff+JY.Skill[21]["参数1"];
				wp.def_buff=wp.def_buff+JY.Skill[21]["参数1"];
			end
		end
		--谨慎
		if WarCheckSkill(wid,29) then
			wp.atk_buff=wp.atk_buff-JY.Skill[29]["参数1"];
			wp.def_buff=wp.def_buff+JY.Skill[29]["参数2"];
		end
		--城战
		if (dx==6 or dx==13 or dx==14) and WarCheckSkill(wid,32) then
		--		00 平原  01 森林  02 山地  03 河流  04 桥梁  05  城墙  06  城池  07  草原
        --		08 村庄  09 悬崖  0A 城门  0B 荒地  0C 栅栏  0D 鹿砦  0E  兵营  0F  粮仓
        --		10 宝物库  11 房舍  12 火焰  13 浊流
      wp.atk_buff=wp.atk_buff+JY.Skill[32]["参数1"];
		end
		--乱战
		if dx == 1 and WarCheckSkill(wid,64) then
      wp.atk_buff=wp.atk_buff+JY.Skill[64]["参数1"];
		end
		if (dx == 1 or dx == 2 or dx == 11) and WarCheckSkill(wid, 69) then	--好汉
			wp.atk_buff = wp.atk_buff + JY.Skill[69]["参数1"];
			wp.def_buff = wp.def_buff + JY.Skill[69]["参数2"];
		end
		--龙胆
		if WarCheckSkill(wid,49) then
			local value=0;
			local array=WarGetAtkFW(wp.x,wp.y,2);
			for i=1,4 do
				local eid=GetWarMap(array[i][1],array[i][2],2);
				if eid>0 then
					if wp.enemy~=War.Person[eid].enemy then
						value=value+JY.Skill[49]["参数1"];
					end
				end
			end
			for i=5,8 do
				local eid=GetWarMap(array[i][1],array[i][2],2);
				if eid>0 then
					if wp.enemy~=War.Person[eid].enemy then
						value=value+JY.Skill[49]["参数2"];
					end
				end
			end
			wp.atk_buff=wp.atk_buff+value;
			wp.def_buff=wp.def_buff+value;
		end
		--布阵类
    local leader;
    local team_atk = 0;
    local team_def = 0;
    if wp.enemy then
      leader = War.Leader2;
    else
      leader = War.Leader1;
    end
    
    if CheckSkill(leader,38) or WarCheckSkill(wid,38) then   --八阵
      team_atk = math.max(team_atk, JY.Skill[38]["参数1"]);
      team_def = math.max(team_def, JY.Skill[38]["参数1"]);
    end
    if CheckSkill(leader,37) or WarCheckSkill(wid,37) then   --魏武
      team_atk = math.max(team_atk, JY.Skill[37]["参数1"]);
      team_def = math.max(team_def, JY.Skill[37]["参数1"]);
    end
    if CheckSkill(leader,36) or WarCheckSkill(wid,36) then   --布阵
      team_def = math.max(team_def, JY.Skill[36]["参数1"]);
    end
    if CheckSkill(leader,67) or WarCheckSkill(wid,67) then   --蛮王
      if between(p["兵种"], 10, 12) or  p["兵种"] == 14 or p["兵种"] == 15 or p["兵种"] == 17 then
        team_atk = math.max(team_atk, JY.Skill[67]["参数1"]);
      end
    end
		--血路
    if leader > 0 and WarCheckSkill(wid, 71) then
      local lwid = GetWarID(leader);
      local lwp = War.Person[lwid]
      if lwid > 0 and lwp.live and (not lwp.hide) then
        local dx = math.abs(lwp.x - wp.x);
        local dy = math.abs(lwp.y - wp.y);
        local distance = 10 * math.max(dx, dy) + 5 * math.min(dx, dy);
        local value = math.max(0, JY.Skill[71]["参数1"] - distance);
        wp.atk_buff = wp.atk_buff + value;
        wp.def_buff = wp.def_buff + value;
      end
    end
    
		wp.atk_buff=limitX(wp.atk_buff + team_atk,-50,95);
		wp.def_buff=limitX(wp.def_buff + team_def,-50,95);
	end
end
--行动顺序的判定以自动补给后的数据为准．
--最优先行动的是处于恢复性地形（村庄、兵营、鹿砦）中的部队，若有数只部队处于恢复性地形上，则以其在屏幕右上方的敌军列表中的顺序排列．
--第二优先行动的是兵力小于最大兵力的40％或士气低于40的部队，若右数只部门处于该情形下，则以其在屏幕右上方的敌军列表中的顺序进行排列．
--最后余下的部队按屏幕右上方的敌军列表中的顺序进行排列．
function AI()
	War.ControlEnableOld = War.ControlEnable;
  local function actionOrder(wid)
    local wp = War.Person[wid];
    if wp.hide or wp.troubled then
      return 0;
    end
    local pt;
    if wp.hide or wp.troubled then
      pt = 0;
    else
      pt = 10;
    end
    local dx = GetWarMap(wp.x, wp.y, 1);
    --
    if dx == 8 or dx == 13 or dx == 14 then
      pt = pt + 50;
    end
    if JY.Person[wp.id]["兵力"] / JY.Person[wp.id]["最大兵力"] <= 0.4 or JY.Person[wp.id]["士气"] <= 40 then
      pt = pt + 20;
    end
    pt = pt + 2 * limitX(10 - wp.atkfw, 0, 10);
    if wp.id <= 256 then
      pt = pt + 1;
    end
    if wp.id == 387 then  --典韦
      pt = 1;
    end
    return pt;
  end
	--友军
	local flag = true;
  local wpList = {};
  for i, v in pairs(War.Person) do
    if v.live and v.active and (not v.enemy) and v.friend then
      table.insert(wpList, i);
    end
  end
  table.sort(wpList, function(a, b)
    return actionOrder(a) > actionOrder(b);
  end);
  for id, wid in ipairs(wpList) do
    if JY.Status ~= GAME_WMAP then
			return;
		end
    local wp = War.Person[wid];
    if wp.live and wp.active and (not wp.hide) and (not wp.troubled) and (not wp.enemy) and wp.friend then
			War.ControlEnable = false;
			War.InMap = false;
			if flag then
				--敌军状况
				WarDrawStrBoxDelay('友军状况', C_WHITE);
        WarRest(1);
				flag = false;
			end
			AI_Sub(wid);
    end
  end
	
	
	--敌军
	WarGetAramyAtkFW();
	flag = true;
  wpList = {};
  for i, v in pairs(War.Person) do
    if v.live and v.active and v.enemy then
      table.insert(wpList, i);
    end
  end
  table.sort(wpList, function(a, b)
    return actionOrder(a) > actionOrder(b);
  end);
  for id, wid in ipairs(wpList) do
    if JY.Status ~= GAME_WMAP then
			return;
		end
    local wp = War.Person[wid];
    if wp.live and wp.active and (not wp.hide) and (not wp.troubled) and wp.enemy then
			War.ControlEnable = false;
			War.InMap = false;
			if flag then
				--敌军状况
				WarDrawStrBoxDelay('敌军状况', C_WHITE);
        WarRest(2);
				flag = false;
			end
			AI_Sub(wid);
    end
  end
	
	--War.ControlEnable=true----War.ControlEnableOld;
end
function WarGetAramyAtkFW()
	CleanWarMap(8,0);
	for i,v in pairs(War.Person) do
		if not v.enemy then
			if not v.hide then
				if v.live then
					local len=1;
					if v.atkfw==2 or v.atkfw==3 then
						len=2;
					elseif v.atkfw==4 then
						len=3;
					elseif v.atkfw==5 then
						len=4;
					end
					CleanWarMap(5,-1);
					local steparray=War_CalMoveStep(i,v.movestep+len);
					for j=0,v.movestep+len do
						for k=1,steparray[j].num do
							local mx,my=steparray[j].x[k],steparray[j].y[k];
							SetWarMap(mx,my,8,GetWarMap(mx,my,8)+1)
						end
					end
				end
			end
		end
	end
	CleanWarMap(5,-1);
end
function WarGetAramyAtkFW()
	CleanWarMap(8,0);
	for i,v in pairs(War.Person) do
		if not v.enemy then
			if not v.hide then
				if v.live then
					local array=WarGetAtkFW(v.x,v.y,2);
					for j=1,array.num do
						local mx,my=array[j][1],array[j][2];
						if between(mx,1,War.Width) and between(my,1,War.Depth) then
							local n=2;
							if j>4 then
								n=1;
							end
							local ov=GetWarMap(mx,my,8);
							if n>ov then
								SetWarMap(mx,my,8,n);
							end
						end
					end
				end
			end
		end
	end
end
function AI_Sub(id)
	--AI类型＝00	被动出击型，部队在原地不移动，但如果有敌人进入其移动后还能攻击到的地方，部队将移动并进行攻击．
	--AI类型＝01	主动出击型，部队会主动移动并攻击
	--AI类型＝02	坚守原地型，部队在原地不移动，即使受到攻击也是如此，但如果有人进入其攻击范围，部队将发起攻击．
	--AI类型＝03	追击指定目标
	--AI类型＝04	移动到目的，攻击
	--AI类型＝05	向目标无攻击移动
	--AI类型＝06	移动到某点不攻击
--[[
00=(X,Y) 移动/n 移动：
 若移动范围+攻击范围内有我军就选择行动价值最高的动作，否则：
1、当仇人代码为n=FF时，朝着(X,Y)坐标移动。
2、当仇人代码为n=FF时，且到达了(X,Y)坐标，则AI变为03=(X,Y) 待命。
3、当仇人代码为n=00~2C且仇人还在场时，朝着战场n号人物移动。
4、若仇人代码为n=00~2C且仇人消失，则AI变为01=攻击最近敌。

01=攻击最近敌：
 若移动范围+攻击范围内有我军就选择行动价值最高的动作，否则向最近的我军移动。

02=(X,Y) 不动/n 不动：
 无论攻击范围内是否有我军都会选择行动价值最高的动作，但是不会移动。
X,Y,n都无意义。（不确定）

03=(X,Y) 待命/n 待命：
 若移动范围+攻击范围内有我军就选择行动价值最高的动作，否则不会移动。
X,Y,n都无意义。（不确定）

04=(X,Y) 无攻击移动/n 无攻击移动：
 只会朝着目标坐标(X,Y)移动（若仇人代码为FF）或战场n号人物移动，不会攻击或使用策略。
1、当仇人代码为n=FF时，且到达了(X,Y)坐标，则AI变为03=(X,Y) 待命。
2、若仇人代码为n=00~2C且仇人消失，则AI变为01=攻击最近敌。

07=键入
 若我方AI≠07，则为友军。


]]--	

	--优先 搜寻移动范围内，有攻击就移动到附近．没有可攻击的，就考虑移动

	War.SelID=id;
	local wp=War.Person[id];
	local id1=wp.id;
	--XXX的移动
	CleanWarMap(5,-1);
	CleanWarMap(6,-1);
	CleanWarMap(7,-1);
	local dx,dy=wp.x,wp.y;
	local dv=0;
--调试
if JY.Base["游戏难度"] == 1 then
	if wp.ai==0 or wp.ai==2 then
		if not wp.friend then
			wp.ai=1
		end
	end
end
	
	--AI根据实际情况自动调整
	--AI类型＝03	追击指定目标	当追击目标消失时	--〉主动出击
	if wp.ai==3 then
		local eid=GetWarID(wp.aitarget);
		if not (eid>0 and War.Person[eid].live) then
			wp.ai=1;
		end
	end
	--
	if wp.ai~=2 then	--除了 坚守原地型 以外，其他的ai类型都需要考虑移动
		local steparray=War_CalMoveStep(id,wp.movestep);
		for i=0,wp.movestep do
			for j=1,steparray[i].num do
				local mx,my=steparray[i].x[j],steparray[i].y[j];
				if GetWarMap(mx,my,2)==0 or (mx==wp.x and my==wp.y) then
					local v=WarGetMoveValue(id,mx,my);
					if v>dv then
						dv=v;
						dx,dy=mx,my;
					end
				end
			end
		end
		--如果部队的兵力不足（即兵力小于最大兵力的40％或士气小于40，下同）．
		if dv<50 then
			if JY.Person[id1]["兵力"]/JY.Person[id1]["最大兵力"]<=0.4 then
				local eid=WarSearchBZ(id,19);
				if eid>0 then
					dv=0;
					WarSearchMove(id,War.Person[eid].x,War.Person[eid].y);
					for i=0,wp.movestep do
						for j=1,steparray[i].num do
							local mx,my=steparray[i].x[j],steparray[i].y[j];
							local v=GetWarMap(mx,my,4);
							if (GetWarMap(mx,my,2)==0 or i==0) and v>dv then
								dv=v;
								dx,dy=mx,my;
							end
						end
					end
				end
			elseif JY.Person[id1]["士气"]<=40 then
				local eid=WarSearchBZ(id,13);
				if eid>0 then
					dv=0;
					WarSearchMove(id,War.Person[eid].x,War.Person[eid].y);
					for i=0,wp.movestep do
						for j=1,steparray[i].num do
							local mx,my=steparray[i].x[j],steparray[i].y[j];
							local v=GetWarMap(mx,my,4);
							if (GetWarMap(mx,my,2)==0 or i==0) and v>dv then
								dv=v;
								dx,dy=mx,my;
							end
						end
					end
				end
			end
		end
		if dv>0 then	--移动范围有目标
			if dx~=wp.x or dy~=wp.y then	--需要移动
				War_CalMoveStep(id,wp.movestep);
				BoxBack();
				--WarDelay(CC.WarDelay);
				--WarDrawStrBoxDelay2(JY.Person[id1]["姓名"]..'的移动',C_WHITE,-310,48);
				War_MovePerson(dx,dy);
				War.ControlEnable=false;
				War.InMap=false;
			end
		else	--一次移动范围内无目标
			if wp.ai==1 then	--考虑移动到最近敌人
				local eid=WarSearchEnemy(id);
				if eid>0 then
					WarSearchMove(id,War.Person[eid].x,War.Person[eid].y);
					for i=0,wp.movestep do
						for j=1,steparray[i].num do
							local mx,my=steparray[i].x[j],steparray[i].y[j];
							local v=GetWarMap(mx,my,4);
							v=v+1-math.max(math.abs(mx-War.Person[eid].x),math.abs(my-War.Person[eid].y))/100;
							if wp.enemy then
								local ddv=GetWarMap(mx,my,8);
								--if wp.bz==13 or wp.bz==19 or wp.bz==19 then
									v=v-ddv;
								--end
							end
							
							if (GetWarMap(mx,my,2)==0 or i==0) and v>dv then
								dv=v;
								dx,dy=mx,my;
							end
						end
					end
				end
			elseif wp.ai==3 or wp.ai==5 then
				local eid=GetWarID(wp.aitarget);
				if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) then
					WarSearchMove(id,War.Person[eid].x,War.Person[eid].y);
					if GetWarMap(wp.x,wp.y,4)==0 then
						WarSearchMove(id,War.Person[eid].x,War.Person[eid].y,true);	--如果找不到路径，则无视敌人拦路，再找一次
					end
					if GetWarMap(wp.x,wp.y,4)==0 then
						eid=WarSearchEnemy(id);
						if eid>0 then
							WarSearchMove(id,War.Person[eid].x,War.Person[eid].y);	--如果找不到路径，则移动到最近敌人
						end
					end
					for i=0,wp.movestep do
						for j=1,steparray[i].num do
							local mx,my=steparray[i].x[j],steparray[i].y[j];
							local v=GetWarMap(mx,my,4);
							v=v+1-math.max(math.abs(mx-War.Person[eid].x),math.abs(my-War.Person[eid].y))/100;
							if wp.enemy then
								local ddv=GetWarMap(mx,my,8);
								if wp.bz==13 or wp.bz==16 or wp.bz==19 then
									v=v-ddv;
								end
							end
							
							if (GetWarMap(mx,my,2)==0 or i==0) and v>dv then
								dv=v;
								dx,dy=mx,my;
							end
						end
					end
				end
			elseif wp.ai==4 or wp.ai==6 then
				WarSearchMove(id,wp.ai_dx,wp.ai_dy);
				if GetWarMap(wp.x,wp.y,4)==0 then
					WarSearchMove(id,wp.ai_dx,wp.ai_dy,true);	--如果找不到路径，则无视敌人拦路，再找一次
				end
				for i=0,wp.movestep do
					for j=1,steparray[i].num do
						local mx,my=steparray[i].x[j],steparray[i].y[j];
						local v=GetWarMap(mx,my,4);
						v=v+1-math.max(math.abs(mx-wp.ai_dx),math.abs(my-wp.ai_dy))/100;
							if wp.enemy then
								local ddv=GetWarMap(mx,my,8);
								if wp.bz==13 or wp.bz==16 or wp.bz==19 then
									v=v-ddv;
								end
							end
							
						if (GetWarMap(mx,my,2)==0 or i==0) and v>dv then
							dv=v;
							dx,dy=mx,my;
						end
					end
				end
			end
			if dx~=wp.x or dy~=wp.y then
				War_CalMoveStep(id,wp.movestep);
				BoxBack();
				--WarDelay(CC.WarDelay);
				--WarDrawStrBoxDelay2(JY.Person[id1]["姓名"]..'的移动',C_WHITE,-310,48);
				War_MovePerson(dx,dy);
				War.ControlEnable=false;
				War.InMap=false;
			end
		end
	end
	CleanWarMap(4,1);
	--XXX的攻击
	local eid=0;
	dv=0;
	if wp.ai==5 or wp.ai==6 then
		
	else
		local atkarray=WarGetAtkFW(dx,dy,War.Person[id].atkfw);
		for i=1,atkarray.num do
			if atkarray[i][1]>0 and atkarray[i][1]<=War.Width and atkarray[i][2]>0 and atkarray[i][2]<=War.Depth then
				local v=WarGetAtkValue(id,atkarray[i][1],atkarray[i][2]);
				if v>dv then
					dv=v;
					eid=GetWarMap(atkarray[i][1],atkarray[i][2],2);
				end
			end
		end
		local mv,magicx,magicy=WarGetMagicValue(id,dx,dy);
		if mv>0 then
			--策略系部队，如果物理攻击价值低于100，则为0（new）
			if wp.bz==13 or wp.bz==16 or wp.bz==19 then
				if dv<100 then
					dv=0;
				end
			end
		end
		if mv>dv then
			local mid=GetWarMap(magicx,magicy,7);
			eid=GetWarMap(magicx,magicy,2);
			BoxBack();
			--WarDelay(CC.WarDelay);
			WarDrawStrBoxDelay(string.format("%s使用%s计．",JY.Person[id1]["姓名"],JY.Magic[mid]["名称"]),C_WHITE);
			WarMagic(id,eid,mid);
			JY.Person[id1]["策略"]=JY.Person[id1]["策略"]-JY.Magic[mid]["消耗"];
			JY.Person[id1]["策略"]=limitX(JY.Person[id1]["策略"],0,JY.Person[id1]["最大策略"]);
		else
			if eid>0 then
				BoxBack();
				--WarDelay(CC.WarDelay);
				--WarDrawStrBoxDelay2(JY.Person[id1]["姓名"]..'的攻击',C_WHITE,-310,48);
				WarAtk(id,eid);
				WarResetStatus(eid);
				--反击
				if JY.Person[War.Person[eid].id]["兵力"]>0 and (not War.Person[eid].troubled) then
					--只有贼兵（山贼、恶贼、义贼）和武术家能反击敌军的物理攻击。
					--敌军兵种为骑兵、贼兵、猛兽兵团、武术家、异民族时，才可能产生反击。敌军兵种为步兵、弓兵、军乐队、妖术师、运输队时，不可能发生反击。
					local fj_flag=false;
					if JY.Bingzhong[War.Person[eid].bz]["可反击"]==1 and JY.Bingzhong[War.Person[id].bz]["被反击"]==1 then
						fj_flag=true;
					elseif CC.Enhancement then
						if WarCheckSkill(eid,42) then	--反击(特技)
							fj_flag=true;
						end
					end
					if fj_flag then
						--检查是否在攻击范围内
						fj_flag=false;
						local fj_arrary=WarGetAtkFW(War.Person[eid].x,War.Person[eid].y,War.Person[eid].atkfw);
						for n=1,fj_arrary.num do
							if between(fj_arrary[n][1],1,War.Width) and between(fj_arrary[n][2],1,War.Depth) then
								if GetWarMap(fj_arrary[n][1],fj_arrary[n][2],2)==id then
									fj_flag=true;
									break;
								end
							end
						end
					end
					
					if fj_flag then
						--反击概率＝我军武将武力÷150
						if CC.Enhancement and WarCheckSkill(eid,19)	then	--报复
							if math.random(100)<=JY.Person[War.Person[eid].id]["武力2"] then
								WarAtk(eid,id,1);
								WarResetStatus(id);
							end
						else
							if math.random(150)<=JY.Person[War.Person[eid].id]["武力2"] then
								WarAtk(eid,id,1);
								WarResetStatus(id);
							end
						end
					end
				end
			end
		end
		--
		War.ControlEnable=false;
		War.InMap=false;
	end
	
	wp.active=false;
	wp.action=0;
	WarResetStatus(id);
	WarCheckStatus();
	War.LastID=War.SelID;
	War.SelID=0;
	WarDelay(CC.WarDelay);
end
--如果部队的兵力不足（即兵力小于最大兵力的40％或士气小于40，下同），则战场上存在可恢复地形的坐标，行动价值加50．
--基本值＝基本物理攻击杀伤＋攻击方当前兵力÷6
--物理攻击的行动价值＝基本值÷16．
--如果攻击的是仇人，基本值＝基本值＋30
--当部队处于有防御加成的地形时，行动价值＝行动价值＋防御加成÷5
function WarGetMoveValue(pid,x,y)
	local id1=War.Person[pid].id;
	local wp=War.Person[pid];
	local atkarray=WarGetAtkFW(x,y,War.Person[pid].atkfw);
	local dv=0;
	if wp.ai==5 or wp.ai==6 then
		dv=0;
	else
		for i=1,atkarray.num do
			if atkarray[i][1]>0 and atkarray[i][1]<=War.Width and atkarray[i][2]>0 and atkarray[i][2]<=War.Depth then
				local v=WarGetAtkValue(pid,atkarray[i][1],atkarray[i][2]);
				if v>0 then	--远距攻击额外附加
					if i<=4 then
						--v=v+0;
					elseif i<=8 then
						v=v+2;
					elseif i<=16 then
						v=v+3;
					elseif i<=24 then
						v=v+4;
					end
				end
				if v>dv then
					dv=v;
				end
			end
		end
		local mv=WarGetMagicValue(pid,x,y);
		--if mv>0 then
			--策略系部队，如果物理攻击价值低于100，则为0（new）
			if wp.bz==13 or wp.bz==16 or wp.bz==19 then
				if dv<100 then
					dv=0;
				end
			end
		--end
		if mv>dv then
			dv=mv;
		end
	end
	local dx=GetWarMap(x,y,1);
	if dv>0 then
		--当部队处于有防御加成的地形时，行动价值＝行动价值＋防御加成÷5			--2.5
		if dx==1 then	--可恢复地形 额外+5（自己新增的）
			dv=dv+8;
		elseif dx==2 then
			dv=dv+10;
		elseif dx==7 then
			dv=dv+2;
		elseif dx==8 then
			dv=dv+2+5;
		elseif dx==13 then
			dv=dv+12+5;
		elseif dx==14 then
			dv=dv+4+5;
		end
		--根据AI再附加
		if wp.ai==3 or wp.ai==5 then
			local eid=GetWarID(wp.aitarget);
			if eid>0 then
				local tx,ty=War.Person[eid].x,War.Person[eid].y;
				dv=dv+5*(wp.movestep-math.abs(tx-x)-math.abs(ty-y));
			end
		elseif wp.ai==4 or wp.ai==6 then
			local tx,ty=wp.ai_dx,wp.ai_dy;
			dv=dv+5*(wp.movestep-math.abs(tx-x)-math.abs(ty-y));
		end
	end
	--如果部队的兵力不足（即兵力小于最大兵力的40％或士气小于40，下同），则战场上存在可恢复地形的坐标，行动价值加50．
	if JY.Person[id1]["兵力"]/JY.Person[id1]["最大兵力"]<=0.4 or JY.Person[id1]["士气"]<=40 then
		if dx==8 or dx==13 or dx==14 then
			dv=dv+50;
		end
	end
	--新增的，mp不足时，靠近军乐队
	for d=1,4 do
		local sid=0;
		local nx,ny=x+CC.DirectX[d],y+CC.DirectY[d]
		if between(nx,1,War.Width) and between(ny,1,War.Depth) then
			sid=GetWarMap(nx,ny,2);
			if sid>0 and sid~=pid then
				if War.Person[sid].enemy==wp.enemy and War.Person[sid].bz==13 then
					if JY.Person[id1]["策略"]/JY.Person[id1]["最大策略"]<=0.4 then
						dv=dv+10;
						break;
					end
				end
			end
		end
	end
	if wp.enemy then
		local ddv=GetWarMap(x,y,8);
		if wp.bz==13 or wp.bz==16 or wp.bz==19 then
			dv=dv-ddv;
		end
	end
	
	return dv;
end
function HaveMagic(pid,mid)
	local bz=JY.Person[pid]["兵种"];
	local lv=JY.Person[pid]["等级"];
	if between(mid,1,36) then
		if between(JY.Bingzhong[bz]["策略"..mid],1,lv) then
			return true;
		end
	end
	if CC.Enhancement then
		if mid==37 then
			if CheckSkill(pid,1) then
				if lv>=JY.Skill[1]["参数1"] then
					return true;
				end
			end
		elseif mid==38 then
			if CheckSkill(pid,1) then
				if lv>=JY.Skill[1]["参数2"] then
					return true;
				end
			end
		elseif mid==39 then
			if CheckSkill(pid,4) then
				if lv>=JY.Skill[4]["参数1"] then
					return true;
				end
			end
		elseif mid==40 then
			if CheckSkill(pid,3) then
				if lv>=JY.Skill[3]["参数1"] then
					return true;
				end
			end
		elseif mid==41 then
			if CheckSkill(pid,39) then
				if lv>=JY.Skill[39]["参数2"] then
					return true;
				end
			end
		elseif mid==42 then
			if CheckSkill(pid,39) then
				if lv>=JY.Skill[39]["参数3"] then
					return true;
				end
			end
		elseif mid==43 then
			if CheckSkill(pid,40) or CheckSkill(pid,5) then
				if lv>=JY.Skill[40]["参数1"] then
					return true;
				end
			end
		elseif mid==44 then
			if CheckSkill(pid,40) or CheckSkill(pid,5) then
				if lv>=JY.Skill[40]["参数2"] then
					return true;
				end
			end
		elseif mid==46 then
			if CheckSkill(pid,38) then
				if lv>=JY.Skill[38]["参数2"] then
					return true;
				end
			end
		elseif mid == 47 then
			if CheckSkill(pid, 72) then
				if lv >= JY.Skill[72]["参数1"] then
					return true;
				end
			end
		elseif between(mid, 1, 5) then
			if CheckSkill(pid,12) then	--火计
				if lv >= 8 * (mid - 1) then
					return true;
				end
			end
		elseif between(mid, 6, 10) then
			if CheckSkill(pid,11) then	--水计
				if lv >= 8 * (mid - 6) then
					return true;
				end
			end
		elseif between(mid, 11, 15) then
			if CheckSkill(pid,14) then	--落石
				if lv >= 8 * (mid - 11) then
					return true;
				end
			end
		elseif between(mid, 28, 33) then
			if CheckSkill(pid, 51) then	--援助
				if lv >= 8 * (mid - 28) then
					return true;
				end
			end
		elseif between(mid, 22, 27) then
			if CheckSkill(pid, 52) then	--激励
				if lv >= 8 * (mid - 22) then
					return true;
				end
			end
		elseif between(mid, 19, 21) then
			if CheckSkill(pid, 53) then	--牵制
				if lv >= 8 * (mid - 19) then
					return true;
				end
			end
		end
	end
	return false;
end
function WarHaveMagic(wid,mid)
	local pid=War.Person[wid].id;
	return HaveMagic(pid,mid);
end
function WarGetMagicValue(pid,x,y)
	local dv=0;
	local dx,dy;
	local bz=War.Person[pid].bz;
	local id1=War.Person[pid].id;
	local lv=JY.Person[id1]["等级"];
	local ox,oy=War.Person[pid].x,War.Person[pid].y;
	War.Person[pid].x,War.Person[pid].y=x,y;
	SetWarMap(ox,oy,2,0);
	SetWarMap(x,y,2,pid);
	for mid=1,JY.MagicNum-1 do
		--if between(JY.Bingzhong[bz]["策略"..mid],1,lv) then
		if WarHaveMagic(pid,mid) then
			if JY.Person[id1]["策略"]>=JY.Magic[mid]["消耗"] then	--mp enough?
				if true then	--dx?
					local kind=JY.Magic[mid]["类型"];
					local fw=JY.Magic[mid]["施展范围"];
					local array=WarGetAtkFW(x,y,fw);
					for j=1,array.num do
						local mx,my=array[j][1],array[j][2];
						if between(mx,1,War.Width) and between(my,1,War.Depth) then
							local eid=GetWarMap(mx,my,2);
							if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) then
								if WarMagicCheck(pid,eid,mid) then	--check dx
									if ((between(kind,1,5) or between(kind,9,10)) and War.Person[pid].enemy~=War.Person[eid].enemy) or
										(between(kind,6,8) and War.Person[pid].enemy==War.Person[eid].enemy) then
										local v,select_magic=WarGetMagicValue_sub(pid,mx,my);
										if v>dv and mid==select_magic then
											dv=v;
											dx,dy=mx,my;
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	War.Person[pid].x,War.Person[pid].y=ox,oy;
	SetWarMap(x,y,2,0);
	SetWarMap(ox,oy,2,pid);
	return dv,dx,dy;
end
function WarGetMagicValue_sub(pid,x,y)
	local id1,id2;
	id1=War.Person[pid].id;
	local bz=War.Person[pid].bz;
	local lv=JY.Person[id1]["等级"];
	local oid=GetWarMap(x,y,2);
	local dv=GetWarMap(x,y,6);
	local select_magic=GetWarMap(x,y,7);
	local hp={600,1200,1800};
	local sp={30,40,50};
	if dv==-1 then
		dv=0;
		local v=0;
		for mid=1,JY.MagicNum-1 do
			--if between(JY.Bingzhong[bz]["策略"..mid],1,lv) then
			if WarHaveMagic(pid,mid) then
				if JY.Person[id1]["策略"]>=JY.Magic[mid]["消耗"] then	--mp enough?
					if oid>0 and War.Person[oid].live and (not War.Person[oid].hide) then
						if WarMagicCheck(pid,oid,mid) then	--地形，天气
							local kind=JY.Magic[mid]["类型"];
							local power=JY.Magic[mid]["效果"];
							local fw=JY.Magic[mid]["效果范围"];
							if between(kind,1,3) or between(kind,9,10) then	--火水石/毒雷
								v=0;
								if War.Person[pid].enemy~=War.Person[oid].enemy then
									local array=WarGetAtkFW(x,y,fw);
									for j=1,array.num do
										local dx,dy=array[j][1],array[j][2];
										if between(dx,1,War.Width) and between(dy,1,War.Depth)  then
											local eid=GetWarMap(dx,dy,2);
											if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) then
												if War.Person[pid].enemy~=War.Person[eid].enemy and WarMagicCheck(pid,eid,mid) then
													local hurt=WarMagicHurt(pid,eid,mid);
													if hurt>=JY.Person[War.Person[eid].id]["兵力"] then
														hurt=hurt*10;
													end
													if math.random()<WarMagicHitRatio(pid,eid,mid)+0.2 then
														v=v+hurt;
													else
														v=v+hurt/4;
													end
												end
											end
										end
									end
								end
							elseif kind==4 then		--假情报
								v=0;
								--如果敌人已混乱，加权值＝0
								--随机值＝（0～299）的随机数
								--根据假情报系策略全分析中的算法计算策略是否成功，如果计算结果是策略成功，加权值＝随机数＋300。
								local eid=GetWarMap(x,y,2);
								if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) and (not War.Person[eid].troubled) then
									if War.Person[pid].enemy~=War.Person[eid].enemy then
										v=math.random(300)-1;
										if math.random()<WarMagicHitRatio(pid,eid,mid) then
											v=v+300;
										end
									end
								end
							elseif kind==5 then		--牵制
								v=0;
								local eid=GetWarMap(x,y,2);
								if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) then
									if War.Person[pid].enemy~=War.Person[eid].enemy then
										if math.random()<WarMagicHitRatio(pid,eid,mid)+0.2 then
											id2=War.Person[eid].id;
											--基本值＝策略基本威力＋使用者等级÷10－被牵制者等级÷10
											--随机值＝1～10的随机数
											--加权值＝基本值×随机数
											v=power+lv/10-JY.Person[id2]["等级"]/10;
											v=limitX(v,0,JY.Person[id2]["士气"])
											local add=math.random(10);
											v=math.modf(v*add);
										end
									end
								end
							elseif kind==6 then		--激励
								v=0;
								if War.Person[pid].enemy==War.Person[oid].enemy then
									local array=WarGetAtkFW(x,y,fw);
									for j=1,array.num do
										local dx,dy=array[j][1],array[j][2];
										if between(dx,1,War.Width) and between(dy,1,War.Depth)  then
											local eid=GetWarMap(dx,dy,2);
											if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) then
												if War.Person[pid].enemy==War.Person[eid].enemy then
													id2=War.Person[eid].id;
													--基本值＝策略基本威力＋使用者等级÷10
													--随机值＝0～（基本值÷10－1）之间的随机数
													--激励值＝基本值＋随机值
													local sv=power+lv/10;
													sv=math.modf(sv*(1+math.random()/10));
													sv=limitX(sv,0,War.Person[oid].sq_limited-JY.Person[id2]["士气"]);
													if sv<10 then
														sv=0;
													end
													if JY.Person[id2]["士气"]<40 then
														sv=sv*20;
													end
													v=v+sv;
												end
											end
										end
									end
								end
							elseif kind==7 then		--援助
								v=0;
								if War.Person[pid].enemy==War.Person[oid].enemy then
									local array=WarGetAtkFW(x,y,fw);
									for j=1,array.num do
										local dx,dy=array[j][1],array[j][2];
										if between(dx,1,War.Width) and between(dy,1,War.Depth) then
											local eid=GetWarMap(dx,dy,2);
											if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) then
												if War.Person[pid].enemy==War.Person[eid].enemy then
													id2=War.Person[eid].id;
													--策略基本威力＋使用者智力×使用者等级÷20
													--随机值＝0～（基本值÷10－1）之间的随机数
													--补给值＝基本值＋随机值
													local sv=power+JY.Person[id1]["智力2"]*lv/20;
													sv=math.modf(sv*(1+math.random()/10));
													sv=limitX(sv,0,JY.Person[id2]["最大兵力"]-JY.Person[id2]["兵力"]);
													if sv<JY.Person[id2]["最大兵力"]/10 then
														sv=0;
													end
													v=v+sv;
												end
											end
										end
									end
								end
								if v/JY.Magic[mid]["消耗"]<50 then
									v=0;
								end
							elseif kind==8 then		--看护
								v=0;
								if War.Person[pid].enemy==War.Person[oid].enemy then
									local array=WarGetAtkFW(x,y,fw);
									for j=1,array.num do
										local dx,dy=array[j][1],array[j][2];
										local eid=GetWarMap(dx,dy,2);
										if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) then
											if War.Person[pid].enemy==War.Person[eid].enemy then
												id2=War.Person[eid].id;
												local sv=hp[power]+JY.Person[id1]["智力2"]*lv/20;
												sv=math.modf(sv*(1+math.random()/10));
												sv=limitX(sv,0,JY.Person[id2]["最大兵力"]-JY.Person[id2]["兵力"]);
												if sv<JY.Person[id2]["最大兵力"]/10 then
													sv=0;
												end
												v=v+sv;
												
												sv=sp[power]+lv/10;
												sv=math.modf(sv*(1+math.random()/10));
												sv=limitX(sv,0,War.Person[oid].sq_limited-JY.Person[id2]["士气"]);
												if sv<10 then
													sv=0;
												end
												if JY.Person[id2]["士气"]<40 then
													sv=sv*20;
												end
												v=v+sv;
												if v<400 then
													v=0;
												end
											end
										end
									end
								end
							end
						end
						v=math.modf(v/(JY.Magic[mid]["消耗"]+12));
						if v>dv then
							dv=v;
							select_magic=mid;
						end
					end
				end
			end
		end
		SetWarMap(x,y,6,dv);
		SetWarMap(x,y,7,select_magic);
	end
	return dv,select_magic;
end
function WarGetAtkValue(pid,x,y)
	local id1,id2;
	id1=War.Person[pid].id;
	local bz=War.Person[pid].bz;
	local v=GetWarMap(x,y,5);
	if v==-1 then
		v=0;
		local eid=GetWarMap(x,y,2);
		if eid>0 and War.Person[eid].live and (not War.Person[eid].hide) then
			if War.Person[pid].enemy~=War.Person[eid].enemy then
				id2=War.Person[eid].id;
				v=WarAtkHurt(pid,eid,0);
				if v>=JY.Person[id2]["兵力"] then	--一击必杀额外附加
					v=v+1600;
				elseif JY.Person[id2]["兵力"]<JY.Person[id2]["最大兵力"]/2 then	--敌军军力低时按兵力附加
					v=v+math.modf((JY.Person[id2]["最大兵力"]-JY.Person[id2]["兵力"])/6)
				end
				--v=v+math.modf(JY.Person[id1]["兵力"]/6);
				--行动价值＝基本值÷16．
				v=math.modf(v/16);
				--如果攻击的是仇人，行动价值＝行动价值＋30
				if id2==War.Person[pid].aitarget then
					v=v+30;
				end
				--如果攻击的是主将，行动价值=行动价值+?
				if War.Person[eid].leader then
					v=v+16;
				end
			end
		end
		SetWarMap(x,y,5,v);
	end
	return v;
end
function WarGetAtkFW(x,y,fw)
	local atkarray={};
	if fw==1 then	--短兵
		--1
		table.insert(atkarray,{x,y+1});
		table.insert(atkarray,{x,y-1});
		table.insert(atkarray,{x+1,y});
		table.insert(atkarray,{x-1,y});
		
		atkarray.num=4;
	elseif fw==2 then	--长兵
		--1
		table.insert(atkarray,{x,y+1});
		table.insert(atkarray,{x,y-1});
		table.insert(atkarray,{x+1,y});
		table.insert(atkarray,{x-1,y});
		--2
		table.insert(atkarray,{x+1,y+1});
		table.insert(atkarray,{x+1,y-1});
		table.insert(atkarray,{x-1,y+1});
		table.insert(atkarray,{x-1,y-1});
		
		atkarray.num=8;
	elseif fw==3 then	--突骑兵
		--1
		table.insert(atkarray,{x,y+1});
		table.insert(atkarray,{x,y-1});
		table.insert(atkarray,{x+1,y});
		table.insert(atkarray,{x-1,y});
		--2
		table.insert(atkarray,{x+1,y+1});
		table.insert(atkarray,{x+1,y-1});
		table.insert(atkarray,{x-1,y+1});
		table.insert(atkarray,{x-1,y-1});
		--2
		table.insert(atkarray,{x,y+2});
		table.insert(atkarray,{x,y-2});
		table.insert(atkarray,{x+2,y});
		table.insert(atkarray,{x-2,y});
		atkarray.num=12;
	elseif fw==4 then	--3++
		--1
		table.insert(atkarray,{x,y+1});
		table.insert(atkarray,{x,y-1});
		table.insert(atkarray,{x+1,y});
		table.insert(atkarray,{x-1,y});
		--2
		table.insert(atkarray,{x+1,y+1});
		table.insert(atkarray,{x+1,y-1});
		table.insert(atkarray,{x-1,y+1});
		table.insert(atkarray,{x-1,y-1});
		--2
		table.insert(atkarray,{x,y+2});
		table.insert(atkarray,{x,y-2});
		table.insert(atkarray,{x+2,y});
		table.insert(atkarray,{x-2,y});
		--3
		table.insert(atkarray,{x-1,y+2});
		table.insert(atkarray,{x-1,y-2});
		table.insert(atkarray,{x+2,y-1});
		table.insert(atkarray,{x-2,y-1});
		
		table.insert(atkarray,{x+1,y+2});
		table.insert(atkarray,{x+1,y-2});
		table.insert(atkarray,{x+2,y+1});
		table.insert(atkarray,{x-2,y+1});
		atkarray.num=20;
	elseif fw==5 then	--弓兵
		--1
		table.insert(atkarray,{x+1,y+1});
		table.insert(atkarray,{x+1,y-1});
		table.insert(atkarray,{x-1,y+1});
		table.insert(atkarray,{x-1,y-1});
		--2
		table.insert(atkarray,{x,y+2});
		table.insert(atkarray,{x,y-2});
		table.insert(atkarray,{x+2,y});
		table.insert(atkarray,{x-2,y});
		
		atkarray.num=8;
	elseif fw==6 then	--弩兵
		--1
		table.insert(atkarray,{x+1,y+1});
		table.insert(atkarray,{x+1,y-1});
		table.insert(atkarray,{x-1,y+1});
		table.insert(atkarray,{x-1,y-1});
		--2
		table.insert(atkarray,{x,y+2});
		table.insert(atkarray,{x,y-2});
		table.insert(atkarray,{x+2,y});
		table.insert(atkarray,{x-2,y});
		--3
		table.insert(atkarray,{x-1,y+2});
		table.insert(atkarray,{x-1,y-2});
		table.insert(atkarray,{x+2,y-1});
		table.insert(atkarray,{x-2,y-1});
		
		table.insert(atkarray,{x+1,y+2});
		table.insert(atkarray,{x+1,y-2});
		table.insert(atkarray,{x+2,y+1});
		table.insert(atkarray,{x-2,y+1});
		
		atkarray.num=16;
	elseif fw==7 then	--连弩兵
		--1
		table.insert(atkarray,{x+1,y+1});
		table.insert(atkarray,{x+1,y-1});
		table.insert(atkarray,{x-1,y+1});
		table.insert(atkarray,{x-1,y-1});
		--2
		table.insert(atkarray,{x,y+2});
		table.insert(atkarray,{x,y-2});
		table.insert(atkarray,{x+2,y});
		table.insert(atkarray,{x-2,y});
		--3
		table.insert(atkarray,{x-1,y+2});
		table.insert(atkarray,{x-1,y-2});
		table.insert(atkarray,{x+2,y-1});
		table.insert(atkarray,{x-2,y-1});
		
		table.insert(atkarray,{x+1,y+2});
		table.insert(atkarray,{x+1,y-2});
		table.insert(atkarray,{x+2,y+1});
		table.insert(atkarray,{x-2,y+1});
		--4
		table.insert(atkarray,{x+2,y+2});
		table.insert(atkarray,{x+2,y-2});
		table.insert(atkarray,{x-2,y+2});
		table.insert(atkarray,{x-2,y-2});
		
		table.insert(atkarray,{x,y+3});
		table.insert(atkarray,{x,y-3});
		table.insert(atkarray,{x+3,y});
		table.insert(atkarray,{x-3,y});
		
		atkarray.num=24;
	elseif fw==8 then	--7++
		--2
		table.insert(atkarray,{x+1,y+1});
		table.insert(atkarray,{x+1,y-1});
		table.insert(atkarray,{x-1,y+1});
		table.insert(atkarray,{x-1,y-1});
		table.insert(atkarray,{x,y+2});
		table.insert(atkarray,{x+2,y});
		table.insert(atkarray,{x,y-2});
		table.insert(atkarray,{x-2,y});
		--3
		table.insert(atkarray,{x,y+3});
		table.insert(atkarray,{x+1,y+2});
		table.insert(atkarray,{x+2,y+1});
		
		table.insert(atkarray,{x+3,y});
		table.insert(atkarray,{x+2,y-1});
		table.insert(atkarray,{x+1,y-2});
		
		table.insert(atkarray,{x,y-3});
		table.insert(atkarray,{x-1,y+2});
		table.insert(atkarray,{x-2,y-1});
		
		table.insert(atkarray,{x-3,y});
		table.insert(atkarray,{x-2,y+1});
		table.insert(atkarray,{x-1,y-2});
		--4
		table.insert(atkarray,{x+1,y+3});
		table.insert(atkarray,{x+2,y+2});
		table.insert(atkarray,{x+3,y+1});
		
		table.insert(atkarray,{x+3,y-1});
		table.insert(atkarray,{x+2,y-2});
		table.insert(atkarray,{x+1,y-3});
		
		table.insert(atkarray,{x-1,y-3});
		table.insert(atkarray,{x-2,y-2});
		table.insert(atkarray,{x-3,y-1});
		
		table.insert(atkarray,{x-3,y+1});
		table.insert(atkarray,{x-2,y+2});
		table.insert(atkarray,{x-1,y+3});
				
		atkarray.num=32;
	elseif fw==9 then	--投石车
		--2
		table.insert(atkarray,{x+1,y+1});
		table.insert(atkarray,{x+1,y-1});
		table.insert(atkarray,{x-1,y+1});
		table.insert(atkarray,{x-1,y-1});
		table.insert(atkarray,{x,y+2});
		table.insert(atkarray,{x+2,y});
		table.insert(atkarray,{x,y-2});
		table.insert(atkarray,{x-2,y});
		--3
		table.insert(atkarray,{x,y+3});
		table.insert(atkarray,{x+1,y+2});
		table.insert(atkarray,{x+2,y+1});
		
		table.insert(atkarray,{x+3,y});
		table.insert(atkarray,{x+2,y-1});
		table.insert(atkarray,{x+1,y-2});
		
		table.insert(atkarray,{x,y-3});
		table.insert(atkarray,{x-1,y+2});
		table.insert(atkarray,{x-2,y-1});
		
		table.insert(atkarray,{x-3,y});
		table.insert(atkarray,{x-2,y+1});
		table.insert(atkarray,{x-1,y-2});
		--4
		table.insert(atkarray,{x,y+4});
		table.insert(atkarray,{x+1,y+3});
		table.insert(atkarray,{x+2,y+2});
		table.insert(atkarray,{x+3,y+1});
		
		table.insert(atkarray,{x+4,y});
		table.insert(atkarray,{x+3,y-1});
		table.insert(atkarray,{x+2,y-2});
		table.insert(atkarray,{x+1,y-3});
		
		table.insert(atkarray,{x,y-4});
		table.insert(atkarray,{x-1,y-3});
		table.insert(atkarray,{x-2,y-2});
		table.insert(atkarray,{x-3,y-1});
		
		table.insert(atkarray,{x-4,y});
		table.insert(atkarray,{x-3,y+1});
		table.insert(atkarray,{x-2,y+2});
		table.insert(atkarray,{x-1,y+3});
				
		atkarray.num=36;
	elseif fw==10 then	--9++
		atkarray.num=0;
	elseif fw==11 then	--原地		-- 11~20 策略专用
		table.insert(atkarray,{x,y});
		atkarray.num=1;
	elseif fw==12 then	--五格
		table.insert(atkarray,{x,y});
		--1
		table.insert(atkarray,{x,y+1});
		table.insert(atkarray,{x,y-1});
		table.insert(atkarray,{x+1,y});
		table.insert(atkarray,{x-1,y});
		
		atkarray.num=5;
	elseif fw==13 then	--八格
		--1
		table.insert(atkarray,{x,y+1});
		table.insert(atkarray,{x,y-1});
		table.insert(atkarray,{x+1,y});
		table.insert(atkarray,{x-1,y});
		--2
		table.insert(atkarray,{x+1,y+1});
		table.insert(atkarray,{x+1,y-1});
		table.insert(atkarray,{x-1,y+1});
		table.insert(atkarray,{x-1,y-1});
		
		atkarray.num=8;
	elseif fw==14 then	--九格
		table.insert(atkarray,{x,y});
		--1
		table.insert(atkarray,{x,y+1});
		table.insert(atkarray,{x,y-1});
		table.insert(atkarray,{x+1,y});
		table.insert(atkarray,{x-1,y});
		--2
		table.insert(atkarray,{x+1,y+1});
		table.insert(atkarray,{x+1,y-1});
		table.insert(atkarray,{x-1,y+1});
		table.insert(atkarray,{x-1,y-1});
		
		atkarray.num=9;
	elseif fw==15 then	--十二格
		--1
		table.insert(atkarray,{x,y+1});
		table.insert(atkarray,{x,y-1});
		table.insert(atkarray,{x+1,y});
		table.insert(atkarray,{x-1,y});
		--2
		table.insert(atkarray,{x+1,y+1});
		table.insert(atkarray,{x+1,y-1});
		table.insert(atkarray,{x-1,y+1});
		table.insert(atkarray,{x-1,y-1});
		--2
		table.insert(atkarray,{x,y+2});
		table.insert(atkarray,{x,y-2});
		table.insert(atkarray,{x+2,y});
		table.insert(atkarray,{x-2,y});
		
		atkarray.num=12;
	elseif fw==16 then	--十三格
		table.insert(atkarray,{x,y});
		--1
		table.insert(atkarray,{x,y+1});
		table.insert(atkarray,{x,y-1});
		table.insert(atkarray,{x+1,y});
		table.insert(atkarray,{x-1,y});
		--2
		table.insert(atkarray,{x+1,y+1});
		table.insert(atkarray,{x+1,y-1});
		table.insert(atkarray,{x-1,y+1});
		table.insert(atkarray,{x-1,y-1});
		--2
		table.insert(atkarray,{x,y+2});
		table.insert(atkarray,{x,y-2});
		table.insert(atkarray,{x+2,y});
		table.insert(atkarray,{x-2,y});
		
		atkarray.num=13;
	elseif fw==17 then	--二十格
		--1
		table.insert(atkarray,{x,y+1});
		table.insert(atkarray,{x,y-1});
		table.insert(atkarray,{x+1,y});
		table.insert(atkarray,{x-1,y});
		--1
		table.insert(atkarray,{x+1,y+1});
		table.insert(atkarray,{x+1,y-1});
		table.insert(atkarray,{x-1,y+1});
		table.insert(atkarray,{x-1,y-1});
		--2
		table.insert(atkarray,{x,y+2});
		table.insert(atkarray,{x,y-2});
		table.insert(atkarray,{x+2,y});
		table.insert(atkarray,{x-2,y});
		--3
		table.insert(atkarray,{x-1,y+2});
		table.insert(atkarray,{x-1,y-2});
		table.insert(atkarray,{x+2,y-1});
		table.insert(atkarray,{x-2,y-1});
		
		table.insert(atkarray,{x+1,y+2});
		table.insert(atkarray,{x+1,y-2});
		table.insert(atkarray,{x+2,y+1});
		table.insert(atkarray,{x-2,y+1});
		
		atkarray.num=20;
	elseif fw==18 then	--二十一格
		table.insert(atkarray,{x,y});
		--1
		table.insert(atkarray,{x,y+1});
		table.insert(atkarray,{x,y-1});
		table.insert(atkarray,{x+1,y});
		table.insert(atkarray,{x-1,y});
		--1
		table.insert(atkarray,{x+1,y+1});
		table.insert(atkarray,{x+1,y-1});
		table.insert(atkarray,{x-1,y+1});
		table.insert(atkarray,{x-1,y-1});
		--2
		table.insert(atkarray,{x,y+2});
		table.insert(atkarray,{x,y-2});
		table.insert(atkarray,{x+2,y});
		table.insert(atkarray,{x-2,y});
		--3
		table.insert(atkarray,{x-1,y+2});
		table.insert(atkarray,{x-1,y-2});
		table.insert(atkarray,{x+2,y-1});
		table.insert(atkarray,{x-2,y-1});
		
		table.insert(atkarray,{x+1,y+2});
		table.insert(atkarray,{x+1,y-2});
		table.insert(atkarray,{x+2,y+1});
		table.insert(atkarray,{x-2,y+1});
		
		atkarray.num=21;
	elseif fw==19 then
		atkarray.num=0;
	elseif fw==20 then
		atkarray.num=0;
	elseif fw==21 then	--选择我方，附近8格
		--1
		table.insert(atkarray,{x,y+1});
		table.insert(atkarray,{x,y-1});
		table.insert(atkarray,{x+1,y});
		table.insert(atkarray,{x-1,y});
		--2
		table.insert(atkarray,{x+1,y+1});
		table.insert(atkarray,{x+1,y-1});
		table.insert(atkarray,{x-1,y+1});
		table.insert(atkarray,{x-1,y-1});
		
		atkarray.num=8;
	elseif fw==22 then	--选择我方，附近9格
		table.insert(atkarray,{x,y});
		--1
		table.insert(atkarray,{x,y+1});
		table.insert(atkarray,{x,y-1});
		table.insert(atkarray,{x+1,y});
		table.insert(atkarray,{x-1,y});
		--2
		table.insert(atkarray,{x+1,y+1});
		table.insert(atkarray,{x+1,y-1});
		table.insert(atkarray,{x-1,y+1});
		table.insert(atkarray,{x-1,y-1});
		
		atkarray.num=9;
	else
		atkarray.num=0;
	end
	return atkarray;
end
function WarSetAtkFW(id,fw)
	local mx=War.Person[id].x;
	local my=War.Person[id].y;
	local atkarray=WarGetAtkFW(mx,my,fw);
	CleanWarMap(4,0);
	for i=1,atkarray.num do
		if between(atkarray[i][1],1,War.Width) and between(atkarray[i][2],1,War.Depth) then
			SetWarMap(atkarray[i][1],atkarray[i][2],4,1);
		end
	end
end
function CheckActive()
	--我方全部行动完毕?
	if JY.Status~=GAME_WMAP then	--当游戏状态改变时，直接结束我方操作
		return true;
	end
	for i,v in pairs(War.Person) do
		if v.live and (not v.hide) and (not v.enemy) and (not v.friend) and v.active then	--任意一人可行动，则返回
			return false;
		end
	end
	War.ControlStatus='DrawStrBoxYesorNo';
	if WarDrawStrBoxYesNo("结束所有部队的命令吗？",C_WHITE) then
		return true;
	else
		return false;
	end
	
end
function WarCheckStatus()
	
	if JY.Status==GAME_WMAP then
		--敌方失败？
		local enum=0;
		for i,v in pairs(War.Person) do
			if v.enemy then
				if v.live then--and (not v.hide) then
					enum=enum+1
				end
			end
			if v.leader and (not v.live) then
				if v.enemy then
					JY.Status=GAME_WARWIN;
					break;
				else
					JY.Status=GAME_WARLOSE;
					break;
				end
			end
		end
		if enum==0 and JY.Status==GAME_WMAP then
			JY.Status=GAME_WARWIN;
		end
		War.ControlEnableOld=War.ControlEnable;
		War.ControlEnable=false;
		War.InMap=false;
		if DoEvent(JY.EventID) then
			if JY.Status==GAME_WMAP or JY.Status==GAME_WARWIN then
				DoEvent(JY.EventID);
			end
		end
		--War.ControlEnable=true----War.ControlEnableOld;
	end
end
----------------------------------------------------------------
--	WarDelay(n)
--	延时，并刷新战场
--	n默认为1
----------------------------------------------------------------
function WarDelay(n)
	n=n or 1;
	for i=1,n do
		JY.ReFreshTime=lib.GetTime();
		DrawWarMap(War.CX,War.CY);
		lib.GetKey();
		ReFresh();
	end
end
function WarPersonCenter(id)
	if id<1 or id>War.PersonNum then
		return false;
	end
	if War.Person[id].live==false then
		return false;
	end
	War.SelID=id;
	BoxBack();
	--WarDelay(CC.WarDelay);
	War.LastID=War.SelID;
	War.SelID=0;
	return true;
end
function WarRest(force)
--人物处于恢复性地形或持有恢复性宝物，可以触发自动恢复．
--村庄、鹿砦可以恢复士气和兵力．兵营可以恢复兵力，但不能恢复士气．
--玉玺可以恢复兵力和士气，援军报告可以恢复兵力，赦命书可以恢复士气．
--地形和宝物的恢复能力不能叠加
	for i,v in pairs(War.Person) do
		if v.live and (not v.hide) and (
        (v.enemy and force == 2) or 
        (
          (not v.enemy) and (
            (v.friend and force == 1) or 
            ((not v.friend) and force == 0)
          )
        )
      ) then
			local hp,sp=0,0;
			local hp_times=0;
			local sp_times=0;
			local hp_item_flag=false;
			local sp_item_flag=false;
			local hp_skill_flag=false;
			local sp_skill_flag=false;
			for index=1,8 do
				local tid=JY.Person[v.id]["道具"..index];
				if JY.Item[tid]["类型"]==7 then
					if JY.Item[tid]["效果"]==1 then
						hp_item_flag=true;
					elseif JY.Item[tid]["效果"]==2 then
						sp_item_flag=true;
					elseif JY.Item[tid]["效果"]==3 then
						hp_item_flag=true;
						sp_item_flag=true;
					end
				end
			end
			if CC.Enhancement then
				if WarCheckSkill(i,22) then	--治疗
					hp_skill_flag=true;
				end
			end
			local dx=GetWarMap(v.x,v.y,1);
			--08 村庄  0D 鹿砦  0E  兵营
			if dx==8 or dx==13 then
				hp_times=hp_times+1;
				sp_times=sp_times+1;
			elseif dx==14 then
				hp_times=hp_times+1;
			end
			if hp_item_flag then
				hp_times=hp_times+1;
			end
			if sp_item_flag then
				sp_times=sp_times+1;
			end
			if hp_skill_flag then
				hp_times=hp_times+1;
			end
			if sp_skill_flag then
				sp_times=sp_times+1;
			end
			if hp_times>0 then
				--兵力的自动恢复量＝150＋（0～10之间的随机数）×10
				--hp=140+math.random(11)*10;
				--修改为自身兵力的5%-10%
				hp=math.max(140+math.random(11)*10, math.modf(JY.Person[v.id]["最大兵力"] / 2000 * (math.modf(JY.Person[v.id]["统率2"]/10) + 1 + math.random(10)))*10);
				--当兵力恢复后离最大兵力的差距不足10时，系统将自动补满该差距
				hp=hp*hp_times;
				if JY.Person[v.id]["最大兵力"]-JY.Person[v.id]["兵力"]-hp<9 then
					hp=JY.Person[v.id]["最大兵力"]-JY.Person[v.id]["兵力"];
				end
			end
			if sp_times>0 then
				--士气的自动恢复量＝统御力÷10＋（1～5之间的随机数）
				sp=math.modf(JY.Person[v.id]["统率2"]/10)+math.random(5);
				--与兵力恢复相仿，士气恢复后超过90时，系统将自动不满士气
				sp=sp*sp_times;
				if v.sq_limited-JY.Person[v.id]["士气"]-sp<9 then
					sp=v.sq_limited-JY.Person[v.id]["士气"];
				end
			end
			if hp>0 or sp>0 then
				--
				War.MX=v.x;
				War.MY=v.y;
				War.CX=War.MX-math.modf(War.MW/2);
				War.CY=War.MY-math.modf(War.MD/2);
				War.CX=limitX(War.CX,1,War.Width-War.MW+1);
				War.CY=limitX(War.CY,1,War.Depth-War.MD+1);
				WarDelay(16);
				--
				local tmax=16;
				tmax=math.min(16,(math.modf(math.max(2,math.abs(hp)/50,math.abs(sp)))));
				local oldbl=JY.Person[v.id]["兵力"];
				local oldsq=JY.Person[v.id]["士气"];
				for t=0,tmax do
					JY.ReFreshTime=lib.GetTime();
					JY.Person[v.id]["兵力"]=oldbl+hp*t/tmax;
					JY.Person[v.id]["士气"]=oldsq+sp*t/tmax;
					DrawWarMap();
					DrawStatusMini(i);
					lib.GetKey();
					ReFresh();
				end
				JY.ReFreshTime=lib.GetTime();
				ReFresh(CC.OpearteSpeed*4);
				WarDelay(4);
			end
			--策略值的自动恢复．
				--部队位于军乐队旁边可以自动恢复策略值，恢复量＝每军乐队（等级÷10）点．
			if v.bz==13 or WarCheckSkill(i,70) then --智囊
				for d=1,4 do
					local x,y=v.x+CC.DirectX[d],v.y+CC.DirectY[d];
					if between(x,1,War.Width) and between(y,1,War.Depth) then
						local eid=GetWarMap(x,y,2);
						if eid>0 then
							if (not War.Person[eid].hide) and War.Person[eid].live then
								local pid=War.Person[eid].id;
								JY.Person[pid]["策略"]=limitX(JY.Person[pid]["策略"]+math.modf(1+JY.Person[v.id]["等级"]/10),0,JY.Person[pid]["最大策略"]);
							end
						end
					end
				end
			end
			if CC.Enhancement then
				if WarCheckSkill(i,35) then	--百出
					JY.Person[v.id]["策略"]=limitX(JY.Person[v.id]["策略"]+math.modf(1+JY.Person[v.id]["等级"]*JY.Skill[35]["参数1"]/100),0,JY.Person[v.id]["最大策略"]);
				end
			end
			--自动唤醒．
				--每回合系统将试图唤醒混乱中的部队，混乱中部队恢复正常状态的算法如下：
				--恢复因子＝0～99的随机数，如果恢复因子小于（统御力＋士气）÷3，那么部队被唤醒．由此看出，统御越高，士气越高，越容易从混乱中苏醒．
				--注意：自动唤醒的判定是再自动恢复后进行的，因此是以恢复后的士气为准．
			WarTroubleShooting(i);
			WarResetStatus(i);
		end
	end
end

function ESCMenu()
	PlayWavE(0);
	--lib.PicLoadCache(4,58*2,)
	--回合结束	全军撤退	胜利条件	部队战斗	背景音乐	音效	游戏结束
	local menu={
					{"回合结束",nil,1},
					{"全军委任",nil,1},
					{"胜利条件",nil,1},
					{"功能设定",nil,0},
					{"策略动画",nil,0},
					{"移动速度",nil,0},
					{"  载入",nil,1},
					{"  储存",nil,1},
					{"游戏结束",nil,1},
					{"  Debug ",nil,0},
				}
	if CC.Debug==1 then
		menu[8][3]=1;
	end
	local r=WarShowMenu(menu,10,0,64,64,0,0,1,1,16,C_WHITE,C_WHITE);
	WarDelay(CC.WarDelay);
	if r==1 then
		return WarDrawStrBoxYesNo("结束所有部队的命令吗？",C_WHITE);
	elseif r==2 then
		if WarDrawStrBoxYesNo("委任剩余部队本回合的命令吗？",C_WHITE) then
      War.ControlStatus = 'AI';
			for i,v in pairs(War.Person) do
				if JY.Status~=GAME_WMAP then
					return;
				end
				local dx=GetWarMap(v.x,v.y,1);
				if v.live and (not v.hide) and (not v.troubled) and (not v.enemy) and (not v.friend) and v.active then
					War.ControlEnable=false;
					War.InMap=false;
					AI_Sub(i);
				end
			end
			return true;
		end
	elseif r==3 then
		WarShowTarget();
	elseif r==4 then
		SettingMenu();
	elseif r==5 then
		if WarDrawStrBoxYesNo('观看策略动画吗？',C_WHITE) then
			War.PlayMagic=true;
		else
			War.PlayMagic=false;
		end
	elseif r==6 then
		if WarDrawStrBoxYesNo('加速部队移动吗？',C_WHITE) then
			War.MoveSpeed=1;
		else
			War.MoveSpeed=0;
		end
	elseif r==7 then	--载入
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
			DrawYJZBox2(-1,164,"请选择将载入的档案",C_WHITE);
			local s2=ShowMenu(menu2,5,0,0,0,0,0,20,1,16,C_WHITE,C_WHITE);
			if between(s2,1,5) then
				if string.sub(menu2[s2][1],5)~="未使用档案" then
					if WarDrawStrBoxYesNo(string.format("载入在硬碟的第%d进度，可以吗？",s2),C_WHITE) then
						LoadRecord(s2);
					end
				else
					WarDrawStrBoxConfirm("没有数据",C_WHITE,true);
				end
			end
	elseif r==8 then	--储存
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
			DrawYJZBox2(-1,164,"将档案储存在哪里？",C_WHITE);
			local s2=ShowMenu(menu2,5,0,0,0,0,0,20,1,16,C_WHITE,C_WHITE);
			if between(s2,1,5) then
				if WarDrawStrBoxYesNo(string.format("储存在硬碟的第%d号，可以吗？",s2),C_WHITE) then
					WarSave(s2);
				end
			end
	elseif r==9 then
		if WarDrawStrBoxYesNo('结束游戏吗？',C_WHITE) then
			WarDelay(CC.WarDelay);
			if WarDrawStrBoxYesNo('再玩一次吗？',C_WHITE) then
				WarDelay(CC.WarDelay);
				JY.Status=GAME_START;
			else
				WarDelay(CC.WarDelay);
				JY.Status=GAME_END;
			end
		end
	elseif r==10 then
		
	end
	
	return false;
end

function SettingMenu()
	local x,y,w,h;
	local size=16;
	w=320;
	h=128+64;
	local notWar=true;
	if JY.Status==GAME_WMAP or JY.Status==GAME_WARWIN or JY.Status==GAME_WARLOSE then
		x=16+(768-0)/2;
		y=32+(528-0)/2;
		notWar=false;
	elseif JY.Status==GAME_SMAP_AUTO or JY.Status==GAME_SMAP_MANUAL then
		x=16+(640-0)/2;
		y=16+(400-0)/2;
		notWar=true;
	else
		x=(CC.ScreenW-0)/2;
		y=(CC.ScreenH-0)/2;
		notWar=true;
	end
	x=x-w/2;
	y=y-h/2;
	local x1=x+254
	local x2=x1+52
	local y1=y+92+64;
	local y2=y1+24;
	
	local function button(bx,by,str,flag)
		local box_w=36;
		local box_h=18;
		local cx=bx;
		local cy=by-1;
		if flag then	--selected
			lib.Background(cx+1,cy+1,cx+box_w,cy+box_h,128,C_BLACK);
			lib.DrawRect(cx,cy,cx+box_w,cy,C_BLACK);
			lib.DrawRect(cx,cy,cx,cy+box_h,C_BLACK);
			lib.DrawRect(cx,cy+box_h,cx+box_w,cy+box_h,M_Gray);
			lib.DrawRect(cx+box_w,cy,cx+box_w,cy+box_h,M_Gray);
			DrawString(cx+box_w/2-size*#str/4,cy+1,str,C_WHITE,size);
		else
			lib.Background(cx+1,cy+1,cx+box_w,cy+box_h,192,C_BLACK);
			lib.DrawRect(cx,cy,cx+box_w,cy,M_Gray);
			lib.DrawRect(cx,cy,cx,cy+box_h,M_Gray);
			lib.DrawRect(cx,cy+box_h,cx+box_w,cy+box_h,C_BLACK);
			lib.DrawRect(cx+box_w,cy,cx+box_w,cy+box_h,C_BLACK);
			DrawString(cx+box_w/2-size*#str/4,cy+1,str,M_Silver,size);
		end
	end
	local function redraw(flag)
		local T={[0]="关闭","１","２","３","４","５"}
		JY.ReFreshTime=lib.GetTime();
		if JY.Status==GAME_WMAP or JY.Status==GAME_WARWIN or JY.Status==GAME_WARLOSE then
			DrawWarMap();
		elseif JY.Status==GAME_SMAP_AUTO or JY.Status==GAME_SMAP_MANUAL then
			DrawSMap();
		else
			
		end
		lib.PicLoadCache(4,80*2,x,y,1);
		lib.SetClip(x,y+72,x+w,y+72+128-8);
		lib.PicLoadCache(4,80*2,x,y+72-8,1);
		lib.SetClip();
		DrawString(x+16,y+16,"功能设定",C_Name,size);
		DrawStr(x+16,y+40,"音乐",C_WHITE,size);
		for i,v in pairs(T) do
			if math.modf(CC.MusicVolume/25)==i then
				button(x+80+i*38,y+40,v,true);
			else
				button(x+80+i*38,y+40,v,false);
			end
		end
		DrawStr(x+16,y+60,"音效",C_WHITE,size);
		for i,v in pairs(T) do
			if math.modf(CC.SoundVolume/12)==i then
				button(x+80+i*38,y+60,v,true);
			else
				button(x+80+i*38,y+60,v,false);
			end
		end
		DrawStr(x+16,y+80,"字形",C_WHITE,size);
		if CC.FontType==0 then
			button(x+80+1*38,y+80,"１",true);
			button(x+80+2*38,y+80,"２",false);
		else
			button(x+80+1*38,y+80,"１",false);
			button(x+80+2*38,y+80,"２",true);
		end
		DrawStr(x+16,y+100,"繁简",C_WHITE,size);
		if CC.OSCharSet==0 then
			button(x+80+1*38,y+100,"简体",true);
			button(x+80+2*38,y+100,"繁体",false);
		else
			button(x+80+1*38,y+100,"简体",false);
			button(x+80+2*38,y+100,"繁体",true);
		end
		if notWar then
			DrawStr(x+16,y+120,"动态等级",C_WHITE,size);
			if JY.Base["动态等级"]>0 then
				button(x+80+1*38,y+120,"开启",true);
				button(x+80+2*38,y+120,"关闭",false);
			else
				button(x+80+1*38,y+120,"开启",false);
				button(x+80+2*38,y+120,"关闭",true);
			end
		else
			DrawStr(x+16,y+120,"策略动画",C_WHITE,size);
			if War.PlayMagic then
				button(x+80+1*38,y+120,"开启",true);
				button(x+80+2*38,y+120,"关闭",false);
			else
				button(x+80+1*38,y+120,"开启",false);
				button(x+80+2*38,y+120,"关闭",true);
			end
		end
		if flag==1 then
			lib.PicLoadCache(4,56*2,x1,y1,1);
		end
		if notWar then
			ShowScreen();
		else
			ReFresh();
		end
	end
	
	local current=0;
	--PlayWavE(0);
	while true do
		redraw(current);
		getkey();
		if MOUSE.HOLD(x1+1,y1+1,x2-1,y2-1) then
			current=1;
		elseif MOUSE.CLICK(x1+1,y1+1,x2-1,y2-1) then
			current=0;
			PlayWavE(0);
			redraw(current);
			if notWar then
				lib.Delay(100);
			else
				WarDelay(4);
			end
			return;
		else
			current=0;
			for i=0,5 do
				if MOUSE.CLICK(x+80+i*38,y+40,x+80+i*38+36,y+40+16) then
					CC.MusicVolume=25*i;
					Config();
					PicCatchIni();
					PlayWavE(0);
					break;
				elseif MOUSE.CLICK(x+80+i*38,y+60,x+80+i*38+36,y+60+16) then
					CC.SoundVolume=12*i;
					Config();
					PicCatchIni();
					PlayWavE(0);
					break;
				end
			end
			if MOUSE.CLICK(x+80+1*38,y+80,x+80+1*38+36,y+80+16) then
				CC.FontType=0;
				PlayWavE(0);
			elseif MOUSE.CLICK(x+80+2*38,y+80,x+80+2*38+36,y+80+16) then
				CC.FontType=1;
				PlayWavE(0);
			elseif MOUSE.CLICK(x+80+1*38,y+100,x+80+1*38+36,y+100+16) then
				CC.OSCharSet=0;
				PlayWavE(0);
			elseif MOUSE.CLICK(x+80+2*38,y+100,x+80+2*38+36,y+100+16) then
				CC.OSCharSet=1;
				PlayWavE(0);
			elseif MOUSE.CLICK(x+80+1*38,y+120,x+80+1*38+36,y+120+16) then
				if notWar then
					JY.Base["动态等级"]=1;
				else
					War.PlayMagic=true;
				end
				PlayWavE(0);
			elseif MOUSE.CLICK(x+80+2*38,y+120,x+80+2*38+36,y+120+16) then
				if notWar then
					JY.Base["动态等级"]=0;
				else
					War.PlayMagic=false;
				end
				PlayWavE(0);
			end
		end
	end
end

function WarGetPic(id)
--[[
0	短兵
1	短兵
2	长兵
3	战车
4	弓兵
5	弩兵
6	投石车
7	轻骑兵
8	重骑兵
9	近卫队
10	山贼
11	恶贼
12	义贼
13	军乐队
14	猛兽兵团
15	武术家
16	妖术师
17	异民族
18	民众
19	运输队
5020	5070	5120	曹操(原版)
5170	5220	5270	夏侯惇(原版)
5320	5370	5420	张辽(原版)
5470	5520	5570	貂蝉(原版)
5620	5670	5720	司马懿(原版)
5770					刘备(原版，进阶)
5820					诸葛(诸葛巾)
5870					周瑜(原版)
5920					陆逊(原版)
5970	6020	6070	典韦(原版)
6120	6170	6220	许褚(原版)
6270					祝融(原版)
6320					刘备(原版)
6370	6420			关羽(原版)
6470	6520			张飞(原版)
6570					赵云(原版)
6620					献帝(原版)
6670					吕布(原版)
6720					姜维	骑马
6770	6820			赵云	骑马
6870					廖化	步行
6920	7420			刘备	步行
6970					庞统(无双)
7020					靖仇
7070					周瑜(三国志)
7120					关羽	骑马
7170					张飞	骑马
7220					武松(水浒)
7270					吕布	骑马
7320					张辽?	步行
7370					剑客
7470					司马懿	步行
7520					女剑客
7570					剑仙
7620					吕布	步行
7670					鲁智深(水浒)
7720					陆逊(三国志)
7770					孙坚	骑马
7820					徐晃	骑马
7870					双刀·女
7920					周仓	步行
7970					男·枪·双戟·白·骑马
8020					典韦	骑马
8070	8120			纪灵	骑马
8170	8220			颜良	文丑	骑马
8270					李明	猛兽
8320					许褚	骑马
8370	8420			太史慈	骑马
8470					赵云(街机)	骑马
8520					双扇·女	步行
8570					魏延	骑马
8620					曹仁	步行
8670					董卓	步行
8720					段誉
8770					黄盖
8820					黄忠	弓
8870					黄忠	骑马
8920					马超
8970					马岱	步行
9020					张任	弓
9070					周泰	步行
9120					子龙	步行
9170					高顺	训虎
9220					沙摩柯	藤甲
9270					诸葛	纶巾
9320					诸葛	帽子
9820					曹操san10风格 骑马
9870					单刀男	步行	蓝
9920					邓艾	骑马
9970	10020	10070	10120	关平骑马1-4
10170	10220			马谡	步行
10270					双鞭男
10320	备娘，步行
10370	步将，剑，白
10420	步将，剑盾，蓝
10470	步将，枪，蓝
10520	公孙瓒，白马
10570	姑娘，单刀
10620	关兴，步
10670	关兴，骑马
10720	剑客，黄
10770	李典，骑马
10820	李典，步行
10870	马谡，妖术师
10920 - 11320	枪兵
11370	沙摩柯，步行
11420	沙摩柯，骑马
11470	张苞，骑马
11520 - 11670	张辽s10，骑马	lv3,move和lv2一样，原本导出的游戏里就有问题
11670	赵云，老年
11720	孙权，孙策，孙坚，原版
11770	袁绍，原版
]]--
	local pid=War.Person[id].id;
	return GetPic(pid,War.Person[id].enemy,War.Person[id].friend);
end
function GetBZPic(pid,enemy,friend)
	local pic=20;
	local bz=JY.Person[pid]["兵种"];
	local lv=1;
	if JY.Person[pid]["等级"]<20 then
		lv=1;
	elseif JY.Person[pid]["等级"]<40 then
		lv=2;
	else
		lv=3;
	end
	pic=JY.Bingzhong[bz]["贴图"..lv];
	if enemy then
		return pic+JY.Bingzhong[bz]["敌军偏移"];
	elseif friend then
		return pic+JY.Bingzhong[bz]["友军偏移"];
	else
		return pic+JY.Bingzhong[bz]["我军偏移"];
	end	
end
function GetPic(pid,enemy,friend)
	--[[
	if bz>12 then
		bz=12+(bz-13)*3+lv;
	end
	--			1					4				7				10				13				16				19				22				25				28				31				34				37				40
	--			步兵				弓兵			骑兵			贼兵			乐队			猛兽			武术家			妖术师			异族			民众			输送			战车			投石车			突骑兵
	local T1={[0]=20,20,170,320,	920,1070,1220,	470,620,770,	1370,1520,1670,	3620,3620,3620,	3170,3170,3170,	1820,1970,2120,	2720,2870,3020,	3320,3320,3320,	3570,3570,3570,	3770,3770,3770,	3920,4070,4220,	4370,4520,4670,	9370,9520,9670,};	--敌军 红
	local T2={[0]=70,70,220,370,	970,1120,1270,	520,670,820,	1420,1570,1720,	3670,3670,3670,	3220,3220,3220,	1870,2020,2170,	2770,2920,3070,	3370,3370,3370,	3570,3570,3570,	3820,3820,3820,	3970,4120,4270,	4420,4570,4720,	9420,9570,9720,};	--友军 黄
	local T3={[0]=120,120,270,420,	1020,1170,1320,	570,720,870,	1470,1620,1770,	3720,3720,3720,	3270,3270,3270,	1920,2070,2220,	2820,2970,3120,	3420,3420,3420,	3570,3570,3570,	3870,3870,3870,	4020,4170,4320,	4470,4620,4770,	9470,9620,9770,};	--我军 蓝
	
	if enemy then
		JY.Person[pid]["战斗动作"]=T1[bz] or 20;
	elseif friend then
		JY.Person[pid]["战斗动作"]=T2[bz] or 70;
	else
		JY.Person[pid]["战斗动作"]=T3[bz] or 120;
	end	
	]]--
	local bz=JY.Person[pid]["兵种"];
	local lv=1;
	if bz==3 or bz==6 or bz==9 or bz==12 or bz==25 then
		lv=3;
	elseif bz==2 or bz==5 or bz==8 or bz==11 or bz==24 then
		lv=2;
	elseif bz==1 or bz==4 or bz==7 or bz==10 or bz==23 then
		lv=1;
	elseif JY.Person[pid]["等级"]<20 then
		lv=1;
	elseif JY.Person[pid]["等级"]<40 then
		lv=2;
	else
		lv=3;
	end
	JY.Person[pid]["战斗动作"]=GetBZPic(pid,enemy,friend);
	local id=JY.Person[pid]["代号"];
	if id==1 then	--刘备
		if between(bz,7,9) or bz==22 then	--骑马
			if lv==1 then
				JY.Person[pid]["战斗动作"]=6320;
			elseif lv==2 then
				JY.Person[pid]["战斗动作"]=12120;
			else
				JY.Person[pid]["战斗动作"]=12170;
			end
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		elseif bz==27 then
			JY.Person[pid]["战斗动作"]=10320;
		else	--步行
			if lv<3 then
				JY.Person[pid]["战斗动作"]=6920;
			else
				JY.Person[pid]["战斗动作"]=7420;
			end
		end
	elseif id==2 or id==373 then	--关羽
		if between(bz,7,9) or bz==22 then	--骑马
			if lv==1 then
				JY.Person[pid]["战斗动作"]=6370;
			elseif lv==2 then
				JY.Person[pid]["战斗动作"]=6420;
			elseif lv==3 then
				JY.Person[pid]["战斗动作"]=7120;
			else
				
			end
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=11870;
		end
	elseif id==3 or id==374 then	--张飞
		if between(bz,7,9) or bz==22 then	--骑马
			if lv==1 then
				JY.Person[pid]["战斗动作"]=6470;
			elseif lv==2 then
				JY.Person[pid]["战斗动作"]=6520;
			elseif lv==3 then
				JY.Person[pid]["战斗动作"]=7170;
			else
				
			end
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=12570;
		end
	elseif id==4 then	--董卓
		if between(bz,7,9) or bz==22 then	--骑马
			JY.Person[pid]["战斗动作"]=8670;
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			
		end
	elseif id==5 then	--吕布
		if between(bz,7,9) or bz==22 then	--骑马
			if lv==1 then
				JY.Person[pid]["战斗动作"]=6670;
			elseif lv==2 or lv==3 then
				--JY.Person[pid]["战斗动作"]=7270;
				JY.Person[pid]["战斗动作"]=12220;
			else
				
			end
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=7620;
		end
	elseif id==6 then	--华雄
		if between(bz,7,9) or bz==22 then	--骑马
			JY.Person[pid]["战斗动作"]=11970;
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			
		end
	elseif id==9 then	--曹操
		if between(bz,7,9) or bz==22 then	--骑马
			if lv==1 then
				JY.Person[pid]["战斗动作"]=5020;
			elseif lv==2 then
				JY.Person[pid]["战斗动作"]=5070;
			elseif lv==3 then
				JY.Person[pid]["战斗动作"]=5120;
			else
				
			end
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			
		end
	elseif id==10 then	--袁绍
		JY.Person[pid]["战斗动作"]=11770;
	elseif id==11 then	--孙坚
		if between(bz,7,9) or bz==22 then	--骑马
			JY.Person[pid]["战斗动作"]=7770;
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			
		end
	elseif id==13 then	--公孙瓒
		if between(bz,7,9) or bz==22 then	--骑马
			JY.Person[pid]["战斗动作"]=10520;
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			
		end
	elseif id==15 then	--黄盖
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=8770;
		end
	elseif id==17 then	--夏侯惇
		if between(bz,7,9) or bz==22 then	--骑马
			if lv==1 then
				JY.Person[pid]["战斗动作"]=5170;
			elseif lv==2 then
				JY.Person[pid]["战斗动作"]=5220;
			elseif lv==3 then
				JY.Person[pid]["战斗动作"]=5270;
			else
				
			end
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			
		end
	elseif id==18 then	--夏侯渊
		if between(bz,7,9) or bz==22 then	--骑马
			if true or bz==22 then
				if lv==1 then
					JY.Person[pid]["战斗动作"]=12320;
				elseif lv==2 then
					JY.Person[pid]["战斗动作"]=12370;
				elseif lv==3 then
					JY.Person[pid]["战斗动作"]=12420;
				else
					
				end
			end
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			
		end
	elseif id==19 then	--曹仁
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=8620;
		end
	elseif id==30 then	--关兴
		if between(bz,7,9) or bz==22 then	--骑马
			if lv==3 and JY.Person[pid]["等级"]>=60 then
				JY.Person[pid]["战斗动作"]=10670;
			end
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=10620;
		end
	elseif id==31 then	--马谡
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==16 then	--妖术师
			JY.Person[pid]["战斗动作"]=10870;
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			if lv==1 then
				JY.Person[pid]["战斗动作"]=10170;
			elseif lv==2 then
				JY.Person[pid]["战斗动作"]=10170;
			elseif lv==3 then
				JY.Person[pid]["战斗动作"]=10220;
			end
		end
	elseif id==34 then	--廖化
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=6870;
		end
	elseif id==35 then	--沙摩柯
		if between(bz,7,9) or bz==22 then	--骑马
			JY.Person[pid]["战斗动作"]=11420;
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=11370;--9220;
		end
	elseif id==44 then	--张苞
		if between(bz,7,9) or bz==22 then	--骑马
			if lv==3 and JY.Person[pid]["等级"]>=60 then
				JY.Person[pid]["战斗动作"]=11470;
			end
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			
		end
	elseif id==52 then	--颜良
		if between(bz,7,9) or bz==22 then	--骑马
			JY.Person[pid]["战斗动作"]=8170;
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			
		end
	elseif id==53 then	--文丑
		if between(bz,7,9) or bz==22 then	--骑马
			JY.Person[pid]["战斗动作"]=8220;
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			
		end
	elseif id==54 then	--赵云
		if between(bz,7,9) or bz==22 then	--骑马
			if lv==1 then
				JY.Person[pid]["战斗动作"]=6570;
			elseif lv==2 then
				JY.Person[pid]["战斗动作"]=6770;
			elseif lv==3 then
				JY.Person[pid]["战斗动作"]=6820;
			else
				
			end
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=9120;
		end
	elseif id==63 then	--于禁
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=10370;
		end
	elseif id==68 then	--许褚
		if between(bz,7,9) or bz==22 then	--骑马
			JY.Person[pid]["战斗动作"]=8320;
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			if lv==1 then
				JY.Person[pid]["战斗动作"]=6120;
			elseif lv==2 then
				JY.Person[pid]["战斗动作"]=6170;
			elseif lv==3 then
				JY.Person[pid]["战斗动作"]=6220;
			else
				
			end
		end
	elseif id==70 then	--纪灵
		if between(bz,7,9) or bz==22 then	--骑马
			if lv==1 then
				JY.Person[pid]["战斗动作"]=8070;
			elseif lv==2 then
				JY.Person[pid]["战斗动作"]=8120;
			elseif lv==3 then
				JY.Person[pid]["战斗动作"]=8120;
			else
				
			end
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			
		end
	elseif id==73 then	--高顺
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
			
		elseif bz==14 then	--训虎一般无特殊形象
			JY.Person[pid]["战斗动作"]=9170;
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			
		end
	elseif id==79 then	--徐晃
		if between(bz,7,9) or bz==22 then	--骑马
			JY.Person[pid]["战斗动作"]=7820;
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			
		end
	elseif id==80 then	--张辽
		if between(bz,7,9) or bz==22 then	--骑马
			if lv==1 then
				JY.Person[pid]["战斗动作"]=5320;
			elseif lv==2 then
				JY.Person[pid]["战斗动作"]=5370;
			elseif lv==3 then
				JY.Person[pid]["战斗动作"]=5420;
			else
				
			end
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=7320;
		end
	elseif id==83 then	--简雍
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
			if lv>1 then
				JY.Person[pid]["战斗动作"]=12070;
			end
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			
		end
	elseif id==103 then	--张郃
		if between(bz,7,9) or bz==22 then	--骑马
			if true or bz==22 then
				JY.Person[pid]["战斗动作"]=12520;
			end
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			
		end
	elseif id==116 then	--李典
		if between(bz,7,9) or bz==22 then	--骑马
			--JY.Person[pid]["战斗动作"]=10770;
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=10820;
		end
	elseif id==126 then	--诸葛亮
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			if between(JY.Person[pid]["等级"],1,39) then
				JY.Person[pid]["战斗动作"]=9270;
			elseif between(JY.Person[pid]["等级"],40,59) then
				JY.Person[pid]["战斗动作"]=5820;
			elseif between(JY.Person[pid]["等级"],60,9999) then
				JY.Person[pid]["战斗动作"]=9320;
			else
				
			end
		end
	elseif id==127 then	--魏延
		if between(bz,7,9) or bz==22 then	--骑马
			JY.Person[pid]["战斗动作"]=8570;
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			
		end
	elseif id==128 then	--关平
		if between(bz,7,9) or bz==22 then	--骑马
			if lv==1 then
				JY.Person[pid]["战斗动作"]=9970;
			elseif lv==2 then
				JY.Person[pid]["战斗动作"]=10070;
			elseif lv==3 then
				JY.Person[pid]["战斗动作"]=10120;
			else
				
			end
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			
		end
	elseif id==129 then	--夏侯兰
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=9870;
		end
	elseif id==133 then	--庞统
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=6970;
		end
	elseif id==142 then	--孙权
		JY.Person[pid]["战斗动作"]=11720;
	elseif id==143 then	--周瑜
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=7070;
		end
	elseif id==150 then	--太史慈
		if between(bz,7,9) or bz==22 then	--骑马
			if lv==1 then
				JY.Person[pid]["战斗动作"]=8370;
			elseif lv==2 then
				JY.Person[pid]["战斗动作"]=8420;
			elseif lv==3 then
				JY.Person[pid]["战斗动作"]=8420;
			else
				
			end
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			
		end
	elseif id==151 then	--陆逊
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=7720;
		end
	elseif id==155 then	--周仓
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=7920;
		end
	elseif id==163 then	--周泰
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=9070;
		end
	elseif id==170 then	--黄忠
		if between(bz,7,9) then	--骑马
			JY.Person[pid]["战斗动作"]=8870;
		elseif bz==22 then	--弓骑
			JY.Person[pid]["战斗动作"]=12020;
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
			JY.Person[pid]["战斗动作"]=8820;
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			
		end
	elseif id==190 then	--马超
		if between(bz,7,9) or bz==22 then	--骑马
			JY.Person[pid]["战斗动作"]=8920;
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
			
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			
		end
	elseif id==196 then	--张任
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
			JY.Person[pid]["战斗动作"]=9020;
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			
		end
	elseif id==204 then	--马岱
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
			
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=8970;
		end
	elseif id==214 then	--司马懿
		if between(bz,7,9) or bz==22 then	--骑马
			if lv==1 then
				JY.Person[pid]["战斗动作"]=5620;
			elseif lv==2 then
				JY.Person[pid]["战斗动作"]=5670;
			elseif lv==3 then
				JY.Person[pid]["战斗动作"]=5720;
			else
				
			end
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=7470;
		end
	elseif id==216 then	--庞德
		if between(bz,7,9) or bz==22 then	--骑马
			JY.Person[pid]["战斗动作"]=10770;
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			
		end
	elseif id==244 then	--姜维
		if between(bz,7,9) or bz==22 then	--骑马
			JY.Person[pid]["战斗动作"]=6720;
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			
		end
	elseif id==376 then	--李明
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			JY.Person[pid]["战斗动作"]=8270;
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=10570;
		end
	elseif id==377 then	--祝融
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=6270;
		end
	elseif id==383 then	--献帝
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=6620;
		end
	elseif id==385 then	--鲁智深
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=7670;
		end
	elseif id==386 then	--武松
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=7220;
		end
	elseif id==387 then	--典韦
		if between(bz,7,9) or bz==22 then	--骑马
			JY.Person[pid]["战斗动作"]=8020;
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			if lv==1 then
				JY.Person[pid]["战斗动作"]=5970;
			elseif lv==2 then
				JY.Person[pid]["战斗动作"]=5970;
			elseif lv==3 then
				JY.Person[pid]["战斗动作"]=6020;
			else
				
			end
		end
	elseif id==388 then	--靖仇
		JY.Person[pid]["战斗动作"]=7020;
	elseif id==389 then	--仙子
		JY.Person[pid]["战斗动作"]=7520;
	elseif id==390 then	--剑仙
		JY.Person[pid]["战斗动作"]=7570;
	elseif id==391 then
		JY.Person[pid]["战斗动作"]=7620;
	elseif id==392 then
		JY.Person[pid]["战斗动作"]=7120;
	elseif id==393 then
		JY.Person[pid]["战斗动作"]=7170;
	elseif id==394 then
		JY.Person[pid]["战斗动作"]=8470;
	elseif id==395 then
		JY.Person[pid]["战斗动作"]=8570;
	elseif id==396 then
		JY.Person[pid]["战斗动作"]=8020;
	elseif id==397 then
		JY.Person[pid]["战斗动作"]=5420;
	elseif id==398 then
		JY.Person[pid]["战斗动作"]=6220;
	elseif id==404 then	--貂蝉
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			if lv==1 then
				JY.Person[pid]["战斗动作"]=5470;
			elseif lv==2 then
				JY.Person[pid]["战斗动作"]=5520;
			elseif lv==3 then
				JY.Person[pid]["战斗动作"]=5570;
			else
				
			end
		end
	elseif id==405 then	--胡笛
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
			
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"]=7370--8720;
		end
	elseif id==406 then	--bttt
		JY.Person[pid]["战斗动作"]=12270;
	elseif id==407 then	--孟获
		if between(bz,7,9) or bz==22 then	--骑马
			
		elseif bz>=4 and bz<=6 then	--弓兵一般无特殊形象
		
		elseif bz==14 then	--训虎一般无特殊形象
      if enemy then
        JY.Person[pid]["战斗动作"] = T1[bz] or 4820;
      elseif friend then
        JY.Person[pid]["战斗动作"] = 4870;
      else
        JY.Person[pid]["战斗动作"] = 4920;
      end	
		elseif bz==20 then	--战车一般无特殊形象
			
		elseif bz==21 then	--投石车一般无特殊形象
			
		else	--步行
			JY.Person[pid]["战斗动作"] = 9220;
		end
	end
	return JY.Person[pid]["战斗动作"];
end
function FightMenu()
	local T={	5,3,387,2,54,68,
				190,385,17,170,98,
				391,392,393,394,395,396,397,398,
				150,216,386,390,44,127,389,35,
				53,79,148,6,11,
				18,80,103,244,4,
				30,201,52,163,196,388,
				15,142,202,155,122,
				149,204,171,407,377,167,
				212,19,128,151,109,
				34,178,236,1,9,104,
				143,165,174,254,20,
				102,218,61,106,191,
				129,141,166,205,252,
			116,13,200,46,70,88,113,
				210,376,14,168,211,
				213,217,243,81,162,
				208,209,248,241,31,
				91,105,240,47,82,
				117,221,48,144,45,
				51,63,87,136,378,
				10,73,146,76,380,
				38,188,133,214,50,
				57,112,126,83,65,
				77,94,64,69,62,
				145,84,251,7,379,
				253,114,239,402,403,
				404,405,382,406,
			}
	local id1=FightSelectMenu(T);
	if id1==0 then
		return;
	end
	for i,v in pairs(T) do
		if id1==v then
			table.remove(T,i);
			break;
		end
	end
	local id2=FightSelectMenu(T);
	if id2==0 then
		return;
	end
	local s={0,1,2,4,6};
	--dofile(CONFIG.ScriptPath .. "war.lua");
	--war(id1,id2,s[math.random(5)]);
	fight(id1,id2,s[math.random(5)]);
end
function FightSelectMenu(T)
	local num_perpage=12;
	local page=1;
	local total_num=#T;
	local maxpage=math.modf(total_num/(num_perpage-2));
	if total_num>(num_perpage-2)*maxpage then
		maxpage=maxpage+1;
	end
	local t={};
	
	while true do
		for i=2,num_perpage-1 do
			t[i]=0;
		end
		t[1]=-1;
		t[num_perpage]=-2;
		for i=2,num_perpage-1 do
			local idx=(num_perpage-2)*(page-1)+(i-1);
			if idx<=total_num then
				t[i]=T[idx];
			end
		end
		local m={};
		m[1]={" 上一页",nil,1};
		m[num_perpage]={" 下一页",nil,1};
		for i=2,num_perpage-1 do
			if t[i]>0 then
				local str=JY.Person[t[i]]["姓名"];
				if #str==6 then
					str=" "..str;
				elseif #str==4 then
					str="  "..str;
				elseif #str==2 then
					str="   "..str;
				end
				m[i]={str,nil,1};
			else
				m[i]={"",nil,0};
			end
		end
		if JY.Status==GAME_WMAP or JY.Status==GAME_WARWIN or JY.Status==GAME_WARLOSE then
			DrawWarMap();
		elseif JY.Status==GAME_SMAP_AUTO or JY.Status==GAME_SMAP_MANUAL then
			DrawSMap();
		else
			lib.FillColor(0,0,0,0);
		end
		local r=ShowMenu(m,num_perpage,0,0,0,0,0,1,1,16,C_WHITE,C_WHITE);
		if r==1 then
			if page>1 then
				page=page-1;
			end
		elseif r==num_perpage then
			if page<maxpage then
				page=page+1;
			end
		elseif r==0 then
			return 0;
		else
			local id=t[r];
			local bz=JY.Person[id]["兵种"];
			if WarDrawStrBoxYesNo(string.format('%s %d级%s 武力 %d*确认吗？',JY.Person[id]["姓名"],JY.Person[id]["等级"],JY.Bingzhong[bz]["名称"],JY.Person[id]["武力"]),C_WHITE,true) then
				return t[r];
			end
		end
	end
end













--[[
     刘　备：我的梦想，不能实现了……
　　关　羽：兄长，我对不起您……
　　张　飞：大哥，对不起，没想到会被……
　　简　雍：糟了，现在只有退兵了。
 　　潘　宫：哎呀，我的武艺也就这些了……
　　赵　云：没有完成使命，是武将的耻辱……
　　孙　乾：主公，我没有守住。
 　　糜　竺：主公，不能再打下去了，是我的过错……
　　糜　芳：现在不得不撤退了……
　　关　平：主公、父亲大人，饶了我吧。
 　　周　仓：关羽将军，是我的过错……
　　刘　封：现在不得不撤退了……
　　伊　籍：刘备大人，不能再打下去了，是我的过错。
 　　徐　庶：没想到我的计谋被识破……
　　诸葛亮：没有完成主公的期望，请允许我们撤退。
 　　马　良：主公，是我的失策……
　　马　谡：糟了，不应是这种结局……
　　黄　忠：我亦老迈无用了，在战场厮杀不如……
　　魏　延：即使拿出全部武力，也不能打啊！
 　　庞　统：计谋被识破了，你这个混帐……
　　法　正：主公，是我的失策……
　　严　颜：最近，挥动大刀不利落了……
　　马　超：我不认输！再杀一场！
 　　马　岱：我军……怎么打了大败仗……
　　关　兴：我玷污了父亲大人的名声……
　　张　苞：我玷污了父亲大人的名声……
　　刘　禅：父亲大人，我是怕上战场的……
　　姜　维：我不服！主公，再给我一次机会！







http://www.xycq.net/forum/thread-214260-1-1.html
二、策略道具全分析

1、攻击性策略与道具
http://www.xycq.net/forum/thread-213692-1-1.html
原作者：ctermiii 

 2、查看类策略与道具

 如果是策略，则要计算成功率：

 计算一个0~(攻击方智力-1)的随机数，如果
 随机数大于等于防御方智力/4，那么策略成功。
 但是如果防御方具有减轻策略损伤的状态，那么要再算一次随机数，两次都大于等于防御方智力/4，策略才能成功。

 查看策略：A=8，B=5
侦察策略：A=15，B=11
谍报策略：A=30，B=11
查看书：A=5，B=4
侦察书：A=11，B=6
谍报书：A=20，B=11

计算一个0~(B-1)的随机数，查看类的损伤就是
A+随机数。

 如果防御方具有减轻策略损伤的状态，那么计算结果要除以2。

 最后，损伤不能超过防御方剩余策略值。

3、压迫类、骂声类的策略与道具

 如果是策略，则要计算成功率：

 计算一个0~(攻击方智力-1)的随机数，如果
 随机数大于等于防御方智力/3，那么策略成功。
 但是如果防御方具有减轻策略损伤的状态，那么要再算一次随机数，两次都大于等于防御方智力/3，策略才能成功。

 最后的效果：
a、双降，能力变为原来的2/3
 b、单降，能力变为原来的4/5
 c、单升，能力变为原来的6/5
 d、双升，能力变为原来的3/2

 4、假情报类策略与道具

 如果是策略，则要计算成功率：

 计算一个0~(攻击方智力-1)的随机数，如果
 随机数大于等于防御方智力/3，那么策略成功。
 但是如果防御方具有减轻策略损伤的状态，那么要再算一次随机数，两次都大于等于防御方智力/3，策略才能成功。

 如果成功，则混乱。

5、反间类策略与道具

 如果是策略，则要计算成功率：

 计算一个0~(攻击方智力-1)的随机数，如果
 随机数大于等于防御方智力/3，那么策略成功。
 但是如果防御方具有减轻策略损伤的状态，那么要再算一次随机数，两次都大于等于防御方智力/3，策略才能成功。

 如果成功，每回合耐久力减少10%，直到撤退或状态恢复。

6、牵制、止步策略与道具

 如果是策略，则要计算成功率：

 计算一个0~(攻击方智力-1)的随机数，如果
 随机数大于等于防御方智力/5，那么策略成功。
 但是如果防御方具有减轻策略损伤的状态，那么要再算一次随机数，两次都大于等于防御方智力/5，策略才能成功。

 如果成功，攻击速度（牵制）或移动速度（止步）减半。

7、补给类策略与道具

 恢复豆、援队书：使用者智力/10+100
恢复麦、援部书：使用者智力/5+300
恢复米、援军书：2*使用者智力/5+500
恢复肉、援国书：补满
 小补给、援队：使用者智力/2+20
中补给、援部：4*使用者智力/5+40
大补给、援军：11*使用者智力/10+60
全补给、援国：补满

 恢复后的剩余耐久力不能超过最大耐久力。

8、策略恢复类策略与道具

 进言、药：　　恢复20策略值
 献策、中药：　恢复40策略值
 施策、华佗药：恢复80策略值

 不能给物资队恢复策略。

9、状态恢复类策略与道具

 苏醒书、觉醒：混乱状态恢复
 恢复书、康复：耐久力每回合减少状态恢复
 释放书、解放：攻击速度减半状态恢复
 轻功书、轻功：移动速度减半状态恢复

10、奋起类、坚固类策略与道具

 暂时提高攻击力、防御力，最后的效果同3

 11、对策、回归、升格策略与道具

 对策：减轻策略损伤
 回归：恢复回合结束的状态
 升格：兵种提升

 升格的道具有：长兵器指南书、近卫兵心得 等等。

12、封策策略与道具

 如果是策略，则要计算成功率：

 计算一个0~(攻击方智力-1)的随机数，如果
 随机数大于等于防御方智力/3，那么策略成功。
 但是如果防御方具有减轻策略损伤的状态，那么要再算一次随机数，两次都大于等于防御方智力/3，策略才能成功。

 如果成功，则不能使用策略。

13、能力提升类道具

 武勇种、智谋种、仁爱种、精神种
 分别增加
 武力、智力、统率力、策略值上限
0~3的随机数+2

武勇果、智谋果、仁爱果、精神果
 分别增加
 武力、智力、统率力、策略值上限
0~5的随机数+5

对应能力不能超过255。

 根性种增加耐久力上限
0~10的随机数+15

根性果增加耐久力上限
0~20的随机数+30

耐久力上限最大1000。

14、经验种、经验果

http://www.xycq.net/forum/thread-213663-1-1.html

的8楼，原作者godtype

 15、武器、防具、车马、兵书

 略
 
 三、经验获得全分析

http://www.xycq.net/forum/thread-213663-1-1.html
原作者：godtype

四、自动恢复全分析

1、处在恢复地形或者持有兵书的部队，每回合可以自动恢复部分耐久力。且两个条件都满足的话，恢复可以叠加。

 恢复量为：

(0~4的随机数+地形恢复效果)*最大耐久力/100+兵书恢复效果*最大耐久力/100

地形恢复效果：
 兵营5
村庄10
鹿砦15
关隘20
城池25

兵书恢复效果（若一支部队携带多本兵书，则只计算效果最高的一本）：
 三略10
六韬15
孟德新书20
孙子兵法25

恢复后的耐久力不能超过最大耐久力。

2、处在军乐队周围的部队每回合可以恢复策略值
 恢复量=军乐队的智力/10+1

物资队的策略值不能恢复；
 我军的军乐队不能给敌军恢复策略值，反之亦然。

3、每回合自动恢复状态

a、如果是好的状态（攻防上升、策略损伤减轻）

 恢复某一个状态（去掉策略损伤减轻，去掉一阶攻防上升，二阶攻防上升降为一阶）要求

 计算一个0~[(智力+防御力)/100+20-1]的随机数，如果小于等于A，则恢复该状态。

 其中A的取值与兵种类型有关：
 军师系、运粮队、物资队、军乐队、皇帝、都督、幻术师：1
步兵系、弓兵系、战车系、炮车系：2
骑兵系、弓骑兵系、贼兵系、武术家系：3
少数民族兵种、动物兵团：4

 b、如果是坏的状态（攻防下降、混乱、耐久力每回合减少等）

 恢复某一个状态（去掉不良状态，去掉一阶攻防下降，二阶攻防下降降为一阶）要求

 计算一个0~[20-(智力+防御力)/100-1]的随机数，如果小于等于B，则恢复该状态。

 其中B的取值与兵种类型有关：
 军师系：10
运粮队、物资队、军乐队、皇帝、都督、幻术师：4
步兵系、弓兵系、战车系、炮车系：3
骑兵系、弓骑兵系、贼兵系、武术家系：2
少数民族兵种、动物兵团：1

注意：
1、一次计算只能恢复一种状态。如果是N个状态则要计算N次。

2、由于每个部队有3个状态变量，分别是：攻击力升降、防御力升降、其他状态。
 在每次附上状态后，所属状态的变量第6位（最右边为第0位，最左边为第7位）被置位。
 于是判断是否恢复之前，要先判断该位是否为1。若为1则该位清零，跳过判断过程。若为0，才能进行判断。
 也就是说，附上状态后，至少要隔一个回合才能恢复（无论要恢复的与附上的是否是同一种状态）。

 
 五、天气算法

 天气代码：00、01、02晴，03云，04、05雨

A=0~5的随机数
B=存储天气的变量

 如果A>B，则B加1；如果A<B，则B减1。

 如果B=5，则B=0；如果B=0，则B=5。

 注：孔明传的天气算法与英杰传完全一致。
 
 六、武将基本数据及战场数据的内存

 从0x4556E8开始，每个武将基本数据占54个字节

+00 2字节 武将代码
+02 4字节 未知
+06 7字节 武将姓名（虽然一个汉字是2个字节，但是字符串要以0x00结尾）
+0D 1字节 未知
+0E 2字节 未知
+10 4字节 未知
+14 4字节 未知
+18 2字节 未知
+1A 1字节 所属君主
+1B 1字节 武力
+1C 1字节 统率力
+1D 1字节 智力
+1E 2字节 最大耐久力
+20 2字节 未知
+22 1字节 最大策略值
+23 1字节 未知
+24 1字节 兵种
+25 1字节 等级
+26 1字节 经验值
+27 15字节 15个道具


 从0x46C098开始，每个武将战场附加数据占23个字节

+00 2字节 人物代码
+02 2字节 未知，但是改成其他值会出错退出
+04 1字节 战场编号
+05 1字节 战场横坐标（左起为0，FF表示伏兵）
+06 1字节 战场纵坐标（上起为0，FF表示伏兵）
+07 1字节 仇人战场编号，FF表示没有仇人
+08 1字节 目标X坐标
+09 1字节 目标Y坐标
+0A 1字节 行动顺序编号，00为最先行动的。
+0B 1字节 00=未出场，01=伏兵，02=正常，03=撤退
+0C 1字节 二进制，10=朝向（该位为1则朝右），20=全屏移动，40=形象不动（在移动动作显示结束时写入），80=回合结束
+0D 1字节 AI，若AI≠07则为友军或敌军
+0E 1字节 在移动过程中（即显示移动动作时）的方向，00=上，01=右，02=下，03=左
+0F 4字节 剩余耐久力（实际只有2字节）
+13 1字节 剩余策略值
+14 1字节 攻击力升降属性：00=双升，01=单升，02=正常，03=单降，04=双降
+15 1字节 防御力升降属性：同上
+16 1字节 状态（二进制）：01=移动力下降，02=攻击速度下降，04=封策，08=对策，10=混乱，20=耐久力每回合减少，40=刚附上状态，下一回合消失。



七、AI类型


00=(X,Y) 移动/n 移动：
 若移动范围+攻击范围内有我军就选择行动价值最高的动作，否则：
1、当仇人代码为n=FF时，朝着(X,Y)坐标移动。
2、当仇人代码为n=FF时，且到达了(X,Y)坐标，则AI变为03=(X,Y) 待命。
3、当仇人代码为n=00~2C且仇人还在场时，朝着战场n号人物移动。
4、若仇人代码为n=00~2C且仇人消失，则AI变为01=攻击最近敌。

01=攻击最近敌：
 若移动范围+攻击范围内有我军就选择行动价值最高的动作，否则向最近的我军移动。

02=(X,Y) 不动/n 不动：
 无论攻击范围内是否有我军都会选择行动价值最高的动作，但是不会移动。
X,Y,n都无意义。（不确定）

03=(X,Y) 待命/n 待命：
 若移动范围+攻击范围内有我军就选择行动价值最高的动作，否则不会移动。
X,Y,n都无意义。（不确定）

04=(X,Y) 无攻击移动/n 无攻击移动：
 只会朝着目标坐标(X,Y)移动（若仇人代码为FF）或战场n号人物移动，不会攻击或使用策略。
1、当仇人代码为n=FF时，且到达了(X,Y)坐标，则AI变为03=(X,Y) 待命。
2、若仇人代码为n=00~2C且仇人消失，则AI变为01=攻击最近敌。

07=键入
 若我方AI≠07，则为友军。


九、物理攻击行动价值

0、使用攻击伤害函数计算一次伤害。注意：
0.1、计算伤害时，计算攻击方地形加成使用的是攻击方当前坐标而不是攻击时的坐标。
0.2、之后与等级相关的随机数加成与连击相关的算法，不进行计算。

1、如果攻击致命（攻击伤害>=防御方剩余耐久力），则行动价值=75。如果防御方还是象或蛇兵团，则行动价值再加5。

2、如果攻击不能致命，那么：
2.1、如果攻击伤害<防御方最大耐久力*10%，那么：
2.1.1、如果防御方还有>40%的耐久力，那么：
 　　　　如果攻击方AI≠1，或者攻击方是三大后勤兵种，那么行动价值=0。否则行动价值=10。
2.1.2、如果防御方还有<=40%的耐久力，那么：
 　　　　行动价值=16

 2.2、如果攻击伤害>=防御方最大耐久力*10%，那么：
 　　行动价值=16。如果防御方还是象或蛇兵团，则行动价值再加4。

3、如果防御方混乱，行动价值再加8。

4、如果行动价值>0，且防御方是我军或敌军主将，那么行动价值加10。

5、如果行动价值>0，且防御方是我军或敌军其他的有名字的武将，那么行动价值加6。

6、如果上述计算的行动价值<75，且攻击方是军师系、后勤、幻术师，则行动价值=0。

7、如果攻击方是象兵团，则周围8格有n个可以攻击到的（包括攻击点本身），行动价值再加 10*n。

8、如果攻击方是蛇兵团，则周围4格有n个可以攻击到的（包括攻击点本身），行动价值再加 10*n。

9、物理攻击行动价值最低为1。


十、策略行动价值

 （一）攻击性策略
1、如果受计方地形符合条件，且不是雨天（如果是火计），并且100-100*受计方智力/施计防智力/5>=50，那么：
 　1.1、先用策略伤害函数计算一次对中心点伤害。
 　1.2、如果致命（策略伤害>=受计方剩余耐久力），行动价值=80。
 　1.3、如果不致命，行动价值=20。
 　1.4、如果是大策略，那么中心点周围4格有n个人(n>=1)，行动价值再加10*n。
 　1.5、如果是大策略，那么中心点周围4格没有人，行动价值减4。
2、如果不满足第1步需要的条件，那么行动价值=0。

 （二）查看类
 如果受计方剩余策略值>0，且100-100*受计方智力/施计防智力/4>=50，那么行动价值=17；否则行动价值=0。

 （三）压迫、威压
1、如果受计方攻击力已经是双降了，行动价值=0。
2、如果受计方攻击力不是双降，那么
 　如果 100-100*受计方智力/施计防智力/3>=50，则行动价值=18；否则行动价值=0。
3、如果是威压，那么以受计方坐标为中心点，周围4格有n个人(n>=1)，行动价值再加10*n。
4、如果是威压，那么中心点周围4格没有人，行动价值减4（最低为0）。

 （三）骂声、挑拨
1、如果受计方防御力已经是双降了，行动价值=0。
2、如果受计方防御力不是双降，那么
 　 如果 100-100*受计方智力/施计防智力/3>=50，则行动价值=19；否则行动价值=0。
3、如果是挑拨，那么以受计方坐标为中心点，周围4格有n个人(n>=1)，行动价值再加10*n。
4、如果是挑拨，那么中心点周围4格没有人，行动价值减4（最低为0）。

 （四）假情报、伪兵
1、如果受计方剩余耐久力不足40%，行动价值=0。
2、如果受计方剩余耐久力>=40%，那么
 　 如果 100-100*受计方智力/施计防智力/4>=50，则行动价值=22；否则行动价值=0。
3、如果是伪兵，那么以受计方坐标为中心点，周围4格有n个人(n>=1)，行动价值再加10*n。
4、如果是伪兵，那么中心点周围4格没有人，行动价值减4（最低为0）。
5、如果受计方已经混乱，行动价值=0。

 （五）反间、流言
1、如果受计方剩余耐久力不足40%，行动价值=0。
2、如果受计方剩余耐久力>=40%，那么
 　 如果 100-100*受计方智力/施计防智力/3>=50，则行动价值=20；否则行动价值=0。
3、如果是流言，那么以受计方坐标为中心点，周围4格有n个人(n>=1)，行动价值再加10*n。
4、如果是流言，那么中心点周围4格没有人，行动价值减4（最低为0）。
5、如果受计方已经有耐久力每回合减少的状态，行动价值=0。

 （六）牵制
1、如果受计方兵种攻击速度>=8，那么行动价值=23，否则行动价值=0。
2、如果受计方已经有攻击速度减半的状态，行动价值=0。

 （七）止步
 如果受计方没有移动速度减半的状态，行动价值=25，否则行动价值=0。

 （八）封策
 如果受计方是文官（军师系、后勤、幻术师）且没有策略被封的状态，行动价值=24，否则行动价值=0。

 （九）耐久力恢复
1、计算策略威力基数：
  小补给、援队=0；
  中补给、援部=1；
  大补给、援军=2；
  全补给、援国=3。
2、如果受计方剩余耐久力<=40%，那么：
 　2.0、行动价值=30。
 　2.1、如果不是全补给或援国，期望值=施计方等级+200*(威力基数+1)
　2.2、如果是全补给或援国，期望值=受计方最大耐久力。
 　2.3、如果恢复了期望值之后满血，则
 　　 期望值=受计方最大耐久力-剩余耐久力；（这步应该删去，否则2.4步没意义）
 　　 行动价值加2。
 　2.4、如果 (受计方最大耐久力-剩余耐久力)/期望值<=60%，则行动价值减4。
 　2.5、如果受计方剩余耐久力<=20%，那么行动价值加4。
 　2.6、如果对自己使用，行动价值加1。
 　2.7、如果是大策略，那么自己周围8格有n个不满血的人(n>=1)，行动价值再加10*n。
 　2.8、如果是大策略，那么自己周围8格没有不满血的人，行动价值减4。
3、如果受计方剩余耐久力>40%，那么行动价值=0。

 （十）策略值恢复
1、如果受计方剩余策略值<=40%且最大策略值>0且不是物资队，那么：
 　2.0、行动价值=28。
 　2.1、计算恢复量，即：进言20，献策40，施策80。
 　2.2、如果恢复了之后满策略值，则行动价值加2。
 　2.3、如果 (受计方最大策略值-剩余策略值)/恢复量<=60%，则行动价值减4。
 　2.4、如果受计方剩余策略值<=20%，那么行动价值加4。
2、如果受计方剩余策略值>40%或者最大策略值=0或者是物资队，那么行动价值=0。

 （十一）觉醒
 如果受计方混乱，行动价值=0，否则行动价值=32。

 （十二）康复
 如果受计方中了耐久力每回合减少状态，行动价值=0，否则行动价值=31。

 （十三）解放
 如果受计方中了攻击速度减半状态，行动价值=0，否则行动价值=27。

 （十四）轻功
 如果受计方中了移动速度减半状态，行动价值=0，否则行动价值=26。

 （十五）奋起、鼓舞
1、如果受计方攻击力已经是双升了，行动价值=0。
2、如果受计方攻击力是单升或正常，那么
 　 受计方不是文官，行动价值=12；否则行动价值=0。
3、如果受计方攻击力是单降，行动价值=29。
4、如果受计方攻击力是双降，行动价值=31。
5、如果是鼓舞，那么以受计方坐标为中心点，周围4格有n个攻击力不是双升的人(n>=1)，行动价值再加10*n。
6、如果是鼓舞，那么中心点周围4格没有攻击力不是双升的人，行动价值减4（最低为0）。
7、如果对自己使用，行动价值减1。

 （十六）坚固、强阵
1、如果受计方防御力已经是双升了，行动价值=0。
2、如果受计方防御力是单升或正常，那么
 　 受计方不是文官，行动价值=11；否则行动价值=0。
3、如果受计方防御力是单降，行动价值=27。
4、如果受计方防御力是双降，行动价值=29。
5、如果是强阵，那么以受计方坐标为中心点，周围4格有n个防御力不是双升的人(n>=1)，行动价值再加10*n。
6、如果是强阵，那么中心点周围4格没有防御力不是双升的人，行动价值减4（最低为0）。
7、如果对自己使用，行动价值减1。

 （十七）对策
 如果受计方没有减轻策略伤害的状态，行动价值=13，否则行动价值=0。

 （十八）回归
1、如果受计方回合结束，行动价值=15，否则行动价值=0。
2、如果对自己使用，行动价值=0。

 （十九）升格
 行动价值=0。

 最后如果行动价值>0，那么：
1、如果受计方是我军或敌军主将，那么行动价值加10。
2、如果受计方是我军或敌军其他的有名字的武将，那么行动价值加6。
3、如果行动价值超过255，那么行动价值=255；如果行动价值低于0，那么行动价值=0。
4、如果受计方是仇人，行动价值加10。
5、有些变量会控制电脑操控部队策略的使用：
  (1)0x46A6DA处的值为0（初级难度），则：
  　 禁止使用对策、封策；
  　 禁止使用12~24号策略；
  　 步兵系、弓兵系、羌族兵不使用火系策略；
   　禁止在受计方攻防状态为单升或正常时使用奋起、鼓舞、坚固、强阵。
  (2)0x46A6DA处的值为1（中级难度），则：
   　禁止使用对策、封策；
   　禁止在受计方攻防状态为单升或正常时使用奋起、鼓舞、坚固、强阵。
  (3)0x46A6AC处的值（四字节）为1（当AI=1且移动范围+攻击范围内有敌人时），则
  　 可以使用奋起、鼓舞、坚固、强阵、对策。

---------------------------------------------------------------

这样就可以看出使用策略的大致优先级了（只考虑单体的策略）：

0、攻击类（致命） 80
 1、觉醒 32
 2、康复 31
 3、奋起（双降时） 31
 4、补给类 约30
 5、奋起（单降时） 29
 6、坚固（双降时） 29
 7、进言类 28
 8、解放 27
 9、坚固（单降时） 27
 10、轻功 26
 11、止步 25
 12、封策 24
 13、牵制 23
 14、假情报 22
 15、攻击类（不致命） 20
 16、反间 20
 17、骂声 19
 18、压迫 18
 19、查看类 17
 20、回归 15
 21、对策 13
 22、奋起（普通） 12
 23、坚固（普通） 11
 
 
 十一、坐标附加行动价值

 战场上每个点都有其附加的行动价值，具体是：

0、附加行动价值=0。（赋初值）
1、如果部队耐久力较低（有名字的部队耐久力小于等于40%或没名字的部队耐久力小于等于20%），则移动范围内的恢复地形的附加行动价值+50.
 2、若不是恢复地形，且地形加成>10，则附加行动价值加上 地形加成-10。
3、若是恢复地形，则附加行动价值加上 该地形耐久力恢复率/(5%)+3。
4、加上该附加行动价值后，总行动价值仍旧不能超过255。
5、在高级难度下，对于周围4格至少存在1个敌军的格子，该格行动价值减1。（最低为0）


十二、友军/敌军部队行动的顺序（以耐久力自动恢复后为准）

 第1优先级：处于恢复地形的部队按照部队列表的顺序行动；
 第2优先级：耐久力不多（有名字武将耐久力小于等于40%，无名小兵耐久力小于等于20%）的部队按照部队列表的顺序行动；
 第3优先级：剩余部队的按照部队列表的顺序行动。

 注：如果有人用了回归，则在此人执行完毕之后，按照上面的规则重新排序，剩下所有未执行的部队按照这个重排的顺序行动。
 
 十三、伏兵出场位置被占时，出场的实际位置

 如图，位置0为原先出场的坐标，如果位置n有人或不可移动地形或边界，则向位置n+1搜索，直到找到空位。

 出于算法速度考虑，系统只能提供如果60个空位。如果这60个都被占，则系统出错。
 十四、与目标坐标相关（仅适用于AI=0或4的部队）

 （一）如果不存在仇人
1、目标坐标行动价值加10；
2、目标坐标周围4格行动价值都加9；（如果是炮车系则不加）
3、如果行动价值最大的几个坐标中包含目标坐标，则优先进入目标坐标。

 （二）如果存在仇人
1、仇人周围4格行动价值都加10；（如果是炮车系则不加）
2、仇人的上2、右2、下2、左2、以及斜的4个格子行动价值都加9。（如果是炮车系则不加）
十五、电脑操控部队被包围后会干什么？

 如果电脑操控部队满足以下所有条件，则按照7L的图逆序（即编号最大的优先）攻击敌人，如果攻击范围内没有敌人，就什么事都不干：

1、该部队的AI为0（移动）、1（攻击最近敌）或3（休息）；
2、该部队周围4格都是敌人或者不可移动地形；
3、此条为AI=0的附加条件，AI=1或3时无视该条：

a)如果该部队存在仇人，且仇人不在周围4格中的任何一格；
b)如果该部队不存在仇人，且其目标坐标不是周围四格中的任何一格。

]]--



--[[
三国志英杰传详细流程攻略

道具篇：

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
许昌II：老酒，米，茶，援军书，长枪，连弩，马铠，无赖精神。
邺：长枪，连弩，马铠，无赖精神，特级酒，豆，麦，伤药。
白马：焦热书，漩涡书，浊流书，落石书，浓雾书。
汝南：焦热书，火龙书，漩涡书，浊流书，落石书，山崩书。
襄阳I：长枪，连弩，马铠，无赖精神，特级酒，麦，伤药，炸弹。
襄阳II：步兵车，发石车，近卫铠，侠义精神，火龙书，浊流书，山崩书，炸弹。
襄阳III：步兵车，发石车，近卫铠，侠义精神，猛火书，老酒，米，茶。
江夏I：火龙书，浊流书，山崩书，浓雾书，雷阵雨书。
江夏II：火龙书，浊流书，山崩书，浓雾书，雷阵雨书，长枪，连弩，马铠。
江陵I：特级酒，麦，中药，平气书，活气书，援队书。
江陵II：火龙书，浊流书，海啸书，山崩书，山洪书，援部书，活气书，勇气书。
长沙：平气书，活气书，援队书，援部书，漩涡书，浊流书。
涪：特级酒，麦，中药，火龙书，长枪，连弩，马铠，炸弹。
成都I：步兵车，发石车，近卫铠，侠义精神，特级酒，老酒，麦，中药。
成都II：步兵车，发石车，近卫铠，侠义精神，特级酒，老酒，麦，米。
西陵：火龙书，浊流书，山崩书，特级酒，麦，中药，援部书，活气书。
宛：老酒，米，茶，猛火书，海啸书，山洪书，雷阵雨书，豪雨书。

道具价格及等效策略：
道具卖价是买价的75%，个位数直接舍去。
道具        价格        等效策略
酒        50        激励
特级酒        100        支援
老酒        200        鼓舞
平气书        250        大激励
活气书        500        大支援
勇气书        1000        大鼓舞
豆        100        援助
麦        200        补给
米        400        救济
援队书        500        大援助
援部书        1000        大补给
援军书        2000        大救济
伤药        300        看护
中药        600        治愈
茶        1200        救命
焦热书        50        焦热
火龙书        100        火龙
猛火书        200        猛火
漩涡书        80        漩涡
浊流书        160        浊流
海啸书        320        海啸
落石书        100        落石
山崩书        200        山崩
山洪书        400        山洪
浓雾书        50        假情报
雷阵雨书        100
豪雨书        200        伪装
炸弹        500
长枪        300
步兵车        600
连弩        350
发石车        700
马铠        400
近卫铠        800
无赖精神        200
侠义精神        400

剧情篇：


战前购买道具地点：陈留。
第一关，汜水关之战，30回合。
自动出场：1级短兵刘备，1级轻骑兵关羽、张飞。
友军：4级轻骑兵公孙瓒(如果说话)，4级短兵陶谦(如果说话)。
单挑：关羽vs华雄(胜利，阵亡，升级)。
主将：华雄。
粮仓道具：豆。
宝物库道具：100金。
战后奖励：100金。
战后不收兵不能交换道具进入虎牢关之战。

第二关，虎牢关之战，30回合。
自动出场：刘备，关羽，张飞。
友军：公孙瓒(如果说话)，陶谦(如果说话)。
单挑：张飞vs吕布(胜利，撤退，升级)。
主将：吕布。
粮仓道具：豆。
宝物库道具：焦热书。
战后奖励：100金。
战后可选择进入信都之战或广川之战。
战后购买道具地点：北平。

第一章　界桥之战

战前3级弓兵简雍加入。
第三关，信都之战，30回合。
必须出场：刘备。
选择出场：3人。
友军：4级武术家队潘宫，4级山贼郭适，4级短兵韩英。
单挑：张飞vs淳于琼(胜利，撤退，升级)。
主将：淳于琼。
50点经验：刘备到达城门口。
宝物库道具：100金(上)，酒(下)。
战后奖励：200金。
战后潘宫加入。
战后购买道具地点：信都。
战后可选择进入巨鹿之战或清河之战。

战前3级弓兵简雍加入。
第三关，广川之战，30回合。
必须出场：刘备。
选择出场：3人。
单挑：关羽vs逢纪(胜利，撤退，升级)。
主将：逢纪。
宝物库道具：100金(左)，豆(右)。
战后奖励：200金。
战后4级山贼郭适，4级短兵韩英加入。
战后购买道具地点：广川。
战后可选择进入巨鹿之战或清河之战。

第四关，巨鹿之战，30回合。
必须出场：刘备。
选择出场：4人。
友军：7级弓兵公孙越，5级短兵羽则。(第3回合)4级弓兵关纯，4级短兵耿武。
单挑：张飞vs颜良(撤退，升级)。
主将：张郃。
50点经验：刘备到达西面鹿砦。
粮仓道具：麦。
战后奖励：200金(灭掉张郃)。
战后关纯，耿武加入。
战后不收兵进入界桥之战，敌人前线增加7级弓兵张南，6级山贼。

第四关，清河之战，30回合。
必须出场：刘备。
选择出场：4人。
友军：4级轻骑兵严纲。
单挑：麴义vs严纲(第一回合，阵亡)，关羽vs麴义(胜利，阵亡，升级)。
主将：麴义。
粮仓道具：酒。
宝物库道具：100金。
战后奖励：200金。
战后不收兵进入界桥之战，敌人前线增加8级短兵逢纪，7级弓兵高览，3级轻骑兵，3级弓兵。

第五关，界桥之战，40回合。
必须出场：刘备。
选择出场：4人。
友军：7级轻骑兵陈蒋，7级弓兵周比，(比虎牢关之战高4级)公孙瓒，11级轻骑兵赵云。
单挑：文丑vs陈蒋(第一回合，阵亡)，赵云vs文丑(第一回合)，张飞vs文丑(撤退，升级)。
主将：袁绍。
50点经验：刘备夺取兵粮库。
宝物库道具：火龙书(左下)，长枪(中下)，麦(中上)，连弩(右上)。
战后奖励：200金。
战后进入北海之战。
战后购买道具地点：北平，信都。


第一章　支援北海●徐州

战前赵云加入。
第六关，北海之战，30回合。
必须出场：刘备，赵云。
选择出场：4人。
友军：1级山贼孟肃，8级短兵孔融，9级轻骑兵太史慈。
单挑：赵云vs管亥(胜利，阵亡，升级)。
主将：管亥。
宝物库道具：特级酒(上)，平气书(下)。
战后奖励：300金。
战后孔融赠送500金。
战后进入徐州I之战。
战后购买道具地点：北平，信都，北海。

第七关，徐州I之战，30回合。
必须出场：刘备，赵云。
选择出场：5人。
友军：9级短兵糜芳，9级运输队孙乾，(比虎牢关之战高6级)陶谦，(第5回合)(比北海之战高4级)太史慈。
单挑：关羽vs于禁(撤退，升级)。
主将：于禁(吃主将不过关)。
50点经验：刘备进入徐州城。
战后奖励：300金(全数歼灭敌人)。
战后可选择进入小沛之战或彭城I之战或夏丘I之战或泰山之战。
如选择不打小沛之战，陶谦会赠送雌雄双剑，孙乾同样会加入。
战后购买道具地点：北平，信都，北海，徐州，下邳。

第八关，小沛之战，9回合(超过回合数则过关)。
必须出场：刘备，赵云。
选择出场：5人。
友军：(均比徐州I之战高1级)糜芳，孙乾，陶谦。
单挑：张飞vs夏侯渊(撤退，升级)。
主将：曹操。
战后奖励：300金(灭掉曹操)。
战后孙乾加入。
战后可选择进入彭城I之战或夏丘I之战或泰山之战。
战后购买道具地点：北平，信都，北海，徐州，下邳，小沛。


第一章　饿虎吕布来访

第九关，彭城I之战，30回合。
必须出场：刘备。
不能出场：赵云。
选择出场：6人。
单挑：刘备vs赵何(胜利，投降，升级)。
主将：赵何(吃主将不过关)。
宝物库道具：剑术指南书。
战后奖励：400金。
战后12级山贼赵何(如果劝降)加入。
战后可选择进入夏丘I之战(如果没打，不收兵)或泰山之战(如果没打，不收兵)或淮南之战。

第十关，夏丘I之战，30回合。
必须出场：刘备。
不能出场：赵云。
选择出场：6人。
单挑：刘备vs董梁(胜利，投降，升级)。
主将：董梁(吃主将不过关)。
宝物库道具：漩涡书。
战后奖励：400金。
战后12级山贼董梁(如果劝降)加入。
战后可选择进入彭城I之战(如果没打，不收兵)或泰山之战(如果没打，不收兵)或淮南之战。

第十一关，泰山之战，40回合。
必须出场：刘备。
不能出场：赵云。
选择出场：6人。
单挑：刘备vs李明(胜利，投降，升级)。
主将：李明(吃主将不过关)。
宝物库道具：炸弹(下)，落石书(上)。
战后奖励：400金。
战后12级猛兽兵团李明(如果劝降)加入。
战后可选择进入彭城I之战(如果没打，不收兵)或夏丘I之战(如果没打，不收兵)或淮南之战。

战前小沛农民送来弓术指南书(如果打了彭城I之战)，浊流书(如果打了夏丘I之战)，500金(如果打了泰山之战)。
战前(比小沛之战高3级)糜芳，13级军乐队糜竺加入。
战前购买道具地点：北平，信都，北海，徐州，下邳，小沛。
第十二关，淮南之战，30回合。
必须出场：刘备。
不能出场：赵云。
选择出场：8人。
单挑：关羽vs张辽(撤退，升级)。
主将：纪灵(吃主将不过关)。
50点经验：刘备到达西北鹿砦。
宝物库道具：猛火书。
战后奖励：400金(全数歼灭敌人)。
战后可选择进入彭城II之战或夏丘II之战。
战后购买道具地点：北平，北海，徐州，小沛，许昌I。


第一章　讨伐吕布之战

第十三关，夏丘II之战，30回合。
必须出场：刘备。
不能出场：赵云。
选择出场：6人。
友军：14级军乐队荀彧，14级短兵曹洪，15级短兵曹仁。
单挑：关羽vs张辽(胜利，50点经验)。
主将：张辽。
50点经验：关羽单挑张辽。
宝物库道具：400金。
战后奖励：500金。
战后进入下邳之战。
战后购买道具地点：北平，北海，信都，徐州，小沛，许昌I。

第十三关，彭城II之战，30回合。
必须出场：刘备。
不能出场：赵云。
选择出场：6人。
友军：13级弓兵郭嘉，14级轻骑兵夏侯惇，14级轻骑兵夏侯渊。
单挑：张飞vs高顺(胜利，撤退，升级)。
主将：高顺。
宝物库道具：马铠。
战后奖励：500金。
战后进入下邳之战。
战后购买道具地点：北平，北海，信都，徐州，小沛，许昌I。

第十四关，下邳之战，45回合。
必须出场：刘备。
不能出场：赵云。
选择出场：6人。
友军：(第30回合或刘备收降三将并到达城门口)(与夏丘II之战等级相同)曹洪、曹仁、荀彧，(与彭城II之战等级相同)郭嘉、夏侯惇、夏侯渊，(与小沛之战等级相同)曹操。
单挑：刘备vs宋宪(撤退，升级)，刘备vs魏续(撤退，升级)，刘备vs侯成(撤退，升级)，关羽vs张辽(撤退，升级)。
主将：吕布。
宝物库道具：赤兔马(左)，方天画戟(右)。
战后奖励：500金。
战后进入广陵之战。
战后购买道具地点：北平，北海，信都，徐州，小沛，许昌I，下邳。


第一章　徐州攻防战

第十五关，广陵之战，30回合。
必须出场：刘备。
不能出场：赵云。
选择出场：6人。
单挑：张飞vs纪灵(阵亡，三尖刀)。
主将：袁术。
宝物库道具：400金(左)，七星剑(右)。
战后奖励：600金。
战后进入徐州II之战。
战后购买道具地点：下邳。

第十六关，徐州II之战，50回合。
必须出场：刘备。
不能出场：关羽，张飞，赵云。
选择出场：8人。
主将：车胄(吃主将不过关)。
50点经验：刘备到达西南村。
战后奖励：600金(灭掉曹操)。
战后进入兖州之战。
战后购买道具地点：邺，北海，白马。

第二章　官渡之战

第十七关，兖州之战，45回合。
必须出场：刘备。
不能出场：关羽，张飞。
自动出场：(第1回合)(比小沛之战高7级)重骑兵赵云。
选择出场：8人。
单挑：赵云vs张郃(撤退，升级)。
主将：郭图。
50点经验：刘备到达西南鹿砦。
粮仓道具：茶。
宝物库道具：炸弹。
战后奖励：700金(灭掉郭图)。
战后不能购买道具进入古城之战。

第十八关，古城之战，40回合。
必须出场：刘备。
不能出场：关羽，张飞。
选择出场：6人。
单挑：所有人vs？？？(胜利)。
主将：？？？。
粮仓道具：特级酒。
宝物库道具：山崩书(左)，剑术指南书(右)。
战后奖励：700金(灭掉？？？)。
战后(比广陵之战高3级)张飞回归。
战后不能购买道具进入颖川之战。

第十九关，颖川之战，30回合。
必须出场：刘备。
自动出场：(均为第8回合)22级重骑兵关平，22级恶贼周仓，(比广陵之战高3级)关羽。
选择出场：7人。
单挑：关羽vs蔡阳(胜利，阵亡，升级)。
主将：蔡阳。
宝物库道具：山洪书。
战后奖励：700金。
战后可选择进入汝南之战或江夏之战。
如果打汝南之战，购买道具地点：汝南。
如果不打汝南之战，刘表赠送2000金，购买道具地点：襄阳I。

第二十关，汝南之战，40回合。
必须出场：刘备。
自动出场：(第3回合)孙乾
选择出场：8人。
友军：22级恶贼朱康、严双，23级恶贼刘辟。
单挑：赵云vs许褚(升级)。
主将：曹仁。
50点经验：刘备到达西南鹿砦。
宝物库道具：鼓吹具。
战后奖励：700金。
战后可选择刘辟是否加入。
战后进入江夏之战。
战后购买道具地点：襄阳I。


第二章　隐伏新野

战前23级长兵伊籍、刘封加入。
第二十一关，江夏之战，40回合。
必须出场：刘备。
选择出场：9人。
单挑：张飞vs陈孙(阵亡，升级)，赵云vs张武(胜利，阵亡，的卢)。
主将：张武。
宝物库道具：侠义精神(上)，步兵车(左下)，400金(右下)。
战后奖励：800金。
战后进入南阳之战。
战后购买道具地点：襄阳I，江夏I。

战前26级妖术师徐庶加入。
第二十二关，南阳之战，40回合。
必须出场：刘备，徐庶。
选择出场：8人。
单挑：赵云vs吕旷(阵亡，升级)，张飞vs吕翔(阵亡，升级)。
主将：曹仁。
50点经验：从最里面攻入阵中。
战后奖励：800金。
战后徐庶离开。
战后可选择进入博望坡之战或新野I之战。
战后购买道具地点：襄阳I，江夏I。


第二章　诸葛孔明下山

30级妖术师诸葛亮加入。


第二章　曹操南征

第二十三关，博望坡之战，40回合。
必须出场：刘备，诸葛亮，赵云。
自动出场：(放火时)关羽，张飞，简雍，关平，周仓，刘封；(或者10回合)关羽，张飞，简雍，周仓。
选择出场：5人。
单挑：关羽vs李典(撤退，升级)。
主将：夏侯惇。
50点经验：放火。
战后奖励：900金。
战后不能购买道具可选择进入襄阳I之战或长阪坡之战。

第二十三关，新野I之战，29回合(超过回合数则过关)。
必须出场：刘备，诸葛亮，张飞。
选择出场：8人。
单挑：张飞vs于禁(撤退，升级)。
主将：夏侯惇。
50点经验：诸葛亮夺取粮仓。
战后奖励：900金。
战后不能购买道具可选择进入襄阳I之战或长阪坡之战。

第二十四关，襄阳I之战，14回合(超过回合数则过关)。
必须出场：刘备。
不能出场：关羽，伊籍。
选择出场：11人。
单挑：赵云vs张允(阵亡，升级)。
主将：蔡瑁。
50点经验：灭掉蔡瑁。
粮仓道具：茶。
宝物库道具：猛火书(左)，倚天剑(上)。
战后奖励：900金(灭掉蔡瑁)。
战后不收兵进入长阪坡之战。

第二十五关，长阪坡之战，99回合(其中长阪坡I之战不能超过70回合)。
必须出场：刘备，诸葛亮。
不能出场：关羽，伊籍。
选择出场：10人。
单挑：赵云vs夏侯恩(阵亡，青釭剑)。
主将：曹操×2。
50点经验：民众逃至东南村。
50点经验：民众逃至西北桥。
战后奖励：900金(长阪坡II之战灭掉曹操)。
战后伊籍，(比博望坡之战高2级)关羽回归。 
战后进入江陵之战。
战后购买道具地点：江夏II。

第三章　荆州南部征服战

第二十六关，江陵之战，15回合(超过回合数则过关)。
必须出场：刘备。
选择出场：8人。
单挑：赵云vs甘宁(撤退，升级)。
主将：陈矫(8回合起吃主将不过关)。
50点经验：7回合内消灭陈矫。
宝物库道具：弓术指南书。
战后奖励：1000金。
战后30级运输队马良加入，可选择30级军乐队马谡是否加入。
战后可选择进入武陵之战或零陵之战或桂阳之战。
战后购买道具地点：襄阳II，江夏II，江陵。

第二十七关，武陵之战，35回合。
必须出场：刘备。
不能出场：关羽，张飞，赵云。
选择出场：6人。
单挑：周仓vs金旋(胜利，阵亡，升级)，刘备vs巩志(胜利，投降，50点经验)。
主将：金旋。
50点经验：刘备单挑巩志。
宝物库道具：发石车(左)，500金(右)。
战后奖励：1000金。
战后31级发石车巩志(如果劝降)加入。
战后进入长沙之战。
战后购买道具地点：襄阳II，江夏II，江陵。

第二十七关，零陵之战，35回合。
必须出场：刘备。
不能出场：关羽，张飞，赵云。
选择出场：6人。
单挑：关平vs刑道荣(阵亡，升级)，刘备vs刘度(胜利，50点经验)。
主将：刘度。
50点经验：刘备单挑刘度。
宝物库道具：援队书。
战后奖励：1000金。
战后进入长沙之战。
战后购买道具地点：襄阳II，江夏II，江陵。

第二十七关，桂阳之战，35回合。
必须出场：刘备。
不能出场：关羽，张飞，赵云。
选择出场：6人。
单挑：刘封vs鲍龙(阵亡，升级)，刘备vs赵范(胜利，50点经验)。
主将：赵范。
50点经验：刘备单挑赵范。
宝物库道具：浊流书。
战后奖励：1000金。
战后进入长沙之战。
战后购买道具地点：襄阳II，江夏II，江陵。

第二十八关，长沙之战，40回合。
必须出场：刘备。
选择出场：10人。
单挑：关羽vs黄忠(胜利，升级)，刘备vs魏延(胜利，50点经验)。
主将：韩玄。
50点经验：刘备单挑魏延。
宝屋库道具：剑术指南书(左下)，英雄之剑(右上)。
战后奖励：1000金。
战后33级武术家队魏延，33级战车黄忠加入。
战后进入公安之战。
战后购买道具地点：襄阳II，江夏II，江陵，长沙。


第三章　荆州所有权的纠纷

第二十九关，公安之战，40回合。
必须出场：刘备，诸葛亮。
选择出场：10人。
单挑：关羽vs吕蒙(撤退，升级)。
主将：周瑜。
50点经验：14回合内且不惊动吴军占领四个鹿砦。
宝屋库道具：海啸书(左上)，鼓吹具(右下)。
战后奖励：1100金。
战后可选择30级发石车蒋琬、费祎是否加入；拒绝了这两人还可以反悔，答应了就不能反悔了。
战后34级妖术师庞统加入。
战后进入雒I之战。
战后购买道具地点：襄阳II，江夏II，江陵，长沙，涪。


第三章　益州攻略战

战前34级战车法正加入。
第三十关，雒I之战，7回合(超过回合数则过关)。
必须出场：刘备，庞统。
不能出场：诸葛亮，关羽，张飞，赵云，简雍，伊籍。
选择出场：9人。
主将：刘贵。
50点经验：庞统阵亡。
战后奖励：1200金(灭掉刘贵)。
战后进入雒II之战。
战后购买道具地点：涪。

战前34级战车严颜加入。
第三十一关，雒II之战，40回合。
必须出场：刘备。
不能出场：关羽，关平，周仓。
自动出场：(均为第2回合)诸葛亮，赵云，简雍，伊籍。
选择出场：8人。
敌人倒戈：37级近卫队吴兰，36级发石车李严。
单挑：刘备vs雷铜(撤退，投降，升级)，刘备vs吴懿(撤退，投降，升级)，刘备vs费观(撤退，投降，升级)，刘备vs吴兰(倒戈，升级)，刘备vs李严(倒戈，升级)，张飞vs张任(阵亡，升级)。
主将：刘贵。
战后37级近卫队雷铜(如果劝降)，37级发石车吴懿(如果劝降)，36级战车费观加入(如果劝降)。
战后奖励：1200金。
战后进入葭萌关I之战。
战后购买道具地点：涪。

第三十二关，葭萌关I之战，30回合。
必须出场：刘备，张飞。
不能出场：诸葛亮，关羽，关平，周仓。
选择出场：8人。
单挑：张飞vs马超(集团撤退，升级)。
主将：张鲁。
宝屋库道具：援军报告。
战后奖励：1200金。
战后41级近卫队马超，40级近卫队马岱加入。
战后可选择进入成都之战或瓦口关之战。
如果打成都之战，购买道具地点：襄阳II，江夏II，江陵，长沙，涪。
如果不打成都之战，刘璋赠送黄爪飞龙，购买道具地点：襄阳II，江夏II，江陵，长沙，涪，成都I。

第三十三关，成都之战，40回合。
必须出场：刘备。
不能出场：关羽，关平，周仓。
选择出场：8人。
敌人倒戈：36级发石车吴班，36级武术家队陈式，37级猛兽兵团霍峻，37级异民族沙摩可，37级战车孟达，38级战车黄权。
单挑：刘备vs吴班(倒戈，升级)，刘备vs陈式(倒戈，升级)，刘备vs霍峻(倒戈，升级)，刘备vs沙摩可(倒戈，升级)，刘备vs孟达(倒戈，升级)，刘备vs黄权(倒戈，升级)，刘备vs刘璋(胜利，50点经验)。
主将：刘璋。
50点经验：刘备单挑刘璋。
宝屋库道具：发石车(上)，步兵车(下)。
战后奖励：1200金。
战后进入瓦口关之战。
战后购买道具地点：襄阳II，江夏II，江陵，长沙，涪，成都I。


第三章　汉中攻防战

第三十四关，瓦口关之战，80回合(两战各40回合)。
必须出场：刘备。
不能出场：关羽，关平，周仓。
选择出场：11人。
单挑：雷铜vs张郃×2(自己撤退)。
主将：张郃×2。
宝屋库道具：猛火书(瓦口关II左)，赦命书(瓦口关II中)。
战后奖励：1300金。
战后不能购买道具可选择进入葭萌关II之战或定军山之战。

第三十五关，葭萌关II之战，35回合。
必须出场：刘备。
不能出场：关羽，关平，周仓。
选择出场：9人。
单挑：严颜vs夏侯德(胜利，阵亡，升级)。
主将：夏侯德。
粮仓道具：米(左下)，老酒(右上)。
宝屋库道具：海啸书(左上)，近卫铠(右下)。
战后奖励：1300金。
战后不能购买道具可选择进入天荡山I之战或定军山之战。

第三十五/三十六关，定军山之战，35回合。
必须出场：刘备。
不能出场：关羽，关平，周仓。
选择出场：12人。
敌人倒戈：42级战车王平。
单挑：刘备vs王平(倒戈，升级)，黄忠vs夏侯渊(胜利，阵亡，升级)。
主将：夏侯渊。
宝屋库道具：800金(左下)，青囊书(上)，山洪书(右)。
战后奖励：1300金。
战后不能购买道具。
如果没打葭萌关II之战，可选择进入天荡山II之战或汉水之战。
如果打了葭萌关II之战，进入汉水之战。

第三十六关，天荡山I之战，40回合。
必须出场：刘备。
不能出场：关羽，关平，周仓。
选择出场：11人。
敌人倒戈：45级战车王平。
单挑：刘备vs王平(倒戈，升级)，黄忠vs夏侯渊(阵亡，升级)。
主将：徐晃。
粮仓道具：中药。
战后奖励：1300金。
战后不能购买道具进入汉水之战。

第三十六关，天荡山II之战，40回合。
必须出场：刘备。
不能出场：关羽，关平，周仓。
选择出场：9人。
单挑：严颜vs夏侯德(胜利，阵亡，升级)。
主将：夏侯德。
粮仓道具：中药。
战后奖励：1300金。
战后不能购买道具进入汉水之战。

第三十七关，汉水之战，40回合。
必须出场：刘备。
不能出场：关羽，关平，周仓。
选择出场：12人。
单挑：吴兰vs曹彰(自己撤退)。
主将：曹洪。
粮仓道具：茶
宝屋库道具：1000金。
战后奖励：1300金。
战后不能购买道具进入阳平关之战。

第三十八关，阳平关之战，45回合。
必须出场：刘备。
不能出场：关羽，关平，周仓。
选择出场：13人。
单挑：马超vs庞德(升级)。
主将：曹操。
宝屋库道具：马术指南书。
战后奖励：1300金。
战后不能购买道具进入麦之战。


第三章　蜀汉建国

第三十九关，麦之战，50回合。
自动出场：(比公安之战高10级)关羽，(比雒I之战高9级)关平，(比雒I之战高9级)周仓，40级战车王甫、廖化，40级发石车赵累。
主将：吕蒙(吃主将不过关)。
宝屋库道具：援军书(左上)，茶(下)，援军书(右)。
战后奖励：无。
战后可选择进入西陵之战或襄阳II之战。
如果打西陵之战，购买道具地点：成都I，涪。
如果不打西陵之战，诸葛瑾赠送孙子兵法，购买道具地点：成都I，涪，成都II，江陵II。

如果关羽在麦城阵亡，战前张飞被张达、范疆杀死。
第四十关，西陵之战，40回合。
必须出场：刘备。
不能出场：诸葛亮，赵云，马超，马岱，关羽，关平，周仓，王甫，廖化，赵累。
自动出场：(均为第1回合)41级近卫队关兴、张苞，41级战车刘禅。
选择出场：8人。
单挑：张苞vs谢旌(阵亡，升级)，关兴vs李异(阵亡，升级)。
主将：孙桓。
战后奖励：1400金。
战后可选择进入彝陵之战或襄阳II之战。
如果打彝陵之战，购买道具地点：西陵，成都I，涪。
如果不打彝陵之战，诸葛瑾赠送吴子兵法，购买道具地点：西陵，成都I，涪，成都II，江陵II。

第四十一关，彝陵之战，50回合。
必须出场：刘备。
不能出场：诸葛亮，赵云，马超，马岱，关羽，关平，周仓，王甫，廖化，赵累。
选择出场：14人。
单挑：周泰vs沙摩可(阵亡)。
主将：陆逊。
战后奖励：1400金。
战后进入襄阳II之战。
战后购买道具地点：成都II，江陵II。

第四章　夺回荆州

如果没打西陵之战，战前41级近卫队关兴、张苞，41级战车刘禅加入。
如果不要求孙权派奇袭队攻合淝，孙权赠送2000金。
第四十二关，襄阳II之战，40回合。
必须出场：刘备，诸葛亮。
不能出场：关羽，关平，周仓，王甫，廖化，赵累。
如果派出奇袭队，另外不能出场：庞统，赵云，马超，魏延，简雍，糜竺，糜芳，伊籍，刘封，法正。
选择出场：6人。
友军：(如果关羽没死)45级近卫队？？？
(如果没打西陵之战)40级近卫队凌统，40级猛兽兵团甘宁，38级战车丁奉，39级战车徐盛，47级妖术师陆逊。
(如果只打西陵之战)51级近卫队凌统，51级猛兽兵团甘宁，49级战车丁奉，50级战车徐盛，53级妖术师陆逊。
(如果打了彝陵之战)53级近卫队凌统，53级猛兽兵团甘宁，52级战车丁奉，53级战车徐盛，56级妖术师陆逊。
单挑：？？？vs曹仁(胜利，阵亡，50点经验)。
主将：曹仁。
50点经验：？？？单挑曹仁。
粮仓道具：茶。
宝物库道具：马术指南书(左)，青囊书(上)。
战后奖励：1500金。
战后可选择进入新野II之战或南郡之战。
战后购买道具地点：成都II，江陵II，襄阳III。

第四十三关，新野II之战，40回合。
必须出场：刘备，诸葛亮。
不能出场：关羽，关平，周仓，王甫，廖化，赵累。
如果派出奇袭队，另外不能出场：庞统，赵云，马超，魏延，简雍，糜竺，糜芳，伊籍，刘封，法正。
选择出场：8人。
单挑：张飞vs于禁(胜利，撤退，升级)。
主将：于禁。
50点经验：自军部队夺取粮仓。
宝物库道具：勇气书。
战后奖励：1500金。
战后(如果没打西陵之战)丁奉、徐盛、凌统、甘宁加入。
战后(如果只打西陵之战)丁奉、徐盛、凌统加入。
战后(如果打了彝陵之战)丁奉、徐盛加入。
战后不能购买道具(如果要求孙权进攻合淝)进入宛II之战，(如果不要求孙权进攻合淝)进入宛I之战。

第四十三关，南郡之战，40回合。
必须出场：刘备，诸葛亮。
不能出场：关羽，关平，周仓，王甫，廖化，赵累。
如果派出奇袭队，另外不能出场：庞统，赵云，马超，魏延，简雍，糜竺，糜芳，伊籍，刘封，法正。
选择出场：8人。
单挑：张苞vs夏侯尚(阵亡，升级)。
主将：于禁。
50点经验：占领南北两个鹿砦。
宝物库道具：海啸书(左)，援队书(上)，2000金(右)。
战后奖励：1500金。
战后(如果没打西陵之战)丁奉、徐盛、凌统、甘宁加入。
战后(如果只打西陵之战)丁奉、徐盛、凌统加入。
战后(如果打了彝陵之战)丁奉、徐盛加入。
战后不能购买道具(如果要求孙权进攻合淝)进入宛II之战，(如果不要求孙权进攻合淝)进入宛I之战。

第四十四关，宛I之战，40回合。
必须出场：刘备，诸葛亮。
不能出场：关羽，关平，周仓，王甫，廖化，赵累。
如果派出奇袭队，另外不能出场：庞统，赵云，马超，魏延，简雍，糜竺，糜芳，伊籍，刘封，法正。
选择出场：8人。
单挑：张飞vs张辽(胜利，撤退，升级)。
主将：张辽。
宝物库道具：炸弹(右)，援队书(中)，猛火书(上)。
战后奖励：1500金。
战后不收兵进入宛II之战。

第四十五关，宛II之战，30回合(如果没打宛I之战则为50回合)。
必须出场：刘备，诸葛亮。
不能出场：关羽，关平，周仓，王甫，廖化，赵累。
如果派出奇袭队，另外不能出场：庞统，赵云，马超，魏延，简雍，糜竺，糜芳，伊籍，刘封，法正。
选择出场：8人。
单挑：张飞vs徐晃(阵亡，升级)，关羽vs夏侯惇(胜利，阵亡，升级)。
主将：夏侯惇。
宝物库道具：遁甲天书(左下)，马术指南书(右下)，剑术指南书(右上)。
战后奖励：1500金。
如果派奇袭队且关羽麦城没死，战后(比麦之战高7级)关羽，(比麦之战高6级)关平、周仓、王甫、廖化、赵累回归。
如果派奇袭队，进入陈仓长安之战。
如果没派奇袭队，进入洛阳之战。
战后购买道具地点：成都II，江陵II，襄阳III，宛。


第四章　中原决死战

第四十六关，陈仓长安之战，59回合(其中陈仓之战不能超过29回合)。
自动出场：庞统，赵云，马超，魏延，简雍，糜竺，糜芳，伊籍，刘封，法正。
(如果庞统雒I阵亡，奇袭主将为赵云，人选为剩下9人)。
敌人倒戈：48级异民族程德、高苍，49级异民族张獲，50级近卫队姜维，52级妖术师徐庶徐庶。
单挑：马超vs程德/高苍/张獲(升级，三人倒戈)，所有人vs姜维(倒戈)，魏延vs郝昭(胜利，阵亡，升级)，所有人vs徐庶(倒戈)，赵云vs张郃(阵亡，升级)。
主将：郝昭，曹真。
宝物库道具：六韬(陈仓左)，弓术指南书(陈仓中)，三略(陈仓右)，援军书(长安)。
战后奖励：1600金×2(单挑或灭掉郝昭、灭掉曹真)。
如果陈仓超过29回合，或两战总和超过59回合，或主将被打死，进入许昌I之战。
如果奇袭成功进入许昌II之战。
战后购买道具地点：成都II，江陵II，襄阳III，宛。

第四十六关，洛阳之战，40回合。
必须出场：刘备，诸葛亮。
选择出场：8人。
敌人倒戈：54级妖术师徐庶。
单挑：所有人vs徐庶(倒戈)，张飞vs张郃(阵亡，升级)。
主将：曹真。
宝物库道具：援军书(左)，2000金(右)。
战后奖励：1600金。
战后不收兵进入许昌I之战。

第四十七关，许昌I之战，40回合。
必须出场：刘备，诸葛亮。
不能出场：(如果派奇袭队且奇袭失败)简雍，糜竺，糜芳，伊籍，刘封，法正。
自动出场：(如果派奇袭队且奇袭失败)(第12回合)庞统，赵云，马超，魏延，姜维。
选择出场：8人。
单挑：关兴vs许褚(升级)。
主将：司马懿。
宝物库道具：弓术指南书(左)，剑术指南书(右)。
战后奖励：1600金。
战后不收兵进入许昌II之战。

第四十八关，许昌II之战，40回合。
必须出场：刘备，诸葛亮。
不能出场：黄忠，严颜。
选择出场：11人。
单挑：关羽vs张辽(撤退，投降，升级)。
主将：司马懿。
宝物库道具：玉玺。
战后奖励：1600金。
战后62级战车张辽加入(如果劝降)，黄忠、严颜死亡。
战后进入邺之战。
战后购买道具地点：成都II，江陵II，襄阳III，宛，许昌II。


第四章　蜀魏最后决战

第四十九关，邺I之战，40回合。
必须出场：刘备，诸葛亮。
选择出场：13人。
单挑：张苞vs曹彰(阵亡，升级)，关兴vs曹植(阵亡，升级)。
主将：曹丕。
宝物库道具：援军书(左)，霸王之剑(右)。

第五十关，邺II之战，27回合。
主将：司马懿。
宝物库道具：援军书(左、中)，勇气书(左上、右)。

第五十一关，邺III之战，50回合。
单挑：赵云vs李典(阵亡，升级)，张飞vs许禇(阵亡，升级)，关羽vs张辽(阵亡，升级)，马超vs乐进(阵亡，升级)。
主将：曹操。


]]--

--[[
---<<War Enhancement>>---
技能类:
	仁德/收拾/水神/火神/天变
	仁德:	回复附近我军兵力士气
	收拾:	回复附近我军混乱
	水神:	大猛火,免疫火系策略
	火神:	大漂流,免疫水系策略
	天变:	控制天气
基础属性类:
	雄师/威风/勇武*/坚韧*/速攻*
	雄师:	按等级提高部队兵力
	威风:	部队士气+20
	勇武:	按武力提高部队攻击
	坚韧:	按统率提高部队防御
	速攻:	移动范围+1
策略类:
	水计/火计/落石/落沙/神算/识破
	水计:	火系策略威力上升
	灭火:	受到火系策略伤害下降
	火计:	火系策略威力上升
	落石:	落石系策略威力上升
	落沙:	使用落石系策略成功后,一定几率使敌军混乱
	明镜:	不会混乱
	神算:	策略成功率上升
	识破:	敌军策略成功率下降
其他?:
	报复/冷静
	报复:	反击率上升
	冷静:	每回合回复混乱状态
	伏兵:	作为伏兵登场时属性上升
	治疗:	每回合回复自身兵力
	藤甲:	受到攻击伤害减半,受到火系策略伤害加倍
	反弓:	受到弓兵的伤害减少30%
	反骑:	受到骑兵的伤害减少30%
	不屈:	部队兵力越低,所受伤害越低
	猛者:	部队兵力越低,攻击伤害越高
	背水:	部队兵力越低,所受伤害越低,攻击伤害越高
	谨慎:	攻击以及被攻击伤害降低
	无双:	部队防御力上升,受多部队攻击损伤减小
	精兵:	不会因为士气下降而陷入混乱或撤退
	犄角:	自势力部队相邻时,所受伤害下降
	攻心:	攻击时可将敌方部分兵力吸收到自己部队中
	强行:	突击移动
	百出:	每回合回复策略
	布阵:	作为统帅时,提高全军防御
	魏武:	作为统帅时,提高全军攻击防御
	八阵:	作为统帅时,提高全军攻击防御移动

仁德：回复附近我军兵力士气（增加一个策略）
铁壁：防御力强化
？？：攻击力强化
？？：移动力强化
？？：降低策略消耗
报复：反击率提高
冷静：每回合回复混乱


无双，奋发，火计，水计，落石，强行，乱射，速攻
沉着，布阵，反计，远射，回射，乱射，骑射，激励
伏兵，内讧，鼓舞，火神，水神，灭火，收拾，混乱
占卜，天变，治疗，祈雨，落沙，藤甲，幻术，妖术，仙术

铁骑/虎豹
奋战/枪阵
连弩/齐射
偷袭/游击
裸衣 鬼才 奸雄
忍耐 刚烈 精兵 大喝
威风
雄师：兵力提供的生命值提高 
坚韧: 武力提供的防御力提高 
勇武：武力提供的攻击力提高30%
会心：一定几率造成伤害额外普通攻击伤害，比7级触发几率更高
反弓：受到弓兵的伤害减少30%
反骑：受到骑兵的伤害减少30%
反枪：受到枪兵的伤害减少30%
无暇：不受负面技能效果影响
集中: 受到负面技能效果持续时间减少
神算：法术伤害类技能效果提高8%
识破：降低己方所受法术技能伤害
魅力：对异性造成的普通攻击伤害提高30%
神速: 移动速度提高
持盾: 一定几率不受普通攻击伤害
背水：生命值每降低15%，增加基础武力值一定百分比的武力
舍身：战场中触发单挑的几率提高
谨慎：单挑失败不会被斩杀
神佑：降低受到的第一次技能伤害
好色：对女性武将造成的伤害提高30%




睿吴：己方全体吴国部队武力提高30%，智力提高35%，持续8秒
仁蜀：己方全体蜀国部队武力提高30%，并每秒恢复少量生命值，持续8秒
强魏：己方全体魏国部队武力提高40%，持续8秒


成长
0	天才	1	2	3	6	8	12
1	天才	2	3	6	8	12	16
2	天才	3	6	9	12	15	18
3	优秀	1	2	4	8	16	32
4	优秀	2	3	5	10	15	29
5	优秀	3	5	10	12	18	24
6	优秀	10	13	16	19	22	25
7	优秀	10	11	12	30	31	32
8	普通	6	12	18	27	36	45
9	普通	11	12	21	22	41	42
10	普通	12	18	24	36	48	60
11	普通	15	21	27	33	39	51
12	早熟	1	2	3	4	5	50
13	晚成	20	25	30	35	40	45
14	晚成	24	28	32	36	40	48
15	晚成	30	35	40	45	50	60






















]]--