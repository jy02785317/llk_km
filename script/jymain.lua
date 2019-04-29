
function JY_Main()        --主程序入口
	os.remove("debug.txt");        --清除以前的debug输出
    xpcall(JY_Main_sub,myErrFun);     --捕获调用错误
end

function myErrFun(err)      --错误处理，打印错误信息
    lib.Debug(err);                 --输出错误信息
    lib.Debug(debug.traceback());   --输出调用堆栈信息
end
function SetGlobal()   --设置游戏内部使用的全程变量
	JY={};
	JY.Status=GAME_START  --游戏当前状态
	--保存R×数据
	JY.Base={};           --基本数据
	JY.ForceNum=0;      --Force个数
	JY.Force={};        --Force数据
	JY.PersonNum=0;      --人物个数
	JY.Person={};        --人物数据
	JY.BingzhongNum=0;      --人物个数
	JY.Bingzhong={};        --人物数据
	JY.SceneNum=0;      --场景个数
	JY.Scene={};        --场景数据
	JY.WarmapNum=0;      --战场个数
	JY.Warmap={};        --战场数据
	JY.CityNum=0;
	JY.City={};
	JY.ConnectionNum=0;
	JY.Connection={};
  JY.CityToCity = {};
	JY.ItemNum=0;      --道具个数
	JY.Item={};        --道具数据
	JY.TitleNum=0;      --策略个数
	JY.Title={};        --策略数据
	JY.SkillNum=0;      --特技个数
	JY.Skill={};        --特技数据
	JY.StrNum=0;
	JY.Str={};
	JY.SubScene=-1;          --当前子场景编号
	JY.SubPic=-1;
	JY.SubSceneX=0;          --子场景显示位置偏移，场景移动指令使用
	JY.SubSceneY=0;

	JY.Darkness=0;             --=0 屏幕正常显示，=1 不显示，屏幕全黑

	JY.MmapMusic=-1;         --切换大地图音乐，返回主地图时，如果设置，则播放此音乐

	JY.CurrentBGM=-1;       --当前播放的音乐id，用来在关闭音乐时保存音乐id．
	JY.EnableMusic=1;        --是否播放音乐 1 播放，0 不播放
	JY.EnableSound=1;        --是否播放音效 1 播放，0 不播放
	
	JY.NameList={};
	JY.Talk={headid=0,name="",str=""};
	JY.Dark=true;
	JY.CURRENT_COLOR=C_WHITE;
	JY.PID=0;
	JY.FID=0;
	JY.GameStatus=creatGameStatus();
	JY.CityMenu=creatCityMenu();
	JY.Tid=0;		--SMAP时，当前选择的人物 或 正在说话的人物
	JY.LLK_N=0;
	JY.DG={
			pid=-1,
		}
	JY.EventID=1;
	JY.LoadedPic=0;
	JY.MenuPic={
				num=0,
				pic={},
				x={},
				y={},
				}
	JY.Death=0;	--用于战场事件-"当消灭XX时触发"
	JY.EventType=0;	--0坐标测试 1属性测试 2游戏状态测试 3我军回合开始 4友军回合开始 5敌军回合开始
	JY.ReFreshTime=0;
	War={};
	War.Person={};
	TeamSelect={};	--用于储存战斗前人物选择
end

function JY_Main_sub()        --真正的游戏主程序入口
	lib.FillColor();
	lib.ShowSurface(0);
	dofile(CONFIG.ScriptPath .. "jyconst.lua");
	dofile(CONFIG.ScriptPath .. "S.RPG.lua");
	dofile(CONFIG.ScriptPath .. "S.lua");
	dofile(CONFIG.ScriptPath .. "fight.lua");
	dofile(CONFIG.ScriptPath .. "UI.lua");
	dofile(CONFIG.ScriptPath .. "mouse.lua");
	dofile(CONFIG.ScriptPath .. "input.lua");
	dofile(CONFIG.ScriptPath .. "Asura.lua");
	dofile(CONFIG.ScriptPath .. "kdef.lua");
	dofile(CONFIG.ScriptPath .. "LLK_III.lua");
	dofile(CONFIG.ScriptPath .. "AI.lua");
	dofile(CONFIG.ScriptPath .. "Sha.lua");
	dofile(CONFIG.ScriptPath .. "km.lua");
	dofile(CONFIG.ScriptPath .. "km_scenario.lua");
	dofile(CONFIG.ScriptPath .. "km_battle.lua");
	dofile(CONFIG.ScriptPath .. "xmlSimple.lua");
	xml = newParser()
	-- xml = require("xmlSimple").newParser()
	SetGlobalConst();
	SetGlobal();
    --禁止访问全程变量
    setmetatable(_G,{ __newindex =function (_,n)
                       error("attempt read write to undeclared variable " .. n,2);
                       end,
                       __index =function (_,n)
                       error("attempt read read to undeclared variable " .. n,2);
                       end,
                     }  );
    lib.Debug("JY_Main start.");

	math.randomseed(tostring(os.time()):reverse():sub(1, 6));         --初始化随机数发生器
	lib.EnableKeyRepeat(CONFIG.KeyRepeatDelay,CONFIG.KeyRePeatInterval);   --设置键盘重复率

    lib.GetKey();
	
	--加载HZ
    local hznum=20000;
	local datasize=(4+6)*hznum;
	local data=Byte.create(datasize);
    Byte.loadfile(data,CONFIG.DataPath .. "EFTDATA.R3",0,datasize);
	CC.Font={};
	local odx=Byte.get32(data,2);
	for i=1,hznum do
	    local idx=Byte.get32(data,2+4*i);
		if idx-odx>2 then
			local picid=Byte.get16(data,odx);
			odx=odx+2;
			local str=Byte.getstr(data,odx,idx-odx);
			CC.Font[str]=picid;
		end
		odx=idx;
	end
	
	--LoadSan8Record();
	--LLK_III_Main();
	--OK
	
	if false then
		local grp = io.open(".\\data\\hdgrp.grp","wb")
		local idx = Byte.create(4*2000*4)
		local index=0;
		for i=0,2000-1 do
			--local filename=string.format("D:\\连连看II\\pic\\San13\\output_03\\1_%04d_.png",i);
			local filename=string.format("D:\\连连看II\\pic\\San13\\X512\\1_%04d_.png",i);
			local sourcefile=io.open(filename,"rb")
			--lib.Debug(filename)
			if filelength(filename)>0 then
				index=index+filelength(filename);
				grp:write(sourcefile:read("*a"))
				sourcefile:close()
			end
			Byte.set32(idx,4*(i),index);
		end
		for i=0,2000-1 do
			local filename=string.format("D:\\连连看II\\pic\\San13\\X128_1\\1_%04d_.png",i);
			local sourcefile=io.open(filename,"rb")
			--lib.Debug(filename)
			if filelength(filename)>0 then
				index=index+filelength(filename);
				grp:write(sourcefile:read("*a"))
				sourcefile:close()
			end
			Byte.set32(idx,4*(2000+i),index);
		end
		for i=0,2000-1 do
			--local filename=string.format("D:\\连连看II\\pic\\San13\\output_01\\2_%04d_.png",i);
			local filename=string.format("D:\\连连看II\\pic\\San13\\X128_2\\2_%04d_.png",i);
			local sourcefile=io.open(filename,"rb")
			--lib.Debug(filename)
			if filelength(filename)>0 then
				index=index+filelength(filename);
				grp:write(sourcefile:read("*a"))
				sourcefile:close()
			end
			Byte.set32(idx,4*(4000+i),index);
		end
		for i=0,2000-1 do
			local filename=string.format("D:\\连连看II\\pic\\San13\\output_04\\4_%04d_.png",i);
			local sourcefile=io.open(filename,"rb")
			--lib.Debug(filename)
			if filelength(filename)>0 then
				index=index+filelength(filename);
				grp:write(sourcefile:read("*a"))
				sourcefile:close()
			end
			Byte.set32(idx,4*(6000+i),index);
		end
		grp:close()
		Byte.savefile(idx,".\\data\\hdgrp.idx",0,4*2000*4);
	end
	if false then
		local grp = io.open(".\\data\\eft.grp","wb")
		local idx = Byte.create(4*40000)
		local index=0;
		local add=1;
		for i=0,20000-1 do
			local filename=string.format("D:\\Documents\\San13\\font2\\images\\1052-%0d.png",i);
			local sourcefile=io.open(filename,"rb")
			if filelength(filename)>0 then
				index=index+filelength(filename);
				grp:write(sourcefile:read("*a"))
				sourcefile:close()
				Byte.set32(idx,4*add,index);	add=add+1;
			end
		end
		for i=add,20000 do
			Byte.set32(idx,4*i,index);
		end
		add=20001;
		for i=0,20000-1 do
			local filename=string.format("D:\\Documents\\San13\\font2\\1053-%0d.png",i);
			local sourcefile=io.open(filename,"rb")
			if filelength(filename)>0 then
				index=index+filelength(filename);
				grp:write(sourcefile:read("*a"))
				sourcefile:close()
				Byte.set32(idx,4*add,index);	add=add+1;
			end
		end
		for i=add,40000-1 do
			Byte.set32(idx,4*i,index);
		end
		grp:close()
		Byte.savefile(idx,".\\data\\eft.idx",0,4*40000);
	end
	if false then
		local grp = io.open("D:\\mmap.grp","wb")
		local idx = Byte.create(4*750)
		local index=0;
		local add=1;
		for i = 1,750 do
			local filename=string.format("D:\\LS11ARC_ac\\ekd2\\map\\images\\new_%03d.png",i);
			local sourcefile=io.open(filename,"rb")
			if filelength(filename)>0 then
				index=index+filelength(filename);
				grp:write(sourcefile:read("*a"))
				sourcefile:close()
			end
			Byte.set32(idx,4*i,index);
		end
		grp:close()
		Byte.savefile(idx,"D:\\mmap.idx",0,4*750);
	end
	
	-- AsuraMain()
	km_mian()
end

function CleanMemory()            --清理lua内存
    if CONFIG.CleanMemory==1 then
		 collectgarbage("collect");
		 --lib.Debug(string.format("Lua memory=%d",collectgarbage("count")));
    end
end


function Game_Cycle()
	for i=JY.Base["事件333"]+1,9999,1 do
		PlayBGM(math.random(19));
		if lianliankan(i+9) then
			if i>JY.Base["事件333"] then
				JY.Base["事件333"]=i;
			end
		else
			return;
		end
	end
