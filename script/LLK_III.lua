-- Classed and Objects
WarMenu = {
  on = false,
  hold = false,
  pause = false,
  timer = 1,
  blmax = 0,
  blatk = 0,
  bldef = 0,
  result = 0,
}
function WarMenu:init()
  self.timer = 1;
  self.blmax = 0;
  self.result = 0;
end
function WarMenu:event()
	self.on = false;
	self.hold = false;
	if MOUSE.CLICK(28,19,103,94) then
		self.pause=not self.pause;
	elseif MOUSE.HOLD(28,19,103,94) then
		self.hold=true;
	elseif MOUSE.IN(28,19,103,94) then
		self.on=true;
	end
	if not self.pause then
		War.FrameT = War.FrameT + 2;
		if War.FrameT >= 64 then
			War.FrameT = 0;
			self.timer = self.timer + 1;
		end
		War.Frame = math.floor(War.FrameT / 8);
	end
  --cal bingli and war result
	self.blatk = 0;
  self.bldef = 0;
	for wid, wp in ipairs(War.Person) do
		if wp["存活"]>0 then
			if wp["敌我"]==0 then
				self.blatk = self.blatk + wp["兵力"];
			else
				self.bldef = self.bldef + wp["兵力"];
			end
		end
	end
	if self.blmax == 0 then
		self.blmax = math.max(self.blatk, self.bldef);
		if self.blmax < 100000 then
			self.blmax = self.blmax + (100000 - self.blmax) / 5;
		end
	end
  if self.blatk == 0 then
    self.result = 1;
  elseif self.bldef == 0 then
    self.result = 2;
  else
    self.result = 0;
  end
end
function WarMenu:redraw()
	local pic=341;
	if self.pause then
		if self.hold then
			pic = 346;
		elseif self.on then
			pic = 345;
		else
			pic = 344;
		end
		lib.Background(0, 0, CC.ScreenW, CC.ScreenH, 128);
		lib.PicLoadCache(4, 347*2, CC.ScreenW/2, CC.ScreenH/2);
	else
		if self.hold then
			pic = 343;
		elseif self.on then
			pic = 342;
		else
			pic = 341;
		end
	end
	lib.PicLoadCache(4, 340*2, 0, 0, 1);
	lib.PicLoadCache(4, pic*2, 66, 57);
	DrawStringEnhance(66, 54, "[B]"..self.timer, M_LightBlue, 32, 0.5, 0.5);
	DrawStringEnhance(186, 28, War.name,C_WHITE, 28, 0.5, 0.5);
	DrawStringEnhance(234, 55, "我军",C_WHITE, 16, 1);
	DrawStringEnhance(277, 55, "敌军",C_WHITE, 16, 0);
  
	lib.Background(254 - 128 * self.blatk / self.blmax, 74, 254, 74 + 16, 128, M_RoyalBlue);
	DrawStringEnhance(250, 72, "[B]" .. self.blatk, M_LightBlue, 18, 1);
	lib.Background(256, 74, 256 + 128 * self.bldef / self.blmax, 74 + 16, 128, C_RED);
	DrawStringEnhance(260, 72, "[B]" .. self.bldef, M_Pink, 18, 0);
  
  --minimap
  local mx, my = CC.ScreenW - 252, 0;
  local dx, dy;
  local function GetMiniMapXY(x, y)
    return (x - y) * 2 + mx + 132, (x + y) * 2 + my - 126;
  end
  lib.PicLoadCache(0, (War.wid1 + 200) * 2, mx, my, 1, nil, nil, 126);
  lib.PicLoadCache(0, (War.wid2 + 200) * 2, mx + 126, my, 1, nil, nil, 126);
  if War.CityPosition == 0 then
    lib.PicLoadCache(0, 281 * 2, mx, my, 1, nil, nil, 48);
  else
    lib.PicLoadCache(0, 282 * 2, mx + 204, my, 1, nil, nil, 48);
  end
  for bid, bd in ipairs(War.Building) do
    if bd.id == 2 and bd.live then
      dx, dy = GetMiniMapXY(bd.x, bd.y);
      lib.PicLoadCache(0, 295 * 2, dx, dy, 0, nil, nil, 12);
    end
  end
  for wid, wp in ipairs(War.Person) do
    if wp["存活"] > 0 then
      dx, dy = GetMiniMapXY(wp["移动X"], wp["移动Y"]);
      lib.PicLoadCache(0, (291 + wp["敌我"]) * 2, dx, dy, 0, nil, nil, 12);
      --lib.PicLoadCache(2, (6000 + wp.p["容貌"]) * 2, dx, dy, 0, nil, nil, 24);
      --lib.PicLoadCache(2, (6000 + wp.p["容貌"]) * 2, dx, dy, 4 + 8, nil, RGB(111,0,0), 24);
    end
  end
end
WarArmySelection = {
  status = 0, -- 0 normal, 1 on holding
  hx = 0,
  hy = 0,
  rx = 0,
  ry = 0,
  
  armyList = {},
  num = 0,
  curPerson = 0,
  showRight = true,
  ox = 0,
  oy = 0,
  width = 208,
  height = 256,
};
function WarArmySelection:event()
  local oldnum = self.num;
  self.curPerson = 0;
  if between(self.num, 2, 6) then
    local yidx = self.num - math.floor((CC.ScreenH - 8 - MOUSE.y) / 40);
    if between(yidx, 1, self.num) then
      if MOUSE.CLICK(self.ox + 8, self.oy + 8 + 40 * (yidx - 1), self.ox + self.width - 8, self.oy + 8 + 40 * (yidx - 1) + 36) then
        self.armyList = {self.armyList[yidx]};
        PlayWavE(0)
      elseif MOUSE.IN(self.ox + 8, self.oy + 8 + 40 * (yidx - 1), self.ox + self.width - 8, self.oy + 8 + 40 * (yidx - 1) + 36) then
        self.curPerson = self.armyList[yidx];
      end
    end
  elseif self.num > 6 then
    local yidx = self.num - math.floor((CC.ScreenH - 8 - MOUSE.y) / 26);
    if between(yidx, 1, self.num) then
      if MOUSE.CLICK(self.ox + 8, self.oy + 8 + 26 * (yidx - 1), self.ox + self.width - 8, self.oy + 8 + 26 * (yidx - 1) + 24) then
        self.armyList = {self.armyList[yidx]};
        PlayWavE(0)
      elseif MOUSE.IN(self.ox + 8, self.oy + 8 + 26 * (yidx - 1), self.ox + self.width - 8, self.oy + 8 + 26 * (yidx - 1) + 24) then
        self.curPerson = self.armyList[yidx];
      end
    end
  end
  
  --select target
		local sx,sy=GetScreenXY(War.mx, War.my);
		if MOUSE.CLICK(sx-16,sy-8,sx+16,sy+8) then
      for i, wid in ipairs(self.armyList) do
        if War.Person[wid]["敌我"] == 0 then
          War.Person[wid].AIConfig.tx, War.Person[wid].AIConfig.ty = War.mx, War.my;
        end
      end
		end
    
  if MOUSE.HOLD(self.ox, self.oy, self.ox + self.width, self.oy + self.height) then
  elseif self.status == 0 then
    if MOUSE.HOLD(0, 0, CC.ScreenW, CC.ScreenH) then
      self.status = 1;
      self.hx, self.hy = MOUSE.hx + War.x_off, MOUSE.hy + War.y_off;
      self.rx, self.ry = self.hx, self.hy;
    end
  else
    if MOUSE.CLICK(0, 0, CC.ScreenW, CC.ScreenH) then
      self.status = 0;
      self.armyList = {};
      for wid, wp in ipairs(War.Person) do
        if wp.show and wp["存活"] > 0 then
          local sx, sy = GetScreenXY(wp["坐标X"], wp["坐标Y"]);
          if between(sx + War.x_off, self.hx, self.rx) and between(sy + War.y_off, self.hy, self.ry) then
            table.insert(self.armyList, wid);
          end
        end
      end
    elseif MOUSE.HOLD(0, 0, CC.ScreenW, CC.ScreenH) then
      self.rx, self.ry = MOUSE.x + War.x_off, MOUSE.y + War.y_off;
    else
      self.status = 0;
    end
  end
  
  
  for i = #self.armyList, 1, -1 do
    local wid = self.armyList[i];
    local wp = War.Person[wid];
    if not wp.show then
      table.remove(self.armyList, i);
    end
  end
  if self.showRight then
    self.ox = CC.ScreenW - self.width;
  else
    self.ox = 0;
  end
  self.num = #self.armyList;
  if self.num > 10 then self.num = 10 end
  if oldnum ~= self.num then
    self.curPerson = 0;
    if self.num < 1 then
      
    elseif self.num == 1 then
      self.height = 256;
    elseif self.num < 7 then
      self.height = self.num * 40 + 16;
    else
      self.height = self.num * 26 + 16;
    end
    self.oy = CC.ScreenH - self.height;
  end
end
function WarArmySelection:redrawAreaSelection()
  if self.status == 1 then  --area Selection
    local hx, hy = self.hx - War.x_off, self.hy - War.y_off;
    local rx, ry = self.rx - War.x_off, self.ry - War.y_off;
    if hx > rx then hx, rx = rx, hx end
    if hy > ry then hy, ry = ry, hy end
    lib.Background(hx, hy, rx, ry, 128, 8438015)
    lib.DrawRect(hx, hy, rx, ry, 8438015);
    lib.DrawRect(hx - 1, hy - 1, rx + 1, ry + 1, 8438015);
  end
