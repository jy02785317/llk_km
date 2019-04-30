SHA={
	cardWidth = 96,
	cardHeight = 128
}	--预定义全局变量Table

function creatCard(x,y,kind,id)
	local width,height=SHA.cardWidth,SHA.cardHeight;
	local card={
				x1=x,y1=y,x2=x+width,y2=y+height,w=width,h=height,
				id=id,kind=kind,	--0 身份卡, 1 武将卡, 2 基本卡,
				pt=0,col=0,cid=0,	--点数/花色/卡片类型(手牌)
				pic=1300,bgpic=1061,fpic=1201,hpic=1111,txt="",
				hide=false,enable=true,on=false,sel=false,ontime=128,
				}
	if kind==0 then
		local str={[0]="[B]主[n]公","[B]忠[n]臣","[B]反[n]贼","[B]内[n]奸"};
		card.txt=str[id];
	elseif kind==1 then
		card.txt=SHA.Person[id]["名称"];
		card.pic=430+id;
		card.fpic=1202;
	elseif kind==2 then
		card.txt=SHA.Card[id]["名称"];
		card.pt=SHA.Card[id]["点数"];
		card.col=SHA.Card[id]["花色"];
		card.cid=SHA.Card[id]["类型"];
		if card.cid==21 then
			card.pic=1316;
		elseif card.cid==31 then
			card.pic=1315;
		elseif card.cid==501 then
			card.pic=1314;
		end
	end
	return card;
end
function drawCard(card)
	if card.on then
		card.ontime=card.ontime+4;
		if card.ontime>=256 then
			card.ontime=0;
		end
	else
		if card.ontime==128 then
			
		elseif card.ontime>=136 then
			card.ontime=card.ontime-8;
		elseif card.ontime<=120 then
			card.ontime=card.ontime+8;
		else
			card.ontime=128;
		end
	end
	local picsource=4;
	if card.kind==1 then
		picsource=2;
	end
	local y_off=0;
	if card.sel then
		y_off=-SHA.cardHeight/8;
	end
	if card.hide then
		--card background
		lib.PicLoadCache(4,card.hpic*2,card.x1,card.y1+y_off,1,nil,nil,card.w,card.h);
		if card.ontime~=128 then
			lib.PicLoadCache(4,card.hpic*2,card.x1,card.y1+y_off,1+2+8,math.abs(card.ontime-128),nil,card.w,card.h);
		end
		--card frame
		lib.PicLoadCache(4,7*2,card.x1-3,card.y1-3+y_off,1,nil,nil,card.w+6,card.h+6);
	else
		--card background
		lib.PicLoadCache(4,card.bgpic*2,card.x1,card.y1+y_off,1,nil,nil,card.w,card.h);
		if card.ontime~=128 then
			lib.PicLoadCache(4,card.bgpic*2,card.x1,card.y1+y_off,1+2+8,math.abs(card.ontime-128),nil,card.w,card.h);
		end
		--card pic
		lib.PicLoadCache(picsource,card.pic*2,card.x1,card.y1+y_off,1,nil,nil,card.w,card.h);
		if card.ontime~=128 then
			lib.PicLoadCache(picsource,card.pic*2,card.x1,card.y1+y_off,1+2+8,math.abs(card.ontime-128),nil,card.w,card.h);
		end
		--card frame
		lib.PicLoadCache(4,card.fpic*2,card.x1,card.y1+y_off,1,nil,nil,card.w,card.h);
		--txt
		if card.kind==0 then
			DrawStringEnhance((card.x1+card.x2)/2,(card.y1+card.y2)/2+y_off,card.txt,C_WHITE,48,0.5,0.5);
		elseif card.kind==1 then
			DrawStringEnhance(card.x1+16,card.y1+16+y_off,"[W]"..card.txt,C_BLACK,20,0.5,nil,20);
		elseif card.kind==2 then
			local t_col={[0]=C_BLACK,M_Red,C_BLACK,M_Red}
			lib.PicLoadCache(4,(1291+card.col)*2,card.x1+16,card.y1+16+y_off,0,nil,t_col[card.col],20);
			DrawStringEnhance(card.x1+16,card.y1+26+y_off,SHA.Str[card.pt],t_col[card.col],20,0.5);
			DrawStringEnhance(card.x1+16,card.y1+46+y_off,"[W]"..card.txt,C_BLACK,20,0.5,nil,20);
		end
	end
	if not card.enable then
		lib.Background(card.x1,card.y1+y_off,card.x2,card.y2+y_off,128);
	end
