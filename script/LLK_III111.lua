function DrawArmy(wid)
	local wp=War.Person[wid]
	--方阵
	local zx={}
	zx[1]={{x=0,y=0}	}	--1
	zx[2]={{x=-0.4,y=0},{x=0.4,y=0}	}	--2
	zx[3]={{x=-0.5,y=-0.433},{x=0.5,y=-0.433},{x=0,y=0.43}	}	--3
	zx[4]={{x=-0.5,y=-0.5},{x=0.5,y=-0.5},{x=-0.5,y=0.5},{x=0.5,y=0.5}	}	--4
	zx[5]={{x=-0.6,y=-0.6},{x=0.6,y=-0.6},{x=0,y=0},{x=-0.6,y=0.6},{x=0.6,y=0.6}	}	--5
	zx[6]={{x=-0.45,y=-0.78},{x=0.45,y=-0.78},{x=-0.9,y=0},{x=0.9,y=0},{x=-0.45,y=0.78},{x=0.45,y=0.78}	}	--6
	zx[7]={{x=-0.5,y=-0.866},{x=0.5,y=-0.866},{x=-1,y=0},{x=0,y=0},{x=1,y=0},{x=-0.5,y=0.866},{x=0.5,y=0.866}	}	--7
	zx[8]={		{x=-0.6,y=-0.9},{x=0.6,y=-0.9},
				{x=-1.2,y=-0.2},{x=0,y=-0.2},{x=1.2,y=-0.2},
				{x=-0.6,y=0.5},{x=0.6,y=0.5},{x=0,y=1.2}	}	--8
	zx[9]={		{x=0,y=-1.2},{x=-0.6,y=-0.6},{x=0.6,y=-0.6},
				{x=-1.2,y=0},{x=0,y=0},{x=1.2,y=0},
				{x=-0.6,y=0.6},{x=0.6,y=0.6},{x=0,y=1.2}	}	--9
	zx[10]={	{x=0,y=-1.2},
				{x=-0.8,y=-0.4},{x=0,y=-0.4},{x=0.8,y=-0.4},
				{x=-1.2,y=0.4},{x=-0.4,y=0.4},{x=0.4,y=0.4},{x=1.2,y=0.4},
				{x=-0.4,y=1.2},{x=0.4,y=1.2},	}	--10
	zx[11]={	{x=0,y=-1.2},
				{x=-1.2,y=-0.4},{x=-0.4,y=-0.4},{x=0.4,y=-0.4},{x=1.2,y=-0.4},
				{x=-1.2,y=0.4},{x=-0.4,y=0.4},{x=0.4,y=0.4},{x=1.2,y=0.4},
				{x=-0.4,y=1.2},{x=0.4,y=1.2},	}	--11
	zx[12]={	{x=-0.4,y=-1.2},{x=0.4,y=-1.2},
				{x=-1.2,y=-0.4},{x=-0.4,y=-0.4},{x=0.4,y=-0.4},{x=1.2,y=-0.4},
				{x=-1.2,y=0.4},{x=-0.4,y=0.4},{x=0.4,y=0.4},{x=1.2,y=0.4},
				{x=-0.4,y=1.2},{x=0.4,y=1.2},	}	--12
	zx[13]={	{x=-0.4,y=-1.2},{x=0.4,y=-1.2},
				{x=-1.2,y=-0.4},{x=-0.4,y=-0.4},{x=0.4,y=-0.4},{x=1.2,y=-0.4},
				{x=-1.2,y=0.4},{x=-0.4,y=0.4},{x=0.4,y=0.4},{x=1.2,y=0.4},
				{x=-0.8,y=1.2},{x=0,y=1.2},{x=0.8,y=1.2},	}	--13
	zx[14]={	{x=-0.8,y=-1.2},{x=0,y=-1.2},{x=0.8,y=-1.2},
				{x=-1.2,y=-0.4},{x=-0.4,y=-0.4},{x=0.4,y=-0.4},{x=1.2,y=-0.4},
				{x=-1.2,y=0.4},{x=-0.4,y=0.4},{x=0.4,y=0.4},{x=1.2,y=0.4},
				{x=-0.8,y=1.2},{x=0,y=1.2},{x=0.8,y=1.2},	}	--14
	zx[15]={	{x=-1.2,y=-1.2},{x=-0.4,y=-1.2},{x=0.4,y=-1.2},{x=1.2,y=-1.2},
				{x=-1.2,y=-0.4},{x=-0.4,y=-0.4},{x=0.4,y=-0.4},{x=1.2,y=-0.4},
				{x=-1.2,y=0.4},{x=-0.4,y=0.4},{x=0.4,y=0.4},{x=1.2,y=0.4},
				{x=-0.8,y=1.2},{x=0,y=1.2},{x=0.8,y=1.2},	}	--15
	zx[16]={	{x=-1.2,y=-1.2},{x=-0.4,y=-1.2},{x=0.4,y=-1.2},{x=1.2,y=-1.2},
				{x=-1.2,y=-0.4},{x=-0.4,y=-0.4},{x=0.4,y=-0.4},{x=1.2,y=-0.4},
				{x=-1.2,y=0.4},{x=-0.4,y=0.4},{x=0.4,y=0.4},{x=1.2,y=0.4},
				{x=-1.2,y=1.2},{x=-0.4,y=1.2},{x=0.4,y=1.2},{x=1.2,y=1.2},	}	--16
	zx[17]={	{x=-1.2,y=-1.2},{x=-0.4,y=-1.2},{x=0.4,y=-1.2},{x=1.2,y=-1.2},
				{x=-1.2,y=-0.4},{x=-0.4,y=-0.4},{x=0.4,y=-0.4},{x=1.2,y=-0.4},
				{x=-1.2,y=0.4},{x=-0.4,y=0.4},{x=0.4,y=0.4},{x=1.2,y=0.4},
				{x=-1.2,y=1.2},{x=-0.4,y=1.2},{x=0.4,y=1.2},{x=1.2,y=1.2},	}	--17
	local ox,oy=wp["坐标X"],wp["坐标Y"];
	if wp["动作"]==1 then	--移动
		ox,oy=ox+(wp["移动X"]-ox)*wp["动作进度"]/wp["动作进度最大值"],oy+(wp["移动Y"]-oy)*wp["动作进度"]/wp["动作进度最大值"];
	end
	wp["屏幕X"],wp["屏幕Y"]=GetScreenXY(ox,oy);
	local n=math.floor(wp["兵力"]/1000)
	if n>16 then
		n=16
	elseif n<1 then
		n=1;
	end
	--n=16
	if wp.bz["巨型"]>0 then
		n=1;
	end
	--n=1
	local sx,sy;
	local width=wp.bz["贴图尺寸"];
	if between(wp["屏幕X"],-64,CC.ScreenW+64) then
		for i,v in ipairs(zx[n]) do
			sx,sy=GetScreenXY(ox+v.x,oy+v.y);
			sx=math.floor(sx)
			sy=math.floor(sy)
			sx=sx-width/2
			sy=sy-width/2-14
			lib.SetClip(sx,sy,sx+width,sy+width);
			local pic=(wp["贴图"]+10*wp["方向"])*2;
			if wp["动作"]==0 then
				sx=sx-width*(War.Frame)
				--sx=sx-width*((War.Frame+i)%8)
			elseif wp["动作"]==1 then
				sx=sx-width*(War.Frame)
				--sx=sx-width*((War.Frame+i)%8)
				pic=pic+2;
			elseif wp["动作"]==2 then
				--sx=sx-width*(War.Frame)
				sx=sx-width*math.min(7,(math.floor(8*wp["动作进度"]/wp["动作进度最大值"])));
				--sx=sx-width*((War.Frame+i)%8)
				pic=pic+4;
			elseif wp["动作"]==3 then
				--sx=sx-width*((math.floor(wp["动作进度"]/4)+i)%8);
				--sx=sx-width*((War.Frame+i)%8)
				sx=sx-width*math.min(7,(math.floor(12*wp["动作进度"]/wp["动作进度最大值"])));
				pic=pic+8;
			end
			lib.PicLoadCache(1,pic,sx,sy,1);
			lib.SetClip(0,0,0,0);
		end
		--旗帜
		sx,sy=GetScreenXY(ox,oy);
		WarDrawFlag(sx-1,sy-64,wp.force_id,wp.flag_id,wp["方向"],(War.Frame%4))
	end
	--hurt_str
	for i=#wp.hurt_str_dy,1,-1 do
		if between(wp["屏幕X"],-64,CC.ScreenW+64) then
			DrawStringEnhance(sx,sy-16-wp.hurt_str_dy[i],wp.hurt_str[i],C_WHITE,20,0.5,nil,nil,640-8*wp.hurt_str_dy[i]);
		end
		if wp.hurt_str_dy[i]>64 then
			table.remove(wp.hurt_str,i);
			table.remove(wp.hurt_str_dy,i);
		else
			wp.hurt_str_dy[i]=wp.hurt_str_dy[i]+1;
		end
	end
	for i,v in pairs(zx[n]) do
		--弓箭轨迹
		if wp["动作"]==3 and wp["动作进度"]/wp["动作进度最大值"]>1/3 then
			sx,sy=GetScreenXY(ox+v.x*1,oy+v.y*1);
			local dx,dy=GetScreenXY(wp["目标X"]+v.x*1.5,wp["目标Y"]+v.y*1.5);
			local f=math.min(1,1.5*wp["动作进度"]/wp["动作进度最大值"]-0.5+i/n/4);
			local h=80;
			local ax=sx+(dx-sx)*f;
			local ay=sy+(dy-sy)*f-h+h*4*(f-0.5)^2-24;
			if between(ax,-32,CC.ScreenW+32) then
				local apic=WarGetArrowPic((dx-sx),(dy-sy)+h*8*(f-0.5));
				lib.PicLoadCache(0,apic*2,ax,ay,1);
			end
		end
	end
end
function War_DrawStateBar(wid,x,y)
	local wp=War.Person[wid];
	lib.PicLoadCache(4,(260+2*wp["敌我"])*2,x,y,1);
	x=x+1;
	y=y+1;
	lib.PicLoadCache(2,(wp.p["容貌"]+6000)*2,x,y,1,255,-1,32);
	x=x+34;
	y=y+5;
	lib.PicLoadCache(4,(276+4*wp.bz["兵系"]+2*wp["敌我"])*2,x,y,1);
	x=x+45;
	DrawStringEnhance(x,y,""..wp["兵力"],C_WHITE,20,0.5);