end
function lianliankan(level)
	local B={};
	local num;
	local headbox={};
	local X_Num,Y_Num;
	local pic_w,pic_h;
	local x_off,y_off;
	local limit,start_time,now_time;
	local mid_point={
						x={},
						y={},
					};
	local select_a={
						x=0,
						y=0,
					};
	local select_b={
						x=0,
						y=0,
					};
	lib.SetClip(0,0,0,0);
	lib.FillColor(0,0,0,0,0);
	lib.PicLoadFile(CC.HeadPicFile[1],CC.HeadPicFile[2],0);
	pic_w,pic_h=lib.PicGetXY(0,4000*2);
	X_Num=math.floor(CC.ScreenW/pic_w);
	Y_Num=math.floor(CC.ScreenH*15/16/pic_h);
	if X_Num~=math.floor(X_Num/2)*2 and Y_Num~=math.floor(Y_Num/2)*2 then
		if CC.ScreenW-pic_w*X_Num<CC.ScreenH*15/16-pic_h*Y_Num then
			X_Num=X_Num-1;
		else
			Y_Num=Y_Num-1;
		end
	end
	if X_Num<6 or Y_Num<4 then
		WarDrawStrBoxConfirm("屏幕分辨率设置过小！",C_WHITE,true)
		return false;
	end
	num=X_Num*Y_Num/2;
	limit=X_Num*Y_Num*(10+level)*100+5000;
	local function sample(st,rp)
		--随机抽样，rp 是否放回
		local n=#st;
		local r=-1;
		if n>1 then
			n=math.random(n);
		end
		r=st[n];
		if not rp then
			table.remove(st,n);
		end
		return r;
	end
	local t_head={};
	for i=4000,5265 do
		--图片池
		table.insert(t_head,i);
	end
	for i=1,math.min(level,50) do
		headbox[i]=sample(t_head);	--决定本次使用的头像
	end
	t_head={};
	for i=1,Y_Num*X_Num/2 do
		local picid=sample(headbox,true);
		table.insert(t_head,picid);
		table.insert(t_head,picid);
	end
	X_Num=X_Num+2;Y_Num=Y_Num+2;
	for i=1,Y_Num do
		B[i]={};
		for j=1,X_Num do
			if between(i,2,Y_Num-1) and between(j,2,X_Num-1) then
				B[i][j]=sample(t_head);
			else
				B[i][j]=-1;
			end
		end
	end
	x_off=math.floor((CC.ScreenW-pic_w*X_Num)/2);
	y_off=math.floor(CC.ScreenH/16+(CC.ScreenH*15/16-pic_h*Y_Num)/2);
	local function SHOW()
		for y=1,Y_Num do
			for x=1,X_Num do
				if B[y][x]>-1 then
					--if (x==select_a.x and y==select_a.y) or (x==select_b.x and y==select_b.y) then
						--lib.PicLoadCache(0,B[y][x],pic_w*(x-1)+x_off,pic_h*(y-1)+y_off,3,128);
						--DrawBox(pic_w*(x-1)+x_off,pic_h*(y-1)+y_off,pic_w*x+x_off,pic_h*y+y_off,C_WHITE);
					--else
						lib.PicLoadCache(0,B[y][x]*2,pic_w*(x-1)+x_off,pic_h*(y-1)+y_off,1);
					--end
				end
			end
		end
		
		if select_a.x~=0 and select_a.y~=0 then
			DrawBox(pic_w*(select_a.x-1)+x_off,pic_h*(select_a.y-1)+y_off,pic_w*select_a.x+x_off,pic_h*select_a.y+y_off,C_WHITE);
		end
		if select_b.x~=0 and select_b.y~=0 then
			DrawBox(pic_w*(select_b.x-1)+x_off,pic_h*(select_b.y-1)+y_off,pic_w*select_b.x+x_off,pic_h*select_b.y+y_off,C_WHITE);
		end
		--DrawTime()
	end
	local function DrawTime()
		now_time=lib.GetTime();
		lib.FillColor(0,0,CC.ScreenW,CC.ScreenH/16,RGB(192,192,192));
		DrawString(0,0,string.format("Level:%d",level-9),C_ORANGE,16);
		DrawBox(160,3,CC.ScreenW-4,CC.ScreenH/16-5,C_WHITE);
		DrawBox(160,3,160+(CC.ScreenW-164)*(start_time+limit-now_time)/limit,CC.ScreenH/16-5,C_WHITE);
	end
	local function Delay(t)
		for i=1,t,10 do
			DrawTime();
			lib.ShowSurface(0);
			lib.Delay(10);
		end
	end
	local function FIND()
		local len_min=(X_Num+Y_Num)*2;
		for x=1,X_Num do
			local flag=true;
			local step;
			if select_b.y>select_a.y then
				step=1;
			elseif select_b.y==select_a.y then
				step=0;
			else
				step=-1;
			end
			if step~=0 then
				for y=select_a.y+step,select_b.y-step,step do
					if B[y][x]~=-1 then
						flag=false;
						break;
					end
				end
			end
			if flag then
				if select_a.x>x then
					step=1;
				elseif select_a.x==x then
					step=0;
				else
					step=-1;
				end
				if step~=0 and x~=select_a.x then
					for xx=x,select_a.x-step,step do
						if B[select_a.y][xx]~=-1 then
							flag=false;
							break;
						end
					end
				end
				if flag then
					if select_b.x>x then
						step=1;
					elseif select_b.x==x then
						step=0;
					else
						step=-1;
					end
					if step~=0 and x~=select_b.x then
						for xx=x,select_b.x-step,step do
							if B[select_b.y][xx]~=-1 then
								flag=false;
								break;
							end
						end
					end
					if flag then
						local len=math.abs(x-select_a.x)+math.abs(x-select_b.x)+math.abs(select_a.y-select_a.y);
						if len<len_min then
							len_min=len;
							mid_point.x[1]=select_a.x;
							mid_point.y[1]=select_a.y;
							mid_point.x[2]=x;
							mid_point.y[2]=select_a.y;
							mid_point.x[3]=x;
							mid_point.y[3]=select_b.y;
							mid_point.x[4]=select_b.x;
							mid_point.y[4]=select_b.y;
						end
					end
				end
			end
		end
		for y=1,Y_Num do
			local flag=true;
			local step;
			if select_b.x>select_a.x then
				step=1;
			elseif select_b.x==select_a.x then
				step=0;
			else
				step=-1;
			end
			if step~=0 then
				for x=select_a.x+step,select_b.x-step,step do
					if B[y][x]~=-1 then
						flag=false;
						break;
					end
				end
			end
			if flag then
				if select_a.y>y then
					step=1;
				elseif select_a.y==y then
					step=0;
				else
					step=-1;
				end
				if step~=0 and y~=select_a.y then
					for yy=y,select_a.y-step,step do
						if B[yy][select_a.x]~=-1 then
							flag=false;
							break;
						end
					end
				end
				if flag then
					if select_b.y>y then
						step=1;
					elseif select_b.y==y then
						step=0;
					else
						step=-1;
					end
					if step~=0 and y~=select_b.y then
						for yy=y,select_b.y-step,step do
							if B[yy][select_b.x]~=-1 then
								flag=false;
								break;
							end
						end
					end
					if flag then
						local len=math.abs(y-select_a.y)+math.abs(y-select_b.y)+math.abs(select_a.x-select_a.x);
						if len<len_min then
							len_min=len;
							mid_point.x[1]=select_a.x;
							mid_point.y[1]=select_a.y;
							mid_point.x[2]=select_a.x;
							mid_point.y[2]=y;
							mid_point.x[3]=select_b.x;
							mid_point.y[3]=y;
							mid_point.x[4]=select_b.x;
							mid_point.y[4]=select_b.y;
						end
					end
				end
			end
		end
		if len_min<(X_Num+Y_Num)*2 then
			--lib.Debug('y')
			
			return true;
		else
			return false;
		end
	end
	lib.FillColor(0,0,0,0,0);
	start_time=lib.GetTime();
	now_time=start_time;
	SHOW();
	lib.ShowSurface(0);
	lib.Delay(20);
	while num>0 do
		if (now_time-start_time)>limit then
			WarDrawStrBoxConfirm("失败，游戏即将结束．",C_WHITE,true)
			return false;
		end
		local eventtype,keypress,x,y=lib.GetKey(1);
		if eventtype==3 and keypress==3 then
			PlayWavE(1);
			if WarDrawStrBoxYesNo('结束游戏吗？',C_WHITE,true) then
				return false;
			end
		end
		if eventtype==3 then
			local X=1+math.floor((x-x_off)/pic_w);
			local Y=1+math.floor((y-y_off)/pic_h);
			if x-x_off>=0 and y-y_off>=0 and X>=1 and X<=X_Num and Y>=1 and Y<=Y_Num and B[Y][X]~=-1 then
				if (select_a.x==0 or select_a.y==0) then
					select_a.x=X;
					select_a.y=Y;
					PlayWavE(0);
				elseif select_a.x==X and select_a.y==Y then
					select_a.x=0;
					select_a.x=0;
					PlayWavE(1);
				else
					if (select_b.x==0 or select_b.y==0) then
						select_b.x=X;
						select_b.y=Y;
						PlayWavE(0);
					elseif select_b.x==X and select_b.y==Y then
						select_b.x=0;
						select_b.x=0;
						PlayWavE(1);
					else
						WarDrawStrBoxConfirm("发生异常，游戏即将结束！",C_WHITE,true);
						return false;
					end
				end
			end
			if select_a.x~=0 and select_a.y~=0 and select_b.x~=0 and select_b.y~=0 then
				lib.FillColor(0,0,0,0,0);
				SHOW();
				--lib.ShowSurface(0);
				Delay(50);
				if B[select_a.y][select_a.x]==B[select_b.y][select_b.x] and FIND(1,select_a.x,select_a.y,-1) then
					B[select_a.y][select_a.x]=-1;
					B[select_b.y][select_b.x]=-1;
					num=num-1;
					for t=1,3 do
						if mid_point.x[t]~=mid_point.x[t+1] or mid_point.y[t]~=mid_point.y[t+1] then
							DrawBox(pic_w*mid_point.x[t]+x_off-pic_w/2,pic_h*mid_point.y[t]+y_off-pic_h/2,
									pic_w*mid_point.x[t+1]+x_off-pic_w/2,pic_h*mid_point.y[t+1]+y_off-pic_h/2,C_WHITE);
						end
						--lib.DrawRect
					end
					PlayWavE(11);
					--lib.ShowSurface(0);
					Delay(250);
				else
					PlayWavE(3);
					Delay(400);
				end
				select_a.x=0;
				select_a.y=0;
				select_b.x=0;
				select_b.y=0;
			end
			lib.FillColor(0,0,0,0,0);
			SHOW();
			--lib.ShowSurface(0);
			Delay(10);
		end
			--lib.FillColor(0,0,0,0,0);
			--SHOW();
			--lib.ShowSurface(0);
			Delay(10);
	end
	WarDrawStrBoxConfirm(string.format("恭喜！进入第%d关",level-8),C_WHITE,true)
	lib.ShowSurface(0);
	lib.Delay(500);
	return true;
end

--绘制一个带背景的白色方框，四角凹进
function DrawBox(x1,y1,x2,y2,color)         --绘制一个带背景的白色方框
    local s=4;
    --lib.Background(x1,y1+s,x1+s,y2-s,128);    --阴影，四角空出
    --lib.Background(x1+s,y1,x2-s,y2,128);
    --lib.Background(x2-s,y1+s,x2,y2-s,128);
	lib.Background(x1+4,y1,x2-4,y1+s,128);
	lib.Background(x1+1,y1+1,x1+s,y1+s,128);
	lib.Background(x2-s,y1+1,x2-1,y1+s,128);
	lib.Background(x1,y1+4,x2,y2-4,128);
	lib.Background(x1+1,y2-s,x1+s,y2-1,128);
	lib.Background(x2-s,y2-s+1,x2-1,y2,128);
	lib.Background(x1+4,y2-s,x2-4,y2,128);
	--lib.FillColor(x1,y1,x2,y2,C_RED,100);
	
    local r,g,b=GetRGB(color);
	local color2=RGB(math.floor(r/2),math.floor(g/2),math.floor(b/2));
    DrawBox_1(x1-1,y1-1,x2-1,y2-1,color2);
    DrawBox_1(x1+1,y1-1,x2+1,y2-1,color2);
    DrawBox_1(x1-1,y1+1,x2-1,y2+1,color2);
    DrawBox_1(x1+1,y1+1,x2+1,y2+1,color2);
    DrawBox_1(x1,y1,x2,y2,color);
end

--绘制四角凹进的方框
function DrawBox_1(x1,y1,x2,y2,color)       --绘制四角凹进的方框
    local s=4;
    --lib.DrawRect(x1+s,y1,x2-s,y1,color);
    --lib.DrawRect(x2-s,y1,x2-s,y1+s,color);
    --lib.DrawRect(x2-s,y1+s,x2,y1+s,color);
    --lib.DrawRect(x2,y1+s,x2,y2-s,color);
    --lib.DrawRect(x2,y2-s,x2-s,y2-s,color);
    --lib.DrawRect(x2-s,y2-s,x2-s,y2,color);
    --lib.DrawRect(x2-s,y2,x1+s,y2,color);
    --lib.DrawRect(x1+s,y2,x1+s,y2-s,color);
    --lib.DrawRect(x1+s,y2-s,x1,y2-s,color);
    --lib.DrawRect(x1,y2-s,x1,y1+s,color);
    --lib.DrawRect(x1,y1+s,x1+s,y1+s,color);
    --lib.DrawRect(x1+s,y1+s,x1+s,y1,color);
	lib.DrawRect(x1+s,y1,x2-s,y1,color);
	lib.DrawRect(x1+s,y2,x2-s,y2,color);
	lib.DrawRect(x1,y1+s,x1,y2-s,color);
	lib.DrawRect(x2,y1+s,x2,y2-s,color);
	lib.DrawRect(x1+2,y1+1,x1+s-1,y1+1,color);
	lib.DrawRect(x1+1,y1+2,x1+1,y1+s-1,color);
	lib.DrawRect(x2-s+1,y1+1,x2-2,y1+1,color);
	lib.DrawRect(x2-1,y1+2,x2-1,y1+s-1,color);
	
	lib.DrawRect(x1+2,y2-1,x1+s-1,y2-1,color);
	lib.DrawRect(x1+1,y2-s+1,x1+1,y2-2,color);
	lib.DrawRect(x2-s+1,y2-1,x2-2,y2-1,color);
	lib.DrawRect(x2-1,y2-s+1,x2-1,y2-2,color);
end
--绘制一个带背景的白色方框，四角凹进
function DrawBox(x1,y1,x2,y2,color,bjcolor)         --绘制一个带背景的白色方框
    local s=4
	bjcolor=bjcolor or 0;
	if bjcolor>=0 then
		lib.Background(x1,y1+s,x1+s,y2-s,128,bjcolor);    --阴影，四角空出
		lib.Background(x1+s,y1,x2-s,y2,128,bjcolor);
		lib.Background(x2-s,y1+s,x2,y2-s,128,bjcolor);
	end
	if color>=0 then
		local r,g,b=GetRGB(color);
		DrawBox_1(x1+1,y1,x2,y2,RGB(math.floor(r/2),math.floor(g/2),math.floor(b/2)));
		DrawBox_1(x1,y1,x2-1,y2-1,color);
	end
