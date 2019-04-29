
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
function limitX(x,minv,maxv)       --限制x的范围
  if x<minv then
    x=minv;
	elseif x>maxv then
    x=maxv;
	end
	return x
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

function ReFresh(n)
	n=n or 1;
	local frame_t=CC.FrameNum*n;
	local t1,t2;
	t1=JY.ReFreshTime;
	t2=lib.GetTime();
	if CC.FPS or CC.Debug==1 then
		if t2-t1<frame_t then
			lib.DrawStr(4,24,string.format("FPS=%d",30),C_WHITE,16,0,CC.FontName,CC.SrcCharSet,CC.OSCharSet);
		else
			lib.DrawStr(4,24,string.format("FPS=%d",1050/(t2-t1)),C_WHITE,16,0,CC.FontName,CC.SrcCharSet,CC.OSCharSet);
		end
	end
	ShowScreen();
	if t2-t1<frame_t then
		lib.Delay(frame_t+t1-t2);
	end
end
function DrawSkillTable(pid,x,y)
	local p=JY.Person[pid];
	local cx,cy
	local box_w=47;
	local box_h=27;
	local skill_id=0;
	for row=0,4 do
		for col=0,5 do
			local i=5*row+col+1;
			local cx=x+box_w*col;
			local cy=y+box_h*row;
			local pic=80;	--黄81 绿83 蓝85 红87
			local color=M_Gray;
			local str=JY.Str[8000+i];
			if col==5 then
				break;
			end
			if p["技能"..i]>0 then
				color=C_WHITE;
				pic=pic+1;
				if MOUSE.IN(cx+1,cy+1,cx+box_w,cy+box_h) then
					skill_id=p["技能"..i];
					pic=pic+1;
				end
			end
			lib.PicLoadCache(4,pic*2,cx,cy,1);
			DrawStringEnhance(cx+4,cy+4,str,color,20);
		end
	end
	return skill_id;
end
function ReSetAttrib(id,flag)
	local p=JY.Person[id];
	local wid=GetWarID(id);
	if between(JY.Status,GAME_START,GAME_SMAP_MANUAL) then
		flag=true;
	end
				if p["名称"]=="萝莉控" then
					p["武力"]=100;
					p["智谋"]=100;
					p["统率"]=100;
					p["政务"]=100;
					p["魅力"]=1;
					p["灵巧"]=1;
					p["福源"]=1;
					p["兵种"]=21;
				end
	--Get Weapon
	local weapon1=0;
	local weapon2=0;
	local weapon3=0;
	--[[
	weapon1=p["武器"];
	weapon2=p["防具"];
	weapon3=p["辅助"];]]--
	
	--计算武器加成后的属性
	local p_wuli=p["武力"];
	local p_tongshuai=p["统率"];
	local p_zhili=p["智谋"];
	local p_zhengwu=p["政务"];
	local p_meili=p["魅力"];--[[
	if weapon1>0 then
		p_wuli=p_wuli+JY.Item[weapon1]["武力"];
		p_zhili=p_zhili+JY.Item[weapon1]["智谋"];
		p_tongshuai=p_tongshuai+JY.Item[weapon1]["统率"];
		atk=atk+JY.Item[weapon1]["攻击"];
		def=def+JY.Item[weapon1]["防御"];
		mov=mov+JY.Item[weapon1]["移动"];
	end
	if weapon2>0 then
		p_wuli=p_wuli+JY.Item[weapon2]["武力"];
		p_zhili=p_zhili+JY.Item[weapon2]["智谋"];
		p_tongshuai=p_tongshuai+JY.Item[weapon2]["统率"];
		atk=atk+JY.Item[weapon2]["攻击"];
		def=def+JY.Item[weapon2]["防御"];
		mov=mov+JY.Item[weapon2]["移动"];
	end
	if weapon3>0 then
		p_wuli=p_wuli+JY.Item[weapon3]["武力"];
		p_zhili=p_zhili+JY.Item[weapon3]["智谋"];
		p_tongshuai=p_tongshuai+JY.Item[weapon3]["统率"];
		atk=atk+JY.Item[weapon3]["攻击"];
		def=def+JY.Item[weapon3]["防御"];
		mov=mov+JY.Item[weapon3]["移动"];
	end]]--
	p["武力2"]=p_wuli;
	p["智谋2"]=p_zhili;
	p["统率2"]=p_tongshuai;
	p["政务2"]=p_zhengwu;
	p["魅力2"]=p_meili;