end
function War_DrawMultiStateBar()
	local xoff=War.x_off%28
	local yoff=War.y_off%34
	local tmap={}
	local maxx,maxy=(math.floor(2016/28)),(math.floor(768/34))
	for i=-1,maxx+1 do
		tmap[i]={};
		for j=-1,maxy+1 do
			tmap[i][j]=0;
		end
	end
	local t_show={};
	for i,wp in ipairs(War.Person) do
		if wp["存活"]>0 then
			local ox,oy=math.floor((wp["屏幕X"]+War.x_off)/28),math.floor((wp["屏幕Y"]+War.y_off)/34);
			if between(ox,0,maxx) and between(oy,0,maxy) then
				tmap[ox-1][oy-1]=1;
				tmap[ox][oy-1]=1;
				tmap[ox+1][oy-1]=1;
				tmap[ox-1][oy]=1;
				tmap[ox][oy]=1;
				tmap[ox+1][oy]=1;
				--tmap[ox-1][oy+1]=1;
				--tmap[ox][oy+1]=1;
				--tmap[ox+1][oy+1]=1;
			end
		end
	end
	local x_order={0,1,-1,2,-2,3,-3,4,-4,5,-5,6,-6,7,-7,8,-8,9,-9,10,-10,11,-11,12,-12,13,-13,14,-14,15,-15,16,-16};
	local y_order={1,-1,2,-2,3,-3,4,-4,5,-5,6,-6,7,-7};
	for i,wp in ipairs(War.Person) do
		if wp["存活"]>0 and wp["选中"]>0 then
			local ox,oy=math.floor((wp["屏幕X"]+War.x_off)/28),math.floor((wp["屏幕Y"]+War.y_off)/34);
			local flag=false;
			for idx_y,dy in ipairs(x_order) do
				for idx_x,dx in ipairs(y_order) do
					if idx_x>idx_y*2+1 then break end;
					local tx,ty=ox+dx,oy-dy;
					if between(tx,0,maxx-3) and between(ty,0,maxy-1) and tmap[tx][ty]==0 and tmap[tx+1][ty]==0 and tmap[tx+2][ty]==0 and tmap[tx+3][ty]==0 then
						tmap[tx][ty]=1
						tmap[tx+1][ty]=1
						tmap[tx+2][ty]=1
						tmap[tx+3][ty]=1
						local x2,y2=tx*28-War.x_off,ty*34-War.y_off;
						local lx
						if dx<-1 then
							lx=x2+96;
						else
							lx=x2+16;
						end
						local ly=y2+17
						table.insert(t_show,{x1=wp["屏幕X"],y1=wp["屏幕Y"]-16,x2=x2,y2=y2,x3=lx,y3=ly,wid=i,col=wp["敌我"]});
						flag=true;
					end
					if flag then break end;
				end
				if flag then break end;
			end
		end
	end
	for i,v in ipairs(t_show) do
		if v.col==0 then
			lib.DrawLine(v.x1+1,v.y1,v.x3+1,v.y3,1858974);
			lib.DrawLine(v.x1,v.y1+1,v.x3,v.y3+1,1858974);
			lib.DrawLine(v.x1,v.y1,v.x3,v.y3,3442651);
		else
			lib.DrawLine(v.x1+1,v.y1,v.x3+1,v.y3,5181968);
			lib.DrawLine(v.x1,v.y1+1,v.x3,v.y3+1,5181968);
			lib.DrawLine(v.x1,v.y1,v.x3,v.y3,8396315);
		end
	end
	local wid=0;
	local sx,sy;
	for i,v in ipairs(t_show) do
		if between(v.x2,-128,CC.ScreenW) then
			War_DrawStateBar(v.wid,v.x2,v.y2);
			if between(MOUSE.x,v.x2,v.x2+110) and between(MOUSE.y,v.y2+4,v.y2+30) then
				wid=v.wid;
				sx,sy=v.x2,v.y2;
				if sx+208>CC.ScreenW then
					sx=CC.ScreenW-208;
				end
				if sy+36>CC.ScreenH-110 then
					sy=sy-110;
				else
					sy=sy+36;
				end
			end
		end
	end
	if wid>0 then
		War_DrawStatus(wid,sx,sy);
	end
end
function War_DrawMultiStateBar()
	local showall=false;
	local sx,sy;
	local s_wid=0;
	
	for wid,wp in ipairs(War.Person) do
		if wp["存活"]>0 then
			if showall or wp["选中"]>0 then
				sx=wp["屏幕X"]-56;
				sy=wp["屏幕Y"]-96;
				if between(sx,-128,CC.ScreenW) then
					War_DrawStateBar(wid,sx,sy);
					
					if between(MOUSE.x,sx,sx+110) and between(MOUSE.y,sy+4,sy+30) then
						s_wid=wid;
					end
				end
			end
		end
	end
	if s_wid>0 then
		sx=MOUSE.x
		sy=MOUSE.y;
		if sx+208>CC.ScreenW then
			sx=CC.ScreenW-208;
		end
		if sy+36>CC.ScreenH-110 then
			sy=sy-110;
		end
		War_DrawStatus(s_wid,sx,sy);
	end
end
function War_DrawTalk()
	local t={};
	for wid,wp in ipairs(War.Person) do
		if wp["存活"]>0 then
			if #wp.talkstr>0 and between(wp["屏幕X"],-384,CC.ScreenW) then
				table.insert(t,wid);
			end
		end
	end
	table.sort(t,function(a,b) if War.Person[a]["移动Y"]<War.Person[b]["移动Y"] or (War.Person[a]["移动Y"]==War.Person[b]["移动Y"] and War.Person[a]["移动X"]<War.Person[b]["移动X"]) then return true end end)
	for i=1,#t do
		War_DrawTalk_sub(t[i]);
	end
end
function War_DrawTalk_sub(wid)
	local wp=War.Person[wid];
	local sx,sy=wp["屏幕X"],wp["屏幕Y"];
	if true then
		local pic;
		local dt,width=DrawStringEnhanceInit("[n][W][b]"..wp.talkstr,M_Wheat,16,0,0.5,1920);
		if width<96 then
			width=96+64;
		elseif width<128 then
			width=128+64;
		elseif width<160 then
			width=160+64;
		elseif width<192 then
			width=192+64;
		elseif width<224 then
			width=224+64;
		elseif width<256 then
			width=256+64;
		elseif width<288 then
			width=288+64;
		else
			width=384;
		end
		local x1,y1;
		local x2,y2;
		local x3,y3;
		if wp.talkd==0 then	--左下
			pic=690;
			x1,y1=sx+25-width,sy-16;
			y2=y1+28+16;
			y3=y1+28+16;
		elseif wp.talkd==1 then	--左上
			pic=691;
			x1,y1=sx+25-width,sy-96;
			y2=y1+28;
			y3=y1+28;
		elseif wp.talkd==2 then	--右上
			pic=692;
			x1,y1=sx-25,sy-96;
			y2=y1+28;
			y3=y1+28;
		else			--右下
			pic=693;
			x1,y1=sx-25,sy-16;
			y2=y1+28+16;
			y3=y1+28+16;
		end
		x2=x1+32;
		x3=x1+64;
		LoadPicEnhance(pic,x1,y1,width);
		lib.PicLoadCache(2,(wp.p["容貌"]+6000)*2,x2,y2,0,nil,nil,48);
		DrawStringEnhanceSub(x3,y3,dt,16);
		if MOUSE.HOLD(x1,y2-28,x1+width,y2+28) then
			wp.talkstr="";
		end
	end
end
function War_DrawStatus(wid,sx,sy)
	local wp=War.Person[wid];
	--208/108
	Glass(sx,sy,sx+208,sy+108,C_BLACK,192);
	sx=sx+42;
	sy=sy+8;
	DrawStringEnhance(sx,sy,wp.p["名称"],C_Name,16,0.5);
	lib.PicLoadCache(2,(wp.p["容貌"]+6000)*2,sx,sy+60,0,nil,nil,72);
	sx=sx+46;
	DrawStringEnhance(sx,sy,"兵种: "..wp.bz["名称"],C_WHITE,16);
	sy=sy+20;
	DrawStringEnhance(sx,sy,"兵力: "..wp["兵力"],C_WHITE,16);
	sy=sy+20;
	DrawStringEnhance(sx,sy,"肉搏: "..wp["攻击力"],C_WHITE,16);
	sy=sy+20;
	DrawStringEnhance(sx,sy,"远程: "..wp["远程攻击力"],C_WHITE,16);                       
	sy=sy+20;
	DrawStringEnhance(sx,sy,"守备: "..wp["防御力"],C_WHITE,16);
end
function WarGetArrowPic(dx,dy)
	if dx==0 then
		dx=1;
	end
	local k=dy/math.abs(dx);
	local pic=300;
	if k>5 then
		pic=pic+9;
	elseif k>1.5 then
		pic=pic+8;
	elseif k>0.67 then
		pic=pic+7;
	elseif k>0.2 then
		pic=pic+6;
	elseif k>-0.2 then
		pic=pic+5;
	elseif k>-0.67 then
		pic=pic+4;
	elseif k>-1.5 then
		pic=pic+3;
	elseif k>-5 then
		pic=pic+2;
	else
		pic=pic+1;
	end
	if dx<0 then
		pic=pic+10;
	end
	return pic;
