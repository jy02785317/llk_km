function WarFight(name1,name2)
	local id1,id2;
	if JY.NameList[name1]~=nil then
		id1=JY.NameList[name1];
	else
		lib.Debug("WarFight: "..name1.." not exist");
		return false;
	end
	if JY.NameList[name2]~=nil then
		id2=JY.NameList[name2];
	else
		lib.Debug("WarFight: "..name2.." not exist");
		return false;
	end
	return fight(id1,id2)
end
function FightMenu()
	local id1=ShowPersonList(GetAllList(),"武力");
	if id1<=-1 then
		return;
	end
	local id2=ShowPersonList(GetAllList(id1),"武力");
	if id2<=-1 then
		return;
	end
	fight(id1,id2);
end
function fight(id1,id2)
	if JY.Status==GAME_START then
		
	elseif JY.Status==GAME_SMAP_AUTO or JY.Status==GAME_SMAP_MANUAL or JY.Status==GAME_MMAP then
		Dark();
		if CC.ScreenW~=CONFIG.Width or CC.ScreenH~=CONFIG.Height then
			CC.ScreenW=CONFIG.Width;
			CC.ScreenH=CONFIG.Height;
			Config();
			PicCacheIni();
		end
	elseif JY.Status==GAME_WMAP then
		Dark();
	elseif JY.Status==GAME_DEAD then
		Dark();
	elseif JY.Status==GAME_END then
		Dark();
	end
	local r=fight_sub(id1,id2);
	Dark();
	if JY.Status==GAME_START then
		
	elseif JY.Status==GAME_SMAP_AUTO or JY.Status==GAME_SMAP_MANUAL or JY.Status==GAME_MMAP then
		if CC.ScreenW~=CONFIG.Width2 or CC.ScreenH~=CONFIG.Height2 then
			CC.ScreenW=CONFIG.Width2;
			CC.ScreenH=CONFIG.Height2;
			Config();
			PicCacheIni();
		end
		DrawSMap();
		Light();
	elseif JY.Status==GAME_WMAP then
		DrawWarMap();
		Light();
	elseif JY.Status==GAME_DEAD then
	elseif JY.Status==GAME_END then
	end
	return r;
