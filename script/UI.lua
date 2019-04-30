-- Classed and Objects
CityGeo = {}
function CityGeo:init()
  self.data = Byte.create(446576);
  Byte.loadfile(self.data, CONFIG.DataPath .. "city.geo", 0, 446576);
end
function CityGeo:query(x, y)
  if between(x, 0, 405) and between(y, 0, 365) then
    local idx = 56 + 1220 * y + 3 * x;
    return Byte.get8(self.data, idx);
  else
    return 0;
  end
end
CityGeo:init();
CityMap = {
  x0 = 0,
  y0 = 0,
  width = 800,
  height = 480,
  mx = 0,
  my = 0,
  selectForce = false,
  purpose = "view",
  selectItem = "代号",
  selectItemChangeable = true,
  selected = -1,
  hold = -1,
  on = -1,
  onTime = 0,
  labelString = "",
  cityEnable = {},
  citys = {},
  data = {},
  sheet = {},
  curSheet = 1,
  bt = {},
  showRoad = true,
}
function CityMap:init()
  --初始化坐标
  self.x0, self.y0 = (CC.ScreenW - self.width) / 2, (CC.ScreenH - self.height) / 2;
  self.mx = (CC.ScreenW - 392 + 232)/2;
  self.my = (CC.ScreenH - 352 - 48) / 2;
  --初始化按钮
  self.sheet = {};
  table.insert(self.sheet, button_creat(10, 1, self.mx + 92, self.y0 - 32, "都市", true, true));
  table.insert(self.sheet, button_creat(10, 2, self.mx, self.y0 - 32, "势力", true, true));
  self.bt = {};
  if self.purpose == "view" then
    button_mainbt_1(self.bt, "关闭", 41, self.y0 + self.height - 56);
  end
  --加载数据
  self.citys = {};
  --self.selectItem = "代号";
  --self.selectItem = "州";
  local function cityName(i)
    if self.selectForce then
      if JY.City[i]["势力"] > 0 then
        return JY.Force[JY.City[i]["势力"]]["名称"] .. "[5]" .. JY.City[i]["名称"];
      else
        return JY.City[i]["名称"];
      end
    else
      return JY.City[i]["名称"];
    end
  end
  local function cityBgColor(i)
    if JY.City[i]["势力"] > 0 then
      return FlagColor[JY.City[i]["势力"]];
    else
      return 0;
    end
  end
  for i = 1, JY.CityNum - 1 do
    local sid;
    if self.selectForce then
      sid = JY.City[i]["势力"];
    else
      sid = i;
    end
    self.citys[i] = {
      sid = sid,
      name = cityName(i),
      pic = 700 + i,
      color = FlagColor[JY.City[i]["势力"]],
      bgColor = cityBgColor(i),
      enable = self.cityEnable[i],
      x = self.mx + JY.City[i]["中地图X"],
      y = self.my + JY.City[i]["中地图Y"],
    };
  end
  self.data = {};
  if self.selectForce then
    for i = 1, JY.ForceNum - 1 do
      local force = JY.Force[i];
      self.data[i] = {
        name = force["名称"],
        leaderName = JY.Person[force["君主"]]["名称"],
        cityNum = 0,
        peopleNum = 0,
        soldierNum = 0,
        gold = 0,
        food = 0
      };
    end
    for i = 1, JY.CityNum - 1 do
      local city = JY.City[i];
      local fid = city["势力"];
      if fid > 0 then
        self.data[fid].cityNum = self.data[fid].cityNum + 1;
        self.data[fid].peopleNum = self.data[fid].peopleNum + city["现役"];
        self.data[fid].soldierNum = self.data[fid].soldierNum + city["兵力"];
        self.data[fid].gold = self.data[fid].gold + city["资金"];
        self.data[fid].food = self.data[fid].food + city["物资"];
      end
    end
    for i, v in ipairs(self.data) do
      v.cityNum = v.cityNum .. "";
      v.peopleNum = v.peopleNum .. "";
      v.soldierNum = v.soldierNum .. "";
      v.gold = v.gold * 10 .. "";
      v.food = v.food * 10 .. "";
    end
  else
    for i = 1, JY.CityNum - 1 do
      local city = JY.City[i];
      self.data[i] = {
        name = city["名称"],
        zhou = JY.Str[city["州"] + 9030],
        forceName = JY.Force[city["势力"]]["名称"],
        leaderName = JY.Person[city["太守"]]["名称"],
        gold = city["资金"] * 10 .. "",
        food = city["物资"] * 10 .. "",
        peopleNum = city["现役"] .. "",
        soldierNum = city["兵力"] .. "",
        def = math.floor(city["防御"] / 2) .. "",
        security = math.floor(city["治安"] / 10) .. "",
        feature = JY.Str[city["特征"] + 9010]
      };
    end
  end
end
function CityMap:event()
  local event, btid, idx = button_event(self.bt);
  if event == 3 then
    if btid == 11 then
      if self.selectItemChangeable and self.selectItem ~= "代号" then
        self.selectItem = "代号";
        self:init();
        return 0;
      end
    elseif btid == 12 then
      if self.selectItemChangeable and self.selectItem ~= "势力" then
        self.selectItem = "势力";
        self:init();
        return 0;
      end
    elseif btid == 13 then
      if self.selectItemChangeable and self.selectItem ~= "州" then
        self.selectItem = "州";
        self:init();
        return 0;
      end
    elseif btid == 14 then
      if self.selectItemChangeable and self.selectItem ~= "地方" then
        self.selectItem = "地方";
        self:init();
        return 0;
      end
    elseif btid == 21 then
      if self.bgItem ~= "代号" then
        self.bgItem = "代号";
        self:init();
        return 0;
      end
    elseif btid == 22 then
      if self.bgItem ~= "势力" then
        self.bgItem = "势力";
        self:init();
        return 0;
      end
    elseif btid == 23 then
      if self.bgItem ~= "州" then
        self.bgItem = "州";
        self:init();
        return 0;
      end
    elseif btid == 24 then
      if self.bgItem ~= "地方" then
        self.bgItem = "地方";
        self:init();
        return 0;
      end
    elseif btid == 31 then
      self.showRoad = not self.showRoad;
      if self.showRoad then
        self.bt[idx].on = 3;
      else
        self.bt[idx].on = 0;
      end
    elseif btid == 41 then
      return 2;
    end
  end
  event, btid, idx = button_event(self.sheet);
  if event == 3 and btid ~= self.curSheet then
    self.curSheet = btid;
    if btid == 1 then
      self.selectItem = "代号";
      self.selectForce = false;
      self:init();
      return 0;
    elseif btid == 2 then
      self.selectItem = "势力";
      self.selectForce = true;
      self:init();
      return 0;
    end
  end
  self.hold = -1;
  self.on = -1;
  --[[for i, city in ipairs(self.citys) do
    if city.enable then
      local r = MOUSE.EVENT(city.x - 7, city.y - 7, city.x + 6, city.y + 6);
      if r == 3 then
        if self.selected == city.sid then
          self.selected = -1;
        else
          self.selected = city.sid;
        end
        PlayWavE(0);
        self.on = city.sid;
        self.labelString = city.name;
        return 1, city.sid;
      elseif r == 2 then
        self.hold = city.sid;
        self.on = city.sid;
        self.labelString = city.name;
        return 0;
      elseif r == 1 then
        self.on = city.sid;
        self.labelString = city.name;
        return 0;
      end
    end
  end]]--
  if between(MOUSE.x, self.mx, self.mx + 406) and between(MOUSE.y, self.my, self.my + 366) then
    if MOUSE.status=='CLICK' then
      MOUSE.status = 'IDLE';
      local id1 = CityGeo:query(MOUSE.hx - self.mx, MOUSE.hy - self.my);
      local id2 = CityGeo:query(MOUSE.rx - self.mx, MOUSE.ry - self.my);
      if id1 == id2 and id1 > 0 then
        local city = self.citys[id1];
        self.on = city.sid;
        self.labelString = city.name;
        if city.enable then
          PlayWavE(0);
          return 1, city.sid;
        else
          PlayWavE(2);
          return 0;
        end
      end
    end
    if MOUSE.status=='HOLD' then
      local id1 = CityGeo:query(MOUSE.hx - self.mx, MOUSE.hy - self.my);
      local id2 = CityGeo:query(MOUSE.x - self.mx, MOUSE.y - self.my);
      if id1 == id2 and id1 > 0 then
        local city = self.citys[id1];
        self.hold = city.sid;
        self.on = city.sid;
        self.labelString = city.name;
        return 0;
      end
    else
      local id1 = CityGeo:query(MOUSE.x - self.mx, MOUSE.y - self.my);
      if id1 > 0 then
        local city = self.citys[id1];
        self.on = city.sid;
        self.labelString = city.name;
        return 0;
      end
    end
  end
end
function CityMap:redraw()
  --重绘  392/352 406/366
  local x0, y0 = self.x0, self.y0;
  local mx, my = self.mx, self.my;
  local bx, by = mx + 392 + 12, my;
  self.sheet[self.curSheet].on = 2;
  button_redraw(self.sheet);
  LoadPicEnhance(73, x0, y0, self.width, self.height);
  --[[DrawStringEnhance(bx, by, "[B]情报切换", C_WHITE, 24);  by = by + 24;
  LoadPicEnhance(72, bx - 12, by, 200);    by = by + 84;
  DrawStringEnhance(bx, by, "[B]背景切换", C_WHITE, 24);  by = by + 24;
  LoadPicEnhance(72, bx - 12, by, 200);]]--
  button_redraw(self.bt);
  --lib.Background(mx - 2, my - 2, mx + 392 + 2, my + 352 + 2, 64);
  --lib.DrawRect(mx - 1, my - 1, mx + 392, my - 1, C_BLACK);
  --lib.DrawRect(mx - 1, my - 1, mx - 1, my  + 352, C_BLACK);
  --lib.DrawRect(mx + 392, my - 1, mx + 392, my + 352, M_Gray);
  --lib.DrawRect(mx - 1, my + 352, mx + 392, my + 352, M_Gray);
  --lib.PicLoadCache(4, (699) * 2, mx, my, 1, 255);
  --lib.SetClip(mx, my, mx + 392, my + 352);
  for i, city in ipairs(self.citys) do
    if city.bgColor > 0 then
      lib.PicLoadCache(4, city.pic * 2, mx, my, 1 + 2 + 4, 192, city.bgColor);
    else
      lib.PicLoadCache(4, city.pic * 2, mx, my, 1 + 2 + 4, 192);
    end
    if city.sid == self.on and city.enable then
      local light = math.min(self.onTime, 256 - self.onTime) + 16;
      if light > 0 then
        lib.PicLoadCache(4, city.pic * 2, mx, my, 1 + 2 + 4 + 8, light, city.bgColor);
      end
    end
  end
  lib.PicLoadCache(4, (700+51) * 2, mx, my, 1, 255);
  --if self.showRoad then
  --end
  for i, city in ipairs(self.citys) do
    local x1, y1 = city.x, city.y;
    local pic;
    if city.enable then
      if city.sid == self.selected then
        pic = 154;
      elseif city.sid == self.hold then
        pic = 154;
      elseif city.sid == self.on then
        pic = 153;
      else
        pic = 152;
      end
    else
      pic = 151;
    end
		--[[if JY.Base["当前城池"]==i then
			lib.PicLoadCache(4,598*2,x1+1,y1+1);
		end]]--
    lib.FillColor(x1 - 5, y1 - 5, x1 + 5, y1 + 5, city.color);
		lib.PicLoadCache(4, pic * 2, x1, y1);
  end
  --lib.SetClip(0, 0, 0, 0);
  if self.on >= 0 or self.hold >= 0 then
    DrawLabel(MOUSE.x, MOUSE.y, self.labelString);
    if self.onTime >= 256 then
      self.onTime = 0;
    else
      self.onTime = self.onTime + 4;
    end
  elseif self.onTime > 0 then
    self.onTime = 0;
  end
  --draw informaction
  local x1, y1 = mx - 232, my + 20;
  local size = 20;
  --lib.Background(x1, y1, x1 + 240, y1 + 360, 128, C_WHITE);
  if self.selectForce then
    for i, v in ipairs({"势力", "君主", "都市", "现役", "兵力", "资金", "物资",}) do
      lib.PicLoadCache(4, 208 * 2, x1, y1, 1);
      DrawStringEnhance(x1 + 50, y1 + 3, v, C_Name, size, 0.5);
      y1 = y1 + 28;
    end
  else
    for i, v in ipairs({"都市", "州", "势力", "太守", "资金", "物资", "现役", "兵力", "防御", "治安", "特征",}) do
      lib.PicLoadCache(4, 208 * 2, x1, y1, 1);
      DrawStringEnhance(x1 + 50, y1 + 3, v, C_Name, size, 0.5);
      y1 = y1 + 28;
    end
  end
  if self.on > 0 then
    x1 = x1 + 114;
    y1 = my + 23;
    local v = self.data[self.on];
    if self.selectForce then
      DrawStringEnhance(x1, y1, v.name, C_WHITE, size);  y1 = y1 + 28;
      DrawStringEnhance(x1, y1, v.leaderName, C_WHITE, size);  y1 = y1 + 28;
      DrawStringEnhance(x1, y1, v.cityNum, C_WHITE, size);  y1 = y1 + 28;
      DrawStringEnhance(x1, y1, v.peopleNum, C_WHITE, size);  y1 = y1 + 28;
      DrawStringEnhance(x1, y1, v.soldierNum, C_WHITE, size);  y1 = y1 + 28;
      DrawStringEnhance(x1, y1, v.gold, C_WHITE, size);  y1 = y1 + 28;
      DrawStringEnhance(x1, y1, v.food, C_WHITE, size);  y1 = y1 + 28;
    else
      DrawStringEnhance(x1, y1, v.name, C_WHITE, size);  y1 = y1 + 28;
      DrawStringEnhance(x1, y1, v.zhou, C_WHITE, size);  y1 = y1 + 28;  --JY.Str[city["地方"] + 9050] .. "[5]" .. 
      DrawStringEnhance(x1, y1, v.forceName, C_WHITE, size);  y1 = y1 + 28;
      DrawStringEnhance(x1, y1, v.leaderName, C_WHITE, size);  y1 = y1 + 28;
      DrawStringEnhance(x1, y1, v.gold, C_WHITE, size);  y1 = y1 + 28;
      DrawStringEnhance(x1, y1, v.food, C_WHITE, size);  y1 = y1 + 28;
      DrawStringEnhance(x1, y1, v.peopleNum, C_WHITE, size);  y1 = y1 + 28;
      DrawStringEnhance(x1, y1, v.soldierNum, C_WHITE, size);  y1 = y1 + 28;
      DrawStringEnhance(x1, y1, v.def, C_WHITE, size);  y1 = y1 + 28;
      DrawStringEnhance(x1, y1, v.security, C_WHITE, size);  y1 = y1 + 28;
      DrawStringEnhance(x1, y1, v.feature, C_WHITE, size);  y1 = y1 + 28;
    end
  end
end
function CityMap:show()
  self.purpose = "view";
  self.selectForce = false;
  self.cityEnable = {};
  for i = 1, JY.CityNum - 1 do
    self.cityEnable[i] = true;
  end
  self:init();
  while true do
		local t1 = lib.GetTime();
    DrawGame();
		self:redraw();
		ShowScreen();
		local delay = CC.FrameNum - lib.GetTime() + t1;
		if delay>0 then
			lib.Delay(delay);
		end
		getkey();
    local event, id = self:event();
    if event == 2 then
      break;
    elseif event == 1 and id > 0 then
      self.selected = -1;
      if self.selectItem == "州" or self.selectItem == "地方" then
        local plist = {};
        for i = 1, JY.CityNum - 1 do
          if JY.City[i][self.selectItem] == id then
            table.insert(plist, i);
          end
        end
        ShowCityList(plist, 0);
      elseif self.selectItem == "势力" then
        local forceList = {};
        local index = 1;
        for i = 1, JY.ForceNum - 1 do
          if JY.Force[i]["状态"] > 0 then
            table.insert(forceList, i);
            if i == id then
              index = #forceList;
            end
          end
        end
				DrawForceStatus(forceList, index);
      else
        local cityList = {};
        local index = 1;
        for i, v in ipairs(self.citys) do
          if v.enable then
            table.insert(cityList, i);
            if i == id then
              index = #cityList;
            end
          end
        end
				DrawCityStatus(cityList, index);
      end
    end
  end
end
function CityMap:showForceMap()
  self.purpose = "view";
  self.selectForce = true;
  self.cityEnable = {};
  for i = 1, JY.CityNum - 1 do
    self.cityEnable[i] = JY.City[i]["势力"] > 0;
  end
  self:init();
  while true do
		local t1 = lib.GetTime();
    DrawGame();
		self:redraw();
		ShowScreen();
		local delay = CC.FrameNum - lib.GetTime() + t1;
		if delay>0 then
			lib.Delay(delay);
		end
		getkey();
    local event, id = self:event();
    if event == 2 then
      break;
    elseif event == 1 and id > 0 then
      self.selected = -1;
      if self.selectItem == "州" or self.selectItem == "地方" then
        local plist = {};
        for i = 1, JY.CityNum - 1 do
          if JY.City[i][self.selectItem] == id then
            table.insert(plist, i);
          end
        end
        ShowCityList(plist, 0);
      elseif self.selectItem == "势力" then
        local forceList = {};
        local index = 1;
        for i = 1, JY.ForceNum - 1 do
          if JY.Force[i]["状态"] > 0 then
            table.insert(forceList, i);
            if i == id then
              index = #forceList;
            end
          end
        end
				DrawForceStatus(forceList, index);
      else
        local cityList = {};
        local index = 1;
        for i = 1, JY.CityNum - 1 do
          if (self.bgItem == "代号") or (self.bgItem == "州" and JY.City[i]["州"] == JY.City[id]["州"]) or (self.bgItem == "地方" and JY.City[i]["地方"] == JY.City[id]["地方"]) or (self.bgItem == "势力" and JY.City[i]["势力"] == JY.City[id]["势力"]) then
            table.insert(cityList, i);
            if i == id then
              index = #cityList;
            end
          end
        end
				DrawCityStatus(cityList, index);
      end
    end
  end
end
function CityMap:selectNearbyCity()
  local cid = JY.Person[JY.PID]["所在"];
  self.selectForce = false;
  self.cityEnable = {};
  for i, v in pairs(JY.CityToCity[cid]) do
    self.cityEnable[i] = true;
  end
  self:init();
  while true do
		local t1 = lib.GetTime();
    DrawGame();
		self:redraw();
		ShowScreen();
		local delay = CC.FrameNum - lib.GetTime() + t1;
		if delay>0 then
			lib.Delay(delay);
		end
		getkey();
    local event, id = self:event();
    if event == 2 then
      break;
    elseif event == 1 and id > 0 then
      self.selected = -1;
      return id;
    end
  end
end
function DrawLabel(tx,ty,str)
	local size=18;
	local bk=2;
  local dt, w, h = DrawStringEnhanceInit(str,C_BLACK,size);
  w = w + bk * 2;
  h =  h + bk * 2;
	if tx + w > CC.ScreenW - 8 then
		tx = tx - w - bk;
	else
		tx = tx + bk;
	end
	ty = ty - h - bk;
	lib.FillColor(tx + 1, ty + 1, tx + w + 1, ty + h + 1, C_BLACK);
	lib.FillColor(tx, ty, tx + w, ty + h, C_WHITE);
	tx, ty = tx + bk, ty + bk;
  DrawStringEnhanceSub(tx, ty-1, dt, size);
end

function DrawStringEnhanceSub(x,y,dt,size,alpha)
	alpha=alpha or 255;
	--Draw --BG
	for i,v in ipairs(dt) do
		for j,vv in ipairs(v) do
			if vv.bg~=nil then
				lib.PicLoadCache(6,vv.pic*2,vv.x+x-1,vv.y+y-1,1+2+4,alpha,vv.bg,size);
				lib.PicLoadCache(6,vv.pic*2,vv.x+x-1,vv.y+y+1,1+2+4,alpha,vv.bg,size);
				lib.PicLoadCache(6,vv.pic*2,vv.x+x+1,vv.y+y-1,1+2+4,alpha,vv.bg,size);
				lib.PicLoadCache(6,vv.pic*2,vv.x+x+1,vv.y+y+1,1+2+4,alpha,vv.bg,size);
			end
		end
	end
	--Draw --Front
	for i,v in ipairs(dt) do
		for j,vv in ipairs(v) do
			lib.PicLoadCache(6,vv.pic*2,vv.x+x,vv.y+y,1+2+4,alpha,vv.color,size);
		end
	end
