
--����ȫ�ֱ���CC��������Ϸ��ʹ�õĳ���
function SetGlobalConst()
    -- SDL ���붨�壬����������Ȼʹ��directx������
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
	else           --��ת90��
		VK_UP=SDLK_RIGHT;
		VK_DOWN=SDLK_LEFT;
		VK_LEFT=SDLK_UP;
		VK_RIGHT=SDLK_DOWN;
	end

	-- ��Ϸ����ɫ����
	C_STARTMENU=RGB(132, 0, 4)            -- ��ʼ�˵���ɫ
	C_RED=RGB(216, 20, 24)                -- ��ʼ�˵�ѡ������ɫ

	C_WHITE=RGB(236, 236, 236);           --��Ϸ�ڳ��õļ�����ɫֵ
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
	-- ��Ϸ״̬����
	GAME_START =0       --��ʼ����,����ѡ�����¼�������
	GAME_SMAP_AUTO =1;       --������ͼ����ֹ��Ҳ������¼�����
	GAME_SMAP_MANUAL =2;       --������ͼ��������Ҳ������¼�����
	GAME_MMAP =3;       --���ͼ����ֹ��Ҳ������¼�����
	GAME_WMAP =4;       --ս����ͼ���¼�����
	GAME_WMAP2 =5;       --ս����ͼ����������ս��
	GAME_DEAD =6;       --��������
	GAME_END  =7;       --����
	GAME_WARWIN  =8;       --ս��ʤ��
	GAME_WARLOSE  =9;       --ս��ʧ��
	--ս���¼�����
	War_Event_Action=0;		--�����ж���
	War_Event_TurnM=1;		--�غϿ�ʼʱ �Ҿ�
	War_Event_TurnF=2;		--�غϿ�ʼʱ �Ѿ�
	War_Event_TurnE=3;		--�غϿ�ʼʱ �о�
	--��Ϸ����ȫ�ֱ���
	CC={};      --������Ϸ��ʹ�õĳ�������Щ�������޸���Ϸʱ�޸�֮
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
		
	CC.SrcCharSet=0;         --Դ������ַ��� 0 gb  1 big5������ת��R���� ���Դ�뱻ת��Ϊbig5����Ӧ��Ϊ1
	CC.OSCharSet=CONFIG.OSCharSet;         --OS �ַ�����0 GB, 1 Big5
	CC.FontName=CONFIG.FontName;    --��ʾ����

	CC.ScreenW=CONFIG.Width;          --��ʾ���ڿ��
	CC.ScreenH=CONFIG.Height;
	CC.ScreenW2 = CC.ScreenW / 2;
	CC.ScreenH2 = CC.ScreenH / 2;
	CC.CardWidth = 90--112
	CC.CardHeight = 128--156
	CC.Direction = {'��','��','��','��'}
	CC.DirectX={0, 1, 0, -1};  --��ͬ����x��y�ļӼ�ֵ��������·�ı�����ֵ
	CC.DirectY={-1, 0, 1, 0};
	CC.TmxFilename = CONFIG.TmxPath .. "%03d.tmx"
	CC.SnrFilename = CONFIG.SnrPath .. "SNR%d-%d.txt"
	CC.RoleTxtFilename = CONFIG.DataPath .. "role.txt"
	CC.CityTxtFilename = CONFIG.DataPath .. "city.txt"
	CC.UnitTxtFilename = CONFIG.DataPath .. "unit.txt"
	CC.TerrainTxtFilename = CONFIG.DataPath .. "terrain.txt"
	CC.UnitTerrainTxtFilename = CONFIG.DataPath .. "unit_terrain.txt"

	CC.MaxLv = 50
	CC.MaxItemNum = 15

	CC.WarName = {
		'������ս��', '��Ұ��ս��', '���ļ���ս', '������ս��', '���ս��',
		'�����ϲ�ս�ۢ�', '����ء����ȹ�ս��', '��ˮս��', '���ս��', '����ս��',
		'��ƽ��ս��', '�����ϲ�ս��', '��Ϫ��ս��', '��ɽ��ս��', '��ˮս��',
		'������ս��', 'ͺ����ս��', '������ս��', '����ս��', '��Ҷ��ս��',
		'���߹�ս��', '����ɽս��', '�ϰ�������ս��', '��ˮ��ս��', '����ս��',
		'��ɽս�ۢ�', '��ƽ��ս��', '��ͤս��', '���г���ս', '�²֡���ɽս��',
		'�²ֹ���ս', '��ɽ׷��ս', '���ȵ�ս��', '��ɽս�ۢ�', 'μˮս��',
		'��«��ս��', '����ԭս��', 'ü��ս��', '�书ս��', '��������ս��',
		'����ս��', '�׵۳�ս��', '����ս��', '�ɶ�����ս��', '����ս��',
		'��������ս��', '��ɽս��', '���ȹ�ս��', '����ս�ۢ�', '����ս�ۢ�'
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
	CC.SpWidth[13624] = 0.5	--�ո�


	CC.MapFile=CONFIG.DataPath .. "HEXZMAP.R3";


	--������ͼ�ļ�����
	CC.MMAPPicFile={CONFIG.DataPath .. "mmap.idx",CONFIG.DataPath .. "mmap.grp"};
	CC.SMAPPicFile={CONFIG.DataPath .. "smap.idx",CONFIG.DataPath .. "smap.grp"};
	CC.WMAPPicFile={CONFIG.DataPath .. "wmap.idx",CONFIG.DataPath .. "wmap.grp"};
	CC.EFT={CONFIG.DataPath .. "eft.idx",CONFIG.DataPath .. "eft.grp"};
	CC.FightPicFile={CONFIG.DataPath .. "fight%03d.idx",CONFIG.DataPath .. "fight%03d.grp"};  --�˴�Ϊ�ַ�����ʽ��������C��printf�ĸ�ʽ��

	CC.HeadPicFile={CONFIG.DataPath .. "hdgrp.idx",CONFIG.DataPath .. "hdgrp.grp"};
	CC.UIPicFile={CONFIG.DataPath .. "ui.idx",CONFIG.DataPath .. "ui.grp"};
	CC.ThingPicFile={CONFIG.DataPath .. "thing.idx",CONFIG.DataPath .. "thing.grp"};


	CC.BGMFile=CONFIG.MusicPath .. "%02d.mp3";
	CC.ATKFile=CONFIG.SoundPath .. "atk%02d.wav";
	CC.EFile=CONFIG.SoundPath .. "Se%02d.wav";

	CC.Skill = {
		[1] = {
			name = '����һ��',
			sesc = '����������һ�����ض���ɱ���',
		},
		[2] = {
			name = 'ͻ��',
			sesc = '',
		},
		[3] = {
			name = '��ɨ',
			sesc = '',
		},
		[4] = {
			name = '����',
			sesc = '',
		},
		[5] = {
			name = 'Զ��',
			sesc = '',
		},
		[6] = {
			name = '���',
			sesc = 'ʹ��Χ�ڵо���ö��ָ���״̬���ɹ�����˫�����������',
		},
		[7] = {
			name = '�ϵ���',
			sesc = 'һ�غ��ڣ�������ʱ�����Ʒ�����������ʹ�о����ң��ɹ�����˫�����������',
		},
		[8] = {
			name = 'ǿ��',
			sesc = '',
		},
		[9] = {
			name = '�ٹ�',
			sesc = '',
		},
		[10] = {
			name = '�����۷�',
			sesc = '�ƶ���ָ��λ�ã�ͬʱ�����ƶ�·�������ео�',
		},
	}
	

	CC.RowPixel=4         -- ÿ���ֵļ��������

	CC.MenuBorderPixel=5  -- �˵����ܱ߿�������������Ҳ���ڻ����ַ�����box������������
	CC.MouseClickType=0;	--0 ����1��2��1ֻ����ʼ���λ�ã� 2ֻ��������ͷ�λ��
	CC.OpearteSpeed=4	--��Ϸ������Ӧ�ٶ�
	CC.WarDelay=1	--ս��������Ӧ�ٶ�
	CC.FrameNum = 20;	--֡�� baseline 40
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
					[99]={1,1,1,1,1,1,1,1,1,1,1,1},	--����ȫ����Ԥ����
				}
	CC.Shiqi=	{
					["����"]	={[0]=1,1,1,2,0,0,0,0,0,0},
					["������"]	={[0]=-2,-1,-1,-1,0,0,0,0,0,0},
					["����"]	={[0]=2,1,0,0,0,0,0,0,0,0},
					["������"]	={[0]=-1,-1,0,-1,0,0,0,0,0,0},
					["����"]	={[0]=3,3,3,3,0,0,0,0,0,0},
				}
	CC.Font={};
	--S.RGP
	War={};
	Pic={};
    Drama={};
    


    
   
   --�����¼�ļ�����S��D�����ǹ̶���С����˲��ٶ���idx�ˡ�
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
   CC.S_Filename={[0]=CONFIG.DataPath .. "allsin.grp",
                  CONFIG.DataPath .. "s1.grp",
				  CONFIG.DataPath .. "s2.grp",
				  CONFIG.DataPath .. "s3.grp",};

   CC.TempS_Filename=CONFIG.DataPath .. "allsinbk.grp";

   CC.D_Filename={[0]=CONFIG.DataPath .. "alldef.grp",
                   CONFIG.DataPath .. "d1.grp",
				   CONFIG.DataPath .. "d2.grp",
				   CONFIG.DataPath .. "d3.grp",};

   CC.PaletteFile=CONFIG.DataPath .. "mmap.col";
   CC.SavedataFile=CONFIG.DataPath .. "savedata.grp";
   CC.FirstFile=CONFIG.PicturePath .. "title.png";
   CC.DeadFile=CONFIG.PicturePath .. "dead.png";
   CC.MMapFile={CONFIG.DataPath .. "earth.002",
                CONFIG.DataPath .. "surface.002",
				CONFIG.DataPath .. "building.002",
		        CONFIG.DataPath .. "buildx.002",
				CONFIG.DataPath .. "buildy.002"};
    CC.WarFile=CONFIG.DataPath .. "war.sta";
    CC.WarMapFile={CONFIG.DataPath .. "warfld.idx",
                    CONFIG.DataPath .. "warfld.grp"};
    
    CC.TalkIdxFile=CONFIG.ScriptPath .. "oldtalk.idx";
    CC.TalkGrpFile=CONFIG.ScriptPath .. "oldtalk.grp";
   
	--�����¼�ļ�R���ṹ��  lua��֧�ֽṹ���޷�ֱ�ӴӶ������ļ��ж�ȡ�������Ҫ��Щ���壬��table�в�ͬ������������ṹ��
	CC.MyThingNum=200      --������Ʒ����
	CC.Kungfunum=5		--��ɫ�书����
	CC.MaxKungfuNum=80
	CC.Base_S={};         --����������ݵĽṹ���Ա��Ժ��ȡ
	CC.Base_S["����"]={0,2,14};	--nouse
	CC.Base_S["�½���"]={14,2,28};	--�½���
	CC.Base_S["ʱ��"]={42,2,14};	--�浵����ʱ��
	CC.Base_S["δʹ��"]={56,2,14};	--nouse
	CC.Base_S["���ڵ�"]={70,2,14};
	CC.Base_S["����"]={70,0,2};
	CC.Base_S["�ж���"]={72,0,2};
	CC.Base_S["����ǳ�"]={82,0,2};
	CC.Base_S["��ǰ״̬"]={84,0,2};
	CC.Base_S["��ǰ�¼�"]={86,0,2};
	CC.Base_S["��ǰ����"]={88,0,2};
	CC.Base_S["��ǰ����"]={90,0,2};
	CC.Base_S["��ǰ����"]={92,0,2};
	CC.Base_S["��ǰ�ǳ�"]={94,0,2};
	CC.Base_S["��ǰ��"]={96,0,2};
	CC.Base_S["��ǰ��"]={98,0,2};
	CC.Base_S["��ǰ�籾"]={100,0,2};
	CC.Base_S["��Ϸ�Ѷ�"]={102,0,2};
	CC.Base_S["ս���浵"]={104,0,2};
	CC.Base_S["�����汾"]={106,0,2};
	CC.Base_S["��̬�ȼ�"]={108,0,2};
	CC.Base_S["��ҵ"]={110,0,2};
	CC.Base_S["ũҵ"]={112,0,2};
	CC.Base_S["����"]={114,0,2};
	CC.Base_S["�ʽ�"]={116,1,2};
	CC.Base_S["����"]={120,1,2};
	CC.Base_S["�ʽ���֧"]={124,0,2};
	CC.Base_S["������֧"]={126,0,2};
	CC.Base_S["��������"]={128,0,2};
	CC.Base_S["��ı����"]={130,0,2};
	CC.Base_S["ͳ�ʾ���"]={132,0,2};
	CC.Base_S["������"]={134,0,2};
	CC.Base_S["��������"]={136,0,2};
	CC.Base_S["ս������"]={150,2,50};	--
	CC.Base_S["ս��Ŀ��"]={200,2,100};	--
	for i=1,15 do
		CC.Base_S["��������" .. i]={128+2*(i-1),0,2};
	end
	for i=1,CC.MyThingNum do
		CC.Base_S["��Ʒ����" .. i]={162+2*(i-1),0,2};
	end
	for i=1,2000 do
		CC.Base_S["ս���¼�" .. i]={1762+2*(i-1),0,2};
	end
	for i=0,2000-1 do
		CC.Base_S["�¼�" .. i]={2162+2*i,0,2};
	end
   
    CC.WarDataSize=186;         --ս�����ݴ�С  war.sta���ݽṹ
    CC.WarData_S={};        --ս�����ݽṹ
    CC.WarData_S["����"]={0,0,2};
    CC.WarData_S["����"]={2,2,10};
    CC.WarData_S["��ͼ"]={12,0,2};
    CC.WarData_S["����"]={14,0,2};
    CC.WarData_S["����"]={16,0,2};
    for i=1,6 do
        CC.WarData_S["�ֶ�ѡ���ս��"  .. i]={18+(i-1)*2,0,2};
        CC.WarData_S["�Զ�ѡ���ս��"  .. i]={30+(i-1)*2,0,2};
        CC.WarData_S["�ҷ�X"  .. i]={42+(i-1)*2,0,2};
        CC.WarData_S["�ҷ�Y"  .. i]={54+(i-1)*2,0,2};
    end
    for i=1,20 do
        CC.WarData_S["����"  .. i]={66+(i-1)*2,0,2};
        CC.WarData_S["�з�X"  .. i]={106+(i-1)*2,0,2};
        CC.WarData_S["�з�Y"  .. i]={146+(i-1)*2,0,2};
    end
   --
	CC.ForceSize=212;   --ÿ��Force����ռ���ֽ�
	CC.Force_S={};      --����Force���ݵĽṹ���Ա��Ժ��ȡ
    CC.Force_S["����"]={0,0,2}
    CC.Force_S["����"]={2,2,14}
    CC.Force_S["״̬"]={16,0,2}
    CC.Force_S["����"]={18,0,2}
    CC.Force_S["�پ�"]={20,0,2}
    CC.Force_S["����"]={22,0,2}
    CC.Force_S["�ǳ�"]={24,0,2}
    CC.Force_S["����"]={26,0,2}
    CC.Force_S["�ʽ�"]={28,0,2}
    CC.Force_S["����"]={30,0,2}
    CC.Force_S["ս��"]={32,0,2}
    CC.Force_S["Ŀ��"]={34,0,2}
    CC.Force_S["����"]={36,0,2}
    CC.Force_S["����"]={38,0,2}
	for i=1,6 do
		CC.Force_S["�س�"..i]={38+2*i,0,2}
	end
	for i=1,20 do
		CC.Force_S["״̬-�籾"..i]={44+8*i,0,2}
		CC.Force_S["����-�籾"..i]={46+8*i,0,2}
		CC.Force_S["�پ�-�籾"..i]={48+8*i,0,2}
		CC.Force_S["����-�籾"..i]={50+8*i,0,2}
	end
	
	CC.PersonSize=288;   --ÿ����������ռ���ֽ�
	CC.Person_S={};      --�����������ݵĽṹ���Ա��Ժ��ȡ
    CC.Person_S["����"]={0,0,2,true}	--true ʵ�ʴ洢 false ���洢
    CC.Person_S["����"]={2,2,8,true}
    CC.Person_S["��"]={10,2,4,true}
    CC.Person_S["���"]={16,2,14,true}
    CC.Person_S["ս����ò"]={30,0,2,false}
    CC.Person_S["������ò"]={32,0,2,false}
    CC.Person_S["��ò"]=CC.Person_S["������ò"];
    CC.Person_S["�д�"]={34,0,2,true}
    CC.Person_S["�Ա�"]={36,0,1,true}
    CC.Person_S["�ǳ�"]={37,0,1,true}
    CC.Person_S["����"]={38,0,1,true}
    CC.Person_S["�ҳ�"]={39,1,1,true}
    CC.Person_S["����"]={40,0,1,true}
    CC.Person_S["����"]={41,0,1,true}
    CC.Person_S["��ı"]={42,0,1,true}
    CC.Person_S["ͳ��"]={43,0,1,true}
    CC.Person_S["����"]={44,0,1,true}
    CC.Person_S["����"]={45,0,1,true}
    CC.Person_S["����2"]={46,0,1,true}
    CC.Person_S["��ı2"]={47,0,1,true}
    CC.Person_S["ͳ��2"]={48,0,1,true}
    CC.Person_S["����2"]={49,0,1,true}
    CC.Person_S["����2"]={50,0,1,true}
	for i=1,40 do
		CC.Person_S["����"..i]={50+i*1,1,1,false}
	end
    CC.Person_S["����"]={91,0,1,true}
    CC.Person_S["����"]={92,0,2,true}
    CC.Person_S["����"]={94,1,2,true}
    CC.Person_S["̨��"]={96,0,1,true}
    CC.Person_S["Ʒ��"]={97,0,1,true}
	--
    CC.Person_S["��ս"]={98,0,1,true}
	--
    CC.Person_S["����"]={99,1,1,true}
    CC.Person_S["��������"]={100,1,1,true}
    CC.Person_S["����"]={101,0,1,false}
    CC.Person_S["����"] = {102, 0, 2, true}
    CC.Person_S["ĸ��"] = {104, 0, 2, true}
    CC.Person_S["��ż"] = {106, 0, 2, true}
    CC.Person_S["����"] = {108, 0, 2, true}
    CC.Person_S["���"] = {110, 0, 2, true}
    for i = 1, 5 do
      CC.Person_S["�׽��佫"..i]={110 + i * 2, 0, 2, false}
      CC.Person_S["����佫"..i]={120 + i * 2, 0, 2, false}
    end
    CC.Person_S["�ȼ�"]={132,0,1,true}
    CC.Person_S["����"]={133,1,1,true}
    CC.Person_S["���"]={134,0,1,true}
    CC.Person_S["����"]={135,0,1,true}
    CC.Person_S["����"]={136,0,1,true}
    CC.Person_S["����"]={137,0,1,true}
    CC.Person_S["����"]={138,0,1,true}  --����,ռλ
    CC.Person_S["����"]={139,0,2,true}  --����,ռλ
    CC.Person_S["����"]={141,0,2,true}  --����,ռλ
    CC.Person_S["�ø�"]={143,0,2,true}
    CC.Person_S["����"]={145,0,1,true}
    CC.Person_S["����̬��"]={146,0,1,true}
    CC.Person_S["�پ�"]={147,0,2,true}
    CC.Person_S["�¹پ�"]={149,0,2,true}
    CC.Person_S["����2"]={151,0,2,true}
    CC.Person_S["����2"]={153,0,2,true}
    CC.Person_S["��������"]={155,0,2,true}
    CC.Person_S["�������"]={157,0,2,true}
    CC.Person_S["��������"]={159,0,2,true}
    CC.Person_S["�ɳ�"]={161,0,1,false}
    CC.Person_S["����"]={162,0,2,false}
    CC.Person_S["�ǳ���"]={164,0,2,false}
    CC.Person_S["����"]={166,0,2,false}
	for i=1,20 do
		CC.Person_S["�ǳ�-�籾"..i]={162+6*i,0,1}
		CC.Person_S["����-�籾"..i]={163+6*i,0,1}
		CC.Person_S["����-�籾"..i]={164+6*i,0,1}
		CC.Person_S["�ҳ�-�籾"..i]={165+6*i,1,1}
		CC.Person_S["����-�籾"..i]={166+6*i,1,2}
	end
	
	
	CC.BingzhongSize=157;   --ÿ����������ռ���ֽ�
	CC.Bingzhong_S={};      --����������ݵĽṹ���Ա��Ժ��ȡ
    CC.Bingzhong_S["����"]={0,0,2}
    CC.Bingzhong_S["����"]={2,2,14}
    CC.Bingzhong_S["˵��"]={16,2,100}
    CC.Bingzhong_S["��ͼ"]={116,0,2}
    CC.Bingzhong_S["��ͼ�ߴ�"]={118,0,2}
    CC.Bingzhong_S["����"]={120,0,1}
    CC.Bingzhong_S["��ϵ"]={121,0,1}
    CC.Bingzhong_S["������"]={122,0,1}
    CC.Bingzhong_S["Զ�̹�����"]={123,0,1}
    CC.Bingzhong_S["������"]={124,0,1}
    CC.Bingzhong_S["����"]={125,0,1}
    CC.Bingzhong_S["���"]={126,0,1}
	for i=1,15 do
		CC.Bingzhong_S["�ƶ���"..i]={126+1*i,0,1}
	end
	for i=1,15 do
		CC.Bingzhong_S["����"..i]={141+1*i,0,1}
	end
	
	CC.SceneSize=10;   --ÿ����������ռ���ֽ�
	CC.Scene_S={};      --���泡�����ݵĽṹ���Ա��Ժ��ȡ
    CC.Scene_S["����"]={0,0,2}
    CC.Scene_S["����"]={2,0,2}
    CC.Scene_S["����X"]={4,0,2}
    CC.Scene_S["����Y"]={6,0,2}
    CC.Scene_S["����"]={8,0,2}
	
	CC.WarmapSize=22;
	CC.Warmap_S={};
    CC.Warmap_S["����"]={0,0,2}
    CC.Warmap_S["����"]={2,2,14}
    CC.Warmap_S["��ͼ1"]={16,0,2}
    CC.Warmap_S["��ͼ2"]={18,0,2}
    CC.Warmap_S["��λ��"]={20,0,2}
	
	CC.CitySize = 186;   --ÿ��City����ռ���ֽ�
	CC.City_S={};      --����City���ݵĽṹ���Ա��Ժ��ȡ
    CC.City_S["����"]={0,0,2}
    CC.City_S["����"]={2,2,14}
    CC.City_S["�е�ͼX"]={16,0,2}
    CC.City_S["�е�ͼY"]={18,0,2}
    CC.City_S["��"]={20,0,2}
    CC.City_S["�ط�"]={22,0,2}
    CC.City_S["��ģ"]={24,0,2}
    CC.City_S["����"]={26,0,2}
    CC.City_S["����"]={28,0,2}
    CC.City_S["̫��"]={30,0,2}
    CC.City_S["����"]={32,0,2}
    CC.City_S["��Ұ"]={34,0,2}
    CC.City_S["ǰ��"]={36,0,2}
    CC.City_S["ս�Լ�ֵ"]={38,0,2}
    CC.City_S["���Լ�ֵ"]={40,0,2}
    CC.City_S["���ѵ���4"]={42,0,2}
    CC.City_S["���ѵ���5"]={44,0,2}
    CC.City_S["��ҵ����1"]={46,0,2}
    CC.City_S["��ҵ����2"]={48,0,2}
    CC.City_S["��ҵ����3"]={50,0,2}
    CC.City_S["��ҵ����4"]={52,0,2}
    CC.City_S["��ҵ����5"]={54,0,2}
    CC.City_S["��������1"]={56,0,2}
    CC.City_S["��������2"]={58,0,2}
    CC.City_S["��������3"]={60,0,2}
    CC.City_S["��������4"]={62,0,2}
    CC.City_S["��������5"]={64,0,2}
    CC.City_S["�˿�"]={66,0,2}
    CC.City_S["����"]={68,0,2}
    CC.City_S["��󿪿�"]={70,0,2}
    CC.City_S["��ҵ"]={72,0,2}
    CC.City_S["�����ҵ"]={74,0,2}
    CC.City_S["����"]={76,0,2}
    CC.City_S["�����"]={78,0,2}
    CC.City_S["����"]={80,0,2}
    CC.City_S["������"]={82,0,2}
    CC.City_S["�ΰ�"]={84,0,2}
    CC.City_S["����"]={86,0,2}
    CC.City_S["�ʽ�"]={88,0,2}
    CC.City_S["����"]={90,0,4}
    CC.City_S["ʿ��"]={94,0,2}
    CC.City_S["����"]={96,0,2}
    CC.City_S["��·"]={98,0,2}
    CC.City_S["����"]={100,0,2}
    CC.City_S["����"]={102,0,2}
    CC.City_S["���"]={104,0,2}
	for i=1,20 do
		CC.City_S["����-�籾"..i]={102+4*i,0,2}
		CC.City_S["̫��-�籾"..i]={104+4*i,0,2}
	end
	
	CC.ConnectionSize=18;   --ÿ��Connection����ռ���ֽ�
	CC.Connection_S={};      --����Connection���ݵĽṹ���Ա��Ժ��ȡ
    CC.Connection_S["����"]={0,0,2}
    CC.Connection_S["����1"]={2,0,2}
    CC.Connection_S["����2"]={4,0,2}
    CC.Connection_S["ս��"]={6,0,2}
    CC.Connection_S["ս����ͼ1"]={8,0,2}
    CC.Connection_S["ս����ͼ2"]={10,0,2}
    CC.Connection_S["��ս��"]={12,0,2}
    CC.Connection_S["��·"]={14,0,2}
    CC.Connection_S["����"]={16,0,2}
	
	CC.ItemSize=256;   --ÿ����������ռ���ֽ�
	CC.Item_S={};      --����������ݵĽṹ���Ա��Ժ��ȡ
    CC.Item_S["����"]={0,0,2}
    CC.Item_S["����"]={2,2,14}
    CC.Item_S["˵��"]={16,2,200}
    CC.Item_S["����"]={216,0,2}
    CC.Item_S["Ч��"]={218,0,2}
    CC.Item_S["����"]={220,0,2}
    CC.Item_S["��ı"]={222,0,2}
    CC.Item_S["ͳ��"]={224,0,2}
    CC.Item_S["�ƶ�"]={226,0,2}
    CC.Item_S["����"]={228,0,2}
    CC.Item_S["���Թ���"]={230,0,2}
    CC.Item_S["����"]={232,0,2}
    CC.Item_S["��ȼ�"]={234,0,2}
    CC.Item_S["�����"]={236,0,2}
    CC.Item_S["�����1"]={236,0,2}
    CC.Item_S["�����2"]={238,0,2}
    CC.Item_S["�����3"]={240,0,2}
    CC.Item_S["�����4"]={242,0,2}
    CC.Item_S["�����5"]={244,0,2}
    CC.Item_S["�����6"]={246,0,2}
    CC.Item_S["�����7"]={248,0,2}
    CC.Item_S["��ֵ"]={250,0,2}
    CC.Item_S["װ��λ"]={252,0,2}
    CC.Item_S["���ȼ�"]={254,0,2}
	
	CC.TitleSize=32;   --ÿ����������ռ���ֽ�
	CC.Title_S={};      --����������ݵĽṹ���Ա��Ժ��ȡ
    CC.Title_S["����"]={0,0,2}
    CC.Title_S["����"]={2,2,14}
    CC.Title_S["����"]={16,0,2}
    CC.Title_S["�ٽ�"]={18,0,2}
    CC.Title_S["Rank"]={20,0,2}
    CC.Title_S["����"]={22,0,2}
    CC.Title_S["����2"]={24,0,2}
    CC.Title_S["����3"]={26,0,2}
    CC.Title_S["����4"]={28,0,2}
    CC.Title_S["����5"]={30,0,2}

	CC.SkillSize=228;   --ÿ���ؼ�����ռ���ֽ�
	CC.Skill_S={};      --�����ؼ����ݵĽṹ���Ա��Ժ��ȡ
    CC.Skill_S["����"]={0,0,2}
    CC.Skill_S["����"]={2,2,14}
    CC.Skill_S["˵��"]={16,2,200}
    CC.Skill_S["����1"]={216,0,2}
    CC.Skill_S["����2"]={218,0,2}
    CC.Skill_S["����3"]={220,0,2}
    CC.Skill_S["����4"]={222,0,2}
    CC.Skill_S["����5"]={224,0,2}
    CC.Skill_S["�ȼ�"]={226,0,2}
end