end
function fight_sub(id1,id2)
	local n=2;
	local ID={id1,id2};
	local p1,p2=JY.Person[id1],JY.Person[id2];
	local card={[1]={},[2]={}};
	local card_num={};
	local str={
					[1]={	"%s在此，*来将速速通名受死！",						"我乃%s是也！*全力一战吧！",
							"我乃%s也！*来将通名再战！",						"%s在此，*放马过来吧！",
							"%s来了！*对面战将，可留姓名？",					"%s在此，*拿命来吧！",
							"我乃%s，*本将刀下不斩无名之鬼！",					"%s在此，*让我看你到底有多厉害",
							"我乃%s也！*谁敢一战！",							"好极了！*%s接受你的挑战。",
							"居然有人敢挑战我%s？",								"多说无益！*接招吧！",
							"%s在此，*有不要命的敢上来吗？",					"我%s不会手软的。*来吧，看招！",
							"我乃%s也，*今日必定斩将立功！",					"%s在此，*看我一招结果你！",
							"%s在此，*活动活动一下吧！",						"%s在此，*看我一招结果你！",
							"我%s来了！*看我来大闹一番！",						"有意思，*我%s来斗斗你！",
							"我乃%s，*敌将，我来取你项上人头了！",				"哼、无名小辈！*滚开！",
							"我乃%s。*你这个不知天高地厚的混蛋，*快报名上来！",	"说什么蠢话，*看我%s的厉害吧！",
							"%s在此，*跟我一决胜负吧！",						"哈哈哈！*好，放马过来！",
							"领教领教我%s的武艺吧！",							"来吧！*%s来会会你！",
							"遇到了我%s算你倒霉，*哈哈哈，今天就是你的死期！",	"这个玩笑真有意思，*看我怎么砍下你的脑袋！",},
					[2]={"呀~呀~呀~呀~呀！！！","看这招！","你躲得过去吗！","小心了！","杀！！！",
						"这招对付你，足够了！","看我取你狗命！","不能再让你了！","觉悟吧！","去死！",},
					[3]={"这一招，仔细看清楚吧！","来吧！*如果你跟得上我的速度！","你惹火我了！*来试试这招吧！","只有这点能耐吗？*那可不行哦！","来吧！*你值得我使出这一招！",
						"还没完呢！再来！","哈哈哈哈！*一切的准备都是为了这一招！","......*死！","来尝尝我的家传绝技吧！","这一招，*虽然还不够熟练，*但是击败你绰绰有余！",
						"真勇猛！*不过接得住我这一招吗，看招！","唔喔喔喔喔！*我生气了！*我真的生气了！","你已经完蛋了！*让你见识我真正的绝招，*就当送你下黄泉的礼物吧！","哈哈哈，*太慢了，太慢了！","哈哈，你上当了！*吃我这招！",},
					[4]={"哼！","啊！","果然有一手","真厉害！","好大的力气！",
						"好快的速度！","这家伙，*是怪物吗？","真没想到......","还不能认输...","居然没防住？",
						"可、可恶...","哇啊啊啊啊......！","怎、怎么可能...","哇呀！*糟、糟了！","唔唔！",},
					[5]={"不过如此！","好险！","华而不实！","看来你技穷了","这也叫招式吗？",
						"你还能再慢点吗？","就像饶痒痒一样","换我反击了！","你这招根本就没有练熟！","再来再来！*一点感觉都没有！",
						"怎么啦，*你就只有这两下子？","就凭这等武艺，*还想胜我？","怎么啦？*根本不管用嘛！","这种雕虫小技在我面前，*根本就是班门弄斧！","真有意思，*可以对我完全没用。",},
					[6]={"居然输了...","我不能死在这里...","怎么会这样！","不该和他打的...","这家伙太恐怖了！",
						"想不到我会败在这里...","天要亡我吗！","耻辱！","奇怪？*力气...怎么没力气了?","再不能临阵讨贼了！",
						"败在你手上，*我无话可说。","唔、果然厉害！","这就是我和你之间的差距吗......","...*......","天下之大，*居然还有如此强劲的对手！",},
					[7]={"敌将被我击败了！","哈哈哈哈！*还有人敢上吗！","不堪一击！","真痛快！","欢呼吧！",
						"知道厉害了吧!","这就赢了？*还没过瘾呢！","赢了","这就是反贼的下场！","太弱了！",},
				}
	card_num[1]=5+p1["威风"];
	card_num[2]=5+p2["威风"];
	--[[
	if p1["等级"]>=30 then
		card_num[1]=6;
	elseif p1["等级"]>=15 then
		card_num[1]=5;
	else
		card_num[1]=4;
	end
	if p2["等级"]>=30 then
		card_num[2]=6;
	elseif p2["等级"]>=15 then
		card_num[2]=5;
	else
		card_num[2]=4;
	end
	]]--
	local hpmax={150+p1["等级"],150+p2["等级"]};
	local hp={150+p1["等级"],150+p2["等级"]};
	local mp={20,20};
	if p1["武力"]>p2["武力"] then
		mp[1]=35;
	elseif p1["武力"]<p2["武力"] then
		mp[2]=35;
	end
	local atk={math.max(math.modf(p1["武力"]/10)-1,2),math.max(math.modf(p2["武力"]/10)-1,2)};
	if atk[1]-atk[2]>5 then
		atk[2]=atk[1]-5;
	elseif atk[2]-atk[1]>5 then
		atk[1]=atk[2]-5;
	end
	--[[local atk_offset=math.max(0,8-math.max(atk[1],atk[2]))
	atk[1]=atk[1]+atk_offset;
	atk[2]=atk[2]+atk_offset;]]--
	local atk_offset=8/math.max(atk[1],atk[2]);
	atk[1]=math.modf(atk[1]*atk_offset);
	atk[2]=math.modf(atk[2]*atk_offset);
	atk[1]=atk[1]+math.modf(p1["奋战"]/8)-p2["奋战"]%8;
	atk[2]=atk[2]+math.modf(p2["奋战"]/8)-p1["奋战"]%8;
	if p1["士气"]<80 then
		atk[1]=atk[1]-1;
	end
	if p1["士气"]<30 then
		atk[1]=atk[1]-1;
	end
	if p2["士气"]<80 then
		atk[2]=atk[2]-1;
	end
	if p2["士气"]<30 then
		atk[2]=atk[2]-1;
	end
	if atk[1]<2 then
		atk[1]=2
	end
	if atk[2]<2 then
		atk[2]=2
	end
	if JY.Status==GAME_WMAP then
		--atk[1]=atk[1]+1;
	end
	local size=48*2;
	local size2=64*2;
	local sy=420;
	local s={};
	s[1]={
			d=0,	--0123 下上左右
			x=32+size,
			pic=p1["战斗动作"],
			action=9,	--0静止 1移动 2攻击 3防御 4被攻击 5喘气 9不存在
			frame=0,
			effect=0,
			movewav=JY.Bingzhong[p1["兵种"]]["音效"],
			atkbuff=JY.Bingzhong[p1["兵种"]]["攻击"]/2,
			defbuff=JY.Bingzhong[p1["兵种"]]["防御"]/2,
			loser=false,
			txt="",
			lv=p1["等级"],
			mpadd=5+p1["福源"]/10,
			dl=1,	--底力可否使用
			jj=0,	--急救可否使用
			wl=p1["武力"],
			ts=p1["统率"],
			lq=p1["灵巧"],
		};
	s[2]={
			d=0,
			x=CC.ScreenW-size-32,
			pic=p2["战斗动作"],
			action=9,	--0静止 1移动 2攻击 3防御 4被攻击 5喘气 6举手 9不存在
			frame=0,
			effect=0,
			movewav=JY.Bingzhong[p2["兵种"]]["音效"],
			atkbuff=JY.Bingzhong[p2["兵种"]]["攻击"]/2,
			defbuff=JY.Bingzhong[p2["兵种"]]["防御"]/2,
			loser=false,
			txt="",
			lv=p2["等级"],
			mpadd=5+p2["福源"]/10,
			dl=1,
			jj=0,	--急救可否使用
			wl=p2["武力"],
			ts=p2["统率"],
			lq=p2["灵巧"],
		};
	if p1["个性"]==1 then
		s[1].ym=1;
		s[1].lj=7;
		s[1].jj=1;
	elseif p1["个性"]==2 then
		s[1].ym=3;
		s[1].lj=5;
	elseif p1["个性"]==3 then
		s[1].ym=5;
		s[1].lj=3;
	elseif p1["个性"]==4 then
		s[1].ym=7;
		s[1].lj=1;
	end
	if p2["个性"]==1 then
		s[2].ym=1;
		s[2].lj=7;
		s[2].jj=1;
	elseif p2["个性"]==2 then
		s[2].ym=3;
		s[2].lj=5;
	elseif p2["个性"]==3 then
		s[2].ym=5;
		s[2].lj=3;
	elseif p2["个性"]==4 then
		s[2].ym=7;
		s[2].lj=1;
	end
	
	
	
	s[1].ym=limitX(s[1].ym,0,math.modf(p1["士气"]/14));
	s[1].lj=limitX(s[1].lj,0,math.modf(p1["士气"]/14));
	s[2].ym=limitX(s[2].ym,0,math.modf(p2["士气"]/14));
	s[2].lj=limitX(s[2].lj,0,math.modf(p2["士气"]/14));
	local function admp(i,v)
		v=math.modf(v);
		mp[i]=limitX(mp[i]+v,0,100);
	end
	local function dechp(i,v,flag)	--flag 格挡成功
		flag=flag or false;
		if math.random(100)<s[3-i].atkbuff then
			v=v+1;
		end
		if math.random(100)<s[i].defbuff then
			v=v-1;
		end
		v=math.modf(v);
		if v<1 then
			v=1;
		end
		--bq 不屈，最低伤害下限，否则不受伤害
		if flag and RND(s[i].ts/110) then
			v=0;
		end
		hp[i]=hp[i]-v;
		
		if hp[i]<0 then
			hp[i]=0;
		end
		--被攻击时mp增加
		admp(i,1+v/2);
	end
	local function show()
		getkey();
		--center=496(from 412,add 84)
		lib.FillColor(0,0,0,0,0);
		lib.PicLoadCache(5,58*2,0,0,1);
			
		DrawYJZBox(128,32,s[1].txt,C_WHITE,18);
		lib.PicLoadCache(2,(p1["容貌"]+2000)*2,32,16,1);
		if s[1].losser then
			--lib.Background(32,8,32+64,8+80,106);
		end
		DrawYJZBox(32+90,110,p1["名称"]..string.format("  武力%3d",p1["武力"]),C_WHITE,18);
		
		DrawYJZBox(-128,32,s[2].txt,C_WHITE,18);
		lib.PicLoadCache(2,(p2["容貌"]+2000)*2,CC.ScreenW-122,16,1);
		if s[2].losser then
			--lib.Background(646,8,646+64,8+80,106);
		end
		DrawYJZBox(-32-90,110,string.format("武力%3d  ",p2["武力"])..p2["名称"],C_WHITE,18);
		
		lib.PicLoadCache(4,220*2,32,128,1);
		lib.PicLoadCache(4,222*2,CC.ScreenW-320,128,1);
		lib.SetClip(0,128,32+math.modf(288*hp[1]/hpmax[1]),128+24);
		lib.PicLoadCache(4,221*2,32,128,1);
		lib.SetClip(CC.ScreenW-math.modf(288*hp[2]/hpmax[2])-32,128,CC.ScreenW,128+24);
		lib.PicLoadCache(4,223*2,CC.ScreenW-320,128,1);
		lib.SetClip(0,0,0,0);
		for i=1,2 do
			if s[i].action==0 then
				lib.PicLoadCache(11,(s[i].pic+16+s[i].d)*2,s[i].x,sy,0);
				if s[i].effect>0 then
					lib.PicLoadCache(11,(s[i].pic+16+s[i].d)*2,s[i].x,sy,0+2+8,s[i].effect);
				end
			elseif s[i].action==1 then
				lib.PicLoadCache(11,(s[i].pic+s[i].frame+s[i].d*4)*2,s[i].x,sy,0);
				if s[i].effect>0 then
					lib.PicLoadCache(11,(s[i].pic+s[i].frame+s[i].d*4)*2,s[i].x,sy,0+2+8,s[i].effect);
				end
			elseif s[i].action==2 then
				lib.PicLoadCache(11,(s[i].pic+30+s[i].frame+s[i].d*4)*2,s[i].x,sy,0);
				if s[i].effect>0 then
					lib.PicLoadCache(11,(s[i].pic+30+s[i].frame+s[i].d*4)*2,s[i].x,sy,0+2+8,s[i].effect);	
				end
			elseif s[i].action==3 then
				lib.PicLoadCache(11,(s[i].pic+22+s[i].d)*2,s[i].x,sy,0);
				if s[i].effect>0 then			
					lib.PicLoadCache(11,(s[i].pic+22+s[i].d)*2,s[i].x,sy,0+2+8,s[i].effect);	
				end
			elseif s[i].action==4 then
				lib.PicLoadCache(11,(s[i].pic+26+s[i].d%2)*2,s[i].x,sy,0);
				if s[i].effect>0 then
					lib.PicLoadCache(11,(s[i].pic+26+s[i].d%2)*2,s[i].x,sy,0+2+8,s[i].effect);
				end
			elseif s[i].action==5 then
				lib.PicLoadCache(11,(s[i].pic+20+s[i].frame)*2,s[i].x,sy,0);
				if s[i].effect>0 then
					lib.PicLoadCache(11,(s[i].pic+20+s[i].frame)*2,s[i].x,sy,0+2+8,s[i].effect);
				end
			elseif s[i].action==6 then
				lib.PicLoadCache(11,(s[i].pic+28)*2,s[i].x,sy,0);
				if s[i].effect>0 then
					lib.PicLoadCache(11,(s[i].pic+28)*2,s[i].x,sy,0+2+8,s[i].effect);
				end
			end
		end
	end
	local function turn(id,d)
		if s[id].d==d then
			return;
		end
		s[id].action=0;
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(2);
		--ReFresh();
		if s[id].d~=0 then
			s[id].d=0;
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh(2);
			--ReFresh();
		end
		s[id].d=d;
		JY.ReFreshTime=lib.GetTime();
		show();
		PlayWavE(6);
		ReFresh(2);
		--ReFresh();
	end
	local function move(id,dx)
		local flag=1;
		s[id].action=1;
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh();
		local step=12;
		if dx<s[id].x then
			step=-12;
		end
		for i=s[id].x,dx,step do
			s[id].x=i;
			s[id].frame=s[id].frame+1;
			if s[id].frame>=2 then
				s[id].frame=0;
			end
			JY.ReFreshTime=lib.GetTime();
			show();
			if flag==1 then
				PlayWavE(s[id].movewav);
				flag=4;
			else
				flag=flag-1;
			end
			ReFresh(3);
			--ReFresh();
			--ReFresh();
			lib.GetKey();
		end
		s[1].action=0;
		s[2].action=0;
		s[1].frame=0;
		s[2].frame=0;
		JY.ReFreshTime=lib.GetTime();
		show();
		PlayWavE(s[id].movewav);
		ReFresh(2);
		--ReFresh();
	end
	local function move2(dx1,dx2)
		local count=1;
		local step1,step2=12,12;
		if dx1<s[1].x then
			step1=-12;
			turn(1,2);
		else
			turn(1,3)
		end
		if dx2<s[2].x then
			step2=-12;
			turn(2,2);
		else
			turn(2,3)
		end
		s[1].action=1;
		s[2].action=1;
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh();
		local mt=0;
		while true do
			local flag=true;
			if s[1].x~=dx1 then
				flag=false;
				s[1].x=s[1].x+step1;
				s[1].frame=s[1].frame+1;
				if s[1].frame>=2 then
					s[1].frame=0;
				end
			else
				s[1].action=0;
			end
			if s[2].x~=dx2 then
				flag=false;
				s[2].x=s[2].x+step2;
				s[2].frame=s[2].frame+1;
				if s[2].frame>=2 then
					s[2].frame=0;
				end
			else
				s[2].action=0;
			end
			JY.ReFreshTime=lib.GetTime();
			show();
			if count==1 then
				if s[1].action==1 then
					PlayWavE(s[1].movewav);
				end
				if s[2].action==1 then
					PlayWavE(s[2].movewav);
				end
				count=4;
			else
				count=count-1;
			end
			ReFresh(4);
			--ReFresh();
			--ReFresh();
			--ReFresh();
			lib.GetKey();
			if flag then
				break;
			end
		end
		s[1].action=0;
		s[2].action=0;
		s[1].frame=0;
		s[2].frame=0;
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh();
	end
	local function atk_p(id,gd)--普通攻击 平手 gd 暴击概率
		local n=3;
		local flag=false;
		s[id].action=2;
		s[3-id].action=2;
		if math.random(gd)>50 then
			flag=true;
			PlayWavE(6);
			s[1].txt=str[2][math.random(10)];
			s[2].txt=str[2][math.random(10)];
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh(4);
		end
		for i=0,3 do
			s[id].frame=i;
			s[3-id].frame=i;
			if flag and i==0 then
				PlayWavE(33);
				for t=8,192,8 do
					s[id].effect=t;
					s[3-id].effect=t;
					JY.ReFreshTime=lib.GetTime();
					show();
					ReFresh();
				end
				s[1].effect=0;
				s[2].effect=0;
			end
			if i==3 then
				if flag then
					PlayWavE(31);
					s[1].txt=str[5][math.random(15)];
					s[2].txt=str[5][math.random(15)];
				else
					PlayWavE(30);
				end
				JY.ReFreshTime=lib.GetTime();
				show();
				ReFresh();
			end
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh(n);
		end
		if flag then
			if s[3-id].x>s[id].x then
				s[3-id].x=s[3-id].x+24;
				s[id].x=s[id].x-24
			else
				s[3-id].x=s[3-id].x-24;
				s[id].x=s[id].x+24
			end
		end
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(n*3);
		s[1].action=0;
		s[2].action=0;
		s[1].frame=0;
		s[2].frame=0;
		s[1].effect=0;
		s[2].effect=0;
	end
	local function atk_ms(id,gd)--秒杀 gd 暴击概率
		local n=3;
		s[id].action=2;
		local flag=false;
		s[id].txt=str[3][math.random(15)];
		if ID[id]==2 then
			s[id].txt=str[3][math.random(15)].."*鬼胡斩！";
		end
		PlayWavE(6);
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(4);
		for i=0,3 do
			s[id].frame=i;
			if i==0 then
				PlayWavE(33);
				for t=24,240,6 do
					s[id].effect=t;
					JY.ReFreshTime=lib.GetTime();
					show();
					ReFresh();
				end
			end
			if i==3 then
				if s[3-id].x>s[id].x then
					s[id].x=s[3-id].x-size;
				else
					s[id].x=s[3-id].x+size;
				end
				if math.random(100)<gd then
					s[3-id].txt=str[5][math.random(15)];
					flag=true;
					s[3-id].action=3;
					PlayWavE(31);
					dechp(3-id,20+atk[id],true);
					s[3-id].effect=208;
					JY.ReFreshTime=lib.GetTime();
					show();
					ReFresh();
				else
					s[3-id].txt=str[4][math.random(15)];
					s[3-id].action=4;
					PlayWavE(36);
					dechp(3-id,300+atk[id]);
				end
			end
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh(n);
		end
		if s[3-id].x>s[id].x then
			if flag then
				s[id].x=s[3-id].x-size;
				s[3-id].x=s[3-id].x+size;
			else
				s[id].x=s[3-id].x;
				JY.ReFreshTime=lib.GetTime();
				show();
				PlayWavE(s[id].movewav);
				ReFresh();
				s[id].x=s[id].x+size;
			end
		else
			if flag then
				s[id].x=s[3-id].x+size;
				s[3-id].x=s[3-id].x-size;
			else
				s[id].x=s[3-id].x;
				JY.ReFreshTime=lib.GetTime();
				show();
				PlayWavE(s[id].movewav);
				ReFresh();
				s[id].x=s[id].x-size;
			end
		end
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(n);
		s[3-id].effect=0;
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(n*3);
		s[1].action=0;
		s[2].action=0;
		s[1].frame=0;
		s[2].frame=0;
		s[1].effect=0;
		s[2].effect=0;
	end
	local function atk_aq(id,gd)--暗器偷袭 gd表示格挡几率
		local n=3;
		s[id].action=2;
		local flag1,flag2=0,false;
		if math.random(5)==1 then
			flag1=1;
		end
		if ID[id]==170	then	--黄忠
			if flag1==0 then
				if math.random(4)==1 then
					flag1=1;
				end
			end
			gd=gd/2;
		end
		for i=0,3 do
			s[id].frame=i;
			if i==0 then
				PlayWavE(6);
				s[id].txt="嘿嘿嘿*你躲得过这一箭吗！";
				JY.ReFreshTime=lib.GetTime();
				show();
				ReFresh(4);
				if flag1==1 then
					PlayWavE(33);
					for t=8,192,8 do
						s[id].effect=t;
						JY.ReFreshTime=lib.GetTime();
						show();
						ReFresh();
						lib.GetKey();
					end
				end
				s[id].effect=0;
				PlayWavE(37);
			end
			if i==3 then
				if math.random(100)<gd then
					flag2=true;
					s[3-id].action=3;
					PlayWavE(30+flag1);
					dechp(3-id,atk[id]*(1+flag1),true);
					JY.ReFreshTime=lib.GetTime();
					show();
					ReFresh();
				else
					flag2=false
					s[3-id].action=4;
					PlayWavE(35+flag1);
					dechp(3-id,(atk[id]+10)*(1+flag1));
					atk[3-id]=atk[3-id]-1;
				end
			end
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh(n);
		end
		if flag2 then
			s[3-id].txt="雕虫小技！";
		else
			s[3-id].txt="卑鄙！";
			card_num[3-id]=card_num[3-id]-1;
		end
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(n*2);
		s[1].action=0;
		s[2].action=0;
		s[1].frame=0;
		s[2].frame=0;
		s[1].effect=0;
		s[2].effect=0;
	end
	local function atk_dz(id)--普通攻击 仅动作
		local n=3;
		s[id].action=2;
		for i=0,3 do
			s[id].frame=i;
			if i==3 then
				PlayWavE(7);
			end
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh();
		end
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(n);
		s[1].action=0;
		s[2].action=0;
		s[1].frame=0;
		s[2].frame=0;
		s[1].effect=0;
		s[2].effect=0;
	end
	local function atk_dl(id)--底力 仅动作
		s[id].txt="可恶啊！！*我要宰了你！！！";
		atk_dz(id);
		JY.ReFreshTime=lib.GetTime();
		ReFresh(4);
		s[id].action=2;
		for t=1,3 do
			for i=0,3 do
				s[id].frame=i;
				if i==3 then
					PlayWavE(7);
				end
				JY.ReFreshTime=lib.GetTime();
				show();
				ReFresh();
				lib.GetKey();
			end
		end
	end
	local function atk_jj(id)	--急救
		--loser
		s[id].txt="呼~好厉害~";
		PlayWavE(8);
		s[id].action=5;
		for i=1,10 do
			s[id].frame=i%2;
			if i==5 then
				PlayWavE(8);
			end
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh(8);
		end
		s[id].txt="还好我还有豆*赶紧吃一颗吧．";
		PlayWavE(41);
		for t=8,255,8 do
			s[id].effect=t;
			hp[id]=hp[id]+1;
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh();
			lib.GetKey();
		end
		s[id].action=0;
		s[id].frame=0;
		s[id].effect=0;
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(6);
		
		s[1].action=0;
		s[2].action=0;
		s[1].frame=0;
		s[2].frame=0;
		s[1].effect=0;
		s[2].effect=0;
	end
	local function atk_s0(id,gd)--普通攻击 gd表示格挡几率
		local n=3;
		s[id].action=2;
		for i=0,3 do
			s[id].frame=i;
			if i==3 then
				if math.random(100)<gd then
					s[3-id].action=3;
					PlayWavE(30);
					dechp(3-id,atk[id]/2,true);
					JY.ReFreshTime=lib.GetTime();
					show();
					ReFresh();
				else
					s[3-id].action=4;
					PlayWavE(35);
					dechp(3-id,atk[id]);
				end
			end
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh(n);
		end
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(n*2);
		s[1].action=0;
		s[2].action=0;
		s[1].frame=0;
		s[2].frame=0;
		s[1].effect=0;
		s[2].effect=0;
	end
	local function atk_s1(id,gd)--小暴击 gd表示格挡几率
		local n=3;
		s[id].action=2;
		local m=24;
		s[id].txt=str[2][math.random(10)];
		PlayWavE(6);
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(4);
		for i=0,3 do
			s[id].frame=i;
			if i==0 then
				PlayWavE(33);
				for t=8,192,8 do
					s[id].effect=t;
					JY.ReFreshTime=lib.GetTime();
					show();
					ReFresh();
				end
				s[id].effect=0;
			end
			if i==3 then
				if math.random(100)<gd then
					s[3-id].txt=str[5][math.random(15)];
					m=12;
					s[3-id].action=3;
					PlayWavE(31);
					s[3-id].effect=192;
					dechp(3-id,1+atk[id]/2,true);
				else
					s[3-id].txt=str[4][math.random(15)];
					s[3-id].action=4;
					PlayWavE(36);
					dechp(3-id,5+atk[id]*1.5);
				end
			end
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh(n);
		end
		if s[3-id].x>s[id].x then
			s[3-id].x=s[3-id].x+m;
		else
			s[3-id].x=s[3-id].x-m;
		end
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(n);
		s[3-id].effect=0;
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(n*2);
		s[1].action=0;
		s[2].action=0;
		s[1].frame=0;
		s[2].frame=0;
		s[1].effect=0;
		s[2].effect=0;
	end
	local function atk_s2(id,gd)--三连击 gd表示格挡几率
		local n=3;
		local flag=true;
		s[id].txt=str[2][math.random(10)];
		PlayWavE(6);
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(4);
		PlayWavE(39);
		for t=8,96,8 do
			s[id].effect=t;
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh();
		end
		s[id].effect=0;
		s[id].action=2;
		for t=1,3 do
			for i=0,3 do
				s[id].frame=i;
				if i==3 then
					if flag and math.random(100)<gd+t*7 then
						s[3-id].action=3;
						PlayWavE(30);
						dechp(3-id,1,true);
						JY.ReFreshTime=lib.GetTime();
						show();
						ReFresh();
					else
						flag=false;
						s[3-id].action=4;
						PlayWavE(35);
						dechp(3-id,1+atk[id]/2);
					end
				end
				JY.ReFreshTime=lib.GetTime();
				show();
				ReFresh(2);
			end
			if t==1 then
				JY.ReFreshTime=lib.GetTime();
				ReFresh(4);
			end
		end
		if flag then
			s[3-id].txt=str[5][math.random(15)];
		else
			s[3-id].txt=str[4][math.random(15)];
		end
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(n*2);
		s[1].action=0;
		s[2].action=0;
		s[1].frame=0;
		s[2].frame=0;
		s[1].effect=0;
		s[2].effect=0;
	end
	local function atk_s3(id,gd)--大暴击 gd表示格挡几率
		local n=3;
		s[id].action=2;
		local flag=false;
		s[id].txt=str[3][math.random(15)];
		PlayWavE(6);
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(4);
		for i=0,3 do
			s[id].frame=i;
			if i==0 then
				PlayWavE(33);
				for t=24,240,6 do
					s[id].effect=t;
					JY.ReFreshTime=lib.GetTime();
					show();
					ReFresh();
				end
			end
			if i==3 then
				if math.random(100)<gd then
					s[3-id].txt=str[5][math.random(15)];
					flag=true;
					s[3-id].action=3;
					PlayWavE(31);
					dechp(3-id,2+atk[id],true);
					s[3-id].effect=208;
					JY.ReFreshTime=lib.GetTime();
					show();
					ReFresh();
				else
					s[3-id].txt=str[4][math.random(15)];
					s[3-id].action=4;
					PlayWavE(36);
					dechp(3-id,15+atk[id]*2.5);
				end
			end
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh(n);
		end
		if s[3-id].x>s[id].x then
			if flag or s[3-id].x>672-size*2 then
				s[3-id].x=s[3-id].x+size/2;
			else
				s[id].x=s[3-id].x;
				JY.ReFreshTime=lib.GetTime();
				show();
				PlayWavE(s[id].movewav);
				ReFresh();
				s[id].x=s[id].x+size;
			end
		else
			if flag or s[3-id].x<size*2 then
				s[3-id].x=s[3-id].x-size/2;
			else
				s[id].x=s[3-id].x;
				JY.ReFreshTime=lib.GetTime();
				show();
				PlayWavE(s[id].movewav);
				ReFresh();
				s[id].x=s[id].x-size;
			end
		end
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(n);
		s[3-id].effect=0;
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(n*3);
		s[1].action=0;
		s[2].action=0;
		s[1].frame=0;
		s[2].frame=0;
		s[1].effect=0;
		s[2].effect=0;
	end
	local function atk_s4(id,gd)--五连击 gd表示格挡几率
		local n=3;
		local flag=true;
		s[id].txt=str[3][math.random(15)];
		PlayWavE(6);
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(4);
		PlayWavE(39);
		for t=8,128,8 do
			s[id].effect=t;
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh();
		end
		s[id].action=2;
		for t=1,5 do
			for i=0,3 do
				s[id].frame=i;
				if i==3 then
					if flag and math.random(100)<gd+t*7 then
						s[3-id].action=3;
						PlayWavE(30);
						dechp(3-id,1,true);
						JY.ReFreshTime=lib.GetTime();
						show();
						ReFresh();
					else
						flag=false;
						s[3-id].action=4;
						PlayWavE(35);
						dechp(3-id,2+atk[id]/2);
					end
				end
				JY.ReFreshTime=lib.GetTime();
				show();
				ReFresh(1);
				if t%2==0 then
					JY.ReFreshTime=lib.GetTime();
					ReFresh(1);
				end
			end
		end
		if flag then
			s[3-id].txt=str[5][math.random(15)];
		else
			s[3-id].txt=str[4][math.random(15)];
		end
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(n*3);
		s[1].action=0;
		s[2].action=0;
		s[1].frame=0;
		s[2].frame=0;
		s[1].effect=0;
		s[2].effect=0;
	end
	local function atk_s5(id,gd)--回马枪 gd表示格挡几率
		local n=3;
		local m=size/2;
		s[id].action=2;
		local flag=false;
		s[id].txt=str[3][math.random(15)];
		PlayWavE(6);
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(4);
		for i=0,3 do
			s[id].frame=i;
			if i==3 then
				if math.random(100)<gd then
					flag=true;
					s[3-id].action=3;
					PlayWavE(30);
					dechp(3-id,2,true);
					JY.ReFreshTime=lib.GetTime();
					show();
					ReFresh();
				else
					s[3-id].action=4;
					PlayWavE(35);
					dechp(3-id,2+atk[id]);
				end
			end
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh(2);
		end
		if s[id].x<s[3-id].x then
			s[id].x=s[3-id].x;
			JY.ReFreshTime=lib.GetTime();
			show();
			PlayWavE(s[id].movewav);
			ReFresh();
			s[id].x=s[id].x+size;
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh();
			turn(id,2);
		else
			s[id].x=s[3-id].x;
			JY.ReFreshTime=lib.GetTime();
			show();
			PlayWavE(s[id].movewav);
			ReFresh();
			s[id].x=s[id].x-size;
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh();
			turn(id,3);
		end
		s[id].action=2;
		for i=0,3 do
			s[id].frame=i;
			if i==0 then
				PlayWavE(33);
				for t=8,240,8 do
					s[id].effect=t;
					JY.ReFreshTime=lib.GetTime();
					show();
					ReFresh();
				end
				s[id].effect=0;
			end
			if i==3 then
				if s[id].x>s[3-id].x then
					s[3-id].d=3;
				else
					s[3-id].d=2;
				end
				if flag and math.random(100)<gd+10 then
					s[3-id].txt=str[5][math.random(15)];
					m=size/4;
					s[3-id].action=3;
					PlayWavE(31);
					s[3-id].effect=192;
					JY.ReFreshTime=lib.GetTime();
					show();
					ReFresh();
					dechp(3-id,2+atk[id]/2,true);
				else
					s[3-id].txt=str[4][math.random(15)];
					s[3-id].action=4;
					PlayWavE(36);
					dechp(3-id,15+atk[id]*1.5);
				end
			end
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh(n);
		end
		if s[3-id].x>s[id].x then
			if s[id].x<size then
				m=size;
			end
			s[3-id].x=s[3-id].x+m;
		else
			if s[id].x>672-size then
				m=size;
			end
			s[3-id].x=s[3-id].x-m;
		end
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(n);
		s[3-id].effect=0;
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(n*3);
		s[1].action=0;
		s[2].action=0;
		s[1].frame=0;
		s[2].frame=0;
		s[1].effect=0;
		s[2].effect=0;
	end
	local function atk_s6(id,gd)--暴击极 gd表示格挡几率
		local n=3;
		local m=36;
		s[id].action=2;
		local flag=false;
		s[id].txt=str[3][math.random(15)];
		PlayWavE(6);
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(4);
		for i=0,3 do
			s[id].frame=i;
			if i==0 then
				PlayWavE(33);
				for t=8,240,8 do
					s[id].effect=t;
					JY.ReFreshTime=lib.GetTime();
					show();
					ReFresh();
				end
			end
			if i==3 then
				if math.random(100)<gd then
					flag=true;
					m=24;
					s[3-id].action=3;
					PlayWavE(31);
					dechp(3-id,atk[id]-2,true);
					JY.ReFreshTime=lib.GetTime();
					show();
					ReFresh();
				else
					s[3-id].action=4;
					PlayWavE(36);
					dechp(3-id,5+atk[id]*1.5);
				end
			end
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh(2);
		end
		if s[3-id].x>s[id].x then
			if s[id].x<672-size*2 then
				s[3-id].x=s[3-id].x+m;
			end
		else
			if s[id].x>size*2 then
				s[3-id].x=s[3-id].x-m;
			end
		end
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(n);
		s[3-id].effect=0;
		s[id].action=2;
		for i=0,3 do
			s[id].frame=i;
			if i==3 then
				if s[3-id].x>s[id].x then
					s[id].x=s[3-id].x-size;
				else
					s[id].x=s[3-id].x+size;
				end
				PlayWavE(s[id].movewav);
				if flag and math.random(100)<gd-10 then
					s[3-id].txt=str[5][math.random(15)];
					s[3-id].action=3;
					if s[id].x>s[3-id].x then
						s[3-id].d=3;
					else
						s[3-id].d=2;
					end
					PlayWavE(31);
					s[3-id].effect=192;
					JY.ReFreshTime=lib.GetTime();
					show();
					ReFresh();
					dechp(3-id,atk[id],true);
				else
					s[3-id].txt=str[4][math.random(15)];
					s[3-id].action=4;
					PlayWavE(36);
					dechp(3-id,20+atk[id]*2);
				end
			end
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh(2);
		end
		s[3-id].effect=0;
		if s[id].x<s[3-id].x then
			if s[3-id].x>672-size*2 then
				s[3-id].x=s[3-id].x+size/2;
				JY.ReFreshTime=lib.GetTime();
				show();
				ReFresh();
				s[3-id].x=s[3-id].x+size/4;
				JY.ReFreshTime=lib.GetTime();
				show();
				ReFresh();
			else
				s[id].x=s[3-id].x;
				JY.ReFreshTime=lib.GetTime();
				show();
				ReFresh();
				s[id].x=s[id].x+size/2;
				JY.ReFreshTime=lib.GetTime();
				show();
				ReFresh();
				s[id].x=s[id].x+size/2;
				JY.ReFreshTime=lib.GetTime();
				show();
				ReFresh();
			end
		else
			if s[3-id].x<size*2 then
				s[3-id].x=s[3-id].x-size/2;
				JY.ReFreshTime=lib.GetTime();
				show();
				ReFresh();
				s[3-id].x=s[3-id].x-size/4;
				JY.ReFreshTime=lib.GetTime();
				show();
				ReFresh();
			else
				s[id].x=s[3-id].x;
				JY.ReFreshTime=lib.GetTime();
				show();
				ReFresh();
				s[id].x=s[id].x-size/2;
				JY.ReFreshTime=lib.GetTime();
				show();
				ReFresh();
				s[id].x=s[id].x-size/2;
				JY.ReFreshTime=lib.GetTime();
				show();
				ReFresh();
			end
		end
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(n);
		s[3-id].effect=0;
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(n*3);
		s[1].action=0;
		s[2].action=0;
		s[1].frame=0;
		s[2].frame=0;
		s[1].effect=0;
		s[2].effect=0;
	end
	local function atk_s7(id,gd)--连击极 gd表示格挡几率
		local n=3;
		local m=24;
		local lianji=6;
		local flag=true;
		
		if s[id].x<s[3-id].x then
			if s[id].x<size*2 then
				lianji=7;
			end
		else
			if s[id].x>672-size*2 then
				lianji=7;
			end
		end
		
		s[id].action=2;
		s[id].txt=str[3][math.random(15)];
		PlayWavE(6);
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(4);
		PlayWavE(39);
		for t=8,192,8 do
			s[id].effect=t;
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh();
		end
		for count=1,lianji do--7 do
			for i=0,3 do
				s[id].frame=i;
				if i==3 then
					if s[id].x>s[3-id].x then
						s[3-id].d=3;
					else
						s[3-id].d=2;
					end
					if flag and math.random(100)<gd+count*7 then
						s[3-id].action=3;
						PlayWavE(30);
						dechp(3-id,2,true);
						JY.ReFreshTime=lib.GetTime();
						show();
						ReFresh();
					else
						flag=false;
						s[3-id].action=4;
						PlayWavE(35);
						dechp(3-id,3+atk[id]/2);
					end
				end
				JY.ReFreshTime=lib.GetTime();
				show();
				ReFresh(1);
			end
			if s[id].x<s[3-id].x then
				s[id].x=s[3-id].x;
				JY.ReFreshTime=lib.GetTime();
				show();
				PlayWavE(s[id].movewav);
				ReFresh();
				s[id].x=s[id].x+size;
				JY.ReFreshTime=lib.GetTime();
				show();
				ReFresh();
				s[id].d=2;
			else
				s[id].x=s[3-id].x;
				JY.ReFreshTime=lib.GetTime();
				show();
				PlayWavE(s[id].movewav);
				ReFresh();
				s[id].x=s[id].x-size;
				JY.ReFreshTime=lib.GetTime();
				show();
				ReFresh();
				s[id].d=3;
			end
		end
		if flag then
			s[3-id].txt=str[5][math.random(15)];
		else
			s[3-id].txt=str[4][math.random(15)];
		end
		s[3-id].effect=0;
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(n*3);
		s[1].action=0;
		s[2].action=0;
		s[1].frame=0;
		s[2].frame=0;
		s[1].effect=0;
		s[2].effect=0;
	end	
	local function atk_s8(id,gd)--秘技 gd表示格挡几率
		local n=3;
		local flag=true;
		s[id].txt=str[3][math.random(15)];
		PlayWavE(6);
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(4);
		PlayWavE(39);
		for t=8,128,8 do
			s[id].effect=t;
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh();
		end
		s[id].action=2;
		for t=1,7 do
			for i=0,3 do
				s[id].frame=i;
				if i==3 then
					if math.random(100)<gd then
						s[3-id].action=3;
						PlayWavE(30);
						dechp(3-id,2,true);
						JY.ReFreshTime=lib.GetTime();
						show();
						ReFresh();
					else
						flag=false;
						s[3-id].action=4;
						PlayWavE(35);
						dechp(3-id,4);
					end
				end
				JY.ReFreshTime=lib.GetTime();
				show();
				ReFresh(1);
			end
		end
		
		for i=0,3 do
			s[id].frame=i;
			if i==0 then
				PlayWavE(33);
				for t=128,248,8 do
					s[id].effect=t;
					JY.ReFreshTime=lib.GetTime();
					show();
					ReFresh();
				end
			end
			if i==3 then
				if flag and math.random(100)<gd then
					s[3-id].txt=str[5][math.random(15)];
					flag=true;
					s[3-id].action=3;
					PlayWavE(31);
					dechp(3-id,atk[id],true);
					s[3-id].effect=208;
					JY.ReFreshTime=lib.GetTime();
					show();
					ReFresh();
				else
					s[3-id].txt=str[4][math.random(15)];
					s[3-id].action=4;
					PlayWavE(36);
					dechp(3-id,40+atk[id]);
				end
			end
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh(n);
		end
		if s[3-id].x>s[id].x then
			if flag or s[3-id].x>672-size*2 then
				s[3-id].x=s[3-id].x+size/2;
			else
				s[id].x=s[3-id].x;
				JY.ReFreshTime=lib.GetTime();
				show();
				PlayWavE(s[id].movewav);
				ReFresh();
				s[id].x=s[id].x+size/2;
				JY.ReFreshTime=lib.GetTime();
				show();
				ReFresh();
				s[id].x=s[id].x+size/2;
			end
		else
			if flag or s[3-id].x<size*2 then
				s[3-id].x=s[3-id].x+-size/2;
			else
				s[id].x=s[3-id].x;
				JY.ReFreshTime=lib.GetTime();
				show();
				PlayWavE(s[id].movewav);
				ReFresh();
				s[id].x=s[id].x-size/2;
				JY.ReFreshTime=lib.GetTime();
				show();
				ReFresh();
				s[id].x=s[id].x-size/2;
			end
		end
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(n);
		s[3-id].effect=0;
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(n*3);
		s[1].action=0;
		s[2].action=0;
		s[1].frame=0;
		s[2].frame=0;
		s[1].effect=0;
		s[2].effect=0;
	end	
	local function win(id)
		--loser
		local eid=3-id;
		s[eid].txt=str[6][math.random(15)];
		PlayWavE(38);
		s[eid].action=5;
		for i=1,4 do
			if s[eid].action==9 then
				s[eid].action=5;
			else
				s[eid].action=9;
			end
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh(3);
		end
		for i=16,128,16 do
			s[eid].effect=i
			if s[eid].action==9 then
				s[eid].action=5;
			else
				s[eid].action=9;
			end
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh(4);
		end
		PlayWavE(22);
		s[eid].losser=true;
		s[eid].action=5;
		for i=128,256,16 do
			s[eid].effect=i
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh(2);
		end
		JY.ReFreshTime=lib.GetTime();
		ReFresh(4);
		s[eid].action=9;
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(20);
		--winer
		s[id].action=0;
		s[id].d=0;
		s[id].txt=str[7][math.random(10)];
		PlayWavE(6);
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(25);
		s[id].action=6;
		JY.ReFreshTime=lib.GetTime();
		show();
		PlayWavE(8);
		ReFresh(12);
		PlayWavE(5);
		JY.ReFreshTime=lib.GetTime();
		show();
		ReFresh(25);
		if hp[id]==hpmax[id] then
			DrawStringEnhance(CC.ScreenW/2,210,JY.Person[ID[id]]["名称"].." 完胜",C_WHITE,48,0.5)
		else
			DrawStringEnhance(CC.ScreenW/2,210,JY.Person[ID[id]]["名称"].." 胜",C_WHITE,48,0.5)
		end
		for t=1,10 do
			JY.ReFreshTime=lib.GetTime();
			ReFresh();
			lib.GetKey();
		end
	end
	local function card_ini(idx)
		card[idx]={};
		for i=1,card_num[idx] do
			card[idx][i]=math.random(9);
		end
	end
	local function card_sort(idx)
		for i=1,card_num[idx]-1 do
			for j=i+1,card_num[idx] do
				if card[idx][i]>card[idx][j] then
					card[idx][i],card[idx][j]=card[idx][j],card[idx][i];
				end
			end
		end
	end
	local function card_value(id,n1,n2,n3)
		local pid=ID[id];
		local wl=JY.Person[pid]["武力"];
		local offset=0--math.max(math.modf(wl/2)-41,0);
		offset=math.max(wl/2-41,0);
		local v=0;
		local k=0;	--0普通攻击 1小暴击 2三连击 3大暴击 4五连击
		--关羽:鬼胡斩,金刚罗煞斩 ==>关平,关索,关兴也会  
		--张飞:烈袭旋风击牙,蛟天舞 ==>张苞也会  
		--赵云:暴龙,飞鹰 ==>赵统,赵广也会  
		--马超:马家之奥义  
		--甘宁:大海之蛟龙
		--specil	444
		--mp[id]=100--无限mp
		if wl>=100 and mp[id]>=99 and n1==4 and n2==4 and n3==4 then
			return 65,9;
		end
		--奥义1		七连击，接暴击穿人	1	111
		if JY.Person[pid]["单挑"]>=9 and mp[id]>=60 and n1==1 and n2==1 and n3==1 then
			return 60+offset,8;
		end
		--222
		if RND(0.5) and JY.Person[pid]["单挑"]>=8 and mp[id]>=60 and n1==2 and n2==2 and n3==2 then
			return 58+offset,8;
		end
		--连击·极	左右来回连击	1	378
		if RND(-5/3+JY.Person[pid]["单挑"]/3) and mp[id]>=55 and n1==3 and n2==7 and n3==8 then
			return 55+offset,7;
		end
		--暴击·极	先回退，然后暴击穿人	1	159
		if RND(-5/3+JY.Person[pid]["单挑"]/3) and  mp[id]>=55 and n1==1 and n2==5 and n3==9 then
			return 55+offset,6;
		end
		--回马枪 普通穿人，接暴击	3	557/567/577
		if RND(-4/3+JY.Person[pid]["单挑"]/3) and mp[id]>=50 and n1==5 and n3==7 then
			return 50+offset,5;
		end
		--个人强化	258
		if mp[id]>=40 and n1==2 and n2==5 and (n3==8 or n3==9) then
			if pid==381 then	--赵云
				return 45+offset,7;	--连击极
			elseif pid==499 then	--马超
				return 45+offset,5;	--回马
			elseif pid==95 then	--关羽
				return 45+offset,99;	--一击
			elseif pid==419 then	--张飞
				return 45+offset,6;	--暴击极
			elseif pid==636 then	--吕布
				return 45+offset,8;	--奥义1
			end
		end
		--五连击	3		334/345/356
		if RND(-1.0+JY.Person[pid]["单挑"]/3) and mp[id]>=45 and n1==3 and n3<7 and n2+1==n3 then
			return 40+offset,4;
		end
		--大暴击 暴击穿人	4	266/277/288/299
		if RND(-1.0+JY.Person[pid]["单挑"]/3) and mp[id]>=45 and n1==2 and n2>5 and n2==n3 then
			return 40+offset,3;
		end
		--三连 三连击	7-1		123/234/345/456/567/678/789
		if RND(0.1+JY.Person[pid]["单挑"]/3) and mp[id]>=40 and n1+1==n2 and n2+1==n3 then
			return 30+offset,2;
		end
		--三条 小暴击	9-1-1	111/222/333/444/555/666/777/888/999
		if RND(0.1+JY.Person[pid]["单挑"]/3) and mp[id]>=40 and n1==n2 and n2==n3 then
			return 30+offset,1;
		end
		--other
		return n1+n2+n3,0;
	end
	local function card_remove(id,t1,t2,t3)
		for i=1,card_num[id] do
			if card[id][i]==t1 then
				table.remove(card[id],i);
				break;
			end
		end
		for i=1,card_num[id]-1 do
			if card[id][i]==t2 then
				table.remove(card[id],i);
				break;
			end
		end
		for i=1,card_num[id]-2 do
			if card[id][i]==t3 then
				table.remove(card[id],i);
				break;
			end
		end
		table.remove(card[id],1);
		for i=card_num[id]-3,card_num[id] do
			card[id][i]=math.random(9);
		end
	end
	local function card_ai(id)
		local t1,t2,t3;
		local vmax=0;
		local kind;
		--local s="card: "
		--card_ini(id);
		card_sort(id);
		--for i=1,card_num[id] do
		--	s=s..card[id][i]..',';
		--end
		--lib.Debug(s);
		 
		for i=1,card_num[id]-2 do
			for j=i+1,card_num[id]-1 do
				for k=j+1,card_num[id] do
					local v1,v2=card_value(id,card[id][i],card[id][j],card[id][k]);
					if v1>vmax then
						vmax=v1;
						kind=v2;
						t1,t2,t3=card[id][i],card[id][j],card[id][k];
					end
				end
			end
		end
		card_remove(id,t1,t2,t3);
		return vmax,kind--,t1,t2,t3;
	end
	--
	card_ini(1);
	card_ini(2);
	--card_sort(1);
	--card_sort(2);
	local action_v={};
	local action_k={};
	local function automove() --人物接近，自动向屏幕中心移动
		local cx=(CC.ScreenW-size)/2;
		local cur=1;
		if math.abs(s[1].x-cx)<math.abs(s[2].x-cx) then
			cur=2;
		end
		if math.abs(s[cur].x-s[3-cur].x)>size then
			if s[cur].x>s[3-cur].x then
				move(cur,s[3-cur].x+size);
			else
				move(cur,s[3-cur].x-size);
			end
		end
	end
	local function arrive(id)
		s[id].action=0;
		PlayWavE(5);
		for i=256,0,-4 do
			s[id].effect=i;
			JY.ReFreshTime=lib.GetTime();
			show();
			ReFresh();
		end
	end
	show();
	Light();
	PlayWavE(4);
	arrive(1);
	local talkid=math.random(15);
	s[1].txt=string.format(str[1][talkid*2-1],p1["外号"]);
	s[1].d=3;
	PlayWavE(6);
	JY.ReFreshTime=lib.GetTime();
	show();
	ReFresh(25);
	arrive(2);
	s[2].txt=string.format(str[1][talkid*2],p2["外号"]);
	s[2].d=2;
	PlayWavE(6);
	JY.ReFreshTime=lib.GetTime();
	show();
	ReFresh(25);
	--atk_ms(1,100)
	local msflag=false;
	for i=1,2 do
		local pid=ID[i];
		local eid=ID[3-i];
		if JY.Person[pid]["一击"]>0 and JY.Person[pid]["武力"]-JY.Person[eid]["武力"]>=5 and math.random(100)<=25 then
			atk_ms(i,JY.Person[eid]["武力"]-65);
			mp[i]=0;
			msflag=true;
			if hp[1]==0 then
				win(2);
				return 2;
			elseif hp[2]==0 then
				win(1);
				return 1;
			end
			break;
		end
	end
	if not msflag then
		for i=1,2 do
			local pid=ID[i];
			local eid=ID[3-i];
			if JY.Person[pid]["暗器"]>0 and math.random(10)<=5 then
				atk_aq(i,JY.Person[eid]["武力"]-30);
				break;
			end
		end
		move2((CC.ScreenW-size)/2,(CC.ScreenW+size)/2);
	else
		automove();
	end
	while true do
		local cur=1;
		for i=1,2 do
			--admp(i,s[i].mpadd);
			action_v[i],action_k[i]=card_ai(i);
		end
		automove();
		if math.abs(action_v[1]-action_v[2])<=1 then
			atk_p(1,action_v[1]+action_v[2])
		else
			if action_v[1]>action_v[2] then
				cur=1;
			else
				cur=2;
			end
			automove();
			--[[if math.abs(s[cur].x-s[3-cur].x)>size then
				if s[cur].x>s[3-cur].x then
					move(cur,s[3-cur].x+size);
				else
					move(cur,s[3-cur].x-size);
				end
			end]]--
			local gd=s[3-cur].lq/3+20*action_v[3-cur]/action_v[cur];
			if action_k[cur]==0 then
				atk_s0(cur,gd);
			elseif action_k[cur]==1 then
				atk_s1(cur,gd);
			elseif action_k[cur]==2 then
				atk_s2(cur,gd);
			elseif action_k[cur]==3 then
				atk_s3(cur,gd);
			elseif action_k[cur]==4 then
				atk_s4(cur,gd);
			elseif action_k[cur]==5 then
				atk_s5(cur,gd);
			elseif action_k[cur]==6 then
				atk_s6(cur,gd);
			elseif action_k[cur]==7 then
				atk_s7(cur,gd);
			elseif action_k[cur]==8 then
				atk_s8(cur,gd);
			elseif action_k[cur]==9 then
				atk_s8(cur,5);
			elseif action_k[cur]==99 then
				atk_ms(cur,JY.Person[ID[3-cur]]["武力"]-60);
			else
				atk_s0(cur,gd);
			end
			if action_k[cur]~=0 then
				admp(cur,-math.modf(action_v[cur]/10)*8);		--攻击者消耗mp
			end
			if action_k[3-cur]~=0 then
				--admp(3-cur,-math.modf(action_v[3-cur]/10)*5); --防御者不消耗mp
			end
		end
		if hp[1]==0 then
			win(2);
			return 2;
		elseif hp[2]==0 then
			win(1);
			return 1;
		end
		if s[1].x>s[2].x then
			turn(1,2);
			turn(2,3);
		else
			turn(1,3);
			turn(2,2);
		end
		--急救
		if hp[3-cur]<hpmax[3-cur]/2 and s[3-cur].jj>0 and math.random(100)<=20 then
			s[3-cur].jj=0;
			atk_jj(3-cur);
		end
		--底力
		if hp[3-cur]<hpmax[3-cur]/3 and s[3-cur].dl>0 and RND((s[3-cur].wl-70)/200) then
			s[3-cur].dl=0;
			atk_dl(3-cur);
			card_num[3-cur]=card_num[3-cur]+1;
			card[3-cur][card_num[3-cur]]=math.random(9);
			admp(3-cur,100);
		end
		JY.ReFreshTime=lib.GetTime();
		show();
		for i=1,2 do
			admp(i,s[i].mpadd);
			--action_v[i],action_k[i]=card_ai(i);
		end
		ReFresh(4);
	end