end
function DrawWarMap()
	lib.FillColor(0,0,0,0);
	if War.y_off<120 then
		lib.PicLoadCache(0,120*2,-War.x_off,-War.y_off,1,255);
	end
	if War.x_off<1008 then
		lib.PicLoadCache(0,War.wid1*2,-War.x_off,120-War.y_off,1,255);
	end
	if 1008-War.x_off<CC.ScreenW then
		lib.PicLoadCache(0,(War.wid2)*2,1008-War.x_off,120-War.y_off,1,255);
	end
	--lib.PicLoadCache(0,(War.wid1+200)*2,300,0,1,255);
	--lib.PicLoadCache(0,(War.wid2+200)*2,300+252,0,1,255);
	--城岩
	for i,v in pairs(War.GroupXY[16]) do
		local sx,sy=GetScreenXY(v.x,v.y)
		sx=sx-20
		sy=sy-24
		if between(sx,-128,CC.ScreenW) then
			lib.PicLoadCache(0,151*2,sx,sy,1,255);
		end
	end
	--MovePath
	for i,wp in ipairs(War.Person) do
		if wp["存活"]>0 and wp["选中"]>0 then
			War_DrawPath(i);
		end
	end
	--当前位置
	local dx,dy=GetScreenXY(War.mx,War.my)
	lib.PicLoadCache(4,270*2,dx,dy,0,255);
	--城
	if War.CityPosition==0 then
		if War.x_off<380 then
			lib.PicLoadCache(0,163*2,0-War.x_off,120-2-War.y_off,1,255);
		end
	else
		if 2016-380-War.x_off<CC.ScreenW then
			lib.PicLoadCache(0,173*2,2016-380-War.x_off,120-2-War.y_off,1,255);
		end
	end
	for j=0,127 do
		for i=0,127 do
			local wid=War.MAP[i][j].wid1;
			if wid>0 then
				DrawArmy(wid);
				--local sx,sy=GetScreenXY(i,j)
				--DrawStringEnhance(sx,sy,"[B]"..wid,C_WHITE,24,0.5,0.5);
			end
		end
	end
	War_DrawTalk();
	War_DrawMultiStateBar();
	
	
	if between(War.mx,0,127) and between(War.my,0,127) then
		DrawStringEnhance(8,32,"[B]Wid: "..War.MAP[War.mx][War.my].wid2,C_WHITE,24);
		if War.tBrush[War.MAP[War.mx][War.my].dx]~=nil then
			DrawStringEnhance(8,56,"[B]当前地形: "..War.tBrush[War.MAP[War.mx][War.my].dx],C_WHITE,24);
		else
			DrawStringEnhance(8,56,"[B]当前地形: "..War.MAP[War.mx][War.my].dx,C_WHITE,24);
		end
		DrawStringEnhance(8,80,"[B]XY: "..War.mx.." , "..War.my,C_WHITE,24);
	end
	for i=1,math.min(8,#War.AI_Pool) do
		local wid=War.AI_Pool[i];
		local pid=War.Person[wid]["人物ID"]
		DrawStringEnhance(CC.ScreenW,80+i*24,"[B]"..JY.Person[pid]["名称"],C_WHITE,24,1);
	end
	
end
function War_DrawPath(wid)
	local mp=War.Person[wid].movepath;
	local pic,sx,sy;
	for i=1,#mp do
		pic=1000+20*mp[i].d+6;
		sx,sy=GetScreenXY(mp[i].x,mp[i].y);
		if between(sx,-32,CC.ScreenW) then
			lib.PicLoadCache(0,pic*2,sx,sy);
		end
	end
end
function creatWarMenu()
	return {on=false,hold=false,pause=false,timer=1,blmax=0}
end
function eventWarMenu(wm)
	wm.on=false;
	wm.hold=false;
	if MOUSE.CLICK(28,19,103,94) then
		wm.pause=not wm.pause;
	elseif MOUSE.HOLD(28,19,103,94) then
		wm.hold=true;
	elseif MOUSE.IN(28,19,103,94) then
		wm.on=true;
	end
	if not wm.pause then
		War.FrameT=War.FrameT+2;
		if War.FrameT>=64 then
			War.FrameT=0;
			wm.timer=wm.timer+1;
		end
		War.Frame=math.floor(War.FrameT/8);
	end
end
function redrawWarMenu(wm)
	local pic=341;
	if wm.pause then
		if wm.hold then
			pic=346;
		elseif wm.on then
			pic=345;
		else
			pic=344;
		end
		lib.Background(0,0,CC.ScreenW,CC.ScreenH,128);
		lib.PicLoadCache(4,347*2,CC.ScreenW/2,CC.ScreenH/2);
	else
		if wm.hold then
			pic=343;
		elseif wm.on then
			pic=342;
		else
			pic=341;
		end
	end
	lib.PicLoadCache(4,340*2,0,0,1);
	lib.PicLoadCache(4,pic*2,66,57);
	DrawStringEnhance(66,54,"[B]"..wm.timer,M_LightBlue,32,0.5,0.5);
	DrawStringEnhance(186,28,War.name,C_WHITE,28,0.5,0.5);
	DrawStringEnhance(234,55,"我军",C_WHITE,16,1);
	DrawStringEnhance(277,55,"敌军",C_WHITE,16,0);
	local bl0,bl1=0,0;
	for wid,wp in ipairs(War.Person) do
		if wp["存活"]>0 then
			if wp["敌我"]==0 then
				bl0=bl0+wp["兵力"];
			else
				bl1=bl1+wp["兵力"];
			end
		end
	end
	if wm.blmax==0 then
		wm.blmax=math.max(bl0,bl1);
		if wm.blmax<100000 then
			wm.blmax=wm.blmax+(100000-wm.blmax)/5;
		end
	end
	local cp=127+math.floor(256*bl0/(bl0+bl1));
	lib.Background(254-128*bl0/wm.blmax,74,254,74+16,128,M_RoyalBlue);
	DrawStringEnhance(250,72,"[B]"..bl0,M_LightBlue,18,1);
	lib.Background(256,74,256+128*bl1/wm.blmax,74+16,128,C_RED);
	DrawStringEnhance(260,72,"[B]"..bl1,M_Pink,18,0);
end
function War_PlayWav()
	local Wav_moving=0;
	local Wav_fight=0;
	local Wav_atk1=0;
	local Wav_atk2=0;
	for i,wp in ipairs(War.Person) do
		if wp["存活"]>0 then
			if between(wp["屏幕X"],0,CC.ScreenW) and between(wp["屏幕Y"],0,CC.ScreenH) then
				if War.FrameT==0 and wp["动作"]==1 then
					Wav_moving=Wav_moving+1;
				end
				if wp["动作"]==2 then--or wp["动作"]==3 then
					Wav_fight=Wav_fight+1;
				end
				--if wp["动作进度"]==wp["动作进度最大值"] then
					if wp["动作"]==2 then
						Wav_atk1=Wav_atk1+1;
					elseif wp["动作"]==3 then
						Wav_atk2=Wav_atk2+1;
					end
				--end
			end
		end
	end
	if War.WavTimer>0 then
		War.WavTimer=War.WavTimer-1;
	else
		--人声 000 -006    003 004 音量大
		if Wav_fight>16 then
			lib.PlayWAV(".\\sound\\se_b004.wav");
			War.WavTimer=math.floor(4840/CC.FrameNum)-0;
		elseif Wav_fight>12 then
			lib.PlayWAV(".\\sound\\se_b003.wav");
			War.WavTimer=math.floor(7527/CC.FrameNum)-0;
		elseif Wav_fight>8 then
			lib.PlayWAV(".\\sound\\se_b002.wav");
			War.WavTimer=math.floor(7261/CC.FrameNum)-0;
		elseif Wav_fight>4 then
			lib.PlayWAV(".\\sound\\se_b001.wav");
			War.WavTimer=math.floor(5495/CC.FrameNum)-0;
		elseif Wav_fight>2 then
			lib.PlayWAV(".\\sound\\se_b000.wav");
			War.WavTimer=math.floor(6410/CC.FrameNum)-0;
		else
			War.WavTimer=20;
		end
	end
	if Wav_moving>0 and Wav_fight<4 then
		lib.PlayWAV(".\\sound\\se_v000a.wav");
	end
	if War.FrameT==32 then
		if Wav_atk1>0 then
			lib.PlayWAV(string.format(".\\sound\\se_a%03d.wav",math.random(0,2)));
		end
	elseif (War.FrameT%16==8 and Wav_atk2>4) or (War.FrameT%24==8 and Wav_atk2>2) or (War.FrameT%32==8 and Wav_atk2>1) or (War.FrameT==8 and Wav_atk2>0) then
		if Wav_atk2>0 then
			lib.PlayWAV(string.format(".\\sound\\se_a%03d.wav",math.random(8,10)));
		end
	end
end
function War_AutoAction()
	--根据AI，人物自行行动
	for wid,wp in pairs(War.Person) do
		if wp["存活"]>0 then
			if wp.bingfa_time>0 then
				wp.bingfa_time=wp.bingfa_time-1;
				if wp.bingfa_time<=0 then
					if wp.bingfa_id>0 then
						wp.bingfa_id=0;
						wp.talkstr="";
						wp.bingfa_time=1024;	--冷却时间
					else
						wp.bingfa_time=0;
					end
				end
			end
			if wp["动作进度"]==wp["动作进度最大值"] then
				wp["动作进度"]=0;
				local eid=wp["目标ID"];
				if wp["动作"]==1 then	--移动
					--坐标修改
					wp["坐标X"],wp["坐标Y"]=wp["移动X"],wp["移动Y"];
				elseif wp["动作"]==2 or wp["动作"]==3 then
					if eid>0 and AI_CanAtk(wid,eid,wp["坐标X"],wp["坐标Y"])==wp["动作"]-1 then
						local hurt=War_CalHurt(wid,eid,wp["动作"]-2);
						War.Person[eid]["兵力"]=War.Person[eid]["兵力"]-hurt;
						if wp.bingfa_id>0 then
							table.insert(War.Person[eid].hurt_str,1,"[Red]-"..hurt);
						else
							table.insert(War.Person[eid].hurt_str,1,"[B]-"..hurt);
						end
						if #War.Person[eid].hurt_str_dy==0 or War.Person[eid].hurt_str_dy[1]>0 then
							table.insert(War.Person[eid].hurt_str_dy,1,0);
						else
							table.insert(War.Person[eid].hurt_str_dy,1,War.Person[eid].hurt_str_dy[1]-2);
						end
						War_SetAttrib(eid);
						if War.Person[eid]["兵力"]<=0 then
							War.Person[eid]["存活"]=0;
							War.MAP[War.Person[eid]["移动X"]][War.Person[eid]["移动Y"]].wid1=0;
							eid=0;
						end
					end
				end
				local atk_r=0;
				eid=AI_CanAtkAll(wid,wp["坐标X"],wp["坐标Y"])
				if eid>0 then
					wp["目标ID"]=eid;
					atk_r=AI_CanAtk(wid,eid,wp["坐标X"],wp["坐标Y"]);
				end
				if atk_r>0 and wp.bingfa_time==0 then
					local bfid,bflv=1,-999;
					if wp.bz["兵系"]==1 and atk_r==1 then
						bfid,bflv=1,wp.p["步兵适性"];
					elseif wp.bz["兵系"]==2 and atk_r==2 then
						bfid,bflv=7,wp.p["弓兵适性"];
					elseif wp.bz["兵系"]==3 and atk_r==1 then
						bfid,bflv=4,wp.p["骑兵适性"];
					elseif wp.bz["兵系"]==3 and atk_r==2 then
						bfid,bflv=10,math.floor((wp.p["弓兵适性"]+wp.p["骑兵适性"]+1)/2);
					end
					local rnd=math.random(0,150);
					if bflv>1 and rnd<=bflv+wp.p["品级"]-2 then
						wp.bingfa_id=bfid+rnd%3;
						wp.bingfa_time=128+wp.p["智谋"];
						local str;
						if bfid==1 then
							str=JY.Str[math.random(6001,6009)];
						elseif bfid==4 then
							str=JY.Str[math.random(6021,6029)];
						elseif bfid==7 then
							str=JY.Str[math.random(6041,6054)];
						elseif bfid==10 then
							str=JY.Str[math.random(6061,6066)];
						end
						str=string.gsub(str,"Ga","[Yellow]"..JY.Str[8400+wp.bingfa_id].."[W]");
						str=string.gsub(str,"pids","[Orange]"..wp.p["名称"].."队[W]");
						str=string.gsub(str,"eids","[Orange]"..War.Person[eid].p["名称"].."队[W]");
						wp.talkstr=str;
					end
				end
				if atk_r==1 then	--近程攻击
					wp["动作"]=2;
					wp["动作进度最大值"]=32;
					if wp.bingfa_id>0 then
						wp["动作进度最大值"]=16;
					end
					wp["目标X"],wp["目标Y"]=War.Person[eid]["坐标X"],War.Person[eid]["坐标Y"];
					wp["方向"]=GetDirection(wp["目标X"]-wp["坐标X"],wp["目标Y"]-wp["坐标Y"],wp["方向"]);
				elseif atk_r==2 then	--远程攻击
					wp["动作"]=3;
					wp["动作进度最大值"]=32*1.5;
					if wp.bingfa_id>0 then
						wp["动作进度最大值"]=16*1.5;
					end
					wp["目标X"],wp["目标Y"]=War.Person[eid]["坐标X"],War.Person[eid]["坐标Y"];
					wp["方向"]=GetDirection(wp["目标X"]-wp["坐标X"],wp["目标Y"]-wp["坐标Y"],wp["方向"]);
				else	--移动
					if #wp.movepath>0 then
						if WarCanPass(wid,wp.movepath[1].x,wp.movepath[1].y) then	--下一步移动目标可到达
							wp["动作"]=1;
							War_MoveToNext(wid);
						else	--不可到达，立即AI
							wp["动作"]=0;
						end
					else
						wp["动作"]=0;
					end
				end
				wp.talkd=math.floor(wp["方向"]/2);
			else
				wp["动作进度"]=wp["动作进度"]+1;
			end
		end
	end
end
function War_MoveToNext(wid)
	local wp=War.Person[wid];
	wp["移动X"],wp["移动Y"]=wp.movepath[1].x,wp.movepath[1].y;
	wp["方向"]=wp.movepath[1].d;
	table.remove(wp.movepath,1);
	wp["动作"]=1;
	local spd=GetMoveCost(wid,wp["移动X"],wp["移动Y"]);
	if spd==0 then
		spd=100;
	end
	if wp["方向"]%2==1 then
		spd=spd*1.414;
	end
	spd=math.floor(spd);
	wp["动作进度最大值"]=spd;
	War.MAP[wp["坐标X"]][wp["坐标Y"]].wid1=0;
	War.MAP[wp["移动X"]][wp["移动Y"]].wid1=wid;
end
function AI_CanAtk(wid,eid,x,y)
	local m;
	local v=(x-War.Person[eid]["坐标X"])^2 + (y-War.Person[eid]["坐标Y"])^2;
	if v<49 then
		m=(War.Person[wid]["体积"]+War.Person[eid]["体积"]+1)^2;
		if v<m then	return 1 end
	else
		m=(War.Person[wid]["体积"]+War.Person[eid]["体积"]+War.Person[wid].bz["射程"])^2;
		if v<m then	return 2 end
	end
	return 0;
end
function AI_CanAtkAll(wid,x,y)
	for i,wp in pairs(War.Person) do
		if wp["存活"]>0 and wp["敌我"]~=War.Person[wid]["敌我"] then
			if AI_CanAtk(wid,i,x,y)>0 then
				return i;
			end
		end
	end
	return 0;
end
function AI_FindNearest(wid)
	local t0=lib.GetTime();
	--寻找最近的可以攻击的位置
	local wp=War.Person[wid];
	local x,y=wp["坐标X"],wp["坐标Y"];
	wp["目标ID"]=0;
	wp["目标X"],wp["目标Y"]=0,0;
	local depth=32;
	local t_eid={};	--敌人列表，记录eid以及价值
	--首先遍历所有敌人，索引即eid
	local eid,ex,ey=0,0,0;
	local min_d=256;	--寻找最近的敌人
	for i,v in ipairs(War.Person) do
		if v["存活"]>0 and v["敌我"]~=wp["敌我"] then
			local value=1000;	--价值，越低越优先 / 1000初始值是先设为无法攻击，可攻击则减去
			value=value+v["兵力"]/100;
			if wp.bz["兵系"]~=2 and v.bz["兵系"]==2 then	--非弓兵对弓兵
				value=value-50;
			end
			local distance=((v["坐标X"]-x)^2+(v["坐标Y"]-y)^2)^0.5;
			if distance<min_d then
				min_d=distance;
				eid=i;
				ex,ey=v["坐标X"],v["坐标Y"];
			end
			local near=true;
			if distance>wp["体积"]+v["体积"]+wp.bz["射程"]+depth then
				near=false;
			end
			t_eid[i]={value=value,near=near};
		end
	end
	if eid==0 then
		return
	--[[elseif math.abs(ex-x)+math.abs(ey-y)>depth then
		wp["目标ID"]=0;
		wp["目标X"],wp["目标Y"]=ex,ey;
		return;]]--
	end
	local mv=math.huge;
	local mx,my;
	
	local FNMap={};
	for i=0,127 do
		FNMap[i]={}
		for j=0,127 do
			FNMap[i][j]=0;
		end
	end
	local Open={};
	table.insert(Open,{x=x,y=y})
	while #Open>0 do
		local iter=Open[1];
		--先考虑能否攻击到敌人
		for eid,ep in pairs(t_eid) do
			if ep.near then
				local r=AI_CanAtk(wid,eid,iter.x,iter.y);
				if r>0 then
					local v=ep.value;
					v=v-200;	--可攻击
					local distance=(math.abs(iter.x-x)+math.abs(iter.y-y))*10;	--距离影响
					if distance==0 then
						v=v-300;
					else
						v=v+distance;
					end
					if wp.bz["兵系"]==2 and r==1 then	--弓兵近程, 优先级降低
						v=v+600;
					end
					if v<mv then
						mv=v;
						wp["目标ID"]=eid;
						wp["目标X"],wp["目标Y"]=iter.x,iter.y;
					end
				end
			end
		end
		--无法攻击的情况，考虑离敌人更近
		local v=5000+(math.abs(iter.x-ex)+math.abs(iter.y-ey))*10;	--距离影响
		if v<mv then
			mv=v;
			wp["目标ID"]=0;
			wp["目标X"],wp["目标Y"]=iter.x,iter.y;
		end
		table.remove(Open,1);
		for i=iter.x-1,iter.x+1 do
			for j=iter.y-1,iter.y+1 do
				if between(i,0,127) and between(j,0,127) then
					if FNMap[i][j]==1 then
					
					else
						FNMap[i][j]=1;
						local length=math.abs(i-x)+math.abs(j-y);
						if length<=depth then
							if WarCanPass(wid,i,j) then
								table.insert(Open,{x=i,y=j});
							end
						end
					end
				end
			end
		end
	end
	War.s5=War.s5+lib.GetTime()-t0;
end
function AI_FindNearest(wid)
	local t0=lib.GetTime();
	--寻找最近的可以攻击的位置
	local wp=War.Person[wid];
	local x,y=wp["坐标X"],wp["坐标Y"];
	wp["目标ID"]=0;
	wp["目标X"],wp["目标Y"]=0,0;
	local depth=12;
	local t_eid={};	--敌人列表，记录eid以及价值
	local function MinHeapInsert(t,v)
		--最小二叉树，新增元素
		table.insert(t,v);
		local n=#t;
		local f;
		while n>1 do
			f=math.floor(n/2);	--父节点
			if v.v<t[f].v then
				t[n],t[f]=t[f],t[n];
				n=f;
			else
				break;
			end
		end
		
	end
	--首先遍历所有敌人，索引即eid
	local eid,ex,ey=0,0,0;
	local min_d=256;	--寻找最近的敌人
	for eid,v in ipairs(War.Person) do
		if v["存活"]>0 and v["敌我"]~=wp["敌我"] then
			local value=1000;	--价值，越低越优先 / 1000初始值是先设为无法攻击，可攻击则减去
			value=value+v["兵力"]/100;
			if wp.bz["兵系"]~=2 and v.bz["兵系"]==2 then	--非弓兵对弓兵
				value=value-50;
			end
			for tx=math.max(v["坐标X"]-4,0),math.min(v["坐标X"]+4,127) do
				for ty=math.max(v["坐标Y"]-4,0),math.min(v["坐标Y"]+4,127) do
					if tx==v["坐标X"] and ty==v["坐标Y"] then
					
					else
						if WarCanPass(wid,tx,ty) and AI_CanAtk(wid,eid,tx,ty) then
							MinHeapInsert(t_eid,{eid=eid,x=tx,y=ty,v=value+(math.abs(tx-x)+math.abs(ty-y))*10})
							--table.insert(t_eid,{eid=eid,x=tx,y=ty,v=value+(math.abs(tx-x)+math.abs(ty-y))*10});
						end
					end
				end
			end
		end
	end
	if #t_eid>0 then
		--table.sort(t_eid,function(a,b) if a.v<b.v then return true end end)
		wp["目标ID"]=t_eid[1].eid;
		wp["目标X"],wp["目标Y"]=t_eid[1].x,t_eid[1].y;
	end
	War.s5=War.s5+lib.GetTime()-t0;
end
function AI_FindNearest1(wid)
	local t0=lib.GetTime();
	--寻找最近的可以攻击的位置
	local wp=War.Person[wid];
	local x,y=wp["坐标X"],wp["坐标Y"];
	wp["目标ID"]=0;
	wp["目标X"],wp["目标Y"]=0,0;
	local depth=32;
	local t_eid={};	--敌人列表，记录eid以及价值
	local FNMap={};
	for i=0,127 do
		FNMap[i]={}
		for j=0,127 do
			FNMap[i][j]=0;
		end
	end
	FNMap[x][y]=1;
	--标记可以近程攻击的位置
	for eid,v in ipairs(War.Person) do
		if v["存活"]>0 and v["敌我"]~=wp["敌我"] then
			local value=1000;	--价值，越低越优先 / 1000初始值是先设为无法攻击，可攻击则减去
			value=value+v["兵力"]/100;
			if wp.bz["兵系"]~=2 and v.bz["兵系"]==2 then	--非弓兵对弓兵
				value=value-50;
			end
			local m=(wp["体积"]+v["体积"]+1)^2;
			for i=math.max(v["坐标X"]-4,0),math.min(v["坐标X"]+4,127) do
				for j=math.max(v["坐标Y"]-4,0),math.min(v["坐标Y"]+4,127) do
					if (i-v["坐标X"])^2+(j-v["坐标Y"])^2<m then
						FNMap[i][j]=-eid;
					end
				end
			end
		end
	end
	local Open={};
	table.insert(Open,{x=x,y=y})
	while #Open>0 do
		local iter=Open[1];
		local move=FNMap[iter.x][iter.y]+1;
		table.remove(Open,1);
		for i=math.max(iter.x-1,0),math.min(iter.x+1,127) do
			for j=math.max(iter.y-1,0),math.min(iter.y+1,127) do
				if FNMap[i][j]<0 then
					wp["目标ID"]=-FNMap[i][j];
					wp["目标X"],wp["目标Y"]=i,j;
	War.s5=War.s5+lib.GetTime()-t0;
					return;
				elseif FNMap[i][j]>0 then
				
				else
					FNMap[i][j]=move;
					if move<=depth then
						if WarCanPass(wid,i,j) then
							table.insert(Open,{x=i,y=j});
						end
					end
				end
			end
		end
	end
	War.s5=War.s5+lib.GetTime()-t0;
end
function War_AI()
	local t0=lib.GetTime()
	if #War.AI_Pool>0 then
		local wid=War.AI_Pool[1];
		local wp=War.Person[wid];
		table.remove(War.AI_Pool,1);
		if wp["存活"]>0 then
			table.insert(War.AI_Pool,wid);
			if true or wp["动作进度"]==0 then	--进行AI
				findpath(wid);
			end
		end
	end
end
function LoadDX()
	local len=64*64*2+2;
	local data=Byte.create(len);
	Byte.loadfile(data,string.format(".\\D_YMAP.S8\\D_YMAP.S8.%03d",War.mapid),0,len);
	local idx=4
	local flag=true
	
	War.GroupXY={	--出场位置
					[1]={},[2]={},[3]={},[4]={},[5]={},
					[6]={},[7]={},[8]={},[9]={},[10]={},[16]={},
				}
	
	local x,y=1,64
	for i=0,62 do
		for j=0,32 do
			local v
			--%16得到第一位，地形
			--第二位 敌我援标识 我方正规军为0 1/2分别为我方援军
			--					敌方城门布阵为5 迎击为8 6/7分别为援军
			--			F 怀疑是 中间据点
			--第三位 部队序号
				v=Byte.getu16(data,idx);
				if v<65521 then
					local group=1+math.floor(v/16)%16;
					local order=1+math.floor(v/256)%16;
					if between(group,1,10) then
						War.GroupXY[group][order]={x=x+j-1,y=y+j}
					end
					if group==16 then
						--lib.Debug("16 "..order)
						order=#War.GroupXY[group]+1;
						War.GroupXY[group][order]={x=x+j-1,y=y+j}
					end
					v=v%16
				else
					v=v%16
				end
				idx=idx+2
				War.MAP[x+j-1][y+j].dx=v
				
			if j<32 then
				v=Byte.getu16(data,idx);
				if v<65521 then
					local group=1+math.floor(v/16)%16;
					local order=1+math.floor(v/256)%16;
					if between(group,1,10) then
						War.GroupXY[group][order]={x=x+j,y=y+j}
					end
					if group==16 then
						--lib.Debug("16 "..order)
						order=#War.GroupXY[group]+1;
						War.GroupXY[group][order]={x=x+j,y=y+j}
					end
					v=v%16
				else
					v=v%16
				end
				idx=idx+2
				War.MAP[x+j][y+j].dx=v
			end
		end
		if idx>len then
			break;
		end
		x=x+1
		y=y-1
	end
	if War.GroupXY[1][1].x>55 then
		War.CityPosition=0;
	else
		War.CityPosition=1;
	end
	if War.CityPosition==0 then	--城在左边
		x=9
		for y=55,73 do
			War.MAP[x][y].dx=14
		end
	else
		y=11
		for x=53,72 do
			War.MAP[x][y].dx=14
		end
	end
	for i,v in ipairs(War.GroupXY[16]) do
		War.MAP[v.x][v.y].dx=13
		War.MAP[v.x+1][v.y].dx=13
		War.MAP[v.x+2][v.y].dx=13
		War.MAP[v.x][v.y-1].dx=13
		War.MAP[v.x+1][v.y-1].dx=13
		War.MAP[v.x+2][v.y-1].dx=13
		War.MAP[v.x][v.y-2].dx=13
		War.MAP[v.x+1][v.y-2].dx=13
		War.MAP[v.x+2][v.y-2].dx=13
	end
end
function GetMapXY(dx,dy)
	--从屏幕坐标dx dy，转换为地图坐标mx my
	local x_off,y_off=1040-War.x_off,-264-War.y_off;
	local mx=math.floor((dx+dy*2-x_off-y_off*2)/32+0.501);
	local my=math.floor((dy*2-dx+x_off-y_off*2)/32+0.501);
	return mx,my;
end
function GetScreenXY(mx,my)
	--从屏幕坐标dx dy，转换为地图坐标mx my
	local x_off,y_off=1040-War.x_off,-264-War.y_off;
	local dx=(mx-my)*16+x_off;
	local dy=(mx+my)*8+y_off;
	return dx,dy;
end
function War_CalHurt(wid,eid,hurt_type)
	local wp=War.Person[wid];
	local ep=War.Person[eid];
	local atk,def;
	if hurt_type==0 then
		atk=wp["攻击力"];
	else
		atk=wp["远程攻击力"];
	end
	def=ep["防御力"];
	local dx=War.MAP[ep["坐标X"]][ep["坐标Y"]].dx;
	--开始计算伤害		固有兵力相关 + 攻防相关 + 随机数
	local hurt=math.max(20 , wp.p["武力"]+wp.p["统率"] , wp["兵力"]/200 , atk)*atk/(atk+def) + (math.random()-math.random())*5;
	hurt=math.max(atk*atk/(atk+def),1) + (math.random()-math.random())*5;
	--暴击
	if math.random(1000)+30<wp.p["武力"] then
		if wp.bingfa_id>0 then
			hurt=hurt*3;
		else
			hurt=hurt*2;
		end
	end
	hurt=math.floor(hurt*20/(8+ep.bz["适性"..dx]));
	if hurt<1 then
		hurt=1;
	end
	return hurt;
end
function War_SetAttrib(wid)
	local wp=War.Person[wid];
	local att=	20 + 
				math.max(	30000/(200-wp.p["武力"])-150,
							(wp["兵力"]*2+wp["兵力上限"])/(200-wp.p["统率"])-150) + 
				wp["兵力"]/500;
	--if att<10 then att=10 end
	wp["攻击力"]=math.floor(att*wp.bz["攻击力"]/10);
	wp["远程攻击力"]=math.floor(att*wp.bz["远程攻击力"]/10);
	wp["防御力"]=math.floor(att*wp.bz["防御力"]/10);
	if wp["兵力"]>12000 then
		wp["体积"]=2;
	elseif wp["兵力"]>8000 then
		wp["体积"]=1.5;
	elseif wp["兵力"]>4000 then
		wp["体积"]=1;
	else
		wp["体积"]=0.5;
	end
end
function War_AddPerson(group,order,pid,bid,bl)
	local wid=1+#War.Person;
	local fid=JY.Person[pid]["势力"];
	War.Person[wid]={
						["方向"]=GetDirection(1,0,1),
						["坐标X"]=War.GroupXY[group][order].x,
						["坐标Y"]=War.GroupXY[group][order].y,
						["移动X"]=War.GroupXY[group][order].x,
						["移动Y"]=War.GroupXY[group][order].y,
						["目标X"]=-1,
						["目标Y"]=-1,
						["屏幕X"]=-1,
						["屏幕Y"]=-1,
						["目标ID"]=0,
						["动作"]=0,
						["动作进度"]=0,
						["动作进度最大值"]=0,
						["贴图"]=0,
						["人物ID"]=pid,
						["兵力"]=bl,
						["兵力上限"]=bl,
						["攻击力"]=0,
						["远程攻击力"]=0,
						["防御力"]=0,
						["兵种"]=bid,
						["存活"]=1,
						["选中"]=0,
						--AI--
						["AI方针"]=0,
						["AI目标ID"]=0,
						["AI目标X"]=0,
						["AI目标Y"]=0,
						------
						flag_id=GetFlagID(pid),
						force_id=fid,
						bingfa_id=0,
						bingfa_time=0,
						talkstr="",
						talkd=0,
						movepath={},	--预订移动路径
						hurt_str={},	--受伤显示
						hurt_str_dy={},	--受伤显示
					}
	if fid==4 or fid==8 or fid==11 or fid==12 
		or fid==14 or fid==16 or fid==19 or fid==23 
		or fid==24 or fid==26 or fid==27 or fid==30 
		or fid==33 or fid==36 or fid==38 or fid==39 
		or fid==42 or fid==43 or fid==45 or fid==48 
		or fid==50 or fid==51 then
		War.Person[wid].flag_id=War.Person[wid].flag_id+459;
	else
		War.Person[wid].flag_id=War.Person[wid].flag_id+662;
	end
	War.Person[wid].p=JY.Person[pid];
	War.Person[wid].bz=JY.Bingzhong[bid];
	if group<6 then
		War.Person[wid]["贴图"]=War.Person[wid].bz["贴图"];
		War.Person[wid]["敌我"]=0;
	else
		War.Person[wid]["贴图"]=War.Person[wid].bz["贴图"]+80;
		War.Person[wid]["敌我"]=1;
		War.Person[wid]["AI方针"]=1;
		War.Person[wid]["AI目标X"]=War.GroupXY[group][order].x;
		War.Person[wid]["AI目标Y"]=War.GroupXY[group][order].y;
	end
	War_SetAttrib(wid);
	War.MAP[War.Person[wid]["坐标X"]][War.Person[wid]["坐标Y"]].wid1=wid;
	table.insert(War.AI_Pool,wid);
end
function WarDrawFlag(x0,y0,fid,xid,d,frame)
	fid=fid+406;
	local x,y=x0,y0;
	if d~=3 then
		lib.PicLoadCache(0,402*2,x0,y0,1,255);	--旗杆
	end
	if d==0 or d==1 then
		x=x-30;
		y=y+4;
	elseif d==2 then
		x=x-30;
		y=y-12;
	elseif d==3 then
		x=x-15;
		y=y-10;
	elseif d==4 then
		x=x+1;
		y=y-12;
	elseif d==5 then
		x=x+1;
		y=y+4;
	elseif d==6 then
		x=x+1;
		y=y+2;
	elseif d==7 then
		x=x-15;
		y=y+2;
	end
	--旗帜
	lib.SetClip(x,y,x+32,y+40)
	lib.PicLoadCache(0,fid*2,x-frame*32,y-d*40,1,255);
	lib.SetClip(0,0,0,0)
	--姓氏
	if d==3 and d==3 then
		
	else
		if d>3 then
			d=d-1;
		end
		lib.SetClip(x,y,x+32,y+40)
		lib.PicLoadCache(0,xid*2,x-frame*32,y-d*40,1,255);
		lib.SetClip(0,0,0,0)
	end
	if d==3 then
		lib.PicLoadCache(0,402*2,x0,y0,1,255);	--旗杆
	end
	
end
function GetFlagID(pid)
	local str=string.sub(JY.Person[pid]["名称"],1,2);
	local ft={	["帅"]=0,["阿"]=1,["韦"]=2,["伊"]=3,["尹"]=4,["于"]=5,["卫"]=6,["袁"]=7,["阎"]=8,["王"]=9,
				["何"]=10,["蒯"]=11,["贾"]=12,["华"]=13,["郭"]=14,["鄂"]=15,["乐"]=16,["霍"]=17,["郝"]=18,["夏"]=19,
				["贺"]=20,["关"]=21,["韩"]=22,["管"]=23,["毋"]=24,["阚"]=25,["甘"]=26,["桓"]=27,["简"]=28,["颜"]=29,
				["魏"]=30,["麴"]=31,["戏"]=32,["牛"]=33,["丘"]=34,["姜"]=35,["巩"]=36,["桥"]=37,["龚"]=38,["许"]=39,
				["纪"]=40,["金"]=41,["虞"]=42,["邢"]=43,["郤"]=44,["严"]=45,["牵"]=46,["吴"]=47,["句"]=48,["黄"]=49,
				["高"]=50,["侯"]=51,["公"]=52,["孔"]=53,["皇"]=54,["胡"]=55,["伍"]=56,["吾"]=57,["顾"]=58,["兀"]=59,
				["崔"]=60,["蔡"]=61,["左"]=62,["笮"]=63,["施"]=64,["师"]=65,["司"]=66,["谢"]=67,["车"]=68,["沙"]=69,
				["朱"]=70,["脩"]=71,["周"]=72,["州"]=73,["祝"]=74,["荀"]=75,["淳"]=76,["焦"]=77,["钟"]=78,["蒋"]=79,
				["谯"]=80,["向"]=81,["邵"]=82,["徐"]=83,["诸"]=84,["沈"]=85,["申"]=86,["岑"]=87,["辛"]=88,["审"]=89,
				["秦"]=90,["眭"]=91,["邹"]=92,["成"]=93,["盛"]=94,["石"]=95,["薛"]=96,["全"]=97,["单"]=98,["曹"]=99,
				["宋"]=100,["臧"]=101,["沮"]=102,["苏"]=103,["祖"]=104,["孙"]=105,["太"]=106,["带"]=107,["戴"]=108,["朵"]=109,
				["谭"]=110,["张"]=111,["赵"]=112,["陈"]=113,["程"]=114,["丁"]=115,["郑"]=116,["典"]=117,["田"]=118,["滕"]=119,
				["董"]=120,["邓"]=121,["党"]=122,["陶"]=123,["唐"]=124,["杜"]=125,["宁"]=126,["裴"]=127,["马"]=128,["万"]=129,
				["樊"]=130,["潘"]=131,["费"]=132,["卑"]=133,["糜"]=134,["毕"]=135,["武"]=136,["冯"]=137,["傅"]=138,["文"]=139,
				["卞"]=140,["方"]=141,["庞"]=142,["忙"]=143,["逢"]=144,["鲍"]=145,["法"]=146,["步"]=147,["穆"]=148,["濮"]=149,
				["木"]=150,["满"]=151,["毛"]=152,["孟"]=153,["俞"]=154,["杨"]=155,["雍"]=156,["羊"]=157,["雷"]=158,["骆"]=159,
				["罗"]=160,["李"]=161,["陆"]=162,["刘"]=163,["留"]=164,["吕"]=165,["廖"]=166,["梁"]=167,["凌"]=168,["伦"]=169,
				["冷"]=170,["楼"]=171,["鲁"]=172,["卢"]=173,["蜀"]=174,["倭"]=175,["乌"]=176,["羌"]=177,["山"]=178,["南"]=179,
				["燕"]=180,["齐"]=181,["楚"]=182,["凉"]=183,["越"]=184,["晋"]=185,["区"]=186,["於"]=187,["温"]=188,["俄"]=189,
				["轲"]=190,["强"]=191,["国"]=192,["呼"]=193,["士"]=194,["蹋"]=195,["波"]=196,["迷"]=197,["娄"]=198,["汉"]=199,
				["商"]=200,["新"]=201,["隋"]=202,
				["韋"]=2,["衛"]=6,["閻"]=8,["區"]=186,["溫"]=188,["賈"]=12,["華"]=13,["樂"]=16,["賀"]=20,["關"]=21,
				["韓"]=22,["闞"]=25,["簡"]=28,["顏"]=29,["戲"]=32,["鞏"]=36,["橋"]=37,["龔"]=38,["許"]=39,["紀"]=40,
				["嚴"]=45,["牽"]=46,["吳"]=47,["黃"]=49,["國"]=192,["顧"]=58,["師"]=65,["車"]=68,["鍾"]=78,["蔣"]=79,
				["譙"]=80,["諸"]=84,["審"]=89,["鄒"]=92,["單"]=98,["蘇"]=103,["孫"]=105,["帶"]=107,["譚"]=110,["張"]=111,
				["趙"]=112,["陳"]=113,["鄧"]=121,["黨"]=122,["馬"]=128,["萬"]=129,["費"]=132,["馮"]=137,["龐"]=142,["鮑"]=145,
				["滿"]=151,["楊"]=155,["駱"]=159,["羅"]=160,["陸"]=162,["劉"]=163,["呂"]=165,["倫"]=169,["婁"]=198,["樓"]=171,
				["魯"]=172,["盧"]=173,["軻"]=190,["強"]=191,["烏"]=176,
				}
	local r=ft[str];
	r=r or -1;
	return r;
end
function War_LoadMap(warid)
	if JY.Connection[warid]["古战场"]>0 then
		War.name=JY.Str[9180+JY.Connection[warid]["古战场"]].."之战";
	else
		War.name=JY.City[JY.Connection[warid]["都市2"]]["名称"].."之战";
	end
	War.mapid=JY.Connection[warid]["战场"];
	War.wid1=JY.Connection[warid]["战场地图1"];
	War.wid2=JY.Connection[warid]["战场地图2"];
	War.CityPosition=0;
	LoadDX();
	War.Target={[0]={},[1]={},};
	if War.CityPosition==0 then
		War.Target[0].x=9;
		War.Target[0].y=62;
	else
		War.Target[0].x=60;
		War.Target[0].y=11;
	end
	War.Target[1].x=War.GroupXY[1][1].x
	War.Target[1].y=War.GroupXY[1][1].y
	War.x_off,War.y_off=GetScreenXY(War.GroupXY[1][1].x,War.GroupXY[1][1].y);
	War.x_off=limitX(War.x_off-CC.ScreenW/2,0,2016-CC.ScreenW);
	War.y_off=limitX(War.y_off-CC.ScreenH/2,0,768-CC.ScreenH);
end
function LLK_III_Main(warid)
	local x_off_old=0;
	local y_off_old=0;
	local move_screen=false;
	for i=0-8,127+8 do
		War.MAP[i]={}
		for j=0-8,127+8 do
			War.MAP[i][j]={
							dx=0,	--地形，不可通过
							wid1=0,	--部队ID，0为无部队
							wid2=0,	--用于单位碰撞
							}
		end
	end
	War_LoadMap(warid);
	War.AI_Pool={};
	for i,v in ipairs(War.ArmyA1) do
		War_AddPerson(1,i,v.pid,v.bz,v.bl);
	end
	for i,v in ipairs(War.ArmyB1) do
		War_AddPerson(9,i,v.pid,v.bz,v.bl);
		
	end
	local bt={};
	table.insert(bt,button_creat(1,73,20,110,"LoadScript",true,true));
	local wm=creatWarMenu();
	War.s1=1
	War.s2=0
	War.s3=0
	War.s4=0
	War.s5=0
	
	local t0=lib.GetTime();
	local fps_num=0;
	local fps_time=0;
	local fps_str="";
	local cpu_str="";
	PlayBGM(11);
	while true do
		local t1=lib.GetTime();
										t0=lib.GetTime();
		if not wm.pause then
		War_AutoAction();
										War.s1=War.s1+lib.GetTime()-t0;
										t0=lib.GetTime();
		War_AI();
										War.s2=War.s2+lib.GetTime()-t0;
										t0=lib.GetTime();
		War_PlayWav();
		end
		DrawWarMap()
		
		button_redraw(bt);
		redrawWarMenu(wm);
						DrawStringEnhance(8,280,fps_str,C_WHITE,24);
						DrawStringEnhance(8,210,cpu_str,C_WHITE,24);
	
						fps_num=fps_num+1;
						fps_time=fps_time+lib.GetTime()-t1;
						if fps_num==20 then
							fps_str=string.format("[B]FPS: %3.1f",20000/fps_time);
							--cpu_str=string.format("[B]%3.1f %3.1f(%3.1f %3.1f) %3.1f",100*War.s1/(War.s1+War.s2+War.s3),100*War.s2/(War.s1+War.s2+War.s3),100*War.s4/(War.s1+War.s2+War.s3),100*War.s5/(War.s1+War.s2+War.s3),100*War.s3/(War.s1+War.s2+War.s3));
							cpu_str=string.format("[B]AI: %2.1f, 寻敌: %2.1f, 寻路: %2.1f",War.s2/20,War.s5/20,War.s4/20)
							fps_num=0;
							fps_time=0;
	War.s1=1
	War.s2=0
	War.s3=0
	War.s4=0
	War.s5=0
						end
		ShowScreen();
										War.s3=War.s3+lib.GetTime()-t0;
										t0=lib.GetTime();
		local delay=CC.FrameNum-lib.GetTime()+t1;
		if delay>0 then
			lib.Delay(delay);
		end
		--DoEvent
		getkey();
		War.mx,War.my=GetMapXY(MOUSE.x,MOUSE.y);
		eventWarMenu(wm);
		local event,btid=button_event(bt);
		if event==3 then
			if btid==73 then
				dofile(CONFIG.ScriptPath .. "LLK_III.lua");
			end
		end
		--移动地图
		if move_screen then
			if MOUSE.status=='HOLD' then
				War.x_off=limitX(x_off_old+MOUSE.hx-MOUSE.x,0,2016-CC.ScreenW);
				War.y_off=limitX(y_off_old+MOUSE.hy-MOUSE.y,0,768-CC.ScreenH);
			else
				move_screen=false;
			end
		else
			if MOUSE.HOLD(0,0,CC.ScreenW,CC.ScreenH) then
				x_off_old=War.x_off;
				y_off_old=War.y_off;
				move_screen=true;
			end
		end
		--选择部队
		local sx,sy=GetScreenXY(War.mx,War.my);
		if MOUSE.CLICK(sx-16,sy-8,sx+16,sy+8) then
			for wid,wp in ipairs(War.Person) do
				if between(wp["屏幕X"],sx-64,sx+64) and between(wp["屏幕Y"],sy-32,sy+32) then
					wp["选中"]=1;
				else
					wp["选中"]=0;
				end
			end
		end
	end
end
function WarCanPass(wid,x,y)
	local dx=War.MAP[x][y].dx;
	if dx==0 then
		return false;
	elseif War.Person[wid].bz["移动力"..dx]==0 then
		return false;
	end
	local tx={-1,0,1,		-2,-1,0,1,2,		-2,-1,0,1,2,		-2,-1,0,1,2,		-1,0,1};
	local ty={-2,-2,-2,		-1,-1,-1,-1,-1,		0,0,0,0,0,			1,1,1,1,1,			2,2,2};
	local tr={3,2.5,3,		3,2,1.5,2,3,		2.5,1.5,0,1.5,2.5,	3,2,1.5,2,3,		3,2.5,3};
	for idx=1,#tx do
		local i,j=x+tx[idx],y+ty[idx];
		--if between(i,0,127) and between(j,0,127) then
			local eid=War.MAP[i][j].wid1;
			if eid>0 and eid~=wid then
				local size=War.Person[wid]["体积"]+War.Person[eid]["体积"];
				if size>tr[idx] then
					return false;
				end
			end
		--end
	end
	return true;
end
function GetMoveCost(wid,x,y)
	local dx=War.MAP[x][y].dx;
	if dx==0 then return 0 end
	local cost=War.Person[wid].bz["移动力"..dx];
	return cost;
end
function findpath(wid)--,x1,y1,x2,y2)
				local t0=lib.GetTime();
	local wp=War.Person[wid];
	local x1,y1=wp["移动X"],wp["移动Y"]--wp["坐标X"],wp["坐标Y"];
	local x2,y2=wp["目标X"],wp["目标Y"];
	local Open={}
	local Neibo={}
	local iter={}
	local ender={}
	local cur={}
	local Asmap={}
	for i=0,127 do
		Asmap[i]={}
		for j=0,127 do
			Asmap[i][j]={
							x=i,y=j,
							g=0,h=0,f=0,w=0,
							father=nil,eid=0,
							s=0,	--0未处理 1 Open 2 Close
							};
		end
	end
	--设置碰撞 标记不可移动的位置 以及 敌人位置
	local tx={0,	-1,1,0,0,	-1,-1,1,1,	-2,2,0,0,	-2,-1,1,2,-2,-1,1,2}
	local ty={0,	0,0,-1,1,	-1,1,-1,1,	0,0,-2,2,	1,2,2,1,-1,-2,-2,-1}
	local n;
	local min_len,cur_len=256*256,0;
	x2,y2=0,0;
	for i,v in ipairs(War.Person) do
		if v["存活"] and i~=wid then
			n=v["体积"]+wp["体积"];
			if n>3 then
				n=21;
			elseif n>2.5 then
				n=13;
			elseif n>2 then
				n=9;
			elseif n>1.5 then
				n=5;
			else
				n=1;
			end
			local value=0;
			if v["敌我"]~=wp["敌我"] then
				value=2;
				cur_len=(v["坐标X"]-x1)^2+(v["坐标Y"]-y1)^2;
				if cur_len<min_len then
					min_len=cur_len;
					x2=v["坐标X"];
					y2=v["坐标Y"];
				end
			else
				value=1;
			end
			for i=1,n do
				local x,y=v["坐标X"]+tx[i],v["坐标Y"]+ty[i];
				if between(x,0,127) and between(y,0,127) then
					Asmap[x][y].eid=value;
				end
			end
		end
	end
	--
	local t1=lib.GetTime();
	lib.Debug("build table "..(t1-t0))
	--A*中的启发式函数，用于求指定位置和终点之间的曼哈顿距离
	local function manhatten(x,y)
		--return math.abs(x-x2) + math.abs(y-y2);
		local dx,dy=math.abs(x-x2),math.abs(y-y2);
		local h_diagonal=math.min(dx,dy);
		local h_straight=dx+dy;
		return h_straight-0.6*h_diagonal;
	end
	--求当前点与父亲节点的距离
	local function increment(node)
		if node.x~=node.father.x and node.y~=node.father.y then
			return 1.4*node.w;
		--elseif node.x==node.father.x and node.y==node.father.y then
		--	return 0;
		else
			return node.w;
		end
	end
	--求出用当前点作为父节点时这个点的G值
	local function NewG(node,father)
		if node.x~=father.x and node.y~=father.y then
			return father.g+1.4*node.w;
		--elseif node.x==father.x and node.y==father.y then
		--	return father.g;
		else
			return father.g+node.w;
		end
	end
	local function MinHeapInsert(t,v)
		--最小二叉树，新增元素
		table.insert(t,v);
		local n=#t;
		local f;
		while n>1 do
			f=math.floor(n/2);	--父节点
			if v.f<t[f].f then
				t[n],t[f]=t[f],t[n];
				n=f;
			else
				break;
			end
		end
		
	end
	local function MinHeapRemove(t)
		--最小二叉树，移除第一位
		table.remove(t,1);
		local n=#t;
		local f=1;
		local c;
		while true do
			if f*2>n then
				break;
			elseif f*2+1>n then
				c=f*2;
			elseif t[f*2].f<t[f*2+1].f then
				c=f*2;
			else
				c=f*2+1;
			end
			if t[c].f<t[f].f then
				t[c],t[f]=t[f],t[c];
			else
				break;
			end
		end
	end
	iter=Asmap[x1][y1];
	iter.x,iter.y=x1,y1;
	iter.g=0;
	iter.s=1
	--把起点放入开启列表
	table.insert(Open,iter);
	--当开启列表为空或者终点在关闭列表中，结束寻径
	local notFound=true;
	local search=0;
	while #Open>0 and notFound do
		search=search+1;
		--取出开启列表中f值最小的节点（之一），并设为iter（当前点）
		iter = Open[1];
		--把当前点从开启列表中删除
		MinHeapRemove(Open);
		--把当前点记录在关闭列表中
		iter.s=2
		if search>2000 then
			notFound=false;
			x2,y2=iter.x,iter.y
		end
		--把当前点的邻居加入邻居列表
		Neibo={};
		for i=math.max(iter.x-1,0),math.min(iter.x+1,127) do
			for j=math.max(iter.y-1,0),math.min(iter.y+1,127) do
				cur=Asmap[i][j];
				if cur==iter then
					
				else
					cur.x,cur.y=i,j;
					cur.h = manhatten(i, j);
					cur.w = GetMoveCost(wid,i,j)/(10+iter.g);
					table.insert(Neibo,cur);
				end
			end
		end
		--对于每个邻居，分三种情况进行操作
		for i,v in ipairs(Neibo) do
			--如果这个邻居节点不可通过，或者这个邻居节点在关闭列表中，略过它
			if v.w==0 or v.s==2 then
			--如果这个邻居结点是目标附近，则找到
			elseif v.eid>0 then
				if v.eid>1 then
					x2,y2=iter.x,iter.y
					notFound=false;
				end
			--如果这个邻居节点已经在开启列表中
			elseif v.s==1 then
			--看看以当前格子为父节点，算出来的新G值是不是比原来的G值小，如果更小，就改变这一格的父节点，G值，重新计算F值
				if NewG(v,iter)<v.g then
					v.father = iter;
					v.g = iter.g + increment(v);
					v.f = v.g + v.h;
				end
			--如果这个邻居节点不在开启列表中
			else
				v.father = iter;
				v.g = iter.g + increment(v);
				v.f = v.g + v.h;
				v.s=1
				MinHeapInsert(Open,v);
			end
		end
	end
	lib.Debug("AI_Search "..search.."pt, use "..(lib.GetTime()-t1).."s, total "..(lib.GetTime()-t0))
	iter=Asmap[x1][y1];
	ender=Asmap[x2][y2];
	local movepath={};
	if not notFound then
		while ender.x~=iter.x or ender.y~=iter.y do
			table.insert(movepath,1,{x=ender.x,y=ender.y})
			ender=ender.father;
		end
		for i=1,#movepath do
			movepath[i].d=GetDirection(movepath[i].x-x1,movepath[i].y-y1);
			x1=movepath[i].x;
			y1=movepath[i].y;
		end
	end
			War.s4=War.s4+lib.GetTime()-t0;
	wp.movepath=movepath;