end
function eventCard(card)
	local y_off=0;
	if card.sel then
		y_off=-SHA.cardHeight/8;
	end
	if MOUSE.CLICK(card.x1,card.y1+y_off,card.x2,card.y2+y_off) then
		if card.enable then
			PlayWavE(0);
			card.sel=not card.sel;
			return 2;
		else
			PlayWavE(2);
			return 1;
		end
	elseif MOUSE.IN(card.x1,card.y1+y_off,card.x2,card.y2+y_off) then
		card.on=true;
		return 1;
	else
		card.on=false;
		return 0;
	end
end
function getSelCard(cardlist)
	local r={};
	for i,v in ipairs(cardlist) do
		if v.sel then
			table.insert(r,i);
		end
	end
	return r;
end
function drawCardList(cardlist)
	--[[for i,card in ipairs(cardlist) do
		if not card.on then
			drawCard(card);
		end
	end
	for i,card in ipairs(cardlist) do
		if card.on then
			drawCard(card);
		end
	end]]--
	for i,card in ipairs(cardlist) do
		drawCard(card);
	end
end
function eventCardList(cardlist,maxnum)
	local r=0;
	local id=0;
	for i=#cardlist,1,-1 do
		if r>0 then
			cardlist[i].on=false;
		else
			r=eventCard(cardlist[i]);
			id=i;
		end
	end
	if maxnum>0 then
		local flag=#getSelCard(cardlist)<maxnum;
		for i,v in ipairs(cardlist) do
			if not v.sel then
				v.enable=flag;
			end
		end
	else
		for i,v in ipairs(cardlist) do
			v.sel=false;
		end
	end
	return r,id;
	--[[
	for i,card in ipairs(cardlist) do
		local r=eventCard(card);
		if r>0 then
			return;
		end
		if eventCard(card) then
			num=0;
			for j,v in ipairs(cardlist) do
				if num1==1 then
					if j~=i then
						v.sel=false;
					end
				end
				if v.sel then
					num=num+1;
				end
			end
			if between(num,num1,num2) then
				bt[2].enable=true;
			else
				bt[2].enable=false;
			end
		end
	end]]--
end
function drawSelectCard(cardlist)
	local w,h=640,480;
	local x,y=(CC.ScreenW-w)/2,(CC.ScreenH-h)/2;
	drawShaMap();
	LoadPicEnhance(73,x,y,w,h);
	drawCardList(cardlist);
end
function selectCard(cardlist,num1,num2)
	num1=num1 or 1;
	num2=num2 or num1;
	local num=0;
	local bt={};
	button_mainbt_1(bt,"决定",1);
	bt[2].enable=false;
	local function redraw()
		drawSelectCard(cardlist);
		button_redraw(bt);
	end
	while true do
		local t1=lib.GetTime();
		redraw()
		ShowScreen();
		local delay=CC.FrameNum-lib.GetTime()+t1;
		if delay>0 then
			lib.Delay(delay);
		end
		--DoEvent
		getkey();
		local event,btid=button_event(bt);
		if event==3 then
			if btid==1 then
				return;
			end
		end
		eventCardList(cardlist,num1);
		bt[2].enable=#getSelCard(cardlist)>0;
	end