end


---===========================================---

function Five()
	--const
	local grid=15;
	local cel=math.modf(grid/2);
	local g_size=36;
	local qz_size=15;
	local grid_size=g_size*(grid-1);
	local gx,gy=(CC.ScreenW-grid_size)/2,(CC.ScreenH-grid_size)/2;
	local map_size=g_size*(grid+0.2);
	local mx,my=(CC.ScreenW-map_size)/2,(CC.ScreenH-map_size)/2;
	local bgc=RGB(220,178,92);
	local s_hb={"执黑","执白"};
	local s_xy={"寒星","溪月","疏星","花月","残月","雨月","金星","松月","丘月","新月","瑞星","山月","游星",
				"长星","峡月","恒星","水月","流星","云月","浦月","岚月","银月","明星","斜月","名月","彗星",
				"","","","","","","","","","","","","","","","","","","","","","","","",""};
	--map info
	local map={};
	local function new_map()
		map={};
		for i=1,grid^2 do
			map[i]=0;
		end
	end
	local function get(x,y)
		if between(x,0,grid-1) and between(y,0,grid-1) then
			return map[grid*y+x+1];
		end
	end
	local function set(x,y,v)
		map[grid*y+x+1]=v;
	end
	local eid=0;
	local eid_lv=0;
	local eid_ad=1;
	local gamecount=0;
	local wincount,losecount=0,0;
	local gameresult=0;
	local turn=1;
	local current=1;
	local c_mode={0,1};	--0 human, 1 AI
	local minx,maxx,miny,maxy=cel,cel,cel,cel;
	local lastx,lasty,lastcolor=-1,-1,0;
	local qx1,qy1,qx2,qy2,qx3,qy3;
	local s_type=0;
	--UI
	local bt={};
	table.insert(bt,button_creat(1,1,CC.ScreenW-200,CC.ScreenH-80,"退出",true,true));
	
	local function redraw()
		DrawGame();
		--LoadPicEnhance(73,mx-64*4,my-32,map_size+64*8,map_size+32*2);
		LoadPicEnhance(73,0,my-16,CC.ScreenW,map_size+16*2);
		lib.FillColor(mx,my,mx+map_size,my+map_size,bgc);
		lib.DrawRect(mx,my,mx+map_size,my,C_WHITE);
		lib.DrawRect(mx,my,mx,my+map_size,C_WHITE);
		lib.DrawRect(mx,my+map_size,mx+map_size,my+map_size,C_BLACK);
		lib.DrawRect(mx+map_size,my,mx+map_size,my+map_size,C_BLACK);
		for i=0,grid-1 do
			lib.DrawRect(gx,gy+g_size*i,gx+grid_size,gy+g_size*i,C_BLACK);
			lib.DrawRect(gx+g_size*i,gy,gx+g_size*i,gy+grid_size,C_BLACK);
		end
		lib.DrawRect(gx-1,gy-1,gx+grid_size+1,gy-1,C_BLACK);
		lib.DrawRect(gx-1,gy-1,gx-1,gy+grid_size+1,C_BLACK);
		lib.DrawRect(gx-1,gy+grid_size+1,gx+grid_size+1,gy+grid_size+1,C_BLACK);
		lib.DrawRect(gx+grid_size+1,gy-1,gx+grid_size+1,gy+grid_size+1,C_BLACK);
		lib.FillColor(gx+g_size*cel-2,gy+g_size*cel-2,gx+g_size*cel+3,gy+g_size*cel+3,C_BLACK);
		lib.FillColor(gx+g_size*3-2,gy+g_size*3-2,gx+g_size*3+3,gy+g_size*3+3,C_BLACK);
		lib.FillColor(gx+g_size*3-2,gy+g_size*(grid-4)-2,gx+g_size*3+3,gy+g_size*(grid-4)+3,C_BLACK);
		lib.FillColor(gx+g_size*(grid-4)-2,gy+g_size*3-2,gx+g_size*(grid-4)+3,gy+g_size*3+3,C_BLACK);
		lib.FillColor(gx+g_size*(grid-4)-2,gy+g_size*(grid-4)-2,gx+g_size*(grid-4)+3,gy+g_size*(grid-4)+3,C_BLACK);
		--map
		for y=0,grid-1 do
			for x=0,grid-1 do
				local r=get(x,y);
				if r==1 then
					lib.PicLoadCache(4,148*2,gx+g_size*x,gy+g_size*y);
				elseif r==2 then
					lib.PicLoadCache(4,149*2,gx+g_size*x,gy+g_size*y);
				end
			end
		end
		if lastx>=0 then
			lib.DrawRect(gx+g_size*lastx-4,gy+g_size*lasty,gx+g_size*lastx+4,gy+g_size*lasty,lastcolor);
			lib.DrawRect(gx+g_size*lastx,gy+g_size*lasty-4,gx+g_size*lastx,gy+g_size*lasty+4,lastcolor);
		end
		--Info
		local x,y=mx-150,my+g_size*1.5;
		lib.PicLoadCache(2,(JY.Person[eid]["容貌"]+2000)*2,x,y,1);					x=x-32;y=y+132;
		DrawStringEnhance(x,y,JY.Person[eid]["名称"].." "..JY.Person[eid]["字"],C_WHITE,24);		y=y+24+2;
		DrawPJ(JY.Person[eid]["品级"],x,y,C_Name,24);											y=y+24+2;
		for i,v in pairs({"统率","武力","智谋","政务","魅力"}) do
			DrawStringEnhance(x,y,v,C_Name,24);
			local pic=213;
			if JY.Person[eid][v]>=70 then
				pic=215;
			elseif JY.Person[eid][v]>=30 then
				pic=214;
			end
			lib.SetClip(x+24*2.5,y,x+24*2.5+JY.Person[eid][v]+16,y+24);
			lib.PicLoadCache(4,pic*2,x+24*2.5,y+2,1);
			lib.SetClip(0,0,0,0);
			DrawNumPic(x+24*2.5+math.max(JY.Person[eid][v],8),y+4,JY.Person[eid][v]);
			y=y+24+2;
		end
		x,y=mx+map_size+32,my+g_size/2;
		if c_mode[1]==0 then
			DrawStringEnhance(x,y,s_hb[1]..": ".."玩家",C_WHITE,24);
		else
			DrawStringEnhance(x,y,s_hb[1]..": "..JY.Person[eid]["名称"],C_WHITE,24);
		end
		y=y+24+2;
		if s_type>0 then
			LoadPicEnhance(263,x,y,100,51);
			DrawStringEnhance(x+50+1,y+11+1,s_xy[s_type],C_ORANGE,28,0.5);
			DrawStringEnhance(x+50,y+11,s_xy[s_type],M_Yellow,28,0.5);
			y=y+52;
		end
		if c_mode[2]==0 then
			DrawStringEnhance(x,y,s_hb[2]..": ".."玩家",C_WHITE,24);
		else
			DrawStringEnhance(x,y,s_hb[2]..": "..JY.Person[eid]["名称"],C_WHITE,24);
		end
		y=y+24+2;
		DrawStringEnhance(x,y,string.format("第%02d手",turn),C_WHITE,24);
		y=my+g_size/2+(24+2)*11;
		DrawStringEnhance(x,y,string.format("第%02d局",gamecount),C_WHITE,24);
		y=y+24+2;
		DrawStringEnhance(x,y,string.format("  %02d胜",wincount),C_WHITE,24);
		y=y+24+2;
		DrawStringEnhance(x,y,string.format("  %02d负",losecount),C_WHITE,24);
		y=y+24+2;
		--UI
		button_redraw(bt);
	end
	local function show(n)
		n=n or 1;
		for i=1,n do
			local t1=lib.GetTime();
			redraw();
			ShowScreen();
			local delay=CC.FrameNum-lib.GetTime()+t1;
			if delay>0 then
				lib.Delay(delay);
			end
			getkey();
		end
	end
	local function check(data,req,n)
		local t=0
		for i,v in pairs(data) do
			if v==req then
				t=t+1;
				if t>=n then
					return true;
				end
			end
		end
		return false;
	end
	local function GetValue(x,y,k)
		--判断形势
		local heng,shu,pie,la=10,10,10,10;
		--heng
		for i=1,4 do
			local v=get(x+i,y);
			if v==k then		heng=heng+10;
			elseif v==0 then	heng=heng+1;	break;
			else				break;
			end
		end
		for i=1,4 do
			local v=get(x-i,y);
			if v==k then		heng=heng+10;
			elseif v==0 then	heng=heng+1;	break;
			else				break;
			end
		end
		--shu
		for i=1,4 do
			local v=get(x,y+i);
			if v==k then		shu=shu+10;
			elseif v==0 then	shu=shu+1;	break;
			else				break;
			end
		end
		for i=1,4 do
			local v=get(x,y-i);
			if v==k then		shu=shu+10;
			elseif v==0 then	shu=shu+1;	break;
			else				break;
			end
		end
		--pie
		for i=1,4 do
			local v=get(x+i,y+i);
			if v==k then		pie=pie+10;
			elseif v==0 then	pie=pie+1;	break;
			else				break;
			end
		end
		for i=1,4 do
			local v=get(x-i,y-i);
			if v==k then		pie=pie+10;
			elseif v==0 then	pie=pie+1;	break;
			else				break;
			end
		end
		--la
		for i=1,4 do
			local v=get(x+i,y-i);
			if v==k then		la=la+10;
			elseif v==0 then	la=la+1;	break;
			else				break;
			end
		end
		for i=1,4 do
			local v=get(x-i,y+i);
			if v==k then		la=la+10;
			elseif v==0 then	la=la+1;	break;
			else				break;
			end
		end
		local Direction={heng,shu,pie,la};
		local rv;
		if math.max(heng,shu,pie,la)>=50 then	--成5, 100分
			rv=100;
		elseif check(Direction,42,1) or check(Direction,41,2) or (check(Direction,41,1) and check(Direction,32,1)) then	--活4、双死4、死4活3， 90分
			rv=80;
		elseif check(Direction,32,2) then		--双活3， 80分
			rv=75;
		elseif check(Direction,31,1) and check(Direction,32,1) then		--死3活3， 70分
			rv=40;
		elseif check(Direction,41,1) then		--死4， 60分
			rv=35;
		elseif check(Direction,32,1) then		--活3， 50分
			rv=30;
		elseif check(Direction,22,2) then		--双活2， 40分
			rv=25;
		elseif check(Direction,31,1) then		--死3， 30分
			rv=20;
		elseif check(Direction,22,1) then		--活2， 20分
			rv=15;
		elseif check(Direction,21,1) then		--死2， 10分
			rv=10;
		elseif turn==1 and x==cel and y==x then
			rv=15;
		else
			rv=0;
		end
		return rv+math.random(5);
	end
	local function XingYue()
		if qx1==qy1 and qx1==cel then	--第一子必须天元
			if (qx1==qx2 and math.abs(qy1-qy2)==1) or (qy1==qy2 and math.abs(qx1-qx2)==1) then	--直止打法
				local dx=(qx3-qx1)*(qx2-qx1);
				local dy=(qy3-qy1)*(qy2-qy1);
				local ax=math.abs(qx3-qx2);
				local ay=math.abs(qy3-qy2);
				if (dx==2 and ay==0) or (dy==2 and ax==0) then							--寒星
					s_type=1;
				elseif (dx==2 and ay==1) or (dy==2 and ax==1) then						--溪月
					s_type=2;	
				elseif (dx==2 and ay==2) or (dy==2 and ax==2) then						--疏星
					s_type=3;
				elseif (dx==1 and ay==1) or (dy==1 and ax==1) then						--花月
					s_type=4;
				elseif (dx==1 and ay==2) or (dy==1 and ax==2) then						--残月
					s_type=5;
				elseif (dx==0 and ay==1) or (dy==0 and ax==1) then						--雨月
					s_type=6;
				elseif (dx==0 and ay==2) or (dy==-1 and ax==2) then						--金星
					s_type=7;
				elseif (dx==-1 and ay==0) or (dy==-1 and ax==0) then					--松月
					s_type=8;
				elseif (dx==-1 and ay==1) or (dy==-1 and ax==1) then					--丘月
					s_type=9;
				elseif (dx==-1 and ay==2) or (dy==-1 and ax==2) then					--新月
					s_type=10;
				elseif (dx==-2 and ay==0) or (dy==-2 and ax==0) then					--瑞星
					s_type=11;
				elseif (dx==-2 and ay==1) or (dy==-2 and ax==1) then					--山月
					s_type=12;
				elseif (dx==-2 and ay==2) or (dy==-2 and ax==2) then					--游星
					s_type=13;
				end
			elseif math.abs(qx1-qx2)==1 and math.abs(qy1-qy2)==1 then						--斜止打法
				local dx=(qx3-qx1)*(qx2-qx1);
				local dy=(qy3-qy1)*(qy2-qy1);
				if dx==2 and dy==2 then													--长星
					s_type=14;
				elseif (dx==2 and dy==1) or (dy==2 and dx==1) then						--峡月
					s_type=15;
				elseif (dx==2 and dy==0) or (dy==2 and dx==0) then						--恒星
					s_type=16;
				elseif (dx==2 and dy==-1) or (dy==2 and dx==-1) then					--水月
					s_type=17;
				elseif (dx==2 and dy==-2) or (dy==2 and dx==-2) then					--流星
					s_type=18;
				elseif (dx==1 and dy==0) or (dy==1 and dx==0) then						--云月
					s_type=19;
				elseif (dx==1 and dy==-1) or (dy==1 and dx==-1) then					--浦月
					s_type=20;
				elseif (dx==1 and dy==-2) or (dy==1 and dx==-2) then					--岚月
					s_type=21;
				elseif (dx==0 and dy==-1) or (dy==0 and dx==-1) then					--银月
					s_type=22;
				elseif (dx==0 and dy==-2) or (dy==0 and dx==-2) then					--明星
					s_type=23;
				elseif (dx==-1 and dy==-1) or (dy==-1 and dx==-1) then					--斜月
					s_type=24;
				elseif (dx==-1 and dy==-2) or (dy==-1 and dx==-2) then					--名月
					s_type=25;
				elseif dx==-2 and dy==-2 then											--彗星
					s_type=26;
				end
			end
		end
		if s_type>0 then
			PlayWavE(3);
			show(25);
		end
	end
	local function luozi(x,y)
		PlayWavE(0);
		set(x,y,current);
		lastx=x;
		lasty=y;
		lastcolor=C_WHITE-lastcolor;
		minx=math.min(minx,x);	maxx=math.max(maxx,x);
		miny=math.min(miny,y);	maxy=math.max(maxy,y);
		if turn==1 then
			qx1=x;qy1=y;
		elseif turn==2 then
			qx2=x;qy2=y;
		elseif turn==3 then
			qx3=x;qy3=y;
			XingYue();
		end
		if GetValue(x,y,current)>=100 then
			show(30);
			PlayWavE(97);
			show(70);
			if c_mode[current]==0 then
				gameresult=1;
				wincount=wincount+1;
			else
				gameresult=2;
				losecount=losecount+1;
			end
		end
		turn=turn+1;
		current=3-current;
	end
	local function manual()
		--落子
		if MOUSE.status=='CLICK' and between(MOUSE.rx,gx-g_size/2,gx+grid_size+g_size/2) and between(MOUSE.ry,gy-g_size/2,gy+grid_size+g_size/2) then
			local lx,ly=math.modf(0.5+(MOUSE.rx-gx)/g_size),math.modf(0.5+(MOUSE.ry-gy)/g_size);
			if MOUSE.CLICK(gx+g_size*lx-qz_size,gy+g_size*ly-qz_size,gx+g_size*lx+qz_size,gy+g_size*ly+qz_size) then
				if get(lx,ly)==0 then
					luozi(lx,ly);
				else
					PlayWavE(2);
				end
			end
		end
	end
	local function TreeSearch(ct,deep,a,b)
		local o_minx=minx;	local o_maxx=maxx;
		local o_miny=miny;	local o_maxy=maxy;
		local rv,maxv,minv,rx,ry;
		local needmax;
		maxv,minv=-200,200;
		if deep%2==1 then
			needmax=true;
		else
			needmax=false;
		end
		for x=math.max(0,minx-3),math.min(grid-1,maxx+3) do
			for y=math.max(0,miny-3),math.min(grid-1,maxy+3) do
				if get(x,y)==0 then
					local v=math.max(GetValue(x,y,ct),GetValue(x,y,3-ct)-5);
					---
					if deep>1 and v<100 then
						set(x,y,ct);
						minx=math.min(minx,x);	maxx=math.max(maxx,x);
						miny=math.min(miny,y);	maxy=math.max(maxy,y);
						v=v/5+TreeSearch(3-ct,deep-1,maxv,minv)--+math.max(GetValue(x,y,ct),GetValue(x,y,3-ct)-5)/5;
						set(x,y,0);
						minx=o_minx;	maxx=o_maxx;
						miny=o_miny;	maxy=o_maxy;
						--lib.Debug(string.format("deep=%d,x=%d,y=%d,v=%d,bv=%d",deep,x,y,v,bv))
						-- a-b cut
						if (needmax and v<a) or (not needmax and v>b) then
							lib.Debug("CUT")
							return v,x,y;
						end
					end
					---
					if v>maxv then
						maxv=v;
						if needmax then	rv,rx,ry=v,x,y; end
					else
						minv=v;
						if not needmax then	rv,rx,ry=v,x,y; end
					end
				end
			end
		end
		return rv,rx,ry;
	end
	local function Five_AI_Fail()
		local maxv,max_x,max_y=TreeSearch(current,3,-200,200);
		luozi(max_x,max_y);
	end
	local function Five_AI()
		local rv,rx,ry;
		rv=-10;
		for x=math.max(0,minx-3),math.min(grid-1,maxx+3) do
			for y=math.max(0,miny-3),math.min(grid-1,maxy+3) do
				if get(x,y)==0 then
					local atk_v=GetValue(x,y,current);
					local def_v=GetValue(x,y,3-current)-1;
					if eid_ad>0 then
						atk_v=atk_v+eid_ad;
					else
						def_v=def_v-eid_ad;
					end
					local v=math.max(atk_v,def_v);
					if RND((90-eid_lv)/200) and v<100 then
						lib.Debug("XXX "..(110+eid_lv)/200)
						v=v+math.random(20)-math.random(20);
					end
					if v>rv then
						rv,rx,ry=v,x,y;
					end
				end
			end
		end
		luozi(rx,ry);
	end
	local function new_game()
		SetSceneID(69,0);
		new_map();
		gamecount=gamecount+1;
		gameresult=0;
		turn=1;
		current=1;
		lastcolor=0;
		minx,maxx,miny,maxy=cel,cel,cel,cel;
		qx1,qy1,qx2,qy2,qx3,qy3=nil,nil,nil,nil,nil,nil;
		s_type=0;
		
		while gameresult==0 and turn<=grid^2 do
			show();
			if c_mode[current]==0 then
				manual();
			else
				show(15+math.random(15));
				Five_AI();
				MOUSE.CLICK();
			end
			--UI
			local event,btid=button_event(bt);
			if event==3 then
				if btid==1 then
					gameresult=2;
					losecount=losecount+1;
					return;
				end
			end
		end
		if gameresult==0 then
			show(30);
			PlayWavE(97);
			show(70);
		end
		WaitKey();
		PlayWavE(0);
			--[[
				Talk(eid,"这局平了。");
				Talk(eid,"你赢了。");
				Talk(eid,"你输了。");]]--
	end
	--control
	local gid=TableRandom({1194,1195,1196,1197,1198,1199,1200,1201,1202,1203,1204,1205,1224,1225,1226,1227,1228,1258,1259,1260,1261,1262,1263,1264});
	local function config()
		local m={
					{"开始",			nil,1,false};
					{"对手: ",			nil,1,true};
					{"先手: 自己",		nil,1,true};
					{"离开",			nil,1,true};
				}
		while true do
			if eid>0 then
				m[1][4]=true;
				m[2][1]="对手: "..JY.Person[eid]["名称"];
			else
				m[1][4]=false;
				m[2][1]="选择对手"
			end
			if c_mode[1]==0 then
				m[3][1]="先手: 自己";
			else
				m[3][1]="先手: 对手";
			end
			local str;
			if eid>0 then
				if c_mode[1]==0 then
					str="请确认：玩家(执黑先行) 对战 [Green]"..JY.Person[eid]["名称"].."[Normal]。[n]可以吗？";
				else
					str="请确认：[Green]"..JY.Person[eid]["名称"].."[Normal](执黑先行) 对战 玩家。[n]可以吗？";
				end
			else
				str="请先选择对手。";
			end
			local r=TalkMenuEx("姑娘",gid,str,m);
			if r==1 then
				return 1;
			elseif r==2 then
				local id=ShowPersonList(GetAllList(),"智谋");
				if id>0 then
					eid=id;
					eid_lv=math.modf((math.max(JY.Person[eid]["统率"],JY.Person[eid]["智谋"])+math.max(JY.Person[eid]["政务"],JY.Person[eid]["魅力"]))/2);
					eid_ad=limitX(math.modf((JY.Person[eid]["武力"]-JY.Person[eid]["统率"])/5),-10,10);
				end
			elseif r==3 then
				if c_mode[1]==0 then
					c_mode={1,0};
				else
					c_mode={0,1};
				end
			elseif r==4 then
				return 0
			end
		end
	end
	SetSceneID(70,0);
	TalkEx("姑娘",gid,"欢迎。");
	while true do
		local r=config();
		if r==1 then
			TalkEx("姑娘",gid,"祝您旗开得胜。");
			new_game();
			SetSceneID(70,0);
			TalkEx("姑娘",gid,"再来一局吗？");
		else
			TalkEx("姑娘",gid,"期待您下次再来。");
			return;
		end
	end
	