end
function findpath(wid)--,x1,y1,x2,y2)
				local t0=lib.GetTime();
	local wp=War.Person[wid];
	local x1,y1=wp["移动X"],wp["移动Y"]--wp["坐标X"],wp["坐标Y"];
	local x2,y2=wp["目标X"],wp["目标Y"];
	local Open={}
	local Neibo={}
	local iter;
	local ender;
	local cur;
	local Asmap={
					g={},
					h={},
					f={},
					w={},
					s={},
					father={},
					eid={},
				}
	--设置碰撞 标记不可移动的位置 以及 敌人位置
	local tx={0,	-1,1,0,0,	-1,-1,1,1,	-2,2,0,0,	-2,-1,1,2,-2,-1,1,2}
	local ty={0,	0,0,-1,1,	-1,1,-1,1,	0,0,-2,2,	1,2,2,1,-1,-2,-2,-1}
	local n;
	local min_len,cur_len=256*256,0;
	for i,v in ipairs(War.Person) do
		if v["存活"]>0 and i~=wid then
			n=v["体积"]+wp["体积"];
			if n>3 then
				n=21;
			elseif n>2.5 then
				n=13;
			elseif n>2 then
				n=9;
			elseif n>1.5 then
				n=5;
			else
				n=1;
			end
			local value=0;
			cur_len=(v["移动X"]-x1)^2+(v["移动Y"]-y1)^2;
			if v["敌我"]~=wp["敌我"] then
				value=1;
				if cur_len<min_len then
					min_len=cur_len;
					x2=v["移动X"];
					y2=v["移动Y"];
				end
			else
				value=0;
				if cur_len>9 and v["动作"]==1 then	--离自己远的，且在移动中的友军，AI无视其阻拦
					n=0;
				end
			end
			for j=1,n do
				local x,y=v["移动X"]+tx[j],v["移动Y"]+ty[j];
				if between(x,0,127) and between(y,0,127) then
					Asmap.eid[128*x+y]=value;
				end
			end
		end
	end
	if wp["AI目标ID"]>0 then
		local target=wp["AI目标ID"];
		if target>0 and War.Person[target]["存活"]>0 then
			wp["AI目标X"],wp["AI目标Y"]=War.Person[target]["移动X"],War.Person[target]["移动Y"];
		else
			target=0;
			wp["AI目标X"],wp["AI目标Y"]=0,0;
		end
	end
	if wp["AI目标X"]>0 then
		if wp["AI方针"]==1 then	--坚守
			if (x2-x1)^2+(y2-y1)^2>100 then	--距离太远，则以坚守点为目标
				x2,y2=wp["AI目标X"],wp["AI目标Y"];
			end
		else
			x2,y2=wp["AI目标X"],wp["AI目标Y"];
		end
	end
	--
	local t1=lib.GetTime();
	--lib.Debug("build table "..(t1-t0))
	--A*中的启发式函数，用于求指定位置和终点之间的曼哈顿距离
	local function manhatten(x,y)
		--return math.abs(x-x2) + math.abs(y-y2);
		local dx,dy=math.abs(x-x2),math.abs(y-y2);
		local h_diagonal=math.min(dx,dy);
		local h_straight=dx+dy;
		return h_straight-0.6*h_diagonal;
	end
	--求当前点与父亲节点的距离
	local function increment(node)
		local dxy=math.abs(node-Asmap.father[node]);
		if dxy==1 or dxy==128 then
			return Asmap.w[node];
		else
			return 1.4*Asmap.w[node];
		end
	end
	--求出用当前点作为父节点时这个点的G值
	local function NewG(node,father)
		local dxy=math.abs(node-father);
		if dxy==1 or dxy==128 then
			return Asmap.w[father]+Asmap.w[node];
		else
			return Asmap.w[father]+1.4*Asmap.w[node];
		end
	end
	local function MinHeapInsert(t,v)
		--最小二叉树，新增元素
		table.insert(t,v);
		local n=#t;
		local f;
		while n>1 do
			f=math.floor(n/2);	--父节点
			if Asmap.f[v]<Asmap.f[t[f]] then
				t[n],t[f]=t[f],t[n];
				n=f;
			else
				break;
			end
		end
		
	end
	local function MinHeapRemove(t)
		--最小二叉树，移除第一位
		table.remove(t,1);
		local n=#t;
		local f=1;
		local c;
		while true do
			if f*2>n then
				break;
			elseif f*2+1>n then
				c=f*2;
			elseif Asmap.f[t[f*2]]<Asmap.f[t[f*2+1]] then
				c=f*2;
			else
				c=f*2+1;
			end
			if Asmap.f[t[c]]<Asmap.f[t[f]] then
				t[c],t[f]=t[f],t[c];
			else
				break;
			end
		end
	end
	min_len=256;
	iter=128*x1+y1;
	Asmap.g[iter]=0;
	Asmap.s[iter]=1;
	Asmap.h[iter]=manhatten(x1, y1);
	--把起点放入开启列表
	table.insert(Open,iter);
	--当开启列表为空或者终点在关闭列表中，结束寻径
	local notFound=true;
	local search=0;
	while #Open>0 and notFound do
		search=search+1;
		--取出开启列表中f值最小的节点（之一），并设为iter（当前点）
		iter = Open[1];
		--把当前点从开启列表中删除
		MinHeapRemove(Open);
		--把当前点记录在关闭列表中
		Asmap.s[iter]=2;
		if Asmap.h[iter]<=min_len then
			min_len=Asmap.h[iter];
			ender=iter;
		end
		if min_len==0 or search>256 then
			notFound=false;
			x2,y2=math.floor(ender/128),ender%128;
			break;
		end
		--把当前点的邻居加入邻居列表
		Neibo={};
		local cx,cy=(math.floor(iter/128)),iter%128;
		for i=math.max(cx-1,0),math.min(cx+1,127) do
			for j=math.max(cy-1,0),math.min(cy+1,127) do
				cur=128*i+j;
				if Asmap.s[cur]==nil then
					Asmap.h[cur]=manhatten(i, j);
					Asmap.w[cur]=GetMoveCost(wid,i,j)/(10+Asmap.g[iter]);
					table.insert(Neibo,cur);
				end
			end
		end
		--对于每个邻居，分三种情况进行操作
		for i,v in ipairs(Neibo) do
			--如果这个邻居节点不可通过，或者这个邻居节点在关闭列表中，略过它
			if Asmap.w[v]==0 or Asmap.s[v]==2 then
			--如果这个邻居结点是目标附近，则找到
			elseif Asmap.eid[v]~=nil then
				if Asmap.eid[v]>0 then
					x2,y2=cx,cy;
					notFound=false;
					break;
				else
					Asmap.s[v]=2;
				end
			--如果这个邻居节点已经在开启列表中
			elseif Asmap.s[v]==1 then
			--看看以当前格子为父节点，算出来的新G值是不是比原来的G值小，如果更小，就改变这一格的父节点，G值，重新计算F值
				if NewG(v,iter)<Asmap.g[v] then
					Asmap.father[v] = iter;
					Asmap.g[v] = Asmap.g[iter] + increment(v);
					Asmap.f[v] = Asmap.g[v] + Asmap.h[v];
				end
			--如果这个邻居节点不在开启列表中
			else
				Asmap.father[v] = iter;
				Asmap.g[v] = Asmap.g[iter] + increment(v);
				Asmap.f[v] = Asmap.g[v] + Asmap.h[v];
				Asmap.s[v]=1;
				MinHeapInsert(Open,v);
			end
		end
	end
	--lib.Debug("AI_Search "..search.."pt, use "..(lib.GetTime()-t1).."s, total "..(lib.GetTime()-t0))
	iter=128*x1+y1;
	ender=128*x2+y2;
	local movepath={};
	if not notFound then
		while iter~=ender do
			table.insert(movepath,1,{x=(math.floor(ender/128)),y=ender%128})
			ender=Asmap.father[ender];
		end
		for i=1,#movepath do
			movepath[i].d=GetDirection(movepath[i].x-x1,movepath[i].y-y1);
			x1=movepath[i].x;
			y1=movepath[i].y;
		end
	end
			War.s4=War.s4+lib.GetTime()-t0;
	wp.movepath=movepath;