end
--修改后的drawbox，边框加粗
function DrawGameBox(x1,y1,x2,y2)
	--[[
    lib.DrawRect(x1,y1,x2-1,y1,C_WHITE);
    lib.DrawRect(x1,y1+1,x2-2,y1+1,C_WHITE);
    lib.DrawRect(x1+2,y1+2,x2-2,y1+2,M_SlateGray);
    lib.DrawRect(x1+2,y1+3,x2-3,y1+3,M_SlateGray);
	
	lib.DrawRect(x1,y1+2,x1,y2,C_WHITE);
	lib.DrawRect(x1+1,y1+2,x1+1,y2-1,C_WHITE);
	lib.DrawRect(x1+2,y1+4,x1+2,y2-2,M_SlateGray);
	lib.DrawRect(x1+3,y1+4,x1+3,y2-3,M_SlateGray);
	
	lib.DrawRect(x2-3,y1+4,x2-3,y2-2,C_WHITE);
	lib.DrawRect(x2-2,y1+3,x2-2,y2-2,C_WHITE);
	lib.DrawRect(x2-1,y1+1,x2-1,y2,M_SlateGray);
	lib.DrawRect(x2,y1,x2,y2,M_SlateGray);
	
    lib.DrawRect(x1+4,y2-3,x2-4,y2-3,C_WHITE);
    lib.DrawRect(x1+3,y2-2,x2-4,y2-2,C_WHITE);
    lib.DrawRect(x1+2,y2-1,x2-2,y2-1,M_SlateGray);
    lib.DrawRect(x1+1,y2,x2-2,y2,M_SlateGray);
	]]--
	lib.PicLoadCache(4,260*2,x1,y1,1,255,-1,War.BoxDepth);
	--lib.PicLoadCache(4,263*2,x1-8,y1-8,1);
end
function WarFillColor(x1,y1,x2,y2,clarity,color,size)
	color=color or M_Red;
	clarity=clarity or 128;
	size=size or 2;
	local flag1=true;
	for y=y1,y2-1,size do
		local flag2=flag1;
		for x=x1,x2-1,size do
			if flag2 then
				lib.Background(x,y,x+size,y+size,clarity,color);
			end
			flag2=not flag2;
		end
		flag1=not flag1;
	end
end
--显示阴影字符串
function DrawString(x,y,str,color,size,align)         --显示阴影字符串
	align=align or 0;
	x=x-#str*(size/2)*align;
	lib.DrawStr(x-1,y,str,color,size,CC.FontName,CC.SrcCharSet,CC.OSCharSet);
	lib.DrawStr(x,y,str,color,size,CC.FontName,CC.SrcCharSet,CC.OSCharSet);
end
function DrawStringBG(x,y,str,color,size,align,bg)         --显示阴影字符串
	align=align or 0;
	x=x-#str*(size/2)*align;
	lib.DrawStr(x,y,str,color,size,CC.FontName,CC.SrcCharSet,CC.OSCharSet,bg);
end
function DrawString2(x,y,str,color,size)         --显示阴影字符串
	if CONFIG.Windows then
		lib.DrawStr(x-2,y,str,C_BLACK,size,0,CC.FontName,CC.SrcCharSet,CC.OSCharSet,1);
		lib.DrawStr(x+1,y,str,C_BLACK,size,0,CC.FontName,CC.SrcCharSet,CC.OSCharSet,1);
		DrawString(x,y,str,color,size);
	else
		lib.DrawStr(x-2,y,str,C_BLACK,size,CC.FontName,CC.SrcCharSet,CC.OSCharSet,1);
		lib.DrawStr(x+1,y,str,C_BLACK,size,CC.FontName,CC.SrcCharSet,CC.OSCharSet,1);
		DrawString(x,y,str,color,size);
	end
end
--显示带框的字符串
--(x,y) 坐标，如果都为-1,则在屏幕中间显示
function DrawStrBox(x,y,str,color,size)         --显示带框的字符串
    local ll=#str;
    local w=size*ll/2+2*CC.MenuBorderPixel;
	local h=size+2*CC.MenuBorderPixel;
	if x==-1 then
        x=(CC.ScreenW-size/2*ll-2*CC.MenuBorderPixel)/2;
	end
	if y==-1 then
        y=(CC.ScreenH-size-2*CC.MenuBorderPixel)/2;
	end

    DrawBox(x,y,x+w-1,y+h-1,C_WHITE);
    DrawString(x+CC.MenuBorderPixel,y+CC.MenuBorderPixel,str,color,size);
end
function DrawStrBox(x,y,str,color,size,bjcolor)         --显示带框的字符串
	
	local strarray={}
	local num,maxlen;
	maxlen=0
	num,strarray=Split(str,'*')
	for i=1,num do
		local len=#strarray[i];
		if len>maxlen then
			maxlen=len
		end
	end
	if maxlen==0 then
		return;
	end
    local w=size*maxlen/2+2*CC.MenuBorderPixel;
	local h=2*CC.MenuBorderPixel+size*num;
	if x==-1 then
        x=(CC.ScreenW-size/2*maxlen-2*CC.MenuBorderPixel)/2;
	end
	if y==-1 then
        y=(CC.ScreenH-size*num-2*CC.MenuBorderPixel)/2;
	end
	if x<0 then
		x=CC.ScreenW-size/2*maxlen-2*CC.MenuBorderPixel+x;
	end
	if y<0 then
        y=CC.ScreenH-size*num-2*CC.MenuBorderPixel+y;
	end
	DrawBox(x,y,x+w-1,y+h-1,C_WHITE,bjcolor);
	for i=1,num do
		DrawStringEnhance(x+CC.MenuBorderPixel,y+CC.MenuBorderPixel+size*(i-1),strarray[i],color,size);
	end
end
function DrawStr(x,y,str,color,size)         --显示字符串,会分行
	
	local strarray={}
	local num,maxlen;
	maxlen=0
	num,strarray=Split(str,'\\n')
	for i=1,num do
		local len=#strarray[i];
		if len>maxlen then
			maxlen=len
		end
	end
	if maxlen==0 then
		return;
	end
	for i=1,num do
		DrawStringEnhance(x,y+size*(i-1),strarray[i],color,size);
	end
end
function Split(szFullString,szSeparator)
	local nFindStartIndex = 1
	local nSplitIndex = 1
	local nSplitArray = {}
	while true do
		local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
		if not nFindLastIndex then
			nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
			break
		end
		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
		nFindStartIndex = nFindLastIndex + string.len(szSeparator)
		nSplitIndex = nSplitIndex + 1
	end
	return nSplitIndex,nSplitArray
end
function DrawItemStatus(id,notWar)        --显示物品属性
	DrawStrStatus(JY.Item[id]["名称"],JY.Item[id]["说明"]);
end
function DrawSkillStatus(id)        --显示技能属性
	DrawStrStatus(JY.Skill[id]["名称"],JY.Skill[id]["说明"]);
end
function DrawBingZhongStatus(id)        --显示技能属性
	DrawStrStatus(JY.Bingzhong[id]["名称"],JY.Bingzhong[id]["说明"]);
end
function DrawLieZhuan(name)        --显示列传
	DrawStrStatus("三国英杰列传 - "..name,CC.LieZhuan[name]);
end
function DrawStrStatus(str1,str2)        --显示属性
    lib.GetKey();
	local x,y;
	local w,h=320,128;
	local size=16;
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
	local y1=y+92;
	local y2=y1+24;
	local function redraw(flag)
		JY.ReFreshTime=lib.GetTime();
		if not notWar then
			DrawWarMap();
		end
		lib.PicLoadCache(4,80*2,x,y,1);
		DrawString(x+16,y+10,str1,C_Name,size);	--old y=16
		DrawStr(x+16,y+28,GenTalkString(str2,18),C_WHITE,size); --old y=36
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
	PlayWavE(0);
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
		end
	end
end
function WarDrawStrBoxConfirm(str,color,notWar)        --显示字符串并询问Y/N
    lib.GetKey();
	local x,y;
	local size=16;
	local strarray={}
	local num,maxlen;
	maxlen=0
	str=str.."*            ";
	num,strarray=Split(str,'*')
	for i=1,num do
		local len=#strarray[i];
		if len>maxlen then
			maxlen=len
		end
	end
	if maxlen==0 then
		return;
	end
    local w=size*maxlen/2+2*CC.MenuBorderPixel;
	local h=2*CC.MenuBorderPixel+size*num+6*(num-1);
	--x=16+768/2;
	--y=32+528/2;
	--if notWar then
	--	x=CC.ScreenW/2;
	--	y=CC.ScreenH/2;
	--end
	if JY.Status==GAME_WMAP or JY.Status==GAME_WARWIN or JY.Status==GAME_WARLOSE then
		x=16+(768-0)/2;
		y=32+(528-0)/2;
	elseif JY.Status==GAME_SMAP_AUTO or JY.Status==GAME_SMAP_MANUAL then
		x=16+(640-0)/2;
		y=16+(400-0)/2;
	else
		x=(CC.ScreenW-0)/2;
		y=(CC.ScreenH-0)/2;
	end
	local x4=x+w/2;
	local x3=x4-52;
	local x2=x4-56
	local x1=x3-56
	local y2=y+h/2;
	local y1=y2-24;
	local function redraw(flag)
		JY.ReFreshTime=lib.GetTime();
		if not notWar then
			DrawWarMap();
		end
		if notWar then
			--DrawYJZBox((CC.ScreenW-w)/2,(CC.ScreenH-h)/2,str,color); 
			DrawYJZBox(-1,-1,str,color,notWar);
		else
			DrawYJZBox(-1,-1,str,color);
		end
		if flag==2 then
			lib.PicLoadCache(4,56*2,x3,y1,1);
		else
			lib.PicLoadCache(4,55*2,x3,y1,1);
		end
		if notWar then
			ShowScreen();
		else
			ReFresh();
		end
	end
	local current=0;
	while true do
		redraw(current);
		getkey();
		if MOUSE.HOLD(x3+1,y1+1,x4-1,y2-1) then
			current=2;
		elseif MOUSE.CLICK(x3+1,y1+1,x4-1,y2-1) then
			current=0;
			PlayWavE(0);
			redraw(current);
			if notWar then
				lib.Delay(100);
			else
				WarDelay(4);
			end
			return false;
		else
			current=0;
		end
	end
end
function WarDrawStrBoxYesNo(str,color,notWar)        --显示字符串并询问Y/N
    lib.GetKey();
	local x,y;
	local size=16;
	local strarray={}
	local num,maxlen;
	maxlen=0;
	str=str.."*            ";
	num,strarray=Split(str,'*')
	for i=1,num do
		local len=#strarray[i];
		if len>maxlen then
			maxlen=len
		end
	end
	if maxlen==0 then
		return;
	end
    local w=size*maxlen/2+2*CC.MenuBorderPixel;
	local h=2*CC.MenuBorderPixel+size*num+6*(num-1);
	if JY.Status==GAME_WMAP or JY.Status==GAME_WARWIN or JY.Status==GAME_WARLOSE then
		x=16+(768)/2;
		y=32+(528)/2;
	elseif JY.Status==GAME_SMAP_AUTO or JY.Status==GAME_SMAP_MANUAL then
		x=16+(640)/2;
		y=16+(400)/2;
	else
		x=(CC.ScreenW)/2;
		y=(CC.ScreenH)/2;
	end
	local x4=x+w/2;
	local x3=x4-52;
	local x2=x4-56
	local x1=x3-56
	local y2=y+h/2;
	local y1=y2-24;
	local function redraw(flag)
		JY.ReFreshTime=lib.GetTime();
		if not notWar then
			DrawWarMap();
		end
		if notWar then
			--DrawYJZBox((CC.ScreenW-w)/2,(CC.ScreenH-h)/2,str,color);
			DrawYJZBox(-1,-1,str,color,notWar);
		else
			DrawYJZBox(-1,-1,str,color);
		end
		if flag==1 then
			lib.PicLoadCache(4,52*2,x1,y1,1);
		else
			lib.PicLoadCache(4,51*2,x1,y1,1);
		end
		if flag==2 then
			lib.PicLoadCache(4,54*2,x3,y1,1);
		else
			lib.PicLoadCache(4,53*2,x3,y1,1);
		end
		if notWar then
			ShowScreen();
		else
			ReFresh();
		end
	end
	local current=0;
	while true do
		redraw(current);
		getkey();
		if MOUSE.HOLD(x1+1,y1+1,x2-1,y2-1) then
			current=1;
		elseif MOUSE.HOLD(x3+1,y1+1,x4-1,y2-1) then
			current=2;
		elseif MOUSE.CLICK(x1+1,y1+1,x2-1,y2-1) then
			current=0;
			PlayWavE(0);
			redraw(current);
			if notWar then
				lib.Delay(100);
			else
				WarDelay(4);
			end
			return true;
		elseif MOUSE.CLICK(x3+1,y1+1,x4-1,y2-1) then
			current=0;
			PlayWavE(0);
			redraw(current);
			if notWar then
				lib.Delay(100);
			else
				WarDelay(4);
			end
			return false;
		else
			current=0;
		end
	end