end
function SanQA()
	local gid=TableRandom({1194,1195,1196,1197,1198,1199,1200,1201,1202,1203,1204,1205,1224,1225,1226,1227,1228,1258,1259,1260,1261,1262,1263,1264});
	SetSceneID(70);
	TalkEx("姑娘",gid,"欢迎。");
	local n={10,15,20,30,50,100,150,200,250,300,400,500,600};	--total 600ea
	local pt={80,85,90,100,100,100,100,100,100,100,100,100,100}
	local tk={};
	local function tk_init()
		tk={};
		for i=1,600 do table.insert(tk,i) end
	end
	local m={
				{n[1].."题",			nil,1,true};
				{n[2].."题",			nil,1,true};
				{n[3].."题",			nil,1,true};
				{n[4].."题",			nil,1,true};
			}
	while true do
		local rightnum,wrongnum,trynum=0,0,0;
		local r=TalkMenuEx("姑娘",gid,"开始挑战三国问答，准备好了吗？[n]请选择问题的数目吧。",m);
		if r>0 then
			tk_init();
			TalkEx("姑娘",gid,"做好准备，我们开始吧！");
			for i=1,n[r] do
				local tid=TableRandom(tk);
				local mdf=RND(0.5);
				if tid>0 then
					local qid=9994+7*tid
					local m1={};
					local ta={2,3,4,5,6};
					for j=1,4 do
						local idx=TableRandom(ta);
						m1[j]={JY.Str[qid+idx],	nil,	1,	true};
					end
					local ra=math.random(1,4);
					m1[ra][1]=JY.Str[qid+1];
					local question=string.format("第%d题[n][wheat]%s",i,JY.Str[qid]);
					local r1=TalkMenuEx("姑娘",gid,question,m1);
					if r1==0 then
						break;
					elseif r1==ra then
						PlayWavE(3);
						TalkEx("姑娘",gid,"真厉害，一次就答对了！");
						rightnum=rightnum+1;
					elseif mdf then
						mdf=false;
						TalkEx("姑娘",gid,"呵呵，这个答案不对哦。[n]没办法，再给你一次机会吧。");
						m1[r1][4]=false;
						r1=TalkMenuEx("姑娘",gid,question,m1);
						if r1==0 then
							break;
						elseif r1==ra then
							PlayWavE(3);
							TalkEx("姑娘",gid,"总算给你做对了，不会是蒙的吧？");
							rightnum=rightnum+1;
							trynum=trynum+1;
						else
							TalkEx("姑娘",gid,"你太差劲了，猜两回都没有猜出来。");
							wrongnum=wrongnum+1;
						end
					else
						TalkEx("姑娘",gid,"呵呵，这个答案不对哦。");
						wrongnum=wrongnum+1;
					end
				end
			end
			local ratio=math.modf(pt[r]*(rightnum-trynum/4)/n[r]);
			local result=string.format("一共%d道题，您的回答: 正确%d 错误%d 得分%d[n]",n[r],rightnum,wrongnum,ratio);
			if ratio==100 then
				result=result.."真是太棒啦，完全正确呢！"
			elseif ratio>80 then
				result=result.."好厉害，期待您下次更好的表现！"
			elseif ratio>60 then
				result=result.."马马虎虎吧，下次加油。"
			else
				result=result.."额，怎么说呢……是没有发挥出真正的实力吗？"
			end
			
			TalkEx("姑娘",gid,result);
			TalkEx("姑娘",gid,"要再来一次吗？");
		else
			TalkEx("姑娘",gid,"期待您下次再来。");
			break;
		end
	end