end
function WarArmySelection:redrawArmySelection()
  local color;
  if self.num < 1 then
    return;
  elseif self.num == 1 then
    LoadPicEnhance(115, self.ox, self.oy, self.width, self.height);
    local wp = War.Person[self.armyList[1]];
    local sx = self.ox + 8;
    local sy = self.oy + 8;
    if wp["敌我"] == 0 then
      color = 8438015;
    else
      color = 16291992;
    end
    DrawStringEnhance(sx + 48, sy, wp.p["名称"], C_Name, 24, 0.5);
    lib.PicLoadCache(4, (276 + 4 * wp.bz["兵系"] + 2 * wp["敌我"]) * 2, sx + 90, sy + 2, 1);
    DrawStringEnhance(sx + 112, sy, "" .. wp["兵力"], C_WHITE, 24);
    sy = sy + 28;
    lib.PicLoadCache(2,(wp.p["容貌"] + 2000)*2, sx, sy, 1);
    sx = sx + 90;
    DrawStringEnhance(sx, sy, "兵种: [white]" .. wp.bz["名称"], C_Name, 16);
    sy = sy + 18;
    DrawStringEnhance(sx, sy, "武力: [white]" .. wp.p["武力"], C_Name, 16);
    sy = sy + 18;
    DrawStringEnhance(sx, sy, "智谋: [white]" .. wp.p["智谋"], C_Name, 16);
    sy = sy + 18;
    DrawStringEnhance(sx, sy, "统率: [white]" .. wp.p["统率"], C_Name, 16);
    sy = sy + 18;
    DrawStringEnhance(sx, sy, "肉搏: [white]" .. wp["攻击力"], C_Name, 16);
    sy = sy + 18;
    DrawStringEnhance(sx, sy, "远程: [white]" .. wp["远程攻击力"], C_Name, 16);
    sy = sy + 18;
    DrawStringEnhance(sx, sy, "守备: [white]" .. wp["防御力"], C_Name, 16);
  elseif self.num < 7 then
    LoadPicEnhance(115, self.ox, self.oy, self.width, self.height);
    for i, wid in ipairs(self.armyList) do
      local sx = self.ox + 8;
      local sy = self.oy + (i - 1) * 40 + 8;
      local wp = War.Person[wid];
      if wp["敌我"] == 0 then
        color = 8438015;
      else
        color = 16291992;
      end
      if wid == self.curPerson then
        lib.Background(sx, sy, sx + 192, sy + 36, 192);
      end
      lib.PicLoadCache(2,(wp.p["容貌"] + 6000)*2, sx, sy, 1, nil, nil, 36);
      sx = sx + 44;
      DrawStringEnhance(sx, sy, wp.p["名称"], C_Name, 18);
      lib.PicLoadCache(4, (276 + 4 * wp.bz["兵系"] + 2 * wp["敌我"]) * 2, sx + 72, sy, 1);
      DrawStringEnhance(sx + 92, sy, "" .. wp["兵力"], C_WHITE, 18);
      sy = sy + 18;
      DrawStringEnhance(sx, sy, "攻击    守备", C_Name, 18);
      DrawStringEnhance(sx + 38, sy, string.format("%3d     %3d", math.max(wp["攻击力"], wp["远程攻击力"]), wp["防御力"]), C_WHITE, 18);
    end
  else
    LoadPicEnhance(115, self.ox, self.oy, self.width, self.height);
    local totalNum = #self.armyList;
    for i, wid in ipairs(self.armyList) do
      local sx = self.ox + 8;
      local sy = self.oy + (i - 1) * 26 + 8;
      local wp = War.Person[wid];
      if wp["敌我"] == 0 then
        color = 8438015;
      else
        color = 16291992;
      end
      if wid == self.curPerson then
        lib.Background(sx, sy, sx + 192, sy + 24, 192);
      end
      sx = sx + 8;
      if i == 10 and totalNum > 10 then
        DrawStringEnhance(sx + 24, sy + 2, "及其他" .. (totalNum - 9) .. "人", C_WHITE, 20);
        break;
      else
        lib.PicLoadCache(2,(wp.p["容貌"] + 6000)*2, sx, sy, 1, nil, nil, 24);
        DrawStringEnhance(sx + 24, sy + 2, wp.p["名称"], C_Name, 20);
        lib.PicLoadCache(4, (276 + 4 * wp.bz["兵系"] + 2 * wp["敌我"]) * 2, sx + 100, sy + 2, 1);
        DrawStringEnhance(sx + 120, sy + 2, "" .. wp["兵力"], C_WHITE, 20);
      end
    end
  end
end
function WarArmySelection:redrawArmyPath()
  for i, wid in ipairs(self.armyList) do
    if War.Person[wid]["敌我"] == 0 then
      War_DrawPath(wid);
    end
  end
end
-- Functions
function War_DrawArmy()
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
	local tx={}
	local ty={}
	local tpic={}
	local tframe={}
	local twidth={}
	local torder={}
	local tz={}
	local num=0;
	for i,wp in ipairs(War.Person) do
		if wp.show then
			local ox,oy=wp["坐标X"],wp["坐标Y"];
			if wp["动作"]==1 then	--移动
				ox,oy=ox+(wp["移动X"]-ox)*wp["动作进度"]/wp["动作进度最大值"],oy+(wp["移动Y"]-oy)*wp["动作进度"]/wp["动作进度最大值"];
			end
			wp["屏幕X"],wp["屏幕Y"]=GetScreenXY(ox,oy);
			if between(wp["屏幕X"],-64,CC.ScreenW+64) then
				local width=wp.bz["贴图尺寸"];
				local pic=(wp["贴图"]+10*wp["方向"])*2;
				local frame=0;
				if wp["动作"]==0 then
					frame=War.Frame;
				elseif wp["动作"]==1 then
					--frame=War.Frame;
					frame=math.min(7,(math.floor(8*wp["动作进度"]/wp["动作进度最大值"])));
					pic=pic+2;
				elseif wp["动作"]==2 then
					frame=math.min(7,(math.floor(8*wp["动作进度"]/wp["动作进度最大值"])));
					pic=pic+4;
				elseif wp["动作"]==3 then
					frame=math.min(7,(math.floor(12*wp["动作进度"]/wp["动作进度最大值"])));
					pic=pic+8;
				end
				local n=math.floor(wp["兵力"]/1000)
				if n>16 then
					n=16
				elseif n<3 then
					n=3;
				end
				if wp.bz["巨型"]>0 then
					n=1;
				end
				for j,v in ipairs(zx[n]) do
					local sx,sy=GetScreenXY(ox+v.x*0.75,oy+v.y*0.75);
					sx=math.floor(sx);
					sy=math.floor(sy);
					sx=sx-width/2;
					sy=sy-width/2-14;
					
					num=num+1;
					tx[num]=sx;
					ty[num]=sy;
					tpic[num]=pic;
					tframe[num]=frame;
					twidth[num]=width;
					tz[num]=(oy+v.y)*128+ox+v.x;
					torder[num]=num;
				end
			end
		end
	end
	table.sort(torder,	function(a,b)
							return tz[a]<tz[b];
						end)
	for i,v in ipairs(torder) do
		lib.SetClip(tx[v],ty[v],tx[v]+twidth[v],ty[v]+twidth[v]);
		lib.PicLoadCache(1,tpic[v],tx[v]-twidth[v]*tframe[v],ty[v],1);
		lib.SetClip(0,0,0,0);
	end
	for id,wp in ipairs(War.Person) do
		if wp.show then
      local sx, sy= wp["屏幕X"], wp["屏幕Y"];
			--旗帜
			if between(sx, -64, CC.ScreenW + 64) then
				WarDrawFlag(sx-1,sy-64,wp.force_id,wp.flag_id,wp["方向"],(War.Frame%4))
			end
			--弓箭轨迹
      local n=math.floor(wp["兵力"]/1000)
      if n>16 then
        n=16
      elseif n<3 then
        n=3;
      end
      if wp.bz["巨型"]>0 then
        n=1;
      end
			if wp["动作"]==3 and wp["动作进度"]/wp["动作进度最大值"]>1/3 then
				for i,v in pairs(zx[n]) do
          sx, sy = GetScreenXY(wp["坐标X"] + v.x, wp["坐标Y"] + v.y);
					local dx,dy=GetScreenXY(wp["目标X"]+v.x*1.5,wp["目标Y"]+v.y*1.5);
					local f=math.min(1,1.5*wp["动作进度"]/wp["动作进度最大值"]-0.5+i/n/4);
					local h=80;
					local ax=sx+(dx-sx)*f;
					local ay=sy+(dy-sy)*f-h+h*4*(f-0.5)^2-24;
					if between(ax,-32,CC.ScreenW+32) then
						local apic=War_GetArrowPic((dx-sx),(dy-sy)+h*8*(f-0.5));
						lib.PicLoadCache(0,apic*2,ax,ay,1);
					end
				end
			end
    end
  end
	for id,wp in ipairs(War.Person) do  --慢 
		if wp.show then
      local sx, sy= wp["屏幕X"], wp["屏幕Y"];
      --hp
			if between(sx, -64, CC.ScreenW + 64) then
        War_DrawStateBar(id, sx, sy);
      end
    end
  end
	for id,wp in ipairs(War.Person) do
		if wp.show then
      local sx, sy= wp["屏幕X"], wp["屏幕Y"];
			--hurt_str
			for i=#wp.hurt_str_dy,1,-1 do
        if between(sx, -64, CC.ScreenW + 64) then
					DrawStringEnhance(sx,sy-16-wp.hurt_str_dy[i],wp.hurt_str[i],C_WHITE,20,0.5,nil,nil,640-8*wp.hurt_str_dy[i]);
				end
				if wp.hurt_str_dy[i]>24 then
					table.remove(wp.hurt_str,i);
					table.remove(wp.hurt_str_dy,i);
				else
					wp.hurt_str_dy[i]=wp.hurt_str_dy[i] + 1;
				end
			end
    end
  end
	for id,wp in ipairs(War.Person) do
		if wp.show then
      local sx, sy= wp["屏幕X"], wp["屏幕Y"];
      --War Special Atk
      if wp.SpecialAction.id > 0 then
        if between(sx, -64, CC.ScreenW + 64) then
          lib.PicLoadCache(0, wp.SpecialAction.pic * 2, sx, sy, 4, nil, wp.SpecialAction.color, 192);
        end
        if wp.SpecialAction.timer <= 4 or wp.SpecialAction.timer >= 28 then
          wp.SpecialAction.pic = wp.SpecialAction.pic + 1;
        end
        wp.SpecialAction.timer = wp.SpecialAction.timer - 1;
        if wp.SpecialAction.timer <= 0 then
          if wp.SpecialAction.id == 21 then
            wp.show = false;
          end
          wp.SpecialAction.id = 0;
        end
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
function War_DrawStateBar(wid,x,y)
	local wp = War.Person[wid];
  y = y + 12;
	lib.PicLoadCache(4, (260 + 2 * wp["敌我"]) * 2, x, y, 0, 0, 0, 64);
	lib.PicLoadCache(2, (wp.p["容貌"] + 6000) * 2, x - 24, y, 0, 0, 0, 26);
	DrawStringEnhance(x + 9, y, "" .. wp["兵力"], C_WHITE, 15, 0.5, 0.5);