end
function GetDirection(dx,dy,od)
	if dx==0 then
		if dy>0 then
			return 4;
		elseif dy<0 then
			return 0;
		else
			return od;
		end
	else
		local k=dy/dx;
		if dx>0 then
			if k>2.4142 then
				return 4;
			elseif k>0.4142 then
				return 3;
			elseif k<-2.4142 then
				return 0;
			elseif k<-0.4142 then
				return 1;
			else
				return 2;
			end
		else
			if k>2.4142 then
				return 0;
			elseif k>0.4142 then
				return 7;
			elseif k<-2.4142 then
				return 4;
			elseif k<-0.4142 then
				return 5;
			else
				return 6;
			end
		end
	end
end

--==================================================--
--					单挑部分						--
--==================================================--
function Fight(pid,eid)
	local x0,y0=CC.ScreenW/2,CC.ScreenH/2;
	--0 静止 1 攻击-挥舞 2 移动 3 攻击-刺-上 4 必杀？5 刺-下 6 舞动 7 防御 8 被击中 9 落马
	local p={	[1]={
						pid=pid,
						name=JY.Person[pid]["名称"],
						hpic=JY.Person[pid]["容貌"],
						wl=JY.Person[pid]["武力"],
						atk=400/(140-JY.Person[pid]["武力"]),
						def=8,
						hp=100,
						pic=1300,
						pos=-12,
						action=0,
						frame=0,
					},
				[2]={
						pid=eid,
						name=JY.Person[eid]["名称"],
						hpic=JY.Person[eid]["容貌"],
						wl=JY.Person[eid]["武力"],
						atk=400/(140-JY.Person[eid]["武力"]),
						def=8,
						hp=100,
						pic=1310,
						pos=12,
						action=0,
						frame=0,
					},
				};
	local bgpic=1200;
	local frame=0;
	--redraw
	local function redraw()
		lib.FillColor(0,0,0,0,0);
		lib.PicLoadCache(0,bgpic*2,x0,y0);
		for i=2,1,-1 do
			local pic=p[i].pic+p[i].action;
			local x=x0+16*p[i].pos;
			local y=y0-8*p[i].pos;
			lib.SetClip(x-82,y-82,x+82,y+82);
			lib.PicLoadCache(0,pic*2,x-164*(p[i].frame-3.5),y);
			lib.SetClip(0,0,0,0);
		end
		lib.PicLoadCache(0,1222*2,0,CC.ScreenH-284,1);
		lib.PicLoadCache(0,1223*2,CC.ScreenW-588,0,1);
		if p[1].hp>0 then
			lib.SetClip(0+246+196-p[1].hp*2,CC.ScreenH-284+199,0+246+196,CC.ScreenH-284+199+16);
			lib.PicLoadCache(0,1220*2,0+246,CC.ScreenH-284+199,1);
			lib.SetClip(0,0,0,0);
		end
		if p[2].hp>0 then
			lib.SetClip(CC.ScreenW-588+123,0+116,CC.ScreenW-588+123+p[2].hp*2,0+116+16);
			lib.PicLoadCache(0,1221*2,CC.ScreenW-588+123,0+116,1);
			lib.SetClip(0,0,0,0);
		end
		DrawStringEnhance(0+268+61,CC.ScreenH-284+161+13,p[1].name,C_WHITE,24,0.5,0.5);
		DrawStringEnhance(CC.ScreenW-588+179+61,0+78+13,p[2].name,C_WHITE,24,0.5,0.5);
		DrawStringEnhance(0+268+61+103,CC.ScreenH-284+161+13,""..p[1].wl,C_WHITE,24,0.5,0.5);
		DrawStringEnhance(CC.ScreenW-588+179+61-103,0+78+13,""..p[2].wl,C_WHITE,24,0.5,0.5);
		DrawStringEnhance(0+268+61+138,CC.ScreenH-284+161+43,"[B]体力",C_WHITE,18,0.5,0.5);
		DrawStringEnhance(CC.ScreenW-588+179+61-139,0+78+43,"[B]体力",C_WHITE,18,0.5,0.5);
		DrawStringEnhance(0+268+61+106,CC.ScreenH-284+161-17,"[B]武力",C_WHITE,18,0.5,0.5);
		DrawStringEnhance(CC.ScreenW-588+179+61-108,0+78-17,"[B]武力",C_WHITE,18,0.5,0.5);
		lib.PicLoadCache(2,p[1].hpic*2,132,CC.ScreenH-138-12,0,nil,nil,180);
		lib.PicLoadCache(2,p[2].hpic*2,CC.ScreenW-132,138-12,0,nil,nil,180);
	end
	local bt={};
	--红发出场 舞动 蓝方出场 挥动
	--胜利后 刺 上
	--舞动 后 接 任意攻击招式，都算必杀
	table.insert(bt,button_creat(1,21,20,20,"静止",true,true));	--0
	table.insert(bt,button_creat(1,22,20,54,"挥动",true,true));	--1
	table.insert(bt,button_creat(1,23,20,88,"移动",true,true));	--2
	table.insert(bt,button_creat(1,24,20,122,"胜利",true,true));	--3
	table.insert(bt,button_creat(1,25,20,156,"劈砍",true,true));	--4
	table.insert(bt,button_creat(1,26,20,190,"刺-下",true,true));	--5
	table.insert(bt,button_creat(1,27,20,224,"舞动",true,true));	--6
	table.insert(bt,button_creat(1,28,20,258,"防御",true,true));	--7
	table.insert(bt,button_creat(1,29,20,292,"受伤",true,true));	--8
	table.insert(bt,button_creat(1,30,20,326,"落马",true,true));	--9
	local function Draw(frame,rpt)
		frame=frame or 1;
		rpt=rpt or 4;
		local t1;
		for count=1,frame do
			for n=1,rpt do
				t1=lib.GetTime();
				redraw();
				button_redraw(bt);
				ShowScreen();
				t1=CC.FrameNum-lib.GetTime()+t1;
				if t1>0 then
					lib.Delay(t1);
				end
				--DoEvent
				getkey();
				local event,btid=button_event(bt);
				if event==3 then
					p[1].action=btid-21;
					p[2].action=btid-21;
				end
			end
			for i=1,2 do
				if p[i].frame<7 then
					p[i].frame=p[i].frame+1;
				else
					if p[i].action==0 or p[i].action==2 then
						p[i].frame=0;
					end
				end
			end
		end
	end
	local function decHP(id,hp)
		p[id].hp=p[id].hp-hp-p[id].atk;
	end
	local function setAction(id,action)
		p[id].action=action;
		p[id].frame=0;
	end
	--封装一些动作
	local function arrive(id)
		local r=math.random(1,2);
		if r==1 then
			setAction(id,1);
			Draw(4,4);
			lib.PlayWAV(".\\sound\\se_i005.wav");
			Draw(8,4);
		else
			setAction(id,6);
			lib.PlayWAV(".\\sound\\se_i006.wav");
			Draw(4,4);
			lib.PlayWAV(".\\sound\\se_i006.wav");
			Draw(4,4);
			Draw(4,4);
		end
		setAction(id,0);
	end
	local function move()
		setAction(1,2);
		setAction(2,2);
		lib.PlayWAV(".\\sound\\se_i000.wav");
		for i=1,20 do
			p[1].pos=p[1].pos+0.5;
			p[2].pos=p[2].pos-0.5;
			Draw(1,6);
		end
		setAction(1,0);
		setAction(2,0);
	end
	local function rnd_atk()
		if math.random(1,2)==1 then
			return 4;
		else
			return 5;
		end
	end
	local function atk_0()	--攻击 - 平
		setAction(1,rnd_atk());
		setAction(2,rnd_atk());
		Draw(4,3);
			PlayWavE(30);
		Draw(4,3);
		setAction(1,0);
		setAction(2,0);
	end
	local function atk_1(id)	--攻击 - 轻
		setAction(id,5);
		setAction(3-id,rnd_atk());
		Draw(4,3);
		if math.random(1,100)>p[3-id].def then
			lib.PlayWAV(".\\sound\\se_i008.wav");
			setAction(3-id,8);
			decHP(3-id,2);
		else
			PlayWavE(30)
			setAction(3-id,7);
		end
		Draw(8,3);
		setAction(1,0);
		setAction(2,0);
	end
	local function atk_2(id)	--攻击 - 重
		setAction(id,4);
		setAction(3-id,rnd_atk());
		Draw(4,3);
		if math.random(1,100)>p[3-id].def then
			lib.PlayWAV(".\\sound\\se_i007.wav");
			setAction(3-id,8);
			decHP(3-id,3);
		else
			PlayWavE(30)
			setAction(3-id,7);
		end
		Draw(8,3);
		setAction(1,0);
		setAction(2,0);
	end
	local function atk_3(id)	--攻击 - 必杀
		setAction(id,6);
		lib.PlayWAV(".\\sound\\se_i012.wav");
		Draw(8,3);
		setAction(id,rnd_atk());
		Draw(4,3);
		if math.random(1,100)>p[3-id].def then
			lib.PlayWAV(".\\sound\\se_i009.wav");
			setAction(3-id,8);
			decHP(3-id,10);
		else
			PlayWavE(30)
			setAction(3-id,7);
		end
		Draw(8,3);
		setAction(1,0);
		setAction(2,0);
	end
	local function atk_4(id)	--攻击 - 超必杀
		setAction(id,6);
		lib.PlayWAV(".\\sound\\se_i012.wav");
		Draw(8,3);
		setAction(id,6);
		if math.random(1,100)>p[3-id].def then
				lib.PlayWAV(".\\sound\\se_i006.wav");
			Draw(8,1);
			setAction(id,6);
				lib.PlayWAV(".\\sound\\se_i006.wav");
			Draw(8,1);
			setAction(id,6);
				lib.PlayWAV(".\\sound\\se_i006.wav");
			Draw(8,1);
			setAction(id,6);
				lib.PlayWAV(".\\sound\\se_i006.wav");
			Draw(8,1);
			setAction(id,rnd_atk());
			Draw(4,3);
			setAction(3-id,8);
			lib.PlayWAV(".\\sound\\se_i009.wav");
			Draw(8,3);
			decHP(3-id,20);
		else
			lib.PlayWAV(".\\sound\\issei.wav");
			Draw(8,1);
			setAction(id,6);
			Draw(8,1);
			setAction(id,6);
			Draw(8,1);
			setAction(id,6);
			Draw(8,1);
			setAction(id,rnd_atk());
			Draw(4,3);
			setAction(3-id,7);
			PlayWavE(30)
			Draw(8,3);
		end
		setAction(1,0);
		setAction(2,0);
	end
	--lib.PlayWAV(".\\sound\\se_i003.wav");
	--登场
	arrive(1);
	arrive(2);
	move();
	while p[1].hp>0 and p[2].hp>0 do
		local ratio=(p[1].wl+50)/(100+p[1].wl+p[2].wl);
		local r=math.random();
		local id=0;
		if r<ratio/2 then
			id=1;
		elseif r>0.5+ratio/2 then
			id=2;
		end
		if id>0 then
			r=math.random();
			if r<0.4 then
				atk_1(id);
			elseif r<0.8 then
				atk_2(id);
			elseif r<0.95 then
				atk_3(id);
			else
				atk_4(id);
			end
		else
			atk_0();
		end
	end
	if p[1].hp<=0 then
		setAction(1,9);
	end
	if p[2].hp<=0 then
		setAction(2,9);
	end
	lib.PlayWAV(".\\sound\\se_i002.wav");
	Draw(16,4);
	if p[1].hp>0 then
		setAction(1,3);
	end
	if p[2].hp>0 then
		setAction(2,3);
	end
	lib.PlayWAV(".\\sound\\se_i010.wav");
	Draw(16,4);