end
function WarDrawStrBoxConfirm(str,color,notWar)        --显示字符串并询问Y/N	--改为waitkey
    lib.GetKey();
	while true do
		local t1=lib.GetTime();
		DrawGame();
		DrawYJZBox(-1,-1,str,color);
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
end
--显示字符串并等待击键，字符串带框，显示在屏幕中间
function DrawStrBoxWaitKey(s,color)          --显示字符串并等待击键
	color=color or C_WHITE;
    lib.GetKey();
	DrawGame();
    DrawYJZBox(-1,-1,s,color)
    ShowScreen();
    WaitKey();
	DrawGame();
    ShowScreen();
end
function WarDrawStrBoxWaitKey(s,color,x,y)          --显示字符串并等待击键 适用于战斗，画面保持刷新
	x=x or -1;
	y=y or -1;
    lib.GetKey();
	while true do
		JY.ReFreshTime=lib.GetTime();
		DrawWarMap();
		DrawYJZBox(x,y,s,color);
		local eventtype,keypress,x,y=lib.GetKey(1);
		ReFresh();
		if eventtype==1 or eventtype==3 then
			break;
	    end
	end
end
function WarDrawStrBoxDelay(s,color,x,y,n)          --显示字符串并等待击键 适用于战斗，画面保持刷新
	x=x or -1;
	y=y or -1;
	n=n or 36;
    lib.GetKey();
	for i=1,n do
		JY.ReFreshTime=lib.GetTime();
		DrawWarMap();
		DrawYJZBox(x,y,s,color);
		local eventtype,keypress,x,y=lib.GetKey(1);
		ReFresh();
		if eventtype==1 or eventtype==3 then
			break;
	    end
	end
end
function DrawYJZBox(x,y,str,color,size)         --显示带框的字符串
	size=size or 20;
	local strarray={}
	local num,maxlen;
	maxlen=0
	num,strarray=Split(str,'*')
	for i=1,num do
		local len=#strarray[i];
		if len>maxlen then
			maxlen=len
		end
	end
	if maxlen==0 then
		return;
	end
    local w=size*maxlen/2;
	local h=size*num+6*(num-1);
	if x==-1 then
		x=(CC.ScreenW-w)/2;
	end
	if y==-1 then
		y=(CC.ScreenH-h)/2;
	end
	if x<0 then
		x=CC.ScreenW-size/2*maxlen+x;
	end
	if y<0 then
        y=CC.ScreenH-size*num+y;
	end
	local boxw,boxh;
	boxw=w+64;	--88
	boxh=h+16;	--24
	local boxx=x-(boxw-w)/2;
	local boxy=y-(boxh-h)/2;
	--671x304
	--Left Top
	lib.SetClip(boxx,boxy,boxx+boxw/2,boxy+boxh/2);
	lib.PicLoadCache(4,73*2,boxx,boxy,1);
	--Left Bot
	lib.SetClip(boxx,boxy+boxh/2,boxx+boxw/2,boxy+boxh);
	lib.PicLoadCache(4,73*2,boxx,boxy+boxh-304,1);
	--Right Top
	lib.SetClip(boxx+boxw/2,boxy,boxx+boxw,boxy+boxh/2);
	lib.PicLoadCache(4,73*2,boxx+boxw-672,boxy,1);
	--Right Bot
	lib.SetClip(boxx+boxw/2,boxy+boxh/2,boxx+boxw,boxy+boxh);
	lib.PicLoadCache(4,73*2,boxx+boxw-672,boxy+boxh-304,1);
	lib.SetClip(0,0,0,0);
	for i=1,num do
		DrawStringEnhance(x,y+(size+6)*(i-1),strarray[i],color,size);
	end
end
function WarDrawStrBoxDelay2(s,color,x,y,n)          --显示字符串并等待击键 适用于战斗，画面保持刷新
	x=x or -1;
	y=y or -1;
	n=n or 16;
    lib.GetKey();
	for i=1,n do
		JY.ReFreshTime=lib.GetTime();
		DrawWarMap();
		DrawYJZBox(x,y,s,color);
		lib.GetKey();
		ReFresh();
	end
end
function ShowScreen()
	if JY.Dark then
		Light();
	else
		lib.ShowSurface(0);
	end
end

function RGB(r,g,b)          --设置颜色RGB
   return r*65536+g*256+b;
end

function GetRGB(color)      --分离颜色的RGB分量
    color=color%(65536*256);
    local r=math.floor(color/65536);
    color=color%65536;
    local g=math.floor(color/256);
    local b=color%256;
    return r,g,b
end
--等待键盘输入
function WaitKey(flag)       --等待键盘输入
	ShowScreen();
	MOUSE.CLICK();
	while true do
		lib.Delay(CC.FrameNum);
		getkey();
		if MOUSE.CLICK(0,0,CC.ScreenW,CC.ScreenH) then
			return;
		end
	end
end
function LoadRecord(id)       -- 读取游戏进度
    local t1=lib.GetTime();
    local data=Byte.create(4*8);
	--读取savedata
	--[[
    Byte.loadfile(data,CC.SavedataFile,0,4*8);
	CC.OSCharSet=Byte.get16(data,0);
	CC.MusicVolume=Byte.get16(data,2);
	CC.SoundVolume=Byte.get16(data,4);
	if CONFIG.Windows then
		Config();
		PicCacheIni();
	else
		lib.LoadSoundConfig(CC.MusicVolume,CC.SoundVolume);
	end]]--
    --读取R*.idx文件
    local data=Byte.create(4*12);
    Byte.loadfile(data,CC.R_GRPFilename[0],0,4*12);
	local idx={}
	idx[0]=100;
	for i =1,12 do
	    idx[i]=Byte.get32(data,4*(i-1)*1);
	end
	
    --读取R*.grp文件
		lib.Debug(idx[1]-idx[0])
    JY.Data_Base=Byte.create(idx[1]-idx[0]);              --基本数据
    Byte.loadfile(JY.Data_Base,CC.R_GRPFilename[id],idx[0],idx[1]-idx[0]);
    --设置访问基本数据的方法，这样就可以用访问表的方式访问了．而不用把二进制数据转化为表．节约加载时间和空间
	local meta_t={
	    __index=function(t,k)
	        return GetDataFromStruct(JY.Data_Base,0,CC.Base_S,k);
		end,

		__newindex=function(t,k,v)
	        SetDataFromStruct(JY.Data_Base,0,CC.Base_S,k,v);
	 	end
	}
    setmetatable(JY.Base,meta_t);
	
    JY.ForceNum=math.floor((idx[2]-idx[1])/CC.ForceSize);   --Force
	JY.Data_Force=Byte.create(CC.ForceSize*JY.ForceNum);
	Byte.loadfile(JY.Data_Force,CC.R_GRPFilename[id],idx[1],CC.ForceSize*JY.ForceNum);
	for i=0,JY.ForceNum-1 do
		JY.Force[i]={};
		local meta_t={
			__index=function(t,k)
				return GetDataFromStruct(JY.Data_Force,i*CC.ForceSize,CC.Force_S,k);
			end,

			__newindex=function(t,k,v)
				SetDataFromStruct(JY.Data_Force,i*CC.ForceSize,CC.Force_S,k,v);
			end
		}
        setmetatable(JY.Force[i],meta_t);
	end
    JY.PersonNum=math.floor((idx[3]-idx[2])/CC.PersonSize);   --人物	/newgamesave和实际存档 混合读取
	JY.Data_Person_Base=Byte.create(CC.PersonSize*JY.PersonNum);
	JY.Data_Person=Byte.create(CC.PersonSize*JY.PersonNum);
	Byte.loadfile(JY.Data_Person_Base,	CC.R_GRPFilename[0],idx[2],CC.PersonSize*JY.PersonNum);
	Byte.loadfile(JY.Data_Person,		CC.R_GRPFilename[id],idx[2],CC.PersonSize*JY.PersonNum);
	for i=0,JY.PersonNum-1 do
		JY.Person[i]={};
		if between(i,901,1000) then		--901-1000为新武将区域
			local meta_t={
				__index=function(t,k)
					return GetDataFromStruct(JY.Data_Person,i*CC.PersonSize,CC.Person_S,k);
				end,

				__newindex=function(t,k,v)
					SetDataFromStruct(JY.Data_Person,i*CC.PersonSize,CC.Person_S,k,v);
				end
			}
			setmetatable(JY.Person[i],meta_t);
		else
			local meta_t={
				__index=function(t,k)
					return GetPersonData(i*CC.PersonSize,CC.Person_S,k);	--0以后的人物混合读取，0为主角
				end,

				__newindex=function(t,k,v)
					SetDataFromStruct(JY.Data_Person,i*CC.PersonSize,CC.Person_S,k,v);
				end
			}
			setmetatable(JY.Person[i],meta_t);
		end
	end
	
    JY.BingzhongNum=math.floor((idx[4]-idx[3])/CC.BingzhongSize);   --兵种	/读取newgamesave
	JY.Data_Bingzhong=Byte.create(CC.BingzhongSize*JY.BingzhongNum);
	Byte.loadfile(JY.Data_Bingzhong,CC.R_GRPFilename[0],idx[3],CC.BingzhongSize*JY.BingzhongNum);
	for i=0,JY.BingzhongNum-1 do
		JY.Bingzhong[i]={};
		local meta_t={
			__index=function(t,k)
				return GetDataFromStruct(JY.Data_Bingzhong,i*CC.BingzhongSize,CC.Bingzhong_S,k);
			end,

			__newindex=function(t,k,v)
				SetDataFromStruct(JY.Data_Bingzhong,i*CC.BingzhongSize,CC.Bingzhong_S,k,v);
			end
		}
        setmetatable(JY.Bingzhong[i],meta_t);
	end
    JY.SceneNum=math.floor((idx[5]-idx[4])/CC.SceneSize);   --场景
	JY.Data_Scene=Byte.create(CC.SceneSize*JY.SceneNum);
	Byte.loadfile(JY.Data_Scene,CC.R_GRPFilename[id],idx[4],CC.SceneSize*JY.SceneNum);
	for i=0,JY.SceneNum-1 do
		JY.Scene[i]={};
		local meta_t={
			__index=function(t,k)
				return GetDataFromStruct(JY.Data_Scene,i*CC.SceneSize,CC.Scene_S,k);
			end,

			__newindex=function(t,k,v)
				SetDataFromStruct(JY.Data_Scene,i*CC.SceneSize,CC.Scene_S,k,v);
			end
		}
        setmetatable(JY.Scene[i],meta_t);
	end
    JY.WarmapNum=math.floor((idx[6]-idx[5])/CC.WarmapSize);   --场景
	JY.Data_Warmap=Byte.create(CC.WarmapSize*JY.WarmapNum);
	Byte.loadfile(JY.Data_Warmap,CC.R_GRPFilename[id],idx[5],CC.WarmapSize*JY.WarmapNum);
	for i=0,JY.WarmapNum-1 do
		JY.Warmap[i]={};
		local meta_t={
			__index=function(t,k)
				return GetDataFromStruct(JY.Data_Warmap,i*CC.WarmapSize,CC.Warmap_S,k);
			end,

			__newindex=function(t,k,v)
				SetDataFromStruct(JY.Data_Warmap,i*CC.WarmapSize,CC.Warmap_S,k,v);
			end
		}
        setmetatable(JY.Warmap[i],meta_t);
	end
	
    JY.CityNum=math.floor((idx[7]-idx[6])/CC.CitySize);
	JY.Data_City=Byte.create(CC.CitySize*JY.CityNum);
	Byte.loadfile(JY.Data_City,CC.R_GRPFilename[id],idx[6],CC.CitySize*JY.CityNum);
	for i=0,JY.CityNum-1 do
		JY.City[i]={};
		local meta_t={
			__index=function(t,k)
				return GetDataFromStruct(JY.Data_City,i*CC.CitySize,CC.City_S,k);
			end,

			__newindex=function(t,k,v)
				SetDataFromStruct(JY.Data_City,i*CC.CitySize,CC.City_S,k,v);
			end
		}
        setmetatable(JY.City[i],meta_t);
	end
  
    JY.ConnectionNum=math.floor((idx[8]-idx[7])/CC.ConnectionSize);
	JY.Data_Connection=Byte.create(CC.ConnectionSize*JY.ConnectionNum);
	Byte.loadfile(JY.Data_Connection,CC.R_GRPFilename[0],idx[7],CC.ConnectionSize*JY.ConnectionNum);
	for i=0,JY.ConnectionNum-1 do
		JY.Connection[i]={};
		local meta_t={
			__index=function(t,k)
				return GetDataFromStruct(JY.Data_Connection,i*CC.ConnectionSize,CC.Connection_S,k);
			end,

			__newindex=function(t,k,v)
				SetDataFromStruct(JY.Data_Connection,i*CC.ConnectionSize,CC.Connection_S,k,v);
			end
		}
        setmetatable(JY.Connection[i],meta_t);
	end
	
    JY.ItemNum=math.floor((idx[9]-idx[8])/CC.ItemSize);   --道具	/读取newgamesave
	JY.Data_Item=Byte.create(CC.ItemSize*JY.ItemNum);
	Byte.loadfile(JY.Data_Item,CC.R_GRPFilename[0],idx[8],CC.ItemSize*JY.ItemNum);
	for i=0,JY.ItemNum-1 do
		JY.Item[i]={};
		local meta_t={
			__index=function(t,k)
				return GetDataFromStruct(JY.Data_Item,i*CC.ItemSize,CC.Item_S,k);
			end,

			__newindex=function(t,k,v)
				SetDataFromStruct(JY.Data_Item,i*CC.ItemSize,CC.Item_S,k,v);
			end
		}
        setmetatable(JY.Item[i],meta_t);
	end
	
    JY.TitleNum=math.floor((idx[10]-idx[9])/CC.TitleSize);   --官爵	/读取newgamesave
	JY.Data_Magic=Byte.create(CC.TitleSize*JY.TitleNum);
	Byte.loadfile(JY.Data_Magic,CC.R_GRPFilename[0],idx[9],CC.TitleSize*JY.TitleNum);
	for i=0,JY.TitleNum-1 do
		JY.Title[i]={};
		local meta_t={
			__index=function(t,k)
				return GetDataFromStruct(JY.Data_Magic,i*CC.TitleSize,CC.Title_S,k);
			end,

			__newindex=function(t,k,v)
				SetDataFromStruct(JY.Data_Magic,i*CC.TitleSize,CC.Title_S,k,v);
			end
		}
        setmetatable(JY.Title[i],meta_t);
	end
    JY.SkillNum=math.floor((idx[11]-idx[10])/CC.SkillSize);   --特技	/读取newgamesave
	JY.Data_Skill=Byte.create(CC.SkillSize*JY.SkillNum);
	Byte.loadfile(JY.Data_Skill,CC.R_GRPFilename[0],idx[10],CC.SkillSize*JY.SkillNum);
	for i=0,JY.SkillNum-1 do
		JY.Skill[i]={};
		local meta_t={
			__index=function(t,k)
				return GetDataFromStruct(JY.Data_Skill,i*CC.SkillSize,CC.Skill_S,k);
			end,

			__newindex=function(t,k,v)
				SetDataFromStruct(JY.Data_Skill,i*CC.SkillSize,CC.Skill_S,k,v);
			end
		}
        setmetatable(JY.Skill[i],meta_t);
	end
	JY.Data_Str=Byte.create(idx[12]-idx[11]);
	Byte.loadfile(JY.Data_Str,CC.R_GRPFilename[0],idx[11],idx[12]-idx[11]);
	JY.StrNum=Byte.get16(JY.Data_Str,0);
	JY.Str={};
	local meta_t={
	    __index=function(t,k)
			return Byte.getstr(JY.Data_Str,Byte.get32(JY.Data_Str,2+4*(k-1)),Byte.get32(JY.Data_Str,2+4*k)-Byte.get32(JY.Data_Str,2+4*(k-1)));
		end,

		__newindex=function(t,k,v)
	        return;
	 	end
	}
	setmetatable(JY.Str,meta_t);
	collectgarbage();
	lib.Debug(string.format("Loadrecord%d time=%d",id,lib.GetTime()-t1));
	
	JY.PID=JY.Base["主角"];
	JY.FID=JY.Base["当前势力"];
	JY.SubScene=JY.Base["当前场景"];
	JY.EventID=JY.Base["当前事件"];
	JY.CurrentBGM=JY.Base["当前音乐"];
	
	for i = 1, JY.CityNum - 1 do
    JY.CityToCity[i] = {};
  end
	for i = 1, JY.ConnectionNum - 1 do
    local from, to = JY.Connection[i]["都市1"], JY.Connection[i]["都市2"];
    JY.CityToCity[from][to] = i;
  end

	JY.NameList={};	--清空
	JY.NameList["主角"]=0;
	for i=1,JY.PersonNum-1 do
		local str=JY.Person[i]["名称"];
		if JY.NameList[str]==nil then
			JY.NameList[str]=i;
		else
			local j=2;
			while true do
				if JY.NameList[str..j]==nil then
					JY.NameList[str..j]=i;
					break;
				else
					j=j+1;
				end
			end
		end
	end
	
	if id>0 then
		if ((JY.Status==GAME_SMAP_MANUAL) and JY.Base["战场存档"]==0) then
			Dark();
			DrawSMap();
			Light();
		end
		if ((JY.Status==GAME_WMAP or JY.Status==GAME_START) and JY.Base["战场存档"]==1) then
			Dark();
		end
		JY.Status=JY.Base["当前状态"];
		if JY.Base["战场存档"]==1 then
			WarLoad(id);
		end
		if JY.CurrentBGM>=0 then
			PlayBGM(JY.CurrentBGM);
		end
		Dark();
	end
