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

	CC.ScreenW = CONFIG.Width;          --显示窗口宽高
	CC.ScreenH = CONFIG.Height;
	CC.ScreenW2 = CC.ScreenW / 2;
	CC.ScreenH2 = CC.ScreenH / 2;
	CC.CardWidth = 90--112
	CC.CardHeight = 128--156
	CC.Direction = {'上','右','下','左'}
	CC.DirectX={0, 1, 0, -1};  --不同方向x，y的加减值，用于走路改变坐标值
	CC.DirectY={-1, 0, 1, 0};
	--各种贴图文件名。
	CC.PaletteFile = CONFIG.ImagePath .. "mmap.col"
	CC.MMAPPicFile = {CONFIG.ImagePath .. "mmap.idx", CONFIG.ImagePath .. "mmap.grp"}
	CC.SMAPPicFile = {CONFIG.ImagePath .. "smap.idx", CONFIG.ImagePath .. "smap.grp"}
	CC.WMAPPicFile = {CONFIG.ImagePath .. "wmap.idx", CONFIG.ImagePath .. "wmap.grp"}
	CC.EFT = {CONFIG.ImagePath .. "eft.idx", CONFIG.ImagePath .. "eft.grp"}
	CC.HeadPicFile = {CONFIG.ImagePath .. "hdgrp.idx", CONFIG.ImagePath .. "hdgrp.grp"}
	CC.UIPicFile = {CONFIG.ImagePath .. "ui.idx", CONFIG.ImagePath .. "ui.grp"}

	CC.BGMFile = CONFIG.MusicPath .. "%02d.ogg"
	CC.ATKFile = CONFIG.SoundPath .. "atk%02d.wav"
	CC.EFile = CONFIG.SoundPath .. "Se%02d.wav"

	CC.TmxFilename = CONFIG.TmxPath .. "%03d.tmx"
	CC.SnrFilename = CONFIG.SnrPath .. "SNR%d-%d.txt"
	CC.FontTxtFilename = CONFIG.DataPath .. "font.tsv"
	CC.RoleTxtFilename = CONFIG.DataPath .. "role.tsv"
	CC.TrickTxtFilename = CONFIG.DataPath .. "trick.tsv"
	CC.CityTxtFilename = CONFIG.DataPath .. "city.tsv"
	CC.UnitTxtFilename = CONFIG.DataPath .. "unit.tsv"
	CC.TerrainTxtFilename = CONFIG.DataPath .. "terrain.tsv"
	CC.UnitTerrainTxtFilename = CONFIG.DataPath .. "unit_terrain.tsv"
	CC.UnitSkinTxtFilename = CONFIG.DataPath .. "unit_skin.tsv"

	CC.MaxLv = 50
	CC.MaxItemNum = 15
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
	CC.ConfirmPic = {
		['是'] = 12,
		['否'] = 15,
		['关闭'] = 18,
		['返回'] = 21,
		['决定'] = 24,
		['确认'] = 27,
	}

	CC.AtkArea = {
		[1] = {
			-- -#-
			-- #X#
			-- -#-
			{x = 0, y = -1},
			{x = 1, y = 0},
			{x = 0, y = 1},
			{x = -1, y = 0},
		},
		[2] = {
			-- ###
			-- #X#
			-- ###
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
			-- --#--
			-- -###-
			-- ##X##
			-- -###-
			-- --#--
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
			-- -###-
			-- #####
			-- ##X##
			-- #####
			-- -###-
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
			-- --#--
			-- -----
			-- #-X-#
			-- -----
			-- --#--
			{x = 0, y = -2},
			{x = 2, y = 0},
			{x = 0, y = 2},
			{x = -2, y = 0},
		},
		[6] = {
			-- --#--
			-- -#-#-
			-- #-X-#
			-- -#-#-
			-- --#--
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
			-- -###-
			-- ##-##
			-- #-X-#
			-- ##-##
			-- -###-
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
			-- ---#---
			-- --###--
			-- -##-##-
			-- ##-X-##
			-- -##-##-
			-- --###--
			-- ---#---
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
			-- ---#---
			-- -#####-
			-- -##-##-
			-- ##-X-##
			-- -##-##-
			-- -#####-
			-- ---#---
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
	CC.Font = {}
end