end
--==================================================--
function LoadSan8Record()
	local pnum=760;
	local size1=88
	local size2=4
	local data1=Byte.create(size1*pnum);
	local data2=Byte.create(size2*pnum);
	local file="E:\\San8PK\\svd_02.sav"
	Byte.loadfile(data1,file,3616,size1*pnum);
	Byte.loadfile(data2,file,79296,size2*pnum);
	local idx1=0;
	local idx2=0;
	for i=0,pnum-1 do
		local fid=Byte.get8(data1,size1*i+0)	--势力
		local sg=Byte.get8(data1,size1*i+1)		--士官年限
		local zc=Byte.get8(data1,size1*i+10)		--忠诚
		local zf--=Byte.get8(data1,size1*i+60)		--战法
		local zfstr=""
		--突击 乱击 搅乱 奇袭 枪阵 车悬 火箭 齐射 乱射 箭岚 激流 烈火 落石 妖术 攻城
		for j=0,7 do
			zf=Byte.get8(data1,size1*i+60+j)
			if zf<0 then
				zf=zf+256
			end
			local v=zf%16
			if v>8 then
				zfstr=zfstr..(v-7).."|"
			else
				zfstr=zfstr.."0|"
			end
			v=math.floor(zf/16)
			if v>8 then
				zfstr=zfstr..(v-7).."|"
			else
				zfstr=zfstr.."0|"
			end
		end
		local other=Byte.get32(data2,size2*i+0)		--位置，身份
		lib.Debug("> |"..i.."|"..fid.."|"..sg.."|"..zc.."|"..other.."|"..zfstr.."|<")
	end
end