end
function positionCard(cardlist)
	local num=#cardlist;
	local n1,n2;
	if num<5 then
		n1=num;	n2=0;
	else
		n1=math.modf(num/2);
		n2=num-n1;
	end
	local x,y;
	x=(CC.ScreenW-(SHA.cardWidth+4)*n1)/2+2;
	if n2>0 then
		y=CC.ScreenH/2-SHA.cardHeight*1.1;
	else
		y=CC.ScreenH/2-SHA.cardHeight*0.5;
	end
	for i=1,n1 do
		cardlist[i].x2=cardlist[i].x2-cardlist[i].x1+x;
		cardlist[i].y2=cardlist[i].y2-cardlist[i].y1+y;
		cardlist[i].x1=x;
		cardlist[i].y1=y;
		x=x+SHA.cardWidth+4;
	end
	if n2>0 then
		x=(CC.ScreenW-(SHA.cardWidth+4)*n2)/2+2;
		y=CC.ScreenH/2+SHA.cardHeight*0.1;
		for i=n1+1,num do
			cardlist[i].x2=cardlist[i].x2-cardlist[i].x1+x;
			cardlist[i].y2=cardlist[i].y2-cardlist[i].y1+y;
			cardlist[i].x1=x;
			cardlist[i].y1=y;
			x=x+SHA.cardWidth+4;
		end
	end
end
function selectWujiang()
	local cardlist={};
	local total=8;
	local x=(CC.ScreenW-(SHA.cardWidth+4)*total)/2;
	x=x+2;
	for i=1,total do
		table.insert(cardlist,creatCard(x,300,1,i));
		x=x+SHA.cardWidth+4;
	end
	positionCard(cardlist);
	selectCard(cardlist,1);
end
function selectShenfen()
	local cardlist={};
	local pool={0,1,2,2,3};
	local num=#pool;
	for i=1,num do
		table.insert(cardlist,creatCard(0,0,0,TableRandom(pool)));
		cardlist[i].hide=true;
	end
	positionCard(cardlist);
	selectCard(cardlist,1);
	PlayWavS(21);
end
function ShaConst()	--定义全局变量
	SHA={
			cardWidth=224/2,
			cardHeight=312/2,
			
			
			Player={},
			UI={
					Player={},
					MyCard={},
					ShowCard={},
					msg="",
				},
			
			--数据结构
			Save_Filename=CONFIG.DataPath .. "SHADATA.R3";
			EFile=CONFIG.SoundPath .. "SE%03d.wav";
			PersonSize=18,
			Person_S={
						["代号"]={0,0,2},
						["名称"]={2,2,14},
						["血点"]={16,0,2},
					},
			CardSize=28,
			Card_S={
						["代号"]={0,0,2},
						["所属包"]={2,0,2},
						["花色"]={4,0,2},
						["点数"]={6,0,2},
						["名称"]={8,2,14},
						["类型"]={22,0,2},
						["攻击范围"]={24,0,2},
						["说明"]={26,0,2},
					},
			SkillSize=20,
			Skill_S={
						["代号"]={0,0,2},
						["名称"]={2,2,14},
						["类型"]={16,0,2},
						["说明"]={18,0,2},
					},
		}
