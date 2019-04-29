

-- �����ļ�
--Ϊ�˼򻯴��������ļ�Ҳ��lua��д
--����C�����ȡ�Ĳ�����lua��������Ҫ���������Ĳ�����lua������������Ȼ����jyconst.lua��

CONFIG={};
CONFIG.Debug=1;         --������Ժʹ�����Ϣ��=0����� =1 �����Ϣ��debug.txt��error.txt����ǰĿ¼
CONFIG.Windows=true
local file = io.open(".\\config.lua");
if (file) then
	CONFIG.Windows = true
	CONFIG.CurrentPath =".\\"
	CONFIG.DataPath=CONFIG.CurrentPath .. "data\\";
	CONFIG.PicturePath=CONFIG.CurrentPath .. "pic\\";
	CONFIG.SoundPath=CONFIG.CurrentPath .. "sound\\";
	CONFIG.ScriptPath=CONFIG.CurrentPath .. "script\\";
	CONFIG.JYMain_Lua=CONFIG.ScriptPath .. "jymain.lua";   --lua��������
	CONFIG.FontName=CONFIG.DataPath .. "font.ttf";
	CONFIG.FontName="C:\\windows\\fonts\\simkai.ttf";
	CONFIG.MusicVolume=50;            --���ò������ֵ�����(0-128)
	CONFIG.SoundVolume=50;            --���ò�����Ч������(0-128)
else
	CONFIG.Windows = false
	CONFIG.CurrentPath = config.GetPath();
	CONFIG.DataPath=CONFIG.CurrentPath.."data/";
	CONFIG.PicturePath=CONFIG.CurrentPath.."pic/";
	CONFIG.SoundPath=CONFIG.CurrentPath.."sound/";
	CONFIG.ScriptPath=CONFIG.CurrentPath.."script/";
	CONFIG.JYMain_Lua=CONFIG.ScriptPath .. "jymain.lua"; --lua��������
	CONFIG.FontName=CONFIG.DataPath.."font.ttf";
	CONFIG.MusicVolume=60;
	CONFIG.SoundVolume=60;
end


CONFIG.Width  = 48*20;       -- ��Ϸͼ�δ��ڿ�
CONFIG.Height = 48*12;      -- ��Ϸͼ�δ��ڿ�
CONFIG.bpp  =16          -- ȫ��ʱ����ɫ�һ��Ϊ16����32���ڴ���ģʽʱֱ�Ӳ��õ�ǰ��Ļɫ���������Ч
                         -- ��֧��8λɫ�Ϊ����ٶȣ�����ʹ��16λɫ�
						 -- 24λδ�������ԣ�����֤��ȷ��ʾ
CONFIG.EnableSound=1     -- �Ƿ������    1 �� 0 �ر�   �ر�������Ϸ���޷���
CONFIG.MP3 = 1
CONFIG.FullScreen=0      -- ����ʱ�Ƿ�ȫ��  1 ȫ�� 0 ����
CONFIG.KeyRepeat=0       -- �Ƿ񼤻�����ظ� 0 �����ֻ����·�˵�ʱ�����ظ���1��������Ի�������ʱ����̾��ظ�
CONFIG.KeyRepeatDelay =300;   --��һ�μ����ظ��ȴ�ms��
CONFIG.KeyRePeatInterval=30;  --һ�����ظ�����

CONFIG.OSCharSet=0      -- ��ʾ�ַ��� 0 ���� 1 ����




     --��ͼ����������һ��500-1000�������debug.txt�о�������"pic cache is full"�������ʵ�����
    CONFIG.MAXCacheNum=2000;
	CONFIG.CleanMemory=0;         --�����л�ʱ�Ƿ�����lua�ڴ档0 ������ 1 ����
	CONFIG.LoadFullS=1;           --1 ����S*�ļ������ڴ� 0 ֻ���뵱ǰ����������S*��4M�࣬�������Խ�Լ�ܶ��ڴ�
	CONFIG.LoadMMapType=0;        --��������ͼ�ļ�(5��002�ļ�)������  0 ȫ������ 1 �������Ǹ������� 2 �������Ǹ������к���
	                              --����2ռ���ڴ����٣��������ֻ����豸������ʱ��ϳ����������߶�ʱ�Ῠһ��
								  --����1ռ���ڴ�϶࣬����ʱ���2Ҫ�٣�һ�㲻���п��ĸо�

	CONFIG.PreLoadPicGrp=1;       --1 Ԥ������ͼ�ļ�*.grp, 0 ��Ԥ���ء�Ԥ���ؿ��Ա�����·ż��ͣ�ٺ�ս������ͣ�١���ռ���ڴ�
	
	
	
	CONFIG.Operation = 1
	CONFIG.Type= 1
	CONFIG.XScale = 18 -- ��ͼ��ȵ�һ��
	CONFIG.YScale = 9 -- ��ͼ�߶ȵ�һ��
	CONFIG.MidSF2 = "";
	CONFIG.MMapAddX=2;
	CONFIG.MMapAddY=2;
	CONFIG.SMapAddX=2;
	CONFIG.SMapAddY=16;
	CONFIG.WMapAddX=2;
	CONFIG.WMapAddY=16;

--������λ�ã�-1ΪĬ��λ��
CONFIG.W=CONFIG.Width
CONFIG.H=CONFIG.Height
CONFIG.Zoom = 100
CONFIG.D1X = math.modf(CONFIG.W/8.5)  --��
CONFIG.D1Y = math.modf(CONFIG.H/2.4)
CONFIG.D2X = math.modf(CONFIG.W/4.2)  --��
CONFIG.D2Y = math.modf(CONFIG.H/1.6)
CONFIG.D3X = math.modf(CONFIG.W/8.5) --��
CONFIG.D3Y = math.modf(CONFIG.H/1.2)
CONFIG.D4X = 0; --��
CONFIG.D4Y = math.modf(CONFIG.H/1.6)
CONFIG.C1X = math.modf(CONFIG.W/1.6) --S
CONFIG.C1Y = 0
CONFIG.C2X = math.modf(CONFIG.W/1.16) --H
CONFIG.C2Y = 0
CONFIG.AX = math.modf(CONFIG.W/1.82) --esc
CONFIG.AY = math.modf(CONFIG.H/1.2)
CONFIG.BX = math.modf(CONFIG.W/1.28) --�ո�
CONFIG.BY = math.modf(CONFIG.H/1.16)