end
function SelectArmy(num)
	local s={};
	local per={};
	local t_select={};
	local current_num=0;
	local total_num=0;
	local size=20;
	local size2=18;
	s[1]={	str="选择武将",
			txtdx=49,
			pic=30,
			x1=64,
			y1=58,
			enable=true;
			x2=64+98,
			y2=58+32}
	s[2]={	str="全部取消",
			txtdx=49,
			pic=30,
			x1=174,
			y1=58,
			enable=true;
			x2=174+98,
			y2=58+32}
	s[6]={	str="",
			txtdx=0,
			pic=140,
			enable=true;
			x1=CC.ScreenW/2-84+50,
			y1=CC.ScreenH-81+8,
			x2=CC.ScreenW/2-84+50+66,
			y2=CC.ScreenH-81+8+46}
	
	local function GetSelected()
		local dx,dy=24,100;
		local index=0;
		per={};
		for i,v in pairs(War.Person) do
			if not (v.enemy or v.friend) then
				index=index+1;
				per[index]={};
				per[index].pid=v.id;
				per[index].index=0;
				per[index].x1,per[index].y1=dx,dy;
				per[index].x2,per[index].y2=per[index].x1+90,per[index].y1+128;
				dx=dx+90;
				if dx>700 then
					dx=24;
					dy=dy+128;
				end
			end
		end
		total_num=index+num;	--总出战人数，必须出战人数+待选人数
		for i,v in pairs(t_select) do
			if true then
				index=index+1;
				per[index]={};
				per[index].pid=v;
				per[index].index=i;
				per[index].x1,per[index].y1=dx,dy;
				per[index].x2,per[index].y2=per[index].x1+90,per[index].y1+128;
				dx=dx+90;
				if dx>700 then
					dx=24;
					dy=dy+128;
				end
			end
		end
		current_num=index;		--已选出战人数(包含了必选)
		if #t_select>0 then
			s[2].enable=true;
		else
			s[2].enable=false;
		end
		if current_num>0 then
			s[6].enable=true;
		else
			s[6].enable=false;
		end
	end
	GetSelected();
	local current=0;
	local hold=false;
	local function redraw()
		DrawGame();
		--
		lib.SetClip(0,0,CC.ScreenW/2,CC.ScreenH);
		LoadPicEnhance(73,0,56);
		lib.PicLoadCache(4,72*2,48,90,1);
		lib.SetClip(CC.ScreenW/2,0,CC.ScreenW,CC.ScreenH);
		lib.PicLoadCache(4,73*2,CC.ScreenW-672,56,1);
		lib.PicLoadCache(4,72*2,CC.ScreenW-576-48,90,1);
		lib.SetClip(0,0,0,0);
		DrawStringEnhance(540,65,string.format("出战人数 %2d/%d",current_num,total_num),C_WHITE,size);
		--DrawNumPic(650,68,current_num,total_num);
		for i,v in pairs(per) do
			if v.pid>=0 then
				lib.PicLoadCache(2,(JY.Person[v.pid]["容貌"]+2000)*2,v.x1,v.y1,1);
			end
			if current==i+10 then
				DrawStringEnhance(v.x1+45-size*#JY.Person[v.pid]["名称"]/4+1,v.y2-size-4,JY.Person[v.pid]["名称"],C_WHITE,size);
			else
				DrawStringEnhance(v.x1+45-size*#JY.Person[v.pid]["名称"]/4+1,v.y2-size-4,JY.Person[v.pid]["名称"],C_WHITE,size);
			end
		end
		if current>10 then
			if hold then
				lib.PicLoadCache(4,9*2,per[current-10].x1-3,per[current-10].y1-3,1);
			else
				lib.PicLoadCache(4,8*2,per[current-10].x1-3,per[current-10].y1-3,1);
			end
		end
		lib.PicLoadCache(4,10*2,s[6].x1-50,s[6].y1-8,1);
		for i,v in pairs(s) do
			if v.enable then
				if current==i then
					if hold then
						lib.PicLoadCache(4,(v.pic+2)*2,v.x1,v.y1,1);
						DrawStringEnhance(v.x1+v.txtdx-size*#v.str/4+1,v.y1+7,v.str,C_BLACK,size);
					else
						lib.PicLoadCache(4,(v.pic+1)*2,v.x1,v.y1,1);
						DrawStringEnhance(v.x1+v.txtdx-size*#v.str/4,v.y1+6,v.str,C_BLACK,size);
					end
				else
					lib.PicLoadCache(4,v.pic*2,v.x1,v.y1,1);
					DrawStringEnhance(v.x1+v.txtdx-size*#v.str/4,v.y1+6,v.str,C_BLACK,size);
				end
			else
				lib.PicLoadCache(4,(v.pic+3)*2,v.x1,v.y1,1);
				DrawStringEnhance(v.x1+v.txtdx-size*#v.str/4,v.y1+6,v.str,C_WHITE,size);
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
		getkey();
		current=0;
		hold=false;
		for i,v in pairs(per) do
			if v.pid>=0 then
				if MOUSE.CLICK(v.x1,v.y1,v.x2,v.y2) then
					current=i+10;
					PlayWavE(0);
					PersonStatus(v.pid);
					break;
				elseif MOUSE.HOLD(v.x1,v.y1,v.x2,v.y2) then
					current=i+10;
					hold=true;
					break;
				elseif MOUSE.IN(v.x1,v.y1,v.x2,v.y2) then
					current=i+10;
					break;
				end
			end
		end
		for i,v in pairs(s) do
			if v.enable then
				if MOUSE.CLICK(v.x1,v.y1,v.x2,v.y2) then
					current=i;
					PlayWavE(99);
					if current==1 then
						t_select=ShowPersonList(GetMyList(),nil,nil,num,t_select);
						GetSelected();
					elseif current==2 then
						t_select={};
						GetSelected();
					elseif current==6 then
						return t_select;
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
	end
	return false;
end