end
function DrawStringEnhanceInit(str,color,size,xadj,yadj,widthlim)
	size=size or 32;
	xadj=xadj or 0;
	yadj=yadj or 0;
	widthlim=widthlim or 1024;
	local dt={[1]={}};
	local width=0;
	local twidth={}
	local row,col=1,1;
	local tcolor=color;
	local bgcolor=nil;
	local oldcolor,oldbg=tcolor,nil;
	local function add(v)
		local nwidth;
		if CC.SpWidth[v]~=nil then
			nwidth=size*CC.SpWidth[v];
		else
			nwidth=size;
		end
		if width+nwidth>widthlim then
			twidth[row]=width;
			row=row+1;
			col=1;
			width=0;
			dt[row]={};
		end
		dt[row][col]={
						x=width,
						y=(size+math.floor(size/10))*(row-1),
						pic=v,
						color=tcolor,
						bg=bgcolor,
					}
		col=col+1;
		width=width+nwidth;
	end
	while #str>0 do
		local tv=string.sub(str,1,1);	--Try单字符
		if tv=="[" then	--控制字符
			local idx=string.find(str,"]",2);
			if idx>1 then
				local cv=string.sub(str,2,idx-1);
				str=string.sub(str,idx+1,-1);
				if (cv=="n" and width>0) or cv=="N" then
					twidth[row]=width;
					row=row+1;
					col=1;
					width=0;
					dt[row]={};
				elseif cv=="white" or cv=="w" then	--控制文字颜色
					oldcolor=tcolor;
					tcolor=M_White;
				elseif cv=="black" or cv=="b" then
					oldcolor=tcolor;
					tcolor=M_Black;
				elseif cv=="red" then
					oldcolor=tcolor;
					tcolor=M_Red;
				elseif cv=="orange" then
					oldcolor=tcolor;
					tcolor=M_Orange;
				elseif cv=="green" then
					oldcolor=tcolor;
					tcolor=M_Lime;
				elseif cv=="yellow" then
					oldcolor=tcolor;
					tcolor=M_Yellow;
				elseif cv=="wheat" then
					oldcolor=tcolor;
					tcolor=M_Wheat;
				elseif cv=="name" then
					oldcolor=tcolor;
					tcolor=C_Name;
				elseif cv=="normal" then
					tcolor=oldcolor;
				elseif cv=="White" or cv=="W"then	--控制文字背景颜色
					oldbg=bgcolor;
					bgcolor=M_White;
				elseif cv=="Black" or cv=="B" then
					oldbg=bgcolor;
					bgcolor=M_Black;
				elseif cv=="Red" then
					oldbg=bgcolor;
					bgcolor=M_Red;
				elseif cv=="Orange" then
					oldbg=bgcolor;
					bgcolor=M_Orange;
				elseif cv=="Green" then
					oldbg=bgcolor;
					bgcolor=M_Green;
				elseif cv=="Yellow" then
					oldbg=bgcolor;
					bgcolor=M_Yellow;
				elseif cv=="Wheat" then
					oldbg=bgcolor;
					bgcolor=M_Wheat;
				elseif cv=="Name" then
					oldbg=bgcolor;
					bgcolor=C_Name;
				elseif cv=="Normal" then
					bgcolor=oldbg;
				elseif cv=="tao" then
					cv=13620;
				elseif cv=="xing" then
					cv=13621;
				elseif cv=="mei" then
					cv=13622;
				elseif cv=="fang" then
					cv=13623;
				end
				local cn=tonumber(cv);
				if cn~=nil then
					add(cn);
				end
			else	--异常，退出
				return;
			end
		else
			local v="";
			local nwidth;
			if string.byte(tv)<128 then	--英文以及数字
				v=tv;
				str=string.sub(str,2,-1);
			else	--汉字
				v=string.sub(str,1,3);
				str=string.sub(str,4,-1);
			end
			add(CC.Font[v] or 0);
		end
	end
	--针对最后一行
	twidth[row]=width;
	local maxheight;
	if row==1 then
		maxheight=size;
	else
		maxheight=(size+math.floor(size/10))*row;
	end
	--X/Y
	local maxwidth=0;
	for i,v in ipairs(dt) do
		for j,vv in ipairs(v) do
			vv.x=vv.x-twidth[i]*xadj;
			vv.y=vv.y-maxheight*yadj;
		end
		if twidth[i]>maxwidth then
			maxwidth=twidth[i];
		end
	end
	return dt,maxwidth,maxheight;
end
function DrawStringEnhance(x,y,str,color,size,xadj,yadj,widthlim,alpha)
	local dt=DrawStringEnhanceInit(str,color,size,xadj,yadj,widthlim);
	DrawStringEnhanceSub(x,y,dt,size,alpha);