end
function LoadShaRecord()       -- 读取游戏进度
    local t1=lib.GetTime();
    local data=Byte.create(4*8);
    --读取R*.idx文件
    local data=Byte.create(4*12);
    Byte.loadfile(data,SHA.Save_Filename,0,4*12);
	local idx={}
	idx[0]=100;
	for i =1,12 do
	    idx[i]=Byte.get32(data,4*(i-1)*1);
	end
	
    --读取R*.grp文件
	--[[
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
    setmetatable(JY.Base,meta_t);]]--
	
    SHA.PersonNum=math.floor((idx[2]-idx[1])/SHA.PersonSize);   --人物
	SHA.Data_Person=Byte.create(SHA.PersonSize*SHA.PersonNum);
	Byte.loadfile(SHA.Data_Person,	SHA.Save_Filename,idx[1],SHA.PersonSize*SHA.PersonNum);
	SHA.Person={};
	for i=0,SHA.PersonNum-1 do
		SHA.Person[i]={};
		local meta_t={
			__index=function(t,k)
				return GetDataFromStruct(SHA.Data_Person,i*SHA.PersonSize,SHA.Person_S,k);
			end,

			__newindex=function(t,k,v)
				SetDataFromStruct(SHA.Data_Person,i*SHA.PersonSize,SHA.Person_S,k,v);
			end
		}
		setmetatable(SHA.Person[i],meta_t);
	end
    SHA.CardNum=math.floor((idx[3]-idx[2])/SHA.CardSize);   --手牌
	SHA.Data_Card=Byte.create(SHA.CardSize*SHA.CardNum);
	Byte.loadfile(SHA.Data_Card,	SHA.Save_Filename,idx[2],SHA.CardSize*SHA.CardNum);
	SHA.Card={};
	for i=0,SHA.CardNum-1 do
		SHA.Card[i]={};
		local meta_t={
			__index=function(t,k)
				return GetDataFromStruct(SHA.Data_Card,i*SHA.CardSize,SHA.Card_S,k);
			end,

			__newindex=function(t,k,v)
				SetDataFromStruct(SHA.Data_Card,i*SHA.CardSize,SHA.Card_S,k,v);
			end
		}
		setmetatable(SHA.Card[i],meta_t);
	end
    SHA.SkillNum=math.floor((idx[4]-idx[3])/SHA.SkillSize);   --技能
	SHA.Data_Skill=Byte.create(SHA.SkillSize*SHA.SkillNum);
	Byte.loadfile(SHA.Data_Skill,	SHA.Save_Filename,idx[3],SHA.SkillSize*SHA.SkillNum);
	SHA.Skill={};
	for i=0,SHA.SkillNum-1 do
		SHA.Skill[i]={};
		local meta_t={
			__index=function(t,k)
				return GetDataFromStruct(SHA.Data_Skill,i*SHA.SkillSize,SHA.Skill_S,k);
			end,

			__newindex=function(t,k,v)
				SetDataFromStruct(SHA.Data_Skill,i*SHA.SkillSize,SHA.Skill_S,k,v);
			end
		}
		setmetatable(SHA.Skill[i],meta_t);
	end
	
	SHA.Data_Str=Byte.create(idx[7]-idx[6]);
	Byte.loadfile(SHA.Data_Str,SHA.Save_Filename,idx[6],idx[7]-idx[6]);
	SHA.StrNum=Byte.get16(SHA.Data_Str,0);
	SHA.Str={};
	local meta_t={
	    __index=function(t,k)
			return Byte.getstr(SHA.Data_Str,Byte.get32(SHA.Data_Str,2+4*(k-1)),Byte.get32(SHA.Data_Str,2+4*k)-Byte.get32(SHA.Data_Str,2+4*(k-1)));
		end,

		__newindex=function(t,k,v)
	        return;
	 	end
	}
	setmetatable(SHA.Str,meta_t);
	collectgarbage();
	lib.Debug(string.format("Loadrecord time=%d",lib.GetTime()-t1));
	
end
--播放音效e**
function PlayWavS(id)              --播放音效e**
    if JY.EnableSound==0 then
        return ;
    end
    if id>=0 then
        lib.PlayWAV(string.format(SHA.EFile,id));
    end
end
function ShaMain()
	ShaConst();
	LoadShaRecord();
	initSha();
	ShaSub();
end
function ShaSub()
	selectShenfen();
	selectWujiang();
	--每人4张，主公+2
	for id=1,#SHA.Player do
		sendCard(id,14);
	end
	freshUI();
	while true do
		for i=1,#SHA.Player do
			ShaTurnStart(i);
			ShaTurnPreCheck(i);
			ShaTurnGetCard(i);
			ShaTurnUseCard(i);
			ShaTurnDisCard(i);
			ShaTurnEnd(i);
		end
	end