end
function HuaRongD()
	local gid=TableRandom({1194,1195,1196,1197,1198,1199,1200,1201,1202,1203,1204,1205,1224,1225,1226,1227,1228,1258,1259,1260,1261,1262,1263,1264});
	SetSceneID(70);
	TalkEx("姑娘",gid,"欢迎。");
	local m={
				{"勇闯五关",			nil,1,true};
				{"水泄不通",			nil,1,true};
				{"横刀立马",			nil,1,true};
				{"小燕出巢",			nil,1,true};
				{"近在咫尺",			nil,1,true};
				{"走投无路",			nil,1,true};
			}
	while true do
		local rightnum,wrongnum,trynum=0,0,0;
		local r=TalkMenuEx("姑娘",gid,"开始挑战华容道，准备好了吗？[n]请选择关卡吧。",m);
		if r>0 then
			TalkEx("姑娘",gid,"做好准备，我们开始吧！");
			HuaRongD_sub(r);
		else
			TalkEx("姑娘",gid,"期待您下次再来。");
			break;
		end
	end	
end
function HuaRongD_sub(gid)
	local qp={};
	local title="";
	--1为小兵 2为横排 3为竖排 4为大方块
	local qz={};
	local function qz_set(kid,qid,x,y)
		if kid==1 then
			qp[x][y]=qid;
		elseif kid==2 then
			qp[x][y]=qid;
			qp[x+1][y]=qid;
		elseif kid==3 then
			qp[x][y]=qid;
			qp[x][y+1]=qid;
		elseif kid==4 then
			qp[x][y]=qid;
			qp[x+1][y]=qid;
			qp[x][y+1]=qid;
			qp[x+1][y+1]=qid;
		end
	end
	local function qz_check(kid,qid,x,y)
		if kid==1 then
			if between(x,1,4) and between(y,1,5) then
				if qp[x][y]==0 or qp[x][y]==qid then
					return true;
				end
			end
		elseif kid==2 then
			if between(x,1,3) and between(y,1,5) then
				if (qp[x][y]==0 or qp[x][y]==qid) and (qp[x+1][y]==0 or qp[x+1][y]==qid) then
					return true;
				end
			end
		elseif kid==3 then
			if between(x,1,4) and between(y,1,4) then
				if (qp[x][y]==0 or qp[x][y]==qid) and (qp[x][y+1]==0 or qp[x][y+1]==qid) then
					return true;
				end
			end
		elseif kid==4 then
			if between(x,1,3) and between(y,1,4) then
				if (qp[x][y]==0 or qp[x][y]==qid) and (qp[x][y+1]==0 or qp[x][y+1]==qid) and
					(qp[x+1][y]==0 or qp[x+1][y]==qid) and (qp[x+1][y+1]==0 or qp[x+1][y+1]==qid) then
					return true;
				end
			end
		end
		return false;
	end
	local function qz_insert(kid,pid,x,y)
		if qz_check(kid,0,x,y) then
			local qid=1+#qz;
			qz_set(kid,qid,x,y);
			qz[qid]={
						kid=kid,
						x=x,
						y=y,
						ox=x,
						oy=y,
						pic=JY.Person[pid]["容貌"],
						name=JY.Person[pid]["名称"],
					}
		end
	end
	local function qz_move(qid)
		--上下左右
		local dx={0,0,-1,1};
		local dy={-1,1,0,0};
		local qx,qy=0,0;
		local v=qz[qid];
		for d=1,4 do
			local tx,ty=v.x+dx[d],v.y+dy[d];
			if qz_check(v.kid,qid,tx,ty) then
				qx,qy=tx,ty;
				if tx~=v.ox or ty~=v.oy then
					break;
				end
			end
		end
		if qx>0 then
			PlayWavE(0);
			qz_set(v.kid,0,v.x,v.y);
			qz_set(v.kid,qid,qx,qy);
			v.ox,v.oy=v.x,v.y;
			v.x,v.y=qx,qy;
		else
			PlayWavE(2);
		end
	end
	local function qp_ini()
		qp={};
		for x=1,4 do
			qp[x]={0,0,0,0,0};
		end
		qz={};
		if gid==1 then
			title="勇闯五关";
			qz_insert(4,334,2,1);	--曹操
			qz_insert(2,419,1,3);	--张飞
			qz_insert(2,381,3,3);	--赵云
			qz_insert(2,499,1,4);	--马超
			qz_insert(2,179,3,4);	--黄忠
			qz_insert(2,95,2,5);	--关羽
			qz_insert(1,237,1,1);	--周仓
			qz_insert(1,117,4,1);	--关平
			qz_insert(1,616,1,2);	--刘封
			qz_insert(1,621,4,2);	--廖化
		elseif gid==2 then
			title="水泄不通";
			qz_insert(4,334,2,1);	--曹操
			qz_insert(3,419,4,1);	--张飞
			qz_insert(2,381,1,3);	--赵云
			qz_insert(2,499,3,3);	--马超
			qz_insert(2,179,1,4);	--黄忠
			qz_insert(2,95,3,4);	--关羽
			qz_insert(1,237,1,1);	--周仓
			qz_insert(1,117,1,2);	--关平
			qz_insert(1,616,1,5);	--刘封
			qz_insert(1,621,4,5);	--廖化
		elseif gid==3 then
			title="横刀立马";
			qz_insert(4,334,2,1);	--曹操
			qz_insert(3,419,1,1);	--张飞
			qz_insert(3,381,4,1);	--赵云
			qz_insert(3,499,1,3);	--马超
			qz_insert(3,179,4,3);	--黄忠
			qz_insert(2,95,2,3);	--关羽
			qz_insert(1,237,2,4);	--周仓
			qz_insert(1,117,3,4);	--关平
			qz_insert(1,616,1,5);	--刘封
			qz_insert(1,621,4,5);	--廖化
		elseif gid==4 then
			title="小燕出巢";
			qz_insert(4,334,2,1);	--曹操
			qz_insert(3,419,1,1);	--张飞
			qz_insert(3,381,4,1);	--赵云
			qz_insert(2,499,1,3);	--马超
			qz_insert(2,179,3,3);	--黄忠
			qz_insert(2,95,2,4);	--关羽
			qz_insert(1,237,1,4);	--周仓
			qz_insert(1,117,4,4);	--关平
			qz_insert(1,616,1,5);	--刘封
			qz_insert(1,621,4,5);	--廖化
		elseif gid==5 then
			title="近在咫尺";
			qz_insert(4,334,3,4);	--曹操
			qz_insert(3,419,2,1);	--张飞
			qz_insert(3,381,3,1);	--赵云
			qz_insert(3,499,4,1);	--马超
			qz_insert(2,179,1,3);	--黄忠
			qz_insert(2,95,1,4);	--关羽
			qz_insert(1,237,1,1);	--周仓
			qz_insert(1,117,1,2);	--关平
			qz_insert(1,616,3,3);	--刘封
			qz_insert(1,621,4,3);	--廖化
		elseif gid==6 then
			title="走投无路";
			qz_insert(4,334,2,1);	--曹操
			qz_insert(3,419,1,1);	--张飞
			qz_insert(3,381,4,1);	--赵云
			qz_insert(3,499,1,3);	--马超
			qz_insert(3,179,2,3);	--黄忠
			qz_insert(3,95,4,3);	--关羽
			qz_insert(1,237,3,3);	--周仓
			qz_insert(1,117,3,4);	--关平
			qz_insert(1,616,1,5);	--刘封
			qz_insert(1,621,4,5);	--廖化
		end
	end
	qp_ini();
	local grid_size=96;
	local map_width=grid_size*4;
	local map_height=grid_size*5;
	local mx=CC.ScreenW/2-map_width/2;
	local my=CC.ScreenH/2-map_height/2+24;
	--UI
	local bt={};
	table.insert(bt,button_creat(1,1,CC.ScreenW-200,CC.ScreenH-120,"重新开始",true,true));
	table.insert(bt,button_creat(1,2,CC.ScreenW-200,CC.ScreenH-80,"退出",true,true));
	local qz_cur=0;
	local function redraw()
		DrawGame();
		LoadPicEnhance(73,mx-64,0,map_width+64*2,CC.ScreenH);
		lib.FillColor(mx-2,my-2-4,mx+map_width+2,my-2,C_WHITE);
		lib.FillColor(mx-2-4,my-2-4,mx-2,my+2+map_height+4,C_WHITE);
		lib.FillColor(mx+2+map_width,my-2-4,mx+2+map_width+4,my+2+map_height+4,C_WHITE);
		lib.FillColor(mx-2,my+2+map_height,mx+grid_size,my+2+map_height+4,C_WHITE);
		lib.FillColor(mx+grid_size*3,my+2+map_height,mx+2+map_width,my+2+map_height+4,C_WHITE);
		for i,v in ipairs(qz) do
			local sx=mx+grid_size*(v.x-1)+1;
			local sy=my+grid_size*(v.y-1)+1;
			if v.kid==1 then
				LoadPicEnhance(201,sx,sy,grid_size-1,grid_size-1);
				lib.PicLoadCache(2,(v.pic+6000)*2,sx+grid_size/2,sy+grid_size/2);
				if qz_cur==i then
					DrawStringEnhance(sx+grid_size/2,sy+grid_size,v.name,M_Wheat,20,0.5,1.2);
				end
			elseif v.kid==2 then
				LoadPicEnhance(201,sx,sy,grid_size*2-1,grid_size-1);
				lib.PicLoadCache(2,(v.pic+6000)*2,sx+grid_size,sy+grid_size/2);
				if qz_cur==i then
					DrawStringEnhance(sx+grid_size,sy+grid_size,v.name,M_Wheat,20,0.5,1.2);
				end
			elseif v.kid==3 then
				LoadPicEnhance(201,sx,sy,grid_size-1,grid_size*2-1);
				lib.PicLoadCache(2,(v.pic+6000)*2,sx+grid_size/2,sy+grid_size);
				if qz_cur==i then
					DrawStringEnhance(sx+grid_size/2,sy+grid_size*2,v.name,M_Wheat,20,0.5,1.2);
				end
			elseif v.kid==4 then
				LoadPicEnhance(201,sx,sy,grid_size*2-1,grid_size*2-1);
				lib.PicLoadCache(2,(v.pic+2000)*2,sx+grid_size,sy+grid_size);
				if qz_cur==i then
					DrawStringEnhance(sx+grid_size,sy+grid_size*2,v.name,M_Wheat,20,0.5,1.2);
				end
			end
		end
		lib.PicLoadCache(4,4*2,CC.ScreenW/2,32);
		DrawStringEnhance(CC.ScreenW/2,32,title,C_WHITE,32,0.5,0.5);
		button_redraw(bt);
	end
	local function show(n)
		n=n or 1;
		for i=1,n do
			local t1=lib.GetTime();
			redraw();
			ShowScreen();
			local delay=CC.FrameNum-lib.GetTime()+t1;
			if delay>0 then
				lib.Delay(delay);
			end
			getkey();
		end
	end
	SetSceneID(62);
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
				qp_ini();
			elseif btid==2 then
				return false;
			end
		end
		qz_cur=0;
		for i,v in ipairs(qz) do
			local qzx=mx+grid_size*(v.x-1)+2;
			local qzy=my+grid_size*(v.y-1)+2;
			local qzw,qzh=0,0;
			if v.kid==1 then
				qzw=grid_size;
				qzh=grid_size;
			elseif v.kid==2 then
				qzw=grid_size*2;
				qzh=grid_size;
			elseif v.kid==3 then
				qzw=grid_size;
				qzh=grid_size*2;
			elseif v.kid==4 then
				qzw=grid_size*2;
				qzh=grid_size*2;
			end
			qzw,qzh=qzw-3,qzh-3;
			if MOUSE.CLICK(qzx,qzy,qzx+qzw,qzy+qzh) then
				qz_cur=i;
				qz_move(i);
				break;
			elseif MOUSE.IN(qzx,qzy,qzx+qzw,qzy+qzh) then
				qz_cur=i;
			end
		end
		if qz[1].x==2 and qz[1].y==4 then
			redraw();
			show(30);
			PlayWavE(97);
			show(70);
			return true;
		end
	end
end