end
function DrawNumPic(x,y,num1,num2,color)
	--只有一个数字时，x为/的居中点,y还是顶端
	--有两个数字时，显示 xxx/yyy的格式，x为/的居中点,y还是顶端
	color=color or 'yellow';
	local width=8;
	local cx=x;
	local pic=50;
	local t={};
	if num2==nil then
		local flag=false;
		if num1<0 then
			num1=-num1;
			flag=true;
		end
		while true do
			if num1>=10 then
				local v=num1%10;
				table.insert(t,1,v);
				num1=math.floor(num1/10);
			else
				table.insert(t,1,num1);
				break;
			end
		end
		if flag then
			table.insert(t,1,-1);
		end
		cx=x-width*#t/2;
	else
		while true do
			if num1>=10 then
				local v=num1%10;
				table.insert(t,1,v);
				num1=math.floor(num1/10);
			else
				table.insert(t,1,num1);
				break;
			end
		end
		cx=x-width*(#t+0.5);
		table.insert(t,-1);
		local n=1+#t;
		while true do
			if num2>=10 then
				local v=num2%10;
				table.insert(t,n,v);
				num2=math.floor(num2/10);
			else
				table.insert(t,n,num2);
				break;
			end
		end
	end
	if color=='red' then
		pic=102;
	elseif color=='blue' then
		pic=91;
	end
	for i,v in pairs(t) do
		lib.PicLoadCache(4,(pic+v)*2,cx+width*(i-1),y,1);
	end
end
function DrawNumPicBig(x,y,num1,num2,color)
	--只有一个数字时，x为/的居中点,y还是顶端
	--有两个数字时，显示 xxx/yyy的格式，x为/的居中点,y还是顶端
	color=color or 'yellow';
	local width=13;
	local cx=x;
	local pic=400;
	local t={};
	if num2==nil then
		local flag=false;
		if num1<0 then
			num1=-num1;
			flag=true;
		end
		while true do
			if num1>=10 then
				local v=num1%10;
				table.insert(t,1,v);
				num1=math.floor(num1/10);
			else
				table.insert(t,1,num1);
				break;
			end
		end
		cx=x-width*#t/2;
		if flag then
			table.insert(t,1,11);
			cx=cx-width;
		end
	else
		while true do
			if num1>=10 then
				local v=num1%10;
				table.insert(t,1,v);
				num1=math.floor(num1/10);
			else
				table.insert(t,1,num1);
				break;
			end
		end
		cx=x-width*(#t+0.5);
		table.insert(t,10);
		local n=1+#t;
		while true do
			if num2>=10 then
				local v=num2%10;
				table.insert(t,n,v);
				num2=math.floor(num2/10);
			else
				table.insert(t,n,num2);
				break;
			end
		end
	end
	if color=='red' then
		pic=420;
	elseif color=='blue' then
		pic=440;
	end
	for i,v in pairs(t) do
		lib.PicLoadCache(4,(pic+v)*2,cx+width*(i-1),y,1);
	end
end
function LoadPicFrame(fileid,picid,x,y,w,h,frame)
	lib.SetClip(x,y,x+w,y+h);
	lib.PicLoadCache(fileid,picid,x-w*frame,y,1);
	lib.SetClip(0,0,0,0);
end
function LoadPicEnhance(picid,x,y,w,h,flag)
	if flag then
		x=x-w/2;
		y=y-h/2;
	end
	picid=picid*2;
	if w==nil then
		lib.PicLoadCache(4,picid,x,y,1);
	elseif h==nil then
		local picw,pich=lib.PicGetXY(4,picid);
		--Left
		lib.SetClip(x,y,x+w/2,y+pich);
		lib.PicLoadCache(4,picid,x,y,1);
		--Right
		lib.SetClip(x+w/2,y,x+w,y+pich);
		lib.PicLoadCache(4,picid,x+w-picw,y,1);
		lib.SetClip(0,0,0,0);
	else
		local picw,pich=lib.PicGetXY(4,picid);
		--Left Top
		lib.SetClip(x,y,x+w/2,y+h/2);
		lib.PicLoadCache(4,picid,x,y,1);
		--Left Bot
		lib.SetClip(x,y+h/2,x+w/2,y+h);
		lib.PicLoadCache(4,picid,x,y+h-pich,1);
		--Right Top
		lib.SetClip(x+w/2,y,x+w,y+h/2);
		lib.PicLoadCache(4,picid,x+w-picw,y,1);
		--Right Bot
		lib.SetClip(x+w/2,y+h/2,x+w,y+h);
		lib.PicLoadCache(4,picid,x+w-picw,y+h-pich,1);
		lib.SetClip(0,0,0,0);
	end
end
function DrawPJ(lv,cx,cy,color,size)
	DrawStringEnhance(cx,cy,"品级",color,size);
	local pj_str;
	local pj_color=color;
	if lv==1 then
		pj_str="Ｃ";
		pj_color=C_WHITE;
	elseif lv==2 then
		pj_str="Ｂ";
		pj_color=C_WHITE;
	elseif lv==3 then
		pj_str="Ａ";
		pj_color=M_Yellow;
	elseif lv==4 then
		pj_str="Ｓ";
		pj_color=C_ORANGE;
	else
		pj_str="Ｄ";
		pj_color=M_Gray;
	end
	DrawStringEnhance(cx+size*2.5+1,cy-1,pj_str,M_Gray,size);
	DrawStringEnhance(cx+size*2.5,cy,pj_str,pj_color,size);
	cy=cy+size+2;
end
function DrawPersonStatusMini_Sub(pid,x,y)
	local pw,ph=240,292;
	local p=JY.Person[pid];
	local size=20;
	local cx=x or (CC.ScreenW-pw);
	local cy=y or ((CC.ScreenH-ph)/2);
	LoadPicEnhance(73,cx,cy,pw,ph);
	lib.PicLoadCache(2,(p["容貌"]+2000)*2,cx+pw/2-48,cy+4,1);
	cx=cx+40;
	cy=cy+132;
	DrawStringEnhance(cx,cy,p["名称"].." "..p["字"],C_WHITE,size);
	cy=cy+size+2;
	DrawPJ(p["品级"],cx,cy,C_Name,size);
	cy=cy+size+2;
	for i,v in pairs({"统率","武力","智谋","政务","魅力"}) do
		DrawStringEnhance(cx,cy,v,C_Name,size);
		local pic=213;
		if p[v]>=70 then
			pic=215;
		elseif p[v]>=30 then
			pic=214;
		end
		lib.SetClip(cx+size*2.5,cy,cx+size*2.5+p[v]+16,cy+24);
		lib.PicLoadCache(4,pic*2,cx+size*2.5,cy+2,1);
		lib.SetClip(0,0,0,0);
		DrawNumPic(cx+size*2.5+math.max(p[v],8),cy+4,p[v]);
		cy=cy+size+2;
	end
end
function Glass(x1,y1,x2,y2,col,alpha)
	if alpha~=nil then
		lib.Background(x1+3,y1+3,x2-2,y2-2,alpha,col);
	end
	lib.Gauss(x1,y1,x2,y2,20);
end
function GetAllCityList()
	local plist={};
	for i=1,JY.CityNum-1 do
		table.insert(plist,i);
	end
	return plist;
end
function GetAllForceList()
  local plist = {};
  for i = 1, JY.ForceNum - 1 do
    if JY.Force[i]["状态"] > 0 then
      table.insert(plist, i);
    end
  end
  return plist;
end
function GetForceWujiang(fid, disablelist)
  local order = "身份";
	disablelist = disablelist or {}
	local function inlist(pid)
		for i, v in pairs(disablelist) do
			if pid == v then
				return true;
			end
		end
		return false;
	end
	local plist = {};
	for pid = 0, 750 do
		if JY.Person[pid]["势力"] == fid and JY.Person[pid]["登场"]==3 and JY.Person[pid]["身份"]>0 and (not inlist(pid)) then
			table.insert(plist,pid);
		end
	end
	table.sort(plist,function(a,b) 
						if JY.Person[a][order]>JY.Person[b][order] then
							return true;
						end
					end)
	return plist;
end
function GetForceCityList(fid)
	local plist={};
	for i=1,JY.CityNum-1 do
		if JY.City[i]["势力"]==fid then
			table.insert(plist,i);
		end
	end
	return plist;
end
function GetMoveCity(cid)
	local plist={};
	for i=1,JY.ConnectionNum-1 do
		if JY.Connection[i]["都市1"]==cid then
			local cid2=JY.Connection[i]["都市2"];
			table.insert(plist,JY.Connection[i]["都市2"]);
		end
	end
	return plist;
end
function GetAtkCity(cid)
	local plist={};
	local fid=JY.City[cid]["势力"];
	for i=1,JY.ConnectionNum-1 do
		if JY.Connection[i]["都市1"]==cid then
			local cid2=JY.Connection[i]["都市2"];
			if JY.City[cid2]["势力"]~=fid then
				table.insert(plist,JY.Connection[i]["都市2"]);
			end
		end
	end
	return plist;
end
function GetCityWujiang(cid,disablelist)
	local order="身份";
	disablelist=disablelist or {}
	local function inlist(pid)
		for i,v in pairs(disablelist) do
			if pid==v then
				return true;
			end
		end
		return false;
	end
	local plist={};
	local fid=JY.FID;
	for pid=0,750 do
		if JY.Person[pid]["所在"]==cid and between(JY.Person[pid]["登场"],2,3) and (not inlist(pid)) then
			table.insert(plist,pid);
		end
	end
	table.sort(plist,function(a,b) 
						if JY.Person[a][order]>JY.Person[b][order] then
							return true;
						end
					end)
	return plist;
end
function GetCityXianyi(cid,disablelist)
	local order="身份";
	disablelist=disablelist or {}
	local function inlist(pid)
		for i,v in pairs(disablelist) do
			if pid==v then
				return true;
			end
		end
		return false;
	end
	local plist={};
	local fid=JY.FID;
	for pid=0,750 do
		if JY.Person[pid]["所在"]==cid and JY.Person[pid]["登场"]==3 and JY.Person[pid]["身份"]>0 and (not inlist(pid)) then
			table.insert(plist,pid);
		end
	end
	table.sort(plist,function(a,b) 
						if JY.Person[a][order]>JY.Person[b][order] then
							return true;
						end
					end)
	return plist;
end
function GetCityZaiye(cid,disablelist)
	disablelist=disablelist or {}
	local function inlist(pid)
		for i,v in pairs(disablelist) do
			if pid==v then
				return true;
			end
		end
		return false;
	end
	local plist={};
	local fid=JY.FID;
	for pid=0,750 do
		if JY.Person[pid]["所在"]==cid and JY.Person[pid]["登场"]==2 and JY.Person[pid]["身份"]==0 and (not inlist(pid)) then
			table.insert(plist,pid);
		end
	end
	return plist;
end
function GetMyList(order,disablelist)
	order=order or "名声";
	disablelist=disablelist or {}
	local function inlist(pid)
		for i,v in pairs(disablelist) do
			if pid==v then
				return true;
			end
		end
		return false;
	end
	local plist={};
	local fid=JY.FID;
	for pid=0,750 do
		if fid>0 and JY.Person[pid]["势力"]==fid and (not inlist(pid)) and pid~=JY.Force[fid]["君主"] then
			table.insert(plist,pid);
		end
	end
	table.sort(plist,function(a,b) 
						if JY.Person[a][order]>JY.Person[b][order] then
							return true;
						end
					end)
	if not inlist(JY.Force[fid]["君主"]) then
		table.insert(plist,1,JY.Force[fid]["君主"]);
	end
	return plist;
end
function GetZaiyeList(...)
	local id={};
	for i,v in pairs({...}) do
		id[i]=v;
	end
	local function inlist(pid)
		for i,v in pairs(id) do
			if pid==v then
				return true;
			end
		end
		return false;
	end
	local plist={};
	for pid=0,750 do
		if JY.Person[pid]["势力"]==0 and JY.Person[pid]["登场"]==2 and (not inlist(pid)) then
			table.insert(plist,pid);
		end
	end
	return plist;
end
function GetAllList(...)
	local id={};
	for i,v in pairs({...}) do
		id[i]=v;
	end
	local function inlist(pid)
		for i,v in pairs(id) do
			if pid==v then
				return true;
			end
		end
		return false;
	end
	local plist={};
	for pid=1,750 do
		if between(JY.Person[pid]["登场"],0,4) and (not inlist(pid)) then
			table.insert(plist,pid);
		end
	end
	return plist;
end
function GetWarList()
	local plist={};
	plist.label={"我军","友军","敌军"}
	plist[1]={};plist[2]={};plist[3]={};
	for i,v in pairs(War.Person) do
		if v.enemy then
			table.insert(plist[3],v.id);
		elseif v.friend then
			table.insert(plist[2],v.id);
		else
			table.insert(plist[1],v.id);
		end
	end
	return plist;
end
function creatNumPad(x,y,v,minv,maxv)
	--width|height = 
	local np={x=x,y=y,val=v,minv=minv,maxv=maxv,old_flag=true,bt={}}
	local width,height=56,36;
	local x0,y0=x+18,y+14;
	table.insert(np.bt,button_creat(0,7,x0,y0+height,"7",true,true));
	table.insert(np.bt,button_creat(0,8,x0+width,y0+height,"8",true,true));
	table.insert(np.bt,button_creat(0,9,x0+width*2,y0+height,"9",true,true));
	table.insert(np.bt,button_creat(0,11,x0+width*3,y0+height,"←BS",true,true));
	table.insert(np.bt,button_creat(0,4,x0,y0+height*2,"4",true,true));
	table.insert(np.bt,button_creat(0,5,x0+width,y0+height*2,"5",true,true));
	table.insert(np.bt,button_creat(0,6,x0+width*2,y0+height*2,"6",true,true));
	table.insert(np.bt,button_creat(0,13,x0+width*3,y0+height*2,"Max",true,true));
	table.insert(np.bt,button_creat(0,1,x0,y0+height*3,"1",true,true));
	table.insert(np.bt,button_creat(0,2,x0+width,y0+height*3,"2",true,true));
	table.insert(np.bt,button_creat(0,3,x0+width*2,y0+height*3,"3",true,true));
	table.insert(np.bt,button_creat(0,12,x0+width*3,y0+height*3,"Min",true,true));
	table.insert(np.bt,button_creat(0,0,x0,y0+height*4,"0",true,true));
	table.insert(np.bt,button_creat(0,10,x0+width,y0+height*4,"00",true,true));
	table.insert(np.bt,button_creat(1,14,x0+width*2+3,y0+height*4,"决定",true,true));
	return np;
end
function drawNumPad(np)
	LoadPicEnhance(114,np.x,np.y,256,208);
	lib.Background(np.x+48,np.y+4,np.x+208,np.y+36,128);
	DrawStringEnhance(np.x+192,np.y+4,"[B]"..np.val,C_WHITE,28,1);
	button_redraw(np.bt);
end
function eventNumPad(np)
	local event,btid=button_event(np.bt);
	if event==3 then
		if btid==10 then
			if np.old_flag then
				np.val=0;
				np.old_flag=false;
			else
				np.val=np.val*100;
			end
		elseif btid==11 then
			np.val=math.floor(np.val/10);
		elseif btid==12 then
			np.val=np.minv;
		elseif btid==13 then
			np.val=np.maxv;
		elseif btid==14 then
			return true;
		else
			if np.old_flag then
				np.val=btid;
				np.old_flag=false;
			else
				np.val=np.val*10+btid;
			end
		end
		np.val=limitX(np.val,np.minv,np.maxv);
	end
	return false;
end
function creatScrollBar(x,y,height,minv,maxv,shownum)
	local sb={	x1=x-2,x2=x+3,y1=y,y2=y+height+1,
				bx1=x-8,bx2=x+9,
				show=true,on=false,hold=false,	}
	--maxv-minv越大 h越小
	--shownum越大 h越大
	local h=height*shownum/(maxv-minv);
	h=limitX(h,36,h*4/5);
	h=math.floor(h/2)*2;
	sb.h=h;
	sb.h1=sb.y1+h/2;
	sb.h2=sb.y2-h/2;
	sb.minv=minv;
	sb.maxv=maxv-shownum+1;
	if sb.maxv<=sb.minv then
		sb.show=false;
	end
	sb.cur=sb.h1;
	sb.old=sb.cur;
	sb.val=minv;--sb.minv+math.floor(	(sb.maxv-sb.minv)*(sb.cur-sb.h1)/sb.h	);
	return sb;
end
function drawScrollBar(sb)
		lib.FillColor(sb.x1,sb.y1,sb.x2,sb.y2,M_Gray);
	if sb.show then
		--lib.FillColor(sb.x1,sb.y1,sb.x2,sb.y2,9408395);
		--lib.FillColor(sb.x1+2,sb.y1+2,sb.x2-2,sb.y2-2,3158064);
			lib.FillColor(sb.bx1-1,sb.cur-sb.h/2-1,sb.bx2+1,sb.cur+sb.h/2+1,6184023);
			--lib.FillColor(sb.bx1,sb.cur-sb.h/2,sb.bx2-1,sb.cur+sb.h/2-1,16711422);
		if sb.hold then
			lib.FillColor(sb.bx1,sb.cur-sb.h/2,sb.bx2,sb.cur+sb.h/2,M_White);
		elseif sb.on then
			lib.FillColor(sb.bx1,sb.cur-sb.h/2,sb.bx2,sb.cur+sb.h/2,C_WHITE);
		else
			lib.FillColor(sb.bx1,sb.cur-sb.h/2,sb.bx2,sb.cur+sb.h/2,14407370);
		end	
	end
end
function eventScrollBar(sb)
	if sb.show then
		if MOUSE.IN(sb.bx1,sb.cur-sb.h/2,sb.bx2,sb.cur+sb.h/2) then
			sb.on=true;
		else
			sb.on=false;
		end
		if sb.hold then
			if MOUSE.status=='HOLD' then
				sb.cur=limitX(sb.old+MOUSE.y-MOUSE.hy,sb.h1,sb.h2);
				sb.val=sb.minv+math.floor(	(sb.maxv-sb.minv)*(sb.cur-sb.h1)/(sb.h2-sb.h1)	);
				return true;
			else
				sb.hold=false;
			end
		else
			if sb.on then
				if MOUSE.HOLD(sb.bx1,sb.cur-sb.h/2,sb.bx2,sb.cur+sb.h/2) then
					sb.old=sb.cur;
					sb.hold=true;
				end
			end
		end
	end
	return false;
end
function rollScrollBar(sb,idx)
	sb.val=math.min(idx,sb.maxv);
	if sb.val<=sb.minv then
		sb.cur=sb.h1;
	elseif sb.val>=sb.maxv then
		sb.cur=sb.h2;
	else
		sb.cur=sb.h1+math.floor(	0.999+(sb.h2-sb.h1)*(sb.val-sb.minv)/(sb.maxv-sb.minv)	);
	end
end
function creatSingleList(x,y,width,height,indexlist,strlist,title)
	local sl={	x1=x,x2=x+width,y1=y+36,y2=y+36+height,width=width,
				index=indexlist,str=strlist,maxn=#indexlist,
				top=1,on=0,hold=0,select=1,val=indexlist[1],
				title="[B]"..title,tx=x+width/2,ty=y+18,	}
	--计算实际可以显示的list数量	一行31像素
	sl.pixel_row=31;
	local num=math.floor(height/sl.pixel_row);
	sl.shownum=num;
	sl.str_x=math.floor(x+width/2);
	sl.str_yoff=16;
	--link ScrollBar
	sl.sb=creatScrollBar(x+width+12,y,36+height,1,sl.maxn,sl.shownum);
	return sl;
end
function drawSingleList(sl)
	for i=1,math.min(sl.shownum,sl.maxn-sl.top+1) do
		local y=sl.y1+sl.pixel_row*(i-1);
		local idx=sl.top+i-1;
		if idx==sl.hold then
			LoadPicEnhance(71,sl.x1,y-5,sl.width);
		elseif idx==sl.on then
			LoadPicEnhance(70,sl.x1,y-5,sl.width);
		end
		LoadPicEnhance(72,sl.x1,y+27,sl.width);
		if idx==sl.select then
			DrawStringEnhance(sl.str_x,y+sl.str_yoff,"[Red]"..sl.str[idx],C_WHITE,20,0.5,0.5);
		else
			DrawStringEnhance(sl.str_x,y+sl.str_yoff,sl.str[idx],C_WHITE,20,0.5,0.5);
		end
	end
	drawScrollBar(sl.sb);
	--draw title
	LoadPicEnhance(205,sl.tx,sl.ty,sl.width,36,true);
	DrawStringEnhance(sl.tx,sl.ty,sl.title,C_Name,24,0.5,0.5);
end
function eventSingleList(sl)
	if eventScrollBar(sl.sb) then
		sl.top=sl.sb.val;
	end
	sl.on=0;
	sl.hold=0;
	for i=1,math.min(sl.shownum,sl.maxn-sl.top+1) do
		local y1=sl.y1+sl.pixel_row*(i-1)+2;
		local y2=y1+sl.pixel_row-6;
		local idx=sl.top+i-1;
		if MOUSE.CLICK(sl.x1,y1,sl.x2,y2) then
			PlayWavE(0);
			sl.on=idx;
			sl.hold=idx;
			sl.select=idx;
			sl.val=sl.index[idx];
			return true;
		elseif MOUSE.HOLD(sl.x1,y1,sl.x2,y2) then
			sl.on=idx;
			sl.hold=idx;
			return false;
		elseif MOUSE.IN(sl.x1,y1,sl.x2,y2) then
			sl.on=idx;
			return false;
		end
	end
	return false;
end
function rollSingleList(sl,idx)
	rollScrollBar(sl.sb,idx);
	sl.select=idx;
	sl.val=sl.index[idx];
	sl.top=math.max(math.min(idx,sl.maxn-sl.shownum+1),1);
end
function creatMultiList(x,y,width,height,indexlist,sortlist,strlist,title,offset)
	local ml={	x1=x,x2=x+width,y1=y+30,y2=y+30+height,width=width,
				index=indexlist,sort=sortlist,sortkey=0,str=strlist,maxn=#indexlist,
				top=1,on=0,hold=0,select=0,val=indexlist[1],multi=1,selnum=0,sellist={},
				title=title,offset=offset,ty=y+14,	}
	--计算实际可以显示的list数量	一行31像素
	ml.pixel_row=31;
	local num=math.floor(height/ml.pixel_row);
	ml.shownum=num;
	ml.str_x=math.floor(x+(width-offset[#offset]-offset[1])/2);
	ml.str_yoff=16;
	--link ScrollBar
	ml.sb=creatScrollBar(x+width+12,y+30,ml.pixel_row*num,1,ml.maxn,ml.shownum);
	return ml;
end
function drawMultiList(ml)
	for i=1,math.min(ml.shownum,ml.maxn-ml.top+1) do
		local y=ml.y1+ml.pixel_row*(i-1);
		local idx=ml.top+i-1;
		if idx==ml.hold then
			LoadPicEnhance(71,ml.x1,y-5,ml.width);
		elseif idx==ml.on then
			LoadPicEnhance(70,ml.x1,y-5,ml.width);
		end
		LoadPicEnhance(72,ml.x1,y+27,ml.width);
		local index=ml.index[idx];
		if ml.multi>1 then
			if ml.sellist[index] then
				for j,v in ipairs(ml.str[index]) do
					DrawStringEnhance(ml.str_x+ml.offset[j],y+ml.str_yoff,"[Red]"..v,C_WHITE,20,0.5,0.5);
				end
			elseif ml.selnum<ml.multi then
				for j,v in ipairs(ml.str[index]) do
					DrawStringEnhance(ml.str_x+ml.offset[j],y+ml.str_yoff,v,C_WHITE,20,0.5,0.5);
				end
			else
				for j,v in ipairs(ml.str[index]) do
					DrawStringEnhance(ml.str_x+ml.offset[j],y+ml.str_yoff,v,M_Gray,20,0.5,0.5);
				end
			end
		else
			if idx==ml.select then
				for j,v in ipairs(ml.str[index]) do
					DrawStringEnhance(ml.str_x+ml.offset[j],y+ml.str_yoff,"[Red]"..v,C_WHITE,20,0.5,0.5);
				end
			else
				for j,v in ipairs(ml.str[index]) do
					DrawStringEnhance(ml.str_x+ml.offset[j],y+ml.str_yoff,v,C_WHITE,20,0.5,0.5);
				end
			end
		end
	end
	if ml.sb.show then
		drawScrollBar(ml.sb);
		LoadPicEnhance(74,ml.x1,ml.y1-30,ml.width+24);
	else
		LoadPicEnhance(74,ml.x1,ml.y1-30,ml.width);
	end
	--draw title
	for j,v in ipairs(ml.title) do
		if MOUSE.IN(ml.str_x+ml.offset[j]-6*#v,ml.ty-12,ml.str_x+ml.offset[j]+6*#v,ml.ty+12) then
			DrawStringEnhance(ml.str_x+ml.offset[j],ml.ty,"[Yellow]"..v,C_BLACK,24,0.5,0.5);
		else
			DrawStringEnhance(ml.str_x+ml.offset[j],ml.ty,v,C_BLACK,24,0.5,0.5);
		end
	end
end
function eventMultiList(ml)
	if eventScrollBar(ml.sb) then
		ml.top=ml.sb.val;
	end
	ml.on=0;
	ml.hold=0;
	for i=1,math.min(ml.shownum,ml.maxn-ml.top+1) do
		local y1=ml.y1+ml.pixel_row*(i-1)+2;
		local y2=y1+ml.pixel_row-6;
		local idx=ml.top+i-1;
		if MOUSE.CLICK(ml.x1,y1,ml.x2,y2) then
			PlayWavE(0);
			ml.on=idx;
			local index=ml.index[idx];
			if ml.multi>1 then
				if ml.sellist[index] then
					ml.sellist[index]=nil;
					ml.selnum=ml.selnum-1;
				elseif ml.selnum<ml.multi then
					ml.sellist[index]=true;
					ml.selnum=ml.selnum+1;
				else
					return false;
				end
			else
				if ml.select==idx then
					ml.select=0;
				else
					ml.select=idx;
					ml.val=ml.index[idx];
				end
			end
			return true;
		elseif MOUSE.HOLD(ml.x1,y1,ml.x2,y2) then
			ml.on=idx;
			ml.hold=idx;
			return false;
		elseif MOUSE.IN(ml.x1,y1,ml.x2,y2) then
			ml.on=idx;
			return false;
		end
	end
	--sort
	for j,v in ipairs(ml.title) do
		if MOUSE.CLICK(ml.str_x+ml.offset[j]-6*#v,ml.ty-12,ml.str_x+ml.offset[j]+6*#v,ml.ty+12) then
			table.sort(ml.index,function(a,b)
									if ml.sort[a][j]==ml.sort[b][j] then
										return a<b
									elseif ml.sortkey==j then
										return ml.sort[a][j]<ml.sort[b][j];
									else
										return ml.sort[a][j]>ml.sort[b][j];
									end
								end)
			if ml.sortkey==j then
				ml.sortkey=0;
			else
				ml.sortkey=j;
			end
			PlayWavE(0);
			break;
		end
	end
	return false;
end
function rollMultiList(ml,idx)
	rollScrollBar(ml.sb,idx);
	ml.select=idx;
	ml.val=ml.index[idx];
	ml.top=math.max(math.min(idx,ml.maxn-ml.shownum+1),1);
end
function ShowCityList(plist,flag)
	local kind=1;
	local sortlist={};
	local strlist={};
	local offset={};
	local title={};
	local lstr="";
	local tx,ty;
	local cid,sid=0,0;
	--init
	for i=1,JY.CityNum-1 do
		JY.City[i]["标记"]=0;
	end
	for i,v in ipairs(plist) do
		JY.City[v]["标记"]=1;
	end
	if kind==0 then
	
	else
		title = {       "都市", "州域",  "势力", "太守","现役","兵力","资金","物资","开发","商业","技术","防御","治安"};
    local widths = {50,     50,    80,     80,    50,    80,    80,     80,    50,    50,    50,    50,   50};
    offset[1] = 0;
    for i = 2, #widths do
      offset[i] = offset[i - 1] + (widths[i - 1] + widths[i]) / 2;
    end
		--offset={0,   50,  100,   150,    320,  390,    460,   520,   590,   650,   700,  750,    800}
		for i,v in ipairs(plist) do
			sortlist[v]={v,JY.City[v]["州"],JY.City[v]["势力"],JY.City[v]["太守"],JY.City[v]["现役"],JY.City[v]["兵力"],JY.City[v]["资金"],JY.City[v]["物资"],JY.City[v]["开垦"],JY.City[v]["商业"],JY.City[v]["技术"],JY.City[v]["防御"],JY.City[v]["治安"]};
			strlist[v]={"--","--","--","--","--","--","--","--","--","--","--","--","--",};
			strlist[v][1]=JY.City[v]["名称"];
			local id=JY.City[v]["州"];
			strlist[v][2]=JY.Str[9030+id];
			id=JY.City[v]["势力"];
			if id>0 then
				strlist[v][3]=JY.Force[id]["名称"];
			end
			id=JY.City[v]["太守"];
			if id>0 then
				strlist[v][4]=JY.Person[id]["名称"];
			end
			strlist[v][5] = JY.City[v]["现役"].."";
			strlist[v][6] = JY.City[v]["兵力"].."";
			strlist[v][7] = (JY.City[v]["资金"] * 10).."";
			strlist[v][8] = (JY.City[v]["物资"] * 10).."";
			strlist[v][9] = math.floor(JY.City[v]["开垦"] / 2).."";
			strlist[v][10] = math.floor(JY.City[v]["商业"] / 2).."";
			strlist[v][11] = math.floor(JY.City[v]["技术"] / 2).."";
			strlist[v][12] = math.floor(JY.City[v]["防御"] / 2).."";
			strlist[v][13] = math.floor(JY.City[v]["治安"] / 10).."";
		end
	end
	local width=960;
	local height=480;
	local x0=(CC.ScreenW-width)/2;
	local y0=(CC.ScreenH-height)/2;
	local bt={};
	if flag==0 then
		button_mainbt_1(bt,"返回",2)
	elseif flag==1 then
		button_mainbt_2(bt,"决定","返回",1,2);
	elseif flag==2 then
		button_mainbt_1(bt,"决定",1)
	end
	local ml=creatMultiList(x0+48,y0+16,840,height-64,plist,sortlist,strlist,title,offset)
	local function redraw()
		DrawGame();
		LoadPicEnhance(73,x0,y0,width,height);
		drawMultiList(ml);
		button_redraw(bt);
	end
	while true do
		local t1=lib.GetTime();
		if flag>0 then
			if sid>0 then
				bt[2].enable=true;
			else
				bt[2].enable=false;
			end
		end
		redraw();
		ShowScreen();
		local delay=CC.FrameNum-lib.GetTime()+t1;
		if delay>0 then
			lib.Delay(delay);
		end
		getkey();
		if eventMultiList(ml) then
			if flag==0 then
				DrawCityStatus(plist,ml.select);
				ml.select=0;
			elseif ml.select>0 then
				sid=plist[ml.select];
			else
				sid=0;
			end
		end
		local event,btid=button_event(bt);
		if event==3 then
			if btid==1 then
				return sid;
			elseif btid==2 then
				return 0;
			end
		end
	end
end
function ShowPersonList(plist,order,fun,multi,t_select)
	multi=multi or 0;
	local sel_num=0;
	local s={};
	local per={};
	local size=20;
	local size2=20;
	s[6]={	str="",
			txtdx=0,
			pic=18,
			enable=true;
			x1=CC.ScreenW/2-84+50,
			y1=CC.ScreenH-81+8,
			x2=CC.ScreenW/2-84+50+66,
			y2=CC.ScreenH-81+8+46}
	if multi>0 then
		s[6].pic=24;
	end
	local topid=1;
	local sheet=1;
	--sort
	if order~=nil then
		table.sort(plist,function(a,b) if JY.Person[a][order]>JY.Person[b][order] then return true end end)
	end
	local t_person={};
	local t_person2={}
	for i,v in pairs(plist) do
		local flag=0;
		if multi>0 then
			for ii,vv in pairs(t_select) do
				if vv==v then
					flag=1;
					sel_num=limitX(sel_num+1,0,multi);
					break;
				end
			end
		end
		table.insert(t_person,{pid=v,select=flag});
		table.insert(t_person2,v);
	end
	local sb=creatScrollBar(900,100,400,1,#t_person,12);
	local function GetPerson()
		per={};
		local num=0;
		local t_index=0;
		local dy=100;
		for i=topid,math.min(topid+11,#t_person) do
			local p=JY.Person[t_person[i].pid];
			table.insert(per,
							{
								x1=96,y1=dy,
								x2=864,y2=dy+31,
								str1=p["名称"],str2=string.format("Lv%02d",p["等级"]),str3="",
								par1_1=0,par1_2=0,
								par2_1=0,par2_2=0,
								par11=p["武力"],par12=p["智谋"],par13=p["统率"],par14=p["政务"],par15=p["魅力"],
								c3="yellow",c4="yellow",c5="yellow",c6="yellow",c7="yellow",
								headid=p["容貌"]+2000,
								id=t_person[i].pid,
								t_person_index=i;
								select=t_person[i].select,
							}
						)
			dy=dy+31;
		end
	end
	local current=0;
	local hold=false;
	local function redraw()
		--lib.PicLoadCache(5,200*2,0,0,1);
		DrawGame();
		--
		LoadPicEnhance(73,48,56,864,432);
		--Glass(48,56,48+864,56+432,C_BLACK,192);
		LoadPicEnhance(74,72,64,816);
		local par_x={	32,		108,	172,	252,	332,	400,	460,	520,	580,	640,}
		local att_name={};
		att_name={"姓名",	"友好",	"身份",	"官爵",	"策略",	"武力",	"智谋",	"统率",	"政务",	"魅力"}
		for i,v in pairs(att_name) do
			DrawStringEnhance(96+par_x[i]-#v*size/4,68,v,C_BLACK,size);
		end
		LoadPicEnhance(72,96,96,768);
		for i,v in pairs(per) do
			if current==i+100 then
				if hold then
					LoadPicEnhance(71,v.x1,v.y1-5,768);
				else
					LoadPicEnhance(70,v.x1,v.y1-5,768);
				end
			end
			LoadPicEnhance(72,v.x1,v.y1+27,768);
			if multi>0 then
				if v.select>0 then
					lib.PicLoadCache(4,131*2,v.x1-10,v.y1+6,1);
					DrawStringEnhance(v.x1+par_x[1]-size2*#v.str1/4+1,v.y1+14-size2/2+1,v.str1,M_Red,size2);
					DrawStringEnhance(v.x1+par_x[1]-size2*#v.str1/4,v.y1+14-size2/2,v.str1,C_WHITE,size2);
				elseif sel_num>=multi then
					lib.PicLoadCache(4,132*2,v.x1-10,v.y1+6,1);
					DrawStringEnhance(v.x1+par_x[1]-size2*#v.str1/4,v.y1+14-size2/2,v.str1,M_Gray,size2);
				else
					lib.PicLoadCache(4,130*2,v.x1-10,v.y1+6,1);
					DrawStringEnhance(v.x1+par_x[1]-size2*#v.str1/4,v.y1+14-size2/2,v.str1,C_WHITE,size2);
				end
			else
				DrawStringEnhance(v.x1+par_x[1]-size2*#v.str1/4,v.y1+14-size2/2,v.str1,C_WHITE,size2);
			end
			DrawStringEnhance(v.x1+par_x[2]-size2*#v.str2/4,v.y1+14-size2/2,v.str2,C_WHITE,size2);
			DrawStringEnhance(v.x1+par_x[3]-size2*#v.str3/4,v.y1+14-size2/2,v.str3,C_WHITE,size2);
			DrawNumPic(v.x1+par_x[4],v.y1+10,v.par1_1,v.par1_2);
			DrawNumPic(v.x1+par_x[5],v.y1+10,v.par2_1,v.par2_2);
				DrawNumPic(v.x1+par_x[6],v.y1+10,v.par11,nil);
				DrawNumPic(v.x1+par_x[7],v.y1+10,v.par12,nil);
				DrawNumPic(v.x1+par_x[8],v.y1+10,v.par13,nil);
				DrawNumPic(v.x1+par_x[9],v.y1+10,v.par14,nil);
				DrawNumPic(v.x1+par_x[10],v.y1+10,v.par15,nil);
			if current==i+100 then
				lib.PicLoadCache(2,v.headid*2,4,v.y1-48,1);
			end
		end
		
		lib.PicLoadCache(4,10*2,s[6].x1-50,s[6].y1-8,1);
		for i,v in pairs(s) do
			if v.enable then
				if current==i then
					if hold then
						lib.PicLoadCache(4,(v.pic+2)*2,v.x1,v.y1,1);
						DrawStringEnhance(v.x1+v.txtdx-#v.str*size/4+1,v.y1+7,v.str,C_BLACK,size);
					else
						lib.PicLoadCache(4,(v.pic+1)*2,v.x1,v.y1,1);
						DrawStringEnhance(v.x1+v.txtdx-#v.str*size/4,v.y1+6,v.str,C_BLACK,size);
					end
				else
					lib.PicLoadCache(4,v.pic*2,v.x1,v.y1,1);
					DrawStringEnhance(v.x1+v.txtdx-#v.str*size/4,v.y1+6,v.str,C_BLACK,size);
				end
			else
				lib.PicLoadCache(4,(v.pic+3)*2,v.x1,v.y1,1);
				DrawStringEnhance(v.x1+v.txtdx-#v.str*size/4,v.y1+6,v.str,C_WHITE,size);
			end
		end
		--滚动条
		drawScrollBar(sb);
	end
	
	GetPerson();
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
		if eventScrollBar(sb) then
			topid=sb.val;
			GetPerson();
		end
		for i,v in pairs(per) do
			if MOUSE.CLICK(v.x1,v.y1,v.x2,v.y2) then
				current=i+100;
				if multi>0 then
					if v.select==1 then
						PlayWavE(1);
						v.select=0;
						t_person[v.t_person_index].select=0;
						sel_num=limitX(sel_num-1,0,multi);
					elseif v.select==0 then
						if sel_num<multi then
							PlayWavE(0);
							v.select=1;
							t_person[v.t_person_index].select=1;
							sel_num=limitX(sel_num+1,0,multi);
						else
							PlayWavE(2);
						end
					else
						PlayWavE(2);
					end
				else
					PlayWavE(0);
					if fun==1 then
						local r=PersonStatus(t_person2,topid+i-1);
						if r>0 then
							return r;
						end
					elseif fun==2 then
						local r=PersonStatus(t_person2,topid+i-1,true);
						if r>0 then
							return r;
						end
					else
						return v.id;
					end
				end
			elseif MOUSE.HOLD(v.x1,v.y1,v.x2,v.y2) then
				current=i+100;
				hold=true;
				break;
			elseif MOUSE.IN(v.x1,v.y1,v.x2,v.y2) then
				current=i+100;
				break;
			end
		end
		for i,v in pairs(s) do
			if v.enable then
				if MOUSE.CLICK(v.x1,v.y1,v.x2,v.y2) then
					current=i;
					PlayWavE(0);
					if current==6 then
						if multi>0 then
							t_select={};
							for ii,vv in pairs(t_person) do
								if vv.select==1 then
									table.insert(t_select,vv.pid);
								end
							end
							return t_select;
						else
							return -1;
						end
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
end
function ShowPersonList(plist,order,fun,multi,t_select)
	local width=750;
	local height=433;
	local x0=math.floor((CC.ScreenW-width)/2);
	local y0=math.floor((CC.ScreenH-height)/2);
	local sortlist={};
	local strlist={};
	local title=	{"姓名","好感","势力","所在","身份",	"统","武","智","政","魅",	"官爵","指挥","步","弓","骑"};
	local size=		{80,64,80,64,64,						32,32,32,32,32,				80,64,32,32,32};
	local offset={0};
	for i=2,#size do
		offset[i]=offset[i-1]+(size[i]+size[i-1])/2
	end
	for i,v in ipairs(plist) do
		local p=JY.Person[v];
		sortlist[v]={v,p["好感"],100-p["势力"],100-p["所在"],p["身份"],p["统率"],p["武力"],p["智谋"],p["政务"],p["魅力"],JY.Title[p["官爵"]]["Rank"],GetMaxBingli(v),p["步兵适性"],p["弓兵适性"],p["骑兵适性"]};
		strlist[v]={p["名称"],""..p["好感"],JY.Force[p["势力"]]["名称"],JY.City[p["所在"]]["名称"],JY.Str[9170+p["身份"]],
					""..p["统率"],""..p["武力"],""..p["智谋"],""..p["政务"],""..p["魅力"],
					JY.Title[p["官爵"]]["名称"],""..GetMaxBingli(v),JY.Str[9160+p["步兵适性"]],JY.Str[9160+p["弓兵适性"]],JY.Str[9160+p["骑兵适性"]],};
		
	end
	local ml=creatMultiList(x0,y0,width,height,plist,sortlist,strlist,title,offset);
	if multi then
		ml.multi=multi;
		ml.selnum=#t_select;
		for i,v in ipairs(t_select) do
			ml.sellist[v]=true;
		end
	end
	local bt={};
	local flag=1;
	if flag==0 then
		button_mainbt_1(bt,"返回",2)
	elseif flag==1 then
		button_mainbt_2(bt,"决定","返回",1,2);
	elseif flag==2 then
		button_mainbt_1(bt,"决定",1)
	end
	local function redraw()
		DrawGame();
		LoadPicEnhance(73,x0-32,y0-8,width+64,height+16);
		drawMultiList(ml);
		if ml.on>0 then
			lib.PicLoadCache(2,(JY.Person[plist[ml.on]]["容貌"]+2000)*2,ml.x1-45,ml.y1+ml.pixel_row*(ml.on-ml.top+0.5));
		end
		button_redraw(bt);
	end
	while true do
		local t1=lib.GetTime();
		if #plist>0 then
			bt[2].enable=true;
		else
			bt[2].enable=false;
		end
		redraw();
		ShowScreen();
		local delay=CC.FrameNum-lib.GetTime()+t1;
		if delay>0 then
			lib.Delay(delay);
		end
		getkey();
		if eventMultiList(ml) then
			local sel=plist[ml.select];
			if multi then
				
			else
				if fun==1 then
					local r=PersonStatus(plist,ml.select);
					if r>0 then
						return r;
					end
				elseif fun==2 then
					local r=PersonStatus(plist,ml.select,true);
					if r>0 then
						return r;
					end
				else
					return sel;
				end
			end
			ml.select=0;
		end
		local event,btid=button_event(bt);
		if event==3 then
			if btid==1 then
				if multi then
					local r={};
					for i,v in pairs(ml.sellist) do
						table.insert(r,i);
					end
					return r;
				else
					return plist[ml.select];
				end
			elseif btid==2 then
				return -1;
			elseif btid==11 then
			
			end
		end
	end
end
function NewPerson(pid)
	PersonStatus(pid,true)
end
function IrwinHall(avg,std,n)
	n=n or 12;
	local v=0;
	for i=1,n*2 do
		v=v+math.random();
	end
	v=v-n;
	local v2=math.floor(avg+std*v*2);
	v=math.floor(avg+std*v);
	v=math.min(v,v2);
	v=limitX(v,0,100);
	return v;
end
function Confirm(tstr,str)
	local size=24;
	local maxlen=24;
	local dt,width,height=DrawStringEnhanceInit(str,M_White,size,0,0,size*maxlen);
    local w=math.max(width,18*#tstr,320)+36*2;
	local h=math.max(height+24+44+20+54,240);
	local x0,y0=(CC.ScreenW-w)/2,(CC.ScreenH-h)/2;
	local bt={};
	button_mainbt_1(bt,"确认",1,CC.ScreenH-y0-58);
	local function redraw()
		DrawGame();
		local x,y=x0,y0;
		Glass(x,y,x+w,y+h,C_BLACK,192);		x,y=x+36,y+24;
		DrawStringEnhance(x0+120,y+18,tstr,M_White,32,0.5,0.5);		y=y+44;
		lib.PicLoadCache(4,44*2,x0+24,y,1);		y=y+16;
		DrawStringEnhanceSub(x,y,dt,size);
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
		local event,btid=button_event(bt);
		if event==3 then
			if btid==1 then
				return;
			end
		end
	end
end
function ConfirmYesNo(tstr,str)
    local size=24;
	local maxlen=24;
	local dt,width,height=DrawStringEnhanceInit(str,M_White,size,0,0,size*maxlen);
    local w=math.max(width,18*#tstr,320)+36*2;
	local h=math.max(height+24+44+20+54,240);
	local x0,y0=(CC.ScreenW-w)/2,(CC.ScreenH-h)/2;
	local bt={};
	button_mainbt_2(bt,"决定","返回",1,2,CC.ScreenH-y0-58);
	local function redraw()
		DrawGame();
		local x,y=x0,y0;
		--Glass(x,y,x+w,y+h,C_BLACK,192);		x,y=x+36,y+24;
		LoadPicEnhance(73,x-40,y,w+80,h);		x,y=x+36,y+24;
		DrawStringEnhance(x0+120,y+18,tstr,M_White,32,0.5,0.5);		y=y+44;
		lib.PicLoadCache(4,44*2,x0+24,y,1);		y=y+16;
		DrawStringEnhanceSub(x,y,dt,size);
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
function DrawSMap()
	local size=20;
	lib.FillColor(0,0,0,0,0);
	if JY.SubScene>=0 then
		local w,h=lib.PicGetXY(5,JY.SubScene*2);
		lib.PicLoadCache(5,JY.SubScene*2,(CC.ScreenW-w)/2,(CC.ScreenH-h)/2,1);
		if JY.SubPic>=0 then
			w,h=lib.PicGetXY(5,JY.SubPic*2);
			local x=(CC.ScreenW-w)/2;
			local y=(CC.ScreenH-h)/2-56;
			lib.PicLoadCache(5,JY.SubPic*2,x,y,1);
		end
	end
end
function creatGameStatus()
	local gs={
				x1=64,y1=CC.ScreenH-48,on=false,ontime=128,
				x2=CC.ScreenW-256-4,y2=CC.ScreenH-200-4,on2=false,ontime2=128,
			}
	return gs;
end
function eventGameStatus(gs)
	if MOUSE.CLICK(gs.x1-48,gs.y1-48,gs.x1+48,gs.y1+48) then
		PlayWavE(0);
		PersonStatus({JY.PID},1);
	elseif MOUSE.IN(gs.x1-48,gs.y1-48,gs.x1+48,gs.y1+48) then
		gs.on=true;
	else
		gs.on=false;
	end
	if MOUSE.CLICK(gs.x2,gs.y2,gs.x2+192,gs.y2+256) then
		PlayWavE(0);
		DrawCityStatus({JY.Person[JY.PID]["所在"]},1);
	elseif MOUSE.IN(gs.x2,gs.y2,gs.x2+192,gs.y2+256) then
		gs.on2=true;
	else
		gs.on2=false;
	end
end
function drawGameStatus(gs)
	local x,y=gs.x1,gs.y1;
	if gs.on then
		gs.ontime=gs.ontime+4;
		if gs.ontime>=256 then
			gs.ontime=0;
		end
	else
		if gs.ontime==128 then
			
		elseif gs.ontime>=136 then
			gs.ontime=gs.ontime-8;
		elseif gs.ontime<=120 then
			gs.ontime=gs.ontime+8;
		else
			gs.ontime=128;
		end
	end
	local f=JY.Force[JY.FID];
	local p=JY.Person[JY.PID];
	lib.PicLoadCache(4,6*2,x-32,y+16,1);
	lib.PicLoadCache(2,(p["容貌"]+6000)*2,x,y);
	if gs.ontime~=128 then
		lib.PicLoadCache(2,(p["容貌"]+6000)*2,x,y,2+8,math.abs(gs.ontime-128));
	end
	x=x+128;y=y+18;
	DrawStringEnhance(x,y,chinese_year_month(),C_Name,24,0.5);
	x=x+120;
	DrawStringEnhance(x,y,JY.Str[9170+p["身份"]],C_Name,24,0.5);
	x=x+180;
	DrawStringEnhance(x,y,"资金",C_Name,24,1);
	DrawStringEnhance(x,y," ".."500",C_WHITE,24);
	x=x+180;
	DrawStringEnhance(x,y,"行动力",C_Name,24,1);
	DrawStringEnhance(x,y," "..JY.Base["行动力"],C_WHITE,24);
	--[[DrawStringEnhance(x,y,"行动力",C_Name,20,0.5);					DrawNumPicBig(x+60,y-1,JY.Base["行动力"]);		x=x+130;
	DrawStringEnhance(x,y,"现役",C_Name,20,0.5);					DrawNumPicBig(x+60,y-1,f["现役"]);		x=x+130;
	DrawStringEnhance(x,y,"城池",C_Name,20,0.5);					DrawNumPicBig(x+60,y-1,f["城池"]);		x=x+130;
	DrawStringEnhance(x,y,"资金",C_Name,20,0.5);					DrawNumPicBig(x+60,y-1,f["资金"]*10);		x=x+130;
	DrawStringEnhance(x,y,"物资",C_Name,20,0.5);					DrawNumPicBig(x+60,y-1,f["物资"]*10);		x=x+130;]]--
	--DrawCCityM(CC.ScreenW-400,64,true);
	--DrawCityStatus
	local x,y=gs.x2,gs.y2;
	if gs.on2 then
		gs.ontime2=gs.ontime2+4;
		if gs.ontime2>=256 then
			gs.ontime2=0;
		end
	else
		if gs.ontime2==128 then
			
		elseif gs.ontime2>=136 then
			gs.ontime2=gs.ontime2-8;
		elseif gs.ontime2<=120 then
			gs.ontime2=gs.ontime2+8;
		else
			gs.ontime2=128;
		end
	end
  --
	local cid=JY.Person[JY.PID]["所在"];
	local c=JY.City[cid];
	local size=18;
	if gs.ontime2~=128 then
		lib.Background(x+4,y+2,x+256-4,y+200-4,256-math.abs(gs.ontime2-128)/2,M_White)
	end
	LoadPicEnhance(78,x,y,256,200);
	LoadPicEnhance(44,x,y+42,256);
	x=x+12;
	DrawStringEnhance(x+96,y+8,"[B][wheat]"..c["名称"],C_WHITE,32,0.5);		lib.PicLoadCache(4,(600+c["势力"])*2,x+4,y+12,1);  y=y+52;
	DrawStringEnhance(x,y,"太守",C_Name,size);					DrawStringEnhance(x + 80,y,JY.Person[c["太守"]]["名称"],C_WHITE,size,0.5);		x = x + 120;
	DrawStringEnhance(x,y,"势力",C_Name,size);					DrawStringEnhance(x + 80,y,JY.Force[c["势力"]]["名称"],C_WHITE,size,0.5);			x = x - 120; y = y + size + 2;
	DrawStringEnhance(x,y,"资金",C_Name,size);					DrawStringEnhance(x + 80,y,c["资金"].."0",C_WHITE,size,0.5);		x = x + 120;	
	DrawStringEnhance(x,y,"物资",C_Name,size);					DrawStringEnhance(x + 80,y,c["物资"].."0",C_WHITE,size,0.5);		x = x - 120; y = y + size + 2;
	DrawStringEnhance(x,y,"开垦",C_Name,size);					DrawStringEnhance(x + 80,y,math.floor(c["开垦"]/2).."/"..math.floor(c["最大开垦"]/2),C_WHITE,size,0.5);		x = x + 120;
	DrawStringEnhance(x,y,"商业",C_Name,size);					DrawStringEnhance(x + 80,y,math.floor(c["商业"]/2).."/"..math.floor(c["最大商业"]/2),C_WHITE,size,0.5);		x = x - 120; y = y + size + 2;
	DrawStringEnhance(x,y,"技术",C_Name,size);					DrawStringEnhance(x + 80,y,math.floor(c["技术"]/2).."/"..math.floor(c["最大技术"]/2),C_WHITE,size,0.5);		x = x + 120;
	DrawStringEnhance(x,y,"防御",C_Name,size);					DrawStringEnhance(x + 80,y,math.floor(c["防御"]/2).."/"..math.floor(c["最大防御"]/2),C_WHITE,size,0.5);		x = x - 120; y = y + size + 2;
	DrawStringEnhance(x,y,"治安",C_Name,size);					DrawStringEnhance(x + 80,y,math.floor(c["治安"]/10).."/100",C_WHITE,size,0.5);		x = x + 120;
	DrawStringEnhance(x,y,"人口",C_Name,size);					DrawStringEnhance(x + 80,y,c["人口"].."00",C_WHITE,size,0.5);		x = x - 120; y = y + size + 2;
	DrawStringEnhance(x,y,"兵力",C_Name,size);					DrawStringEnhance(x + 80,y,c["兵力"].."",C_WHITE,size,0.5);		x = x + 120;
	DrawStringEnhance(x,y,"训练",C_Name,size);					DrawStringEnhance(x + 80,y,c["兵力"].."",C_WHITE,size,0.5);		x = x - 120; y = y + size + 2;
	DrawStringEnhance(x,y,"现役",C_Name,size);					DrawStringEnhance(x + 80,y,c["现役"].."",C_WHITE,size,0.5);		x = x + 120;
	DrawStringEnhance(x,y,"在野",C_Name,size);					DrawStringEnhance(x + 80,y,c["在野"].."",C_WHITE,size,0.5);		x = x - 120; y = y + size + 2;
  --
  x, y = 0, 0;
  DrawCCityS(0, 0);
  
  
  --lib.PicLoadCache(4, 700 * 2, x, y, 1, nil, 0, 203);
  
end
function drawbar(x,y,v)
		local w=60;
		local max_v=250;
		local c1=RGB(187,180,182);
		local c2=RGB(247,242,231);
		lib.Background(x,y,x+w*4,y+7,128);
		lib.DrawRect(x,y+5,x+w-2,y+5,c1);
		lib.DrawRect(x+w,y+5,x+w*2-2,y+5,c1);
		lib.DrawRect(x+w*2,y+5,x+w*3-2,y+5,c1);
		lib.DrawRect(x+w*3,y+5,x+w*4-2,y+5,c1);
		
		lib.DrawRect(x+w-2,y,x+w-2,y+4,c1);
		lib.DrawRect(x+w*2-2,y,x+w*2-2,y+4,c1);
		lib.DrawRect(x+w*3-2,y,x+w*3-2,y+4,c1);
		for i=0,3 do
			if v-max_v*i>0 then
				lib.FillColor(x+w*i,y,x+w*i+math.floor((w-2)*limitX((v-max_v*i)/max_v,0,1)),y+5,c2);
			end
		end
end
function DrawGame()
	--[[if JY.Status==GAME_WMAP or JY.Status==GAME_WARWIN or JY.Status==GAME_WARLOSE then
		DrawWarMap();
	elseif JY.Status==GAME_SMAP_MANUAL then
		DrawCity();
	else
		DrawSMap();
	end]]--
	if JY.SubScene>0 then
		DrawSMap();
	else
		DrawCity();
	end
	if JY.DG.pid>=0 then
		DrawPersonStatusMini_Sub(JY.DG.pid);
	end
end
function DrawCity(cid)
	cid=cid or JY.Person[JY.PID]["所在"];
	local x0,y0=0,CC.ScreenH-768;
	local tx={};
	local ty={};
	local tpic={};
	--西北 全部坐标矫正完毕
	--其余都市，基本设施坐标校正完毕，剩余特殊设施
	--全部城墙遮蔽 尚未校正
	if between(cid,48,50) then					--南蛮
		--		背景	城		河流	装饰	装饰2	宫城	装饰3	农地	市场	工房	驻所	城墙	酒家	兵营	自宅	特1		特2		特3		遮罩小	遮罩中	遮罩大	遮罩巨
		tx={	0,		176,	0,		000,	354,	460,	640,	28,		396,	320,	236,	244,	500,	440,	364,	208,	588,	472,	0,		0,		0,		0};
		ty={	0,		216,	628,	000,	156,	316,	288,	368,	384,	436,	452,	520,	420,	456,	508,	344,	412,	450,	0,		0,		0,		0};
		tpic={	341,	345,	0,		000,	000,	499,	000,	503,	494,	498,	505,	497,	504,	493,	496,	623,	627,	624,	0,		0,		0,		0};
	elseif JY.City[cid]["地方"]==1 then			--河北
		--		背景	城		河流	装饰	装饰2	宫城	装饰3	农地	市场	工房	驻所	城墙	酒家	兵营	自宅	特1		特2		特3		遮罩小	遮罩中	遮罩大	遮罩巨
		tx={	0,		0,		0,		0,		356,	460,	640,	28,		396,	320,	236,	244,	500,	440,	364,	376,	692,	484,	596,	0,		0,		608};
		ty={	0,		176,	628,	0,		156,	316,	288,	368,	384,	436,	452,	520,	420,	456,	508,	316,	428,	460,	440,	0,		0,		508};
		tpic={	331,	335,	0,		0,		000,	486,	720,	490,	481,	485,	492,	484,	491,	480,	483,	541,	547,	545,	403,	0,		0,		404};
	elseif JY.City[cid]["地方"]==2 then		--中原
		--		背景	城		河流	装饰	装饰2	宫城	装饰3	农地	市场	工房	驻所	城墙	酒家	兵营	自宅	特1		特2		特3		遮罩
		tx={	0,		0,		0,		380,	0,		460,	0,		28,		396,	320,	236,	244,	500,	440,	364,	640,	540,	728,	0,		0,		520,	0};
		ty={	0,		192,	628,	248,	0,		316,	0,		368,	384,	436,	452,	520,	420,	456,	508,	348,	416,	364,	0,		0,		524,	0};
		tpic={	301,	305,	0,		701,	0,		446,	0,		450,	441,	445,	452,	444,	451,	440,	443,	617,	600,	614,	0,		0,		370,	0};
	elseif JY.City[cid]["地方"]==3 then		--西北
		--		背景	城		河流	装饰	装饰2	宫城	装饰3	农地	市场	工房	驻所	城墙	酒家	兵营	自宅	特1		特2		特3		遮罩
		tx={	0,		0,		0,		0,		609,	460,	640,	28,		396,	320,	236,	244,	500,	440,	364,	592,	836,	480,	0,		0,		480,	0};
		ty={	0,		232,	528,	0,		144,	316,	288,	368,	384,	436,	452,	520,	420,	456,	508,	408,	368,	460,	0,		0,		592,	0};
		tpic={	351,	355,	0,		0,		0,		512,	729,	516,	507,	511,	518,	510,	517,	506,	509,	574,	567,	566,	0,		0,		416,	0};
	elseif JY.City[cid]["地方"]==4 then		--巴蜀
		--		背景	城		河流	装饰	装饰2	宫城	装饰3	农地	市场	工房	驻所	城墙	酒家	兵营	自宅	特1		特2		特3		遮罩
		tx={	0,		0,		0,		380,	0,		460,	0,		28,		396,	320,	236,	244,	500,	440,	364,	484,	644,	701,	0,		0,		596,	0};
		ty={	0,		192,	632,	248,	0,		316,	0,		368,	384,	436,	452,	520,	420,	456,	508,	452,	340,	424,	0,		0,		440,	0};
		tpic={	321,	325,	0,		715,	0,		472,	0,		476,	467,	471,	478,	470,	477,	466,	469,	634,	636,	633,	0,		0,		393,	0};
	elseif JY.City[cid]["地方"]==5 then		--楚
		--		背景	城		河流	装饰	装饰2	宫城	装饰3	农地	市场	工房	驻所	城墙	酒家	兵营	自宅	特1		特2		特3		遮罩
		tx={	0,		0,		0,		380,	0,		460,	0,		28,		396,	320,	236,	244,	500,	440,	364,	548,	664,	495,	0,		0,		0,		492};
		ty={	0,		208,	552,	248,	0,		316,	0,		368,	384,	436,	452,	520,	420,	456,	508,	420,	420,	492,	0,		0,		0,		584};
		tpic={	361,	365,	0,		734,	0,		525,	0,		529,	520,	524,	531,	523,	530,	519,	522,	581,	579,	585,	0,		0,		0,		426};
	elseif JY.City[cid]["地方"]==6 then		--吴越
		--		背景	城		河流	装饰	装饰2	宫城	装饰3	农地	市场	工房	驻所	城墙	酒家	兵营	自宅	特1		特2		特3		遮罩
		tx={	0,		0,		0,		0,		548,	460,	640,	28,		396,	320,	236,	244,	500,	440,	364,	546,	732,	668,	0,		0,		0,		0};
		ty={	0,		220,	528,	0,		592,	316,	288,	368,	384,	436,	452,	520,	420,	456,	508,	416,	364,	432,	0,		0,		0,		0};
		tpic={	311,	315,	0,		0,		392,	459,	709,	463,	454,	458,	465,	457,	464,	453,	456,	565,	553,	558,	0,		0,		0,		0};
	end
	--
	if JY.City[cid]["规模"]==1 then
		tpic[16]=0;tpic[17]=0;tpic[18]=0;
		tpic[20]=0;tpic[21]=0;tpic[22]=0;
		if JY.City[cid]["地方"]==6 then
			tpic[5]=0;
		end
	elseif JY.City[cid]["规模"]==2 then
		tpic[2]=tpic[2]+1;
		tpic[6]=tpic[6]+1;
		tpic[17]=0;tpic[18]=0;
		tpic[21]=0;tpic[22]=0;
	elseif JY.City[cid]["规模"]==3 then
		tpic[2]=tpic[2]+2;
		tpic[6]=tpic[6]+2;
		tpic[18]=0;
		tpic[22]=0;
	elseif JY.City[cid]["规模"]==4 then
		tpic[2]=tpic[2]+3;
		tpic[6]=tpic[6]+3;
	end
	if cid==1 then		--辽东
		tpic[1]=332;
		tpic[5]=402;
		tpic[7]=722;
	elseif cid==2 then		--北平
		tpic[1]=332;
		tpic[5]=402;
	elseif cid==3 then		--薊
		tpic[1]=332;
		tpic[7]=721;
	elseif cid==4 then		--渤海
	elseif cid==5 then		--平原
	elseif cid==6 then		--邺
		tpic[6]=479;
		tpic[7]=725;
	elseif cid==7 then		--晋阳
		tpic[5]=402;
	elseif cid==8 then		--上党
		tpic[5]=402;
		tpic[7]=724;
	elseif cid==10 then		--北海
		tpic[7]=723;
	elseif cid==11 then		--濮阳
		tpic[3]=304;
		tpic[4]=707;
	elseif cid==12 then		--陈留
		tpic[1]=302;
		tpic[4]=705;
	elseif cid==13 then		--下邳
		tpic[1]=302;
	elseif cid==14	then	--小沛
		tpic[1]=302;
		tpic[4]=704;
	elseif cid==16	then	--许昌
		tpic[1]=302;
		tpic[4]=706;
	elseif cid==17	then	--汝南
		tpic[1]=302;
	elseif cid==18	then	--洛阳
		tpic[1]=302;
		tpic[4]=702;
	elseif cid==20 then		--长安
		tpic[1]=352;
		tpic[5]=730;
	elseif cid==21 then		--天水
		tpic[1]=352;
	elseif cid==22 then		--西平
		tpic[7]=733;
	elseif cid==23 then		--西凉/武威
		tpic[3]=354;
		tpic[7]=731;
	elseif cid==25 then		--寿春
		--tpic[3]=304;
		tpic[1]=312;
		tpic[3]=314;
		tpic[7]=712;
	elseif cid==26 then		--庐江
		--tpic[3]=304;
		tpic[1]=312;
		tpic[3]=314;
		tpic[7]=712;
	elseif cid==27 then		--建业
		tpic[1]=312;
		tpic[3]=314;
		tpic[7]=712;
	elseif cid==28 then		--吴
		tpic[1]=312;
		tpic[3]=314;
		tpic[7]=713;
	elseif cid==29 then		--会稽
		tpic[5]=0;
		tpic[7]=714;
	elseif cid==31 then		--柴桑
		tpic[1]=312;
		tpic[3]=314;
		tpic[7]=710;
	elseif cid==32 then		--宛
		tpic[1]=362;
		tpic[4]=737;
	elseif cid==33 then		--新野
		tpic[1]=362;
	elseif cid==34 then		--襄阳
		tpic[3]=364;
		tpic[4]=738;
	elseif cid==35 then		--上庸
		tpic[3]=364;
	elseif cid==36 then		--江夏
		tpic[3]=364;
	elseif cid==37 then		--江陵
		tpic[3]=364;
		tpic[4]=735;
	elseif cid==38 then		--长沙
		tpic[1]=363;
	elseif cid==39 then		--武陵
	elseif cid==40 then		--桂阳
		tpic[1]=363;
	elseif cid==41 then		--零陵
		tpic[1]=363;
		tpic[4]=736;
	elseif cid==42 then		--汉中
		tpic[1]=322;
	elseif cid==43 then		--武都
		tpic[1]=322;
		tpic[4]=717;
	elseif cid==44 then		--永安
		tpic[3]=324;
	elseif cid==45 then		--涪/梓潼
		tpic[4]=716;
	elseif cid==46 then		--巴/江州
		tpic[4]=718;
	elseif cid==47 then		--成都
		tpic[4]=719;
	elseif cid==48 then		--建宁
		tpic[7]=728;
	elseif cid==49 then		--永昌
		tpic[7]=726;
	elseif cid==50 then		--三江/云南
		tpic[7]=727;
	end
	if cid==JY.Person[JY.PID]["所在"] then
		tpic[15]=tpic[15]-1;
	end
	--
	lib.FillColor(0,0,0,0,0);
	local fid=JY.City[cid]["势力"];
	local xid=0;
	if fid>0 then
		xid=GetFlagID(JY.Force[fid]["君主"]);
	end
	if fid==4 or fid==8 or fid==11 or fid==12 
		or fid==14 or fid==16 or fid==19 or fid==23 
		or fid==24 or fid==26 or fid==27 or fid==30 
		or fid==33 or fid==36 or fid==38 or fid==39 
		or fid==42 or fid==43 or fid==45 or fid==48 
		or fid==50 or fid==51 then
		xid=xid+459;
	else
		xid=xid+662;
	end
	local frame=math.floor(os.clock()*4)%4;
	for i=1,11 do
		lib.PicLoadCache(5,tpic[i]*2,tx[i],ty[i]+y0,1);
	end
	LoadPicFrame(5,801*2,372,403+y0,48,56,math.floor(os.clock()*4)%8);
	WarDrawFlag(244,531+y0,fid,xid,5,frame);
	for i=12,#tpic do
		lib.PicLoadCache(5,tpic[i]*2,tx[i],ty[i]+y0,1);
	end
	WarDrawFlag(307,552+y0,fid,xid,5,frame);
end
function creatCityMenu()
	local x0,y0=0,CC.ScreenH-768;
	local cm={
				cx=	{620,	280,	470,	424,	356,	300,	590,	534,	466},
				cy=	{400+y0,	440+y0,	450+y0,	486+y0,	540+y0,	620+y0,	470+y0,	516+y0,	580+y0},
				cstr=	{"[B]宫城","[B]农地","[B]市场","[B]工房","[B]驻所","[B]城门","[B]酒家","[B]兵营","[B]自宅"},
				on=0,
				mu=nil,
				};
	return cm;
end
function drawCityMenu(cm)
	for i=1,#cm.cstr do
		if i==cm.on then
			DrawStringEnhance(cm.cx[i],cm.cy[i],cm.cstr[i],M_Yellow,26,0.5,0.5);
		else
			DrawStringEnhance(cm.cx[i],cm.cy[i],cm.cstr[i],C_WHITE,24,0.5,0.5);
		end
	end
	if cm.mu then
		drawMenu(cm.mu);
	end
end
function eventCityMenu(cm)
	if cm.mu then
		local r=eventMenu(cm.mu);
		if r>=0 then
			cm.mu=nil;
		end
		if r>0 then
			cm.on=0;
			return r;
		else
			return 0;
		end
	else
		for i=1,#cm.cstr do
			if MOUSE.CLICK(cm.cx[i]-36,cm.cy[i]-18,cm.cx[i]+36,cm.cy[i]+18) then
				cm.on=i;
				local p=JY.Person[JY.PID];
				local cid=p["所在"];
				local c=JY.City[cid];
				local mymune={};
				if i==1 then
					mymune={	{"政厅",101,between(p["身份"],1,3),true and JY.Base["行动力"]>0},
								{"出征",111,p["身份"]>=0,JY.Base["行动力"]>0},
								{"仕官",102,p["身份"]==0,JY.Base["行动力"]>0},
								{"官爵",104,p["身份"]>0,JY.Base["行动力"]>0},
								{"测试太守",105,p["身份"]>=0,JY.Base["行动力"]>0},
								{"访问",103,true,c["现役"]>0 and JY.Base["行动力"]>0},	}
				elseif i==2 then
					mymune={	{"开垦",201,true,true and JY.Base["行动力"]>0},
								{"见闻",202,true,true and JY.Base["行动力"]>0},
								{"会话",209,false,false and JY.Base["行动力"]>0},	}
				elseif i==3 then
					mymune={	{"商业",301,true,true and JY.Base["行动力"]>0},
								{"购买",302,true,false and JY.Base["行动力"]>0},
								{"卖出",303,true,false and JY.Base["行动力"]>0},
								{"见闻",309,true,true and JY.Base["行动力"]>0},	}
				elseif i==4 then
					mymune={	{"技术",401,true,true and JY.Base["行动力"]>0},
								{"见闻",409,true,true and JY.Base["行动力"]>0},
								{"会话",403,false,false and JY.Base["行动力"]>0},	}
				elseif i==5 then
					mymune={	{"治安",501,true,true and JY.Base["行动力"]>0},
								{"见闻",509,true,true and JY.Base["行动力"]>0},
								{"会话",503,false,false and JY.Base["行动力"]>0},	}
				elseif i==6 then
					mymune={	{"修补",601,true,true and JY.Base["行动力"]>0},
								{"增筑",602,true,false and JY.Base["行动力"]>0},
								{"见闻",609,true,true and JY.Base["行动力"]>0},	}
				elseif i==7 then
					mymune={	{"宴会",701,true,false and JY.Base["行动力"]>0},
								{"委托",702,true,false and JY.Base["行动力"]>0},
								{"访问",703,true,((p["身份"]>0 and c["在野"]>0) or c["在野"]>1) and JY.Base["行动力"]>0},
								{"见闻",709,true,true and JY.Base["行动力"]>0},	}
				elseif i==8 then
					mymune={	{"募兵",801,true,false and JY.Base["行动力"]>0},
								{"训练",802,true,false and JY.Base["行动力"]>0},
								{"见闻",809,true,true and JY.Base["行动力"]>0},	}
				elseif i==9 then
					mymune={	{"锻炼",901,true,JY.Base["行动力"]>0},
								{"下野",902,between(p["身份"],1,2),false and JY.Base["行动力"]>0},
								{"迁居",903,p["身份"]==0,true and JY.Base["行动力"]>0},
								{"休息",909,true,true},	}
				end
				cm.mu=creatMenu(cm.cx[i]+36,cm.cy[i],0,0.5,mymune);
				PlayWavE(0);
				return 0;
			elseif MOUSE.IN(cm.cx[i]-36,cm.cy[i]-18,cm.cx[i]+36,cm.cy[i]+18) then
				cm.on=i;
				return 0;
			end
		end
		cm.on=0;
		return 0;
	end
end
function creatMenu(x,y,x_adj,y_adj,item)
	local newitem={}
	for i=1,#item do
		if item[i][3] then
			table.insert(newitem,item[i]);
		end
	end
	local width=96;
	local height=36*#newitem+8;
	local mu={x=x-width*x_adj,y=y-height*y_adj,width=width,height=height,item=newitem,on=0}
	return mu;
end
function drawMenu(mu)
	LoadPicEnhance(78,mu.x,mu.y,mu.width,mu.height);
	local x=mu.x+mu.width/2;
	local y=mu.y+18;
	local x1=mu.x+12;
	local x2=x1+mu.width-24;
	for i=1,#mu.item do
		if not mu.item[i][4] then
			DrawStringEnhance(x,y,mu.item[i][1],M_Gray,22,0.5,0.5);
			lib.FillColor(x1,y+11,x2,y+12,M_Gray);
		elseif mu.on==i then
			DrawStringEnhance(x,y,mu.item[i][1],M_Yellow,24,0.5,0.5);
			lib.FillColor(x1,y+11,x2,y+12,M_Yellow);
		else
			DrawStringEnhance(x,y,mu.item[i][1],C_WHITE,22,0.5,0.5);
			lib.FillColor(x1,y+11,x2,y+12,C_WHITE);
		end
		y=y+36;
	end
end
function eventMenu(mu)
	mu.on=0;
	local x1=mu.x+12;
	local x2=x1+mu.width-24;
	local y1=mu.y+6;
	local y2=y1+24;
	for i=1,#mu.item do
		if MOUSE.CLICK(x1,y1,x2,y2) then
			mu.on=i;
			if mu.item[i][4] then
				PlayWavE(0);
				return mu.item[i][2];
			else
				PlayWavE(2);
				return -1;
			end
		elseif MOUSE.IN(x1,y1,x2,y2) then
			mu.on=i;
			return -1;
		end
		y1=y1+36;y2=y2+36;
	end
	if (not MOUSE.IN(mu.x,mu.y,mu.x+mu.width,mu.y+mu.height)) and MOUSE.CLICK(MOUSE.x-8,MOUSE.y-8,MOUSE.x+8,MOUSE.y+8) then
		PlayWavE(1);
		return 0;
	end
	return -1;
end
function DrawPolygon(num,T,sx,sy,length,color,size)
	local cx,cy;
	local angle;
	local p={};
	local pp={};
	local ppp={};
	local pz={};
	local Sur={};
	if num<3 then
		return;
	end
	sx=math.floor(sx);
	sy=math.floor(sy);
	length=math.floor(length/2-2);
	cx=sx+length;
	cy=sy+length;
	angle=math.pi*2/num;
	--确定点坐标
	for i=1,num do
		p[i]={
					x=cx+length*limitX(T[i]/100+0.0,0,1.1)*math.cos(angle*(i-1)-math.pi/2),
					y=cy+length*limitX(T[i]/100+0.0,0,1.1)*math.sin(angle*(i-1)-math.pi/2),
				};
		pz[i]={
					x=cx+length*limitX(T[i]/100+0.15,0.3,1.1)*math.cos(angle*(i-1)-math.pi/2),
					y=cy+length*limitX(T[i]/100+0.12,0.3,1.1)*math.sin(angle*(i-1)-math.pi/2),
				};
	end
	p[num+1]=p[1];
	for i=1,num do
		pp[i]={
					x=cx+length*math.cos(angle*(i-1)-math.pi/2),
					y=cy+length*math.sin(angle*(i-1)-math.pi/2),
				};
	end
	pp[num+1]=pp[1];
	for n=1,4 do
		ppp[n]={}
		for i=1,num do
			ppp[n][i]={
						x=cx+length*n/5*math.cos(angle*(i-1)-math.pi/2),
						y=cy+length*n/5*math.sin(angle*(i-1)-math.pi/2),
					};
		end
		ppp[n][num+1]=ppp[n][1];
	end
	--基准
	for n=1,4 do
		for i=1,num do
			lib.DrawLine(ppp[n][i].x,ppp[n][i].y,ppp[n][i+1].x,ppp[n][i+1].y,M_Gray);
		end
	end
	--外围
	for i=1,num do
		--lib.DrawLine(pp[i].x-1,pp[i].y,pp[i+1].x-1,pp[i+1].y,M_Gray);
		--lib.DrawLine(pp[i].x,pp[i].y-1,pp[i+1].x,pp[i+1].y-1,M_Gray);
		--lib.DrawLine(pp[i].x+1,pp[i].y,pp[i+1].x+1,pp[i+1].y,M_Gray);
		--lib.DrawLine(pp[i].x,pp[i].y+1,pp[i+1].x,pp[i+1].y+1,M_Gray);
		lib.DrawLine(pp[i].x,pp[i].y,pp[i+1].x,pp[i+1].y,M_Gray);
	end
	--基准线
	for i=1,num do
		--lib.DrawLine(cx-1,cy,pp[i].x-1,pp[i].y,M_Gray);
		--lib.DrawLine(cx,cy-1,pp[i].x,pp[i].y-1,M_Gray);
		--lib.DrawLine(cx+1,cy,pp[i].x+1,pp[i].y,M_Gray);
		--lib.DrawLine(cx,cy+1,pp[i].x,pp[i].y+1,M_Gray);
		lib.DrawLine(cx,cy,pp[i].x,pp[i].y,M_Gray);
	end
	--内部
	for i=1,num do
		--lib.DrawLine(p[i].x-1,p[i].y,p[i+1].x-1,p[i+1].y,M_DarkOrange);
		--lib.DrawLine(p[i].x,p[i].y-1,p[i+1].x,p[i+1].y-1,M_DarkOrange);
		--lib.DrawLine(p[i].x+1,p[i].y,p[i+1].x+1,p[i+1].y,M_DarkOrange);
		--lib.DrawLine(p[i].x,p[i].y+1,p[i+1].x,p[i+1].y+1,M_DarkOrange);
		DrawLine(p[i].x,p[i].y,p[i+1].x,p[i+1].y,M_Yellow);
	end
	--str
	DrawStringEnhance(pp[1].x-size,pp[1].y-size-8,'统率',color,size);
	DrawStringEnhance(pp[2].x+8,pp[2].y-size,'武',color,size);
	DrawStringEnhance(pp[2].x+8,pp[2].y,'力',color,size);
	DrawStringEnhance(pp[3].x-size,pp[3].y+8,'智谋',color,size);
	DrawStringEnhance(pp[4].x-size,pp[4].y+8,'政务',color,size);
	DrawStringEnhance(pp[5].x-size-8,pp[5].y-size,'魅',color,size);
	DrawStringEnhance(pp[5].x-size-8,pp[5].y,'力',color,size);
	--点
	for i=1,num do
		lib.DrawRect(p[i].x-1,p[i].y-1,p[i].x+1,p[i].y+1,M_Yellow);
		DrawNumPic(pz[i].x,pz[i].y-5,T[i]);
	end
	--绘制名称
	--[[
	for i=1,num do
		DrawStringEnhance(p[i].x,p[i].y,TN[i],C_WHITE,CC.Fontbig)
	end
	]]--
end
function DrawLine(x1,y1,x2,y2,color)
	x1=limitX(x1,1,CC.ScreenW-2);
	x2=limitX(x2,1,CC.ScreenW-2);
	y1=limitX(y1,1,CC.ScreenH-2);
	y2=limitX(y2,1,CC.ScreenH-2);
	local r,g,b=GetRGB(color);
	lib.DrawLine(x1+1,y1,x2+1,y2,RGB(math.floor(r/2),math.floor(g/2),math.floor(b/2)));
	lib.DrawLine(x1-1,y1,x2-1,y2,RGB(math.floor(r/2),math.floor(g/2),math.floor(b/2)));
	lib.DrawLine(x1,y1+1,x2,y2+1,RGB(math.floor(r/2),math.floor(g/2),math.floor(b/2)));
	lib.DrawLine(x1,y1-1,x2,y2-1,RGB(math.floor(r/2),math.floor(g/2),math.floor(b/2)));
	lib.DrawLine(x1,y1,x2,y2,color);
	
end

function button_creat(kind,id,x,y,txt,show,enable)
	local bt={}
	bt.isbt=true;
	bt.id=id or 0;
	bt.x=x or 0;
	bt.y=y or 0;
	bt.txt=txt or "";
	bt.show=show;
	bt.enable=enable;
	bt.on=0;
	bt.col1=C_BLACK;
	bt.col2=C_BLACK;
	bt.col3=C_BLACK;
	bt.col4=M_Gray;
	if kind==0 then
		bt.pic1=34;	--normal
		bt.pic2=35;	--on
		bt.pic3=36;	--hold
		bt.pic4=37;	--disable
		bt.x1=x+3;
		bt.y1=y+5;
		bt.x2=x+48;
		bt.y2=y+29;
		bt.size=20;
		bt.txtx=(bt.x1+bt.x2)/2;
		bt.txty=(bt.y1+bt.y2-bt.size)/2;
		bt.col4=C_BLACK;
	elseif kind==1 then
		bt.pic1=30;	--normal
		bt.pic2=31;	--on
		bt.pic3=32;	--hold
		bt.pic4=33;	--disable
		bt.x1=x+3;
		bt.y1=y+5;
		bt.x2=x+96;
		bt.y2=y+29;
		bt.size=20;
		bt.txtx=(bt.x1+bt.x2)/2;
		bt.txty=(bt.y1+bt.y2-bt.size)/2;
		bt.col4=C_BLACK;
	elseif kind==2 then
		bt.pic1=45;	--normal
		bt.pic2=46;	--on
		bt.pic3=47;	--hold
		bt.pic4=48;	--disable
		bt.x1=x+3;
		bt.y1=y+5;
		bt.x2=x+116;
		bt.y2=y+29;
		bt.size=20;
		bt.txtx=(bt.x1+bt.x2)/2;
		bt.txty=(bt.y1+bt.y2-bt.size)/2;
		bt.col4=C_BLACK;
	elseif kind==3 then
		bt.pic1=38;	--normal
		bt.pic2=39;	--on
		bt.pic3=40;	--hold
		bt.pic4=41;	--disable
		bt.x1=x+3;
		bt.y1=y+5;
		bt.x2=x+206;
		bt.y2=y+29;
		bt.size=20;
		bt.txtx=(bt.x1+bt.x2)/2;
		bt.txty=(bt.y1+bt.y2-bt.size)/2;
		bt.col4=C_BLACK;
	elseif kind==4 then
		
	elseif kind==5 then
		
	elseif kind==10 then
		bt.pic1=75;	--normal
		bt.pic2=75;	--on
		bt.pic3=76;	--hold
		bt.pic4=75;	--disable
		bt.x1=x+12;
		bt.y1=y+8;
		bt.x2=x+94;
		bt.y2=y+32;
		bt.size=20;
		bt.txtx=(bt.x1+bt.x2)/2;
		bt.txty=(bt.y1+bt.y2-bt.size)/2;
		bt.col1=C_WHITE;
		bt.col2=C_ORANGE;
		bt.col3=C_ORANGE;
		bt.col4=M_Gray;
	elseif kind==90 then
		bt.pic1=10;	--normal
		bt.pic2=10;	--on
		bt.pic3=10;	--hold
		bt.pic4=10;	--disable
		bt.txt="";
		bt.x1=0;
		bt.y1=0;
		bt.x2=-1;
		bt.y2=-1;
		bt.size=0;
		bt.txtx=0;
		bt.txty=0;
		bt.enable=false;
	elseif kind==91 then
		bt.pic1=11;	--normal
		bt.pic2=11;	--on
		bt.pic3=11;	--hold
		bt.pic4=11;	--disable
		bt.txt="";
		bt.x1=0;
		bt.y1=0;
		bt.x2=-1;
		bt.y2=-1;
		bt.size=0;
		bt.txtx=0;
		bt.txty=0;
		bt.enable=false;
	elseif kind==99 then
		if bt.txt=="是" then
			bt.pic1=12;	--normal
			bt.pic2=13;	--on
			bt.pic3=14;	--hold
			bt.pic4=0;	--disable
		elseif bt.txt=="否" then
			bt.pic1=15;	--normal
			bt.pic2=16;	--on
			bt.pic3=17;	--hold
			bt.pic4=0;	--disable
		elseif bt.txt=="关闭" then
			bt.pic1=18;	--normal
			bt.pic2=19;	--on
			bt.pic3=20;	--hold
			bt.pic4=137;	--disable
		elseif bt.txt=="返回" then
			bt.pic1=21;	--normal
			bt.pic2=22;	--on
			bt.pic3=23;	--hold
			bt.pic4=136;	--disable
		elseif bt.txt=="决定" then
			bt.pic1=24;	--normal
			bt.pic2=25;	--on
			bt.pic3=26;	--hold
			bt.pic4=138;	--disable
		elseif bt.txt=="确认" then
			bt.pic1=27;	--normal
			bt.pic2=28;	--on
			bt.pic3=29;	--hold
			bt.pic4=139;	--disable
		elseif bt.txt=="开战" then
			bt.pic1=140;	--normal
			bt.pic2=141;	--on
			bt.pic3=142;	--hold
			bt.pic4=143;	--disable
		else
			bt.pic1=140;	--normal
			bt.pic2=141;	--on
			bt.pic3=142;	--hold
			bt.pic4=143;	--disable
		end
		bt.txt="";
		bt.x1=x+5;
		bt.y1=y+5;
		bt.x2=x+60;
		bt.y2=y+40;
		bt.size=20;
		bt.txtx=(bt.x1+bt.x2)/2;
		bt.txty=(bt.y1+bt.y2-bt.size)/2;
	end
	return bt;
end
function button_mainbt_1(t_bt,txt,id,y)
	y=y or CC.ScreenH-81;
	table.insert(t_bt,button_creat(90,0,CC.ScreenW/2-84,y,"",true,false));
	table.insert(t_bt,button_creat(99,id,CC.ScreenW/2-34,y+8,txt,true,true));
end
function button_mainbt_2(t_bt,txt1,txt2,id1,id2,y)
	y=y or CC.ScreenH-81;
	table.insert(t_bt,button_creat(91,0,CC.ScreenW/2-108,y,"",true,false));
	table.insert(t_bt,button_creat(99,id1,CC.ScreenW/2-68,y+8,txt1,true,true));
	table.insert(t_bt,button_creat(99,id2,CC.ScreenW/2+2,y+8,txt2,true,true));
end
function button_redraw(t_bt)
	for i,v in pairs(t_bt) do
		if v.isbt then
			if v.show then
				--pic
				if not v.enable then
					lib.PicLoadCache(4,v.pic4*2,v.x,v.y,1);
				elseif v.on==2 or v.on == 3 then
					lib.PicLoadCache(4,v.pic3*2,v.x,v.y,1);
				elseif v.on==1 then
					lib.PicLoadCache(4,v.pic2*2,v.x,v.y,1);
				else
					lib.PicLoadCache(4,v.pic1*2,v.x,v.y,1);
				end
				--txt
				if #v.txt>0 then
					if not v.enable then
						DrawStringEnhance(v.txtx,v.txty,v.txt,v.col4,v.size,0.5);
					elseif v.on==2 or v.on == 3 then
						DrawStringEnhance(v.txtx+1,v.txty+1,v.txt,v.col3,v.size,0.5);
					elseif v.on==1 then
						DrawStringEnhance(v.txtx,v.txty,v.txt,v.col2,v.size,0.5);
					else
						DrawStringEnhance(v.txtx,v.txty,v.txt,v.col1,v.size,0.5);
					end
				end
			end
		end
	end
end
function button_event(t_bt)
	for i,v in pairs(t_bt) do
		if v.isbt then
      if v.on < 3 then
        v.on = 0;
      end
		end
	end
	for i,v in pairs(t_bt) do
		if v.isbt then
			if v.show then
				if v.enable then
					if MOUSE.CLICK(v.x1,v.y1,v.x2,v.y2) then
						PlayWavE(0);
						return 3,v.id,i;
					elseif MOUSE.HOLD(v.x1,v.y1,v.x2,v.y2) then
						if v.on < 3 then
              v.on = 2;
            end
						return 2,v.id,i;
					elseif MOUSE.IN(v.x1,v.y1,v.x2,v.y2) then
						if v.on < 3 then
              v.on = 1;
            end
						return 1,v.id,i;
					end
				end
			end
		end
	end
	return 0;
end

function PersonStatus(plist,index,edit)
	edit=edit or false;
	local strlist={};
	for i,v in ipairs(plist) do
		strlist[i]=JY.Person[v]["名称"];
	end
	local width=360+540+96;
	local height=512;
	local x0,y0=(CC.ScreenW-width)/2,(CC.ScreenH-height)/2;
	local pid=plist[index];
	ReSetAttrib(pid,true);
	local p=JY.Person[pid];
	local fid=p["势力"];
	local st={};
	if edit then
		table.insert(st,button_creat(10,3,584,y0-32,"兵种",false,false));
		table.insert(st,button_creat(10,2,492,y0-32,"列传",true,false));
	else
		table.insert(st,button_creat(10,3,584,y0-32,"兵种",false,true));
		table.insert(st,button_creat(10,2,492,y0-32,"列传",true,true));
	end
	table.insert(st,button_creat(10,1,400,y0-32,"能力",true,true));
	local bt={};
	if edit then
		table.insert(bt,button_creat(1,1,150,500,"变更形象",true,true));
		table.insert(bt,button_creat(1,2,550,53,"更改姓名",true,true));
		table.insert(bt,button_creat(1,3,820,54,"重置属性",true,true));
		table.insert(bt,button_creat(1,4,732,340,"重置技能",true,true));
		table.insert(bt,button_creat(1,5,550,120,"变更兵种",true,true));
		button_mainbt_2(bt,"决定","返回",98,99);
	else
		button_mainbt_1(bt,"关闭",99);
	end
	--local b=JY.Bingzhong[p["兵种"]];
	local att={70,70,70,70,70,70,70,}	--初始化主角五维用的基准值
	local size=24;
	local size2=20;
	local sheet=3;
	local sl=creatSingleList(x0+24,y0+12,84,456,plist,strlist,"武将")
	rollSingleList(sl,index);
	local function redraw()
		DrawGame();
		button_redraw(st);
		local cx,cy=x0+120,y0;
		LoadPicEnhance(73,x0,cy,width,height);
		--Glass(x0,cy,x0+width,cy+height,nil,192)
		lib.PicLoadCache(2,p["容貌"]*2,cx,cy,1);
		cx = cx + 360;
		cy = cy + 8;
		LoadPicEnhance(79, cx, cy, 180);
    cy = cy + 6;
		DrawStringEnhance(cx + 90, cy, p["名称"].." "..p["字"], C_WHITE, size, 0.5);
		lib.PicLoadCache(4, 88 * 2, cx + 240, cy, 1);
		DrawStringEnhance(cx + 240 + size, cy + 4, JY.Str[9170 + p["身份"]], C_WHITE, size2, 0.5);
		lib.PicLoadCache(4, 80 * 2, cx + 300, cy, 1);
		DrawStringEnhance(cx + 300 + size, cy + 4, JY.Str[9065 + p["性别"]], C_WHITE, size2, 0.5);
		
		cy = cy + 32;
    LoadPicEnhance(72,cx-16,cy,512);
		cy=cy+8
		if sheet==3 then
			DrawPolygon(5,{p["统率2"],p["武力2"],p["智谋2"],p["政务2"],p["魅力2"]},cx+200,cy+32,150,C_Name,size2)
			DrawStringEnhance(cx,cy,"所在[w]  "..JY.City[p["所在"]]["名称"],C_Name,size);
			cy=cy+size+2;
			if fid>0 then
				DrawStringEnhance(cx,cy,"势力[w]  "..JY.Force[fid]["名称"],C_Name,size);
				cy=cy+size+2;
				DrawStringEnhance(cx,cy,"官爵[w]  "..JY.Title[p["官爵"]]["名称"],C_Name,size);
				cy=cy+size+2;
				DrawStringEnhance(cx,cy,"功绩[w]  "..p["功绩"],C_Name,size);
				cy=cy+size+2;
				DrawStringEnhance(cx,cy,"俸禄[w]  --",C_Name,size);
				cy=cy+size+2;
				DrawStringEnhance(cx,cy,"忠诚[w]  " .. p["忠诚"],C_Name,size);
				cy=cy+size+2;
				DrawStringEnhance(cx,cy,"仕官[w]  " .. (JY.Base["当前年"] - p["登场年"]) .. "年",C_Name,size);
			else
				DrawStringEnhance(cx,cy,"势力[w]  --",C_Name,size);
				cy=cy+size+2;
				DrawStringEnhance(cx,cy,"官爵[w]  --",C_Name,size);
				cy=cy+size+2;
				DrawStringEnhance(cx,cy,"功绩[w]  --",C_Name,size);
				cy=cy+size+2;
				DrawStringEnhance(cx,cy,"俸禄[w]  --",C_Name,size);
				cy=cy+size+2;
				DrawStringEnhance(cx,cy,"忠诚[w]  --",C_Name,size);
				cy=cy+size+2;
				DrawStringEnhance(cx,cy,"仕官[w]  --",C_Name,size);
			end
      cy=cy+size+2;
      DrawStringEnhance(cx,cy,"年龄[w]  " .. (JY.Base["当前年"] - p["生年"]) .. "岁",C_Name,size);
			cy=cy+size+2;
				DrawStringEnhance(cx,cy,"相性[w]  " .. p["相性"],C_Name,size);
				cy=cy+size+2;
			LoadPicEnhance(72,cx-16,cy,512);
			cy=cy+8;
			DrawStringEnhance(cx,cy,"技能",C_Name,size);
			local skill_id=DrawSkillTable(pid,cx+128,cy);
			cy=cy+size+2+27;
			for i,v in pairs({"步兵适性","弓兵适性","骑兵适性"}) do
				local sx=p[v];
				lib.PicLoadCache(4,89*2,cx,cy,1);
				DrawStringEnhance(cx+60,cy+4,v..JY.Str[sx+9160],C_WHITE,20,0.5);
				cy=cy+27;
			end
			if skill_id>0 then
        DrawStringEnhance(MOUSE.x, MOUSE.y, "技能说明 - "..JY.Skill[skill_id]["名称"], C_Name, size2);
				--[[cx=409;cy=390;
				LoadPicEnhance(78,cx-15,cy-10,490,120);
				DrawStringEnhance(cx,cy,"技能说明 - "..JY.Skill[skill_id]["名称"],C_Name,size2);
				cy=cy+size2+2;
				DrawStringEnhance(cx,cy,JY.Skill[skill_id]["说明"],C_WHITE,size2,0,0,size2*23);]]--
			end
		elseif sheet==2 then
			LoadPicEnhance(78,cx,cy,448,400);
			cx=cx+15
			cy=cy+10
			DrawStringEnhance(cx,cy,"三国英杰列传 - "..p["名称"],C_Name,size);
			cy=cy+size+2;
			if p["列传"]>0 then
				DrawStringEnhance(cx,cy,JY.Str[p["列传"]],C_WHITE,size2,0,0,420);
			end
		elseif sheet==1 then
			cx=409;cy=60;
			LoadPicEnhance(78,cx-15,cy-10,536,180);
			--DrawStringEnhance(cx,cy,"兵种简介 - "..b["名称"],C_Name,size2);
			cy=cy+size2+2;
			--DrawStringEnhance(cx,cy,b["说明"],C_WHITE,size2,0,0,524);
			cy=cy+160;
			DrawStringEnhance(cx,cy,"现在开始",C_Name,size2);
		end
		button_redraw(bt);
		drawSingleList(sl);
	end	
	local function ReSetSkill()
		local t_skill={6,7,10,11,12,13,14,15,16,17,18,19,20,21,22,24,25,29,31,32,33,34,35,41,42}
		if p["性别"]==1 and math.random()<0.2 then
			table.insert(t_skill,47);
		end
		if math.random()<0.1 then
			table.insert(t_skill,30);
		else
			if math.random()<0.3 then
				table.insert(t_skill,8);
			end
			if math.random()<0.3 then
				table.insert(t_skill,9);
			end
		end
		if math.random()<0.1 then
			table.insert(t_skill,28);
		else
			if math.random()<0.3 then
				table.insert(t_skill,26);
			end
			if math.random()<0.3 then
				table.insert(t_skill,27);
			end
		end
		if math.random()<0.3 then
			table.insert(t_skill,39);
		end
		if math.random()<0.3 then
			table.insert(t_skill,40);
		end
		if math.random()<0.3 then
			table.insert(t_skill,44);
		end
		if math.random()<0.3 then
			table.insert(t_skill,46);
		end
		if math.random()<0.3 then
			table.insert(t_skill,48);
		end
		for i=1,6 do
			local num=#t_skill;
			local n=math.random(num)
			p["技能"..i]=t_skill[n];
			table.remove(t_skill,n);
		end
	end
	if edit then
		p["相性"]=math.random(1,149);
		p["成长"]=99;
		--ReSetSkill();
		--p["兵种"]=1;
		--p["灵巧"]=IrwinHall(80,5,4);
		--p["福源"]=IrwinHall(70,5,4);
		ReSetAttrib(0,true);
	end
	while true do
		st[sheet].on=2;
		local t1=lib.GetTime();
		redraw();
		ShowScreen();
		local delay=CC.FrameNum-lib.GetTime()+t1;
		if delay>0 then
			lib.Delay(delay);
		end
		getkey();
		if	eventSingleList(sl) then
			pid=sl.val;
			ReSetAttrib(pid,true);
			p=JY.Person[pid];
			fid=p["势力"];
		end
		local event,btid=button_event(st);
		if event==3 then
			if btid==1 then
				sheet=3;
			elseif btid==2 then
				sheet=2;
			elseif btid==3 then
				sheet=1;
			end
		end
		event,btid=button_event(bt);
		if event==3 then
			if btid==1 then
				p["内政容貌"]=SelectFace(p["内政容貌"]);
				p["战斗容貌"]=p["内政容貌"];
				p["相性"]=math.random(1,149);
				if between(p["容貌"],1179,1208) then
					p["性别"]=1;
				elseif between(p["容貌"],1219,1228) then
					p["性别"]=1;
				elseif between(p["容貌"],1240,1246) then
					p["性别"]=1;
				elseif between(p["容貌"],1258,1264) then
					p["性别"]=1;
				else--if between(p["容貌"],1251,1280) then
					p["性别"]=0;
				end
			elseif btid==2 then
				p["名称"]=Input(p["名称"],p["容貌"]);
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
			elseif btid==3 then
				p["武力"]=limitX(IrwinHall(att[1],10,2),1,100);
				p["智谋"]=limitX(IrwinHall(att[2],10,2),1,100);
				p["统率"]=limitX(IrwinHall(att[3],10,2),1,100);
				p["政务"]=limitX(IrwinHall(att[4],10,2),1,100);
				p["魅力"]=limitX(IrwinHall(att[5],10,2),1,100);
				p["灵巧"]=limitX(IrwinHall(att[6],10,2),1,100);
				p["福源"]=limitX(IrwinHall(att[7],10,2),1,100);
				if p["性别"]==1 then
					p["魅力"]=limitX(p["魅力"]+5,1,100);
				end
				if p["兵种"]==1 then
					p["统率"]=limitX(p["统率"]+10,1,100);
				end
				if p["兵种"]==7 then
					p["武力"]=limitX(p["武力"]+5,1,100);
					p["智谋"]=limitX(p["智谋"]+5,1,100);
				end
				if p["兵种"]==13 then
					p["武力"]=limitX(p["武力"]+10,1,100);
				end
				if p["兵种"]==19 then
					p["武力"]=limitX(p["武力"]+5,1,100);
					p["统率"]=limitX(p["统率"]+5,1,100);
				end
				if p["兵种"]==24 then
					p["智谋"]=limitX(p["智谋"]+10,1,100);
				end
				ReSetAttrib(pid,true);
			elseif btid==4 then
				ReSetSkill();
				ReSetAttrib(pid,true);
			elseif btid==5 then
				if p["兵种"]==1 then
					p["兵种"]=4;
					att={75,70,75,70,70,60,70,}	--武智统政魅巧福
				elseif p["兵种"]==4 then
					p["兵种"]=7;
					att={65,70,65,70,70,75,75,}	--武智统政魅巧福
				elseif p["兵种"]==7 then
					p["兵种"]=13;
					att={75,60,75,65,75,70,70,}	--武智统政魅巧福
				elseif p["兵种"]==13 then
					p["兵种"]=16;
					att={75,65,70,65,75,70,70,}	--武智统政魅巧福
				elseif p["兵种"]==16 then
					p["兵种"]=19;
					att={70,75,70,60,70,70,75,}	--武智统政魅巧福
				elseif p["兵种"]==19 then
					p["兵种"]=24;
					att={65,75,75,75,70,60,70,}	--武智统政魅巧福
				elseif p["兵种"]==24 then
					p["兵种"]=27;
					att={70,75,70,75,70,70,60,}	--武智统政魅巧福
				elseif p["兵种"]==27 then
					p["兵种"]=30;
					att={75,65,70,65,70,75,70,}	--武智统政魅巧福
				elseif p["兵种"]==30 then
					p["兵种"]=33;
					att={70,70,70,70,70,70,70,}	--武智统政魅巧福
				else
					p["兵种"]=1;
					att={70,70,75,70,70,65,70,}	--武智统政魅巧福
				end
				b=JY.Bingzhong[p["兵种"]];
				ReSetAttrib(pid,true);
			elseif btid==98 then
				return pid;
			elseif btid==99 then
				if edit then
					p["成长"]=10;
				end
				return 0;
			end
		end
	end
end
function SelectFace(faceid)
	local st={}
	table.insert(st,button_creat(10,3,584,0,"兵种",true,false));
	table.insert(st,button_creat(10,2,492,0,"列传",true,false));
	table.insert(st,button_creat(10,1,400,0,"能力",true,true));
	st[3].on=2;
	local bt={};
	table.insert(bt,button_creat(1,1,500,54,"上一页",true,false));
	table.insert(bt,button_creat(1,2,700,54,"下一页",true,true));
	--init
	local t_pic={
				[1]={1129,1130,1131,1132,1133,1134,1135,1136,1137,1138,1139,1140,1141,1142,1143,1144,1145,1146,1147,1148,1149,1150,1151,1152,1153,1154,1155,1156,1157,1158,},
				[2]={1159,1160,1161,1162,1163,1164,1165,1166,1167,1168,1169,1170,1171,1172,1173,1174,1175,1176,1177,1178,1209,1210,1211,1212,1213,1214,1215,1216,1217,1218,},
				[3]={1229,1230,1231,1232,1233,1234,1235,1236,1237,1238,1239,1247,1248,1249,1250,1251,1252,1253,1254,1255,1256,1257,},
				[4]={1179,1180,1181,1182,1183,1184,1185,1186,1187,1188,1189,1190,1191,1192,1193,1194,1195,1196,1197,1198,1199,1200,1201,1202,1203,1204,1205,1206,1207,1208,},
				[5]={1219,1220,1221,1222,1223,1224,1225,1226,1227,1228,1240,1241,1242,1243,1244,1245,1246,1258,1259,1260,1261,1262,1263,1264,},
				};
	--82+54
	local s_pic={};
	local page=1;
	local maxpage=#t_pic;
	local s={};
	local current=0;
	local hold=false;
	local function freshpage()
		s={};
		for i,v in ipairs(t_pic[page]) do
			local x,y=420+84*((i-1)%6),108+80*math.floor((i-1)/6);
			s[i]={
					id=v,
					left=x,
					top=y,
					right=x+72,
					bottom=y+66,
					}
		end
	end
	freshpage();
	local cx,cy=24,(CC.ScreenH-512)/2;
	local function redraw()
		DrawGame();
		button_redraw(st);
		LoadPicEnhance(73,0,cy,CC.ScreenW,512);
		for i,v in pairs(s) do
			lib.PicLoadCache(2,(v.id+6000)*2,v.left,v.top,1);
		end
		if current>0 then
			lib.PicLoadCache(2,(s[current].id)*2,180+24,CC.ScreenH/2,0);
			if hold then
				LoadPicEnhance(9,s[current].left-4,s[current].top-3,80,72);
			else
				LoadPicEnhance(8,s[current].left-4,s[current].top-3,80,72);
			end
		else
			lib.PicLoadCache(2,faceid*2,180+24,CC.ScreenH/2,0);
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
		current=0;
		hold=false;
		for i,v in pairs(s) do
			if MOUSE.CLICK(v.left,v.top,v.right,v.bottom) then
				current=i;
				PlayWavE(0);
				return v.id;
			elseif MOUSE.HOLD(v.left,v.top,v.right,v.bottom) then
				current=i;
				hold=true;
				break;
			elseif MOUSE.IN(v.left,v.top,v.right,v.bottom) then
				current=i;
				faceid=s[current].id;
				break;
			end
		end
		local event,btid=button_event(bt);
		if event==3 then
			if btid==1 then
				page=page-1;
			elseif btid==2 then
				page=page+1;
			end
			page=limitX(page,1,maxpage);
			freshpage();
			bt[1].enable=true;
			bt[2].enable=true;
			if page==1 then
				bt[1].enable=false;
			end
			if page==maxpage then
				bt[2].enable=false;
			end
		end
	
	end
end

function DrawCCityM(x0,y0)
	--lib.PicLoadCache(4,700*2,x0,y0,1,255,M_Gray);
	for i=1,JY.CityNum-1 do
		local fid=JY.City[i]["势力"];
		lib.PicLoadCache(4,(700+i)*2,x0,y0,1+4,255,FlagColor[fid]);
	end
	lib.PicLoadCache(4,(700+51)*2,x0,y0,1,255);
	for i=1,JY.CityNum-1 do
		local x1,y1=x0+JY.City[i]["中地图X"]+1,y0+JY.City[i]["中地图Y"]+1;
		local fid=JY.City[i]["势力"];
		local pic=151+JY.City[i]["标记"];
		if JY.Base["当前城池"]==i then
			lib.PicLoadCache(4,598*2,x1+1,y1+1);
		end
		lib.FillColor(x1-5,y1-5,x1+5,y1+5,FlagColor[fid]);
		lib.PicLoadCache(4,pic*2,x1,y1);
	end
end




function DrawCCityS(x0,y0,control)
	local cid=0;
	local tx,ty=MOUSE.x,MOUSE.y;
	lib.PicLoadCache(4,160*2,x0,y0,1);
	--lib.FillColor();
	for i=1,JY.CityNum-1 do
		local x1,y1=x0+JY.City[i]["小地图X"],y0+JY.City[i]["小地图Y"];
		local pic=500+JY.City[i]["势力"];
		if JY.Base["当前城池"]==i then
			lib.PicLoadCache(4,599*2,x1+1,y1+1);
		end
		lib.PicLoadCache(4,pic*2,x1,y1);
		if control and cid==0 and MOUSE.IN(x1-4,y1-4,x1+3,y1+3) then
			cid=i;
		end
	end
	if cid>0 then
		DrawLabel(tx,ty,JY.City[cid]["名称"]);
	end
end
function DrawCCityS(x, y)
  local mapBGColor = RGB(48, 48, 16);
  local playerCityID = JY.Person[JY.PID]["所在"];
  local cid = 0;
  local cityX, cityY;
  
  if between(MOUSE.x, x, x + 203) and between(MOUSE.y, y, y + 183) then
    if MOUSE.status=='CLICK' then
      MOUSE.status = 'IDLE';
      local id1 = CityGeo:query(MOUSE.hx * 2 - x, MOUSE.hy * 2 - y);
      local id2 = CityGeo:query(MOUSE.rx * 2 - x, MOUSE.ry * 2 - y);
      if id1 == id2 and id1 > 0 then
        PlayWavE(0);
        DrawCityStatus(GetAllCityList(), id1);
        return;
      end
    else
      local id1 = CityGeo:query(MOUSE.x * 2 - x, MOUSE.y * 2 - y);
      if id1 > 0 then
        cid = id1;
      end
    end
  end
  for i = 1, JY.CityNum - 1 do
    local fid = JY.City[i]["势力"];
    local cx, cy = x + JY.City[i]["中地图X"] / 2, y + JY.City[i]["中地图Y"] / 2;
    --[[local event = MOUSE.EVENT(cx - 3, cy - 3, cx + 3, cy + 3);
    if event == 3 then
      PlayWavE(0);
      DrawCityStatus(GetAllCityList(), i);
      return;
    end
    if event > 0 then
      cid = i;
      cityX, cityY = cx + 8, cy + 22;
      lib.PicLoadCache(4, (i + 700) * 2, x, y, 1 + 0 + 4, 192, FlagColor[fid], 203);
    else
      lib.PicLoadCache(4, (i + 700) * 2, x, y, 1 + 2 + 4, 128, mapBGColor, 203);
    end]]--
    
    if cid == i then
      lib.PicLoadCache(4, (i + 700) * 2, x, y, 1 + 0 + 4, 192, FlagColor[fid], 203);
    else
      lib.PicLoadCache(4, (i + 700) * 2, x, y, 1 + 2 + 4, 128, mapBGColor, 203);
    end
    
    if playerCityID == i then
      lib.PicLoadCache(4, 157 * 2, cx, cy, 4, nil, FlagColor[fid]);
      cityX, cityY = cx - 13, cy - 12;
    else
      lib.Background(cx - 3, cy - 2, cx + 3, cy + 2, 128);
      lib.Background(cx - 2, cy - 3, cx + 2, cy + 3, 128);
      lib.Background(cx - 2, cy - 1, cx + 2, cy + 1, 64, FlagColor[fid]);
      lib.Background(cx - 1, cy - 2, cx + 1, cy + 2, 64, FlagColor[fid]);
      lib.Background(cx - 2, cy - 2, cx + 0, cy + 0, 128, C_WHITE);
    end
  end
  --[[lib.SetClip(cityX, cityY, cityX + 24, cityY + 24);
	local frame = math.floor(os.clock() * 7) % 8;
  lib.PicLoadCache(4, 158 * 2, cityX - 24 * frame, cityY, 1 + 8);
  lib.SetClip(0, 0, 0, 0);]]--
  
  lib.PicLoadCache(4, 700 * 2, x, y, 1 + 8, nil, nil, 203);
  if cid > 0 then
    DrawLabel(MOUSE.x + 8, MOUSE.y + 24, JY.City[cid]["名称"]);
  end
end
function DrawCityStatus(plist,index)
	local strlist={};
	for i,v in ipairs(plist) do
		strlist[i]=JY.City[v]["名称"];
	end
	local cid=plist[index]
	local c=JY.City[cid];
	local fid=c["势力"];
	local width,height=800,480;
	local size=24;
	local size2=20;
	local x0=(CC.ScreenW-width)/2;
	local y0=(CC.ScreenH-height)/2;
	local bt={};
	table.insert(bt,button_creat(1,11,x0+150,y0+424,"都市武将",true,true));
	button_mainbt_1(bt,"关闭",2, y0 + height - 56);
	bt[1].enable=c["现役"]+c["在野"]>0;
	local sl=creatSingleList(x0+24,y0+12,84,403,plist,strlist,"都市");
	rollSingleList(sl,index);
	local function redraw()
		DrawGame();
		local x,y=x0,y0;
		LoadPicEnhance(73,x,y,width,height);
		x=x+144; y=y+16;
		LoadPicEnhance(79,x,y,120);
		LoadPicEnhance(72,x-16,y+38,width-160);
		DrawStringEnhance(x+60,y+5,c["名称"],C_WHITE,size,0.5);
		y=y+4;	x=x+140;
		DrawStringEnhance(x,y,"太守",C_Name,size);					DrawStringEnhance(x+60,y,JY.Person[c["太守"]]["名称"],C_WHITE,size);
		lib.PicLoadCache(4,87*2,x+220,y,1);
		DrawStringEnhance(x+224,y+4,JY.Str[9010+c["特征"]],C_WHITE,size2);
		if c["接壤"]>0 then
			lib.PicLoadCache(4,82*2,x+280,y,1);
			DrawStringEnhance(x+284,y+4,"前线",C_WHITE,size2);
		end
		y=y+50;
		if c["太守"]>0 then
			lib.PicLoadCache(2,(JY.Person[c["太守"]]["容貌"]+4000)*2,x-80,y+64,0);
		end
			y=y-4;
		DrawStringEnhance(x,y,"势力",C_Name,size);					DrawStringEnhance(x+60,y,JY.Force[fid]["名称"],C_WHITE,size);			y=y+size+4;
		DrawStringEnhance(x,y,"州",C_Name,size);					DrawStringEnhance(x+60,y,JY.Str[9030+c["州"]],C_WHITE,size);
		DrawStringEnhance(x+140,y,"地方",C_Name,size);				DrawStringEnhance(x+140+60,y,JY.Str[9050+c["地方"]],C_WHITE,size);		y=y+size+4;
		DrawStringEnhance(x,y,"规模",C_Name,size);					DrawStringEnhance(x+60,y,JY.Str[9000+c["规模"]],C_WHITE,size);
		DrawStringEnhance(x + 140,y,"人口",C_Name,size);					DrawNumPicBig(x + 140 + 90, y, c["人口"] * 100);			y=y+size+4;
		DrawStringEnhance(x,y,"资金",C_Name,size);					DrawNumPicBig(x+90,y,c["资金"]*10);
		DrawStringEnhance(x+140,y,"物资",C_Name,size);				DrawNumPicBig(x+140+90,y,c["物资"]*10);		y=y+size+4;
		DrawStringEnhance(x,y,"现役",C_Name,size);					DrawNumPicBig(x+90,y,c["现役"]);
		DrawStringEnhance(x+140,y,"在野",C_Name,size);				DrawNumPicBig(x+140+90,y,c["在野"]);		y=y+size+4;
		DrawStringEnhance(x,y,"兵力",C_Name,size);					DrawNumPicBig(x+90,y,c["兵力"]);
		DrawStringEnhance(x+140,y,"士气",C_Name,size);				DrawNumPicBig(x+140+90,y,c["士气"]);		y=y+size+4;
		x=x-132;	y=y+8;
		--DrawStringEnhance(x,y,"特征",C_Name,size);					DrawStringEnhance(x+60,y,JY.Str[9010+c["特征"]],C_WHITE,size);		x=x+140;
		--DrawStringEnhance(x,y,"接壤",C_Name,size);					DrawStringEnhance(x+60,y,JY.Str[9060+c["接壤"]],C_WHITE,size);		y=y+size+4;		x=x-140;
		DrawStringEnhance(x,y,"开垦",C_Name,size);					DrawNumPicBig(x+160,y,c["开垦"]/2,c["最大开垦"]/2);		drawbar(x,y+size,1000*c["开垦"]/2000);
		local grow
    --grow = (c["开垦"] + 10) * (10 + JY.Person[c["太守"]]["魅力"] + 100) / 50;
    grow = 4 * c["开垦"] / 10 * (1 + limitX(c["人口"] / 5000, 0, 2) +  15/ limitX(110 - JY.Person[c["太守"]]["魅力"], 10, 110));
    grow = math.floor(grow);
    DrawStringEnhance(x + 240, y, string.format("(+%d/年)",grow * 10), C_WHITE, size);         y=y+size+12;
		DrawStringEnhance(x,y,"商业",C_Name,size);					DrawNumPicBig(x+160,y,c["商业"]/2,c["最大商业"]/2);		drawbar(x,y+size,1000*c["商业"]/2000);
		
    --grow = (c["商业"] + 10) * (10 + JY.Person[c["太守"]]["魅力"] + 100) / 200;
    grow = c["商业"] / 10 * (1 + limitX(c["人口"] / 5000, 0, 2) +  15/ limitX(110 - JY.Person[c["太守"]]["魅力"], 10, 110));
    if c["特征"] == 3 then --交易都市
      grow = grow * 1.2;
    end
    grow = math.floor(grow);
    DrawStringEnhance(x + 240, y, string.format("(+%d/季)",grow * 10), C_WHITE, size);         y=y+size+12;
		DrawStringEnhance(x,y,"技术",C_Name,size);					DrawNumPicBig(x+160,y,c["技术"]/2,c["最大技术"]/2);		drawbar(x,y+size,1000*c["技术"]/2000);		y=y+size+12;
		DrawStringEnhance(x,y,"防御",C_Name,size);					DrawNumPicBig(x+160,y,c["防御"]/2,c["最大防御"]/2);		drawbar(x,y+size,1000*c["防御"]/2000);		y=y+size+12;
		DrawStringEnhance(x,y,"治安",C_Name,size);					DrawNumPicBig(x+160,y,c["治安"]/10,100);		drawbar(x,y+size,1000*c["治安"]/1000);		y=y+size+12;
    
    x = x + 360; y = y - 80;
		DrawStringEnhance(x,y,"战略",C_Name,size);					DrawNumPicBig(x+90,y,c["战略价值"]); y=y+size+4;
		DrawStringEnhance(x,y,"政略",C_Name,size);					DrawNumPicBig(x+90,y,c["政略价值"]); y=y+size+4;
		DrawStringEnhance(x,y,"前线",C_Name,size);					DrawNumPicBig(x+90,y,c["前线"]); y=y+size+4;
    
    
		button_redraw(bt);
		drawSingleList(sl);
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
		if eventSingleList(sl) then
			index=sl.select;
			cid=plist[index]
			c=JY.City[cid];
			fid=c["势力"];
			bt[1].enable=c["现役"]+c["在野"]>0;
		end
		local event,btid=button_event(bt);
		if event==3 then
			if btid==1 then
				return 1;
			elseif btid==2 then
				return 0;
			elseif btid==11 then
				ShowPersonList(GetCityWujiang(cid),nil,1);
			end
		end
	end
	
--	x0=x0+24;
--	--LoadPicEnhance(205,x,y,w,h);						x=x+36;y=y+32;
--	Glass(x,y,x+w,y+h,FlagColor[fid],244);				x=x+36;y=y+24;
--	DrawStringEnhance(x+85,y+2,"[B][wheat]"..c["名称"],C_WHITE,32,0.5);		lib.PicLoadCache(4,(600+c["势力"])*2,x+180,y+6,1);			y=y+42;
--	y=y+8;	lib.PicLoadCache(4,44*2,x0,y,1);			y=y+20;
--	DrawStringEnhance(x,y,"势力",C_Name,size);					DrawStringEnhance(x+60,y,JY.Force[fid]["名称"],C_WHITE,size);	y=y+size+4;	
--	DrawStringEnhance(x,y,"太守",C_Name,size);					DrawStringEnhance(x+60,y,JY.Person[c["太守"]]["名称"],C_WHITE,size);		x=x+140;
--	DrawStringEnhance(x,y,"规模",C_Name,size);					DrawStringEnhance(x+60,y,JY.Str[9000+c["规模"]],C_WHITE,size);							y=y+size+4;		x=x-140;
--	DrawStringEnhance(x,y,"州",C_Name,size);						DrawStringEnhance(x+60,y,JY.Str[9030+c["州"]],C_WHITE,size);			x=x+140
--	DrawStringEnhance(x,y,"地方",C_Name,size);					DrawStringEnhance(x+60,y,JY.Str[9050+c["地方"]],C_WHITE,size);		y=y+size+4;		x=x-140;
--	DrawStringEnhance(x,y,"特征",C_Name,size);					DrawStringEnhance(x+60,y,JY.Str[9010+c["特征"]],C_WHITE,size);		x=x+140;
--	DrawStringEnhance(x,y,"接壤",C_Name,size);					DrawStringEnhance(x+60,y,JY.Str[9060+c["接壤"]],C_WHITE,size);		y=y+size+4;		x=x-140;
--	y=y+8;	lib.PicLoadCache(4,44*2,x0,y,1);	y=y+20;
--	DrawStringEnhance(x,y,"开垦",C_Name,size);					DrawNumPicBig(x+160,y,c["开垦"]/10,c["最大开垦"]/10);		drawbar(x,y+size,1000*c["开垦"]/c["最大开垦"]);		y=y+size+8;
--	DrawStringEnhance(x,y,"商业",C_Name,size);					DrawNumPicBig(x+160,y,c["商业"]/10,c["最大商业"]/10);		drawbar(x,y+size,1000*c["商业"]/c["最大商业"]);		y=y+size+8;
--	DrawStringEnhance(x,y,"兵力",C_Name,size);					DrawNumPicBig(x+90,y,c["兵力"]);		x=x+140;
--	DrawStringEnhance(x,y,"士气",C_Name,size);					DrawNumPicBig(x+90,y,c["士气"]);		y=y+size+4;		x=x-140;
--	DrawStringEnhance(x,y,"现役",C_Name,size);					DrawNumPicBig(x+90,y,c["现役"]);		x=x+140;
--	DrawStringEnhance(x,y,"在野",C_Name,size);					DrawNumPicBig(x+90,y,c["在野"]);		y=y+size+4;		x=x-140;
--	y=y+8;	lib.PicLoadCache(4,44*2,x0,y,1);	y=y+20;
--	DrawStringEnhance(x,y,"设施",C_Name,size);					DrawStringEnhance(x+60,y,"无",C_WHITE,size);							y=y+size+4;	
--														DrawStringEnhance(x+60,y,"无",C_WHITE,size);							y=y+size+4;	
--														DrawStringEnhance(x+60,y,"无",C_WHITE,size);							y=y+size+4;	
end
function DrawForceStatus(id,x0,y0)
	local f=JY.Force[id];
	local w,h=320,420;
	local size=24;
	local x,y=x0,y0;
	x0=x0+24;
	--LoadPicEnhance(205,x,y,w,h);						x=x+36;y=y+32;
	Glass(x,y,x+w,y+h,FlagColor[id],244);				x=x+36;y=y+24;
	DrawStringEnhance(x+85,y+2,"[B][wheat]"..f["名称"],C_WHITE,32,0.5);		lib.PicLoadCache(4,(600+id)*2,x+180,y+6,1);			y=y+42;
	y=y+8;	lib.PicLoadCache(4,44*2,x0,y,1);			y=y+20;
	DrawStringEnhance(x,y,"君主",C_Name,size);					DrawStringEnhance(x+60,y,JY.Person[f["君主"]]["名称"],C_WHITE,size);	y=y+size+4;	
	DrawStringEnhance(x,y,"官爵",C_Name,size);					DrawStringEnhance(x+60,y,JY.Str[9080+f["官爵"]],C_WHITE,size);		x=x+140;
	DrawStringEnhance(x,y,"本城",C_Name,size);					DrawStringEnhance(x+60,y,JY.City[f["本城"]]["名称"],C_WHITE,size);		y=y+size+4;		x=x-140;
	DrawStringEnhance(x,y,"现役",C_Name,size);					DrawStringEnhance(x+60,y,""..f["现役"],C_WHITE,size);		x=x+140;
	DrawStringEnhance(x,y,"城池",C_Name,size);					DrawStringEnhance(x+60,y,""..f["城池"],C_WHITE,size);		y=y+size+4;		x=x-140;
	DrawStringEnhance(x,y,"资金",C_Name,size);					DrawStringEnhance(x+60,y,""..f["资金"]*10,C_WHITE,size);		x=x+140;
	DrawStringEnhance(x,y,"物资",C_Name,size);					DrawStringEnhance(x+60,y,""..f["物资"]*10,C_WHITE,size);		y=y+size+4;		x=x-140;
	y=y+8;	lib.PicLoadCache(4,44*2,x0,y,1);	y=y+20;
	DrawStringEnhance(x,y,"战略",C_Name,size);					DrawStringEnhance(x+60,y,JY.Str[9070+f["战略"]],C_WHITE,size);
	if f["战略"]>0 then
		x=x+140
		DrawStringEnhance(x,y,"目标",C_Name,size);					DrawStringEnhance(x+60,y,"中原",C_WHITE,size);		x=x-140;
	end
	y=y+size+4;
	DrawStringEnhance(x,y,"敌意",C_Name,size);					DrawStringEnhance(x+60,y,""..f["敌意"],C_WHITE,size);		x=x+140;
	y=y+size+4;		x=x-140;--DrawStringEnhance(x,y,"接壤",C_Name,size);					DrawStringEnhance(x+60,y,JY.Str[9060+f["接壤"]],C_WHITE,size);		y=y+size+4;		x=x-140;
	y=y+8;	lib.PicLoadCache(4,44*2,x0,y,1);	y=y+20;
	DrawStringEnhance(x,y,"重臣",C_Name,size);					x=x+100;
	for i=0,5 do
		local pid=f["重臣"..(i+1)];
		if pid>0 then
			DrawStringEnhance(x+100*(i%2),y+(size+4)*math.floor(i/2),JY.Person[pid]["名称"],C_WHITE,size,0.5);
		end
	end
end
function DrawForceStatus(plist, index)
	local strlist={};
	for i,v in ipairs(plist) do
		strlist[i] = JY.Force[v]["名称"];
	end
	local fid = plist[index]
	local width, height = 800, 480;
	local size = 24;
	local size2 = 20;
	local x0 = (CC.ScreenW - width) / 2;
	local y0 = (CC.ScreenH - height) / 2;
	local bt = {};
	table.insert(bt, button_creat(1, 11, x0 + 138, y0 + 420, "都市", true, true));
	table.insert(bt, button_creat(1, 12, x0 + 242, y0 + 420, "武将", true, true));
	button_mainbt_1(bt, "关闭", 2, y0 + height - 56);
	--bt[1].enable=c["现役"]+c["在野"]>0;
	local sl = creatSingleList(x0 + 24, y0 + 12, 84, 420, plist, strlist, "势力");
	rollSingleList(sl, index);
  local forceData = {};
  local function fixNum(n)
    local t = 0;
    while n >= 100 do
      n = n / 10;
      t = t + 1;
    end
    return math.floor(n) * 10^t;
  end
  local function getForceData()
    local f = JY.Force[fid];
    forceData.name = f["名称"];
    forceData.leader = f["君主"];
    forceData.leaderName = JY.Person[forceData.leader]["名称"];
    forceData.title = f["官爵"];
    forceData.titleName = JY.Str[9080 + forceData.title];
    forceData.capital = f["本城"];
    forceData.capitalName = JY.City[forceData.capital]["名称"];
    forceData.cityNum = 0;
    forceData.personNum = 0;
    forceData.gold = 0;
    forceData.food = 0;
    forceData.peopleNum = 0;
    forceData.soldierNum = 0;
    forceData.color = FlagColor[fid];
    forceData.cityX = JY.City[forceData.capital]["中地图X"] / 2;
    forceData.cityY = JY.City[forceData.capital]["中地图Y"] / 2;
    forceData.citys = {};
    for i = 1, JY.CityNum - 1 do
      if JY.City[i]["势力"] == fid then
        table.insert(forceData.citys, i);
        forceData.cityNum = forceData.cityNum + 1;
        forceData.personNum = forceData.personNum + JY.City[i]["现役"];
        forceData.gold = forceData.gold + JY.City[i]["资金"];
        forceData.food = forceData.food + JY.City[i]["物资"];
        forceData.peopleNum = forceData.peopleNum + JY.City[i]["人口"];
        forceData.soldierNum = forceData.soldierNum + JY.City[i]["兵力"];
      end
    end
    forceData.strategy = f["战略"];
    forceData.strategyTarget = f["目标"];
    forceData.strategyStr = JY.Str[9260 + forceData.strategy];
    if forceData.strategy == 2 then
      forceData.strategyStr = forceData.strategyStr .. "[5]" .. JY.Str[9050 + forceData.strategyTarget];
    elseif forceData.strategy == 3 then
      forceData.strategyStr = forceData.strategyStr .. "[5]" .. JY.Str[9030 + forceData.strategyTarget];
    elseif forceData.strategy == 5 then
      forceData.strategyStr = forceData.strategyStr .. "[5]" .. JY.Force[forceData.strategyTarget]["名称"];
    end
    forceData.goldStr = chinese_number(fixNum(forceData.gold) * 10);
    forceData.foodStr = chinese_number(fixNum(forceData.food) * 10);
    forceData.cityNumStr = chinese_number(forceData.cityNum);
    forceData.personNumStr = chinese_number(forceData.personNum);
    if forceData.peopleNum <= 0 then
      forceData.peopleNumStr = "0";
    elseif forceData.peopleNum < 10 then
      forceData.peopleNumStr = math.floor(forceData.peopleNum) .. "百";
    elseif forceData.peopleNum < 100 then
      forceData.peopleNumStr = math.floor(forceData.peopleNum / 10) .. "千";
    else
      forceData.peopleNumStr = math.floor(forceData.peopleNum / 100) .. "万";
    end
    forceData.peopleNumStr = chinese_number(fixNum(forceData.peopleNum) * 100);
    forceData.soldierNumStr = chinese_number(fixNum(forceData.soldierNum));
  end
	local function redraw()
		DrawGame();
		local x, y = x0, y0;
		LoadPicEnhance(73, x, y, width, height);
		x = x + 144; y = y + 16;
		LoadPicEnhance(79, x, y, 120);
		LoadPicEnhance(72, x - 16, y + 38, width -  160);
		DrawStringEnhance(x + 60, y + 5, forceData.name, C_WHITE, size, 0.5);
		y = y + 4;	x = x + 140;
		DrawStringEnhance(x, y, "君主", C_Name, size);					DrawStringEnhance(x + 60, y, forceData.leaderName, C_WHITE, size);
		lib.PicLoadCache(4, 87 * 2, x + 220, y, 1);
    DrawStringEnhance(x + 244, y + 4, forceData.titleName, C_WHITE, size2, 0.5);
		
		y = y + 50;
    lib.PicLoadCache(2, (JY.Person[forceData.leader]["容貌"] + 0000) * 2, x - 160, y, 1, nil, nil, 240);
    x = x + 80;
    DrawStringEnhance(x, y, "都城", C_Name, size);					DrawStringEnhance(x + 60, y, forceData.capitalName, C_WHITE, size);			y = y + size + 4;
    DrawStringEnhance(x, y, "资金", C_Name, size);					DrawStringEnhance(x + 60, y, forceData.goldStr, C_WHITE, size);     x = x + 180;
    DrawStringEnhance(x, y, "物资", C_Name, size);					DrawStringEnhance(x + 60, y, forceData.foodStr, C_WHITE, size);			y = y + size + 4; x = x - 180;
    DrawStringEnhance(x, y, "都市", C_Name, size);					DrawStringEnhance(x + 60, y, forceData.cityNumStr, C_WHITE, size);			x = x + 180
    DrawStringEnhance(x, y, "武将", C_Name, size);					DrawStringEnhance(x + 60, y, forceData.personNumStr, C_WHITE, size);			y = y + size + 4; x = x - 180;
    DrawStringEnhance(x, y, "人口", C_Name, size);					DrawStringEnhance(x + 60, y, forceData.peopleNumStr, C_WHITE, size);			x = x + 180
    DrawStringEnhance(x, y, "兵力", C_Name, size);					DrawStringEnhance(x + 60, y, forceData.soldierNumStr, C_WHITE, size);			y = y + size + 4; x = x - 180;
    DrawStringEnhance(x, y, "战略", C_Name, size);					DrawStringEnhance(x + 60, y, forceData.strategyStr, C_WHITE, size);			--x = x + 180
    
    x = x + 120; y = y + 96;
    lib.PicLoadCache(4, 700 * 2, x, y, 1, nil, nil, 203);
    for i, city in ipairs(forceData.citys) do
      lib.PicLoadCache(4, (city + 700) * 2, x, y, 1 + 4, nil, forceData.color, 203);
    end
    x, y = x + forceData.cityX, y + forceData.cityY;
    lib.Background(x - 3, y - 2, x + 3, y + 2, 128);
    lib.Background(x - 2, y - 3, x + 2, y + 3, 128);
    lib.Background(x - 2, y - 1, x + 2, y + 1, 32, C_Name);
    lib.Background(x - 1, y - 2, x + 1, y + 2, 32, C_Name);
    DrawStringEnhance(x + 4, y, "[B]" .. forceData.capitalName, C_WHITE, 16, 0, 0.5);
		button_redraw(bt);
		drawSingleList(sl);
	end
  getForceData();
	while true do
		local t1=lib.GetTime();
		redraw();
		ShowScreen();
		local delay = CC.FrameNum - lib.GetTime() + t1;
		if delay > 0 then
			lib.Delay(delay);
		end
		getkey();
		if eventSingleList(sl) then
			index = sl.select;
			fid = plist[index]
      getForceData();
		end
		local event, btid = button_event(bt);
		if event == 3 then
			if btid == 1 then
				return 1;
			elseif btid == 2 then
				return 0;
			elseif btid == 11 then
				ShowCityList(GetForceCityList(fid), 0);
			elseif btid == 12 then
				ShowPersonList(GetForceWujiang(fid), nil, 1);
			end
		end
	end
end
function SelectCity(kind,purpose)
	--kind --0,查看势力	1,查看任意城市	2,查看空白城市	
	--purpose --0 查看 1，选择空白城市 不可返回	2, 选择接壤城市 可返回 3,选择存活势力 不可返回
	local x0,y0=CC.ScreenW-520,32;
	local lstr,tx,ty="",0,0;	--鼠标移动到的city/force
	local sid,cid=0,0;
	local pid=797;
	--UI
	local bt={};
	if purpose==0 then
		button_mainbt_1(bt,"返回",2)
	elseif purpose==1 or purpose==2 or purpose==3 then
		button_mainbt_2(bt,"决定","返回",1,2);
	end
	--[[
		button_mainbt_1(bt,"确认",2)
	elseif kind==1 then
		button_mainbt_2(bt,"决定","返回",1,2);
	else
		button_mainbt_1(bt,"返回",2)
	end]]--
	--init
	for i=1,JY.CityNum-1 do
		JY.City[i]["标记"]=0;
	end
	local function setforce(fid,v)
		for i=1,JY.CityNum-1 do
			if JY.City[i]["势力"]==fid then
				JY.City[i]["标记"]=v;
			end
		end
	end
	local function redraw()
		lib.PicLoadCache(5,201*2,0,0,1)		--		x0-504,y0-112,1);
		--DrawGame()
		DrawCCityM(x0,y0);
		if #lstr>0 then
			DrawLabel(tx,ty,lstr);
		end
		local x,y=96,80;
		if cid==0 then
			cid=sid;
		end
		if cid>0 then
			if kind==0 then
				DrawForceStatus(cid,100,64);
			elseif kind==1 then
				DrawCityStatus(cid,100,64);
			end
		end
		button_redraw(bt);
	end
	if kind==0 then
		for i=1,JY.CityNum-1 do
			if JY.City[i]["势力"]==0 then
				JY.City[i]["标记"]=0;
			else
				JY.City[i]["标记"]=1;
			end
		end
	elseif kind==1 then
		for i=1,JY.CityNum-1 do
			if purpose==1 and JY.City[i]["势力"]>0 then
				JY.City[i]["标记"]=0;
			elseif purpose==2 and (JY.City[i]["接壤"]==0 or JY.City[i]["势力"]==JY.FID) then
				JY.City[i]["标记"]=0;
			else
				JY.City[i]["标记"]=1;
			end
		end
	end
	--
	redraw();
	if purpose==1 then
		Talk(pid,"请选择一个空白城池开始吧。");
	elseif purpose==2 then
		Talk(pid,"请选择要攻打的城池。");
	elseif purpose==3 then
		Talk(pid,"请选择一个势力开始吧。");
	end
	while true do
		local t1=lib.GetTime();
		redraw();
		ShowScreen();
		local delay=CC.FrameNum-lib.GetTime()+t1;
		if delay>0 then
			lib.Delay(delay);
		end
		--
		cid=0;
		lstr="";
		if kind==0 then
			for i=1,JY.CityNum-1 do
				if JY.City[i]["标记"]==0 then
					
				elseif JY.City[i]["势力"]==sid then
					JY.City[i]["标记"]=3;
				else
					JY.City[i]["标记"]=1;
				end
			end
		elseif kind==1 then
			for i=1,JY.CityNum-1 do
				if JY.City[i]["标记"]==0 then
				
				elseif i==sid then
					JY.City[i]["标记"]=3;
				else
					JY.City[i]["标记"]=1;
				end
			end
		end
		getkey();
		local event,btid=button_event(bt);
		if event==3 then
			if btid==1 then
				if purpose==0 then
					return 0;
				elseif purpose==1 then
					if sid>0 then
						return sid;
					else
						Talk(pid,"请先选择一个城池。");
					end
				elseif purpose==2 then
					if sid>0 then
						return sid;
					else
						Talk(pid,"还没有选择要攻打的城池。");
					end
				elseif purpose==3 then
					if sid>0 then
						return sid;
					else
						Talk(pid,"请先选择一个势力。");
					end
				end
			elseif btid==2 then
				return 0;
			end
		end
		if MOUSE.IN(x0,y0,x0+520,y0+448) then
			for i=1,JY.CityNum-1 do
				local x1,y1=x0+JY.City[i]["中地图X"],y0+JY.City[i]["中地图Y"];
				if MOUSE.CLICK(x1-7,y1-7,x1+6,y1+6) then
					if kind==0 then			lstr=JY.Force[JY.City[i]["势力"]]["名称"];
					elseif kind==1 then		lstr=JY.City[i]["名称"];					end
					tx,ty=MOUSE.x,MOUSE.y;
					if between(JY.City[i]["标记"],1,3) then
						PlayWavE(0);
						if kind==0 then
							cid=JY.City[i]["势力"];
							if cid==sid then
								setforce(sid,2);
								sid=0;
							else
								if sid>0 then
									setforce(sid,1);
								end
								sid=cid;
								setforce(sid,3);
							end
						elseif kind==1 then
							cid=i;
							if i==sid then
								sid=0;
								JY.City[i]["标记"]=2;
							else
								sid=i;
								JY.City[i]["标记"]=3;
							end
						end
						break;
					end
				elseif MOUSE.HOLD(x1-7,y1-7,x1+6,y1+6) then
					if kind==0 then			lstr=JY.Force[JY.City[i]["势力"]]["名称"];
					elseif kind==1 then		lstr=JY.City[i]["名称"];					end
					tx,ty=MOUSE.x,MOUSE.y;
					if kind==0 then
						if JY.City[i]["标记"]==1 then
							cid=JY.City[i]["势力"];
							setforce(cid,3);
						end
					elseif kind==1 then
						if JY.City[i]["标记"]==1 then
							cid=i;
							JY.City[i]["标记"]=3;
						end
					end
					break;
				elseif MOUSE.IN(x1-7,y1-7,x1+6,y1+6) then
					if kind==0 then			lstr=JY.Force[JY.City[i]["势力"]]["名称"];
					elseif kind==1 then		lstr=JY.City[i]["名称"];					end
					tx,ty=MOUSE.x,MOUSE.y;
					if kind==0 then
						if JY.City[i]["标记"]==1 then
							cid=JY.City[i]["势力"];
							setforce(cid,2);
						end
					elseif kind==1 then
						if JY.City[i]["标记"]==1 then
							cid=i;
							JY.City[i]["标记"]=2;
						end
					end
					break;
				end
			end
		end
	end
end
function SelectArmy(cid)
	local width=960;
	local height=480;
	local x0=(CC.ScreenW-width)/2;
	local y0=(CC.ScreenH-height)/2;
	local x_map=x0+32;
	local y_map=y0+32;
	local bt={};
	local flag=1;
	if flag==1 then
		button_mainbt_2(bt,"开战","返回",1,2);
	elseif flag==2 then
		button_mainbt_1(bt,"开战",1)
	end
	table.insert(bt,button_creat(1,11,15,20,"编制",true,true));
	local ml;
	local sortlist={};
	local strlist={};
	local offset={};
	local title={};
	offset={0,90,180,270,360,450}
	title={"武将","兵力","兵种","适性","攻击","防御",};
	local plist={};
	local army={};
	local army_info={};
	local function fresh()
		army_info={};
		for i,v in ipairs(army) do
			sortlist[v]={v,v.bl,v.bz,JY.Person[v.pid]["步兵适性"],JY.Person[v.pid]["弓兵适性"],JY.Person[v.pid]["骑兵适性"]};
			strlist[v]={"--","--","--","--","--","--",};
			strlist[v][1]=JY.Person[v.pid]["名称"];
			strlist[v][2]=""..v.bl;
			strlist[v][3]=JY.Bingzhong[v.bz]["名称"];
			for ii,vv in ipairs({"步兵适性","弓兵适性","骑兵适性"}) do
				if ii==JY.Bingzhong[v.bz]["兵系"] then
					strlist[v][4]=vv..JY.Str[JY.Person[v.pid][vv]+9160];
					break;
				end
			end
			local att=20+math.max(20000/(200-JY.Person[v.pid]["武力"])-100,v.bl*2/(200-JY.Person[v.pid]["统率"])-100)+v.bl/200;
			strlist[v][5]=""..math.floor(att*math.max(JY.Bingzhong[v.bz]["攻击力"],JY.Bingzhong[v.bz]["远程攻击力"])/10);
			strlist[v][6]=""..math.floor(att*JY.Bingzhong[v.bz]["防御力"]/10);
			army_info[v.pid]={bz=v.bz,bl=v.bl};
		end
		ml=creatMultiList(x0+128,y0+16,704,height-64,plist,sortlist,strlist,title,offset)
	end
	local function redraw()
		DrawGame();
		LoadPicEnhance(73,x0,y0,width,height);
		drawMultiList(ml);
		if ml.on>0 then
			lib.PicLoadCache(2,(JY.Person[plist[ml.on]]["容貌"]+2000)*2,ml.x1-45,ml.y1+ml.pixel_row*(ml.on-ml.top+0.5));
		end
		button_redraw(bt);
	end
	fresh();
	while true do
		local t1=lib.GetTime();
		if #plist>0 then
			bt[2].enable=true;
		else
			bt[2].enable=false;
		end
		redraw();
		ShowScreen();
		local delay=CC.FrameNum-lib.GetTime()+t1;
		if delay>0 then
			lib.Delay(delay);
		end
		getkey();
		if eventMultiList(ml) then
			local sel=army[ml.select];
			ml.select=0;
			sel.bz,sel.bl=SelectUnitTypeNum(sel.bz,sel.bl,{1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16},20000);
			fresh();
		end
		local event,btid=button_event(bt);
		if event==3 then
			if btid==1 then
				return army;
			elseif btid==2 then
				return {};
			elseif btid==11 then
				plist=ShowPersonList(GetCityWujiang(cid),nil,nil,10,plist);
				army={};
				for i,v in ipairs(plist) do
					if army_info[v]==nil then
						army[i]={pid=v,bz=1,bl=0};
					else
						army[i]={pid=v,bz=army_info[v].bz,bl=army_info[v].bl};
					end
				end
				fresh();
			end
		end
	end
end
function SelectUnitTypeNum(bz,bl,bzlist,blmax)
	local width=640;
	local height=320;
	local x0=(CC.ScreenW-width)/2;
	local y0=(CC.ScreenH-height)/2;
	local x_map=x0+32;
	local y_map=y0+32;
	local bt={};
	button_mainbt_1(bt,"决定",1,(CC.ScreenH+height)/2-64);
	--兵种
	local sortlist={};
	local strlist={};
	local offset={};
	local title={};
	offset={0,60,120}
	title={"兵种","攻击","防御",};
	local idx=1;
	for i,v in ipairs(bzlist) do
		sortlist[v]={v,math.max(JY.Bingzhong[v]["攻击力"],JY.Bingzhong[v]["远程攻击力"]),JY.Bingzhong[v]["防御力"]}
		strlist[v]={"--","--","--",};
		strlist[v][1]=JY.Bingzhong[v]["名称"];
		strlist[v][2]=""..math.max(JY.Bingzhong[v]["攻击力"],JY.Bingzhong[v]["远程攻击力"]);
		strlist[v][3]=""..JY.Bingzhong[v]["防御力"];
		if bz==v then
			idx=i;
		end
	end
	local ml=creatMultiList(x0+100,y0+48,200,160,bzlist,sortlist,strlist,title,offset);
	rollMultiList(ml,idx);
	--兵力
	local np=creatNumPad(x0+340,y0+48,bl,0,blmax);
	
	local sid=lib.SaveSur(0,0,CC.ScreenW,CC.ScreenH);
	local function redraw()
		lib.LoadSur(sid,0,0);
		LoadPicEnhance(73,x0,y0,width,height);
		--Glass(x0,y0,x0+width,y0+height);
		drawMultiList(ml);
		drawNumPad(np);
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
		if eventMultiList(ml) then
			
		end
		eventNumPad(np);
		local event,btid=button_event(bt);
		if event==3 then
			if btid==1 then
				lib.FreeSur(sid);
				return ml.val,np.v;
			end
		end
	end
end
function SelectArmy(cid)
	local width=960;
	local height=480;
	local x0=(CC.ScreenW-width)/2;
	local y0=(CC.ScreenH-height)/2;
	local bt={};
	local per={}
	for i=1,5 do
		per[i]={x=x0+192+128*i,y=y0+32,pid=0,bz=0,bl=0,on=false,hold=false}
	end
	for i=6,10 do
		per[i]={x=x0+192+128*(i-5),y=y0+256,pid=0,bz=0,bl=0,on=false,hold=false}
	end
	local flag=1;
	if flag==1 then
		button_mainbt_2(bt,"开战","返回",1,2);
	elseif flag==2 then
		button_mainbt_1(bt,"开战",1)
	end
	table.insert(bt,button_creat(1,11,150,200,"自动编制",true,true));
	table.insert(bt,button_creat(1,12,150,260,"最大兵力",true,true));
	local plist={};
	local army={};
	local function redraw()
		DrawGame();
		LoadPicEnhance(73,x0,y0,width,height);
		for i,v in ipairs(per) do
			if v.pid>0 then
				lib.PicLoadCache(2,(JY.Person[v.pid]["容貌"]+4000)*2,v.x,v.y,1);
			else
				lib.PicLoadCache(4,112*2,v.x,v.y,1);
			end
			if v.hold==1 then
				lib.PicLoadCache(4,9*2,v.x-3,v.y-3,1);
			elseif v.on==1 then
				lib.PicLoadCache(4,8*2,v.x-3,v.y-3,1);
			else
				lib.PicLoadCache(4,7*2,v.x-3,v.y-3,1);
			end
			lib.PicLoadCache(4,113*2,v.x-3,v.y+129,1);
			if v.pid>0 then
				DrawStringEnhance(v.x+87,v.y+131,""..v.bl,C_WHITE,22,1);
			end
			if v.pid==0 then
				lib.PicLoadCache(4,33*2,v.x-3,v.y+158,1);
			elseif v.hold==3 then
				lib.PicLoadCache(4,32*2,v.x-3,v.y+158,1);
				DrawStringEnhance(v.x+45+1,v.y+158+17+1,JY.Bingzhong[v.bz]["名称"],C_BLACK,20,0.5,0.5);
			elseif v.on==3 then
				lib.PicLoadCache(4,31*2,v.x-3,v.y+158,1);
				DrawStringEnhance(v.x+45,v.y+158+17,JY.Bingzhong[v.bz]["名称"],C_BLACK,20,0.5,0.5);
			else
				lib.PicLoadCache(4,30*2,v.x-3,v.y+158,1);
				DrawStringEnhance(v.x+45,v.y+158+17,JY.Bingzhong[v.bz]["名称"],C_BLACK,20,0.5,0.5);
			end
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
		for i,v in ipairs(per) do
			v.on=0;
			v.hold=0
			if MOUSE.CLICK(v.x,v.y,v.x+90,v.y+128) then
				PlayWavE(0);
				plist={};
				for ii,vv in ipairs(per) do
					if vv.pid>0 then
						table.insert(plist,vv.pid);
					end
				end
				v.pid=ShowPersonList(GetCityWujiang(cid,plist));
				v.bz=1;
			elseif MOUSE.HOLD(v.x,v.y,v.x+90,v.y+128) then
				v.hold=1;
			elseif MOUSE.IN(v.x,v.y,v.x+90,v.y+128) then
				v.on=1;
			end
			if v.pid>0 then
				if MOUSE.CLICK(v.x,v.y+129,v.x+90,v.y+129+30) then
					PlayWavE(0);
					local sy=v.y+129+30;
					if sy>CC.ScreenH/2 then
						sy=sy-208-30;
					end
					v.bl=ShowNumPad(v.x-83,sy,v.bl,0,20000);
				elseif MOUSE.HOLD(v.x,v.y+129,v.x+90,v.y+129+30) then
					v.hold=2;
				elseif MOUSE.IN(v.x,v.y+129,v.x+90,v.y+129+30) then
					v.on=2;
				end
				if MOUSE.CLICK(v.x,v.y+158+5,v.x+90,v.y+158+29) then
					PlayWavE(0);
					local sy=v.y+158;
					if sy>CC.ScreenH/2 then
						sy=sy-210+36;
					end
					v.bz=ShowBZList(v.x-5,sy,v.bz,{1,2,3,4,5,6,7,8,9,10,11,12,13,14})
				elseif MOUSE.HOLD(v.x,v.y+158+5,v.x+90,v.y+158+29) then
					v.hold=3;
				elseif MOUSE.IN(v.x,v.y+158+5,v.x+90,v.y+158+29) then
					v.on=3;
				end
			end
		end
		
		local event,btid=button_event(bt);
		if event==3 then
			if btid==1 then
				army={};
				for i,v in ipairs(per) do
					if v.pid>0 then
						table.insert(army,{pid=v.pid,bz=v.bz,bl=v.bl})
					end
				end
				return army;
			elseif btid==2 then
				return {};
			elseif btid==11 then
				for i,v in ipairs(per) do
					v.pid=0;
					v.bz=0;
					v.bl=0;
				end
				for i,v in ipairs(AutoSelectArmy(cid)) do
					per[i].pid=v.pid;
					per[i].bz=v.bz;
					per[i].bl=v.bl;
				end
			elseif btid==12 then
				for i,v in ipairs(per) do
					v.bl=20000;
				end
			end
		end
	end
end
function ShowNumPad(x0,y0,v,minv,maxv)
	local np=creatNumPad(x0,y0,v,minv,maxv);
	while true do
		local t1=lib.GetTime();
		drawNumPad(np);
		ShowScreen();
		local delay=CC.FrameNum-lib.GetTime()+t1;
		if delay>0 then
			lib.Delay(delay);
		end
		getkey();
		if eventNumPad(np) then
			return np.val;
		end
	end
end
function ShowBZList(x0,y0,bz,bzlist)
	local idx=1;
	local strlist={}
	for i,v in ipairs(bzlist) do
		strlist[i]=JY.Bingzhong[v]["名称"];
		if bz==v then
			idx=i;
		end
	end
	local sl=creatSingleList(x0+6,y0+8,68,31*5,bzlist,strlist,"兵种")
	rollSingleList(sl,idx);
	while true do
		local t1=lib.GetTime();
		LoadPicEnhance(115,x0,y0,102,210);
		drawSingleList(sl);
		ShowScreen();
		local delay=CC.FrameNum-lib.GetTime()+t1;
		if delay>0 then
			lib.Delay(delay);
		end
		getkey();
		if eventSingleList(sl) then
			return sl.val;
		end
	end
	
end
function AutoSelectArmy(cid)
	local army={};
	local plist=GetCityWujiang(cid);
	local bzlist={1,4,7}
	local function value(pid)
		local v=JY.Person[pid]["统率"]+JY.Person[pid]["武力"]/2;
		v=v+10*math.max(JY.Person[pid]["步兵适性"],JY.Person[pid]["骑兵适性"],JY.Person[pid]["弓兵适性"]);
		return v;
	end
	local function bz_value(pid,bzid)
		local v=JY.Person[pid]["统率"]+JY.Person[pid]["武力"]/2;
		v=v+10*math.max(JY.Person[pid]["步兵适性"],JY.Person[pid]["骑兵适性"],JY.Person[pid]["弓兵适性"]);
		return v;
	end
	table.sort(plist,function(a,b) 
						if value(a)>value(b) then
							return true;
						end
					end)
	local num=math.min(10,#plist);
  plist = Sample(plist,num)
	local bl_actual=JY.City[cid]["兵力"];
	local bl_max=0;
	for i=1,num do
		bl_max=bl_max+GetMaxBingli(plist[i]);
	end
	for i=1,num do
		local pid=plist[i];
		local bz=1;
		local v,maxv=0,0;
		for id=1,9 do
			v=0;
			if JY.Bingzhong[id]["兵系"]==1 then
				v=JY.Person[pid]["步兵适性"]*10+JY.Person[pid]["统率"]/10+JY.Bingzhong[id]["攻击力"]+JY.Bingzhong[id]["防御力"];
			elseif JY.Bingzhong[id]["兵系"]==2 then
				v=JY.Person[pid]["弓兵适性"]*10+JY.Person[pid]["智谋"]/10+JY.Bingzhong[id]["远程攻击力"]+JY.Bingzhong[id]["防御力"]+JY.Bingzhong[id]["射程"]/10;
			else
				v=JY.Person[pid]["骑兵适性"]*10+JY.Person[pid]["武力"]/10+JY.Bingzhong[id]["攻击力"]+JY.Bingzhong[id]["防御力"];
			end
			if v>maxv then
				maxv=v;
				bz=id;
			end
		end
		table.insert(army,{pid=pid,bz=bz,bl=100*math.floor(GetMaxBingli(plist[i])/100*limitX(bl_actual/bl_max,0,1))});
	end
	return army;
end
function GetMaxBingli(pid)
	local v=math.max(3000,math.floor(ValueAdjust(JY.Person[pid]["统率"],70)*1)*100);
	if JY.Person[pid]["技能8"]>0 then
		v=v+2000;
	end
	return v;
end