end
function drawShaMap()
	lib.FillColor(0,0,0,0,0);
	lib.PicLoadCache(5,50*2,CC.ScreenW/2,CC.ScreenH/2);
	--显示Player信息
	drawCardList(SHA.UI.Player);
	for i,v in ipairs(SHA.Player) do
		local sx,sy
		--card
		if i>1 then	--非玩家
			local cnum=#v.card;
			if cnum>0 then
				local w,h=SHA.cardWidth/4,SHA.cardHeight/4;
				sx,sy=v.x+SHA.cardWidth+w/2,v.y+h/2+2;
				local dx=2;
				if sx>CC.ScreenW then
					sx=v.x-w/2;
					dx=-2;
				end
				for j=1,cnum do
					sx=sx+dx;
					lib.PicLoadCache(4,SHA.UI.Player[i].hpic*2,sx,sy,0,nil,nil,SHA.UI.Player[i].w/4);
				end
				DrawStringEnhance(sx,sy,"[W]"..#v.card,C_BLACK,20,0.5,0.5);
			end
		end
		--武器装备马
		sx,sy=v.x+SHA.cardWidth+2,v.y+SHA.cardHeight/4+2;
		local xadj=0;
		if sx>CC.ScreenW then
			sx=v.x-2;
			xadj=1;
		end
		for j,cid in ipairs(v.item) do
			if cid>0 then
				local card=SHA.Card[cid];
				local str=SHA.Str[21+card["花色"]]..SHA.Str[card["点数"]]..card["名称"];
				DrawStringEnhance(sx,sy+20*(j-1),str,C_BLACK,20,xadj);
			end
		end
		--hp
		sx,sy=v.x+SHA.cardWidth-16,v.y+16;
		for j=1,v.hp do
			lib.PicLoadCache(4,1281*2,sx,sy,0,nil,nil,20);
			sy=sy+22;
		end
		for j=v.hp+1,v.hpmax do
			lib.PicLoadCache(4,1282*2,sx,sy,0,nil,nil,20);
			sy=sy+22;
		end
	end
	--显示玩家手牌
	drawCardList(SHA.UI.MyCard);
	--显示提示信息
	if #SHA.UI.msg>0 then
		DrawStringEnhance(CC.ScreenW/2,CC.ScreenH*2/3,"[W]"..SHA.UI.msg,C_BLACK,36,0.5,1);
	end
end
function initSha()
	--初始化玩家信息
	SHA.Player={};
	for i=1,5 do
		SHA.Player[i]={
						pid=i,				--武将ID
						ai=true,			--玩家/AI
						live=true,			--存活
						x=0,				--显示位置X
						y=0,				--Y
						role=0,				--主/忠/反/内
						hp=3,
						hpmax=4,
						item={0,0,0,0},		--武器/防具/马X2
						spcard={},			--判定区
						card={},			--手牌
						};
	end
	if true then	--标准5人局
		SHA.Player[1].x=SHA.cardWidth;
		SHA.Player[1].y=CC.ScreenH-SHA.cardHeight;
		SHA.Player[2].x=CC.ScreenW-SHA.cardWidth;
		SHA.Player[2].y=CC.ScreenH/2-SHA.cardHeight/2;
		SHA.Player[3].x=CC.ScreenW*2/3-SHA.cardWidth/2;
		SHA.Player[3].y=0;
		SHA.Player[4].x=CC.ScreenW*1/3-SHA.cardWidth/2;
		SHA.Player[4].y=0;
		SHA.Player[5].x=0;
		SHA.Player[5].y=CC.ScreenH/2-SHA.cardHeight/2;
	end
	SHA.Player[1].ai=false;	--1号为玩家
	--清空所有卡牌池
	SHA.CardPool={};
	SHA.UsedCardPool={};
	--将可用牌加入弃牌区
	for i=1,SHA.CardNum-1 do
		if SHA.Card[i]["所属包"]==0 then
			table.insert(SHA.UsedCardPool,i);
		end
	end
	--洗牌，从弃牌区抓入卡牌池
	initCard();
end
function initCard()
	while #SHA.UsedCardPool>0 do
		table.insert(SHA.CardPool,TableRandom(SHA.UsedCardPool));
	end
end
function sendCard(id,num)
	for i=1,num do
		table.insert(SHA.Player[id].card,TableRandom(SHA.CardPool));
	end
end
function removeCard(id,cid)
	table.insert(SHA.UsedCardPool,SHA.Player[id].card[cid]);	--加入弃牌堆
	table.remove(SHA.Player[id].card,cid);						--从手牌堆移除
end
function sortCard()	--对玩家手牌 排序
	if #SHA.UI.MyCard>0 then
		local frame=10;
		PlayWavS(20);
		local x0=SHA.UI.MyCard[1].x1;
		for t=frame,0,-1 do
			for i,v in ipairs(SHA.UI.MyCard) do
				v.x1=x0+(v.x2-v.w-x0)*t/frame;
			end
			local t1=lib.GetTime();
			drawShaMap();
			ShowScreen();
			local delay=CC.FrameNum-lib.GetTime()+t1;
			if delay>0 then
				lib.Delay(delay);
			end
			getkey();
			--eventCardList(SHA.UI.Player,0);
			--eventCardList(SHA.UI.MyCard,0);
		end
		table.sort(SHA.Player[1].card,	function(a,b)
											if SHA.Card[a]["类型"]<SHA.Card[b]["类型"] then return true end
										end)
		freshUI();
		PlayWavS(20);
		for t=0,frame do
			for i,v in ipairs(SHA.UI.MyCard) do
				v.x1=x0+(v.x2-v.w-x0)*t/frame;
			end
			local t1=lib.GetTime();
			drawShaMap();
			ShowScreen();
			local delay=CC.FrameNum-lib.GetTime()+t1;
			if delay>0 then
				lib.Delay(delay);
			end
			getkey();
			--eventCardList(SHA.UI.Player,0);
			--eventCardList(SHA.UI.MyCard,0);
		end
		
	end
end
function freshUI()
	SHA.UI.Player={};
	SHA.UI.MyCard={};
	SHA.UI.ShowCard={};
	for i,v in ipairs(SHA.Player) do
		table.insert(SHA.UI.Player,creatCard(v.x,v.y,1,v.pid));
	end
	local x,y=SHA.Player[1].x+SHA.cardWidth*1.2,SHA.Player[1].y;
	local dx=(CC.ScreenW-SHA.cardWidth*3)/(#SHA.Player[1].card+1);
	dx=limitX(dx,16,SHA.cardWidth+4)
	for i,v in ipairs(SHA.Player[1].card) do
		table.insert(SHA.UI.MyCard,creatCard(x,y,2,v));
		x=x+dx;
	end
end
function ShaTurnStart(id)
	
end
function ShaTurnPreCheck(id)
	
end
function ShaTurnGetCard(id)
	sendCard(id,2);
	freshUI();
end
function ShaTurnUseCard(id)
	if id==1 then
		sortCard();
		local bt={}
		local x,y=CC.ScreenW-SHA.cardWidth*3,CC.ScreenH-SHA.cardHeight*1.2-32;
		table.insert(bt,button_creat(1,11,x,y,"取消",true,true));	x=x-100;
		table.insert(bt,button_creat(1,12,x,y,"确定",true,true));
		table.insert(bt,button_creat(1,73,20,4,"Exit",true,true));
		table.insert(bt,button_creat(1,74,120,4,"Dofile",true,true));
		SHA.UI.msg="请出牌。"
		while true do
			local t1=lib.GetTime();
			drawShaMap();
			button_redraw(bt);
			ShowScreen();
			local delay=CC.FrameNum-lib.GetTime()+t1;
			if delay>0 then
				lib.Delay(delay);
			end
			--DoEvent
			getkey();
			local event,btid=button_event(bt);
			if event==3 then
				if btid==73 then
					return;
				elseif btid==74 then
					dofile(CONFIG.ScriptPath .. "Sha.lua");
				elseif btid==12 then
					bt[2].enable=false;
					if useMyCard() then
						return;
					end
				end
			end
			eventCardList(SHA.UI.Player,0);
			if eventCardList(SHA.UI.MyCard,1)==2 then	--手牌选择有改变，重设按钮文本
				bt[2].txt="确定";
				bt[2].enable=false;
				local selcard=getSelCard(SHA.UI.MyCard);
				if #selcard==1 then
					local id=selcard[1];
					local cid=SHA.UI.MyCard[id].id
					local card=SHA.Card[cid];
					local cardtype=card["类型"];
					if between(cardtype,1,3) then	--杀
						bt[2].txt="杀";
						bt[2].enable=true;
					elseif cardtype==21 and SHA.Player[1].hp<SHA.Player[1].hpmax then	--桃
						bt[2].txt="使用";
						bt[2].enable=true;
					elseif cardtype==31 then	--酒
						bt[2].txt="使用";
						bt[2].enable=true;
					elseif between(cardtype,101,500) then	--武器/防具/马
						bt[2].txt="装备";
						bt[2].enable=true;
					elseif cardtype>500 then
						bt[2].txt="使用";
						bt[2].enable=true;
					end
				end
			end
		end
	end
end
function ShaTurnDisCard(id)
	
end
function ShaTurnEnd(id)
	
end

function useMyCard()
	local selcard=getSelCard(SHA.UI.MyCard);
	if #selcard==1 then
		local id=selcard[1];
		local cid=SHA.UI.MyCard[id].id
		local card=SHA.Card[cid];
		local cardtype=card["类型"];
		if cardtype==1 then	--杀
			SHA.UI.MyCard={};
			SHA.UI.msg="请选择杀的对象。"
			local id2=selectPlayer();
			if id2>0 then
				showCard(1,cid,40);
				card_base_kill(1,id2);
				removeCard(1,id);
				freshUI();
			end
		elseif cardtype==21 then	--桃
			SHA.UI.MyCard={};
			showCard(1,cid,40)
			PlayWavS(95);
			SHA.Player[1].hp=SHA.Player[1].hp+1;
			removeCard(1,id);
			freshUI();
		elseif cardtype==31 then	--酒
			
		elseif between(cardtype,101,200) then	--武器
			SHA.UI.MyCard={};
			showCard(1,cid,40);
			removeCard(1,id);
			SHA.Player[1].item[1]=cid;
			freshUI();
		elseif between(cardtype,201,300) then	--防具
			SHA.UI.MyCard={};
			showCard(1,cid,40);
			removeCard(1,id);
			SHA.Player[1].item[2]=cid;
			freshUI();
		elseif between(cardtype,301,400) then	--马
			SHA.UI.MyCard={};
			showCard(1,cid,40);
			removeCard(1,id);
			SHA.Player[1].item[3]=cid;
			freshUI();
		elseif between(cardtype,401,500) then	--马
			SHA.UI.MyCard={};
			showCard(1,cid,40);
			removeCard(1,id);
			SHA.Player[1].item[4]=cid;
			freshUI();
		elseif cardtype>500 then
			
		end
	end
end
function showCard(pid,cid,t)
	t=t or 40;
	PlayWavS(99);
	local card=creatCard(300,300,2,cid);
	card.on=true;
	for t=1,t do
		local t1=lib.GetTime();
		drawShaMap();
		drawCard(card);
		ShowScreen();
		local delay=CC.FrameNum-lib.GetTime()+t1;
		if delay>0 then
			lib.Delay(delay);
		end
		getkey();
	end
end
function selectPlayer()
	local r,id;
	while true do
		local t1=lib.GetTime();
		drawShaMap();
		ShowScreen();
		local delay=CC.FrameNum-lib.GetTime()+t1;
		if delay>0 then
			lib.Delay(delay);
		end
		getkey();
		r,id=eventCardList(SHA.UI.Player,0);
		if r>1 then
			return id;
		end
	end
end
function card_base_kill(id1,id2)
	if Sha_AI2(id2,id1,1) then
	
	else
		SHA.Player[id2].hp=SHA.Player[id2].hp-1;
	end
end

----------------
----	AI	----
----------------
function Sha_AI2(id1,id2,kind)	--被动出牌
	local cardkind=0;
	if kind==1 then	--杀
		local id=Sha_AI_getCard(id1,11);
		if id>0 then
			showCard(id1,SHA.Player[id1].card[id]);
			removeCard(id1,id);
			return true;
		end
	end
end
function Sha_AI_getCard(id,cardkind)
	local player=SHA.Player[id];
	for i,v in ipairs(player.card) do
		if SHA.Card[v]["类型"]==cardkind then
			return i;
		end
	end
	return 0;
end