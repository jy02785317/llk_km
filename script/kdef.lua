--[[
SceneID
-1	����
0	���ͼ
43	����ܲٹ�ۡ
45	�������t��ۡ
48	��ƽ������
54	ƽԭ������/����/С��/����/����/�ų�
63	�ܲپ�Ӫ��
66	��� �ܲٻ�԰
77	��������ۡ
83	����������
84	�������
85	��������/���������
86	����������/����
87	�Ŷ�������
89	��������׵ۣ�
85	���������׿������
92	����������
97	�㴨Ӫ��/����
95	����Ӫ��/����/Ԭ�B
]]--

Event=	{
			[0001]=function()
				end,
			[0101]=function()
					SetSceneID(59);
					LoadPic(103,"����");
					DrawMulitStrBox("ʱΪ���������ڣ������ʵۡ�[Green]���[Normal]��λ�ڼ䣬[n]��[Red]��������[Normal]���������ˣ�������ĺ�����[n]�ѳ�Ϊ�񳼡��¹ٵĳ�Ѩ��");
					DrawMulitStrBox("����ر����û¹����õ�ʮ�ˣ�[n]�˳ơ�[Red]ʮ����[Normal]��������ʵȨ��");
					LoadPic(103,"����");
					LoadPic(3,"����");
					DrawMulitStrBox("���ֶ��ң�����������Ű�����ֲ��ϣ�������ⱡ�[n]ƣ�������İ����ǿ�����Ӣ�۵ĳ��֡�");
					LoadPic(3,"����");
					LoadPic(104,"����");
					DrawMulitStrBox("��ͣ��꣨�������꣩��[n]�ųƴ�����ʦ��[Green]�Ž�[Normal]����ũ���ںӱ�һ�����壬[n]ʷ�ơ�[Red]�ƽ�֮��[Normal]����");
					DrawMulitStrBox("��ں�Ϊ��[Red]�������������쵱����[n]          ���ڼ��ӣ����´󼪡�[Normal]����");
					DrawMulitStrBox("�ڳ�͢���������״���£�[n]�ƽ���ڸ�������������[n]����һ���ѱ���ɫ���ĸ�����");
					LoadPic(104,"����");
					if JY.FID==33 then
						SetSceneID(55);
						Talk("�ű�","�ع�����[Green]�ű�[Normal]��[n]�˹�����[Green]����[Normal]�ոչ�����");
						Talk("����","ӱ���Ĺپ�ȫ�������ˣ�[n]ԥ��һ�������ǵġ�");
						Talk("����","��ǰ�����ִ󽫾�[Green]�ν�[Normal][n]������ͬ��԰׵�������");
						Talk("�Ž�","�ţ������˶����úá�[n]�����������Ʊؿ�һ�����������پ���");
						Talk("�Ž�","[Red]��[Normal]�������Ѿ���[n]�������������ĳ����������������ǵ�ʹ����");
						Talk("����","�ǣ�������");
						Talk("�ű�","�����ˡ�[n]��Ҫ���մ�����ʦ����Ըȥ����");
					elseif JY.FID==34 then
						SetSceneID(54);
						Talk("�ν�","ʲô������ԥ��Ҳ����������ˣ���");
						Talk("�ܲ�","�����´�������Ϣ��[n]��ȷʵ���鱨��");
						Talk("Ԭ�B","�󽫾�����̬���ذ���[n]Ӧ�����ϱ����ַ�����");
						Talk("�ν�","֪���ˡ���ô�ټ���������");
						SetSceneID(54);
						Talk("�ν�","[Green]�ʸ��Խ�����[Green]��y[Normal]������[n][Green]¬ֲ[Normal]����������[Green]��׿[Normal]������");
						Talk("�ʸ���","�ǣ�");
						Talk("�ν�","�����ǵֿ��������ֵ��������ӡ�[n]��Σ�����������������ɣ�");
						Talk("¬ֲ","�ǣ�[n]�ؾ��ౡ֮��������������");
						Talk("��y","һ������ѹ������������");
						Talk("��׿","�󽫾����£�[n]��ȴ�����Ϣ�ɣ�");
						Talk("�ν�","�ţ�����[Green]Ԭ�B[Normal]��[Green]�ܲ�[Normal]��");
						Talk("�ν�","�������̫�أ�[n]��Ҳ���������������룡");
						Talk("Ԭ�B","����������ȥ�죡");
					else
						SetSceneID(51);
						Talk("����2","���²����ˣ��ƽ�����[Green]�Ž�[Normal]������췴�ˣ�[n]�������̻��ٸ����������ϡ�");
						Talk(JY.PID,"��˵���ң�����������ô���ֵ��¡���");
						SetSceneID(54);
						Talk("�نT","�ƽ����ĺ�����ʥ�Ϸ��ǣ�[n]����[Green]�ν�[Normal]����Ϊ[Red]�󽫾�[Normal]��ǰ���ַ��䵳��[n]�����������[Green]�ν�[Normal]������ָʾ��ǰ���ַ�������");
						Talk(JY.PID,"�¹���ּ���¹ٱ���ȫ������������¡�");
						SetSceneID(54);
						Talk(JY.PID,"˳��ּ�⣬�������̳������ֻƽ�����[n]�Գ�͢����������˾�������ˡ��");
						SetSceneID(67);
						Talk(JY.PID,"��������˵�ƽ�����ڱ鼰ȫ�����أ�[n]��εĶ����ƺ�������ܾá�����");
						LoadPic(8,"����");
						DrawMulitStrBox("��"..JY.Person[JY.PID]["����"].."��Ԥ���һ����ս�𽥽������й�ȫ����[n]ʱ�����ⳡ����Ϊ������ʼ���˾޴�䶯��[n]��ʱ����Ӣ���ǣ�һ����һ���Ŀ�ʼΪ������֪��");
						LoadPic(8,"����");
					end
				end,
			[0102]=function()
					SetSceneID(59);
					LoadPic(103,"����");
					DrawMulitStrBox("ʱΪ���������ڣ������ʵۡ�[Green]�ٵ�[Normal]��[n]�ڣ������ʵۡ�[Green]�׵�[Normal]��λ�ڼ䡣");
					DrawMulitStrBox("��[Red]��������[Normal]���������ˣ�������ĺ�������[n]����ʵ�����ʵ�ʧȥ��ǿ�����������Ϊ��ܣ�[n]�����Ƕ�����ά�֡�");
					DrawMulitStrBox("�������������¸�������ݣ�[n]�����������ɱ��ս�����������");
					LoadPic(103,"����");
					LoadPic(79,"����");
					DrawMulitStrBox("��ƽ�������������ꣴ�£�[Green]���[Normal]�ݱ���[n]����[Green]��[Normal]��λ[Green]�ٵ�[Normal]��");
					LoadPic(79,"����");
					DrawMulitStrBox("����[Green]��[Normal]�Ǵ󽫾�[Green]�ν�[Normal]�����ú�̫��֮�ӣ�[n][Green]�ν�[Normal]��Ȩ�ƽ�����ͬ�ն��[n]���ǿ����֪���ˡ�");
					DrawMulitStrBox("�����ˣ��£�[n][Green]�ν�[Normal]ȴ�����л¹١�[Red]ʮ����[Normal]����ɱ��[n]���ڷ�����");
					DrawMulitStrBox("��[Red]ʮ����[Normal]����׼�������ν����µ�[Green]Ԭ�B[Normal]��[n][Green]Ԭ��[Normal]��[Green]�ܲ�[Normal]���ˣ�[n]���ڴ˻���֮�ʣ���������һЩ����֮�͡�");
					LoadPic(93,"����");
					DrawMulitStrBox("��ѹ¤������֮����������ǿ���Ȩ��[Green]��׿[Normal]��[n]������ռ���˶���[Red]����[Normal]��");
					LoadPic(93,"����");
					LoadPic(106,"����");
					DrawMulitStrBox("���������ٵۣ���������[Green]��Э[Normal]Ϊ�ʵ�[n]�򵹶����ɵ�[Green]��ԭ[Normal]��ǿ�з�λ��");
					DrawMulitStrBox("Ȼ��������[Green]��׿[Normal]�ı��У�[n]���ط�[Green]��׿[Normal]����������ǡ�");
					DrawMulitStrBox("ͬ�꣱���£�[Green]�ܲ�[Normal]�ص����������[n]��������������[Green]��׿[Normal]��ϭ�ġ�");
					LoadPic(106,"����");
					LoadPic(87,"����");
					DrawMulitStrBox("������Ӧ���ͺν������Ų���[Green]Ԭ�B[Normal]�����[Green]Ԭ��[Normal]��[n]ƽ���˳�ɳ���ң��˳ƽ���֮�����½�[Green]�O��[Normal]��");
					DrawMulitStrBox("ƽ�����������ҵİ�����[Green]�����[Normal]��[n]�Լ�������[Green]����[Normal]��");
					DrawMulitStrBox("���ң�[Green]����[Normal]�ȶ�[Green]��׿[Normal]�����Ļ������ĸ�����[n]Ҳ����ˡ�[Red]����׿����[Normal]����ͬ�����");
					LoadPic(87,"����");
					LoadPic(106,"����");
					DrawMulitStrBox("�Դˣ�[Green]��׿[Normal]Ҳ�������ܱ߼�����ӣ�[n]���ɳ��׿�ս֮�ơ�");
					DrawMulitStrBox("��ƽ�������������꣱�£�[n][Green]��׿[Normal]�ľ����롸[Red]����׿����[Normal]����ʼ��ս��");
					LoadPic(106,"����");
					if JY.FID==1 or JY.FID==2 or JY.FID==3 or JY.FID==4 or JY.FID==5 or JY.FID==10 or JY.FID==11 or JY.FID==13 or JY.FID==18 or JY.FID==19 or JY.FID==20 or JY.FID==21 or JY.FID==22 or JY.FID==23 or JY.FID==24 then
						SetSceneID(55);
						Talk("�ܲ�","��Ӧϭ�ĵ�����ǣ�[n]һ·��������طǳ����۰ɣ���");
						Talk("�ܲ�","Ϊ����֮�£����Ǿ۵�һ��[n]�Ժ��Ҷ������ѡ�");
						Talk("�ܲ�","�β�Ѹ�ٱ�����·���������ǣ��ַ�[Green]��׿[Normal]��");
						Talk("�O��","[Green]�ܲ�[Normal]���ˣ����һ�ȣ�[n]�����ѳ����������˭��[Red]����[Normal]�أ�");
						Talk("�O��","������Ƿֱ�����ȥ����[n]���б�[Green]��׿[Normal]���Ӹ������Ƶ�Σ�ա�");
						Talk("�ܲ�","�ţ�[Green]�O��[Normal]�������Լ��ǡ�");
						Talk("�ܲ�","������ˣ�[n]���Ǿ�ӵ��λ[Green]Ԭ�B[Normal]����Ϊ[Red]����[Normal]��Σ�");
						Talk("�ܲ�","Ԭ���������������Ǻ����Ĺ�����[n]��[Red]����[Normal]����ʲ����ˡ�");
						Talk("����","���գ�[n]����[Green]Ԭ�B[Normal]���ˣ�������ѡ��");
						Talk("�ܲ�","��Ȼ��ұ������飬[n]��ô���;�����[Green]Ԭ�B[Normal]���˵���[Red]����[Normal]�ɣ�");
						Talk("Ԭ�B","�ţ��Ǿ͹�����������ˡ�");
						Talk("Ԭ�B","��λ��[n][Green]��׿[Normal]�Ѷ����ǵ��ж����������[n]���һ�������˳��׼����");
						Talk("Ԭ�B","��Ҫ����[Red]����[Normal]��[n]������ɱ�����Թ��ݵġ�[Red]���ι�[Normal]����");
						Talk("Ԭ�B","Ȼ����[Green]��׿[Normal]������նɱ[Green]��ԭ[Normal][n]���鸽������[Red]������˫[Normal]�ĺ���[Green]�β�[Normal]��");
						Talk("Ԭ�B","���ǣ���·�������Ž�������[n]��ǿ�ľ���Ҳ����Ϊ�塣");
						Talk("Ԭ�B","����λһͬ����[Green]��׿[Normal]�ı�����[n]��ʾ���¹�����ͳ�ɣ�");
					elseif JY.FID==6 then
						SetSceneID(54);
						Talk("��׿","ʲô����[n]��������Ѽ��ᣬֱ�����Ƕ�������");
						Talk("����","���������Ӧ[Green]�ܲ�[Normal]��ϭ�ģ�[n]ӵ[Green]Ԭ�B[Normal]Ϊ�������ѽ�������ˡ�");
						Talk("����","һ�������öԸ���[n]�������������������²��׶Ը���");
						Talk("��׿","�š���[n]�������󣬸�����Ǻã�");
						Talk("�β�","�常���˺α����ģ�[n]��Ī����������[Green]�β�[Normal]�ڴˣ�");
						Talk("�β�","��Щ��С�����ƥ��[n]Ҫ����ᵳ�Ÿ����������к����ͣ�");
						Talk("�β�","ֻҪ����[Green]�β�[Normal]�ڣ�[n]�;������õ���̤�붼�ǰ벽��");
						Talk("��׿","Ŷ��û��[n]ֻҪ�����ڣ��Ҿ����������ˡ�");
						Talk("��׿","����Ϊ�˴�ʱ��[n]�ҲŲ�ϧ�ó�[Red]������[Normal]��������Ϊ���µġ�");
						Talk("��׿","�����ϱ�������[n]������[Red]������˫[Normal]��������ɱ����Щ��ͽ�ɣ�");
						Talk("����","[Green]��׿[Normal]���ˣ�ɱ������ţ����[n][Green]Ԭ�B[Normal]��[Green]�ܲ�[Normal]֮�������Ͳ����ͼ�[Green]�β�[Normal]���ˣ�[n]ĩ�����ʤ�Ρ�");
						Talk("����","������һҪ����[Red]���ι�[Normal]����[n]����ĩ�����ȷ�ɣ�");
						Talk("��׿","Ŷ����[Green]����[Normal]����[n]�ã��Ҿ��������ȷ档");
						Talk("��׿","�����ټ���ȫ�����ڡ�[Red]���ι�[Normal]��ӭ�����ˣ�[n]��Ҫɱ������Ƭ�ײ�����");
					else
						
					end
				end,
			[0103]=function()
					SetSceneID(59);
					LoadPic(103,"����");
					DrawMulitStrBox("ʱΪ���������ڣ������ʵۡ�[Green]�׵�[Normal]��λ�ڼ䡣");
					DrawMulitStrBox("��[Red]��������[Normal]���������ˣ�������ĺ�������[n]����ʵ�����ʵ�ʧȥ��ǿ�����������Ϊ��ܣ�[n]�����Ƕ�����ά�֡�");
					DrawMulitStrBox("�������������¸�������ݣ�[n]��ʷ��̨�߽��������ɱ��ս�����������");
					LoadPic(103,"����");
					LoadPic(110,"����");
					DrawMulitStrBox("��ƽ�������������ꣴ�£�[n]������[Green]��׿[Normal]Ȩ�ƴﵽ���㣬[n]ȴ������[Green]�β�[Normal]��˾ͽ[Green]����[Normal]��ɱ��");
					LoadPic(79,"����");
					LoadPic(75,"����");
					DrawMulitStrBox("[Green]�β�[Normal]����ʱռ���˶��ǳ�����[n]����[Green]���[Normal]�ȶ�׿���൳��սʧ�ܣ�[n]������볤����");
					LoadPic(75,"����");
					LoadPic(85,"����");
					DrawMulitStrBox("���붼�ǵ�[Green]���[Normal]��ɱ[Green]����[Normal]���Ľ��ʵۣ�[n]�����붭׿һ���ı�����[n]���ǻķϣ���͢������ɥʧ������");
					LoadPic(85,"����");
					SetSceneID(66);
					DrawMulitStrBox("��һ���棬�Ӷ��Ǹϳ�����[Green]�β�[Normal]��[n]Ϊ�˶�ɽ����Ѱ�Ҿݵ㣬շת���ء�");
					DrawMulitStrBox("��ʱ[Green]�β�[Normal]���еģ�[n]��[Green]�ܲ�[Normal]�������ݶ���Ϊ�ճǵ����ݡ�");
					DrawMulitStrBox("[Green]�β�[Normal]��[Green]ꐌm[Normal]��[Green]����[Normal]���˵�֧Ԯ�£�[n]�ܿ�Ļ�����������ǣ�[n]������ͻ��[Green]�ܲپ�[Normal]�ĺ����");
					DrawMulitStrBox("[Green]�ܲ�[Normal]���ò������������ݣ�[n]�������Ƹ�Ϊӭս[Green]�β�[Normal]�����ٰ�Ӫ���ˡ�");
					DrawMulitStrBox("�ͽ�[Green]�β�[Normal]���ǽ�[Green]�ܲ�[Normal]���ߵĴ����[n]�ڶ���ɽ����������ս��[n]չ���������ݵĳ���ս�ۡ�");
					SetSceneID(63);
					DrawMulitStrBox("��ʱ���ڽ���ս�ҵ���̨�ϣ�������һλ����Ӣ�ۣ�[n]���������ھ���֮ս�а�������ČO��֮��[Green]�O��[Normal]��");
					DrawMulitStrBox("[Green]�O��[Normal]һֱ�ܻ���[Green]Ԭ��[Normal]�ıӻ���[n]���ǽ����׵����[Red]����[Normal]�ø�[Green]Ԭ��[Normal]��[n]���ñ���ȡ�ö�����");
					DrawMulitStrBox("���Դ˽���������[Red]��[Normal]���Ļ�����[n]�Ӵ�֮�󣬱㿪ʼ��[Green]�O��[Normal]�ĳưԽ���֮ս��");
					if JY.FID==1 then
						SetSceneID(54);
						Talk("�ܲ�","����ʧ��[n]���ݾ�����˵���������֮�֡�");
						Talk("�ĺ","��ȥ֮�����޷���أ�[n]����Ӧ����[Green]�β�[Normal]��ս��������ݡ�");
						Talk("�ĺ�Y","�Ҿ����ཫ�㣬[n]����ѷ��[Green]�β�[Normal]��");
						Talk("�ܲ�","����˵�Ķ���ȷ��[n]���Ҿ���������[Green]����[Normal]��");
						Talk("�ܲ�","����[Green]����[Normal]Ȱ��ͣս��[n]�Լ�ȴפ�������ݡ�");
						Talk("�ܲ�","���Ҿ���[Green]�β�[Normal]��ս�ڼ䣬[n]��[Green]����[Normal]�ӱ���ɱ�룬�ǿɾ͸����ܵ��ˡ�");
						Talk("����","��������ģ�[n][Green]����[Normal]�ոս�פ���ݣ������в�������");
						Talk("����","��ǰ��Ҫ��ͣս��[n]Ϊ�ı��ǲ������Ҿ���ս��[n]����֤������δ�ᡣ");
						Talk("����","����֮�ƣ�[n]����Ӧ���ȿ�����ζ�����ݲ��ǡ�");
						Talk("����","[Green]����[Normal]�������Լ��ǣ�[n][Green]�β�[Normal]��ֻ֪����֪�˵�ç��[n]Ҳ��ᷴ�����������ǡ�");
						Talk("����","��������ֻ��ר������[Green]�β�[Normal]֮ս���ɡ�");
						Talk("�ܲ�","�ã���ô��[n]����ս[Green]�β�[Normal]�ɣ�");
						Talk("�ܲ�","[Green]�β�[Normal]��[Red]������˫[Normal]�ĺ��ܣ�[n]�ֽ����[Green]ꐌm[Normal]���˸��������в������ӡ�");
					elseif JY.FID==2 then
						SetSceneID(51);
						Talk("�OǬ","[Green]����[Normal]���ˣ�[n]���������ã���ȥ������������");
						SetSceneID(50);
						LoadPic(77,"����");
						Talk("����","[Green]���t[Normal]���ˣ��뱣�����塣");
						Talk("���t","�Ҳ���Σ�ƣ���Ϧ�ѱ���[n]����[Green]����[Normal]�������ҳǳ�Ϊ�أ�[n]����������������Ҳ�Ŀ�ˣ���");
						Talk("����","���˻����������ӣ�[n]Ϊ�β���λ����Ķ��ӣ�");
						Talk("���t","�ҳ������̣�������Ӧ�����ǵĲ��ܷ񲻹���[n]����֮����[Green]����[Normal]�úý�ѵ���ǡ�");
						Talk("�P��","�ֳ�����ʲô����ԥ�ģ�[n]���Ҫ���Լ�������ˡ�");
						Talk("���w","��磬�������ɡ�");
						Talk("�OǬ","[Green]����[Normal]���ˣ����������ˡ�");
						Talk("����","����ʱ��ս֮�أ�[n]���䱻���˶��ߣ��������и���[Green]����[Normal]���ˡ�");
						Talk("���t","����ܽ����ҵ�����[n]��Ҳ��û��ʲô��ǣ�ҵ��ˣ�[n][Green]����[Normal]����һ��Ҫ���ܡ�");
						Talk("����","�����ˣ����䲻�ţ�Ը���ܡ�");
						Talk("���t","������ˣ�лл��������Ҳû��ǣ���ˡ�[n]����ˡ�");
						DrawMulitStrBox("[Green]���t[Normal]ȥ���ˡ�");
						LoadPic(77,"����");
					elseif JY.FID==3 then
						SetSceneID(55);
						DrawMulitStrBox("[Green]�O��[Normal]�ó�[Red]����[Normal]��ñ����[n]��פ����®�����Ż����򽭶���");
						DrawMulitStrBox("��ʱ����������ֵ�[Green]���[Normal]����[Green]�O��[Normal]��");
						Talk("�O��","[Green]���[Normal]�����������ã�[n]�����ڣ�������ð���֮����");
						Talk("���","[Green]����[Normal]���˺αض���[n][Green]����[Normal]�����𲽣��ұ�Ӧȫ��֧Ԯ�Ŷԡ�");
						Talk("���","Ϊ��[Green]����[Normal]���˵ô�ҵ��[n]�����ԸЧȮ��֮�͡�");
						Talk("�O��","��˼��ã�[n]�ǿ�ȫ�����ˡ�");
						Talk("���","�ǡ�");
						Talk("����","[Green]�O��[Normal]���ˣ�[n]�������[Green]���[Normal]����������[n]����Ӧ�����̽���������");
						Talk("����","���³������");
						Talk("�O��","�ţ��ã�");
						Talk("�O��","Ϊ�˼̳и��׵���־��[n]ҲΪ������[Red]���[Normal]��������[n]����Ҫ��λ��ͬЭ����");
						Talk("�O��","��֪����ս�ǳ���ս��[n]���������λͬ��Э����[n]һ��ȡ���Ҿ���ʤ����");
					elseif JY.FID==7 then
						SetSceneID(54);
						Talk("����","[Green]�β�[Normal]������[n]��ϲ��ռ������ݡ�");
						Talk("�β�","���С�£�[n]�Ƕ��������㲻��ʲô��");
						Talk("�β�","[Green]�ܲ�[Normal]ƥ��[n]���ݵر��ᣬ[n]��������������˰ɣ�");
						Talk("ꐌm","[Green]�β�[Normal]���ˣ���̽�ӻر���[n][Green]�ܲ�[Normal]�Ѿ��̈́���ͣս��[n]��׼��Ϊ������ݶ�����");
						Talk("ꐌm","�ҷ�ҲӦ�ü�ǿ���أ�[n]�Ա�ӭ��[Green]�ܾ�[Normal]��");
						Talk("�β�","[Green]�ܲ�[Normal]��[Green]�ܲ�[Normal]��[n]���Ǿ���ô������");
						Talk("�β�","[Green]�ܲ�[Normal]����������[n]��һ���ȣ�һꪱ�ȡ���׼���[n]��˭���������ң�");
						Talk("ꐌm","[Green]�ܲ�[Normal]��ǿ��׳��[n]�����˲żüã�[n]�뽫��ǧ�򲻿�С�ӡ�");
						Talk("�β�","��̫�����ˣ�[Green]ꐌm[Normal]��[n]�������ҵ��뷨��");
						Talk("�β�","������ֻҪ��[Green]�ܲ�[Normal]��������ԭ��[n]��ɴ�[Green]���[Normal]���ж�ض��ǡ�");
						Talk("�β�","[Green]���|[Normal]��[Green]��˳[Normal]�����̱�������[n]ȥȡ[Green]�ܲ�[Normal]���׼������ҡ�");
						Talk("���|","ĩ��������");
						Talk("ꐌm","����");
					end
				end,
			[0104]=function()
					SetSceneID(59);
					LoadPic(103,"����");
					DrawMulitStrBox("ʱΪ���������ڣ������ʵۡ�[Green]�׵�[Normal]��λ�ڼ䡣");
					DrawMulitStrBox("��������ͣ�ͳ�δ�½��������[n]Ҳ��Ϊ��̱��������Һ�Ⱥ�۵�����[n]�����Ե�˥�ˡ�");
					DrawMulitStrBox("ͽ�����ĳ�͢������ɨ�أ�[n]Ⱥ��Ϊ�˳�Ϊ�°������໥������");
					DrawMulitStrBox("�������������¸�������ݣ�[n]��ʷ��̨�߽��������ɱ��ս�����������");
					LoadPic(103,"����");
					LoadPic(12,"����");
					DrawMulitStrBox("�����������������꣱���£�[n]��͢��ӵ���ߵ�[Green]�ܲ�[Normal]���򱻹��������ݵ�[Green]�β�[Normal]��");
					DrawMulitStrBox("������������ǿ�ֿ���[Green]�β�[Normal]��[n]����������±��Ѷ����ܣ������̳���");
					DrawMulitStrBox("�˴�ʤ����[n]ʹ[Green]�ܲ�[Normal]�����˴�½����ġ�[Red]��ԭ[Normal]���󲿷ֵ�����");
					LoadPic(12,"����");
					LoadPic(25,"����");
					DrawMulitStrBox("�����������������꣱�£�[n]�ڴ�½����չ���ļ���[Green]Ԭ�B[Normal]�뱱ƽ[Green]�����[Normal]����ս��[n]Ҳ�ӽ�β����");
					DrawMulitStrBox("���׾�����Ҫ������ֹ[Green]Ԭ�B[Normal]���ϵ�[Green]�����[Normal]��[n]��������ɱ�������Ӵ�Ϊ[Green]Ԭ�B[Normal]�����ơ�");
					LoadPic(25,"����");
					DrawMulitStrBox("�ڻ��Ͻ�����[Red]��[Normal]����[n]ȴ��[Green]�ܲ�[Normal]��ܶ�������[Green]Ԭ��[Normal]��[n]ԭ����Ͷ������[Green]Ԭ�B[Normal]��");
					DrawMulitStrBox("��[Green]�ܲ�[Normal]�ɳ�[Green]����[Normal]��ֹ�䱱�ϣ�[n]�����ڻ�ս֮�С�");
					DrawMulitStrBox("���⣬[Green]����[Normal]���밵ɱ[Green]�ܲ�[Normal]�ļƻ�Ҳ�����·���[n]�ܵ���[Green]�ܲ�[Normal]�Ĺ�����");
					DrawMulitStrBox("��ܵ�[Green]�����[Normal]��ɢ������[n]�������ݵĄ���֮��ܡ�[Green]�P��[Normal]��[n]���ñ�Ͷ����[Green]�ܲ�[Normal]��");
					LoadPic(112,"����");
					DrawMulitStrBox("���ǣ�������[Green]�ܲ�[Normal]��[Green]Ԭ�B[Normal]һ��Ϊ����[n]˫���ľ�ս�����ɱ��⡣");
					DrawMulitStrBox("[Green]�ܲ�[Normal]Ϊ����[Green]Ԭ�B[Normal]���£�[n]�����˺��֮�ǡ�����ǵ�[Green]���C[Normal]֮��[n]���̻Ӿ����ƽ���");
					LoadPic(112,"����");
					DrawMulitStrBox("���ǣ��Ϸ����С�[Red]����С����[Normal]����[Green]�O��[Normal]��[n][Green]�O��[Normal]Ҳ����ԭ��������");
					DrawMulitStrBox("[Green]�ܲ�[Normal]��[Green]Ԭ�B[Normal]�Լ�[Green]�O��[Normal]���ˣ�[n]�Ϸ�����֮ս������ʼ�ˡ�");
					if JY.FID==1 then
						SetSceneID(54);
						Talk("�ܲ�","Ŷ��[Green]���C[Normal]��[n]�������ͺã������ͺá�");
						Talk("���C","����������[Green]�ܲ�[Normal]��������֮�ˣ�[n]û�뵽���˻�����˻�ӭ�ҡ�");
						Talk("�ܲ�","��������[n]��ȥ֮�£���������ǰɣ�[n]��������ܺúñ��֡�");
						Talk("���C","�ǡ�");
						Talk("�ܲ�","���ˣ�[Green]����[Normal]��[n]����[Green]���C[Normal]���⣬[n]�����Ϸ����Ķ�����Σ�");
						Talk("����","������[Green]�O��[Normal]�ƺ��Ѵ�ӦЭ��[Green]Ԭ�B[Normal]��[n]����δ���ͬ�ˡ�");
						Talk("����","���⣬���ݵ�[Green]����[Normal]��[n]����[Green]Ԭ�B[Normal]������[n]ֻ�������Թۡ�");
						Talk("����","[Green]����[Normal]���Ҳ��ۣ�[n][Green]�O��[Normal]�����ҵ����ᣬ[n]�ͻ���ʱ�����İɣ�");
						Talk("����","�Ҿ�������������޶ȵı�����[n]�Է�[Green]�O��[Normal]������");
						Talk("�ܲ�","�ţ�[Green]����[Normal]���������[n]���߶�Ա�����������򱱳�����");
						Talk("�P��","[Green]�ܲ�[Normal]���ˣ�[n]��Ը�����ܱ�����˵Ķ��¡�");
						Talk("�P��","�ڵ�֪[Green]�ֳ�[Normal]��Ϣ֮ǰ��[n]�ɷ�Ҳ�������У�");
						Talk("�ܲ�","�ţ�����б�Ҫ���һ����ģ�[n]�������뽫�����ڶ��ǡ�");
						Talk("�P��","�����ǡ�");
						Talk("�ܲ�","��λ����[Green]Ԭ�B[Normal]֮ս��[n]���Ǿ�������֮ս��[n]���ս�ܣ����ǽ�ǰ;�ϲ⡣");
						Talk("�ܲ�","[Green]Ԭ�B[Normal]���������࣬�������˲żüã�[n]ֻҪ��ҹ�ͬŬ�������Ǳض�����ʧ�ܡ�");
						Talk("�ܲ�","��[Green]�O��[Normal]����֮ǰ��[n]����Ҫ��[Green]Ԭ�B[Normal]��һ��ս��[n]ȡ�û�����");
					elseif JY.FID==2 or JY.FID==4 then
						SetSceneID(52);
						DrawMulitStrBox("[Green]����[Normal]�����ݱ�[Green]�ܲپ�[Normal]��ܣ�[n]����[Green]Ԭ�B[Normal]֮����");
						Talk("Ԭ�B","Ŷ��[Green]����[Normal]���ˣ�[n]���������ã�");
						Talk("Ԭ�B","[Green]�ܲ�[Normal]��������֮ʱ��[n]δȥ��Ԯ�����Ǳ�Ǹ��");
						Talk("����","���[n]��Ը������������֮�˾����ӡ�");
						Talk("Ԭ�B","����Ļ���[n]��ר��ǰ��Ͷ�����ң�[n]��������֮����");
						Talk("Ԭ�B","���������ڵ���������Ϣ��[n]�Ҿ���[Green]�ܲ�[Normal]��սʱ��[n]���Ҿ���Ԯ�ɣ�");
						Talk("����","�õġ�");
						Talk("Ԭ�B","���ˣ�[Green]����[Normal]��[n]������������ʹ�ߣ�[n]�к���Ϣ�ر���");
						Talk("����","������[Green]�O��[Normal]��ͬ��������[n]����Ӻ�������ܲ١�");
						Talk("����","���[Green]���C[Normal]�ѽ�����[Green]�ܲ�[Normal]��[n]���ݵ�[Green]����[Normal]�������Ѷ��");
						Talk("Ԭ�B","�ɶ��[Green]����[Normal]��[n]ֻ�������Թۣ�[n]��������֪��������");
						Talk("���S","[Green]Ԭ�B[Normal]���ˣ�[n]���ǲŸմ��[Green]�����[Normal]��[n]�����������ս�¡�");
						Talk("���S","����Ϊ����Ӧ��һʹ��ȥ���ݣ�[n]��[Green]����[Normal]����Ѻ�֮�⣬[n]����[Green]�ܲ�[Normal]��սΪ�á�");
						Talk("����","��Ҳ��ͬ�У�[n][Green]�ܲ�[Normal]��ս����[Green]�����[Normal]���ܱ��⡣");
						Talk("����","��Ȼ��ս���ɱ��⣬[n]����Ӧ��������һʧ��׼����");
						Talk("���D","��Ҳ��[n]�ֽ׶Σ��ҷ����Ҫ��[Green]�ܲ�[Normal]����ǿ��");
						Talk("���D","��������ʱ�䣬[n][Green]�ܲ�[Normal]�����б��������̱�����ࡣ");
						Talk("���","[Green]Ԭ�B[Normal]���ˣ�Ϊ����ԥ��[n][Green]�ܲ�[Normal]�����������Һ�[Green]���h[Normal]�Ķ��֡�");
						Talk("���h","���ɸ��ҵ�һ֧����[n]�ҵȱؿ�ɱ��[Green]�ܲپ�[Normal]��");
						Talk("Ԭ�B","ร�˵�ü��ã�[n]�Ҿ���ʿ����ʢ��[n]����������ʼ��ս��׼����");
						Talk("Ԭ�B","�������Ƕ���ģ�[n]�Ȱ�[Green]�ܲ�[Normal]��ȡ��ԭ��[n]���¾������ǵ��ˣ�");
					elseif JY.FID==3 then
						SetSceneID(54);
						Talk("����","[Green]�O��[Normal]���ˣ�[n][Green]Ԭ�B[Normal]��ʹ��˵Щʲô��");
						Talk("�O��","ʹ��˵��[Green]Ԭ�B[Normal]ϣ������Ϯ��[Green]�ܲ�[Normal]�����[n]�ȴ��[Green]�ܲ�[Normal]�󣬴�½���Ϸ�������ҡ�");
						Talk("����","��ô��������δ𸴣�");
						Talk("�O��","�Ҵ�Ӧ������");
						Talk("�O��","��Ȼ[Green]Ԭ�B[Normal]�������ң�[n]���Ǿ����û�ȥ�ɣ�");
						Talk("���","ֻҪ[Green]�ܲ�[Normal]��[Green]Ԭ�B[Normal]һ��ս��[n]˫�����ٶ����������ˡ�");
						Talk("���","�ô˻��ᣬ[n]���Ǳ��ȡ������֮��������");
						Talk("�O��","��Ϊ��[n]��Ҳ����ֻ������[Red]����С����[Normal]����");
						Talk("����","���ǣ���������[Green]����[Normal]��[n]��ɲ��ܴ��⡣");
						Talk("�O��","�ţ���ȻҪ���·������ݵ�����");
						Talk("�O��","����Ƕ�ȡ��ԭ�ľ��ѻ��ᣬ[n]�������ܴ����");
						Talk("�O��","�Ը���ȥ��������������[n][Green]�ܲپ�[Normal]һ�п�϶����һ���������������");
					end
				end,
			[0105]=function()
					SetSceneID(59);
					LoadPic(103,"����");
					DrawMulitStrBox("ʱΪ���������ڣ������ʵۡ�[Green]�׵�[Normal]��λ�ڼ䡣");
					DrawMulitStrBox("��������ͣ�ͳ�δ�½��������[n]Ҳ��Ϊ��̱��������Һ�Ⱥ�۵�����[n]�����Ե�˥�ˡ�");
					DrawMulitStrBox("ͽ�����ĳ�͢������ɨ�أ�[n]Ⱥ��Ϊ�˳�Ϊ�°������໥������");
					DrawMulitStrBox("�������������¸�������ݣ�[n]��ʷ��̨�߽��������ɱ��ս�����������");
					LoadPic(103,"����");
					LoadPic(79,"����");
					DrawMulitStrBox("�����������������ꣵ�£�[n]��[Red]�ٶ�֮ս[Normal]��ʧ�ܵĵ�[Green]Ԭ�B[Normal]��[n]��׼������[Green]�ܲ�[Normal]��;�в��š�");
					DrawMulitStrBox("����[Green]Ԭ�B[Normal]û��ָ���̳��˶������[n]Ԭ�ҷ�Ϊ����[Green]Ԭ��[Normal]�ɺͳ���[Green]Ԭ̷[Normal]�ɣ�[n]��ʼ�໥������");
					LoadPic(79,"����");
					SetSceneID(66);
					DrawMulitStrBox("[Green]�ܲ�[Normal]û�зŹ���һʱ������ʼ����[n]�����������������꣹�£�[n]���ȹ�����[Green]Ԭ��[Normal]�ĸ��ݵ�����");
					DrawMulitStrBox("�������������������꣱�£����ݵ�[Green]Ԭ̷[Normal]����");
					DrawMulitStrBox("���꣬[Green]Ԭ��[Normal]���ں��صĸ߸�Ҳս�ܶ����ܡ�");
					DrawMulitStrBox("[Green]Ԭ��[Normal]�ۿ���Ҫ��׷�ϵ���[n]��Ͷ���˱�������������[Red]����[Normal]��[n]Ԭ�������������֮��");
					if JY.FID==1 then
						SetSceneID(52);
						Talk("���|","[Green]�ܲ�[Normal]���ˣ�[n]���ݵĹ��Խ����ˣ�[n]����ֻʣ��[Red]��ƽ[Normal]�ˡ�");
						Talk("���|","[Green]Ԭ��[Normal]��������֮�[n]�ַ���׼��Ҳ�������ˡ�");
						Talk("����","[Green]Ԭ��[Normal]��ֵһ�ᣬ[n]���ɶ�������[Green]����[Normal]һ�塣");
						Talk("����","�˴Σ�һ��������ң�[n]��ȫ�������ݡ�");
						Talk("����","����������£�[n]�سɺ󻼡�");
						Talk("�ܲ�","�ţ�Ԭ���ַ����������ϡ�");
						Talk("�ܲ�","���ǣ�[n]����һֱ��һֻ����������Ԭ���йϸ�");
						Talk("�ܲ�","[Green]���M[Normal]������һ֧����[n]ȥ֧Ԯ[Green]����[Normal]��[Green]�ĺ[Normal]��");
						Talk("���M","������[n]����ǰ���Ϸ���");
						Talk("�ܲ�","������Ҳ��ʼ��������׼����");
						Talk("�ܲ�","�����[Green]�O��[Normal]�����ݵ�[Green]����[Normal]��[n]������Ұ��[Green]����[Normal]��[n]�Ϸ����в��ٵ��˲�����");
						Talk("�ܲ�","���ǣ�[n]˭������Ҳ�Ȳ��������[Green]Ԭ�B[Normal]��");
						Talk("�ܲ�","�������ѻص��������У�[n]�úô��̰ɡ�");
					elseif JY.FID==2 then
						SetSceneID(54);
						Talk("����","[Green]�ܲ�[Normal]��Ԭ��һ��֮ս��Ҫ�����˰ɣ�");
						Talk("����","[Green]�ܲ�[Normal]�����Ծ���ΪĿ��ʱ��[n]��Ұ�ؽ���Ϊս����");
						Talk("����","��ҰС�ǣ���΢���ѣ�[n][Green]�ܲ�[Normal]������ʱ����η������أ�");
						Talk("���w","�ֳ���[n]û�б�Ҫ�ȴ�[Green]�ܲ�[Normal]���¡�");
						Talk("���w","��[Green]�ܾ�[Normal]�����ڼ䣬[n]��ȡ������Ǹ�����");
						Talk("�w�","����[Green]���w[Normal]������˵��[n]���Ҫ����[Green]�ܲ�[Normal]��û���ɴ�����ڡ�");
						Talk("�w�","��˵������[n]��[Green]�ܲ�[Normal]����[Green]����[Normal]���̷��أ�[n]���׹���ѽ��");
						Talk("����","�ţ�[Green]����[Normal]��ô���ǣ�");
						Talk("����","��ȷ��[Green]�ܾ�[Normal]�Ǵ����[n]��ս����ʤ������ֻ�����������ġ�");
						Talk("����","����д����[n]�������������Ե���ս������");
						Talk("����","������˵Ŀ�϶����õģ�[n]������У�ֻ���������취�ˡ�");
						Talk("����","��ǰ���ټ��佫��[n]����ʿ���ǵ���֮����");
						Talk("����","׼������[Green]�ܾ�[Normal]��������[n]�ͺ�[Green]����[Normal]�������ֻ��ˡ�");
						Talk("����","���˷�������֮ʱ��[n]�ҷ������㹻��ս������תΪ�����ɣ�");
						Talk("����","�ţ���ȷ��ˡ�");
						Talk("����","[Green]����[Normal]��[n]������ǰ����û������һ���ľ�ʦ�����԰��̵ġ�");
						Talk("����","[Green]�ܲ�[Normal]����ʱ������æ��");
						Talk("����","�ǣ��ҽ��������ܡ�");
					elseif JY.FID==4 then
						SetSceneID(54);
						Talk("Ԭ��","[Green]Ԭ��[Normal]��[n]�ٵֿ�����Ҳ����ȡʤ��");
						Talk("Ԭ��","���Բ���Ͷ��[Green]�ܲ�[Normal]�ɣ�");
						Talk("Ԭ��","˵ʲô�أ�[n]�ֳ���Ԭ�ҵ�־��Ϊ�����䣬[n]����Ͷ��[Green]�ܲ�[Normal]��");
						Talk("Ԭ��","���ȣ���Ͷ���Ļ���[n]�����ǲ���ԭ�������ֵܵġ�");
						Talk("Ԭ��","[Green]Ԭ̷[Normal]��[Green]�߸�[Normal]�ȱ��ܵ�Ԭ����ȫ����ɱ��");
						Talk("Ԭ��","��������Ǻ��أ�[n]��������Ĵ�������ս��");
						Talk("Ԭ��","ֻ�������ɶ���[Green]���￵[Normal]�ˡ�");
						Talk("Ԭ��","������Ǳ���[n][Green]���￵[Normal]ҲҪ��������[n]һ����������ǵġ�");
						Talk("Ԭ��","�Ҳ���Ϊ[Green]���￵[Normal]���Ӧ��[n]����������֣��Ͷ���ͬ[Green]�ܲ�[Normal]����֮����");
						Talk("Ԭ��","��ս���棬[n]��ȥ�����޷�֪����");
						Talk("Ԭ��","[Green]���￵[Normal]������Ӧ��[n]�Ǿ�ֻ��ͨ��ս�������[Green]�ܲ�[Normal]��");
						Talk("Ԭ��","���ǻ���[Red]����[Normal]�������[n]ս�������ʧ�ܾ�ȥ����");
					end
				end,
			[0106]=function()
					SetSceneID(59);
					LoadPic(103,"����");
					DrawMulitStrBox("ʱΪ���������ڣ������ʵۡ�[Green]�׵�[Normal]��λ�ڼ䡣");
					DrawMulitStrBox("ͳ�δ�½�������͵�������������Ƶ����[n]Ⱥ�������ս�˥���ˡ�");
					DrawMulitStrBox("ͽ�������ĳ�͢����ɨ�أ�[n]��ʵ����Ⱥ��Ϊ�������Ȩ��[n]��¹��ԭ��ս�²��ϡ�");
					LoadPic(103,"����");
					LoadPic(1,"����");
					DrawMulitStrBox("����֮�ء���[Red]����[Normal]����[n]�����������½���ϲ���Ⱥɽ���ƣ�[n]����ԭ������ս�����޹�ϵ���ʶ�����ս����");
					LoadPic(1,"����");
					SetSceneID(66);
					DrawMulitStrBox("Ȼ�����ԴӺ��е�[Green]����[Normal]��ͼ�������ݣ�[n]���ݵ�����˲�䷢���˱仯��");
					DrawMulitStrBox("���ݵ�[Green]���[Normal]Ϊ�˶Կ�[Green]����[Normal]��[n]���ݵ�[Green]����[Normal]��Ԯ��");
					DrawMulitStrBox("[Green]����[Normal]Ӧ���������ݶԿ�[Green]����[Normal]��[n]��ˣ�[Green]����[Normal]�����˽�����һ��ս���ƺ������ˡ�");
					DrawMulitStrBox("���ǣ���̬�ּ�תֱ�¡�[n]�����[Green]���[Normal]��[Green]����[Normal]�Ĺ�ϵ�񻯣�[n]����˫�����н�ս��");
					LoadPic(93,"����");
					DrawMulitStrBox("[Green]�����[Normal]������һ����ս����ʧ�˾�ʦ[Green]��ͳ[Normal]��[n]������Ԯ���ϵ������Է���Ϊʤ��[n]ֱ��[Green]���[Normal]���ڵĳɶ���");
					DrawMulitStrBox("���Ƶ���Ͷ��·��[Green]���[Normal]�������ǵ��˵�[Green]����[Normal]��Ԯ��[n][Green]����[Normal]��Ӧ����[Green]�R��[Normal]ǰ����");
					DrawMulitStrBox("���ǣ�����[Green]�T����[Normal]�ļ�ı��[Green]�R��[Normal]��[Green]����[Normal]���ɣ�[n]��ʧ������[Green]�R��[Normal]Ͷ����[Green]����[Normal]��");
					LoadPic(93,"����");
					SetSceneID(59);
					LoadPic(11,"����");
					DrawMulitStrBox("��[Green]�R��[Normal]ҲͶ����[Green]����[Normal]��[n][Green]���[Normal]ʧȥ�˵ֿ�����������[Green]����[Normal]Ͷ���ˡ�");
					LoadPic(11,"����");
					LoadPic(114,"����");
					DrawMulitStrBox("���ǣ�[Green]����[Normal]�ɹ��ؽ�����ء�[n]���½�����[Green]�ܲ�[Normal]��[Green]����[Normal]��[Green]�O��[Normal]���ඦ��������ʱ����");
					LoadPic(114,"����");
					if JY.FID==1 then
						SetSceneID(52);
						Talk("�ܲ�","[Green]����[Normal]������������");
						Talk("�ܲ�","���ܶ���һ���֮��֮�ˡ�[n]��ʲô�취��");
						Talk("����","[Green]�ܲ�[Normal]���ˣ�[n]�ַ���ص�[Green]����[Normal]ֻ������·�ߡ�");
						Talk("����","һ���ǴӾ��ݣ�[n]��һ���ǴӺ��С�");
						Talk("�ܲ�","���Լ��ǣ�[n]��������[Green]����[Normal]��");
						Talk("�ĺ","[Green]����[Normal]���ڹ�����Ԯ��[n]����Ҿ����򣬿�һ�����ܡ�");
						Talk("�ĺ","���Խ�󣬹�����ص�[Green]����[Normal]ʱ��[n]�Ӻ��п�ʼ����Ҫ�ȴӾ��ݸ������ˡ�");
						Talk("�ܲ�","�ţ���ȷ��ˡ�[n]����������б�[Green]����[Normal]��ȥ��[n]������Σ���ˡ�");
						Talk("�ܲ�","��������������ǿ������[n]׼���������С�");
						Talk("�ܲ�","[Green]�ĺ�Y[Normal]��[Green]���A[Normal]��[n]�����Ϊ���������ȷ档");
						Talk("�ܲ�","��ȡ���У�[n]Ϊ������ش������ơ�");
						Talk("�ĺ�Y","������");
						Talk("�ܲ�","������ҲҪ׼��֧Ԯ������[n]���������Ϸ���");
						Talk("����","�����ˣ�");
					elseif JY.FID==2 then
						SetSceneID(52);
						Talk("����","[Green]�R��[Normal]���úð���[n]������㣬�ű�������ν��������");
						Talk("�R��","��Ϊ��Ч��������̫���ˡ�");
						Talk("����","��λ�������ˡ�[n]����ʧȥ�˾�ʦ[Green]��ͳ[Normal]������[n]�����������ʹ�ġ�");
						Talk("����","������ȷ�õ�����أ�[n]������[Green]�ܲ�[Normal]��[Green]�O��[Normal]��ǿ�����������");
						Talk("����","���������Ǹո�������������[n]����������[Green]�ܲ�[Normal]���ǡ�");
						Talk("����","������Ҫ�����������������ģ�[n]�𽥻�������[Green]�ܲ�[Normal]�����������");
						Talk("�T����","��ǰ�п��ܺ�[Green]�ܲ�[Normal]��ս�ģ�[n]��[Green]�P��[Normal]�������ڵľ��ݡ�");
						Talk("�T����","�ţ�׼��֧Ԯ���ݣ�[n]ͬʱŬ����ǿ������");
						Talk("����","�ţ������ˡ�[n][Green]�P��[Normal]�����ݰ������ˡ�");
						Talk("�P��","������[n]��ʹ��������[n]Ҳһ������ס���ݡ�");
					elseif JY.FID==3 then
						SetSceneID(54);
						Talk("�O��","[Green]����[Normal]���ջ���ռ������أ�[n]�����[Green]�ܲ�[Normal]Ҳ�ǲ������ӵġ�");
						Talk("�O��","[Green]�ܲ�[Normal]����β�ȡ�ж��أ�");
						Talk("����","[Green]����[Normal]������أ�[n]������δ��ǿ��");
						Talk("����","[Green]�ܲ�[Normal]Ȼ�����������������ǿǰ��������");
						Talk("�n��","�ޣ�������ˣ�[n][Green]�ܲ�[Normal]�����ǵķ���Ҳ������ม�");
						Talk("���C","��������[n][Green]�ܲ�[Normal]Ҳһ�������Ǳ������㹻�ķ�����");
						Talk("���C","���ǣ������[Green]�ܲ�[Normal]������ؽ���֮�ʣ�[n]���ǹ��䱳��[n][Green]�ܲ�[Normal]��Ҫ������ս����������������ġ�");
						Talk("�O��","�ţ���ôһ��[Green]�ܲپ�[Normal]�����л��ɳˣ�[n]���Ǿ͹��򱱲���");
						Talk("��ʢ","������[n]����׼������");
					elseif JY.FID==16 then
						SetSceneID(54);
						Talk("����","��ѽѽ��û�뵽[Green]�R��[Normal]��˳��[Green]����[Normal]��");
						Talk("����","���Ǳ�[Green]�ܲ�[Normal]��[Green]����[Normal]�����м䣬[n]Ӧ������Ǻð���");
						Talk("����","���ģ�[Green]����[Normal]�յ���أ���������������[n]��[Green]�ܲ�[Normal]Ҳ��ܿ����������Ҫ���衣");
						Talk("����","������������Ҫ������[Red]��ƽ��[Normal]��");
						Talk("����","��ʹ[Green]�ܲ�[Normal]��ǿ��[n]Ҳ�޷����׹��ơ�");
						Talk("����","[Green]����[Normal]�����ж����ң�[n]��������ɣ�");
						DrawMulitStrBox("[Green]����[Normal]��[Green]�R��[Normal]�����£�[n]���򻼲�û��һͬ��ս��[n]�����˺��С�");
						Talk("����","�ޣ���Ҳ��ս��[n]�Ҿ͸��������ˡ�");
						Talk("����","�������ˣ�������ǿ������[n]����[Green]�ܲ�[Normal]���ް취��");
						Talk("����","����׼������");
						Talk("���l","������");
					end
				end,
			[0111]=function()
					SetSceneID(61);
					DrawMulitStrBox("�ڡ��������塻�ǳ����ڶ�Ӣ���ǡ�[n]����֮�У��ܱ���ΪӢ�۵����[n]�����ж����أ�");
					DrawMulitStrBox("ӵ������������̫ƽ��������[Green]�Ž�[Normal]��[n]Ϊ��Ŀ�Ĳ����ֶε��泼[Green]��׿[Normal]��[n]���������ӳ���[Red]����[Normal]��[Green]�����[Normal]��");
					LoadPic(127,"����");
					DrawMulitStrBox("��������˫�������������ԭɧ����[Green]�β�[Normal]��[n]��[Red]����[Normal]�᳹�Ժ���֮�����[Green]����[Normal]��[n]�ư�����֮�ص�[Green]�ϻ�[Normal]��");
					LoadPic(127,"����");
					LoadPic(25,"����");
					DrawMulitStrBox("����������[Red]Ԭ[Normal]�ң�һ����[n]Ӧӵ��ǿ���������ưԵ�[Green]Ԭ�B[Normal]��[Green]Ԭ��[Normal]��[n]ƽ��������[Red]����[Normal]��[Green]����[Normal]��");
					LoadPic(25,"����");
					LoadPic(111,"����");
					DrawMulitStrBox("����֮����[Green]�O��[Normal]��С������[Green]�O��[Normal]��[n]�̳�ΰ��ĸ������ֳ�����־��[n]ƽ����������̫�桤[Green]�O��[Normal]��");
					LoadPic(111,"����");
					LoadPic(12,"����");
					DrawMulitStrBox("��׿Խ�Ĳ����ƺ���ԭ��[Green]�ܲ�[Normal]��[n]�̳������ͳһ����[n]�춨����������[Green]˾��ܲ[Normal]��");
					LoadPic(12,"����");
					LoadPic(13,"����");
					DrawMulitStrBox("�Լ���������ѵ��յ㣬[n]������֮�ء����������[Green]����[Normal]��");
					LoadPic(13,"����");
					LoadPic(119,"����");
					DrawMulitStrBox("Ӣ��ʮ�����ڴ˼���������[n]�ܳ�������Ӣ�ۣ�������˭�أ�[n]����ս���ʹ�չ����");
					LoadPic(119,"����");
				end,
			[1001]=function()
					--XXX��Ԯս
					local p1,p2,p3,p4,p5,p6,p7,p8,p9,p10;
					local wid;
					local plist={};
					--����Ԯ��
					plist=FilterPerson("������",-1,	"����","����",	"����",200);
					p1=TableRandom(plist);
					--�о���˧
					plist=FilterPerson("������",-1,	"����","ͳ��",	"����",300);
					p2=TableRandom(plist);
					
					--ս������
					WarIni();
					DefineWarMap(0,"XXX��Ԯս","һ�����ܣ�������",20,"����",p2);
					--�Ҿ�
					InsertWarPerson(0,"����",3,18,"��",0,"��",false,"����",0,0);
					SelectTeam(	2,17,"��",false,
								2,19,"��",false,
								3,20,"��",false,
								1,18,"��",false,
								1,20,"��",false,
								4,19,"��",false)
					
					--�Ѿ�
					InsertWarPerson(1,p1,			10,12,"��",4,"��",false,"����",-1,-1);
					WarSetFlag(101,War.PersonNum);
					InsertWarPerson(1,GenPerson(true,p1,"������"),	11,12,"��",2,"��",false,"����",-1,-1);
					InsertWarPerson(1,GenPerson(true,p1,"������"),	10,13,"��",2,"��",false,"����",-1,-1);
					InsertWarPerson(1,GenPerson(true,p1,"������"),	9,12,"��",2,"��",false,"����",-1,-1);
					
					--�о�
						--���� & ��Ӫ
					InsertWarPerson(2,p2,			16,2,"��",5,"��",false,"����",-1,-1);
					WarSetFlag(111,War.PersonNum);
					InsertWarPerson(2,GenPerson(true,p2,"����"),	16,1,"��",2,"��",false,"����",-1,-1);
					InsertWarPerson(2,GenPerson(true,p2,"������"),	16,3,"��",2,"��",false,"����",-1,-1);
					InsertWarPerson(2,GenPerson(true,p2,"�����"),	17,2,"��",2,"��",false,"����",-1,-1);
					InsertWarPerson(2,GenPerson(true,p2,"�����"),	17,1,"��",2,"��",false,"����",-1,-1);
						--�ײ����ӣ����������Ҿ�
					InsertWarPerson(3,GenPerson(true,p2,"������"),	10,17,"��",1,"��",false,"����",10,15);
					InsertWarPerson(3,GenPerson(true,p2,"������"),	11,18,"��",0,"��",false,"����",11,16);
					InsertWarPerson(3,GenPerson(true,p2,"����"),	12,18,"��",0,"��",false,"����",10,16);
						--����
					InsertWarPerson(4,GenPerson(true,p2,"����"),		5,11,"��",0,"��",false,"����",8,10);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	4,12,"��",1,"��",false,"����",7,12);
						--ǰ��
					InsertWarPerson(5,GenPerson(true,p2,"����"),		11,4,"��",0,"��",false,"����",9,12);
					InsertWarPerson(5,GenPerson(true,p2,"������"),	10,5,"��",0,"��",false,"����",12,12);
					InsertWarPerson(5,GenPerson(true,p2,"����"),		12,5,"��",0,"��",false,"����",13,12);
					
					--
					JY.Status=GAME_WMAP;
					NextEvent(1002);
				end,
			[1002]=function()
					PlayBGM(11);
					WarTalk(WarGetFlag(111),30);
					WarTalk(WarGetFlag(101),31);
					WarShowTarget(true);
					PlayBGM(19);
					NextEvent(1003);
				end,
			[1003]=function()
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(2)) and WarCheckArea(-1,8,1,20,6) then
							WarSetFlag(2,2);	--�о��ܹ�
							WarTalk(WarGetFlag(111),"�о��Ѿ�����һ����[n]ȫ��������");
							WarModifyTeamAI(2,"����",WarGetFlag(111),-1);
							WarModifyAI(WarGetFlag(111),"����",-1,-1)
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						--��2�غ� �Ѿ�AI�޸ģ�������
						if War.Turn==2 and (not WarCheckFlag(1)) then
							WarSetFlag(1,1);
							WarModifyTeamAI(1,"����",WarGetFlag(101),-1);
							WarModifyAI(WarGetFlag(101),"����",-1,-1)
						end
						--�о�δ�ܹ����о���������7
						if War.PersonNumEnemy<7 and (not WarCheckFlag(2)) then
							WarSetFlag(2,1);	--�Ѿ�����
							WarTalk(WarGetFlag(101),"������ת��[n]ȫ����������");
							WarModifyAI(WarGetFlag(101),"����",-1,-1)
						end
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						--�Ѿ�δ��������12�غ�
						if War.Turn==12 and (not WarCheckFlag(2)) then
							WarSetFlag(2,2);	--�о��ܹ�
							WarTalk(WarGetFlag(111),"�о��Ѿ�����һ����[n]ȫ��������");
							WarModifyTeamAI(2,"����",WarGetFlag(111),-1);
							WarModifyAI(WarGetFlag(111),"����",-1,-1)
						end
					end
					
					--[[
					ʱ��
					�غϿ�ʼǰ ��/��/��
					�佫�ж���
					
					
					�佫���ڲ���
					�佫����ָ���ص�/�������
					�佫������� ��������
					�佫��ʼ�ж�/�����ж����ԣ���
					�佫״̬���� ����ʱ��
					ս���������� ����ʱ��
					�ж�������
					�غϲ���
					ʤ������
					ʧ�ܲ���
					]]--
				end,
			[1004]=function()
					--XXX��Ԯս
					local p1,p2,p3,p4,p5,p6,p7,p8,p9,p10;
					local wid;
					local plist={};
					--����Ԯ��
					plist=FilterPerson("������",-1,	"����","����",	"����",200);
					p1=TableRandom(plist);
					--�о���˧
					plist=FilterPerson("������",-1,	"����","��ı",	"����",300);
					p2=TableRandom(plist);
					
					--ս������
					WarIni();
					DefineWarMap(1,"XXX��Ԯս","һ�����ܣ�������",20,"����",p2);
					--�Ҿ�
					InsertWarPerson(0,"����",20,7,"��",0,"��",false,"����",0,0);
					SelectTeam(	20,6,"��",false,
								19,7,"��",false,
								20,8,"��",false,
								19,6,"��",false,
								19,8,"��",false,
								20,5,"��",false,
								20,9,"��",false,
								18,7,"��",false)
					
					--�Ѿ�
					InsertWarPerson(1,p1,			11,11,"��",4,"��",false,"�ƶ�",16,11);
					WarSetFlag(101,War.PersonNum);
					InsertWarPerson(1,GenPerson(true,p1,"�����"),	12,12,"��",0,"��",false,"�ƶ�",16,11);
					InsertWarPerson(1,GenPerson(true,p1,"������"),	11,10,"��",0,"��",false,"�ƶ�",16,11);
					InsertWarPerson(1,GenPerson(true,p1,"����"),		11,12,"��",1,"��",false,"�ƶ�",16,11);
					InsertWarPerson(1,GenPerson(true,p1,"������"),	10,11,"��",1,"��",false,"�ƶ�",16,11);
					InsertWarPerson(1,GenPerson(true,p1,"������"),	10,12,"��",0,"��",false,"�ƶ�",16,11);
					
					--�о�
						--���� & ��Ӫ
					InsertWarPerson(2,p2,			3,9,"��",5,"��",false,"����",-1,-1);
					WarSetFlag(111,War.PersonNum);
					InsertWarPerson(2,GenPerson(true,p2,"������"),	4,10,"��",2,"��",false,"����",-1,-1);
					InsertWarPerson(2,GenPerson(true,p2,"������"),	4,11,"��",2,"��",false,"����",-1,-1);
					InsertWarPerson(2,GenPerson(true,p2,"������"),	4,9,"��",2,"��",false,"����",-1,-1);
					InsertWarPerson(2,GenPerson(true,p2,"������"),	4,12,"��",2,"��",false,"����",-1,-1);
					InsertWarPerson(2,GenPerson(true,p2,"�ｫ"),		3,10,"��",2,"��",false,"����",-1,-1);
					InsertWarPerson(2,GenPerson(true,p2,"�ｫ"),		3,11,"��",2,"��",false,"����",-1,-1);
						--���� ��
					InsertWarPerson(3,GenPerson(true,p2,"����"),		9,6,"��",1,"��",true,"����",13,9);
					InsertWarPerson(3,GenPerson(true,p2,"������"),	10,5,"��",0,"��",true,"����",13,9);
					InsertWarPerson(3,GenPerson(true,p2,"������"),	11,6,"��",1,"��",true,"����",13,9);
					InsertWarPerson(3,GenPerson(true,p2,"������"),	12,5,"��",0,"��",true,"����",13,9);
					InsertWarPerson(3,GenPerson(true,p2,"������"),	13,6,"��",1,"��",true,"����",13,9);
						--���� ��
					InsertWarPerson(4,GenPerson(true,p2,"������"),	9,15,"��",0,"��",true,"����",13,13);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	10,16,"��",1,"��",true,"����",13,13);
					InsertWarPerson(4,GenPerson(true,p2,"����"),		11,15,"��",0,"��",true,"����",13,13);
					InsertWarPerson(4,GenPerson(true,p2,"����"),		12,16,"��",1,"��",true,"����",13,13);
					InsertWarPerson(4,GenPerson(true,p2,"����"),		13,17,"��",0,"��",true,"����",13,13);
					JY.Status=GAME_WMAP;
					NextEvent(1005);
				end,
			[1005]=function()
					PlayBGM(11);
					WarTalk(WarGetFlag(101),"�����ӳ���[n]��������Ӧ�ð�ȫ�˰ɣ�");
					WarTalk(WarGetFlag(111),"�ߣ������Ӳ����ģ�[n]�����ɣ�");
					WarTalk(WarGetFlag(101),31);
					WarShowTeamArmy(3);
					WarShowTeamArmy(4);
					WarModifyTeamAI(3,"����",WarGetFlag(101),-1);
					WarModifyTeamAI(4,"����",WarGetFlag(101),-1);
					WarShowTarget(true);
					PlayBGM(19);
					NextEvent(1006);
				end,
			[1006]=function()
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						--��2�غ� �Ѿ�AI�޸ģ�������
						if War.Turn==2 and (not WarCheckFlag(1)) then
							WarSetFlag(1,1);
							WarModifyTeamAI(1,"����",WarGetFlag(101),-1);
							WarModifyAI(WarGetFlag(101),"����",1,-1)
						end
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						--ǰ����ս����
						if War.PersonNumEnemy<14 and (not WarCheckFlag(2)) then
							WarSetFlag(2,1);	--�Ѿ�����
							WarTalk(WarGetFlag(111),"ǰ�߲��Ӿ�Ȼ�����ս��[n]ȫ�����������ܸ����˴�Ϣ֮����");
							WarModifyTeamAI(2,"����",WarGetFlag(111),-1);
							WarModifyAI(WarGetFlag(111),"����",-1,-1)
						end
						--�Ѿ�δ��������10�غ�
						if War.Turn==10 and (not WarCheckFlag(2)) then
							WarSetFlag(2,2);	--�о��ܹ�
							WarTalk(WarGetFlag(111),"�о��Ѿ�����һ����[n]ȫ��������");
							WarModifyTeamAI(2,"����",WarGetFlag(111),-1);
							WarModifyAI(WarGetFlag(111),"����",-1,-1)
						end
					end
				end,
			[1007]=function()
					--XXX��Ԯս
					local p1,p2,p3,p4,p5,p6,p7,p8,p9,p10;
					local wid;
					local plist={};
					--����Ԯ��
					plist=FilterPerson("������",-1,	"����","����",	"����",200);
					p1=TableRandom(plist);
					--�о���˧
					plist=FilterPerson("������",-1,	"����","ͳ��",	"����",300);
					p2=TableRandom(plist);
					--�о���˧2
					plist=FilterPerson("������",-1,	"����","����",	"����",300);
					p3=TableRandom(plist);
					
					--ս������
					WarIni();
					DefineWarMap(3,"XXX��Ԯս","һ�����ܣ�������",20,"����",p2);
					--�Ҿ�
					InsertWarPerson(0,"����",2,3,"��",0,"��",false,"����",0,0);
					SelectTeam(	1,4,"��",false,
								3,4,"��",false,
								1,2,"��",false,
								3,2,"��",false,
								2,2,"��",false,
								1,3,"��",false,
								3,3,"��",false,
								2,4,"��",false)
					
					--�Ѿ�
					InsertWarPerson(1,p1,			4,19,"��",4,"��",false,"����",0,0);
					WarSetFlag(101,War.PersonNum);
					InsertWarPerson(1,GenPerson(true,p1,"������"),		3,18,"��",0,"��",false,"����",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"������"),	4,18,"��",0,"��",false,"����",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"������"),	5,18,"��",0,"��",false,"����",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"������"),		3,19,"��",1,"��",false,"����",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"������"),	5,19,"��",1,"��",false,"����",0,0);
					
					InsertWarPerson(2,GenPerson(true,p1,"����"),	4,15,"��",0,"��",false,"����",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"�����"),	4,14,"��",1,"��",false,"����",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"������"),	3,15,"��",0,"��",false,"����",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"������"),	5,15,"��",-1,"��",false,"����",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"������"),	4,16,"��",-1,"��",false,"����",0,0);
					
					InsertWarPerson(3,GenPerson(true,p1,"����"),	9,17,"��",1,"��",false,"����",0,0);
					InsertWarPerson(3,GenPerson(true,p1,"�����"),	8,16,"��",0,"��",false,"����",0,0);
					InsertWarPerson(3,GenPerson(true,p1,"�����"),	10,16,"��",-1,"��",false,"����",0,0);
					InsertWarPerson(3,GenPerson(true,p1,"������"),	8,18,"��",1,"��",false,"����",0,0);
					InsertWarPerson(3,GenPerson(true,p1,"������"),	10,18,"��",0,"��",false,"����",0,0);
					
					--�о�
						--���� & ��Ӫ
					InsertWarPerson(4,p2,			27,11,"��",5,"��",false,"����",-1,-1);
					WarSetFlag(111,War.PersonNum);
					InsertWarPerson(4,GenPerson(true,p2,"ı��"),	26,10,"��",3,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	26,12,"��",3,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"�����"),	27,10,"��",3,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"�����"),	27,12,"��",3,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"�����"),	28,11,"��",3,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"�����"),	28,10,"��",3,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"�����"),	28,12,"��",3,"��",false,"����",-1,-1);
						--��Ӫ ǰ��
					InsertWarPerson(5,GenPerson(true,p2,"����"),	23,9,"��",2,"��",false,"����",13,9);
					InsertWarPerson(5,GenPerson(true,p2,"������"),	24,9,"��",1,"��",false,"����",13,9);
					InsertWarPerson(5,GenPerson(true,p2,"������"),	25,9,"��",1,"��",false,"����",13,9);
					InsertWarPerson(5,GenPerson(true,p2,"����"),	23,13,"��",2,"��",false,"����",13,9);
					InsertWarPerson(5,GenPerson(true,p2,"������"),	24,13,"��",1,"��",false,"����",13,9);
					InsertWarPerson(5,GenPerson(true,p2,"������"),	25,13,"��",1,"��",false,"����",13,9);
						--ǰ�� ��Ӫ
					InsertWarPerson(6,p3,			9,10,"��",5,"��",false,"����",-1,-1);
					WarSetFlag(112,War.PersonNum);
					InsertWarPerson(6,GenPerson(true,p3,"����"),		8,10,"��",3,"��",false,"����",-1,-1);
					InsertWarPerson(6,GenPerson(true,p3,"������"),	8,9,"��",2,"��",false,"����",-1,-1);
					InsertWarPerson(6,GenPerson(true,p3,"����"),		9,11,"��",3,"��",false,"����",-1,-1);
					InsertWarPerson(6,GenPerson(true,p3,"������"),	9,9,"��",2,"��",false,"����",-1,-1);
					InsertWarPerson(6,GenPerson(true,p3,"������"),	10,10,"��",2,"��",false,"����",-1,-1);
					InsertWarPerson(6,GenPerson(true,p3,"����"),		10,11,"��",3,"��",false,"����",-1,-1);
						--ǰ�� ��
					InsertWarPerson(4,GenPerson(true,p3,"������"),	5,10,"��",0,"��",false,"����",4,15);
					InsertWarPerson(4,GenPerson(true,p3,"������"),	4,9,"��",1,"��",false,"����",4,15);
					InsertWarPerson(4,GenPerson(true,p3,"������"),	3,10,"��",0,"��",false,"����",4,15);
					InsertWarPerson(4,GenPerson(true,p3,"����"),		2,11,"��",2,"��",false,"����",4,15);
					InsertWarPerson(4,GenPerson(true,p3,"����"),		1,12,"��",2,"��",false,"����",4,15);
						--ǰ�� ��
					InsertWarPerson(4,GenPerson(true,p3,"����"),	12,13,"��",1,"��",false,"����",9,17);
					InsertWarPerson(4,GenPerson(true,p3,"����"),		13,14,"��",1,"��",false,"����",9,17);
					InsertWarPerson(4,GenPerson(true,p3,"������"),	14,15,"��",0,"��",false,"����",9,17);
					InsertWarPerson(4,GenPerson(true,p3,"������"),	15,16,"��",0,"��",false,"����",9,17);
					InsertWarPerson(4,GenPerson(true,p3,"������"),	15,17,"��",0,"��",false,"����",9,17);
					JY.Status=GAME_WMAP;
					NextEvent(1008);
				end,
			[1008]=function()
					PlayBGM(11);
					WarTalk(WarGetFlag(111),30);
					WarTalk(WarGetFlag(101),31);
					WarTalk(WarGetFlag(112),"ǰ����������");
					WarShowTarget(true);
					PlayBGM(19);
					NextEvent(1009);
				end,
			[1009]=function()
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						--��2�غ� �Ѿ�AI�޸ģ�������
						if War.Turn==2 and (not WarCheckFlag(1)) then
							WarSetFlag(1,1);
							WarModifyTeamAI(2,"����",0,0);
							WarModifyTeamAI(3,"����",0,0);
						end
						--��5�غ� �Ѿ�AI�޸ģ�������
						if War.Turn==5 and (not WarCheckFlag(2)) then
							WarSetFlag(2,1);
							WarModifyTeamAI(1,"����",0,0);
						end
						--�о�δ�ܹ����о���������7
						if War.PersonNumEnemy<7 and (not WarCheckFlag(5)) then
							WarSetFlag(5,1);	--�Ѿ�����
							WarTalk(WarGetFlag(101),"������ת��[n]ȫ����������");
							WarModifyTeamAI(1,"����",0,0);
							WarModifyTeamAI(2,"����",0,0);
							WarModifyTeamAI(3,"����",0,0);
						end
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						--ǰ����ս����
						if War.PersonNumEnemy<18 and (not WarCheckFlag(4)) then
							WarSetFlag(4,1);	--�о��ܹ�
							WarTalk(WarGetFlag(111),"ǰ�߲��Ӿ�Ȼ�����ս��[n]ȫ�����������ܸ����˴�Ϣ֮����");
							WarModifyTeamAI(4,"����",WarGetFlag(111),-1);
							WarModifyAI(WarGetFlag(111),"����",-1,-1)
							WarModifyTeamAI(5,"����",0,0);
						end
						--�Ѿ�δ��������8�غ�
						if War.Turn==8 and (not WarCheckFlag(3)) then
							WarSetFlag(3,1);	--�о��ܹ�
							WarTalk(WarGetFlag(111),"���Ҽ���������");
							WarModifyTeamAI(5,"����",0,0);
						end
						
						if War.Turn==4 then
							WarTalk(WarGetFlag(112),"��ʱ����[n]ȫ��������");
							WarModifyTeamAI(6,"����",WarGetFlag(112),-1);
							WarModifyAI(WarGetFlag(112),"����",-1,-1)
						end
					end
				end,
			[1010]=function()
					--XXX��Ԯս
					local p1,p2,p3,p4,p5,p6,p7,p8,p9,p10;
					local wid;
					local plist={};
					--����Ԯ��
					plist=FilterPerson("������",-1,	"����","����",	"����",200);
					p1=TableRandom(plist);
					--�о���˧
					plist=FilterPerson("������",-1,	"����","����",	"����",200);
					p2=TableRandom(plist);
					
					--ս������
					WarIni();
					DefineWarMap(5,"XXX��Ԯս","һ�����ܣ�������",20,"����",p2);
					--�Ҿ�
					InsertWarPerson(0,"����",21,22,"��",0,"��",true,"����",0,0);
					SelectTeam(	22,21,"��",true,
								20,23,"��",true,
								22,23,"��",true,
								23,20,"��",true,
								19,24,"��",true,
								23,22,"��",true,
								21,24,"��",true,
								23,24,"��",true)
					
					--�Ѿ�
					InsertWarPerson(1,p1,						20,13,"��",4,"��",false,"����",0,0);
					WarSetFlag(101,War.PersonNum);
					InsertWarPerson(1,GenPerson(true,p1,"ı��"),		20,14,"��",2,"��",false,"����",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"����"),		20,12,"��",2,"��",false,"����",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"������"),	19,13,"��",1,"��",false,"����",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"������"),	19,14,"��",0,"��",false,"����",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"������"),	19,12,"��",0,"��",false,"����",0,0);
					
					InsertWarPerson(1,GenPerson(true,p1,"����"),		16,13,"��",2,"��",false,"����",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"������"),	16,12,"��",0,"��",false,"����",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"������"),	16,14,"��",0,"��",false,"����",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"������"),	17,13,"��",0,"��",false,"����",0,0);
					
					InsertWarPerson(2,GenPerson(true,p1,"������"),	19,8,"��",0,"��",false,"����",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"������"),	20,8,"��",-1,"��",false,"����",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"������"),	19,17,"��",0,"��",false,"����",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"������"),	20,17,"��",-1,"��",false,"����",0,0);
					
					InsertWarPerson(3,GenPerson(true,p1,"�ｫ"),		16,10,"��",3,"��",false,"����",0,0);
					InsertWarPerson(3,GenPerson(true,p1,"�����"),	16,11,"��",2,"��",false,"����",0,0);
					InsertWarPerson(3,GenPerson(true,p1,"�����"),	17,11,"��",2,"��",false,"����",0,0);
					
					--�о�
						--���� & ��Ӫ
					InsertWarPerson(4,p2,						1,13,"��",5,"��",false,"����",-1,-1);
					WarSetFlag(111,War.PersonNum);
					InsertWarPerson(4,GenPerson(true,p2,"ı��"),		1,14,"��",3,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"����"),		1,12,"��",3,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"�����"),	1,15,"��",2,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"�����"),	1,11,"��",2,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	2,13,"��",1,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	2,14,"��",1,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	2,12,"��",1,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	2,15,"��",1,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	2,11,"��",1,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	3,13,"��",1,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	3,14,"��",1,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	3,12,"��",1,"��",false,"����",-1,-1);
					
						--ǰ�� ��
					InsertWarPerson(5,GenPerson(true,p2,"����"),		8,13,"��",3,"��",false,"����",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"ͳ��"),		8,12,"��",2,"��",false,"����",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"��ı"),		8,14,"��",2,"��",false,"����",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"�����"),	9,13,"��",2,"��",false,"����",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"�����"),	9,14,"��",1,"��",false,"����",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"�����"),	9,12,"��",2,"��",false,"����",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"������"),	10,11,"��",1,"��",false,"����",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"������"),	11,10,"��",1,"��",false,"����",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"������"),	10,15,"��",1,"��",false,"����",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"������"),	11,16,"��",1,"��",false,"����",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"������"),	9,11,"��",1,"��",false,"����",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"������"),	10,10,"��",1,"��",false,"����",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"������"),	9,15,"��",1,"��",false,"����",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"������"),	10,16,"��",1,"��",false,"����",17,13);
						--ǰ�� ��
					InsertWarPerson(5,GenPerson(true,p2,"������"),	18,3,"��",2,"��",false,"����",21,10);
					InsertWarPerson(5,GenPerson(true,p2,"������"),	17,4,"��",0,"��",false,"����",21,10);
					InsertWarPerson(5,GenPerson(true,p2,"������"),	19,2,"��",0,"��",false,"����",21,10);
						--ǰ�� ��
					InsertWarPerson(5,GenPerson(true,p2,"������"),	17,22,"��",2,"��",false,"����",21,16);
					InsertWarPerson(5,GenPerson(true,p2,"������"),	16,21,"��",1,"��",false,"����",21,16);
					InsertWarPerson(5,GenPerson(true,p2,"������"),	18,23,"��",0,"��",false,"����",21,16);
					JY.Status=GAME_WMAP;
					NextEvent(1011);
				end,
			[1011]=function()
					PlayBGM(11);
					WarTalk(WarGetFlag(111),30);
					WarTalk(WarGetFlag(101),31);
					PlayBGM(19);
					NextEvent(1012);
				end,
			[1012]=function()
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						if War.Turn==3 then
							WarShowTeamArmy(0);
							WarModifyTeamAI(5,"����",0,0);
							WarShowTarget(true);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						--��2�غ� �Ѿ�AI�޸ģ�������
						if War.Turn==3 then
							WarModifyTeamAI(2,"����",0,0);
							WarModifyTeamAI(3,"����",0,0);
						end
						if War.Turn==6 then
							WarModifyTeamAI(1,"����",0,0);
							WarModifyAI(WarGetFlag(101),"����",0,0);
						end
						--�о�δ�ܹ����о���������7
						if War.PersonNumEnemy<7 and (not WarCheckFlag(1)) then
							WarSetFlag(1,1);	--�Ѿ�����
							WarTalk(WarGetFlag(101),"������ת��[n]ȫ����������");
							WarModifyTeamAI(1,"����",WarGetFlag(101),0);
							WarModifyTeamAI(2,"����",WarGetFlag(101),0);
							WarModifyTeamAI(3,"����",WarGetFlag(101),0);
							WarModifyAI(WarGetFlag(101),"����",-1,-1)
						end
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						--ǰ����ս����
						if War.PersonNumEnemy<20 and (not WarCheckFlag(2)) then
							WarSetFlag(2,1);	--�о��ܹ�
							WarTalk(WarGetFlag(111),"ǰ�߲��Ӿ�Ȼ�����ս��[n]ȫ�����������ܸ����˴�Ϣ֮����");
							WarModifyTeamAI(4,"����",WarGetFlag(111),-1);
							WarModifyAI(WarGetFlag(111),"����",-1,-1)
							WarModifyTeamAI(5,"����",0,0);
						end
					end
				end,
			[1013]=function()
					--XXX��Ԯս
					local p1,p2,p3,p4,p5,p6,p7,p8,p9,p10;
					local wid;
					local plist={};
					--����Ԯ��
					plist=FilterPerson("������",-1,	"����","����",	"����",200);
					p1=TableRandom(plist);
					--�о���˧
					plist=FilterPerson("������",-1,	"����","����",	"����",200);
					p2=TableRandom(plist);
					
					--ս������
					WarIni();
					DefineWarMap(9,"XXX��Ԯս","һ�����ܣ�������",20,"����",p2);
					--�Ҿ�
					InsertWarPerson(0,"����",3,2,"��",0,"��",false,"����",0,0);
					SelectTeam(	5,2,"��",false,
								4,3,"��",false,
								2,3,"��",false,
								6,3,"��",false,
								7,2,"��",false,
								5,4,"��",false,
								3,4,"��",false,
								7,4,"��",false)
					
					--�Ѿ�
					InsertWarPerson(1,p1,						20,13,"��",4,"��",false,"����",0,0);
					WarSetFlag(101,War.PersonNum);
					InsertWarPerson(1,GenPerson(true,p1,"ı��"),		20,14,"��",2,"��",false,"����",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"����"),		20,12,"��",2,"��",false,"����",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"������"),	19,13,"��",1,"��",false,"����",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"������"),	19,14,"��",0,"��",false,"����",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"������"),	19,12,"��",0,"��",false,"����",0,0);
					
					InsertWarPerson(1,GenPerson(true,p1,"����"),		16,13,"��",2,"��",false,"����",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"������"),	16,12,"��",0,"��",false,"����",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"������"),	16,14,"��",0,"��",false,"����",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"������"),	17,13,"��",0,"��",false,"����",0,0);
					
					InsertWarPerson(2,GenPerson(true,p1,"������"),	19,8,"��",0,"��",false,"����",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"������"),	20,8,"��",-1,"��",false,"����",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"������"),	19,17,"��",0,"��",false,"����",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"������"),	20,17,"��",-1,"��",false,"����",0,0);
					
					InsertWarPerson(3,GenPerson(true,p1,"�ｫ"),		16,10,"��",3,"��",false,"����",0,0);
					InsertWarPerson(3,GenPerson(true,p1,"�����"),	16,11,"��",2,"��",false,"����",0,0);
					InsertWarPerson(3,GenPerson(true,p1,"�����"),	17,11,"��",2,"��",false,"����",0,0);
					
					--�о�
						--���� & ��Ӫ
					InsertWarPerson(4,p2,						8,14,"��",5,"��",false,"����",-1,-1);
					WarSetFlag(111,War.PersonNum);
					InsertWarPerson(4,GenPerson(true,p2,"ı��"),		8,15,"��",3,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"����"),		8,13,"��",3,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	7,14,"��",1,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	9,14,"��",1,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	9,15,"��",1,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	9,13,"��",1,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	10,15,"��",1,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	10,13,"��",1,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	10,16,"��",1,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	10,12,"��",1,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"�����"),	11,16,"��",2,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"�����"),	11,12,"��",2,"��",false,"����",-1,-1);
					
						--�о�
					InsertWarPerson(5,GenPerson(true,p2,"�ｫ"),		16,16,"��",3,"��",false,"����",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"�����"),	15,17,"��",0,"��",false,"����",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"�����"),	15,18,"��",0,"��",false,"����",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"�����"),	17,17,"��",1,"��",false,"����",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"�����"),	17,18,"��",1,"��",false,"����",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"����"),		16,15,"��",2,"��",false,"����",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"������"),	15,15,"��",1,"��",false,"����",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"������"),	17,15,"��",1,"��",false,"����",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"������"),	16,14,"��",1,"��",false,"����",17,13);
						--ǰ��
					InsertWarPerson(6,GenPerson(true,p2,"����"),		19,7,"��",3,"��",false,"����",21,10);
					InsertWarPerson(6,GenPerson(true,p2,"������"),	17,5,"��",1,"��",false,"����",21,10);
					InsertWarPerson(6,GenPerson(true,p2,"������"),	19,5,"��",1,"��",false,"����",21,16);
					InsertWarPerson(6,GenPerson(true,p2,"����"),		12,2,"��",1,"��",false,"����",21,16);
					InsertWarPerson(6,GenPerson(true,p2,"����"),		13,4,"��",1,"��",false,"����",21,16);
					InsertWarPerson(6,GenPerson(RND(0.5),p2,"������","������"),	18,6,"��",2,"��",false,"����",21,10);
					InsertWarPerson(6,GenPerson(RND(0.5),p2,"������","������"),	20,6,"��",1,"��",false,"����",21,16);
					JY.Status=GAME_WMAP;
					NextEvent(1014);
				end,
			[1014]=function()
					PlayBGM(11);
					WarTalk(WarGetFlag(111),30);
					WarTalk(WarGetFlag(101),31);
					PlayBGM(19);
					NextEvent(1015);
				end,
			[1015]=function()
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(2)) and WarCheckArea(-1,1,10,12,20) then
							WarSetFlag(2,1);
							WarTalk(WarGetFlag(111),"�ɶ񣬾�Ȼ�õ���ɱ���������ˣ�");
							WarModifyTeamAI(4,"����",0,0);
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						--��2�غ� �Ѿ�AI�޸ģ�������
						if War.Turn==2 then
							WarModifyTeamAI(1,"����",0,0);
						end
						--�о�δ�ܹ����о���������7
						if War.PersonNumEnemy<10 and (not WarCheckFlag(1)) then
							WarSetFlag(1,1);	--�Ѿ�����
							WarTalk(WarGetFlag(101),"������ת��[n]ȫ����������");
							WarModifyTeamAI(1,"����",WarGetFlag(101),0);
							WarModifyAI(WarGetFlag(101),"����",-1,-1)
						end
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==2 then
							WarModifyTeamAI(6,"����",0,0);
							WarModifyTeamAI(5,"����",19,7);
						end
						if War.Turn==5 then
							WarModifyTeamAI(6,"����",0,0);
							WarModifyTeamAI(5,"����",0,0);
						end
						if (not WarCheckFlag(2)) and War.Turn==8 then
							WarSetFlag(2,2);
							WarModifyTeamAI(4,"����",0,0);
						end
					end
				end,
			[1016]=function()
					--XXX��Ԯս
					local p1,p2,p3,p4,p5,p6,p7,p8,p9,p10;
					local wid;
					local plist={};
					--����Ԯ��
					plist=FilterPerson("������",-1,	"����","��Դ",	"����",200);
					p1=TableRandom(plist);
					--�о���˧
					plist=FilterPerson("������",-1,	"����","ͳ��",	"����",200);
					p2=TableRandom(plist);
					
					--ս������
					WarIni();
					DefineWarMap(10,"XXX��Ԯս","һ�����ܣ�������",20,"����",p2);
					--�Ҿ�
					InsertWarPerson(0,"����",1,10,"��",0,"��",false,"����",0,0);
					SelectTeam(	1,9,"��",false,
								1,11,"��",false,
								1,8,"��",false,
								1,12,"��",false,
								1,7,"��",false,
								1,13,"��",false,
								1,6,"��",false,
								1,14,"��",false)
					
					--�Ѿ�
					InsertWarPerson(1,p1,								13,9,"��",4,"��",false,"����",0,0);
					WarSetFlag(101,War.PersonNum);
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"����"),	12,9,"��",2,"��",false,"����",0,0);
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"����"),	13,10,"��",2,"��",false,"����",0,0);
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"�����"),		14,9,"��",-1,"��",false,"����",0,0);
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"������","������"),	12,10,"��",0,"��",false,"����",0,0);
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"������"),	14,10,"��",-1,"��",false,"����",0,0);
					
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"����"),	11,9,"��",2,"��",false,"����",10,9);
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"�����"),		11,8,"��",-1,"��",false,"����",10,8);
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"�����","������"),	11,10,"��",0,"��",false,"����",10,10);
					
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"ͳ��"),	15,9,"��",2,"��",false,"����",19,10);
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"������"),		15,8,"��",-1,"��",false,"����",19,9);
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"������","������"),	15,10,"��",0,"��",false,"����",19,11);
					
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"����"),	13,11,"��",2,"��",false,"����",15,12);
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"����"),		12,11,"��",-1,"��",false,"����",14,12);
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"����","������"),	14,11,"��",0,"��",false,"����",16,12);
					
					--�о�
						--���� & ��Ӫ
					InsertWarPerson(4,p2,						15,20,"��",5,"��",false,"����",-1,-1);
					WarSetFlag(111,War.PersonNum);
					InsertWarPerson(4,GenPerson(true,p2,"����"),		14,20,"��",3,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"����"),		16,20,"��",3,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	13,18,"��",1,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	14,18,"��",0,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	15,18,"��",-1,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	16,18,"��",1,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	17,18,"��",0,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	13,20,"��",0,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	17,20,"��",0,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"�����"),	13,19,"��",1,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"�����"),	14,19,"��",1,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"�ｫ"),	15,19,"��",2,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"�����"),	16,19,"��",0,"��",false,"����",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"�����"),	17,19,"��",0,"��",false,"����",-1,-1);
					
					InsertWarPerson(4,GenPerson(true,p2,"�����"),	11,15,"��",2,"��",false,"����",15,12);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	11,16,"��",0,"��",false,"����",15,12);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	11,17,"��",1,"��",false,"����",15,12);
					InsertWarPerson(4,GenPerson(true,p2,"�����"),	18,15,"��",2,"��",false,"����",15,12);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	18,16,"��",0,"��",false,"����",15,12);
					InsertWarPerson(4,GenPerson(true,p2,"������"),	18,17,"��",1,"��",false,"����",15,12);
					
						--��
					InsertWarPerson(5,GenPerson(true,p2,"����"),	8,19,"��",3,"��",false,"����",8,10);
					InsertWarPerson(5,GenPerson(true,p2,"����"),	8,18,"��",2,"��",false,"����",8,10);
					InsertWarPerson(5,GenPerson(true,p2,"����"),	7,19,"��",1,"��",false,"����",8,10);
					InsertWarPerson(5,GenPerson(true,p2,"����"),	9,19,"��",1,"��",false,"����",8,10);
					InsertWarPerson(5,GenPerson(0.5,p2,"������"),	6,20,"��",1,"��",false,"����",8,10);
					InsertWarPerson(5,GenPerson(0.7,p2,"������"),	7,20,"��",0,"��",false,"����",8,10);
					InsertWarPerson(5,GenPerson(true,p2,"������"),	8,20,"��",1,"��",false,"����",8,10);
					InsertWarPerson(5,GenPerson(true,p2,"������"),	9,20,"��",-1,"��",false,"����",8,10);
					InsertWarPerson(5,GenPerson(true,p2,"������"),	10,20,"��",-1,"��",false,"����",8,10);
						--��
					InsertWarPerson(6,GenPerson(true,p2,"����"),		22,18,"��",3,"��",false,"����",22,9);
					InsertWarPerson(6,GenPerson(true,p2,"������"),		21,18,"��",2,"��",false,"����",22,9);
					InsertWarPerson(6,GenPerson(true,p2,"������"),		21,19,"��",-1,"��",false,"����",22,9);
					InsertWarPerson(6,GenPerson(true,p2,"����"),		20,19,"��",1,"��",false,"����",22,9);
					InsertWarPerson(6,GenPerson(true,p2,"����"),		20,20,"��",-1,"��",false,"����",22,9);
					InsertWarPerson(6,GenPerson(RND(0.5),p2,"������","������"),	19,20,"��",0,"��",false,"����",22,9);
					InsertWarPerson(6,GenPerson(RND(0.5),p2,"������","������"),	21,20,"��",1,"��",false,"����",22,9);
						--Ԯ��
					InsertWarPerson(7,GenPerson(true,p2,"��ı"),		21,2,"��",3,"��",true,"����",14,7);
					InsertWarPerson(7,GenPerson(true,p2,"������"),		19,1,"��",1,"��",true,"����",14,7);
					InsertWarPerson(7,GenPerson(true,p2,"������"),		20,2,"��",0,"��",true,"����",14,7);
					InsertWarPerson(7,GenPerson(true,p2,"����"),		21,3,"��",0,"��",true,"����",14,7);
					InsertWarPerson(7,GenPerson(true,p2,"����"),		20,1,"��",1,"��",true,"����",14,7);
					InsertWarPerson(7,GenPerson(RND(0.5),p2,"�����","������"),	22,3,"��",1,"��",true,"����",14,7);
					InsertWarPerson(7,GenPerson(RND(0.5),p2,"�����","������"),	22,4,"��",1,"��",true,"����",14,7);
					JY.Status=GAME_WMAP;
					NextEvent(1017);
				end,
			[1017]=function()
					PlayBGM(11);
					WarTalk(WarGetFlag(111),30);
					WarTalk(WarGetFlag(101),31);
					PlayBGM(19);
					NextEvent(1018);
				end,
			[1018]=function()
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(2)) and WarCheckArea(-1,8,17,21,20) then
							WarSetFlag(2,1);
							WarTalk(WarGetFlag(111),"�ɶ񣬾�Ȼ�õ���ɱ���������ˣ�");
							WarModifyTeamAI(4,"����",0,0);
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						--��2�غ� �Ѿ�AI�޸ģ�������
						if War.Turn==4 then
							WarModifyTeamAI(1,"����",0,0);
						end
						--�о�δ�ܹ����о���������7
						if War.PersonNumEnemy<10 and (not WarCheckFlag(1)) then
							WarSetFlag(1,1);	--�Ѿ�����
							WarTalk(WarGetFlag(101),"������ת��[n]ȫ����������");
							WarModifyTeamAI(1,"����",WarGetFlag(101),0);
							WarModifyAI(WarGetFlag(101),"����",-1,-1)
						end
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==3 then
							WarTalk(WarGetFlag(111),"������Ԯ��������");
							WarShowTeamArmy(7);
							WarTeamAI(7);
						end
						if (not WarCheckFlag(2)) and War.Turn==7 then
							WarSetFlag(2,2);
							WarTalk(WarGetFlag(111),"ȫ����������");
							WarModifyTeamAI(4,"����",0,0);
						end
					end
				end,
			[1019]=function()
					JY.Status=GAME_START;
				end,
			[1020]=function()
					JY.Status=GAME_START;
				end,
			[1021]=function()
					JY.Status=GAME_START;
				end,
			[1022]=function()
					JY.Status=GAME_START;
				end,
			[1023]=function()
					JY.Status=GAME_START;
				end,
			[1024]=function()
					JY.Status=GAME_START;
				end,
			[1025]=function()
					JY.Status=GAME_START;
				end,
			[1026]=function()
					JY.Status=GAME_START;
				end,
			[1027]=function()
					JY.Status=GAME_START;
				end,
			[1028]=function()
					JY.Status=GAME_START;
				end,
			[1029]=function()
					JY.Status=GAME_START;
				end,
			[1030]=function()
					JY.Status=GAME_START;
				end,
			[1031]=function()
					JY.Status=GAME_START;
				end,
			[1032]=function()
					JY.Status=GAME_START;
				end,
			[1033]=function()
					JY.Status=GAME_START;
				end,
			[1034]=function()
					JY.Status=GAME_START;
				end,
			[1035]=function()
					JY.Status=GAME_START;
				end,
			[1036]=function()
					JY.Status=GAME_START;
				end,
			[1037]=function()
					JY.Status=GAME_START;
				end,
			[1038]=function()
					JY.Status=GAME_START;
				end,
			[1039]=function()
					JY.Status=GAME_START;
				end,
			[1040]=function()
					JY.Status=GAME_START;
				end,
			[1041]=function()
					JY.Status=GAME_START;
				end,
			[1042]=function()
					JY.Status=GAME_START;
				end,
			[1043]=function()
					JY.Status=GAME_START;
				end,
			[1044]=function()
					JY.Status=GAME_START;
				end,
			[1045]=function()
					JY.Status=GAME_START;
				end,
			[1046]=function()
					JY.Status=GAME_START;
				end,
			[1047]=function()
					JY.Status=GAME_START;
				end,
			[1048]=function()
					JY.Status=GAME_START;
				end,
			[1049]=function()
					JY.Status=GAME_START;
				end,
			[1050]=function()
					JY.Status=GAME_START;
				end,
			[1051]=function()
					JY.Status=GAME_START;
				end,
			[1052]=function()
					JY.Status=GAME_START;
				end,
			[1053]=function()
					JY.Status=GAME_START;
				end,
			[1054]=function()
					JY.Status=GAME_START;
				end,
			[1055]=function()
					JY.Status=GAME_START;
				end,
			[1056]=function()
					JY.Status=GAME_START;
				end,
			[1057]=function()
					JY.Status=GAME_START;
				end,
			[1058]=function()
					JY.Status=GAME_START;
				end,
			[1059]=function()
					JY.Status=GAME_START;
				end,
			[1060]=function()
					JY.Status=GAME_START;
				end,
			[1061]=function()
					JY.Status=GAME_START;
				end,
			[1062]=function()
					JY.Status=GAME_START;
				end,
			[1063]=function()
					JY.Status=GAME_START;
				end,
			[1064]=function()
					JY.Status=GAME_START;
				end,
			[1065]=function()
					JY.Status=GAME_START;
				end,
			[1066]=function()
					JY.Status=GAME_START;
				end,
			[1067]=function()
					JY.Status=GAME_START;
				end,
			[1068]=function()
					JY.Status=GAME_START;
				end,
			[1069]=function()
					JY.Status=GAME_START;
				end,
			[1070]=function()
					JY.Status=GAME_START;
				end,
			[1071]=function()
					JY.Status=GAME_START;
				end,
			[1072]=function()
					JY.Status=GAME_START;
				end,
			[1073]=function()
					JY.Status=GAME_START;
				end,
			[1074]=function()
					JY.Status=GAME_START;
				end,
			[1075]=function()
					JY.Status=GAME_START;
				end,
			[1076]=function()
					JY.Status=GAME_START;
				end,
			[1077]=function()
					JY.Status=GAME_START;
				end,
			[1078]=function()
					JY.Status=GAME_START;
				end,
			[1079]=function()
					JY.Status=GAME_START;
				end,
			[1080]=function()
					JY.Status=GAME_START;
				end,
			[1081]=function()
					JY.Status=GAME_START;
				end,
			[1082]=function()
					JY.Status=GAME_START;
				end,
			[1083]=function()
					JY.Status=GAME_START;
				end,
			[1084]=function()
					JY.Status=GAME_START;
				end,
			[1085]=function()
					JY.Status=GAME_START;
				end,
			[1086]=function()
					JY.Status=GAME_START;
				end,
			[1087]=function()
					JY.Status=GAME_START;
				end,
			[1088]=function()
					JY.Status=GAME_START;
				end,
			[1089]=function()
					JY.Status=GAME_START;
				end,
			[1090]=function()
					JY.Status=GAME_START;
				end,
			[1091]=function()
					JY.Status=GAME_START;
				end,
			[1092]=function()
					JY.Status=GAME_START;
				end,
			[1093]=function()
					JY.Status=GAME_START;
				end,
			[1094]=function()
					JY.Status=GAME_START;
				end,
			[1095]=function()
					JY.Status=GAME_START;
				end,
			[1096]=function()
					JY.Status=GAME_START;
				end,
			[1097]=function()
					JY.Status=GAME_START;
				end,
			[1098]=function()
					JY.Status=GAME_START;
				end,
			[1099]=function()
					JY.Status=GAME_START;
				end,
			[2050]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(5,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�
					--InsertWarPerson(0,0,1,13,"��",0,"��",false,"����",0,0);
					SelectTeam(	1,13,"��",false,
								2,14,"��",false,
								2,12,"��",false,
								1,11,"��",false,
								1,15,"��",false,
								2,16,"��",false,
								2,10,"��",false,
								1,9,"��",false,
								1,17,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,20,13,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,16,13,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(3,p,19,8,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(4,p,20,17,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,17,10,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,17,15,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(7,p,22,10,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(8,p,22,15,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(9,p,18,12,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(10,p,21,5,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(11,p,21,20,"��","��",false,"��",1,"����",0,0);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,20,13,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,16,13,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(3,p,19,8,"��","��",false,"��",1,"����",13,6);
						InsertWarTeam(4,p,20,17,"��","��",false,"��",1,"����",13,19);
						InsertWarTeam(5,p,14,13,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,18,3,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(7,p,17,22,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(8,p,13,9,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(9,p,13,16,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(10,p,18,11,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(11,p,18,15,"��","��",false,"��",1,"����",0,0);
					end
					JY.Status=GAME_WMAP;
					NextEvent(2051);
				end,
			[2051]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2052);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2053);
					end
				end,
			[2052]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(51)) and WarCheckArea(-1,13,10,16,15) then	--���˽���ǰ������
							WarSetFlag(51,1);
							WarModifyTeamAI(2,"����",16,13);
							WarModifyTeamAI(5,"����",16,13);
							WarModifyTeamAI(6,"����",16,13);
							WarModifyTeamAI(9,"����",16,13);
						end
						if (not WarCheckFlag(52)) and WarCheckArea(-1,17,3,24,7) then	--���˽����Ϸ�����
							WarSetFlag(52,1);
							WarModifyTeamAI(3,"����",19,8);
							WarModifyTeamAI(7,"����",19,8);
							WarModifyTeamAI(10,"����",19,8);
						end
						if (not WarCheckFlag(53)) and WarCheckArea(-1,17,18,24,22) then	--���˽����·�����
							WarSetFlag(53,1);
							WarModifyTeamAI(4,"����",19,17);
							WarModifyTeamAI(8,"����",19,17);
							WarModifyTeamAI(11,"����",19,17);
						end
						if (not WarCheckFlag(54)) and WarCheckArea(-1,16,8,22,17) then	--���˽������
							WarSetFlag(54,1);WarSetFlag(51,1);WarSetFlag(52,1);WarSetFlag(53,1);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2053]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==2 then
							WarModifyTeamAI(3,"����",0,0);
							WarModifyTeamAI(4,"����",0,0);
						end
						if War.Turn==3 then
							WarModifyTeamAI(1,"����",0,0);
						end
					end
				end,
				
			[2060]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(6,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�
					--InsertWarPerson(0,0,1,13,"��",0,"��",false,"����",0,0);
					SelectTeam(	4,2,"��",false,
								3,3,"��",false,
								6,2,"��",false,
								5,3,"��",false,
								4,4,"��",false,
								7,3,"��",false,
								6,4,"��",false,
								5,5,"��",false,
								4,6,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,20,18,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,22,18,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(3,p,16,18,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(4,p,21,14,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,12,20,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,23,10,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(7,p,12,15,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(8,p,18,10,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(9,p,20,21,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(10,p,25,18,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(11,p,5,17,"��","��",false,"��",1,"�ƶ�",14,19);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,20,18,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,22,18,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(3,p,15,18,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(4,p,21,13,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,13,16,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,19,11,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(7,p,13,19,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(8,p,22,11,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(9,p,11,18,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(10,p,21,9,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(11,p,5,17,"��","��",false,"��",1,"����",0,0);
					end
					JY.Status=GAME_WMAP;
					NextEvent(2061);
				end,
			[2061]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2062);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2063);
					end
				end,
			[2062]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(51)) and WarCheckArea(-1,14,8,28,13) then	--���˽����Ϸ�����
							WarSetFlag(51,1);
							WarModifyTeamAI(4,"����",20,12);
							WarModifyTeamAI(6,"����",21,10);
							WarModifyTeamAI(8,"����",20,11);
							WarModifyTeamAI(10,"����",21,14);
						end
						if (not WarCheckFlag(52)) and WarCheckArea(-1,10,12,15,24) then	--���˽����·�����
							WarSetFlag(52,1);
							WarModifyTeamAI(3,"����",14,18);
							WarModifyTeamAI(5,"����",12,18);
							WarModifyTeamAI(7,"����",13,17);
							WarModifyTeamAI(9,"����",16,18);
							WarModifyTeamAI(11,"����",14,19);
						end
						if (not WarCheckFlag(54)) and WarCheckArea(-1,14,12,28,24) then	--���˽������
							WarSetFlag(54,1);WarSetFlag(51,1);WarSetFlag(52,1);
							WarModifyTeamAI(1,"����",20,18);
							WarModifyTeamAI(2,"����",20,18);
							for i=3,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2063]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==2 then
							WarModifyTeamAI(11,"����",0,0);
						end
						if War.Turn==3 then
							WarModifyTeamAI(1,"����",0,0);
							WarModifyTeamAI(2,"����",0,0);
						end
					end
				end,
				
			[2080]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(8,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�
					--InsertWarPerson(0,0,1,13,"��",0,"��",false,"����",0,0);
					SelectTeam(	2,22,"��",false,
								3,23,"��",false,
								2,20,"��",false,
								3,21,"��",false,
								4,22,"��",false,
								5,23,"��",false,
								4,20,"��",false,
								5,21,"��",false,
								6,22,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,20,4,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,21,3,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(3,p,17,3,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(4,p,21,6,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,15,5,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,19,8,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(7,p,13,2,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(8,p,22,9,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(9,p,12,5,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(10,p,21,11,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(11,p,15,8,"��","��",false,"��",1,"����",0,0);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,20,4,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,21,3,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(3,p,5,3,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(4,p,4,5,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,6,5,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,19,8,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(7,p,22,8,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(8,p,20,11,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(9,p,21,13,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(10,p,4,2,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(11,p,6,2,"��","��",false,"��",1,"����",0,0);
					end
					JY.Status=GAME_WMAP;
					NextEvent(2081);
				end,
			[2081]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2082);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2083);
					end
				end,
			[2082]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(51)) and WarCheckArea(-1,9,1,15,9) then	--���˽����Ϸ�����
							WarSetFlag(51,1);
							WarModifyTeamAI(3,"����",14,3);
							WarModifyTeamAI(5,"����",13,5);
							WarModifyTeamAI(7,"����",13,3);
							WarModifyTeamAI(9,"����",12,4);
						end
						if (not WarCheckFlag(52)) and WarCheckArea(-1,9,8,24,14) then	--���˽����·�����
							WarSetFlag(52,1);
							WarModifyTeamAI(4,"����",21,9);
							WarModifyTeamAI(6,"����",20,10);
							WarModifyTeamAI(8,"����",21,11);
							WarModifyTeamAI(10,"����",20,11);
						end
						if (not WarCheckFlag(54)) and WarCheckArea(-1,14,1,14,9) then	--���˽������
							WarSetFlag(54,1);WarSetFlag(51,1);WarSetFlag(52,1);
							WarModifyTeamAI(1,"����",20,18);
							WarModifyTeamAI(2,"����",20,18);
							for i=3,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2083]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==3 then
							WarModifyTeamAI(1,"����",0,0);
							WarModifyTeamAI(2,"����",0,0);
						end
					end
				end,
				
			[2100]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(10,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�
					SelectTeam(	14,19,"��",false,
								16,19,"��",false,
								15,20,"��",false,
								13,20,"��",false,
								17,20,"��",false,
								12,19,"��",false,
								11,20,"��",false,
								18,19,"��",false,
								19,20,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,13,9,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,14,13,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(3,p,16,9,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(4,p,10,9,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,19,9,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,13,11,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(7,p,16,11,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(8,p,12,7,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(9,p,17,7,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(10,p,11,12,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(11,p,18,12,"��","��",false,"��",2,"����",0,0);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,13,9,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,14,13,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(3,p,16,9,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(4,p,7,9,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,22,9,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,12,15,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(7,p,17,15,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(8,p,11,10,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(9,p,19,10,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(10,p,11,12,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(11,p,18,12,"��","��",false,"��",1,"����",0,0);
					end
					JY.Status=GAME_WMAP;
					NextEvent(2101);
				end,
			[2101]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2102);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2103);
					end
				end,
			[2102]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(54)) and WarCheckArea(-1,9,6,20,13) then	--���˽������
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"����",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2103]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==3 then
							WarModifyTeamAI(1,"����",0,0);
							WarModifyTeamAI(3,"����",0,0);
						end
					end
				end,
				
			[2110]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid)*100;
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(11,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�
					SelectTeam(	13,2,"��",false,
								15,2,"��",false,
								11,2,"��",false,
								17,2,"��",false,
								14,1,"��",false,
								12,1,"��",false,
								16,1,"��",false,
								18,1,"��",false,
								10,1,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					enpcnum=1110;
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,13,13,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,11,9,"��","��",false,"��",3,"����",0,0);
						InsertWarTeam(3,p,11,13,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(4,p,15,13,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(5,p,9,9,"��","��",false,"��",3,"����",0,0);
						InsertWarTeam(6,p,17,9,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(7,p,9,11,"��","��",false,"��",3,"����",0,0);
						InsertWarTeam(8,p,9,15,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(9,p,17,12,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(10,p,12,17,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(11,p,17,16,"��","��",false,"��",2,"����",0,0);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,13,13,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,11,9,"��","��",false,"��",3,"����",0,0);
						InsertWarTeam(3,p,11,13,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(4,p,15,13,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(5,p,9,9,"��","��",false,"��",3,"����",0,0);
						InsertWarTeam(6,p,17,9,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(7,p,17,13,"��","��",false,"��",3,"����",0,0);
						InsertWarTeam(8,p,19,14,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(9,p,22,13,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(10,p,8,13,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(11,p,16,17,"��","��",false,"��",2,"����",0,0);
					end
					JY.Status=GAME_WMAP;
					NextEvent(2111);
				end,
			[2111]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2112);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2113);
					end
				end,
			[2112]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(54)) and WarCheckArea(-1,9,9,17,17) then	--���˽������
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"����",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2113]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==3 then
							WarModifyTeamAI(1,"����",0,0);
							WarModifyTeamAI(2,"����",0,0);
							WarModifyTeamAI(3,"����",0,0);
						end
					end
				end,
				
			[2120]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(12,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�
					SelectTeam(	27,3,"��",false,
								27,5,"��",false,
								26,4,"��",false,
								25,5,"��",false,
								24,4,"��",false,
								24,6,"��",false,
								23,5,"��",false,
								23,7,"��",false,
								22,6,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					-- 1 normal; 2����; 3 ˮս; 4 ����; 5 ���
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,1,10,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,3,10,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(3,p,7,11,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(4,p,6,4,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,6,17,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,5,4,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(7,p,5,17,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(8,p,17,5,"��","��",true,"��",4,"����",0,0);
						InsertWarTeam(9,p,16,12,"��","��",true,"��",4,"����",0,0);
						InsertWarTeam(10,p,14,3,"��","��",true,"��",4,"����",0,0);
						InsertWarTeam(11,p,15,14,"��","��",true,"��",4,"����",0,0);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,1,10,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,3,10,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(3,p,7,11,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(4,p,6,4,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,6,17,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,5,4,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(7,p,5,17,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(8,p,2,7,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(9,p,2,14,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(10,p,3,8,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(11,p,3,12,"��","��",false,"��",4,"����",0,0);
					end
					JY.Status=GAME_WMAP;
					NextEvent(2121);
				end,
			[2121]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2122);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2123);
					end
				end,
			[2122]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(51)) and WarCheckArea(-1,1,1,11,20) then	--���˽ӽ����ţ���������
							WarSetFlag(51,1);
							WarSetFlag(52,1);
						end
						if (not WarCheckFlag(54)) and WarCheckArea(-1,1,1,7,20) then	--���˽������
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"����",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if WarCheckFlag(52) then
							WarSetFlag(52,0);
							if WarGetFlag(11)>=8 then
								WarShowTeamArmy(8);
								WarShowTeamArmy(9);
								WarShowTeamArmy(10);
								WarShowTeamArmy(11);
								WarTalk(WarGetFlag(110+8),29);
								for i=9,11 do
									local pid=WarGetFlag(110+i);
									if pid>0 and JY.Person[pid]["̨��"]>=0 then
										WarTalk(pid,29);
									end
								end
							end
						end
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2123]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"����",0,0);
						end
					end
				end,
				 
			[2130]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(13,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�
					SelectTeam(	3,3,"��",false,
								4,2,"��",false,
								2,4,"��",false,
								2,2,"��",false,
								5,3,"��",false,
								4,4,"��",false,
								3,5,"��",false,
								2,6,"��",false,
								6,2,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,20,26,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,11,26,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(3,p,20,23,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(4,p,15,27,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(5,p,12,6,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,12,8,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(7,p,11,15,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(8,p,13,20,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(9,p,5,23,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(10,p,7,19,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(11,p,17,11,"��","��",false,"��",1,"����",0,0);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,20,26,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,11,26,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(3,p,20,23,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(4,p,15,27,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(5,p,12,6,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,12,8,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(7,p,11,15,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(8,p,13,20,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(9,p,5,23,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(10,p,7,19,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(11,p,17,11,"��","��",false,"��",1,"����",0,0);
					end
					JY.Status=GAME_WMAP;
					NextEvent(2131);
				end,
			[2131]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2132);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2133);
					end
				end,
			[2132]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(54)) and WarCheckArea(-1,8,22,20,28) then	--���˽������
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"����",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2133]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==2 then
							WarModifyTeamAI(2,"����",0,0);
							WarModifyTeamAI(3,"����",0,0);
						end
						if War.Turn==3 then
							WarModifyTeamAI(6,"����",0,0);
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"����",0,0);
							WarModifyTeamAI(5,"����",0,0);
						end
					end
				end,
				
			[2140]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(14,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�
					SelectTeam(	27,3,"��",false,
								26,2,"��",false,
								28,4,"��",false,
								25,3,"��",false,
								26,4,"��",false,
								24,2,"��",false,
								27,5,"��",false,
								28,6,"��",false,
								25,1,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,14,17,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,14,12,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(3,p,20,17,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(4,p,16,17,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(5,p,14,15,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(6,p,9,17,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(7,p,14,21,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(8,p,17,13,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(9,p,19,14,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(10,p,11,13,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(11,p,19,19,"��","��",false,"��",2,"����",0,0);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,14,17,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,14,12,"��","��",false,"��",5,"����",19,3);
						InsertWarTeam(3,p,20,17,"��","��",false,"��",5,"����",27,9);
						InsertWarTeam(4,p,16,17,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(5,p,14,15,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(6,p,9,17,"��","��",false,"��",1,"����",19,3);
						InsertWarTeam(7,p,14,21,"��","��",false,"��",1,"����",27,9);
						InsertWarTeam(8,p,17,13,"��","��",false,"��",5,"����",19,3);
						InsertWarTeam(9,p,19,14,"��","��",false,"��",5,"����",27,9);
						InsertWarTeam(10,p,11,13,"��","��",false,"��",2,"����",19,3);
						InsertWarTeam(11,p,19,19,"��","��",false,"��",2,"����",27,9);
					end
					JY.Status=GAME_WMAP;
					NextEvent(2141);
				end,
			[2141]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2142);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2143);
					end
				end,
			[2142]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(54)) and WarCheckArea(-1,9,12,20,21) then	--���˽������
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"����",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2143]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"����",0,0);
						end
					end
				end,
				
			[2160]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(16,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�
					SelectTeam(	5,5,"��",false,
								6,4,"��",false,
								4,6,"��",false,
								6,6,"��",false,
								7,5,"��",false,
								5,7,"��",false,
								8,4,"��",false,
								4,8,"��",false,
								7,3,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					-- 1 normal; 2����; 3 ˮս; 4 ����; 5 ���
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,18,19,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,10,15,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(3,p,17,10,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(4,p,17,17,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,16,20,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,10,17,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(7,p,15,10,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(8,p,11,13,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(9,p,19,11,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(10,p,13,16,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(11,p,17,13,"��","��",false,"��",2,"����",0,0);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,18,19,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,10,15,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(3,p,17,10,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(4,p,17,17,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,16,20,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,10,17,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(7,p,15,10,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(8,p,11,13,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(9,p,19,11,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(10,p,13,16,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(11,p,17,13,"��","��",false,"��",2,"����",0,0);
					end
					JY.Status=GAME_WMAP;
					NextEvent(2161);
				end,
			[2161]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2162);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2163);
					end
				end,
			[2162]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(54)) and WarCheckArea(-1,12,11,20,20) then	--���˽������
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"����",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2163]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"����",0,0);
						end
					end
				end,
				
			[2170]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(17,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�
					SelectTeam(	7,3,"��",false,
								5,3,"��",false,
								9,3,"��",false,
								6,4,"��",false,
								8,4,"��",false,
								4,4,"��",false,
								10,4,"��",false,
								6,2,"��",false,
								8,2,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					-- 1 normal; 2����; 3 ˮս; 4 ����; 5 ���
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,12,22,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,5,17,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(3,p,18,11,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(4,p,12,23,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(5,p,15,12,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(6,p,21,13,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(7,p,3,19,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(8,p,5,21,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(9,p,12,18,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(10,p,10,21,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(11,p,14,21,"��","��",false,"��",2,"����",0,0);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,12,22,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,5,17,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(3,p,18,11,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(4,p,12,23,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(5,p,15,12,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(6,p,21,13,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(7,p,3,19,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(8,p,5,21,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(9,p,12,18,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(10,p,10,21,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(11,p,14,21,"��","��",false,"��",2,"����",0,0);
					end
					JY.Status=GAME_WMAP;
					NextEvent(2171);
				end,
			[2171]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2172);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2173);
					end
				end,
			[2172]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(54)) and WarCheckArea(-1,6,17,18,24) then	--���˽������
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"����",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2173]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"����",0,0);
						end
					end
				end,
				
			[2200]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(20,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�
					SelectTeam(	13,2,"��",false,
								12,1,"��",false,
								14,1,"��",false,
								12,3,"��",false,
								14,3,"��",false,
								11,2,"��",false,
								15,2,"��",false,
								10,1,"��",false,
								16,1,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					-- 1 normal; 2����; 3 ˮս; 4 ����; 5 ���
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,2,25,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,3,26,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(3,p,3,23,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(4,p,5,25,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(5,p,14,14,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,9,16,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(7,p,10,12,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(8,p,18,14,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(9,p,5,20,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(10,p,2,16,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(11,p,12,22,"��","��",false,"��",2,"����",0,0);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,2,25,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,3,26,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(3,p,3,23,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(4,p,5,25,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(5,p,14,14,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,9,16,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(7,p,10,12,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(8,p,18,14,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(9,p,5,20,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(10,p,2,16,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(11,p,12,22,"��","��",false,"��",2,"����",0,0);
					end
					JY.Status=GAME_WMAP;
					NextEvent(2201);
				end,
			[2201]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2202);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2203);
					end
				end,
			[2202]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(54)) and WarCheckArea(-1,1,16,13,28) then	--���˽������
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"����",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2203]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"����",0,0);
						end
					end
				end,
				
			[2220]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(22,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�
					SelectTeam(	31,10,"��",false,
								30,9,"��",false,
								32,9,"��",false,
								31,8,"��",false,
								30,7,"��",false,
								32,7,"��",false,
								31,6,"��",false,
								30,5,"��",false,
								32,5,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					-- 1 normal; 2����; 3 ˮս; 4 ����; 5 ���
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,1,3,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,4,10,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(3,p,8,7,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(4,p,5,7,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(5,p,7,9,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(6,p,2,5,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(7,p,3,3,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(8,p,12,10,"��","��",true,"��",4,"����",0,0);
						InsertWarTeam(9,p,13,11,"��","��",true,"��",4,"����",0,0);
						InsertWarTeam(10,p,11,13,"��","��",true,"��",4,"����",0,0);
						InsertWarTeam(11,p,13,14,"��","��",true,"��",4,"����",0,0);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,1,3,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,4,10,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(3,p,8,7,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(4,p,5,7,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(5,p,7,9,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(6,p,2,5,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(7,p,3,3,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(8,p,21,2,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(9,p,22,5,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(10,p,19,4,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(11,p,24,4,"��","��",false,"��",5,"����",0,0);
					end
					JY.Status=GAME_WMAP;
					NextEvent(2221);
				end,
			[2221]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2222);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2223);
					end
				end,
			[2222]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(51)) and (WarCheckArea(-1,1,4,11,9) or WarCheckArea(-1,1,1,8,13)) then	--���˽ӽ����ţ���������
							WarSetFlag(51,1);
							WarSetFlag(52,1);
						end
						if (not WarCheckFlag(54)) and WarCheckArea(-1,1,1,8,10) then	--���˽������
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"����",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if WarCheckFlag(52) then
							WarSetFlag(52,0);
							if WarGetFlag(11)>=8 then
								WarShowTeamArmy(8);
								WarShowTeamArmy(9);
								WarShowTeamArmy(10);
								WarShowTeamArmy(11);
								WarTalk(WarGetFlag(110+8),29);
								for i=9,11 do
									local pid=WarGetFlag(110+i);
									if pid>0 and JY.Person[pid]["̨��"]>=0 then
										WarTalk(pid,29);
									end
								end
							end
						end
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2223]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"����",0,0);
						end
					end
				end,
				
			[2230]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(23,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�
					--InsertWarPerson(0,0,1,13,"��",0,"��",false,"����",0,0);
					SelectTeam(	2,18,"��",false,
								3,19,"��",false,
								2,16,"��",false,
								3,17,"��",false,
								4,18,"��",false,
								5,19,"��",false,
								4,16,"��",false,
								5,17,"��",false,
								6,18,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					-- 1 normal; 2����; 3 ˮս; 4 ����; 5 ���
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,19,2,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,18,4,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(3,p,17,3,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(4,p,15,10,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,11,6,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,17,9,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(7,p,12,5,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(8,p,13,9,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(9,p,13,6,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(10,p,15,8,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(11,p,15,5,"��","��",false,"��",1,"����",0,0);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,19,2,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,18,4,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(3,p,17,3,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(4,p,15,10,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,11,6,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,17,9,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(7,p,12,5,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(8,p,13,9,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(9,p,13,6,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(10,p,15,8,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(11,p,15,5,"��","��",false,"��",1,"����",0,0);
					end
					JY.Status=GAME_WMAP;
					NextEvent(2231);
				end,
			[2231]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2232);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2233);
					end
				end,
			[2232]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(54)) and WarCheckArea(-1,11,1,20,10) then	--���˽������
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"����",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2233]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"����",0,0);
						end
					end
				end,
				
			[2240]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(24,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�
					SelectTeam(	18,21,"��",false,
								19,20,"��",false,
								19,22,"��",false,
								20,21,"��",false,
								20,23,"��",false,
								21,22,"��",false,
								22,21,"��",false,
								22,23,"��",false,
								23,22,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					-- 1 normal; 2����; 3 ˮս; 4 ����; 5 ���
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,23,2,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,11,9,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(3,p,23,4,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(4,p,17,3,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(5,p,16,10,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(6,p,6,8,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(7,p,10,7,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(8,p,13,14,"��","��",true,"��",4,"����",0,0);
						InsertWarTeam(9,p,3,15,"��","��",true,"��",5,"����",0,0);
						InsertWarTeam(10,p,10,21,"��","��",true,"��",5,"����",0,0);
						InsertWarTeam(11,p,14,22,"��","��",true,"��",4,"����",0,0);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,23,2,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,11,9,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(3,p,23,4,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(4,p,17,3,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(5,p,16,10,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(6,p,6,8,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(7,p,10,7,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(8,p,13,11,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(9,p,4,15,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(10,p,6,18,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(11,p,8,17,"��","��",false,"��",4,"����",0,0);
					end
					JY.Status=GAME_WMAP;
					NextEvent(2241);
				end,
			[2241]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2242);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2243);
					end
				end,
			[2242]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(51)) and WarCheckArea(-1,4,6,16,13) then	--���˽ӽ����ţ���������
							WarSetFlag(51,1);
							WarSetFlag(52,1);
						end
						if (not WarCheckFlag(54)) and WarCheckArea(-1,17,1,24,8) then	--���˽������
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"����",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if WarCheckFlag(52) then
							WarSetFlag(52,0);
							if WarGetFlag(11)>=8 then
								WarShowTeamArmy(8);
								WarShowTeamArmy(9);
								WarShowTeamArmy(10);
								WarShowTeamArmy(11);
								WarTalk(WarGetFlag(110+8),29);
								for i=9,11 do
									local pid=WarGetFlag(110+i);
									if pid>0 and JY.Person[pid]["̨��"]>=0 then
										WarTalk(pid,29);
									end
								end
							end
						end
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2243]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"����",0,0);
						end
					end
				end,
				
			[2250]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(25,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�;
					SelectTeam(	8,1,"��",false,
								9,2,"��",false,
								10,1,"��",false,
								11,2,"��",false,
								12,1,"��",false,
								13,2,"��",false,
								14,1,"��",false,
								15,2,"��",false,
								16,1,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					-- 1 normal; 2����; 3 ˮս; 4 ����; 5 ���
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,14,29,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,16,24,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(3,p,7,30,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(4,p,9,25,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,13,20,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(6,p,2,18,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(7,p,14,15,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(8,p,5,13,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(9,p,15,10,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(10,p,6,8,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(11,p,12,9,"��","��",false,"��",1,"����",0,0);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,14,29,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,16,24,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(3,p,7,30,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(4,p,9,25,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,13,20,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(6,p,2,18,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(7,p,14,15,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(8,p,5,13,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(9,p,15,10,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(10,p,6,8,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(11,p,12,9,"��","��",false,"��",1,"����",0,0);
					end
					JY.Status=GAME_WMAP;
					NextEvent(2251);
				end,
			[2251]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2252);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2253);
					end
				end,
			[2252]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(54)) and WarCheckArea(-1,1,24,20,32) then	--���˽������
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"����",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2253]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"����",0,0);
						end
					end
				end,
				
			[2300]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(30,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�
					SelectTeam(	16,19,"��",false,
								15,18,"��",false,
								17,18,"��",false,
								15,20,"��",false,
								17,20,"��",false,
								14,19,"��",false,
								18,19,"��",false,
								13,20,"��",false,
								19,20,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					-- 1 normal; 2����; 3 ˮս; 4 ����; 5 ���
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,15,6,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,16,5,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(3,p,13,6,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(4,p,15,12,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,9,6,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,13,11,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(7,p,10,8,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(8,p,17,11,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(9,p,10,4,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(10,p,15,8,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(11,p,11,6,"��","��",false,"��",1,"����",0,0);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,15,6,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,16,5,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(3,p,13,6,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(4,p,15,12,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,9,6,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,13,11,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(7,p,10,8,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(8,p,17,11,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(9,p,10,4,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(10,p,15,8,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(11,p,11,6,"��","��",false,"��",1,"����",0,0);
					end
					JY.Status=GAME_WMAP;
					NextEvent(2301);
				end,
			[2301]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2302);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2303);
					end
				end,
			[2302]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(54)) and WarCheckArea(-1,10,1,20,11) then	--���˽������
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"����",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2303]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"����",0,0);
						end
					end
				end,
				
			[2310]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(31,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�
					SelectTeam(	9,2,"��",false,
								10,2,"��",false,
								8,1,"��",false,
								11,1,"��",false,
								8,3,"��",false,
								11,3,"��",false,
								7,2,"��",false,
								12,2,"��",false,
								9,4,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					-- 1 normal; 2����; 3 ˮս; 4 ����; 5 ���
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,8,23,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,9,24,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(3,p,8,26,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(4,p,8,21,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,10,22,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,6,24,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(7,p,11,24,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(8,p,2,18,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(9,p,15,18,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(10,p,3,22,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(11,p,14,22,"��","��",false,"��",2,"����",0,0);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,8,23,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,9,24,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(3,p,8,26,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(4,p,8,21,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,10,22,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,6,24,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(7,p,11,24,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(8,p,2,18,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(9,p,15,18,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(10,p,3,22,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(11,p,14,22,"��","��",false,"��",2,"����",0,0);
					end
					JY.Status=GAME_WMAP;
					NextEvent(2311);
				end,
			[2311]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2312);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2313);
					end
				end,
			[2312]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(54)) and WarCheckArea(-1,6,21,11,26) then	--���˽������
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"����",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2313]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"����",0,0);
						end
					end
				end,
				
			[2320]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(32,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�
					SelectTeam(	2,5,"��",false,
								3,6,"��",false,
								3,4,"��",false,
								1,4,"��",false,
								1,6,"��",false,
								4,5,"��",false,
								4,7,"��",false,
								3,8,"��",false,
								4,9,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					-- 1 normal; 2����; 3 ˮս; 4 ����; 5 ���
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,27,19,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,24,19,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(3,p,26,16,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(4,p,9,10,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,16,12,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,10,10,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(7,p,13,14,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(8,p,19,9,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(9,p,17,13,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(10,p,21,17,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(11,p,25,12,"��","��",false,"��",5,"����",0,0);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,27,19,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,24,19,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(3,p,26,16,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(4,p,9,10,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,16,12,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,10,10,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(7,p,13,14,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(8,p,19,9,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(9,p,17,13,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(10,p,21,17,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(11,p,25,12,"��","��",false,"��",5,"����",0,0);
					end
					JY.Status=GAME_WMAP;
					NextEvent(2321);
				end,
			[2321]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2322);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2323);
					end
				end,
			[2322]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(54)) and WarCheckArea(-1,20,14,28,20) then	--���˽������
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"����",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2323]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"����",0,0);
						end
					end
				end,
				
			[2330]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid)*99;
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(33,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�
					SelectTeam(	3,31,"��",false,
								2,30,"��",false,
								5,31,"��",false,
								4,30,"��",false,
								3,29,"��",false,
								2,28,"��",false,
								6,30,"��",false,
								5,29,"��",false,
								7,31,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					enpcnum=1
					-- 1 normal; 2����; 3 ˮս; 4 ����; 5 ���
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,16,1,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,13,1,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(3,p,15,3,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(4,p,15,4,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,16,11,"��","��",false,"��",3,"����",0,0);
						InsertWarTeam(6,p,11,9,"��","��",false,"��",3,"����",0,0);
						InsertWarTeam(7,p,17,13,"��","��",false,"��",3,"����",0,0);
						InsertWarTeam(8,p,12,21,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(9,p,11,20,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(10,p,10,25,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(11,p,11,23,"��","��",false,"��",2,"����",0,0);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,16,1,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,13,1,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(3,p,15,3,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(4,p,15,4,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,16,11,"��","��",false,"��",3,"����",0,0);
						InsertWarTeam(6,p,11,9,"��","��",false,"��",3,"����",0,0);
						InsertWarTeam(7,p,17,13,"��","��",false,"��",3,"����",0,0);
						InsertWarTeam(8,p,12,21,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(9,p,11,20,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(10,p,10,25,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(11,p,11,23,"��","��",false,"��",2,"����",0,0);
					end
					JY.Status=GAME_WMAP;
					NextEvent(2331);
				end,
			[2331]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2332);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2333);
					end
				end,
			[2332]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(54)) and WarCheckArea(-1,1,1,20,10) then	--���˽������
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"����",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*22 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2333]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"����",0,0);
						end
					end
				end,
			
			[2380]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(38,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�
					SelectTeam(	2,11,"��",false,
								1,10,"��",false,
								1,12,"��",false,
								2,9,"��",false,
								2,13,"��",false,
								1,8,"��",false,
								1,14,"��",false,
								2,7,"��",false,
								2,15,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					-- 1 normal; 2����; 3 ˮս; 4 ����; 5 ���
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,18,14,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,18,17,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(3,p,16,15,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(4,p,8,14,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,8,17,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(6,p,8,11,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(7,p,10,16,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(8,p,10,13,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(9,p,2,21,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(10,p,6,24,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(11,p,15,30,"��","��",false,"��",4,"����",8,14);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,18,14,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,18,17,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(3,p,16,15,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(4,p,8,14,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,8,17,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(6,p,8,11,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(7,p,10,16,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(8,p,10,13,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(9,p,2,21,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(10,p,6,24,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(11,p,15,30,"��","��",false,"��",4,"����",0,0);
					end
					JY.Status=GAME_WMAP;
					NextEvent(2381);
				end,
			[2381]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2382);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2383);
					end
				end,
			[2382]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(54)) and WarCheckArea(-1,16,12,20,17) then	--���˽������
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"����",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2383]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"����",0,0);
						end
					end
				end,
				
			[2470]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(47,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�
					SelectTeam(	1,4,"��",false,
								1,6,"��",false,
								1,2,"��",false,
								2,5,"��",false,
								2,7,"��",false,
								3,6,"��",false,
								3,8,"��",false,
								4,7,"��",false,
								4,9,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					-- 1 normal; 2����; 3 ˮս; 4 ����; 5 ���
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,17,17,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,17,19,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(3,p,14,17,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(4,p,17,14,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(5,p,12,10,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,9,14,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(7,p,14,5,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(8,p,3,14,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(9,p,4,19,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(10,p,18,9,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(11,p,9,20,"��","��",false,"��",5,"����",0,0);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,17,17,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,17,19,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(3,p,14,17,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(4,p,17,14,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(5,p,12,10,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,9,14,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(7,p,14,5,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(8,p,3,14,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(9,p,4,19,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(10,p,18,9,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(11,p,9,20,"��","��",false,"��",5,"����",0,0);
					end
					JY.Status=GAME_WMAP;
					NextEvent(2471);
				end,
			[2471]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2472);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2473);
					end
				end,
			[2472]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(54)) and WarCheckArea(-1,10,10,24,24) then	--���˽������
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"����",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2473]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"����",0,0);
						end
					end
				end,
				
			[2410]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(41,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�
					SelectTeam(	20,2,"��",false,
								18,2,"��",false,
								22,2,"��",false,
								19,3,"��",false,
								21,3,"��",false,
								23,3,"��",false,
								17,3,"��",false,
								18,4,"��",false,
								22,4,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					-- 1 normal; 2����; 3 ˮս; 4 ����; 5 ���
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,21,26,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,20,26,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(3,p,21,23,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(4,p,15,10,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,26,10,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,12,26,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(7,p,29,26,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(8,p,16,11,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(9,p,25,11,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(10,p,13,25,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(11,p,28,25,"��","��",false,"��",2,"����",0,0);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,21,26,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,20,26,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(3,p,21,23,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(4,p,15,10,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,26,10,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,12,26,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(7,p,29,26,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(8,p,16,11,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(9,p,25,11,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(10,p,13,25,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(11,p,28,25,"��","��",false,"��",2,"����",0,0);
					end
						---
						InsertWarPerson(6,GenPerson(true,0,"������"),7,21,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						InsertWarPerson(6,GenPerson(true,0,"������"),8,21,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						InsertWarPerson(6,GenPerson(true,0,"������"),9,21,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						
						InsertWarPerson(7,GenPerson(true,0,"������"),33,21,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						InsertWarPerson(7,GenPerson(true,0,"������"),34,21,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						InsertWarPerson(7,GenPerson(true,0,"������"),32,21,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						
						InsertWarPerson(3,GenPerson(true,0,"������"),20,19,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						InsertWarPerson(3,GenPerson(true,0,"������"),21,19,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						InsertWarPerson(3,GenPerson(true,0,"������"),15,17,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						InsertWarPerson(3,GenPerson(true,0,"������"),26,17,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						
						InsertWarPerson(4,GenPerson(true,0,"������"),7,12,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						InsertWarPerson(4,GenPerson(true,0,"������"),9,14,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						InsertWarPerson(5,GenPerson(true,0,"������"),34,12,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						InsertWarPerson(5,GenPerson(true,0,"������"),32,14,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
					JY.Status=GAME_WMAP;
					NextEvent(2411);
				end,
			[2411]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2412);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2413);
					end
				end,
			[2412]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(51)) and WarCheckArea(-1,5,11,36,16) then	--���˽������
							WarSetFlag(51,1);
							WarModifyTeamAI(4,"����",0,0);
							WarModifyTeamAI(5,"����",0,0);
							WarModifyTeamAI(8,"����",0,0);
							WarModifyTeamAI(9,"����",0,0);
						end
						if (not WarCheckFlag(52)) and WarCheckArea(-1,12,17,29,22) then	--���˽������
							WarSetFlag(52,1);
							WarModifyTeamAI(6,"����",0,0);
							WarModifyTeamAI(7,"����",0,0);
							WarModifyTeamAI(10,"����",0,0);
							WarModifyTeamAI(11,"����",0,0);
						end
						if (not WarCheckFlag(53)) and WarCheckArea(-1,18,23,23,28) then	--���˽������
							WarSetFlag(53,1);
							WarModifyTeamAI(1,"����",0,0);
							WarModifyTeamAI(2,"����",0,0);
							WarModifyTeamAI(3,"����",0,0);
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2413]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"����",0,0);
						end
					end
				end,
				
			[2420]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid)*99;
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(42,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�
					SelectTeam(	13,23,"��",false,
								12,24,"��",false,
								14,24,"��",false,
								11,23,"��",false,
								15,23,"��",false,
								10,24,"��",false,
								16,24,"��",false,
								9,23,"��",false,
								17,23,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					enpcnum=0;
					-- 1 normal; 2����; 3 ˮս; 4 ����; 5 ���
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,14,5,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,14,4,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(3,p,14,15,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(4,p,8,5,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,14,7,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,7,14,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(7,p,5,10,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(8,p,15,14,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(9,p,9,4,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(10,p,20,7,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(11,p,5,8,"��","��",false,"��",2,"����",0,0);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,14,5,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,14,4,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(3,p,14,15,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(4,p,8,5,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(5,p,14,7,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,7,14,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(7,p,5,10,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(8,p,15,14,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(9,p,9,4,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(10,p,20,7,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(11,p,5,8,"��","��",false,"��",2,"����",0,0);
					end
						---
						InsertWarPerson(3,GenPerson(true,0,"������"),16,5,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						InsertWarPerson(3,GenPerson(true,0,"������"),16,4,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						
						InsertWarPerson(3,GenPerson(true,0,"������"),14,13,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						InsertWarPerson(3,GenPerson(true,0,"������"),15,13,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						
						InsertWarPerson(3,GenPerson(true,0,"������"),7,14,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						InsertWarPerson(3,GenPerson(true,0,"������"),6,14,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						
						InsertWarPerson(3,GenPerson(true,0,"������"),5,10,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						InsertWarPerson(3,GenPerson(true,0,"������"),5,9,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						
						InsertWarPerson(2,GenPerson(true,0,"������"),12,11,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						InsertWarPerson(2,GenPerson(true,0,"������"),17,11,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						InsertWarPerson(2,GenPerson(true,0,"������"),8,11,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						InsertWarPerson(2,GenPerson(true,0,"������"),12,7,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
						InsertWarPerson(2,GenPerson(true,0,"������"),17,7,"��",1+math.random(0,1)-math.random(0,1),"��",false,"����",0,0);
					JY.Status=GAME_WMAP;
					NextEvent(2421);
				end,
			[2421]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2422);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2423);
					end
				end,
			[2422]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(54)) and WarCheckArea(-1,11,1,18,8) then	--���˽������
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"����",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*22 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2423]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"����",0,0);
						end
					end
				end,
				
			[2480]=function()
					local wid;
					local p={};
					--�о���������
					local cid=JY.Base["����ǳ�"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["����"];
					if fid==0 then
						fid=52;	--������
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["����"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["Ʒ��"];
					end
					
					--ս������
					WarIni();
					DefineWarMap(48,JY.City[cid]["����"].."����ս","һ��ȫ��о���",20,"����",p[1]);
					--�Ҿ�
					SelectTeam(	1,4,"��",false,
								1,2,"��",false,
								2,3,"��",false,
								2,5,"��",false,
								3,2,"��",false,
								3,4,"��",false,
								3,6,"��",false,
								4,3,"��",false,
								4,5,"��",false)
					WarSetFlag(101,War.Person[1].id);	--�ҷ���˧ID
					local mnum=War.PersonNum;
					--�о�
					-- 1 normal; 2����; 3 ˮս; 4 ����; 5 ���
					if mnum*1.5>enpcnum then	--���سǳ�
						WarSetFlag(1,1);--�ҷ��������з�����
						InsertWarTeam(1,p,17,3,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,14,5,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(3,p,16,12,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(4,p,14,11,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(5,p,17,6,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,16,16,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(7,p,13,17,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(8,p,9,15,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(9,p,5,16,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(10,p,6,14,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(11,p,19,15,"��","��",false,"��",2,"����",0,0);
					else
						WarSetFlag(1,2);--�ҷ��������з�����
						InsertWarTeam(1,p,17,3,"��","��",false,"˧",1,"����",0,0);
						InsertWarTeam(2,p,14,5,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(3,p,16,12,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(4,p,14,11,"��","��",false,"��",2,"����",0,0);
						InsertWarTeam(5,p,17,6,"��","��",false,"��",1,"����",0,0);
						InsertWarTeam(6,p,16,16,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(7,p,13,17,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(8,p,9,15,"��","��",false,"��",5,"����",0,0);
						InsertWarTeam(9,p,5,16,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(10,p,6,14,"��","��",false,"��",4,"����",0,0);
						InsertWarTeam(11,p,19,15,"��","��",false,"��",2,"����",0,0);
					end
					JY.Status=GAME_WMAP;
					NextEvent(2481);
				end,
			[2481]=function()
					local kid=WarGetFlag(1);
					if kid==1 then
						PlayBGM(11);
						WarTalk(WarGetFlag(101),30);
						WarTalk(WarGetFlag(111),21);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,21);
							end
						end
						NextEvent(2482);
					elseif kid==2 then
						PlayBGM(12);
						WarTalk(WarGetFlag(101),31);
						WarTalk(WarGetFlag(111),20);
						for i=2,WarGetFlag(11) do
							local pid=WarGetFlag(110+i);
							if JY.Person[pid]["̨��"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2483);
					end
				end,
			[2482]=function()	--��������
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						if (not WarCheckFlag(54)) and WarCheckArea(-1,11,1,20,13) then	--���˽������
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"����",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
					end
				end,
			[2483]=function()	--���˳���
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"�ɡ��ɶ񡭡�����С�����ۣ���");
					end
					if JY.EventType==War_Event_Action then	--�ж���
						
					end
					if JY.EventType==War_Event_TurnM then	--�Ҿ��غϿ�ʼ
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--�Ѿ��غϿ�ʼ
						
					end
					if JY.EventType==War_Event_TurnE then	--�о��غϿ�ʼ
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"����",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"����",0,0);
						end
					end
				end,
				
				
				
				
				
			[9999]=function()
					JY.Status=GAME_START;
				end,
		};
		
		