end
function War_DrawMultiStateBar()
	local xoff = War.x_off % 28
	local yoff = War.y_off % 34
	local tmap = {}
	local maxx, maxy = (math.floor(2016 / 37)), (math.floor(768 / 34))
	for i = -1, maxx + 1 do
		tmap[i] = {};
		for j = -1, maxy + 1 do
			tmap[i][j] = 0;
		end
	end
	local t_show = {};
	for i, wp in ipairs(War.Person) do
		if wp["存活"] > 0 then
			local ox , oy = math.floor((wp["屏幕X"] + War.x_off) / 37), math.floor((wp["屏幕Y"] + War.y_off) / 34);
			if between(ox, 0, maxx) and between(oy, 0, maxy) then
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
  local xyoff = {
    --right up
    [0] = {-1,1, -2,2, -2,1, -1,2, -3,3 -3,2, -2,3, -4,4, -4,3, -3,4, -4,2, -2,4, -5,5, -5,4, -4,5, -5,3, -3,5, -6,6, -6,5, -5,6, -6,4, -4,6, -7,7, -7,6, -6,7, -7,5, -5,7, -7,4, -4,7, -8,8, -8,7, -7,8, -8,6, -6,8, -8,5, -5,8   },
    --right
    [1] = {-1,0, -2,0, -3,0, -3,-1, -3,1, -4,0, -4,-1, -4,1, -5,0, -5,-1, -5,1, -5,-2, -5,2, -6,0, -6,-1, -6,1, -6,-2, -6,2, -6,-3, -6,3, -7,0, -7,-1, -7,1, -7,-2, -7,2, -7,-3, -7,3, -8,0, -8,-1, -8,1, -8,-2, -8,2, -8,-3, -8,3, -8,-4, -8,4  },
    --right down
    [2] = {-1,-1, -2,-2, -2,-1, -1,-2, -3,-3 -3,-2, -2,-3, -4,-4, -4,-3, -3,-4, -4,-2, -2,-4, -5,-5, -5,-4, -4,-5, -5,-3, -3,-5, -6,-6, -6,-5, -5,-6, -6,-4, -4,-6, -7,-7, -7,-6, -6,-7, -7,-5, -5,-7, -7,-4, -4,-7, -8,-8, -8,-7, -7,-8, -8,-6, -6,-8, -8,-5, -5,-8   },
    --down
    [3] = {0,-1, 0,-2, 0,-3, -1,-3, 1,-3, 0,-4, -1,-4, 1,-4, 0,-5, -1,-5, 1,-5, -2,-5, 2,-5, 0,-6, -1,-6, 1,-6, -2,-6, 2,-6, -3,-6, 3,-6, 0,-7, -1,-7, 1,-7, -2,-7, 2,-7, -3,-7, 3,-7, 0,-8, -1,-8, 1,-8, -2,-8, 2,-8, -3,-8, 3,-8, -4,-8, 4,-8  },
    --left down
    [4] = {1,-1, 2,-2, 2,-1, 1,-2, 3,-3, 3,-2, 2,-3, 4,-4, 4,-3, 3,-4, 4,-2, 2,-4, 5,-5, 5,-4, 4,-5, 5,-3, 3,-5, 6,-6, 6,-5, 5,-6, 6,-4, 4,-6, 7,-7, 7,-6, 6,-7, 7,-5, 5,-7, 7,-4, 4,-7, 8,-8, 8,-7, 7,-8, 8,-6, 6,-8, 8,-5, 5,-8   },
    --left
    [5] = {1,0, 2,0, 3,0, 3,-1, 3,1, 4,0, 4,-1, 4,1, 5,0, 5,-1, 5,1, 5,-2, 5,2, 6,0, 6,-1, 6,1, 6,-2, 6,2, 6,-3, 6,3, 7,0, 7,-1, 7,1, 7,-2, 7,2, 7,-3, 7,3, 8,0, 8,-1, 8,1, 8,-2, 8,2, 8,-3, 8,3, 8,-4, 8,4  },
    --left up
    [6] = {1,1, 2,2, 2,1, 1,2, 3,3, 3,2, 2,3, 4,4, 4,3, 3,4, 4,2, 2,4, 5,5, 5,4, 4,5, 5,3, 3,5, 6,6, 6,5, 5,6, 6,4, 4,6, 7,7, 7,6, 6,7, 7,5, 5,7, 7,4, 4,7, 8,8, 8,7, 7,8, 8,6, 6,8, 8,5, 5,8   },
    --up
    [7] = {0,1, 0,2, 0,3, -1,3, 1,3, 0,4, -1,4, 1,4, 0,5, -1,5, 1,5, -2,5, 2,5, 0,6, -1,6, 1,6, -2,6, 2,6, -3,6, 3,6, 0,7, -1,7, 1,7, -2,7, 2,7, -3,7, 3,7, 0,8, -1,8, 1,8, -2,8, 2,8, -3,8, 3,8, -4,8, 4,8  },
  }
	for i,wp in ipairs(War.Person) do
		if wp.show then
			local ox, oy = math.floor((wp["屏幕X"] + War.x_off) / 37), math.floor((wp["屏幕Y"] + War.y_off) / 34);
      if 2 == wp["动作"] or 3 ==wp["动作"] then
        local off = xyoff[wp["方向"]];
        --[[if 0 == wp["方向"] then
          ox = ox - 1;
        elseif 1 == wp["方向"] then
          ox = ox - 2;
        elseif 2 == wp["方向"] then
          ox = ox - 1;
        end]]--
        for idx = 1, #off, 2 do
          local tx, ty = ox + off[idx], oy + off[idx + 1];
          if between(tx, 1, maxx - 1) and between(ty, 0, maxy - 1) and tmap[tx][ty] == 0 and tmap[tx+1][ty] == 0 and tmap[tx-1][ty] == 0 then
            tmap[tx][ty] = 1;
            tmap[tx+1][ty] = 1;
            tmap[tx-1][ty] = 1;
            ox, oy = tx * 37 - War.x_off, ty * 34 - War.y_off;
            break;
          end
        end
      else
        ox, oy = wp["屏幕X"] - 56, wp["屏幕Y"] - 96;
      end
      if wp["状态X"] == -1 then
        wp["状态X"], wp["状态Y"] = ox, oy;
      end
      if wp["状态X"] > ox then
        wp["状态X"] = limitX(wp["状态X"] - 16, ox, wp["状态X"]);
      elseif wp["状态X"] < ox then
        wp["状态X"] = limitX(wp["状态X"] + 16, wp["状态X"], ox);
      end
      if wp["状态Y"] > oy then
        wp["状态Y"] = limitX(wp["状态Y"] - 16, oy, wp["状态Y"]);
      elseif wp["状态Y"] < ox then
        wp["状态Y"] = limitX(wp["状态Y"] + 16, wp["状态Y"], oy);
      end
		end
	end
	local wid = 0;
	if wid>0 then
		War_DrawStatus(wid, sx, sy);
	end
end
function War_DrawMultiStateBar1()
	local showall=false;
	local sx,sy;
	local s_wid=0;
	
	for wid,wp in ipairs(War.Person) do
		if wp.show then
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
		if wp.show then
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
function War_DrawStatus()
  local ox = CC.ScreenW - 208;
  local oy = CC.ScreenH - 256;
  local n = #WarAreaSelection.armySelect;
  if n < 1 then
    return;
  end
	--208/108
  LoadPicEnhance(115, ox, oy, 208, 256);
  if n == 1 then
    local wp = War.Person[WarAreaSelection.armySelect[1]];
    local sx = ox + 8;
    local sy = oy + 8;
    DrawStringEnhance(sx + 48, sy, wp.p["名称"], C_Name, 24, 0.5);
    lib.PicLoadCache(4, (276 + 4 * wp.bz["兵系"] + 2 * wp["敌我"]) * 2, sx + 90, sy + 2, 1);
    DrawStringEnhance(sx + 112, sy, "" .. wp["兵力"], C_WHITE, 24);
    sy = sy + 28;
    lib.PicLoadCache(2,(wp.p["容貌"] + 2000)*2, sx, sy, 1);
    sx = sx + 90;
    DrawStringEnhance(sx, sy, "兵种: [white]" .. wp.bz["名称"], C_Name, 16);
    sy = sy + 18;
    DrawStringEnhance(sx, sy, "武力: [white]" .. wp.p["武力"], C_Name, 16);
    sy = sy + 18;
    DrawStringEnhance(sx, sy, "智谋: [white]" .. wp.p["智谋"], C_Name, 16);
    sy = sy + 18;
    DrawStringEnhance(sx, sy, "统率: [white]" .. wp.p["统率"], C_Name, 16);
    sy = sy + 18;
    DrawStringEnhance(sx, sy, "肉搏: [white]" .. wp["攻击力"], C_Name, 16);
    sy = sy + 18;
    DrawStringEnhance(sx, sy, "远程: [white]" .. wp["远程攻击力"], C_Name, 16);
    sy = sy + 18;
    DrawStringEnhance(sx, sy, "守备: [white]" .. wp["防御力"], C_Name, 16);
    sy = sy + 18;
  elseif n <= 5 then
    for i, wid in ipairs(WarAreaSelection.armySelect) do
      local sx = ox + 8;
      local sy = oy + (i - 1) * 72 + 8;
      local wp = War.Person[wid];
      lib.PicLoadCache(2,(wp.p["容貌"] + 6000)*2, sx, sy, 1, nil, nil, 64);
      sx = sx + 64;
      DrawStringEnhance(sx, sy, wp.p["名称"], C_Name, 16);
      DrawStringEnhance(sx + 64, sy, wp.bz["名称"], C_WHITE, 16);
      sy = sy + 16;
      DrawStringEnhance(sx, sy, "兵力 [white]" .. wp["兵力"], C_Name, 16);
      sy = sy + 16;
      DrawStringEnhance(sx, sy, "武   智   统", C_Name, 16);
      DrawStringEnhance(sx + 16, sy, wp.p["武力"] .. "   " .. wp.p["智谋"] .. "   " .. wp.p["统率"], C_WHITE, 16);
      sy = sy + 16;
      DrawStringEnhance(sx, sy, "攻击    守备", C_Name, 16);
      DrawStringEnhance(sx + 32, sy, math.max(wp["攻击力"], wp["远程攻击力"]) .. "      " .. wp["防御力"], C_WHITE, 16);
    end
  else
    for i, wid in ipairs(WarAreaSelection.armySelect) do
      local sx = ox + 16;
      local sy = oy + (i - 1) * 26 + 8;
      local wp = War.Person[wid];
      lib.PicLoadCache(2,(wp.p["容貌"] + 6000)*2, sx, sy, 1, nil, nil, 24);
      DrawStringEnhance(sx + 24, sy + 2, wp.p["名称"], C_Name, 20);
      lib.PicLoadCache(4, (276 + 4 * wp.bz["兵系"] + 2 * wp["敌我"]) * 2, sx + 100, sy + 2, 1);
      DrawStringEnhance(sx + 120, sy + 2, "" .. wp["兵力"], C_WHITE, 20);
    end
  end
