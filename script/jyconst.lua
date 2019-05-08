
--设置全局变量CC，保存游戏中使用的常数
function SetGlobalConst()
    -- SDL 键码定义，这里名字仍然使用directx的名字
    VK_ESCAPE=27
    VK_Y=121
	VK_N=110
	VK_SPACE=32
	VK_RETURN=13

	SDLK_UP=273
	SDLK_DOWN=274
	SDLK_LEFT=276
	SDLK_RIGHT=275

	if CONFIG.Rotate==0 then
		VK_UP=SDLK_UP;
		VK_DOWN=SDLK_DOWN;
		VK_LEFT=SDLK_LEFT;
		VK_RIGHT=SDLK_RIGHT;
	else           --右转90度
		VK_UP=SDLK_RIGHT;
		VK_DOWN=SDLK_LEFT;
		VK_LEFT=SDLK_UP;
		VK_RIGHT=SDLK_DOWN;
	end

	-- 游戏中颜色定义
	C_STARTMENU=RGB(132, 0, 4)            -- 开始菜单颜色
	C_RED=RGB(216, 20, 24)                -- 开始菜单选中项颜色

	C_WHITE=RGB(236, 236, 236);           --游戏内常用的几个颜色值
	C_ORANGE=RGB(252, 148, 16);
	C_GOLD=RGB(236, 200, 40);
	C_BLACK=RGB(0,0,0);
	
	M_Black=RGB(0,0,0);
	M_Sienna=RGB(160,82,45);
	M_DarkOliveGreen=RGB(85,107,47);
	M_DarkGreen=RGB(0,100,0);
	M_DarkSlateBlue=RGB(72,61,139);
	M_Navy=RGB(0,0,128);
	M_Indigo=RGB(75,0,130);
	M_DarkSlateGray=RGB(47,79,79);
	M_DarkRed=RGB(139,0,0);
	M_DarkOrange=RGB(255,140,0);	--(239,101,0)
	M_Olive=RGB(128,128,0);
	M_Green=RGB(0,128,0);
	M_Teal=RGB(0,128,128);
	M_Blue=RGB(0,0,255);
	M_SlateGray=RGB(112,128,144);
	M_DimGray=RGB(105,105,105);
	M_Red=RGB(255,0,0);
	M_SandyBrown=RGB(244,164,96);
	M_YellowGreen=RGB(154,205,50);
	M_SeaGreen=RGB(46,139,87);
	M_MediumTurquoise=RGB(72,209,204);
	M_RoyalBlue=RGB(65,105,225);
	M_Purple=RGB(128,0,128);
	M_Gray=RGB(128,128,128);
	M_Magenta=RGB(255,0,255);
	M_Orange=RGB(255,165,0);
	M_Yellow=RGB(255,255,0);
	M_Lime=RGB(0,255,0);
	M_Cyan=RGB(0,255,255);
	M_DeepSkyBlue=RGB(0,191,255);
	M_DarkOrchid=RGB(153,50,204);
	M_Silver=RGB(192,192,192);
	M_Pink=RGB(255,192,203);
	M_Wheat=RGB(245,222,179);
	M_LemonChiffon=RGB(255,250,205);
	M_PaleGreen=RGB(152,251,152);
	M_PaleTurquoise=RGB(175,238,238);
	M_LightBlue=RGB(173,216,230);
	M_Plum=RGB(221,160,221);
	M_White=RGB(255,255,255);
	
	C_Name=RGB(255,207,85);
	FlagColor={
				[1]=RGB(40,40,232),			[2]=RGB(56,112,0),			[3]=RGB(208,0,40),			[4]=RGB(248,248,0),			[5]=RGB(232,136,240),
				[6]=RGB(104,104,104),		[7]=RGB(176,120,136),		[8]=RGB(88,200,240),		[9]=RGB(24,0,72),			[10]=RGB(224,72,0),
				[11]=RGB(192,168,232),		[12]=RGB(208,208,8),		[13]=RGB(160,96,0),			[14]=RGB(192,168,104),		[15]=RGB(112,0,80),
				[16]=RGB(200,224,160),		[17]=RGB(64,64,168),		[18]=RGB(80,24,0),			[19]=RGB(192,248,144),		[20]=RGB(200,8,152),
				[21]=RGB(248,0,136),		[22]=RGB(120,56,0),			[23]=RGB(176,232,216),		[24]=RGB(152,160,232),		[25]=RGB(112,104,232),
				[26]=RGB(160,144,96),		[27]=RGB(232,232,200),		[28]=RGB(112,80,176),		[29]=RGB(200,104,0),		[30]=RGB(240,184,152),
				[31]=RGB(96,112,88),		[32]=RGB(248,120,64),		[33]=RGB(240,176,0),		[34]=RGB(80,72,48),			[35]=RGB(0,160,112),
				[36]=RGB(248,136,144),		[37]=RGB(80,112,168),		[38]=RGB(232,232,144),		[39]=RGB(224,200,168),		[40]=RGB(48,136,232),
				[41]=RGB(0,0,136),			[42]=RGB(136,248,248),		[43]=RGB(96,192,96),		[44]=RGB(0,0,48),			[45]=RGB(208,152,80),
				[46]=RGB(0,72,0),			[47]=RGB(248,0,0),			[48]=RGB(104,152,160),		[49]=RGB(120,160,0),		[50]=RGB(56,248,152),
				[51]=RGB(248,248,248),		[0]=RGB(248,248,248),
			}
	-- 游戏状态定义
	GAME_START =0       --开始画面,各种选单，事件不开启
	GAME_SMAP_AUTO =1;       --场景地图，禁止玩家操作，事件开启
	GAME_SMAP_MANUAL =2;       --场景地图，开启玩家操作，事件开启
	GAME_MMAP =3;       --大地图，禁止玩家操作，事件开启
	GAME_WMAP =4;       --战斗地图，事件开启
	GAME_WMAP2 =5;       --战斗地图，用于连续战斗
	GAME_DEAD =6;       --死亡画面
	GAME_END  =7;       --结束
	GAME_WARWIN  =8;       --战斗胜利
	GAME_WARLOSE  =9;       --战斗失败
	--战斗事件类型
	War_Event_Action=0;		--人物行动后
	War_Event_TurnM=1;		--回合开始时 我军
	War_Event_TurnF=2;		--回合开始时 友军
	War_Event_TurnE=3;		--回合开始时 敌军
	--游戏数据全局变量
	CC={};      --定义游戏中使用的常量，这些可以在修改游戏时修改之
	CC.Debug=0;
	CC.FPS=false;
	CC.PASCODE=	{	
		"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
		"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
		".","\\","?","*","+","-",
	}
	--config
	CC.FontType=0;
	CC.FontSize = 24
	CC.FontSizeM = 20
	CC.FontSizeS = 16
	CC.MusicVolume=CONFIG.MusicVolume;
	CC.SoundVolume=CONFIG.SoundVolume
		
	CC.SrcCharSet=0;         --源代码的字符集 0 gb  1 big5，用于转换R×。 如果源码被转换为big5，则应设为1
	CC.OSCharSet=CONFIG.OSCharSet;         --OS 字符集，0 GB, 1 Big5
	CC.FontName=CONFIG.FontName;    --显示字体

	CC.ScreenW=CONFIG.Width;          --显示窗口宽高
	CC.ScreenH=CONFIG.Height;
	CC.ScreenW2 = CC.ScreenW / 2;
	CC.ScreenH2 = CC.ScreenH / 2;
	CC.CardWidth = 90--112
	CC.CardHeight = 128--156
	CC.Direction = {'上','右','下','左'}
	CC.DirectX={0, 1, 0, -1};  --不同方向x，y的加减值，用于走路改变坐标值
	CC.DirectY={-1, 0, 1, 0};
	CC.TmxFilename = CONFIG.TmxPath .. "%03d.tmx"
	CC.SnrFilename = CONFIG.SnrPath .. "SNR%d-%d.txt"
	CC.FontTxtFilename = CONFIG.DataPath .. "font.tsv"
	CC.RoleTxtFilename = CONFIG.DataPath .. "role.tsv"
	CC.CityTxtFilename = CONFIG.DataPath .. "city.tsv"
	CC.UnitTxtFilename = CONFIG.DataPath .. "unit.tsv"
	CC.TerrainTxtFilename = CONFIG.DataPath .. "terrain.tsv"
	CC.UnitTerrainTxtFilename = CONFIG.DataPath .. "unit_terrain.tsv"
	CC.UnitSkinTxtFilename = CONFIG.DataPath .. "unit_skin.tsv"

	CC.MaxLv = 50
	CC.MaxItemNum = 15

	CC.WarName = {
		'博望坡战役', '新野城战役', '江夏急行战', '长阪坡战役', '赤壁战役',
		'荆州南部战役Ⅰ', '绵竹关·葭萌关战役', '汉水战役', '麦城战役', '彝陵战役',
		'阳平关战役', '益州南部战役', '五溪峰战役', '夹山谷战役', '泸水战役',
		'西耳湖战役', '秃龙洞战役', '三江城战役', '蛮都战役', '桃叶江战役',
		'盘蛇谷战役', '凤鸣山战役', '南安·安定战役', '天水城战役', '冀城战役',
		'祁山战役Ⅰ', '西平关战役', '街亭战役', '汉中撤退战', '陈仓·祁山战役',
		'陈仓攻城战', '祁山追击战', '二谷道战役', '祁山战役Ⅱ', '渭水战役',
		'葫芦谷战役', '五丈原战役', '眉城战役', '武功战役', '长安攻城战Ⅰ',
		'巴西战役', '白帝城战役', '江陵战役', '成都防卫战Ⅰ', '建宁战役',
		'长安攻城战Ⅱ', '华山战役', '函谷关战役', '洛阳战役Ⅰ', '洛阳战役Ⅱ'
	}

	CC.Exp={
		100,	100,	100,	100,	100,
		110,	120,	130,	140,	150,
		160,	170,	180,	190,	200,
		210,	220,	230,	240,	250,
		260,	270,	280,	290,	300,
		310,	320,	330,	340,	350,
		360,	370,	380,	390,	400,
		410,	420,	430,	440,	450,
		460,	470,	480,	490,	500,
		510,	520,	530,	540,	550,
		560,	570,	580,	590,	600,
		610,	620,	630,	640,	650,
		660,	670,	680,	690,	700,
		710,	720,	730,	740,	750,
		760,	770,	780,	790,	800,
		810,	820,	830,	840,	850,
		860,	870,	880,	890,	900,
	}
	CC.AtkArea = {
		[1] = {
--[[
-#-
#X#
-#-
]]
			{x = 0, y = -1},
			{x = 1, y = 0},
			{x = 0, y = 1},
			{x = -1, y = 0},
		},
		[2] = {
--[[
###
#X#
###
]]
			{x = 0, y = -1},
			{x = 1, y = 0},
			{x = 0, y = 1},
			{x = -1, y = 0},
			{x = 1, y = -1},
			{x = 1, y = 1},
			{x = -1, y = 1},
			{x = -1, y = -1},
		},
		[3] = {
--[[
--#--
-###-
##X##
-###-
--#--
]]
			{x = 0, y = -1},
			{x = 1, y = 0},
			{x = 0, y = 1},
			{x = -1, y = 0},
			{x = 1, y = -1},
			{x = 1, y = 1},
			{x = -1, y = 1},
			{x = -1, y = -1},
			{x = 0, y = -2},
			{x = 2, y = 0},
			{x = 0, y = 2},
			{x = -2, y = 0},
		},
		[4] = {
--[[
-###-
#####
##X##
#####
-###-
]]
			{x = 0, y = -1},
			{x = 1, y = 0},
			{x = 0, y = 1},
			{x = -1, y = 0},
			{x = 1, y = -1},
			{x = 1, y = 1},
			{x = -1, y = 1},
			{x = -1, y = -1},
			{x = 0, y = -2},
			{x = 2, y = 0},
			{x = 0, y = 2},
			{x = -2, y = 0},
			{x = 1, y = -2},
			{x = -1, y = -2},
			{x = 2, y = -1},
			{x = 2, y = 1},
			{x = 1, y = 2},
			{x = -1, y = 2},
			{x = -2, y = -1},
			{x = -2, y = 1},
		},
		[5] = {
--[[
--#--
-----
#-X-#
-----
--#--
]]
			{x = 0, y = -2},
			{x = 2, y = 0},
			{x = 0, y = 2},
			{x = -2, y = 0},
		},
		[6] = {
--[[
--#--
-#-#-
#-X-#
-#-#-
--#--
]]
			{x = 0, y = -2},
			{x = 2, y = 0},
			{x = 0, y = 2},
			{x = -2, y = 0},
			{x = 1, y = -1},
			{x = 1, y = 1},
			{x = -1, y = 1},
			{x = -1, y = -1},
		},
		[7] = {
--[[
-###-
##-##
#-X-#
##-##
-###-
]]
			{x = 0, y = -2},
			{x = 2, y = 0},
			{x = 0, y = 2},
			{x = -2, y = 0},
			{x = 1, y = -1},
			{x = 1, y = 1},
			{x = -1, y = 1},
			{x = -1, y = -1},
			{x = 1, y = -2},
			{x = -1, y = -2},
			{x = 2, y = -1},
			{x = 2, y = 1},
			{x = 1, y = 2},
			{x = -1, y = 2},
			{x = -2, y = -1},
			{x = -2, y = 1},
		},
		[8] = {
--[[
---#---
--###--
-##-##-
##-X-##
-##-##-
--###--
---#---
]]
			{x = 0, y = -2},
			{x = 2, y = 0},
			{x = 0, y = 2},
			{x = -2, y = 0},
			{x = 1, y = -1},
			{x = 1, y = 1},
			{x = -1, y = 1},
			{x = -1, y = -1},
			{x = 1, y = -2},
			{x = -1, y = -2},
			{x = 2, y = -1},
			{x = 2, y = 1},
			{x = 1, y = 2},
			{x = -1, y = 2},
			{x = -2, y = -1},
			{x = -2, y = 1},
			{x = 0, y = -3},
			{x = 3, y = 0},
			{x = 0, y = 3},
			{x = -3, y = 0},
		},
		[9] = {
--[[
---#---
-#####-
-##-##-
##-X-##
-##-##-
-#####-
---#---
]]
			{x = 0, y = -2},
			{x = 2, y = 0},
			{x = 0, y = 2},
			{x = -2, y = 0},
			{x = 1, y = -1},
			{x = 1, y = 1},
			{x = -1, y = 1},
			{x = -1, y = -1},
			{x = 1, y = -2},
			{x = -1, y = -2},
			{x = 2, y = -1},
			{x = 2, y = 1},
			{x = 1, y = 2},
			{x = -1, y = 2},
			{x = -2, y = -1},
			{x = -2, y = 1},
			{x = 0, y = -3},
			{x = 3, y = 0},
			{x = 0, y = 3},
			{x = -3, y = 0},
			{x = 2, y = -2},
			{x = 2, y = 2},
			{x = -2, y = 2},
			{x = -2, y = -2},
		},
	}



	CC.SpWidth = {}
	for i = 13525, 13619 do
		CC.SpWidth[i] = 0.5
	end
	for i = 13557, 13583 do
		CC.SpWidth[i] = 0.66
	end
	CC.SpWidth[13565] = 0.3
	CC.SpWidth[13566] = 0.5
	CC.SpWidth[13569] = 0.75
	CC.SpWidth[13578] = 0.75
	CC.SpWidth[13579] = 0.75
	CC.SpWidth[13597] = 0.25
	CC.SpWidth[13600] = 0.25
	CC.SpWidth[13601] = 0.7
	CC.SpWidth[13606] = 0.4
	CC.SpWidth[13611] = 0.7
	CC.SpWidth[13624] = 0.5	--空格




	--各种贴图文件名。
	CC.MMAPPicFile={CONFIG.ImagePath .. "mmap.idx",CONFIG.ImagePath .. "mmap.grp"};
	CC.SMAPPicFile={CONFIG.ImagePath .. "smap.idx",CONFIG.ImagePath .. "smap.grp"};
	CC.WMAPPicFile={CONFIG.ImagePath .. "wmap.idx",CONFIG.ImagePath .. "wmap.grp"};
	CC.EFT={CONFIG.ImagePath .. "eft.idx",CONFIG.ImagePath .. "eft.grp"};
	CC.HeadPicFile={CONFIG.ImagePath .. "hdgrp.idx",CONFIG.ImagePath .. "hdgrp.grp"};
	CC.UIPicFile={CONFIG.ImagePath .. "ui.idx",CONFIG.ImagePath .. "ui.grp"};

	CC.BGMFile=CONFIG.MusicPath .. "%02d.ogg";
	CC.ATKFile=CONFIG.SoundPath .. "atk%02d.wav";
	CC.EFile=CONFIG.SoundPath .. "Se%02d.wav";

	CC.Skill = {
		[1] = {
			name = '奋力一击',
			sesc = '集中力量的一击，必定造成暴击',
		},
		[2] = {
			name = '突刺',
			sesc = '',
		},
		[3] = {
			name = '横扫',
			sesc = '',
		},
		[4] = {
			name = '毒箭',
			sesc = '',
		},
		[5] = {
			name = '远射',
			sesc = '',
		},
		[6] = {
			name = '大喝',
			sesc = '使范围内敌军获得多种负面状态，成功率以双方武力差决定',
		},
		[7] = {
			name = '拖刀计',
			sesc = '一回合内，被攻击时将先制反击，并可能使敌军混乱，成功率以双方智力差决定',
		},
		[8] = {
			name = '强行',
			sesc = '',
		},
		[9] = {
			name = '速攻',
			sesc = '',
		},
		[10] = {
			name = '长坂雄风',
			sesc = '移动到指定位置，同时攻击移动路径上所有敌军',
		},
	}
	

	CC.RowPixel=4         -- 每行字的间距像素数

	CC.MenuBorderPixel=5  -- 菜单四周边框留的像素数，也用于绘制字符串的box四周留得像素
	CC.MouseClickType=0;	--0 满足1且2，1只检查初始点击位置， 2只检查最终释放位置
	CC.OpearteSpeed=4	--游戏操作反应速度
	CC.WarDelay=1	--战斗操作反应速度
	CC.FrameNum = 20;	--帧数 baseline 40
	CC.LastWords={}
	CC.AtkWords={}
	CC.Enhancement=true;
	CC.SkillExp={
					[0]={1,1,1,1,1,1,1,2,3,6,8,12},
					[1]={1,1,1,1,1,1,2,3,6,8,12,16},
					[2]={1,1,1,1,1,1,3,6,9,12,15,18},
					[3]={1,1,1,1,1,1,1,2,4,8,16,32},
					[4]={1,1,1,1,1,1,2,3,5,10,15,29},
					[5]={1,1,1,1,1,1,3,5,10,12,18,24},
					[6]={1,1,1,1,1,1,10,13,16,19,22,25},
					[7]={1,1,1,1,1,1,10,11,12,30,31,32},
					[8]={1,1,1,1,1,1,6,12,18,27,40,52},--{6,12,18,27,36,45},
					[9]={1,1,1,1,1,1,11,12,21,22,41,42},
					[10]={1,1,1,1,1,1,6,12,24,36,48,60},--{12,18,24,36,48,60},
					[11]={1,1,1,1,1,1,15,21,27,33,39,51},
					[12]={1,1,1,1,1,1,4,8,16,24,36,55},--{1,2,3,4,5,50},
					[13]={1,1,1,1,1,1,20,25,30,35,40,45},
					[14]={1,1,1,1,1,1,24,28,32,36,40,48},
					[15]={1,1,1,1,1,1,30,35,40,45,50,60},
					[99]={1,1,1,1,1,1,1,1,1,1,1,1},	--用于全技能预览用
				}
	CC.Shiqi=	{
					["攻击"]	={[0]=1,1,1,2,0,0,0,0,0,0},
					["被攻击"]	={[0]=-2,-1,-1,-1,0,0,0,0,0,0},
					["防御"]	={[0]=2,1,0,0,0,0,0,0,0,0},
					["被防御"]	={[0]=-1,-1,0,-1,0,0,0,0,0,0},
					["击退"]	={[0]=3,3,3,3,0,0,0,0,0,0},
				}
	CC.Font={};
	--S.RGP
	War={};
	Pic={};
    Drama={};
    


    
   
   --定义记录文件名。S和D由于是固定大小，因此不再定义idx了。
   CC.R_IDXFilename={[0]=CONFIG.DataPath .. "newgame.idx",
                     CONFIG.DataPath .. "r1.idx",
					 CONFIG.DataPath .. "r2.idx",
					 CONFIG.DataPath .. "r3.idx",
					 CONFIG.DataPath .. "r4.idx",
					 CONFIG.DataPath .. "r5.idx",};
   CC.R_GRPFilename={[0]=CONFIG.DataPath .. "BAKDATA.R3",
                     CONFIG.DataPath .. "ESAVE0.grp",
					 CONFIG.DataPath .. "ESAVE1.grp",
					 CONFIG.DataPath .. "ESAVE2.grp",
					 CONFIG.DataPath .. "ESAVE3.grp",
					 CONFIG.DataPath .. "ESAVE4.grp",
					 CONFIG.DataPath .. "ESAVE5.grp",
					 CONFIG.DataPath .. "ESAVE6.grp",
					 CONFIG.DataPath .. "ESAVE7.grp",
					 CONFIG.DataPath .. "ESAVE8.grp",
					 CONFIG.DataPath .. "ESAVE9.grp",};

   CC.PaletteFile=CONFIG.ImagePath .. "mmap.col";
   
	--定义记录文件R×结构。  lua不支持结构，无法直接从二进制文件中读取，因此需要这些定义，用table中不同的名字来仿真结构。
	CC.MyThingNum=200      --主角物品数量
	CC.Kungfunum=5		--角色武功数量
	CC.MaxKungfuNum=80
	CC.Base_S={};         --保存基本数据的结构，以便以后存取
	CC.Base_S["名称"]={0,2,14};	--nouse
	CC.Base_S["章节名"]={14,2,28};	--章节名
	CC.Base_S["时间"]={42,2,14};	--存档保存时间
	CC.Base_S["未使用"]={56,2,14};	--nouse
	CC.Base_S["现在地"]={70,2,14};
	CC.Base_S["主角"]={70,0,2};
	CC.Base_S["行动力"]={72,0,2};
	CC.Base_S["攻打城池"]={82,0,2};
	CC.Base_S["当前状态"]={84,0,2};
	CC.Base_S["当前事件"]={86,0,2};
	CC.Base_S["当前场景"]={88,0,2};
	CC.Base_S["当前音乐"]={90,0,2};
	CC.Base_S["当前势力"]={92,0,2};
	CC.Base_S["当前城池"]={94,0,2};
	CC.Base_S["当前年"]={96,0,2};
	CC.Base_S["当前月"]={98,0,2};
	CC.Base_S["当前剧本"]={100,0,2};
	CC.Base_S["游戏难度"]={102,0,2};
	CC.Base_S["战场存档"]={104,0,2};
	CC.Base_S["档案版本"]={106,0,2};
	CC.Base_S["动态等级"]={108,0,2};
	CC.Base_S["商业"]={110,0,2};
	CC.Base_S["农业"]={112,0,2};
	CC.Base_S["技术"]={114,0,2};
	CC.Base_S["资金"]={116,1,2};
	CC.Base_S["物资"]={120,1,2};
	CC.Base_S["资金收支"]={124,0,2};
	CC.Base_S["物资收支"]={126,0,2};
	CC.Base_S["武力经验"]={128,0,2};
	CC.Base_S["智谋经验"]={130,0,2};
	CC.Base_S["统率经验"]={132,0,2};
	CC.Base_S["政务经验"]={134,0,2};
	CC.Base_S["魅力经验"]={136,0,2};
	CC.Base_S["战场名称"]={150,2,50};	--
	CC.Base_S["战场目标"]={200,2,100};	--
	for i=1,15 do
		CC.Base_S["内政担当" .. i]={128+2*(i-1),0,2};
	end
	for i=1,CC.MyThingNum do
		CC.Base_S["物品数量" .. i]={162+2*(i-1),0,2};
	end
	for i=1,2000 do
		CC.Base_S["战场事件" .. i]={1762+2*(i-1),0,2};
	end
	for i=0,2000-1 do
		CC.Base_S["事件" .. i]={2162+2*i,0,2};
	end
   
    CC.WarDataSize=186;         --战斗数据大小  war.sta数据结构
    CC.WarData_S={};        --战斗数据结构
    CC.WarData_S["代号"]={0,0,2};
    CC.WarData_S["名称"]={2,2,10};
    CC.WarData_S["地图"]={12,0,2};
    CC.WarData_S["经验"]={14,0,2};
    CC.WarData_S["音乐"]={16,0,2};
    for i=1,6 do
        CC.WarData_S["手动选择参战人"  .. i]={18+(i-1)*2,0,2};
        CC.WarData_S["自动选择参战人"  .. i]={30+(i-1)*2,0,2};
        CC.WarData_S["我方X"  .. i]={42+(i-1)*2,0,2};
        CC.WarData_S["我方Y"  .. i]={54+(i-1)*2,0,2};
    end
    for i=1,20 do
        CC.WarData_S["敌人"  .. i]={66+(i-1)*2,0,2};
        CC.WarData_S["敌方X"  .. i]={106+(i-1)*2,0,2};
        CC.WarData_S["敌方Y"  .. i]={146+(i-1)*2,0,2};
    end
   --
	CC.ForceSize=212;   --每个Force数据占用字节
	CC.Force_S={};      --保存Force数据的结构，以便以后存取
    CC.Force_S["代号"]={0,0,2}
    CC.Force_S["名称"]={2,2,14}
    CC.Force_S["状态"]={16,0,2}
    CC.Force_S["君主"]={18,0,2}
    CC.Force_S["官爵"]={20,0,2}
    CC.Force_S["本城"]={22,0,2}
    CC.Force_S["城池"]={24,0,2}
    CC.Force_S["现役"]={26,0,2}
    CC.Force_S["资金"]={28,0,2}
    CC.Force_S["物资"]={30,0,2}
    CC.Force_S["战略"]={32,0,2}
    CC.Force_S["目标"]={34,0,2}
    CC.Force_S["敌意"]={36,0,2}
    CC.Force_S["接壤"]={38,0,2}
	for i=1,6 do
		CC.Force_S["重臣"..i]={38+2*i,0,2}
	end
	for i=1,20 do
		CC.Force_S["状态-剧本"..i]={44+8*i,0,2}
		CC.Force_S["君主-剧本"..i]={46+8*i,0,2}
		CC.Force_S["官爵-剧本"..i]={48+8*i,0,2}
		CC.Force_S["本城-剧本"..i]={50+8*i,0,2}
	end
	
	CC.PersonSize=288;   --每个人物数据占用字节
	CC.Person_S={};      --保存人物数据的结构，以便以后存取
    CC.Person_S["代号"]={0,0,2,true}	--true 实际存储 false 不存储
    CC.Person_S["名称"]={2,2,8,true}
    CC.Person_S["字"]={10,2,4,true}
    CC.Person_S["外号"]={16,2,14,true}
    CC.Person_S["战斗容貌"]={30,0,2,false}
    CC.Person_S["内政容貌"]={32,0,2,false}
    CC.Person_S["容貌"]=CC.Person_S["内政容貌"];
    CC.Person_S["列传"]={34,0,2,true}
    CC.Person_S["性别"]={36,0,1,true}
    CC.Person_S["登场"]={37,0,1,true}
    CC.Person_S["势力"]={38,0,1,true}
    CC.Person_S["忠诚"]={39,1,1,true}
    CC.Person_S["所在"]={40,0,1,true}
    CC.Person_S["武力"]={41,0,1,true}
    CC.Person_S["智谋"]={42,0,1,true}
    CC.Person_S["统率"]={43,0,1,true}
    CC.Person_S["政务"]={44,0,1,true}
    CC.Person_S["魅力"]={45,0,1,true}
    CC.Person_S["武力2"]={46,0,1,true}
    CC.Person_S["智谋2"]={47,0,1,true}
    CC.Person_S["统率2"]={48,0,1,true}
    CC.Person_S["政务2"]={49,0,1,true}
    CC.Person_S["魅力2"]={50,0,1,true}
	for i=1,40 do
		CC.Person_S["技能"..i]={50+i*1,1,1,false}
	end
    CC.Person_S["文武"]={91,0,1,true}
    CC.Person_S["名声"]={92,0,2,true}
    CC.Person_S["功绩"]={94,1,2,true}
    CC.Person_S["台词"]={96,0,1,true}
    CC.Person_S["品级"]={97,0,1,true}
	--
    CC.Person_S["出战"]={98,0,1,true}
	--
    CC.Person_S["相性"]={99,1,1,true}
    CC.Person_S["个人相性"]={100,1,1,true}
    CC.Person_S["个性"]={101,0,1,false}
    CC.Person_S["父亲"] = {102, 0, 2, true}
    CC.Person_S["母亲"] = {104, 0, 2, true}
    CC.Person_S["配偶"] = {106, 0, 2, true}
    CC.Person_S["义兄"] = {108, 0, 2, true}
    CC.Person_S["仇敌"] = {110, 0, 2, true}
    for i = 1, 5 do
      CC.Person_S["亲近武将"..i]={110 + i * 2, 0, 2, false}
      CC.Person_S["厌恶武将"..i]={120 + i * 2, 0, 2, false}
    end
    CC.Person_S["等级"]={132,0,1,true}
    CC.Person_S["经验"]={133,1,1,true}
    CC.Person_S["身份"]={134,0,1,true}
    CC.Person_S["义理"]={135,0,1,true}
    CC.Person_S["爱勇"]={136,0,1,true}
    CC.Person_S["爱才"]={137,0,1,true}
    CC.Person_S["防御"]={138,0,1,true}  --无用,占位
    CC.Person_S["精神"]={139,0,2,true}  --无用,占位
    CC.Person_S["敏捷"]={141,0,2,true}  --无用,占位
    CC.Person_S["好感"]={143,0,2,true}
    CC.Person_S["理想"]={145,0,1,true}
    CC.Person_S["任务态度"]={146,0,1,true}
    CC.Person_S["官爵"]={147,0,2,true}
    CC.Person_S["新官爵"]={149,0,2,true}
    CC.Person_S["敏捷2"]={151,0,2,true}
    CC.Person_S["运气2"]={153,0,2,true}
    CC.Person_S["步兵适性"]={155,0,2,true}
    CC.Person_S["骑兵适性"]={157,0,2,true}
    CC.Person_S["弓兵适性"]={159,0,2,true}
    CC.Person_S["成长"]={161,0,1,false}
    CC.Person_S["生年"]={162,0,2,false}
    CC.Person_S["登场年"]={164,0,2,false}
    CC.Person_S["卒年"]={166,0,2,false}
	for i=1,20 do
		CC.Person_S["登场-剧本"..i]={162+6*i,0,1}
		CC.Person_S["势力-剧本"..i]={163+6*i,0,1}
		CC.Person_S["所在-剧本"..i]={164+6*i,0,1}
		CC.Person_S["忠诚-剧本"..i]={165+6*i,1,1}
		CC.Person_S["功绩-剧本"..i]={166+6*i,1,2}
	end
	
	
	CC.BingzhongSize=157;   --每个兵种数据占用字节
	CC.Bingzhong_S={};      --保存兵种数据的结构，以便以后存取
    CC.Bingzhong_S["代号"]={0,0,2}
    CC.Bingzhong_S["名称"]={2,2,14}
    CC.Bingzhong_S["说明"]={16,2,100}
    CC.Bingzhong_S["贴图"]={116,0,2}
    CC.Bingzhong_S["贴图尺寸"]={118,0,2}
    CC.Bingzhong_S["巨型"]={120,0,1}
    CC.Bingzhong_S["兵系"]={121,0,1}
    CC.Bingzhong_S["攻击力"]={122,0,1}
    CC.Bingzhong_S["远程攻击力"]={123,0,1}
    CC.Bingzhong_S["防御力"]={124,0,1}
    CC.Bingzhong_S["攻速"]={125,0,1}
    CC.Bingzhong_S["射程"]={126,0,1}
	for i=1,15 do
		CC.Bingzhong_S["移动力"..i]={126+1*i,0,1}
	end
	for i=1,15 do
		CC.Bingzhong_S["适性"..i]={141+1*i,0,1}
	end
	
	CC.SceneSize=10;   --每个场景数据占用字节
	CC.Scene_S={};      --保存场景数据的结构，以便以后存取
    CC.Scene_S["代号"]={0,0,2}
    CC.Scene_S["人物"]={2,0,2}
    CC.Scene_S["坐标X"]={4,0,2}
    CC.Scene_S["坐标Y"]={6,0,2}
    CC.Scene_S["类型"]={8,0,2}
	
	CC.WarmapSize=22;
	CC.Warmap_S={};
    CC.Warmap_S["代号"]={0,0,2}
    CC.Warmap_S["名称"]={2,2,14}
    CC.Warmap_S["地图1"]={16,0,2}
    CC.Warmap_S["地图2"]={18,0,2}
    CC.Warmap_S["城位置"]={20,0,2}
	
	CC.CitySize = 186;   --每个City数据占用字节
	CC.City_S={};      --保存City数据的结构，以便以后存取
    CC.City_S["代号"]={0,0,2}
    CC.City_S["名称"]={2,2,14}
    CC.City_S["中地图X"]={16,0,2}
    CC.City_S["中地图Y"]={18,0,2}
    CC.City_S["州"]={20,0,2}
    CC.City_S["地方"]={22,0,2}
    CC.City_S["规模"]={24,0,2}
    CC.City_S["特征"]={26,0,2}
    CC.City_S["势力"]={28,0,2}
    CC.City_S["太守"]={30,0,2}
    CC.City_S["现役"]={32,0,2}
    CC.City_S["在野"]={34,0,2}
    CC.City_S["前线"]={36,0,2}
    CC.City_S["战略价值"]={38,0,2}
    CC.City_S["政略价值"]={40,0,2}
    CC.City_S["开垦担当4"]={42,0,2}
    CC.City_S["开垦担当5"]={44,0,2}
    CC.City_S["商业担当1"]={46,0,2}
    CC.City_S["商业担当2"]={48,0,2}
    CC.City_S["商业担当3"]={50,0,2}
    CC.City_S["商业担当4"]={52,0,2}
    CC.City_S["商业担当5"]={54,0,2}
    CC.City_S["防御担当1"]={56,0,2}
    CC.City_S["防御担当2"]={58,0,2}
    CC.City_S["防御担当3"]={60,0,2}
    CC.City_S["防御担当4"]={62,0,2}
    CC.City_S["防御担当5"]={64,0,2}
    CC.City_S["人口"]={66,0,2}
    CC.City_S["开垦"]={68,0,2}
    CC.City_S["最大开垦"]={70,0,2}
    CC.City_S["商业"]={72,0,2}
    CC.City_S["最大商业"]={74,0,2}
    CC.City_S["技术"]={76,0,2}
    CC.City_S["最大技术"]={78,0,2}
    CC.City_S["防御"]={80,0,2}
    CC.City_S["最大防御"]={82,0,2}
    CC.City_S["治安"]={84,0,2}
    CC.City_S["物资"]={86,0,2}
    CC.City_S["资金"]={88,0,2}
    CC.City_S["兵力"]={90,0,4}
    CC.City_S["士气"]={94,0,2}
    CC.City_S["接壤"]={96,0,2}
    CC.City_S["道路"]={98,0,2}
    CC.City_S["距离"]={100,0,2}
    CC.City_S["音乐"]={102,0,2}
    CC.City_S["标记"]={104,0,2}
	for i=1,20 do
		CC.City_S["势力-剧本"..i]={102+4*i,0,2}
		CC.City_S["太守-剧本"..i]={104+4*i,0,2}
	end
	
	CC.ConnectionSize=18;   --每个Connection数据占用字节
	CC.Connection_S={};      --保存Connection数据的结构，以便以后存取
    CC.Connection_S["代号"]={0,0,2}
    CC.Connection_S["都市1"]={2,0,2}
    CC.Connection_S["都市2"]={4,0,2}
    CC.Connection_S["战场"]={6,0,2}
    CC.Connection_S["战场地图1"]={8,0,2}
    CC.Connection_S["战场地图2"]={10,0,2}
    CC.Connection_S["古战场"]={12,0,2}
    CC.Connection_S["道路"]={14,0,2}
    CC.Connection_S["距离"]={16,0,2}
	
	CC.ItemSize=256;   --每个道具数据占用字节
	CC.Item_S={};      --保存道具数据的结构，以便以后存取
    CC.Item_S["代号"]={0,0,2}
    CC.Item_S["名称"]={2,2,14}
    CC.Item_S["说明"]={16,2,200}
    CC.Item_S["类型"]={216,0,2}
    CC.Item_S["效果"]={218,0,2}
    CC.Item_S["武力"]={220,0,2}
    CC.Item_S["智谋"]={222,0,2}
    CC.Item_S["统率"]={224,0,2}
    CC.Item_S["移动"]={226,0,2}
    CC.Item_S["攻击"]={228,0,2}
    CC.Item_S["策略攻击"]={230,0,2}
    CC.Item_S["防御"]={232,0,2}
    CC.Item_S["需等级"]={234,0,2}
    CC.Item_S["需兵种"]={236,0,2}
    CC.Item_S["需兵种1"]={236,0,2}
    CC.Item_S["需兵种2"]={238,0,2}
    CC.Item_S["需兵种3"]={240,0,2}
    CC.Item_S["需兵种4"]={242,0,2}
    CC.Item_S["需兵种5"]={244,0,2}
    CC.Item_S["需兵种6"]={246,0,2}
    CC.Item_S["需兵种7"]={248,0,2}
    CC.Item_S["价值"]={250,0,2}
    CC.Item_S["装备位"]={252,0,2}
    CC.Item_S["优先级"]={254,0,2}
	
	CC.TitleSize=32;   --每个策略数据占用字节
	CC.Title_S={};      --保存策略数据的结构，以便以后存取
    CC.Title_S["代号"]={0,0,2}
    CC.Title_S["名称"]={2,2,14}
    CC.Title_S["文武"]={16,0,2}
    CC.Title_S["官阶"]={18,0,2}
    CC.Title_S["Rank"]={20,0,2}
    CC.Title_S["人物"]={22,0,2}
    CC.Title_S["保留2"]={24,0,2}
    CC.Title_S["保留3"]={26,0,2}
    CC.Title_S["保留4"]={28,0,2}
    CC.Title_S["保留5"]={30,0,2}

	CC.SkillSize=228;   --每个特技数据占用字节
	CC.Skill_S={};      --保存特技数据的结构，以便以后存取
    CC.Skill_S["代号"]={0,0,2}
    CC.Skill_S["名称"]={2,2,14}
    CC.Skill_S["说明"]={16,2,200}
    CC.Skill_S["参数1"]={216,0,2}
    CC.Skill_S["参数2"]={218,0,2}
    CC.Skill_S["参数3"]={220,0,2}
    CC.Skill_S["参数4"]={222,0,2}
    CC.Skill_S["参数5"]={224,0,2}
    CC.Skill_S["等级"]={226,0,2}
end