end
function fileexist(filename)         --检测文件是否存在
    local inp=io.open(filename,"rb");
	if inp==nil then
		return false;
	end
	inp:close();
    return true;
end
function copyfile(source,destination)
	local sourcefile = io.open(source,"rb")
	local destinationfile = io.open(destination,"wb")
	destinationfile:write(sourcefile:read("*a"))
	sourcefile:close()
	destinationfile:close()
end
-- 写游戏进度
-- id=0 新进度，=1/2/3 进度
function SaveRecord(id)         -- 写游戏进度
    local t1=lib.GetTime()
	--
	if JY.Status==GAME_WMAP then
		JY.Base["战场存档"]=1;
	else
		JY.Base["战场存档"]=0;
	end
	JY.Base["时间"]=string.sub(os.date(),0,14);
	JY.Base["当前状态"]=JY.Status;
	JY.Base["主角"]=JY.PID;
	JY.Base["当前势力"]=JY.FID;
	JY.Base["当前场景"]=JY.SubScene;
	JY.Base["当前事件"]=JY.EventID;
	JY.Base["当前音乐"]=JY.CurrentBGM;
    --local data=Byte.create(4*8);
	--读取savedata
	--[[
	Byte.set16(data,2,CC.MusicVolume);
	Byte.set16(data,4,CC.SoundVolume);
	Byte.savefile(data,CC.SavedataFile,0,4*8);]]--
    --读取R*.idx文件
    local data=Byte.create(4*11);
    Byte.loadfile(data,CC.R_GRPFilename[0],0,4*11);
	local idx={}
	idx[0]=100;
	for i =1,11 do
	    idx[i]=Byte.get32(data,4*(i-1)*1);
	end

    --写R*.grp文件
	if true then--not fileexist(CC.R_GRPFilename[id]) then
		copyfile(CC.R_GRPFilename[0],CC.R_GRPFilename[id])
	end
    Byte.savefile(JY.Data_Base,CC.R_GRPFilename[id],idx[0],idx[1]-idx[0]);
	Byte.savefile(JY.Data_Force,CC.R_GRPFilename[id],idx[1],CC.ForceSize*JY.ForceNum);
	Byte.savefile(JY.Data_Person,CC.R_GRPFilename[id],idx[2],CC.PersonSize*JY.PersonNum);
	Byte.savefile(JY.Data_Scene,CC.R_GRPFilename[id],idx[4],CC.SceneSize*JY.SceneNum);
	Byte.savefile(JY.Data_City,CC.R_GRPFilename[id],idx[6],CC.CitySize*JY.CityNum);
    lib.Debug(string.format("SaveRecord time=%d",lib.GetTime()-t1));
end
--从数据的结构中翻译数据
--data 二进制数组
--offset data中的偏移
--t_struct 数据的结构，在jyconst中有很多定义
--key  访问的key
function GetDataFromStruct(data,offset,t_struct,key)  --从数据的结构中翻译数据，用来取数据
    local t=t_struct[key];
	local r;
	if t[2]==0 then
		if t[3]==1 then
			r=Byte.get8(data,t[1]+offset);
		elseif t[3]==2 then
			r=Byte.get16(data,t[1]+offset);
		elseif t[3]==4 then
			r=Byte.get32(data,t[1]+offset);
		end
	elseif t[2]==1 then
		if t[3]==1 then
			r=Byte.get8(data,t[1]+offset);
			if r<0 then
				r=r+256;
			end
		elseif t[3]==2 then
			r=Byte.getu16(data,t[1]+offset);
		elseif t[3]==4 then
			r=Byte.getu32(data,t[1]+offset);
		end
	elseif t[2]==2 then
		if CC.SrcCharSet==1 then
			r=lib.CharSet(Byte.getstr(data,t[1]+offset,t[3]),0);
		else
			r=Byte.getstr(data,t[1]+offset,t[3]);
		end
	end
	
	return r;
end
function SetDataFromStruct(data,offset,t_struct,key,v)  --从数据的结构中翻译数据，保存数据
    local t=t_struct[key];
	
	if t[2]==0 then
		if t[3]==1 then
			Byte.set8(data,t[1]+offset,v);
		elseif t[3]==2 then
			Byte.set16(data,t[1]+offset,v);
		elseif t[3]==4 then
			Byte.set32(data,t[1]+offset,v);
		end
	elseif t[2]==1 then
		if t[3]==1 then
			if v>127 then
				v=v-256;
			end
			Byte.set8(data,t[1]+offset,v);
		elseif t[3]==2 then
			Byte.setu16(data,t[1]+offset,v);
		elseif t[3]==4 then
			Byte.setu32(data,t[1]+offset,v);
		end
	elseif t[2]==2 then
		local s;
		if CC.SrcCharSet==1 then
			s=lib.CharSet(v,1);
		else
			s=v;
		end
		Byte.setstr(data,t[1]+offset,t[3],s);
	end
end
function GetPersonData(offset,t_struct,key)
    if t_struct[key][4] then
		return GetDataFromStruct(JY.Data_Person,offset,t_struct,key);
	else
		return GetDataFromStruct(JY.Data_Person_Base,offset,t_struct,key);
	end
end
function between(v,Min,Max)
	if Min>Max then
		Min,Max=Max,Min;
	end
	if v>=Min and v<=Max then
		return true;
	end
	return false;
end
function ResizeScreen(w,h)
end
function Light()            --场景变亮
	if JY.Dark then
		JY.Dark=false;
		lib.ShowSlow(CC.FrameNum/4,0);
		lib.GetKey();
	end
end
function Dark()             --场景变黑
	if not JY.Dark then
		JY.Dark=true;
		lib.ShowSlow(CC.FrameNum/4,1);
		lib.GetKey();
	end
end
--播放MP3
function PlayBGM(id)
	id=id or 0
    JY.CurrentBGM=id;
    if JY.EnableMusic==0 then
        return ;
    end
    if id>=0 and id<=99 then
        lib.PlayMIDI(string.format(CC.BGMFile,id));
    end
end
function StopBGM()
	JY.CurrentBGM=-1;
	lib.PlayMIDI("");
end
--播放音效e**
function PlayWavE(id)              --播放音效e**
    if JY.EnableSound==0 then
        return ;
    end
    if id>=0 then
        lib.PlayWAV(string.format(CC.EFile,id));
    end
end
--产生对话显示需要的字符串，即每隔n个中文字符加一个星号
function GenTalkString(str,n)              --产生对话显示需要的字符串
    local tmpstr="";
	local num=0;
    for s in string.gmatch(str .. "*","(.-)%*") do           --去掉对话中的所有*. 字符串尾部加一个星号，避免无法匹配
        tmpstr=tmpstr .. s;
    end

    local newstr="";
    while #tmpstr>0 do
		num=num+1;
		local w=0;
		while w<#tmpstr do
		    local v=string.byte(tmpstr,w+1);          --当前字符的值
			if v>=128 then
			    w=w+2;
			else
			    w=w+1;
			end
			if w >= 2*n-1 then     --为了避免跨段中文字符
			    break;
			end
		end

        if w<#tmpstr then
		    if w==2*n-1 and string.byte(tmpstr,w+1)<128 then
				newstr=newstr .. string.sub(tmpstr,1,w+1) .. "*";
				tmpstr=string.sub(tmpstr,w+2,-1);
			else
				newstr=newstr .. string.sub(tmpstr,1,w)  .. "*";
				tmpstr=string.sub(tmpstr,w+1,-1);
			end
		else
		    newstr=newstr .. tmpstr;
			break;
		end
	end
    return newstr,num;