end
function War_GetArrowPic(dx,dy)
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
function War_DrawBuindling()
  local zx = {};
	zx[9]={		{x=0,y=-1.2},{x=-0.6,y=-0.6},{x=0.6,y=-0.6},
				{x=-1.2,y=0},{x=0,y=0},{x=1.2,y=0},
				{x=-0.6,y=0.6},{x=0.6,y=0.6},{x=0,y=1.2}	}	--9
  --Building
  for i, bd in ipairs(War.Building) do
    local sx, sy = GetScreenXY(bd.x, bd.y);
    if 1 == bd.id then --城门
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
      lib.PicLoadCache(4, 275*2, sx, sy, 2+4, 256,RGB(48,255,12));
      sy = sy - 64;
			lib.PicLoadCache(4, 264 * 2, sx, sy, 0);
      lib.FillColor(sx - 46, sy - 4, sx + 46, sy + 4, C_RED);
      DrawStringEnhance(sx, sy, '[B]800', C_WHITE, 16, 0.5, 0.5);
    elseif 2 == bd.id then --砦
      if between(sx, -128, CC.ScreenW) then
        lib.PicLoadCache(0, 151 * 2, sx, sy);
      end
      lib.PicLoadCache(4, 275*2, sx, sy, 2+4, 256,RGB(48,255,12));
      sy = sy - 32;
			lib.PicLoadCache(4, 264 * 2, sx, sy, 0);
      lib.FillColor(sx - 46, sy - 4, sx + 46, sy + 4, C_RED);
      DrawStringEnhance(sx, sy, '[B]800', C_WHITE, 16, 0.5, 0.5);
    end
    
    --弓箭轨迹
    if bd["目标ID"] > 0 and bd["动作进度"]/bd["动作进度最大值"] > 1/3 then
      local n = 9;
      for ii, v in pairs(zx[n]) do
        sx, sy = GetScreenXY(bd.x + v.x*1, bd.y + v.y*1);
        local dx, dy = GetScreenXY(bd["目标X"] + v.x*1.5, bd["目标Y"] + v.y*1.5);
        local f = math.min(1, 1.5*bd["动作进度"]/bd["动作进度最大值"] - 0.5 + ii/n/4);
        local h = 80;
        local ax = sx + (dx-sx)*f;
        local ay = sy + (dy-sy)*f - h + h*4*(f-0.5)^2 - 24;
        if between(ax, -32, CC.ScreenW + 32) then
          local apic = 20 + War_GetArrowPic((dx - sx), (dy - sy) + h*8*(f - 0.5));
          lib.PicLoadCache(0, apic*2, ax, ay, 1);
        end
      end
    end
  end