end
function ShowMenu(menuItem,numItem,numShow,x1,y1,x2,y2,isBox,isEsc,size,color,selectColor)     --通用菜单函数
    local w=0;
    local h=0;   --边框的宽高
    local i=0;
    local num=0;     --实际的显示菜单项
    local newNumItem=0;  --能够显示的总菜单项数
	size=size or CC.Fontbig;
	size=16;
	color=color or C_ORANGE;
	selectColor=selectColor or C_WHITE;
    lib.GetKey();
	local sid=lib.SaveSur(0,0,CC.ScreenW,CC.ScreenH);
    local newMenu={};   -- 定义新的数组，以保存所有能显示的菜单项

    --计算能够显示的总菜单项数
    for i=1,numItem do
        if menuItem[i][3]>0 then
            newNumItem=newNumItem+1;
            newMenu[newNumItem]={menuItem[i][1],menuItem[i][2],menuItem[i][3],i,1};   --新数组多了[4],保存和原数组的对应
																					  --新数组多了[5], 代表对齐 123 左中右
			if string.sub(menuItem[i][1],1,1)=="@" then
				newMenu[newNumItem][1]=string.sub(menuItem[i][1],2);
				newMenu[newNumItem][1]=2;
			end
        end
    end
    --计算实际显示的菜单项数
    if numShow==0 or numShow > newNumItem then
        num=newNumItem;
    else
        num=numShow;
    end

    --计算边框实际宽高
    local maxlength=0;
    if x2==0 and y2==0 then
        for i=1,newNumItem do
            if string.len(newMenu[i][1])>maxlength then
                maxlength=string.len(newMenu[i][1]);
            end
        end
        w=size*maxlength/2+2*CC.MenuBorderPixel;        --按照半个汉字计算宽度，一边留4个象素
        h=(size+CC.RowPixel)*num+CC.MenuBorderPixel;            --字之间留4个象素，上面再留4个象素
    else
        w=x2-x1;
        h=y2-y1;
		num=math.min(num,(math.floor(h/(size+CC.RowPixel))));
    end
	--[[
	if x1==0 and y1==0 then
		x1=(CC.ScreenW-w)/2;
		y1=(CC.ScreenH-h)/2;
	end
	if x1==-1 then
		x1=(CC.ScreenW-w)/2;
	end
	if y1==-1 then
		y1=(CC.ScreenH-h)/2;
	end]]--
	
    local start=1;             --显示的第一项

	local current =0;          --当前选择项
	for i=1,newNumItem do
	    if newMenu[i][3]==2 then
		    current=i;
			break;
		end
	end
				if current > num then
					start=1+current-num;
				end
	--[[
	if numShow~=0 then
	    current=1;
	end]]--
	if JY.Menu_keep then
		start=JY.Menu_start;
		current=JY.Menu_current;
	end
    local keyPress =-1;
    local returnValue =0;
	
	local x_off,y_off,row_off,h_off=0,0,0,0;
	
	if isBox==1 then
		x_off=3;
		y_off=7;
		row_off=4;
		h_off=8;
		w=80;
		h=16+24*num;
	elseif isBox==2 then
		x_off=4;
		y_off=6;
		row_off=4;
		h_off=8;
		w=144;
		h=16+24*num;
	elseif isBox==3 then	--baseon 2，调整宽度
		x_off=4;
		y_off=6;
		row_off=4;
		h_off=8;
		w=96;
		h=16+24*num;
	elseif isBox==4 then
		x_off=11;
		y_off=9;
		row_off=0;
		h_off=12;
		w=112;
		h=16+8+20*num;
	elseif isBox==9 then
		DrawBox(x1,y1,x1+w,y1+h,C_WHITE);
	end
	if x1==0 and y1==0 then
		x1=(CC.ScreenW-w)/2;
		y1=(CC.ScreenH-h)/2;
	end
	if x1==-1 then
		x1=(CC.ScreenW-w)/2;
	end
	if y1==-1 then
		y1=(CC.ScreenH-h)/2;
	end
	local function redraw(flag)
		if num~=0 then --暂且这样改
	        --Cls(x1,y1,x1+w,y1+h);
			if isBox==1 then
				lib.SetClip(x1,y1,x1+w,y1+8+24*num);
				lib.PicLoadCache(4,0*2,x1,y1,1);
				lib.SetClip(0,0,0,0);
				lib.SetClip(x1,y1+8+24*math.max(0,(num-8)),x1+w,y1+8+24*num+8);
				lib.PicLoadCache(4,0*2,x1,y1+16+24*num-256,1);
				lib.SetClip(0,0,0,0);
			elseif isBox==2 then
				lib.SetClip(x1,y1,x1+w,y1+7+24*num);
				lib.PicLoadCache(4,60*2,x1,y1,1);
				lib.SetClip(0,0,0,0);
				lib.SetClip(x1,y1+8+24*math.max(0,(num-3)),x1+w,y1+8+24*num+8);
				lib.PicLoadCache(4,60*2,x1,y1+14+24*num-110,1);
				lib.SetClip(0,0,0,0);
			elseif isBox==3 then
				lib.SetClip(x1,y1,x1+w,y1+7+24*num);
				lib.PicLoadCache(4,63*2,x1,y1,1);
				lib.SetClip(0,0,0,0);
				lib.SetClip(x1,y1+8+24*math.max(0,(num-3)),x1+w,y1+8+24*num+8);
				lib.PicLoadCache(4,63*2,x1,y1+14+24*num-110,1);
				lib.SetClip(0,0,0,0);
			elseif isBox==4 then
				lib.SetClip(x1,y1,x1+w,y1+h);
				lib.PicLoadCache(4,59*2,x1,y1,1);
				lib.SetClip(0,0,0,0);
				lib.SetClip(x1,y1+h-8,x1+w,y1+h);
				lib.PicLoadCache(4,59*2,x1,y1-(384-h),1);
				lib.SetClip(0,0,0,0);
			elseif isBox==9 then
				DrawBox(x1,y1,x1+w,y1+h,C_WHITE);
			end
		end

	    for i=start,start+num-1 do
  	        local drawColor=color;           --设置不同的绘制颜色
			local menustr=newMenu[i][1];
			local dx=0;
			if newMenu[i][5]==2 then
				dx=size*(maxlength-string.len(menustr))/2/2;
			end
	        if i==current then
	            drawColor=selectColor;
	        end
			if isBox==1 then
				if i==current then
					lib.PicLoadCache(4,2*2,x1+6,y1+9+24*(i-1),1);
					DrawString(x1+dx+x_off+CC.MenuBorderPixel,1+y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				else
					lib.PicLoadCache(4,1*2,x1+6,y1+9+24*(i-1),1);
					DrawString(x1+dx+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				end
			elseif isBox==2 then
				if i==current then
					lib.PicLoadCache(4,62*2,x1+6,y1+8+24*(i-1),1);
					DrawString(x1+dx+x_off+CC.MenuBorderPixel,1+y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				else
					lib.PicLoadCache(4,61*2,x1+6,y1+8+24*(i-1),1);
					DrawString(x1+dx+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				end
			elseif isBox==3 then
				if i==current then
					lib.PicLoadCache(4,65*2,x1+6,y1+8+24*(i-1),1);
					DrawString(x1+dx+x_off+CC.MenuBorderPixel,1+y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				else
					lib.PicLoadCache(4,64*2,x1+6,y1+8+24*(i-1),1);
					DrawString(x1+dx+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				end
			elseif isBox==4 then
				if i==current then
					lib.DrawRect(x1+12,y1+12+20*(i-1),x1+99,y1+12+20*(i),C_WHITE);
					DrawString(x1+dx+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				else
					DrawString(x1+dx+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				end
			else
				DrawString(x1+dx+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
							menustr,drawColor,size);
			end
			

	    end
		if flag then
			lib.Background(x1,y1,x1+w,y1+h,128);
		end
	end
	local wait=true;
    while wait do
		JY.ReFreshTime=lib.GetTime();
		lib.LoadSur(sid);
		redraw();
		ReFresh();
		local eventtype,keyPress,mx,my=getkey();
		mx,my=MOUSE.x,MOUSE.y;
		if eventtype==3 and keyPress==3 then
			if isEsc==1 then
				wait=false;
			end
		end
		if mx>x1+6 and mx<x1+w-6 and my>y1+h_off and my<y1+h-h_off then
			current=math.floor((my-y1-h_off)/(size+CC.RowPixel+row_off));
			if MOUSE.HOLD(x1+7,y1+h_off+(size+CC.RowPixel+row_off)*current,x1+w-7,y1+h_off+(size+CC.RowPixel+row_off)*(current+1)) then
				current=limitX(start+current,1,newNumItem);
			elseif MOUSE.CLICK(x1+7,y1+h_off+(size+CC.RowPixel+row_off)*current,x1+w-7,y1+h_off+(size+CC.RowPixel+row_off)*(current+1)) then
				local sel=limitX(start+current,1,newNumItem);
				current=0;
				PlayWavE(0);
				JY.ReFreshTime=lib.GetTime();
				lib.LoadSur(sid);
				redraw();
				ReFresh(CC.OpearteSpeed); --这里应该可以决定菜单的反应速度
				if newMenu[sel][2]==nil then
					returnValue=newMenu[sel][4];
					wait=false;
				else
					redraw();
					JY.MenuPic.num=JY.MenuPic.num+1;
					JY.MenuPic.pic[JY.MenuPic.num]=lib.SaveSur(x1,y1,x1+w,y1+h);
					JY.MenuPic.x[JY.MenuPic.num]=x1;
					JY.MenuPic.y[JY.MenuPic.num]=y1;
					local r=newMenu[sel][2](newMenu[sel][4]);               --调用菜单函数
					lib.FreeSur(JY.MenuPic.pic[JY.MenuPic.num]);
					JY.MenuPic.num=JY.MenuPic.num-1;
					if r==1 then
						returnValue=newMenu[sel][4];
						wait=false;
					end
				end
			else
				current=0;
			end
		else
			current=0;
		end
    end

    --Cls(x1,y1,x1+w+1,y1+h+1,0,1);
	if returnValue==0 then
		PlayWavE(1);
	end
	lib.LoadSur(sid);
	lib.FreeSur(sid);
    return returnValue;
end
function ShowMenu(menuItem,numItem,numShow,x1,y1,x2,y2,isBox,isEsc,size,color,selectColor)     --通用菜单函数
    local w=0;
    local h=0;   --边框的宽高
    local i=0;
    local num=0;     --实际的显示菜单项
    local newNumItem=0;  --能够显示的总菜单项数
	size=size or CC.Fontbig;
	size=16;
	color=color or C_ORANGE;
	selectColor=selectColor or C_WHITE;
    lib.GetKey();

	local sid=lib.SaveSur(0,0,CC.ScreenW,CC.ScreenH);
    local newMenu={};   -- 定义新的数组，以保存所有能显示的菜单项

    --计算能够显示的总菜单项数
    for i=1,numItem do
        if menuItem[i][3]>0 then
            newNumItem=newNumItem+1;
            newMenu[newNumItem]={menuItem[i][1],menuItem[i][2],menuItem[i][3],i,1};   --新数组多了[4],保存和原数组的对应
																					  --新数组多了[5], 代表对齐 123 左中右
			if string.sub(menuItem[i][1],1,1)=="@" then
				newMenu[newNumItem][1]=string.sub(menuItem[i][1],2);
				newMenu[newNumItem][5]=2;
			end
        end
    end

    --计算实际显示的菜单项数
    if numShow==0 or numShow > newNumItem then
        num=newNumItem;
    else
        num=numShow;
    end

    --计算边框实际宽高
    local maxlength=0;
    if x2==0 and y2==0 then
        for i=1,newNumItem do
            if string.len(newMenu[i][1])>maxlength then
                maxlength=string.len(newMenu[i][1]);
            end
        end
        w=size*maxlength/2+2*CC.MenuBorderPixel;        --按照半个汉字计算宽度，一边留4个象素
        h=(size+CC.RowPixel)*num+CC.MenuBorderPixel;            --字之间留4个象素，上面再留4个象素
    else
        w=x2-x1;
        h=y2-y1;
		num=math.min(num,(math.floor(h/(size+CC.RowPixel))));
    end
	--[[
	if x1==0 and y1==0 then
		x1=(CC.ScreenW-w)/2;
		y1=(CC.ScreenH-h)/2;
	end
	if x1==-1 then
		x1=(CC.ScreenW-w)/2;
	end
	if y1==-1 then
		y1=(CC.ScreenH-h)/2;
	end]]--
	
    local start=1;             --显示的第一项

	local current =0;          --当前选择项
	for i=1,newNumItem do
	    if newMenu[i][3]==2 then
		    current=i;
			break;
		end
	end
				if current > num then
					start=1+current-num;
				end
	--[[
	if numShow~=0 then
	    current=1;
	end]]--
	if JY.Menu_keep then
		start=JY.Menu_start;
		current=JY.Menu_current;
	end
    local keyPress =-1;
    local returnValue =0;
	
	local x_off,y_off,row_off,h_off=0,0,0,0;
	
	if isBox==1 then
		x_off=3;
		y_off=7;
		row_off=4;
		h_off=8;
		w=80;
		h=16+24*num;
	elseif isBox==2 then
		x_off=4;
		y_off=6;
		row_off=4;
		h_off=8;
		w=144;
		h=16+24*num;
	elseif isBox==20 then	--2的加宽版本
		x_off=4;
		y_off=6;
		row_off=4;
		h_off=8;
		w=420;
		h=16+24*num;
	elseif isBox==3 then	--baseon 2，调整宽度
		x_off=4;
		y_off=6;
		row_off=4;
		h_off=8;
		w=96;
		h=16+24*num;
	elseif isBox==4 then
		x_off=11;
		y_off=9;
		row_off=0;
		h_off=12;
		w=112;
		h=16+8+20*num;
	elseif isBox==5 then	--策略<=8用
		x_off=4;
		y_off=9;
		row_off=0;
		h_off=12;
		w=104;
		h=16+8+20*num;
	elseif isBox==6 then	--策略>8用
		x_off=4;
		y_off=9;
		row_off=0;
		h_off=12;
		w=120-20;
		h=16+8+20*num;
	elseif isBox==9 then
		DrawBox(x1,y1,x1+w,y1+h,C_WHITE);
	end
	
	if x1==-1 or x1==0 then
		if JY.Status==GAME_WMAP or JY.Status==GAME_WARWIN or JY.Status==GAME_WARLOSE then
			x1=16+(768-w)/2;
		elseif JY.Status==GAME_SMAP_AUTO or JY.Status==GAME_SMAP_MANUAL then
			x1=16+(640-w)/2;
		else
			x1=(CC.ScreenW-w)/2;
		end
	end
	if y1==-1 or y1==0 then
		if JY.Status==GAME_WMAP or JY.Status==GAME_WARWIN or JY.Status==GAME_WARLOSE then
			y1=32+(528-h)/2;
		elseif JY.Status==GAME_SMAP_AUTO or JY.Status==GAME_SMAP_MANUAL then
			y1=16+(400-h)/2;
		else
			y1=(CC.ScreenH-h)/2;
		end
	end
	local function redraw(flag)
		if num~=0 then --暂且这样改
	        --Cls(x1,y1,x1+w,y1+h);
			if isBox==1 then
				lib.SetClip(x1,y1,x1+w,y1+8+24*num);
				lib.PicLoadCache(4,0*2,x1,y1,1);
				lib.SetClip(0,0,0,0);
				lib.SetClip(x1,y1+8+24*math.max(0,(num-8)),x1+w,y1+8+24*num+8);
				lib.PicLoadCache(4,0*2,x1,y1+16+24*num-256,1);
				lib.SetClip(0,0,0,0);
			elseif isBox==2 then
				lib.SetClip(x1,y1,x1+w,y1+7+24*num);
				lib.PicLoadCache(4,60*2,x1,y1,1);
				lib.SetClip(0,0,0,0);
				lib.SetClip(x1,y1+8+24*math.max(0,(num-3)),x1+w,y1+8+24*num+8);
				lib.PicLoadCache(4,60*2,x1,y1+14+24*num-110,1);
				lib.SetClip(0,0,0,0);
			elseif isBox==20 then
				lib.SetClip(x1,y1,x1+w,y1+7+24*num);
				lib.PicLoadCache(4,70*2,x1,y1,1);
				lib.SetClip(0,0,0,0);
				lib.SetClip(x1,y1+8+24*math.max(0,(num-3)),x1+w,y1+8+24*num+8);
				lib.PicLoadCache(4,70*2,x1,y1+14+24*num-110,1);
				lib.SetClip(0,0,0,0);
			elseif isBox==3 then
				lib.SetClip(x1,y1,x1+w,y1+7+24*num);
				lib.PicLoadCache(4,63*2,x1,y1,1);
				lib.SetClip(0,0,0,0);
				lib.SetClip(x1,y1+8+24*math.max(0,(num-3)),x1+w,y1+8+24*num+8);
				lib.PicLoadCache(4,63*2,x1,y1+14+24*num-182,1);
				lib.SetClip(0,0,0,0);
			elseif isBox==4 then
				lib.SetClip(x1,y1,x1+w,y1+h);
				lib.PicLoadCache(4,59*2,x1,y1,1);
				lib.SetClip(0,0,0,0);
				lib.SetClip(x1,y1+h-8,x1+w,y1+h);
				lib.PicLoadCache(4,59*2,x1,y1-(384-h),1);
				lib.SetClip(0,0,0,0);
			elseif isBox==5 then
				lib.SetClip(x1,y1,x1+w,y1+h);
				lib.PicLoadCache(4,66*2,x1,y1,1);
				lib.SetClip(0,0,0,0);
				lib.SetClip(x1,y1+h-8,x1+w,y1+h);
				lib.PicLoadCache(4,66*2,x1,y1-(384-h),1);
				lib.SetClip(0,0,0,0);
			elseif isBox==6 then
				lib.SetClip(x1,y1,x1+w+20,y1+h);
				lib.PicLoadCache(4,67*2,x1,y1,1);
				lib.SetClip(0,0,0,0);
				lib.SetClip(x1,y1+h-32,x1+w+20,y1+h);
				lib.PicLoadCache(4,67*2,x1,y1-(384-h),1);
				lib.SetClip(0,0,0,0);
				
				local nn=newNumItem-num;
				local nn_row=120;
				lib.PicLoadCache(4,68*2,x1+98,y1+24+nn_row*(start-1)/nn,1);
			elseif isBox==9 then
				DrawBox(x1,y1,x1+w,y1+h,C_WHITE);
			end
		end

	    for i=start,start+num-1 do
  	        local drawColor=color;           --设置不同的绘制颜色
			local menustr=newMenu[i][1];
			local dx=0;
			if newMenu[i][5]==2 then
				dx=size*(maxlength-string.len(menustr))/2/2;
			end
	        if i==current then
	            drawColor=selectColor;
	        end
			if isBox==1 then
				if i==current then
					lib.PicLoadCache(4,2*2,x1+6,y1+9+24*(i-1),1);
					DrawString(x1+dx+x_off+CC.MenuBorderPixel,1+y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				else
					lib.PicLoadCache(4,1*2,x1+6,y1+9+24*(i-1),1);
					DrawString(x1+dx+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				end
			elseif isBox==2 then
				if i==current then
					lib.PicLoadCache(4,62*2,x1+6,y1+8+24*(i-1),1);
					DrawString(x1+dx+x_off+CC.MenuBorderPixel,1+y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				else
					lib.PicLoadCache(4,61*2,x1+6,y1+8+24*(i-1),1);
					DrawString(x1+dx+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				end
			elseif isBox==20 then
				if i==current then
					lib.PicLoadCache(4,72*2,x1+6,y1+8+24*(i-1),1);
					DrawString(x1+dx+x_off+CC.MenuBorderPixel,1+y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				else
					lib.PicLoadCache(4,71*2,x1+6,y1+8+24*(i-1),1);
					DrawString(x1+dx+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				end
			elseif isBox==3 then
				if i==current then
					lib.PicLoadCache(4,65*2,x1+6,y1+8+24*(i-1),1);
					DrawString(x1+dx+x_off+CC.MenuBorderPixel,1+y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				else
					lib.PicLoadCache(4,64*2,x1+6,y1+8+24*(i-1),1);
					DrawString(x1+dx+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				end
			elseif isBox==4 then
				if i==current then
					lib.DrawRect(x1+12,y1+12+20*(i-1),x1+99,y1+12+20*(i),C_WHITE);
					DrawString(x1+dx+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				else
					DrawString(x1+dx+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				end
			elseif isBox==5 then
				if i==current then
					lib.DrawRect(x1+12,y1+12+20*(i-1),x1+91,y1+12+20*(i),C_WHITE);
					DrawString(x1+dx+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				else
					DrawString(x1+dx+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				end
			elseif isBox==6 then
				if i==current then
					lib.DrawRect(x1+12,y1+12+20*(i-start),x1+91,y1+12+20*(i-start+1),C_WHITE);
					DrawString(x1+dx+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				else
					DrawString(x1+dx+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				end
			else
				DrawString(x1+dx+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
							menustr,drawColor,size);
			end
			

	    end
		if flag then
			lib.Background(x1,y1,x1+w,y1+h,128);
		end
	end
	local wait=true;
    while wait do
		JY.ReFreshTime=lib.GetTime();
		lib.LoadSur(sid);
		redraw();
		ReFresh();
		local eventtype,keyPress,mx,my=getkey();
		mx,my=MOUSE.x,MOUSE.y;
		if eventtype==3 and keyPress==3 then
			if isEsc==1 then
				wait=false;
			end
		end
		if mx>x1+6 and mx<x1+w-6 and my>y1+h_off and my<y1+h-h_off then
			current=math.floor((my-y1-h_off)/(size+CC.RowPixel+row_off));
			if MOUSE.HOLD(x1+7,y1+h_off+(size+CC.RowPixel+row_off)*current,x1+w-7,y1+h_off+(size+CC.RowPixel+row_off)*(current+1)) then
				current=limitX(start+current,1,newNumItem);
			elseif MOUSE.CLICK(x1+7,y1+h_off+(size+CC.RowPixel+row_off)*current,x1+w-7,y1+h_off+(size+CC.RowPixel+row_off)*(current+1)) then
				local sel=limitX(start+current,1,newNumItem);
				current=0;
				PlayWavE(0);
				JY.ReFreshTime=lib.GetTime();
				lib.LoadSur(sid);
				redraw();
				ReFresh(CC.OpearteSpeed/2);
				if newMenu[sel][2]==nil then
					returnValue=newMenu[sel][4];
					wait=false;
				else
					redraw();
					JY.MenuPic.num=JY.MenuPic.num+1;
					JY.MenuPic.pic[JY.MenuPic.num]=lib.SaveSur(x1,y1,x1+w,y1+h);
					JY.MenuPic.x[JY.MenuPic.num]=x1;
					JY.MenuPic.y[JY.MenuPic.num]=y1;
					local r=newMenu[sel][2](newMenu[sel][4]);               --调用菜单函数
					lib.FreeSur(JY.MenuPic.pic[JY.MenuPic.num]);
					JY.MenuPic.num=JY.MenuPic.num-1;
					if r==1 then
						returnValue=newMenu[sel][4];
						wait=false;
					end
				end
			elseif between(isBox,4,6) and MOUSE.IN(x1+7,y1+h_off+(size+CC.RowPixel+row_off)*current,x1+w-7,y1+h_off+(size+CC.RowPixel+row_off)*(current+1)) then
				current=limitX(start+current,1,newNumItem);
			--elseif isBox==6 and MOUSE.IN(x1+7,y1+h_off+(size+CC.RowPixel+row_off)*current,x1+w-7-16,y1+h_off+(size+CC.RowPixel+row_off)*(current+1)) then
			--	current=limitX(start+current,1,newNumItem);
			else
				current=0;
			end
		elseif isBox==6 then
				local nn=newNumItem-num
				local nn_row=120;
				local nn_x=x1+99;
				local nn_y=y1+24+nn_row*start/nn;
				if MOUSE.HOLD(nn_x,y1+24,nn_x+12,y1+24+136) then
					nn_y=MOUSE.y-8;
					start=1+math.floor((nn_y-y1-24)*nn/nn_row);
					start=limitX(start,1,nn+1)
				elseif MOUSE.CLICK(nn_x,y1+9,nn_x+16,y1+24) then
					start=limitX(start-1,1,nn+1);
				elseif MOUSE.CLICK(nn_x,y1+161,nn_x+16,y1+176) then
					start=limitX(start+1,1,nn+1);
				end
				current=0;
		else
			current=0;
		end
    end

    --Cls(x1,y1,x1+w+1,y1+h+1,0,1);
	if returnValue==0 then
		PlayWavE(1);
	end
	lib.LoadSur(sid);
	lib.FreeSur(sid);
    return returnValue;
end

function WarShowMenu(menuItem,numItem,numShow,x1,y1,x2,y2,isBox,isEsc,size,color,selectColor)     --通用菜单函数
    local w=0;
    local h=0;   --边框的宽高
    local i=0;
    local num=0;     --实际的显示菜单项
    local newNumItem=0;  --能够显示的总菜单项数
	size=size or CC.Fontbig;
	size=16;
	color=color or C_ORANGE;
	selectColor=selectColor or C_WHITE;
    lib.GetKey();

    local newMenu={};   -- 定义新的数组，以保存所有能显示的菜单项

    --计算能够显示的总菜单项数
    for i=1,numItem do
        if menuItem[i][3]>0 then
            newNumItem=newNumItem+1;
            newMenu[newNumItem]={menuItem[i][1],menuItem[i][2],menuItem[i][3],i};   --新数组多了[4],保存和原数组的对应
        end
    end

    --计算实际显示的菜单项数
    if numShow==0 or numShow > newNumItem then
        num=newNumItem;
    else
        num=numShow;
    end

    --计算边框实际宽高
    local maxlength=0;
    if x2==0 and y2==0 then
        for i=1,newNumItem do
            if string.len(newMenu[i][1])>maxlength then
                maxlength=string.len(newMenu[i][1]);
            end
        end
        w=size*maxlength/2+2*CC.MenuBorderPixel;        --按照半个汉字计算宽度，一边留4个象素
        h=(size+CC.RowPixel)*num+CC.MenuBorderPixel;            --字之间留4个象素，上面再留4个象素
    else
        w=x2-x1;
        h=y2-y1;
		num=math.min(num,(math.floor(h/(size+CC.RowPixel))));
    end
	--[[
	if x1==0 and y1==0 then
		x1=(CC.ScreenW-w)/2;
		y1=(CC.ScreenH-h)/2;
	end
	if x1==-1 then
		x1=(CC.ScreenW-w)/2;
	end
	if y1==-1 then
		y1=(CC.ScreenH-h)/2;
	end]]--
	
    local start=1;             --显示的第一项

	local current =0;          --当前选择项
	for i=1,newNumItem do
	    if newMenu[i][3]==2 then
		    current=i;
			break;
		end
	end
				if current > num then
					start=1+current-num;
				end
	--[[
	if numShow~=0 then
	    current=1;
	end]]--
	if JY.Menu_keep then
		start=JY.Menu_start;
		current=JY.Menu_current;
	end
    local keyPress =-1;
    local returnValue =0;
	
	local x_off,y_off,row_off,h_off=0,0,0,0;
	
	if isBox==1 then
		x_off=3;
		y_off=7;
		row_off=4;
		h_off=8;
		w=80;
		h=16+24*num;
	elseif isBox==2 then
		x_off=4;
		y_off=6;
		row_off=4;
		h_off=8;
		w=144;
		h=16+24*num;
	elseif isBox==3 then	--baseon 2，调整宽度
		x_off=4;
		y_off=6;
		row_off=4;
		h_off=8;
		w=96;
		h=16+24*num;
	elseif isBox==4 then
		x_off=11;
		y_off=9;
		row_off=0;
		h_off=12;
		w=112;
		h=16+8+20*num;
	elseif isBox==5 then	--策略<=8用
		x_off=4;
		y_off=9;
		row_off=0;
		h_off=12;
		w=104;
		h=16+8+20*num;
	elseif isBox==6 then	--策略>8用
		x_off=4;
		y_off=9;
		row_off=0;
		h_off=12;
		w=120-20;
		h=16+8+20*num;
	elseif isBox==9 then
		DrawBox(x1,y1,x1+w,y1+h,C_WHITE);
	end
	if x1==-1 then
		x1=(CC.ScreenW-w)/2;
	end
	if y1==-1 then
		y1=(CC.ScreenH-h)/2
	end
	local function redraw(flag)
		if num~=0 then --暂且这样改
	        --Cls(x1,y1,x1+w,y1+h);
			if isBox==1 then
				lib.SetClip(x1,y1,x1+w,y1+8+24*num);
				lib.PicLoadCache(4,0*2,x1,y1,1);
				lib.SetClip(0,0,0,0);
				lib.SetClip(x1,y1+8+24*math.max(0,(num-8)),x1+w,y1+8+24*num+8);
				lib.PicLoadCache(4,0*2,x1,y1+16+24*num-256,1);
				lib.SetClip(0,0,0,0);
			elseif isBox==2 then
				lib.SetClip(x1,y1,x1+w,y1+7+24*num);
				lib.PicLoadCache(4,60*2,x1,y1,1);
				lib.SetClip(0,0,0,0);
				lib.SetClip(x1,y1+8+24*math.max(0,(num-3)),x1+w,y1+8+24*num+8);
				lib.PicLoadCache(4,60*2,x1,y1+14+24*num-110,1);
				lib.SetClip(0,0,0,0);
			elseif isBox==3 then
				lib.SetClip(x1,y1,x1+w,y1+7+24*num);
				lib.PicLoadCache(4,63*2,x1,y1,1);
				lib.SetClip(0,0,0,0);
				lib.SetClip(x1,y1+8+24*math.max(0,(num-3)),x1+w,y1+8+24*num+8);
				lib.PicLoadCache(4,63*2,x1,y1+14+24*num-110,1);
				lib.SetClip(0,0,0,0);
			elseif isBox==4 then
				lib.SetClip(x1,y1,x1+w,y1+h);
				lib.PicLoadCache(4,59*2,x1,y1,1);
				lib.SetClip(0,0,0,0);
				lib.SetClip(x1,y1+h-8,x1+w,y1+h);
				lib.PicLoadCache(4,59*2,x1,y1-(384-h),1);
				lib.SetClip(0,0,0,0);
			elseif isBox==5 then
				lib.SetClip(x1,y1,x1+w,y1+h);
				lib.PicLoadCache(4,66*2,x1,y1,1);
				lib.SetClip(0,0,0,0);
				lib.SetClip(x1,y1+h-8,x1+w,y1+h);
				lib.PicLoadCache(4,66*2,x1,y1-(384-h),1);
				lib.SetClip(0,0,0,0);
			elseif isBox==6 then
				lib.SetClip(x1,y1,x1+w+20,y1+h);
				lib.PicLoadCache(4,67*2,x1,y1,1);
				lib.SetClip(0,0,0,0);
				lib.SetClip(x1,y1+h-32,x1+w+20,y1+h);
				lib.PicLoadCache(4,67*2,x1,y1-(384-h),1);
				lib.SetClip(0,0,0,0);
				
				local nn=newNumItem-num;
				local nn_row=120;
				lib.PicLoadCache(4,68*2,x1+98,y1+24+nn_row*(start-1)/nn,1);
			elseif isBox==9 then
				DrawBox(x1,y1,x1+w,y1+h,C_WHITE);
			end
		end

	    for i=start,start+num-1 do
  	        local drawColor=color;           --设置不同的绘制颜色
			local menustr=newMenu[i][1];
	        if i==current then
	            drawColor=selectColor;
	        end
			if isBox==1 then
				if i==current then
					lib.PicLoadCache(4,2*2,x1+6,y1+9+24*(i-1),1);
					DrawString(x1+x_off+CC.MenuBorderPixel,1+y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				else
					lib.PicLoadCache(4,1*2,x1+6,y1+9+24*(i-1),1);
					DrawString(x1+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				end
			elseif isBox==2 then
				if i==current then
					lib.PicLoadCache(4,62*2,x1+6,y1+8+24*(i-1),1);
					DrawString(x1+x_off+CC.MenuBorderPixel,1+y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				else
					lib.PicLoadCache(4,61*2,x1+6,y1+8+24*(i-1),1);
					DrawString(x1+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				end
			elseif isBox==3 then
				if i==current then
					lib.PicLoadCache(4,65*2,x1+6,y1+8+24*(i-1),1);
					DrawString(x1+x_off+CC.MenuBorderPixel,1+y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				else
					lib.PicLoadCache(4,64*2,x1+6,y1+8+24*(i-1),1);
					DrawString(x1+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				end
			elseif isBox==4 then
				if i==current then
					lib.DrawRect(x1+12,y1+12+20*(i-1),x1+99,y1+12+20*(i),C_WHITE);
					DrawString(x1+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				else
					DrawString(x1+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				end
			elseif isBox==5 then
				if i==current then
					lib.DrawRect(x1+12,y1+12+20*(i-1),x1+91,y1+12+20*(i),C_WHITE);
					DrawString(x1+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				else
					DrawString(x1+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				end
			elseif isBox==6 then
				if i==current then
					lib.DrawRect(x1+12,y1+12+20*(i-start),x1+91,y1+12+20*(i-start+1),C_WHITE);
					DrawString(x1+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				else
					DrawString(x1+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
								menustr,drawColor,size);
				end
			else
				DrawString(x1+x_off+CC.MenuBorderPixel,y1+y_off+CC.MenuBorderPixel+(i-start)*(size+row_off+CC.RowPixel),
							menustr,drawColor,size);
			end
			

	    end
		if flag then
			lib.Background(x1,y1,x1+w,y1+h,128);
		end
	end
	local wait=true;
    while wait do
		JY.ReFreshTime=lib.GetTime();
		DrawWarMap();
		redraw();
		ReFresh();
		local eventtype,keyPress,mx,my=getkey();
		mx,my=MOUSE.x,MOUSE.y;
		if eventtype==3 and keyPress==3 then
			if isEsc==1 then
				wait=false;
			end
		end
		if mx>x1+6 and mx<x1+w-6 and my>y1+h_off and my<y1+h-h_off then
			current=math.floor((my-y1-h_off)/(size+CC.RowPixel+row_off));
			if MOUSE.HOLD(x1+7,y1+h_off+(size+CC.RowPixel+row_off)*current,x1+w-7,y1+h_off+(size+CC.RowPixel+row_off)*(current+1)) then
				current=limitX(start+current,1,newNumItem);
			elseif MOUSE.CLICK(x1+7,y1+h_off+(size+CC.RowPixel+row_off)*current,x1+w-7,y1+h_off+(size+CC.RowPixel+row_off)*(current+1)) then
				local sel=limitX(start+current,1,newNumItem);
				current=0;
				PlayWavE(0);
				JY.ReFreshTime=lib.GetTime();
				DrawWarMap();
				redraw();
				ReFresh(CC.OpearteSpeed);
				if newMenu[sel][2]==nil then
					returnValue=newMenu[sel][4];
					wait=false;
				else
					redraw();
					JY.MenuPic.num=JY.MenuPic.num+1;
					JY.MenuPic.pic[JY.MenuPic.num]=lib.SaveSur(x1,y1,x1+w,y1+h);
					JY.MenuPic.x[JY.MenuPic.num]=x1;
					JY.MenuPic.y[JY.MenuPic.num]=y1;
					local r=newMenu[sel][2](newMenu[sel][4]);               --调用菜单函数
					lib.FreeSur(JY.MenuPic.pic[JY.MenuPic.num]);
					JY.MenuPic.num=JY.MenuPic.num-1;
					if r==1 then
						returnValue=newMenu[sel][4];
						wait=false;
					end
				end
			elseif between(isBox,4,6) and MOUSE.IN(x1+7,y1+h_off+(size+CC.RowPixel+row_off)*current,x1+w-7,y1+h_off+(size+CC.RowPixel+row_off)*(current+1)) then
				current=limitX(start+current,1,newNumItem);
			--elseif isBox==6 and MOUSE.IN(x1+7,y1+h_off+(size+CC.RowPixel+row_off)*current,x1+w-7-16,y1+h_off+(size+CC.RowPixel+row_off)*(current+1)) then
			--	current=limitX(start+current,1,newNumItem);
			else
				current=0;
			end
		elseif isBox==6 then
				local nn=newNumItem-num
				local nn_row=120;
				local nn_x=x1+99;
				local nn_y=y1+24+nn_row*start/nn;
				if MOUSE.HOLD(nn_x,y1+24,nn_x+12,y1+24+136) then
					nn_y=MOUSE.y-8;
					start=1+math.floor((nn_y-y1-24)*nn/nn_row);
					start=limitX(start,1,nn+1)
				elseif MOUSE.CLICK(nn_x,y1+9,nn_x+16,y1+24) then
					start=limitX(start-1,1,nn+1);
				elseif MOUSE.CLICK(nn_x,y1+161,nn_x+16,y1+176) then
					start=limitX(start+1,1,nn+1);
				end
				current=0;
		else
			current=0;
		end
    end

    --Cls(x1,y1,x1+w+1,y1+h+1,0,1);
	if returnValue==0 then
		PlayWavE(1);
	end
	--[[
	for i=1,CC.OpearteSpeed do
		JY.ReFreshTime=lib.GetTime();
		DrawWarMap();
		redraw();
		ReFresh();
	end]]--
    return returnValue;
end