end
function War_DrawMap()
	lib.FillColor(0,0,0,0);
	if War.x_off<1008 then
		lib.PicLoadCache(0,War.wid1*2,-War.x_off,120-War.y_off,1,255);
	end
	if 1008-War.x_off<CC.ScreenW then
		lib.PicLoadCache(0,(War.wid2)*2,1008-War.x_off,120-War.y_off,1,255);
	end
	if War.y_off<120 then
		lib.PicLoadCache(0,102*2,-War.x_off,-War.y_off,1,255);
	end
  
  --Shadow
  for x, v in pairs(War.MAP) do
    for y, vv in pairs(v) do
      vv.shadow = 0;
      vv.wid = 0;
    end
  end
  --lib.Debug('>> ' .. (os.clock() - t1))
  for wid, wp in ipairs(War.Person) do
    if wp["存活"] > 0 then
      local ox, oy = wp["移动X"], wp["移动Y"];
      War.MAP[ox][oy].wid = wid;
      if wp["敌我"] == 0 then
        for x = math.max(0, ox - 10), math.min(127, ox + 10) do
          for y = math.max(0, oy - 10), math.min(127, oy + 10) do
            if War.MAP[x][y] then-- and (ox - x)^2 + (oy - y)^2 < 100 then
              War.MAP[x][y].shadow = 1;
            end
          end
        end
      end
    end
  end
  
  --[[
	for x = 0, 127 do
		for y = 0, 127 do
      if War.MAP[x][y].shadow > 0 then
        local sx, sy = GetScreenXY(x, y);
        if between(sx, -16, CC.ScreenW+16) and between(sy, -8, CC.ScreenH+8) then
          lib.PicLoadCache(4,270*2,sx,sy,8);
        end
      end
		end
	end
	]]--
  --AI find path image
  
	--MovePath
	for i,wp in ipairs(War.Person) do
		if wp.show and wp["选中"]>0 then
      War_DrawAIPath(i);
			War_DrawPath(i);
		end
	end
  WarArmySelection:redrawArmyPath()
	--当前位置
  if War.MAP[War.mx] and War.MAP[War.mx][War.my] then
    local dx, dy = GetScreenXY(War.mx, War.my);
    lib.PicLoadCache(4, 270*2, dx, dy);
  end
  War_DrawBuindling();
	War_DrawArmy();
  WarArmySelection:redrawAreaSelection();
	War_DrawTalk();
  WarArmySelection:redrawArmySelection()
  --War_DrawStatus(1);
	--War_DrawMultiStateBar();
	
	
	if War.MAP[War.mx] and War.MAP[War.mx][War.my] then
		if War.tBrush[War.MAP[War.mx][War.my].dx]~=nil then
			DrawStringEnhance(420,24,"[B]当前地形: "..War.tBrush[War.MAP[War.mx][War.my].dx],C_WHITE,24);
		else
			DrawStringEnhance(420,24,"[B]当前地形: "..War.MAP[War.mx][War.my].dx,C_WHITE,24);
		end
		DrawStringEnhance(420,0,"[B]XY: "..War.mx.." , "..War.my,C_WHITE,24);
	end
	--[[for i=1,math.min(8,#War.AI_Pool) do
		local wid=War.AI_Pool[i];
		local pid=War.Person[wid]["人物ID"]
		DrawStringEnhance(CC.ScreenW,80+i*24,"[B]"..JY.Person[pid]["名称"],C_WHITE,24,1);
	end]]--
	
end
function War_DrawMap1()
	lib.FillColor(0,0,0,0);
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
function War_DrawAIPath(wid)
  for i,v in pairs(War.Person[wid].AISearch) do
    --lib.Debug('War_DrawAIPath' .. i .. ' , ' .. v)
    local x, y = (math.floor(i/128)),i%128;
    local dx ,dy = GetScreenXY(x,y);
    lib.PicLoadCache(4, 270*2, dx, dy, 2, 96);
    lib.PicLoadCache(4, 275*2, dx, dy, 2+4, 256-v,RGB(48,255,12));
  end
end

function War_PlayWav()
	local Wav_moving=0;
	local Wav_fight=0;
	local Wav_atk1=0;
	local Wav_atk2=0;
	for i,wp in ipairs(War.Person) do
		if wp.show then
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
			lib.PlayWAV(CONFIG.CurrentPath.."sound/se_b004.wav");
			War.WavTimer=math.floor(4840/CC.FrameNum)-0;
		elseif Wav_fight>12 then
			lib.PlayWAV(CONFIG.CurrentPath.."sound/se_b003.wav");
			War.WavTimer=math.floor(7527/CC.FrameNum)-0;
		elseif Wav_fight>8 then
			lib.PlayWAV(CONFIG.CurrentPath.."sound/se_b002.wav");
			War.WavTimer=math.floor(7261/CC.FrameNum)-0;
		elseif Wav_fight>4 then
			lib.PlayWAV(CONFIG.CurrentPath.."sound/se_b001.wav");
			War.WavTimer=math.floor(5495/CC.FrameNum)-0;
		elseif Wav_fight>2 then
			lib.PlayWAV(CONFIG.CurrentPath.."sound/se_b000.wav");
			War.WavTimer=math.floor(6410/CC.FrameNum)-0;
		else
			War.WavTimer=20;
		end
	end
	if Wav_moving>0 and Wav_fight<4 then
		lib.PlayWAV(CONFIG.CurrentPath.."sound/se_v000a.wav");
	end
	if War.FrameT==32 then
		if Wav_atk1>0 then
			lib.PlayWAV(string.format(CONFIG.CurrentPath.."sound/se_a%03d.wav",math.random(0,2)));
		end
	elseif (War.FrameT%16==8 and Wav_atk2>4) or (War.FrameT%24==8 and Wav_atk2>2) or (War.FrameT%32==8 and Wav_atk2>1) or (War.FrameT==8 and Wav_atk2>0) then
		if Wav_atk2>0 then
			lib.PlayWAV(string.format(CONFIG.CurrentPath.."sound/se_a%03d.wav",math.random(8,10)));
		end
	end
end
function War_AutoAction()
  --building
  for bid, bd in ipairs(War.Building) do
    if bd.live and 2 == bd.id then
      if bd["动作进度"] == bd["动作进度最大值"] then
        --close old action
        local eid = bd["目标ID"];
        if eid > 0 and War.Person[eid]["存活"] > 0 and math.abs(bd["目标X"] - War.Person[eid]["坐标X"]) < 2 and math.abs(bd["目标Y"] - War.Person[eid]["坐标Y"]) < 2 then
          local hurt = 111;
          War.Person[eid]["兵力"] = War.Person[eid]["兵力"] - hurt;
          table.insert(War.Person[eid].hurt_str, 1, "-" .. hurt);
          if #War.Person[eid].hurt_str_dy == 0 or War.Person[eid].hurt_str_dy[1] > 0 then
            table.insert(War.Person[eid].hurt_str_dy, 1, 0);
          else
            table.insert(War.Person[eid].hurt_str_dy, 1, War.Person[eid].hurt_str_dy[1] - 2);
          end
          War_SetAttrib(eid);
          if War.Person[eid]["兵力"] <= 0 then
            War.Person[eid]["存活"] = 0;
            War.Person[eid].SpecialAction.id = 21;
            War.Person[eid].SpecialAction.pic = 1500;
            War.Person[eid].SpecialAction.timer = 32;
          end
        end
        --start new action
        bd["目标ID"] = 0;
        bd["动作进度"] = 0;
        eid = bd.target;
        if eid > 0 then
          if true then  --can atk
            bd["目标ID"] = eid;
            if War.Person[eid]["动作"] == 1 and #War.Person[eid].movepath > 0 then
              bd["目标X"], bd["目标Y"] = War.Person[eid].movepath[1].x, War.Person[eid].movepath[1].y;
            else
              bd["目标X"], bd["目标Y"] = War.Person[eid]["移动X"], War.Person[eid]["移动Y"];
            end
          end
        end
      else
				bd["动作进度"] = bd["动作进度"] + 1;
      end
    end
  end
	--根据AI，人物自行行动
	for wid,wp in pairs(War.Person) do
		if wp["存活"]>0 then
      if wp.dz < 1300 then
        wp.dz = wp.dz + wp.dzinc;
      end
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
			if wp["动作进度"] == wp["动作进度最大值"] then
        --close old action
				if wp["动作"] == 1 then	--移动
					--坐标修改
					wp["坐标X"],wp["坐标Y"] = wp["移动X"],wp["移动Y"];
				elseif wp["动作"]==2 or wp["动作"]==3 then
          local eid = wp["目标ID"];
					if eid>0 and War.Person[eid]["存活"] > 0 and math.abs(wp["目标X"] - War.Person[eid]["坐标X"]) < 2 and math.abs(wp["目标Y"] - War.Person[eid]["坐标Y"]) < 2 then --AI_CanAtk(wid,eid,wp["坐标X"],wp["坐标Y"])==wp["动作"]-1 then
						local hurt = War_CalHurt(wid, eid);
            if hurt > 0 then
              if between(wp.SpecialAction.id, 1, 10) then
                table.insert(War.Person[eid].hurt_str, 1, "[Red]-" .. hurt);
                if #War.Person[eid].hurt_str_dy == 0 or War.Person[eid].hurt_str_dy[1] > 0 then
                  table.insert(War.Person[eid].hurt_str_dy, 1, 0);
                else
                  table.insert(War.Person[eid].hurt_str_dy, 1, War.Person[eid].hurt_str_dy[1] - 2);
                end
              elseif false then
                table.insert(War.Person[eid].hurt_str, 1, "[B]-" .. hurt);
                if #War.Person[eid].hurt_str_dy == 0 or War.Person[eid].hurt_str_dy[1] > 0 then
                  table.insert(War.Person[eid].hurt_str_dy, 1, 0);
                else
                  table.insert(War.Person[eid].hurt_str_dy, 1, War.Person[eid].hurt_str_dy[1] - 2);
                end
              end
              War.Person[eid]["兵力"] = War.Person[eid]["兵力"] - hurt;
              War_SetAttrib(eid);
              if War.Person[eid]["兵力"] <= 0 then
                War.Person[eid]["存活"] = 0;
                War.Person[eid].SpecialAction.id = 21;
                War.Person[eid].SpecialAction.pic = 1500;
                War.Person[eid].SpecialAction.timer = 32;
              end
            end
					end
				end
        
        --start new action
        wp["动作"] = 0;
				wp["动作进度"] = 0;
        wp["动作进度最大值"] = 4;
        if #wp.movepath > 0 then
          if WarCanPass(wid, wp.movepath[1].x, wp.movepath[1].y) then	--下一步移动目标可到达
            wp["动作"] = 1;
            War_MoveToNext(wid);
          end
        else
          local eid = wp.target;
          local atk_r = 0;
          if eid > 0 then
            wp["目标ID"] = eid;
            atk_r = AI_CanAtk(wid, eid, wp["移动X"], wp["移动Y"]);
          end
          if false and atk_r>0 and wp.bingfa_time==0 then
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
          if atk_r == 1 then	--近程攻击
            wp["动作"] = 2;
            wp["动作进度最大值"] = 24;
            wp["目标X"],wp["目标Y"] = War.Person[eid]["移动X"],War.Person[eid]["移动Y"];
            wp["方向"] = GetDirection(wp["目标X"]-wp["坐标X"],wp["目标Y"]-wp["坐标Y"],wp["方向"]);
          elseif atk_r == 2 then	--远程攻击
            wp["动作"] = 3;
            wp["动作进度最大值"] = 24*1.5;
            if War.Person[eid]["动作"] == 1 and #War.Person[eid].movepath > 0 then
              wp["目标X"], wp["目标Y"] = War.Person[eid].movepath[1].x, War.Person[eid].movepath[1].y;
            else
              wp["目标X"], wp["目标Y"] = War.Person[eid]["移动X"],War.Person[eid]["移动Y"];
            end
            wp["方向"] = GetDirection(wp["目标X"]-wp["坐标X"],wp["目标Y"]-wp["坐标Y"],wp["方向"]);
          end
          if War_SpecialAction(wp, atk_r) then
            wp["动作进度最大值"] = math.ceil(wp["动作进度最大值"] * 3 / 4);
          end
        end
				wp.talkd = math.floor(wp["方向"]/2);
			else
				wp["动作进度"] = wp["动作进度"] + 1;
			end
		end
	end
end
function War_SpecialAction(wp, method)
  if method > 0 and wp.SpecialAction.id == 0 and wp.dz > 1000 then
    if method == 1 then --近程攻击
      if wp.bz["兵系"] == 1 and math.random() < 0.10 then  --步兵
        wp.dz = wp.dz - 1000;
        wp.SpecialAction.id = 1;
        wp.SpecialAction.power = 2.5;
        wp.SpecialAction.pic = 1700;
      elseif (wp.bz["兵系"] == 3 or wp.bid == 14) and math.random() < 0.10 then  --骑兵
        wp.dz = wp.dz - 1000;
        wp.SpecialAction.id = 1;
        wp.SpecialAction.power = 2.5;
        wp.SpecialAction.pic = 1900;
      end
    elseif method == 2 then --远程攻击
      if wp.bz["兵系"] == 2 and math.random() < 0.10 then  --弓兵
        wp.dz = wp.dz - 1000;
        wp.SpecialAction.id = 2;
        wp.SpecialAction.power = 2.0;
        wp.SpecialAction.pic = 1800;
      elseif wp.bid == 14 and math.random() < 0.10 then  --突骑
        wp.dz = wp.dz - 1000;
        wp.SpecialAction.id = 2;
        wp.SpecialAction.power = 2.0;
        wp.SpecialAction.pic = 2000;
      end
    elseif method == 11 then --回避
      if math.random() < 0.03 then
        wp.dz = wp.dz - 800;
        wp.SpecialAction.id = 11;
        wp.SpecialAction.pic = 1510;
      end
    end
    if wp.SpecialAction.id > 0 then
      wp.SpecialAction.timer = 32;
      PlayWavE(11);
      return true;
    end
  end
  return false;
end
function War_MoveToNext(wid)
	local wp = War.Person[wid];
	wp["移动X"], wp["移动Y"] = wp.movepath[1].x, wp.movepath[1].y;
  War.MAP[wp["坐标X"]][wp["坐标Y"]].wid = 0;
  War.MAP[wp["移动X"]][wp["移动Y"]].wid = wid;
	wp["方向"] = wp.movepath[1].d;
	table.remove(wp.movepath, 1);
	wp["动作"] = 1;
	local spd = GetMoveCost(wid, wp["移动X"], wp["移动Y"]);
	if spd == 0 then
		spd = 100;
	end
	if wp["方向"] % 2 == 1 then
		spd = spd * 1.414;
	end
	spd = math.ceil(spd);
	wp["动作进度最大值"] = spd;
end
function AI_CanAtk(wid,eid,x,y)
	local m;
	local v=(x-War.Person[eid]["移动X"])^2 + (y-War.Person[eid]["移动Y"])^2;
	if v < 49 then
		m = (War.Person[wid]["体积"]+War.Person[eid]["体积"]+1)^2;
		if v < m then	return 1 end
	else
		m=(War.Person[wid]["体积"]+War.Person[eid]["体积"]+War.Person[wid].bz["射程"])^2;
		if v<m then	return 2 end
	end
	return 0;
end
function War_AI()
	if #War.AI_Pool > 0 then
		local wid = War.AI_Pool[1];
		local wp = War.Person[wid];
		table.remove(War.AI_Pool, 1);
		if wp["存活"] > 0 then
			table.insert(War.AI_Pool, wid);
			if true then--or wp["动作进度"]==0 then	--进行AI
				findpath(wid);
			end
		end
	end
	if #War.BuildingAI_Pool > 0 then
		local bid = War.BuildingAI_Pool[1];
		local bd = War.Building[bid];
		table.remove(War.BuildingAI_Pool, 1);
		if bd.live and 2 == bd.id then
			table.insert(War.BuildingAI_Pool, bid);
			--find enemy
      local target = {
        v = 0,
        x = bd.x,
        y = bd.y,
        eid = 0,
      };
      for eid, wp in ipairs(War.Person) do
        if wp["存活"] > 0 and wp["敌我"] ~= bd.group then
          local x, y = wp["移动X"], wp["移动Y"];
          if War.MAP[x][y].shadow > 0 and   --可见
          (bd.x - x)^2 + (bd.y - y)^2 < (wp["体积"] + 2 + bd.rng)^2 then  --射程内，设building的size = 2
            local v = 1000 / (1 + (bd.x - x)^2 + (bd.y - y)^2); --距离近的优先
            v = v + 100 - wp["兵力"] / 200;
            v = v + math.random(10);
            if v > target.v then
              target.v = v;
              target.x = x;
              target.y = y;
              target.eid = eid;
            end
          end
        end
      end
      bd.target = target.eid;
		end
	end
end
function GetMapXY(dx, dy)
	--从屏幕坐标dx dy，转换为地图坐标mx my
	local x_off,y_off = 1040 - War.x_off, -264 - War.y_off;
	local mx = math.floor((dx + dy * 2 - x_off - y_off * 2) / 32 + 0.501);
	local my = math.floor((dy * 2 - dx + x_off - y_off * 2) / 32 + 0.501);
	return mx, my;
end
function GetScreenXY(mx,my)
	--从屏幕坐标dx dy，转换为地图坐标mx my
	local x_off,y_off=1040-War.x_off,-264-War.y_off;
	local dx=(mx-my)*16+x_off;
	local dy=(mx+my)*8+y_off;
	return dx,dy;
end
function War_CalHurt(wid, eid)
	local wp = War.Person[wid];
	local ep = War.Person[eid];
  local hurt_type = wp["动作"];
	local atk,def;
	if hurt_type == 2 then
		atk = wp["攻击力"];
	else
		atk = wp["远程攻击力"];
	end
	def = ep["防御力"];
	local dx = War.MAP[ep["坐标X"]][ep["坐标Y"]].dx;
	--开始计算伤害		固有兵力相关 + 攻防相关 + 随机数
	local hurt = math.max(20 , wp.p["武力"]+wp.p["统率"] , wp["兵力"]/200 , atk)*atk/(atk+def) + (math.random()-math.random())*5;
	hurt = math.max(atk*atk/(atk+def),1) + (math.random()-math.random())*5;
	--SpecialAction
  if ep.SpecialAction.id == 11 or War_SpecialAction(ep, 11) then
    return 0;
  else
    if between(wp.SpecialAction.id, 1, 10) then
      hurt = hurt * wp.SpecialAction.power;
    end
    hurt = math.floor(hurt * 20 / (8 + ep.bz["适性"..dx]));
    hurt = limitX(hurt, 1, 9999);
    return hurt;
  end
end
function War_SetAttrib(wid)
	local wp=War.Person[wid];
	local att=	20 + 
				math.max(	30000/(200-wp.p["武力"])-150,
							math.min(wp["兵力"]*2+wp["兵力上限"],wp.p["统率"]*300)/(200-wp.p["统率"])-150) + 
				wp["兵力"]/500;
	--if att<10 then att=10 end
	wp["攻击力"]=math.floor(att*wp.bz["攻击力"]/10);
	wp["远程攻击力"]=math.floor(att*wp.bz["远程攻击力"]/10);
	wp["防御力"]=math.floor(att*wp.bz["防御力"]/10);
  --[[
	if wp["兵力"]>12000 then
		wp["体积"]=2;
	elseif wp["兵力"]>8000 then
		wp["体积"]=1.5;
	elseif wp["兵力"]>4000 then
		wp["体积"]=1;
	else
		wp["体积"]=0.5;
	end
  ]]--
	if wp["兵力"]>12000 then
		wp["体积"]=2.5;
	elseif wp["兵力"]>8000 then
		wp["体积"]=2;
	elseif wp["兵力"]>4000 then
		wp["体积"]=1.5;
	else
		wp["体积"]=1;
	end
  wp.dzinc = 0.8 + (wp.p["统率"] + math.max(wp.p["武力"], wp.p["智谋"])) / 200;
end
function War_AddPerson(group,order,pid,bid,bl)
	local wid=1+#War.Person;
	local fid=JY.Person[pid]["势力"];
	War.Person[wid]={
    ["方向"] = 0,
    ["坐标X"]=War.GroupXY[group][order].x,
    ["坐标Y"]=War.GroupXY[group][order].y,
    ["移动X"]=War.GroupXY[group][order].x,
    ["移动Y"]=War.GroupXY[group][order].y,
    ["目标X"]=-1,
    ["目标Y"]=-1,
    ["屏幕X"]=-1,
    ["屏幕Y"]=-1,
    ["状态X"]=-1,
    ["状态Y"]=-1,
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
    show = true,  --是否显示
    ["选中"]=0,
    --AI--
    ["AI方针"]=0,
    ["AI目标ID"]=0,
    ["AI目标X"]=0,
    ["AI目标Y"]=0,
    ------
    building = false, --是否为战场建筑
    flag_id=GetFlagID(pid),
    force_id=fid,
    bingfa_id=0,
    bingfa_time=0,
    talkstr="",
    talkd=0,
    movepath = {},	--预订移动路径
    target = 0, --预定攻击目标
    AIConfig = {  --AI设置
      kind = 0,
      tx = 0,
      ty = 0,
    },
    AISearch = {},  --AI思考区域
    hurt_str={},	--受伤显示
    hurt_str_dy={},	--受伤显示
    dz = 0, --斗志，决定特殊技发动
    dzinc = 0,  --斗志上升率
    SpecialAction = {  --特殊攻击
      id = 0,
      power = 0,
      pic = 0,
      timer = 0,
    },
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
	War.Person[wid].pid = pid;
	War.Person[wid].p=JY.Person[pid];
	War.Person[wid].bid = bid;
	War.Person[wid].bz=JY.Bingzhong[bid];
	if group<6 then
		War.Person[wid]["贴图"] = War.Person[wid].bz["贴图"];
		War.Person[wid]["敌我"] = 0;
    if War.CityPosition == 0 then
      War.Person[wid]["方向"] = 6;
    else
      War.Person[wid]["方向"] = 0;
    end
    War.Person[wid].SpecialAction.color = RGB(55,164,250);
	else
		War.Person[wid]["贴图"]=War.Person[wid].bz["贴图"]+80;
		War.Person[wid]["敌我"]=1;
    if War.CityPosition == 0 then
      War.Person[wid]["方向"] = 2;
    else
      War.Person[wid]["方向"] = 4;
    end
    War.Person[wid].SpecialAction.color = RGB(250,87,95);
		War.Person[wid]["AI方针"]=1;
		War.Person[wid]["AI目标X"]=War.GroupXY[group][order].x;
		War.Person[wid]["AI目标Y"]=War.GroupXY[group][order].y;
	end
	War_SetAttrib(wid);
	War.MAP[War.Person[wid]["坐标X"]][War.Person[wid]["坐标Y"]].wid = wid;
	table.insert(War.AI_Pool, wid);
end
function War_AddBuilding(id, group, x, y, lv)
  -- id 1 城门 2 砦 3 城墙守军
  local bid = 1 + #War.Building;
  War.Building[bid] = {
    id = id,
    group = group,
    x = x,
    y = y,
    lv = lv,
    live = true,
    pic = 0,
    hp = 800,
    hp_max = 800,
    atk = 100,
    def = 100,
    rng = 15,
    target = 0, --预定攻击目标
    ["目标X"] = -1,
    ["目标Y"] = -1,
    ["目标ID"] = 0,
    ["动作进度"] = 0,
    ["动作进度最大值"] = 48,
  };
  if 2 == id then
    table.insert(War.BuildingAI_Pool, bid);
  end
end
function War_LoadDX()
	local len = 4 + 63*65*2;
	local data = Byte.create(len);
	Byte.loadfile(data,string.format(CONFIG.CurrentPath.."D_YMAP.S8/D_YMAP.S8.%03d",War.mapid),0,len);
	War.GroupXY={	--出场位置
					[1]={},[2]={},[3]={},[4]={},[5]={},
					[6]={},[7]={},[8]={},[9]={},[10]={},[16]={},
				}
  local function convertXY(x, y)  --奇异坐标转为标准坐标
    local y1, y2 = math.floor(y / 2), y % 2;
    local rx = x + y1 + y2;
    local ry = 64 - x + y1;
    return rx, ry;
  end
	local idx = 4;
	for i = 0, 62 do
    for j = 0, 64 do
      local v = Byte.getu16(data, idx);
      idx = idx + 2;
      local x, y = convertXY(i, j, 1);
      local sx, sy = GetScreenXY(x, y);
      if between(sx, 24, 2008 - 24) and sy < 768 - 16 then
        --%16得到第一位，地形
        --第二位 敌我援标识 我方正规军为0 1/2分别为我方援军
        --					敌方城门布阵为5 迎击为8 6/7分别为援军
        --			F 怀疑是 中间据点
        --第三位 部队序号
        if v<65521 then
          local group = 1 + math.floor(v / 16) % 16;
          local order = 1 + math.floor(v / 256) % 16;
          if between(group, 1, 10) then
            War.GroupXY[group][order] = {x = x, y = y}
          end
          if group == 16 then
            --lib.Debug("16 "..order)
            order = #War.GroupXY[group] + 1;
            War.GroupXY[group][order] = {x = x, y = y}
          end
        end
        v = v % 16;
        War.MAP[x][y] = {
          dx = v,
          shadow = 0,
          wid = 0,
        }
      end
    end
  end
	if War.GroupXY[1][1].x > 55 then
		War.CityPosition = 0;
	else
		War.CityPosition = 1;
	end
	if War.CityPosition == 0 then	--城在左边
		for y=55, 72 do
			War.MAP[9][y].dx = 14
		end
    War_AddBuilding(1, 1, 9, 62, 3); --城门
	else
		for x=53, 70 do
			War.MAP[x][11].dx = 14
		end
    War_AddBuilding(1, 1, 60, 11, 3); --城门
	end
  War_AddBuilding(2, 0, War.GroupXY[1][1].x, War.GroupXY[1][1].y, 1); --攻击方营地
  for i, v in ipairs(War.GroupXY[16]) do
    War_AddBuilding(2, 1, v.x, v.y, 1); --防守方中间营地
  end
  
--	for i,v in ipairs(War.GroupXY[16]) do
--		War.MAP[v.x][v.y].dx=13
--		War.MAP[v.x+1][v.y].dx=13
--		War.MAP[v.x+2][v.y].dx=13
--		War.MAP[v.x][v.y-1].dx=13
--		War.MAP[v.x+1][v.y-1].dx=13
--		War.MAP[v.x+2][v.y-1].dx=13
--		War.MAP[v.x][v.y-2].dx=13
--		War.MAP[v.x+1][v.y-2].dx=13
--		War.MAP[v.x+2][v.y-2].dx=13
--	end
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
	War_LoadDX();
	War.Target={[0] = {}, [1] = {}, [2] = {},};
	if War.CityPosition==0 then
		War.Target[0].x=9;
		War.Target[0].y=62;
	else
		War.Target[0].x=60;
		War.Target[0].y=11;
	end
	--[[War.Target[1].x=War.GroupXY[1][1].x
	War.Target[1].y=War.GroupXY[1][1].y
	War.Target[2].x=War.GroupXY[16][1].x
	War.Target[2].y=War.GroupXY[16][1].y]]--
	War.x_off,War.y_off=GetScreenXY(War.GroupXY[1][1].x,War.GroupXY[1][1].y);
	War.x_off=limitX(War.x_off-CC.ScreenW/2,0,2016-CC.ScreenW);
	War.y_off=limitX(War.y_off-CC.ScreenH/2,0,768-CC.ScreenH);
end
function skipWar(warid)
  local army = {};
	local width, height = 800, 320;
	local size = 20;
	local x0 = (CC.ScreenW - width) / 2;
	local y0 = (CC.ScreenH - height) / 2;
  local function redraw()
    DrawGame();
    local x, y = x0, y0;
    LoadPicEnhance(73, x, y, width, height);
    x, y = CC.ScreenW / 2, y0 - 36;
    lib.PicLoadCache(4, 4 * 2, x, y);
    DrawStringEnhance(x, y, War.name, C_WHITE, 36, 0.5, 0.5);
    x = x + 100; y = y + 48;
    for i, wp in ipairs(army) do
      x = CC.ScreenW / 2 + (wp.group - 3) * 200 + 28;
      y = y0 + wp.idx * (size + 4);
      local color;
      if wp.live then
        color = C_WHITE;
      else
        color = C_RED;
      end
      lib.PicLoadCache(2, wp.head * 2, x - 24, y - 2, 1, nil, nil, 24);
      lib.PicLoadCache(4, wp.bzPic * 2, x + size* 4, y, 1);
      DrawStringEnhance(x + size * 2, y, wp.name, color, size, 0.5);
      DrawStringEnhance(x + size * 5, y, string.format("%5d", wp.bl), color, size);
    end
  end
  local function setAttrib(i)
    local wp = army[i];
    local att=	20 + 
          math.max(	30000/(200-wp.p["武力"]) - 150,
                math.min(wp.bl * 2 + wp.blMax, wp.p["统率"] * 300) / (200 - wp.p["统率"]) - 150) + 
          wp.bl / 500;
    local fid = wp.p["势力"];
    if fid == 1 or fid == 2 or fid == 3 then
      att = att * 1.1;
    end
    if fid == 2 then
      att = att * 1.1
    end
    wp.atk1 = math.floor(att * wp.bz["攻击力"] / 10);
    wp.atk2 = math.floor(att * wp.bz["远程攻击力"] / 10);
    wp.def = math.floor(att * wp.bz["防御力"] / 10);
  end
  local function sortArmy()
    table.sort(army, function(a, b)
      if a.idx < b.idx then
        return true;
      elseif a.idx == b.idx then
        return a.group < b.group;
      end
    end);
  end
  local function autoWar()
    local wlist = {};
    for i, v in ipairs(army) do
      if v.live then
        table.insert(wlist, {
          id = i,
          pid = v.pid,
          bz = v.bz["兵系"],
          enemy = v.enemy,
          hit = 0,
        });
      end
    end
    for i, wp in ipairs(army) do
      if wp.live then
        table.sort(wlist, function(a, b)
          if a.enemy ~= wp.enemy then
            if b.enemy == wp.enemy then
              return true;
            elseif a.hit < b.hit then
              return true;
            elseif a.hit == b.hit then
              if a.bz == wp.bz then
                if a.bz == b.bz then
                  return a.pid < b.pid;
                else
                  return true;
                end
              elseif (wp.bz == 1 and a.bz == 3) or (wp.bz == 3 and a.bz == 2) or (wp.bz == 2 and a.bz == 1) then
                if a.bz == b.bz then
                  return a.pid < b.pid;
                else
                  return true;
                end
              end
            end
          end
        end);
        local eid = wlist[1];
        if eid.enemy ~= wp.enemy then
          wlist[1].hit = wlist[1].hit + 1;
          local ep = army[eid.id];
          local atk;
          if wp.bz["兵系"] == 2 then
            atk = wp.atk2;
          else
            atk = wp.atk1;
          end
          local def = ep.def;
          local hurt = math.max(atk * atk / (atk + def), 1) + (math.random() - math.random())*5;
          hurt = limitX(math.floor(hurt), 1, 9999);
          ep.bl = ep.bl - hurt;
          if ep.bl <= 0 then
            ep.bl = 0;
            ep.live = false;
          end
        end
      end
    end
  end
	local function checkResult()
    local bl1, bl2 = 0, 0;
    for i, wp in ipairs(army) do
      if wp.live then
        if wp.enemy then
          bl2 = bl2 + wp.bl;
        else
          bl1 = bl1 + wp.bl;
        end
      end
    end
    if bl1 == 0 then
      return 1;
    elseif bl2 == 0 then
      return 2;
    else
      return 0;
    end
  end
  --War_LoadMap(warid);
	if JY.Connection[warid]["古战场"]>0 then
		War.name=JY.Str[9180+JY.Connection[warid]["古战场"]].."之战";
	else
		War.name=JY.City[JY.Connection[warid]["都市2"]]["名称"].."之战";
	end
	War.mapid=JY.Connection[warid]["战场"];
	for i, v in ipairs(War.ArmyA1) do
    table.insert(army, {
      group = 2,
      idx = i,
      pid = v.pid,
      head = JY.Person[v.pid]["容貌"] + 6000,
      name = JY.Person[v.pid]["名称"],
      bl = v.bl,
      blMax = v.bl,
      atk1 = 0,
      atk2 = 0,
      def = 0,
      p = JY.Person[v.pid],
      bz = JY.Bingzhong[v.bz],
      bzPic = 276 + 4 * JY.Bingzhong[v.bz]["兵系"],
      live = true,
      enemy = false,
    });
	end
	for i, v in ipairs(War.ArmyB1) do
    table.insert(army, {
      group = 3,
      idx = i,
      pid = v.pid,
      head = JY.Person[v.pid]["容貌"] + 6000,
      name = JY.Person[v.pid]["名称"],
      bl = v.bl,
      blMax = v.bl,
      atk1 = 0,
      atk2 = 0,
      def = 0,
      p = JY.Person[v.pid],
      bz = JY.Bingzhong[v.bz],
      bzPic = 276 + 4 * JY.Bingzhong[v.bz]["兵系"] + 2,
      live = true,
      enemy = true,
    });
	end
  for i, v in ipairs(army) do
    setAttrib(i);
  end
  sortArmy();
  while true do
    local t1 = lib.GetTime();
    redraw();
    ShowScreen();
    autoWar();
    local r = checkResult();
		local delay = CC.FrameNum * 2 - lib.GetTime() + t1;
		if delay > 0 then
			lib.Delay(delay);
		end
    getkey();
    if r > 0 then
      redraw();
      ShowScreen();
      for i = 1, 4 do
        lib.Delay(CC.FrameNum);
        getkey();
      end
      Talk("", "战斗结束");
      return r;
    end
  end
  
  --[[
  给每个部队, 设置攻击目标, follow 以下rule

自身为步兵时, 敌方以 被攻击次数小的>步>弓>骑 的次序排序, 攻击最优先的, 被攻击之目标, 标记被攻击次数+1
自身为弓兵时, 敌方以 被攻击次数小的>弓>骑>步 的次序排序, 攻击最优先的, 被攻击之目标, 标记被攻击次数+1
自身为骑兵时, 敌方以 被攻击次数小的>骑>步>弓 的次序排序, 攻击最优先的, 被攻击之目标, 标记被攻击次数+1

  ]]
end
function LLK_III_Main(warid)
	local x_off_old=0;
	local y_off_old=0;
	local move_screen=false;
	for i = 0 - 2, 127 + 2 do
		War.MAP[i] = {};
	end
	War.AI_Pool = {};
	War.BuildingAI_Pool = {};
	War_LoadMap(warid);
	for i,v in ipairs(War.ArmyA1) do
		War_AddPerson(1,i,v.pid,v.bz,v.bl);
	end
	for i,v in ipairs(War.ArmyB1) do
		War_AddPerson(9,i,v.pid,v.bz,v.bl);
	end
	local bt={};
	table.insert(bt,button_creat(1,73,20,110,"LoadScript",true,true));
	WarMenu:init();
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
	PlayBGM(13);
	while WarMenu.result == 0 do
		local t1 = lib.GetTime();
		if not WarMenu.pause then
      t0 = lib.GetTime();
      War_AutoAction();
      War_AI();
      War.s1 = War.s1 + lib.GetTime() - t0;
      War_PlayWav();
		end
    t0 = lib.GetTime();
		War_DrawMap();
    WarMenu:redraw();
		button_redraw(bt);
    DrawStringEnhance(8,528,fps_str,C_WHITE,24);
    DrawStringEnhance(8,552,cpu_str,C_WHITE,24);
    if fps_num==30 then
      fps_str=string.format("[B]FPS: %3.1f",30000/fps_time);
      cpu_str=string.format("[B]AI: %2.1f, ReDraw: %2.1f, ShowScreen: %2.1f, Delay: %2.1f",War.s1/30, War.s2/30, War.s3/30, War.s4/30)
      fps_num=0;
      fps_time=0;
      War.s1=1
      War.s2=0
      War.s3=0
      War.s4=0
      War.s5=0
    end
    War.s2 = War.s2 + lib.GetTime() - t0;
    t0 = lib.GetTime();
		ShowScreen();
    War.s3 = War.s3 + lib.GetTime() - t0;
    t0 = lib.GetTime();
		local delay=CC.FrameNum-lib.GetTime()+t1;
		if delay>0 then
			lib.Delay(delay);
		end
    War.s4 = War.s4 + lib.GetTime() - t0;
		--DoEvent
		getkey();
		War.mx, War.my = GetMapXY(MOUSE.x, MOUSE.y);
    WarMenu:event();
		local event,btid=button_event(bt);
		if event==3 then
			if btid==73 then
				dofile(CONFIG.ScriptPath .. "LLK_III.lua");
				dofile(CONFIG.ScriptPath .. "UI.lua");
			end
		end
		--移动地图
    if MOUSE.x < 10 then
      War.x_off = limitX(War.x_off - 12, 0, 2016 - CC.ScreenW);
    elseif MOUSE.x > CC.ScreenW - 10 then
      War.x_off = limitX(War.x_off + 12, 0, 2016 - CC.ScreenW);
    end
    if MOUSE.y < 10 then
      War.y_off = limitX(War.y_off - 8, 0, 768 - CC.ScreenH);
    elseif MOUSE.y > CC.ScreenH - 10 then
      War.y_off = limitX(War.y_off + 8, 0, 768 - CC.ScreenH);
    end
    --选择部队
    WarArmySelection:event();
    
    --[=[
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
    ]=]--
		--选择部队
    --[[
		local sx,sy=GetScreenXY(War.mx, War.my);
		if MOUSE.CLICK(sx-16,sy-8,sx+16,sy+8) then
			for wid, wp in ipairs(War.Person) do
				if 1 == wp["存活"] and math.abs(wp["移动X"] - War.mx) <= 1 and math.abs(wp["移动Y"] - War.my) <= 1 then
					wp["选中"] = 1;
				else
					wp["选中"] = 0;
				end
			end
		end
    ]]--
    fps_num = fps_num + 1;
    fps_time = fps_time + lib.GetTime() - t1;
	end
  return WarMenu.result;
end
function WarCanPass(wid, x, y)
	local tx = {-1,0,1,		  -2,-1,0,1,2,		  -2,-1,0,1,2,		    -2,-1,0,1,2,		-1,0,1};
	local ty = {-2,-2,-2,		-1,-1,-1,-1,-1,		0,0,0,0,0,			    1,1,1,1,1,			2,2,2};
	local tr = {3,2.5,3,		3,2,1.5,2,3,		  2.5,1.5,0,1.5,2.5,	3,2,1.5,2,3,		3,2.5,3};
	for idx = 1, #tx do
		local i, j = x + tx[idx], y + ty[idx];
		if War.MAP[i][j] then
			local eid = War.MAP[i][j].wid;
			if eid > 0 and eid ~= wid then
				local size = War.Person[wid]["体积"] + War.Person[eid]["体积"];
				if size > tr[idx] then
					return false;
				end
			end
		end
	end
	return true;
end
function GetMoveCost(wid, x, y)
	if War.MAP[x][y] then
    local dx = War.MAP[x][y].dx;
    local cost = War.Person[wid].bz["移动力" .. dx];
    return cost;
  else
    return 0;
  end
end
function findpath(wid)--,x1,y1,x2,y2) --将寻敌加入在内
	local wp = War.Person[wid];
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
          search={},
				}
	--设置碰撞 标记不可移动的位置 以及 敌人位置
	local tx={0,	-1,1,0,0,	-1,-1,1,1,	-2,2,0,0,	-2,-1,1,2,-2,-1,1,2}
	local ty={0,	0,0,-1,1,	-1,1,-1,1,	0,0,-2,2,	1,2,2,1,-1,-2,-2,-1}
	local tx = {-1,0,1,		-2,-1,0,1,2,		-2,-1,0,1,2,		-2,-1,0,1,2,		-1,0,1};
	local ty = {-2,-2,-2,		-1,-1,-1,-1,-1,		0,0,0,0,0,			1,1,1,1,1,			2,2,2};
	local tr = {3,2.5,3,		3,2,1.5,2,3,		2.5,1.5,0,1.5,2.5,	3,2,1.5,2,3,		3,2.5,3};
	local n;
	local min_len,cur_len=256*256,0;
	for i, v in ipairs(War.Person) do
    local ox, oy = v["移动X"], v["移动Y"];
    if i ~= wid and v["存活"] > 0 and War.MAP[ox][oy].shadow > 0 then
      local size = wp["体积"] + v["体积"];
      for idx = 1, #tx do
        local nx, ny = ox + tx[idx], oy + ty[idx];
        if War.MAP[nx][ny] and size > tr[idx] then
          if v["敌我"] ~= wp["敌我"] or v["动作"] ~= 1 then
            Asmap.s[128*nx + ny] = 2; --关闭此节点
          end
        end
      end
    end
	end
  local target = {
    v = 0,
    x = x1,
    y = y1,
    eid = 0,
  };
  local emeny = {};
  local wid_bx = War.Person[wid].bz["兵系"];
  for i, v in pairs(War.Person) do
    if v["存活"] > 0 and v["敌我"] ~= wp["敌我"] and War.MAP[v["坐标X"]][v["坐标Y"]].shadow > 0 then
      local eid_bl = War.Person[i]["兵力"];
      local eid_bx = War.Person[i].bz["兵系"];
      local v = 200 - eid_bl/200;  --敌方兵力越小，权值越高
      if wid_bx == 3 and eid_bx == 2 then --骑兵优先攻击弓兵
        v = v + 50;
      end
      if wid_bx == 2 and eid_bx == 3 then --弓兵优先攻击骑兵
        v = v + 20;
      end
      if eid_bx == 1 then --所有兵种优先攻击步兵(嘲讽)
        v = v + 20;
      end
      table.insert(emeny, {
        v = v,
        eid = i,
      });
    end
  end
  table.sort(emeny, function(a, b) return a.v > b.v end);
  local function findEmenyCanAtk(x,y)
    local eid, maxv = 0, 0;
    for i, v in pairs(emeny) do
      local atk_r = AI_CanAtk(wid, v.eid, x, y);
      if atk_r > 0 then
        local nv = v.v;
        if atk_r == 1 and wp.bz["兵系"] == 2 then
          nv = nv / 10;
        end
        if nv > maxv then
          maxv = nv;
          eid = v.eid;
        end
      end
    end
    return eid, maxv;
  end
  local function findEmeny(x,y)
    local iter = 128 * x + y;
    local eid, v = findEmenyCanAtk(x,y);
    if eid > 0 then
      v = v + 128 - Asmap.g[iter];  --移动的cost越小，权值越高
      if x == x1 and y == y1 then --原地，不移动，额外加权
        v = v + 50;
      end
    else  --无法攻击敌人时，离目标的距离越小，权值越高
      v = 256 - Asmap.h[iter];
    end
    if v > target.v then
      target.v = v;
      target.x = x;
      target.y = y;
      target. eid = eid;
    end
  end
  
  local aiType = wp['敌我'];
  if 0 == aiType then --主动出击
    if #emeny > 0 then
      local eid = emeny[1].eid;
      x2, y2 = War.Person[eid]["移动X"], War.Person[eid]["移动Y"];
    else
      if wp['敌我'] == 0 then
        x2, y2 = War.Target[0].x, War.Target[0].y;
        if wp.AIConfig.tx > 0 then
          x2, y2 = wp.AIConfig.tx, wp.AIConfig.ty;
        end
      else
        x2, y2 = War.Target[1].x, War.Target[1].y;
      end
    end
  elseif 1 == aiType then --被动出击
    x2, y2 = wp["移动X"], wp["移动Y"];
  elseif 2 == aiType then --原地坚守
  elseif 3 == aiType then --攻击坐标
  end
  

	local function manhatten(x,y) --A*中的启发式函数，用于求指定位置和终点之间的曼哈顿距离
		--return math.abs(x-x2) + math.abs(y-y2);
		
    --local dx,dy=math.abs(x-x2),math.abs(y-y2);
		--local h_diagonal=math.min(dx,dy);
		--local h_straight=dx+dy;
		--return h_straight-0.6*h_diagonal;
    
    return math.sqrt((x - x2)^2 + (y - y2)^2)
	end
	local function increment(node)  --求当前点与父亲节点的距离
		local dxy=math.abs(node-Asmap.father[node]);
		if dxy==1 or dxy==128 then
			return Asmap.w[node];
		else
			return 1.4*Asmap.w[node];
		end
	end
	local function NewG(node,father)  --求出用当前点作为父节点时这个点的G值
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
		t[1], t[#t] = t[#t], t[1]
		table.remove(t)
		-- table.remove(t,1);
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

	iter = 128 * x1 + y1;
	Asmap.g[iter]=0;                  --已花费的cost
	Asmap.s[iter]=1;                  --状态 nil 未处理 1 已开启 2 已关闭
	Asmap.h[iter]=manhatten(x1, y1);  --距离目标的曼哈顿距离
	--把起点放入开启列表
	table.insert(Open,iter);
	--当开启列表为空或者终点在关闭列表中，结束寻径
	local search=0;
  local max_search = 256;
	while #Open > 0 and search < max_search do
		search=search+1;
		
		iter = Open[1];   --取出开启列表中f值最小的节点（之一），并设为iter（当前点）
		MinHeapRemove(Open);  --把当前点从开启列表中删除
		Asmap.s[iter]=2;  --把当前点记录在关闭列表中
		Asmap.search[iter]=search;  --把当前点记录在关闭列表中
		local cx,cy=(math.floor(iter/128)),iter%128;
    findEmeny(cx,cy);
		--把当前点的邻居加入邻居列表
		Neibo={};
		for i = math.max(cx - 1, 0), math.min(cx + 1, 127) do
			for j = math.max(cy - 1, 0), math.min(cy + 1, 127) do
				cur = 128 * i + j;
				if (not Asmap.s[cur]) and War.MAP[i][j] then
					Asmap.h[cur] = manhatten(i, j);
					Asmap.w[cur] = GetMoveCost(wid, i, j) / 10--*10/(10+Asmap.g[iter]);
					table.insert(Neibo, cur);
				end
			end
		end
		--对于每个邻居，分三种情况进行操作
		for i,v in ipairs(Neibo) do
			--如果这个邻居节点在关闭列表中，或者这个邻居节点不可通过，略过它
			if Asmap.s[v] == 2 or Asmap.w[v] == 0 then
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
	local movepath={};
	iter = 128 * x1 + y1;
  if target.v > 0 then
    ender = 128 * target.x + target.y;
		while iter ~= ender do
			table.insert(movepath,1,{x=(math.floor(ender/128)),y=ender%128})
			ender=Asmap.father[ender];
		end
		for i=1, #movepath do
			movepath[i].d=GetDirection(movepath[i].x-x1,movepath[i].y-y1);
			x1=movepath[i].x;
			y1=movepath[i].y;
		end
  end
  wp.target = target.eid;
	wp.movepath = movepath;
  wp.AISearch = Asmap.search;
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
			lib.PlayWAV(CONFIG.CurrentPath.."sound/se_i005.wav");
			Draw(8,4);
		else
			setAction(id,6);
			lib.PlayWAV(CONFIG.CurrentPath.."sound/se_i006.wav");
			Draw(4,4);
			lib.PlayWAV(CONFIG.CurrentPath.."sound/se_i006.wav");
			Draw(4,4);
			Draw(4,4);
		end
		setAction(id,0);
	end
	local function move()
		setAction(1,2);
		setAction(2,2);
		lib.PlayWAV(CONFIG.CurrentPath.."sound/se_i000.wav");
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
			lib.PlayWAV(CONFIG.CurrentPath.."sound/se_i008.wav");
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
			lib.PlayWAV(CONFIG.CurrentPath.."sound/se_i007.wav");
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
		lib.PlayWAV(CONFIG.CurrentPath.."sound/se_i012.wav");
		Draw(8,3);
		setAction(id,rnd_atk());
		Draw(4,3);
		if math.random(1,100)>p[3-id].def then
			lib.PlayWAV(CONFIG.CurrentPath.."sound/se_i009.wav");
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
		lib.PlayWAV(CONFIG.CurrentPath.."sound/se_i012.wav");
		Draw(8,3);
		setAction(id,6);
		if math.random(1,100)>p[3-id].def then
				lib.PlayWAV(CONFIG.CurrentPath.."sound/se_i006.wav");
			Draw(8,1);
			setAction(id,6);
				lib.PlayWAV(CONFIG.CurrentPath.."sound/se_i006.wav");
			Draw(8,1);
			setAction(id,6);
				lib.PlayWAV(CONFIG.CurrentPath.."sound/se_i006.wav");
			Draw(8,1);
			setAction(id,6);
				lib.PlayWAV(CONFIG.CurrentPath.."sound/se_i006.wav");
			Draw(8,1);
			setAction(id,rnd_atk());
			Draw(4,3);
			setAction(3-id,8);
			lib.PlayWAV(CONFIG.CurrentPath.."sound/se_i009.wav");
			Draw(8,3);
			decHP(3-id,20);
		else
			lib.PlayWAV(CONFIG.CurrentPath.."sound/issei.wav");
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
	--lib.PlayWAV(CONFIG.CurrentPath.."sound/se_i003.wav");
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
	lib.PlayWAV(CONFIG.CurrentPath.."sound/se_i002.wav");
	Draw(16,4);
	if p[1].hp>0 then
		setAction(1,3);
	end
	if p[2].hp>0 then
		setAction(2,3);
	end
	lib.PlayWAV(CONFIG.CurrentPath.."sound/se_i010.wav");
	Draw(16,4);
end
--==================================================--
function LoadSan8Record()
	local pnum=760;
	local size1=88
	local size2=4
	local data1=Byte.create(size1*pnum);
	local data2=Byte.create(size2*pnum);
	local file="E:/San8PK/svd_02.sav"
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