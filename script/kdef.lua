--[[
SceneID
-1	黑屏
0	大地图
43	许昌曹操官邸
45	徐州陶謙官邸
48	北平议事厅
54	平原议事厅/北海/小沛/下邳/白马/古城
63	曹操军营帐
66	许昌 曹操花园
77	许昌劉備官邸
83	邺城议事厅
84	许昌宫殿
85	洛阳宫殿/许昌议事厅
86	陈留议事厅/徐州
87	信度议事厅
89	洛阳宫殿（献帝）
85	洛阳宫殿（董卓）乱用
92	淮南议事厅
97	广川营帐/劉備
95	陈留营帐/虎牢/袁紹
]]--

Event=	{
			[0001]=function()
				end,
			[0101]=function()
					SetSceneID(59);
					LoadPic(103,"淡入");
					DrawMulitStrBox("时为东汉王朝第１２代皇帝·[Green]灵帝[Normal]在位期间，[n]自[Red]光武中兴[Normal]以来延续了１６０年的汉王朝[n]已成为恶臣、宦官的巢穴。");
					DrawMulitStrBox("灵帝特别重用宦官张让等十人，[n]人称「[Red]十常侍[Normal]」，掌握实权。");
					LoadPic(103,"淡出");
					LoadPic(3,"淡入");
					DrawMulitStrBox("政局动乱，各地瘟疫肆虐，天灾不断，盗贼猖獗。[n]疲于乱世的百姓们渴望着英雄的出现。");
					LoadPic(3,"淡出");
					LoadPic(104,"淡入");
					DrawMulitStrBox("光和７年（１８４年），[n]号称大贤良师的[Green]张角[Normal]发动农民在河北一带起义，[n]史称「[Red]黄巾之乱[Normal]」。");
					DrawMulitStrBox("其口号为「[Red]苍天已死，黄天当立；[n]          岁在甲子，天下大吉。[Normal]」。");
					DrawMulitStrBox("在朝廷已无秩序的状况下，[n]黄巾军在各地扩大势力，[n]华北一带已被黄色旗帜盖满。");
					LoadPic(104,"淡出");
					if JY.FID==33 then
						SetSceneID(55);
						Talk("张宝","地公将军[Green]张宝[Normal]，[n]人公将军[Green]张梁[Normal]刚刚归来。");
						Talk("张梁","颖川的官军全部打跑了，[n]豫州一带是我们的。");
						Talk("张梁","眼前好像浮现大将军[Green]何进[Normal][n]到都城同伙苍白的脸蛋。");
						Talk("张角","嗯，两个人都做得好。[n]以这样的气势必可一鼓作气击溃官军！");
						Talk("张角","[Red]汉[Normal]朝气数已尽。[n]对于走向灭亡的朝代给予引导是我们的使命。");
						Talk("张梁","是，遵命！");
						Talk("张宝","明白了。[n]都要按照大贤良师的心愿去做。");
					elseif JY.FID==34 then
						SetSceneID(54);
						Talk("何进","什么！？在豫州也被贼军打败了！？");
						Talk("曹操","我属下带来的消息，[n]是确实的情报。");
						Talk("袁紹","大将军，事态严重啊！[n]应该马上编组讨伐军。");
						Talk("何进","知道了。那么召集各将军。");
						SetSceneID(54);
						Talk("何进","[Green]皇甫嵩将军、[Green]朱儁[Normal]将军、[n][Green]卢植[Normal]将军，还有[Green]董卓[Normal]将军！");
						Talk("皇甫嵩","是！");
						Talk("何进","你们是抵抗贼军入侵的主力部队。[n]如何，这样的宣布很清楚吧！");
						Talk("卢植","是！[n]必尽绵薄之力，不负所望。");
						Talk("朱儁","一定会镇压贼军给您看。");
						Talk("董卓","大将军阁下，[n]请等待好消息吧！");
						Talk("何进","嗯，还有[Green]袁紹[Normal]和[Green]曹操[Normal]！");
						Talk("何进","严令各地太守，[n]再也不能允许贼就侵入！");
						Talk("袁紹","遵命，立刻去办！");
					else
						SetSceneID(51);
						Talk("傳令2","大事不好了！黄巾贼的[Green]张角[Normal]，起兵造反了！[n]请您立刻火速赶往政厅集合。");
						Talk(JY.PID,"你说叛乱！？竟做出这么过分的事……");
						SetSceneID(54);
						Talk("官員","黄巾贼的横行令圣上烦忧，[n]特命[Green]何进[Normal]大人为[Red]大将军[Normal]，前往讨伐其党羽。[n]命各诸侯谨遵从[Green]何进[Normal]将军的指示，前往讨伐贼军。");
						Talk(JY.PID,"下官领旨。下官必以全部心力处理此事。");
						SetSceneID(54);
						Talk(JY.PID,"顺从旨意，我们立刻出发征讨黄巾贼！[n]对朝廷刀锋相向的人绝不能饶恕！");
						SetSceneID(67);
						Talk(JY.PID,"（……听说黄巾的信众遍及全国各地，[n]这次的动乱似乎会持续很久……）");
						LoadPic(8,"淡入");
						DrawMulitStrBox("跟"..JY.Person[JY.PID]["名称"].."所预想的一样，战火渐渐覆盖中国全土。[n]时代以这场大乱为契机开始有了巨大变动。[n]新时代的英雄们，一个接一个的开始为世人所知。");
						LoadPic(8,"淡出");
					end
				end,
			[0102]=function()
					SetSceneID(59);
					LoadPic(103,"淡入");
					DrawMulitStrBox("时为东汉王朝第１３代皇帝·[Green]少帝[Normal]至[n]第１４代皇帝·[Green]献帝[Normal]在位期间。");
					DrawMulitStrBox("自[Red]光武中兴[Normal]以来延续了１６０年的汉王朝已[n]名存实亡，皇帝失去了强有力的诸侯作为后盾，[n]连都城都难以维持。");
					DrawMulitStrBox("王朝崩溃，导致各地诸侯割据，[n]进入了自相残杀的战国乱世年代。");
					LoadPic(103,"淡出");
					LoadPic(79,"淡入");
					DrawMulitStrBox("中平６（１８９）年４月，[Green]灵帝[Normal]驾崩，[n]皇子[Green]辨[Normal]即位[Green]少帝[Normal]。");
					LoadPic(79,"淡出");
					DrawMulitStrBox("皇子[Green]辨[Normal]是大将军[Green]何进[Normal]的妹妹何太后之子，[n][Green]何进[Normal]的权势将不可同日而语，[n]这是可想而知的了。");
					DrawMulitStrBox("但到了８月，[n][Green]何进[Normal]却被政敌宦官「[Red]十常侍[Normal]」暗杀，[n]死于非命。");
					DrawMulitStrBox("「[Red]十常侍[Normal]」还准备铲除何进手下的[Green]袁紹[Normal]、[n][Green]袁术[Normal]、[Green]曹操[Normal]等人，[n]就在此混乱之际，京城来了一些不速之客。");
					LoadPic(93,"淡入");
					DrawMulitStrBox("镇压陇西叛乱之后，手中握有强大兵权的[Green]董卓[Normal]，[n]率领大军占领了都城[Red]洛阳[Normal]。");
					LoadPic(93,"淡出");
					LoadPic(106,"淡入");
					DrawMulitStrBox("他宣布废少帝，立陈留王[Green]刘协[Normal]为皇帝[n]打倒对立派的[Green]丁原[Normal]，强行废位。");
					DrawMulitStrBox("然而，对于[Green]董卓[Normal]的暴行，[n]各地反[Green]董卓[Normal]气势日益高涨。");
					DrawMulitStrBox("同年１２月，[Green]曹操[Normal]回到故乡陈留，[n]发表号令各地诸侯打倒[Green]董卓[Normal]的檄文。");
					LoadPic(106,"淡出");
					LoadPic(87,"淡入");
					DrawMulitStrBox("与其相应的油何进的亲信渤海[Green]袁紹[Normal]、其弟[Green]袁术[Normal]、[n]平定了长沙叛乱，人称江东之虎的勇将[Green]孫堅[Normal]、");
					DrawMulitStrBox("平定了幽州叛乱的白马将军[Green]公孙瓒[Normal]、[n]以及西凉的[Green]马腾[Normal]。");
					DrawMulitStrBox("而且，[Green]劉備[Normal]等对[Green]董卓[Normal]暴政心怀不满的各地诸侯，[n]也结成了「[Red]反董卓联盟[Normal]」共同起兵。");
					LoadPic(87,"淡出");
					LoadPic(106,"淡入");
					DrawMulitStrBox("对此，[Green]董卓[Normal]也在洛阳周边集结军队，[n]构成彻底抗战之势。");
					DrawMulitStrBox("初平１（１９０）年１月，[n][Green]董卓[Normal]的军队与「[Red]反董卓联盟[Normal]」开始交战。");
					LoadPic(106,"淡出");
					if JY.FID==1 or JY.FID==2 or JY.FID==3 or JY.FID==4 or JY.FID==5 or JY.FID==10 or JY.FID==11 or JY.FID==13 or JY.FID==18 or JY.FID==19 or JY.FID==20 or JY.FID==21 or JY.FID==22 or JY.FID==23 or JY.FID==24 then
						SetSceneID(55);
						Talk("曹操","相应檄文的诸侯们，[n]一路奔波，想必非常劳累吧！。");
						Talk("曹操","为正义之事，我们聚到一起，[n]以后大家都是盟友。");
						Talk("曹操","何不迅速兵分三路，进攻都城，讨伐[Green]董卓[Normal]？");
						Talk("孫堅","[Green]曹操[Normal]大人，请等一等！[n]现在已成立大军，由谁当[Red]盟主[Normal]呢？");
						Talk("孫堅","如果我们分兵各自去攻打，[n]将有被[Green]董卓[Normal]军队各个击破的危险。");
						Talk("曹操","嗯，[Green]孫堅[Normal]大人所言极是。");
						Talk("曹操","既是如此，[n]我们就拥这位[Green]袁紹[Normal]大人为[Red]盟主[Normal]如何？");
						Talk("曹操","袁家四世三公，乃是汉朝的功臣，[n]当[Red]盟主[Normal]最合适不过了。");
						Talk("鲍信","妙哉！[n]除了[Green]袁紹[Normal]大人，别无它选。");
						Talk("曹操","既然大家别无异议，[n]那么，就决定请[Green]袁紹[Normal]大人担任[Red]盟主[Normal]吧！");
						Talk("袁紹","嗯！那就恭敬不如从命了。");
						Talk("袁紹","各位诸侯，[n][Green]董卓[Normal]已对我们的行动有所察觉，[n]想必一定做好了充分准备。");
						Talk("袁紹","想要攻克[Red]洛阳[Normal]，[n]必须先杀入难以攻陷的「[Red]虎牢关[Normal]」。");
						Talk("袁紹","然而，[Green]董卓[Normal]军中有斩杀[Green]丁原[Normal][n]并归附于他的[Red]天下无双[Normal]的豪杰[Green]呂布[Normal]。");
						Talk("袁紹","但是，各路诸侯如果团结起来，[n]再强的劲敌也不足为惧。");
						Talk("袁紹","请诸位一同铲除[Green]董卓[Normal]的暴政，[n]昭示天下归于正统吧！");
					elseif JY.FID==6 then
						SetSceneID(54);
						Talk("董卓","什么！？[n]各地诸侯已集结，直奔都城而来！？");
						Talk("李儒","各地诸侯相应[Green]曹操[Normal]的檄文，[n]拥[Green]袁紹[Normal]为盟主，已结成了联盟。");
						Talk("李儒","一两个诸侯还好对付，[n]但是若联合起来，恐怕不易对付。");
						Talk("董卓","嗯……[n]此事甚大，该如何是好？");
						Talk("呂布","义父大人何必忧心？[n]您莫非忘了有我[Green]呂布[Normal]在此？");
						Talk("呂布","那些胆小如鼠的匹夫，[n]要呼朋结党才敢来犯，又有何能耐？");
						Talk("呂布","只要有我[Green]呂布[Normal]在，[n]就绝不会让敌人踏入都城半步！");
						Talk("董卓","哦，没错！[n]只要有你在，我就无所惧怕了。");
						Talk("董卓","就是为了此时，[n]我才不惜让出[Red]赤兔马[Normal]，将你纳为属下的。");
						Talk("董卓","你马上备齐人马，[n]用你那[Red]天下无双[Normal]的武力，杀尽那些叛徒吧！");
						Talk("华雄","[Green]董卓[Normal]大人，杀鸡焉用牛刀！[n][Green]袁紹[Normal]、[Green]曹操[Normal]之辈根本就不用劳驾[Green]呂布[Normal]大人，[n]末将便可胜任。");
						Talk("华雄","洛阳有一要塞「[Red]虎牢关[Normal]」，[n]就让末将打先锋吧！");
						Talk("董卓","哦？是[Green]华雄[Normal]啊！[n]好，我就派你作先锋。");
						Talk("董卓","你速速集合全军，在「[Red]虎牢关[Normal]」迎击敌人，[n]定要杀得他们片甲不留！");
					else
						
					end
				end,
			[0103]=function()
					SetSceneID(59);
					LoadPic(103,"淡入");
					DrawMulitStrBox("时为东汉王朝第１４代皇帝·[Green]献帝[Normal]在位期间。");
					DrawMulitStrBox("自[Red]光武中兴[Normal]以来延续了１６０年的汉王朝已[n]名存实亡，皇帝失去了强有力的诸侯作为后盾，[n]连都城都难以维持。");
					DrawMulitStrBox("王朝崩溃，导致各地诸侯割据，[n]历史舞台走进了自相残杀的战国乱世年代。");
					LoadPic(103,"淡出");
					LoadPic(110,"淡入");
					DrawMulitStrBox("初平３（１９２）年４月，[n]长安的[Green]董卓[Normal]权势达到极点，[n]却被义子[Green]呂布[Normal]和司徒[Green]王允[Normal]所杀。");
					LoadPic(79,"淡出");
					LoadPic(75,"淡入");
					DrawMulitStrBox("[Green]呂布[Normal]虽暂时占据了都城长安，[n]但与[Green]李傕[Normal]等董卓军余党作战失败，[n]随后逃离长安。");
					LoadPic(75,"淡出");
					LoadPic(85,"淡入");
					DrawMulitStrBox("进入都城的[Green]李傕[Normal]诛杀[Green]王允[Normal]、幽禁皇帝，[n]推行与董卓一样的暴政。[n]都城荒废，朝廷的威信丧失殆尽。");
					LoadPic(85,"淡出");
					SetSceneID(66);
					DrawMulitStrBox("另一方面，从都城赶出来的[Green]呂布[Normal]，[n]为了东山再起寻找据点，辗转各地。");
					DrawMulitStrBox("此时[Green]呂布[Normal]看中的，[n]是[Green]曹操[Normal]攻打徐州而成为空城的兖州。");
					DrawMulitStrBox("[Green]呂布[Normal]在[Green]陳宮[Normal]、[Green]張邈[Normal]等人的支援下，[n]很快的击破了兖州诸城，[n]并且欲突击[Green]曹操军[Normal]的后防。");
					DrawMulitStrBox("[Green]曹操[Normal]不得不放弃攻打徐州，[n]调整军势改为迎战[Green]呂布[Normal]，急速拔营撤退。");
					DrawMulitStrBox("猛将[Green]呂布[Normal]和智将[Green]曹操[Normal]二者的大军，[n]在定陶山附近发生激战，[n]展开争夺兖州的长期战役。");
					SetSceneID(63);
					DrawMulitStrBox("此时，在江东战乱的舞台上，出现了一位少年英雄，[n]他就是曾在荆州之战中败于刘表的孫堅之子[Green]孫策[Normal]。");
					DrawMulitStrBox("[Green]孫策[Normal]一直受淮南[Green]袁术[Normal]的庇护，[n]于是将父亲的遗物·[Red]玉玺[Normal]让给[Green]袁术[Normal]，[n]借用兵马，取得独立。");
					DrawMulitStrBox("并以此建立后来「[Red]吴[Normal]」的基础，[n]从此之后，便开始了[Green]孫策[Normal]的称霸江东之战。");
					if JY.FID==1 then
						SetSceneID(54);
						Talk("曹操","真是失策[n]兖州竟会如此的落入他人之手。");
						Talk("夏侯惇","过去之事已无法挽回，[n]现在应当与[Green]呂布[Normal]决战，夺回兖州。");
						Talk("夏侯淵","我军兵多将广，[n]绝不逊于[Green]呂布[Normal]。");
						Talk("曹操","你们说的都正确，[n]但我军背后尚有[Green]劉備[Normal]。");
						Talk("曹操","而且[Green]劉備[Normal]劝我停战，[n]自己却驻兵在徐州。");
						Talk("曹操","当我军与[Green]呂布[Normal]作战期间，[n]若[Green]劉備[Normal]从背后杀入，那可就腹背受敌了。");
						Talk("郭嘉","大人请放心，[n][Green]劉備[Normal]刚刚进驻徐州，军备尚不成气候。");
						Talk("郭嘉","日前他要求停战，[n]为的便是不想与我军开战，[n]足以证明羽翼未丰。");
						Talk("郭嘉","当今之势，[n]我们应该先考虑如何夺回兖州才是。");
						Talk("荀彧","[Green]郭嘉[Normal]大人所言极是，[n][Green]呂布[Normal]是只知进不知退的莽夫，[n]也许会反而来攻打我们。");
						Talk("荀彧","现在我们只须专心于与[Green]呂布[Normal]之战即可。");
						Talk("曹操","好，那么，[n]就先战[Green]呂布[Normal]吧！");
						Talk("曹操","[Green]呂布[Normal]是[Red]天下无双[Normal]的豪杰，[n]现今更有[Green]陳宮[Normal]等人辅助，切切不可轻视。");
					elseif JY.FID==2 then
						SetSceneID(51);
						Talk("孫乾","[Green]劉備[Normal]大人，[n]你来得正好，快去见我们主公。");
						SetSceneID(50);
						LoadPic(77,"淡入");
						Talk("劉備","[Green]陶謙[Normal]大人，请保重身体。");
						Talk("陶謙","我病已危笃，朝夕难保。[n]万望[Green]玄德[Normal]可怜汉家城池为重，[n]接任徐州牧，我死也瞑目了！。");
						Talk("劉備","大人还有两个儿子，[n]为何不传位给你的儿子？");
						Talk("陶謙","我长子陶商，次子陶应，他们的才能否不够。[n]我死之后，请[Green]玄德[Normal]好好教训他们。");
						Talk("關羽","兄长，有什么可犹豫的，[n]你就要有自己的领地了。");
						Talk("張飛","大哥，快快决定吧。");
						Talk("孫乾","[Green]劉備[Normal]大人，我们求您了。");
						Talk("糜竺","徐州时四战之地，[n]与其被敌人夺走，还不如托付于[Green]劉備[Normal]大人。");
						Talk("陶謙","如果能接受我的请求，[n]我也就没有什么可牵挂的了，[n][Green]玄德[Normal]请你一定要接受。");
						Talk("劉備","明白了，劉備不才，愿接受。");
						Talk("陶謙","你接受了，谢谢，这样我也没有牵挂了。[n]告别了。");
						DrawMulitStrBox("[Green]陶謙[Normal]去世了。");
						LoadPic(77,"淡出");
					elseif JY.FID==3 then
						SetSceneID(55);
						DrawMulitStrBox("[Green]孫策[Normal]让出[Red]玉玺[Normal]借得兵马后，[n]便驻扎在庐江，伺机攻打江东。");
						DrawMulitStrBox("此时，正逢结义兄弟[Green]周瑜[Normal]来见[Green]孫策[Normal]。");
						Talk("孫策","[Green]公瑾[Normal]，你来得正好！[n]有你在，我有如得百万之军。");
						Talk("周瑜","[Green]伯符[Normal]大人何必多礼？[n][Green]伯符[Normal]大人起步，我本应全力支援才对。");
						Talk("周瑜","为了[Green]伯符[Normal]大人得大业，[n]我周瑜愿效犬马之劳。");
						Talk("孫策","如此极好，[n]那可全靠你了。");
						Talk("周瑜","是。");
						Talk("程普","[Green]孫策[Normal]大人，[n]如今有了[Green]周瑜[Normal]大人相助，[n]我们应当立刻进军江东。");
						Talk("程普","请下出征命令！");
						Talk("孫策","嗯，好！");
						Talk("孫策","为了继承父亲的遗志，[n]也为了重振[Red]孙家[Normal]的威名，[n]我需要诸位共同协助。");
						Talk("孫策","我知道此战是场苦战，[n]但还是请各位同心协力，[n]一起取得我军的胜利！");
					elseif JY.FID==7 then
						SetSceneID(54);
						Talk("張邈","[Green]呂布[Normal]将军，[n]恭喜你占领的兖州。");
						Talk("呂布","这等小事，[n]那对我来讲算不了什么。");
						Talk("呂布","[Green]曹操[Normal]匹夫，[n]根据地被夺，[n]想必脸都气到白了吧！");
						Talk("陳宮","[Green]呂布[Normal]大人，据探子回报，[n][Green]曹操[Normal]已经和劉備停战，[n]正准备为夺回兖州而来。");
						Talk("陳宮","我方也应该加强防守，[n]以便迎击[Green]曹军[Normal]。");
						Talk("呂布","[Green]曹操[Normal]、[Green]曹操[Normal]，[n]你们就那么怕他吗？");
						Talk("呂布","[Green]曹操[Normal]若敢来犯，[n]我一马当先，一戟便取其首级。[n]看谁还敢阻扰我？");
						Talk("陳宮","[Green]曹操[Normal]兵强马壮，[n]手下人才济济，[n]请将军千万不可小视。");
						Talk("呂布","你太啰嗦了！[Green]陳宮[Normal]！[n]我自有我的想法。");
						Talk("呂布","首先我只要打倒[Green]曹操[Normal]，巩固中原，[n]便可从[Green]李傕[Normal]手中夺回都城。");
						Talk("呂布","[Green]張遼[Normal]、[Green]高顺[Normal]，立刻备齐人马，[n]去取[Green]曹操[Normal]的首级来见我。");
						Talk("張遼","末将领命。");
						Talk("陳宮","……");
					end
				end,
			[0104]=function()
					SetSceneID(59);
					LoadPic(103,"淡入");
					DrawMulitStrBox("时为东汉王朝第１４代皇帝·[Green]献帝[Normal]在位期间。");
					DrawMulitStrBox("迈入二世纪，统治大陆的王朝，[n]也因为相继爆发的叛乱和群雄的崛起，[n]而更显得衰退。");
					DrawMulitStrBox("徒有其表的朝廷已威信扫地，[n]群雄为了成为新霸主而相互争斗。");
					DrawMulitStrBox("王朝崩溃，导致各地诸侯割据，[n]历史舞台走进了自相残杀的战国乱世年代。");
					LoadPic(103,"淡出");
					LoadPic(12,"淡入");
					DrawMulitStrBox("建安３（１９８）年１２月，[n]朝廷的拥护者的[Green]曹操[Normal]攻向被孤立在徐州的[Green]呂布[Normal]。");
					DrawMulitStrBox("躲在下邳城顽强抵抗的[Green]呂布[Normal]，[n]最后由于属下背叛而被擒，死于刑场。");
					DrawMulitStrBox("此次胜利，[n]使[Green]曹操[Normal]控制了大陆中央的「[Red]中原[Normal]」大部分地区。");
					LoadPic(12,"淡出");
					LoadPic(25,"淡入");
					DrawMulitStrBox("建安４（１９９）年１月，[n]在大陆北部展开的冀州[Green]袁紹[Normal]与北平[Green]公孙瓒[Normal]攻防战，[n]也接近尾声。");
					DrawMulitStrBox("在易京建立要塞，阻止[Green]袁紹[Normal]北上的[Green]公孙瓒[Normal]，[n]最后兵败自杀，北方从此为[Green]袁紹[Normal]所控制。");
					LoadPic(25,"淡出");
					DrawMulitStrBox("在淮南建国「[Red]成[Normal]」，[n]却被[Green]曹操[Normal]大败而逃网的[Green]袁术[Normal]，[n]原本想投靠其兄[Green]袁紹[Normal]。");
					DrawMulitStrBox("但[Green]曹操[Normal]派出[Green]劉備[Normal]阻止其北上，[n]而死于混战之中。");
					DrawMulitStrBox("另外，[Green]劉備[Normal]参与暗杀[Green]曹操[Normal]的计划也东窗事发，[n]受到了[Green]曹操[Normal]的攻击。");
					DrawMulitStrBox("大败的[Green]劉備军[Normal]四散逃命，[n]守卫徐州的劉備之义弟·[Green]關羽[Normal]，[n]不久便投降于[Green]曹操[Normal]。");
					LoadPic(112,"淡入");
					DrawMulitStrBox("于是，华北被[Green]曹操[Normal]和[Green]袁紹[Normal]一分为二，[n]双方的决战将不可避免。");
					DrawMulitStrBox("[Green]曹操[Normal]为防备[Green]袁紹[Normal]南下，[n]降服了后顾之忧——宛城的[Green]張繡[Normal]之后，[n]立刻挥军向北推进。");
					LoadPic(112,"淡出");
					DrawMulitStrBox("但是，南方还有「[Red]江东小霸王[Normal]」·[Green]孫策[Normal]，[n][Green]孫策[Normal]也对中原虎视眈眈。");
					DrawMulitStrBox("[Green]曹操[Normal]、[Green]袁紹[Normal]以及[Green]孫策[Normal]三人，[n]瓜分天下之战即将开始了。");
					if JY.FID==1 then
						SetSceneID(54);
						Talk("曹操","哦，[Green]張繡[Normal]，[n]你来降就好，来降就好。");
						Talk("張繡","我是数次与[Green]曹操[Normal]大人作对之人，[n]没想到大人还会如此欢迎我。");
						Talk("曹操","不不不，[n]过去之事，便把它忘记吧！[n]今后还望你能好好表现。");
						Talk("張繡","是。");
						Talk("曹操","对了，[Green]郭嘉[Normal]，[n]除了[Green]張繡[Normal]以外，[n]其他南方诸候的动向如何？");
						Talk("郭嘉","江东的[Green]孫策[Normal]似乎已答应协助[Green]袁紹[Normal]，[n]但尚未结成同盟。");
						Talk("郭嘉","另外，荆州的[Green]刘表[Normal]，[n]无视[Green]袁紹[Normal]的请求，[n]只是袖手旁观。");
						Talk("荀彧","[Green]刘表[Normal]暂且不论，[n][Green]孫策[Normal]若是找到机会，[n]就会随时来攻的吧！");
						Talk("荀彧","我军必须留下最低限度的兵力，[n]以防[Green]孫策[Normal]来犯。");
						Talk("曹操","嗯，[Green]荀彧[Normal]留在许昌，[n]余者动员其他兵力，向北出发。");
						Talk("關羽","[Green]曹操[Normal]大人，[n]我愿尽可能报答大人的恩德。");
						Talk("關羽","在得知[Green]兄长[Normal]消息之前，[n]可否也让我随行？");
						Talk("曹操","嗯，如果有必要，我会叫你的，[n]但现在请将军留在都城。");
						Talk("關羽","……是。");
						Talk("曹操","诸位，与[Green]袁紹[Normal]之战，[n]将是决定天下之战，[n]如果战败，我们将前途叵测。");
						Talk("曹操","[Green]袁紹[Normal]大军人马虽多，但我们人才济济，[n]只要大家共同努力，我们必定不会失败。");
						Talk("曹操","在[Green]孫策[Normal]打来之前，[n]我们要与[Green]袁紹[Normal]决一死战，[n]取得华北！");
					elseif JY.FID==2 or JY.FID==4 then
						SetSceneID(52);
						DrawMulitStrBox("[Green]劉備[Normal]在徐州被[Green]曹操军[Normal]大败，[n]逃至[Green]袁紹[Normal]之处。");
						Talk("袁紹","哦，[Green]劉備[Normal]大人，[n]你来得正好！");
						Talk("袁紹","[Green]曹操[Normal]攻打徐州之时，[n]未去救援，真是抱歉。");
						Talk("劉備","哪里，[n]您愿接纳我这亡命之人就足矣。");
						Talk("袁紹","哪里的话，[n]您专程前来投奔于我，[n]我怎可置之不理？");
						Talk("袁紹","请贵君人马在当地稍作休息，[n]我军与[Green]曹操[Normal]开战时，[n]给我军声援吧！");
						Talk("劉備","好的。");
						Talk("袁紹","对了，[Green]審配[Normal]，[n]派往华南诸侯的使者，[n]有何消息回报？");
						Talk("審配","江东的[Green]孫策[Normal]已同意相助，[n]将会从后防攻击曹操。");
						Talk("審配","宛的[Green]張繡[Normal]已降服于[Green]曹操[Normal]，[n]荆州的[Green]刘表[Normal]则毫无音讯。");
						Talk("袁紹","可恶的[Green]刘表[Normal]，[n]只想袖手旁观，[n]早晚让他知道厉害。");
						Talk("田豐","[Green]袁紹[Normal]大人，[n]我们才刚打败[Green]公孙瓒[Normal]，[n]早往后还有许多战事。");
						Talk("田豐","我认为现在应派一使者去荆州，[n]向[Green]刘表[Normal]表达友好之意，[n]再向[Green]曹操[Normal]作战为好。");
						Talk("沮授","我也有同感，[n][Green]曹操[Normal]的战力非[Green]公孙瓒[Normal]所能比拟。");
						Talk("沮授","既然此战不可避免，[n]我们应做好万无一失的准备。");
						Talk("郭圖","非也，[n]现阶段，我方大军要比[Green]曹操[Normal]军力强大。");
						Talk("郭圖","若给他们时间，[n][Green]曹操[Normal]定会招兵买马，缩短兵力差距。");
						Talk("顏良","[Green]袁紹[Normal]大人，为何犹豫？[n][Green]曹操[Normal]的弱兵并非我和[Green]文醜[Normal]的对手。");
						Talk("文醜","请派给我等一支兵马，[n]我等必可杀尽[Green]曹操军[Normal]！");
						Talk("袁紹","喔！说得极好！[n]我军的士气正盛，[n]可以立即开始作战的准备。");
						Talk("袁紹","再讨论是多余的，[n]先败[Green]曹操[Normal]再取中原，[n]天下就是我们的了！");
					elseif JY.FID==3 then
						SetSceneID(54);
						Talk("張昭","[Green]孫策[Normal]大人，[n][Green]袁紹[Normal]的使者说些什么？");
						Talk("孫策","使者说，[Green]袁紹[Normal]希望我们袭击[Green]曹操[Normal]后防，[n]等打败[Green]曹操[Normal]后，大陆的南方便归于我。");
						Talk("張紘","那么，大人如何答复？");
						Talk("孫策","我答应相助。");
						Talk("孫策","既然[Green]袁紹[Normal]想利用我，[n]我们就利用回去吧！");
						Talk("周瑜","只要[Green]曹操[Normal]和[Green]袁紹[Normal]一开战，[n]双方多少都会有所损伤。");
						Talk("周瑜","趁此机会，[n]我们便可取得渔翁之利，是吗？");
						Talk("孫策","因为，[n]我也不想只当个「[Red]江东小霸王[Normal]」。");
						Talk("程普","但是，荆州尚有[Green]刘表[Normal]，[n]这可不能大意。");
						Talk("孫策","嗯，当然要留下防备荆州的人马。");
						Talk("孫策","这次是夺取中原的绝佳机会，[n]我们怎能错过？");
						Talk("孫策","吩咐下去，马上重整兵马，[n][Green]曹操军[Normal]一有空隙，便一鼓作气攻向许昌！");
					end
				end,
			[0105]=function()
					SetSceneID(59);
					LoadPic(103,"淡入");
					DrawMulitStrBox("时为东汉王朝第１４代皇帝·[Green]献帝[Normal]在位期间。");
					DrawMulitStrBox("迈入二世纪，统治大陆的王朝，[n]也因为相继爆发的叛乱和群雄的崛起，[n]而更显得衰退。");
					DrawMulitStrBox("徒有其表的朝廷已威信扫地，[n]群雄为了成为新霸主而相互争斗。");
					DrawMulitStrBox("王朝崩溃，导致各地诸侯割据，[n]历史舞台走进了自相残杀的战国乱世年代。");
					LoadPic(103,"淡出");
					LoadPic(79,"淡入");
					DrawMulitStrBox("建安７（２０２）年５月，[n]「[Red]官渡之战[Normal]」失败的的[Green]袁紹[Normal]，[n]在准备反击[Green]曹操[Normal]的途中病逝。");
					DrawMulitStrBox("由于[Green]袁紹[Normal]没有指定继承人而猝死，[n]袁家分为三子[Green]袁尚[Normal]派和长子[Green]袁谭[Normal]派，[n]开始相互斗争。");
					LoadPic(79,"淡出");
					SetSceneID(66);
					DrawMulitStrBox("[Green]曹操[Normal]没有放过这一时机，开始北上[n]建安９（２０４）年９月，[n]首先攻陷了[Green]袁尚[Normal]的根据地邺。");
					DrawMulitStrBox("建安１０（２０５）年１月，青州的[Green]袁谭[Normal]被灭。");
					DrawMulitStrBox("翌年，[Green]袁尚[Normal]留在壶关的高干也战败而被擒。");
					DrawMulitStrBox("[Green]袁尚[Normal]眼看就要被追赶到，[n]就投奔了北方的游牧民族[Red]乌丸[Normal]。[n]袁家命运已如风中之烛。");
					if JY.FID==1 then
						SetSceneID(52);
						Talk("張遼","[Green]曹操[Normal]大人，[n]冀州的攻略结束了，[n]现在只剩下[Red]北平[Normal]了。");
						Talk("張遼","[Green]袁尚[Normal]已如瓮中之鳖，[n]讨伐的准备也已做好了。");
						Talk("郭嘉","[Green]袁尚[Normal]不值一提，[n]在辽东还残有[Green]公孙[Normal]一族。");
						Talk("郭嘉","此次，一气打败两家，[n]完全控制幽州。");
						Talk("郭嘉","如果他们留下，[n]必成后患。");
						Talk("曹操","嗯，袁家讨伐军继续北上。");
						Talk("曹操","但是，[n]不能一直和一只脚已入土的袁家有瓜葛。");
						Talk("曹操","[Green]樂進[Normal]，你领一支人马，[n]去支援[Green]曹仁[Normal]、[Green]夏侯惇[Normal]。");
						Talk("樂進","遵命，[n]立刻前往南方。");
						Talk("曹操","其他人也开始做好南下准备。");
						Talk("曹操","东吴的[Green]孫權[Normal]，荆州的[Green]刘表[Normal]，[n]还有新野的[Green]劉備[Normal]，[n]南方还有不少敌人残留。");
						Talk("曹操","但是，[n]谁的势力也比不过当年的[Green]袁紹[Normal]。");
						Talk("曹操","天下像已回到我们手中，[n]好好打仗吧。");
					elseif JY.FID==2 then
						SetSceneID(54);
						Talk("劉備","[Green]曹操[Normal]和袁氏一家之战快要结束了吧？");
						Talk("劉備","[Green]曹操[Normal]南下以荆州为目标时，[n]新野必将成为战场。");
						Talk("劉備","新野小城，兵微将寡，[n][Green]曹操[Normal]来攻打时，如何防御好呢？");
						Talk("張飛","兄长，[n]没有必要等待[Green]曹操[Normal]南下。");
						Talk("張飛","趁[Green]曹军[Normal]北上期间，[n]夺取许昌不是更好吗？");
						Talk("趙雲","正如[Green]張飛[Normal]大人所说，[n]如果要攻打[Green]曹操[Normal]，没理由错过现在。");
						Talk("趙雲","虽说这样，[n]但[Green]曹操[Normal]已派[Green]曹仁[Normal]巩固防守，[n]不易攻打呀！");
						Talk("劉備","嗯！[Green]徐庶[Normal]怎么考虑？");
						Talk("徐庶","的确，[Green]曹军[Normal]是大军，[n]但战斗的胜负不是只靠兵力决定的。");
						Talk("徐庶","大军有大军，[n]少数有少数各自的作战方法。");
						Talk("徐庶","攻打敌人的空隙是最好的，[n]如果不行，只有想其他办法了。");
						Talk("徐庶","当前，召集武将，[n]集合士兵是当务之急。");
						Talk("徐庶","准备人马，[Green]曹军[Normal]若来攻打，[n]就和[Green]刘表[Normal]大人联手击退。");
						Talk("徐庶","敌人发生混乱之时，[n]我方如有足够的战斗力就转为反攻吧！");
						Talk("劉備","嗯，的确如此。");
						Talk("劉備","[Green]徐庶[Normal]，[n]我们以前就是没有像你一样的军师才连吃败仗的。");
						Talk("劉備","[Green]曹操[Normal]来攻时，请多帮忙。");
						Talk("徐庶","是，我将尽我所能。");
					elseif JY.FID==4 then
						SetSceneID(54);
						Talk("袁熙","[Green]袁尚[Normal]，[n]再抵抗我们也无望取胜。");
						Talk("袁熙","索性不如投降[Green]曹操[Normal]吧？");
						Talk("袁尚","说什么呢？[n]兄长，袁家的志气为人所夸，[n]不能投降[Green]曹操[Normal]。");
						Talk("袁尚","首先，若投降的话，[n]属下是不会原谅我们兄弟的。");
						Talk("袁尚","[Green]袁谭[Normal]和[Green]高干[Normal]等被擒的袁家人全部被杀。");
						Talk("袁熙","到底如何是好呢？[n]面对那样的大军如何作战？");
						Talk("袁尚","只有求助辽东的[Green]公孙康[Normal]了。");
						Talk("袁尚","如果我们被灭，[n][Green]公孙康[Normal]也要被灭亡，[n]一定会帮助我们的。");
						Talk("袁熙","我不认为[Green]公孙康[Normal]会答应。[n]如果我们联手，就断了同[Green]曹操[Normal]讲和之道。");
						Talk("袁尚","交战或交涉，[n]不去做就无法知道。");
						Talk("袁尚","[Green]公孙康[Normal]若不答应，[n]那就只有通过战争来打败[Green]曹操[Normal]。");
						Talk("袁尚","我们还有[Red]乌丸[Normal]的骑兵，[n]战到最后，若失败就去死！");
					end
				end,
			[0106]=function()
					SetSceneID(59);
					LoadPic(103,"淡入");
					DrawMulitStrBox("时为东汉王朝第１４代皇帝·[Green]献帝[Normal]在位期间。");
					DrawMulitStrBox("统治大陆２个世纪的王朝由于叛乱频发，[n]群雄四起，日渐衰败了。");
					DrawMulitStrBox("徒有虚名的朝廷威信扫地，[n]有实力的群雄为了争夺霸权，[n]逐鹿中原而战事不断。");
					LoadPic(103,"淡出");
					LoadPic(1,"淡入");
					DrawMulitStrBox("西蜀之地·「[Red]益州[Normal]」。[n]这个地区被大陆西南部的群山环绕，[n]与中原发生的战斗本无关系，故而免于战祸。");
					LoadPic(1,"淡出");
					SetSceneID(66);
					DrawMulitStrBox("然而，自从汉中的[Green]張魯[Normal]企图攻打益州，[n]益州的形势瞬间发生了变化。");
					DrawMulitStrBox("益州的[Green]刘璋[Normal]为了对抗[Green]張魯[Normal]，[n]向荆州的[Green]劉備[Normal]求援。");
					DrawMulitStrBox("[Green]劉備[Normal]应邀亲入益州对抗[Green]張魯[Normal]。[n]因此，[Green]張魯[Normal]放弃了进军，一场战乱似乎避免了。");
					DrawMulitStrBox("可是，事态又急转直下。[n]这次是[Green]刘璋[Normal]和[Green]劉備[Normal]的关系恶化，[n]最终双方进行交战。");
					LoadPic(93,"淡入");
					DrawMulitStrBox("[Green]劉備军[Normal]经历了一番苦战，损失了军师[Green]庞统[Normal]，[n]但荆州援军赶到，得以反败为胜，[n]直逼[Green]刘璋[Normal]所在的成都。");
					DrawMulitStrBox("被逼的走投无路的[Green]刘璋[Normal]，向曾是敌人的[Green]張魯[Normal]求援，[n][Green]張魯[Normal]响应，派[Green]馬超[Normal]前往。");
					DrawMulitStrBox("可是，由于[Green]諸葛亮[Normal]的计谋，[Green]馬超[Normal]被[Green]張魯[Normal]猜疑，[n]大失所望的[Green]馬超[Normal]投靠了[Green]劉備[Normal]。");
					LoadPic(93,"淡出");
					SetSceneID(59);
					LoadPic(11,"淡入");
					DrawMulitStrBox("连[Green]馬超[Normal]也投靠了[Green]劉備[Normal]，[n][Green]刘璋[Normal]失去了抵抗力，所以向[Green]劉備[Normal]投降了。");
					LoadPic(11,"淡出");
					LoadPic(114,"淡入");
					DrawMulitStrBox("于是，[Green]劉備[Normal]成功地进入蜀地。[n]天下进入了[Green]曹操[Normal]、[Green]劉備[Normal]、[Green]孫權[Normal]互相鼎立的三国时代。");
					LoadPic(114,"淡出");
					if JY.FID==1 then
						SetSceneID(52);
						Talk("曹操","[Green]劉備[Normal]还是入蜀了吗？");
						Talk("曹操","不能对这家伙听之任之了。[n]有什么办法吗？");
						Talk("荀攸","[Green]曹操[Normal]大人，[n]讨伐蜀地的[Green]劉備[Normal]只有两条路线。");
						Talk("荀攸","一条是从荆州，[n]另一条是从汉中。");
						Talk("曹操","所言极是，[n]但汉中有[Green]張魯[Normal]。");
						Talk("夏侯惇","[Green]張魯[Normal]现在孤立无援。[n]如果我军攻打，可一击即败。");
						Talk("夏侯惇","所以今后，攻打蜀地的[Green]劉備[Normal]时，[n]从汉中开始攻打要比从荆州更有利了。");
						Talk("曹操","嗯，的确如此。[n]可是如果汉中被[Green]劉備[Normal]夺去，[n]长安就危险了。");
						Talk("曹操","必须立刻向西加强兵力，[n]准备进攻汉中。");
						Talk("曹操","[Green]夏侯淵[Normal]、[Green]张郃[Normal]，[n]命你等为西征军的先锋。");
						Talk("曹操","夺取汉中，[n]为进攻蜀地创造优势。");
						Talk("夏侯淵","遵命！");
						Talk("曹操","其他人也要准备支援西征，[n]继续防范南方。");
						Talk("曹仁","明白了！");
					elseif JY.FID==2 then
						SetSceneID(52);
						Talk("劉備","[Green]馬超[Normal]做得好啊！[n]多亏了你，才避免了无谓的牺牲。");
						Talk("馬超","能为您效力，真是太好了。");
						Talk("劉備","诸位，辛苦了。[n]但是失去了军师[Green]庞统[Normal]，唉！[n]真是令人万分痛心。");
						Talk("劉備","不过，确得到了蜀地，[n]有了与[Green]曹操[Normal]、[Green]孫權[Normal]两强抗衡的势力。");
						Talk("法正","主公，我们刚刚扩大完领土。[n]国力还不及[Green]曹操[Normal]他们。");
						Talk("法正","现在首要勤于内政，安定民心，[n]逐渐积蓄能与[Green]曹操[Normal]抗衡的力量。");
						Talk("諸葛亮","当前有可能和[Green]曹操[Normal]交战的，[n]是[Green]關羽[Normal]将军所在的荆州。");
						Talk("諸葛亮","嗯，准备支援荆州，[n]同时努力增强国力。");
						Talk("劉備","嗯，明白了。[n][Green]關羽[Normal]，荆州拜托你了。");
						Talk("關羽","遵命！[n]即使豁上性命[n]也一定会守住荆州。");
					elseif JY.FID==3 then
						SetSceneID(54);
						Talk("孫權","[Green]劉備[Normal]最终还是占领了蜀地，[n]这对于[Green]曹操[Normal]也是不可轻视的。");
						Talk("孫權","[Green]曹操[Normal]会如何采取行动呢？");
						Talk("呂蒙","[Green]劉備[Normal]刚入蜀地，[n]国力尚未加强。");
						Talk("呂蒙","[Green]曹操[Normal]然道不想在蜀国力量增强前攻打汉中吗？");
						Talk("韓當","噢，若是如此，[n][Green]曹操[Normal]对我们的防备也许会减轻喔。");
						Talk("魯肅","不，不，[n][Green]曹操[Normal]也一定对我们保持着足够的防备。");
						Talk("魯肅","但是，如果趁[Green]曹操[Normal]向汉中蜀地进军之际，[n]我们攻其背后[n][Green]曹操[Normal]就要两面作战，这对我们是有利的。");
						Talk("孫權","嗯，那么一旦[Green]曹操军[Normal]西进有机可乘，[n]我们就攻打北部。");
						Talk("徐盛","遵命！[n]立刻准备人马。");
					elseif JY.FID==16 then
						SetSceneID(54);
						Talk("張魯","哎呀呀，没想到[Green]馬超[Normal]归顺了[Green]劉備[Normal]。");
						Talk("張魯","我们被[Green]曹操[Normal]和[Green]劉備[Normal]夹在中间，[n]应该如何是好啊？");
						Talk("楊松","放心，[Green]劉備[Normal]刚得蜀地，不会马上来攻打，[n]但[Green]曹操[Normal]也许很快就来攻，需要警惕。");
						Talk("楊任","主公，汉中有要塞·「[Red]阳平关[Normal]」");
						Talk("楊任","即使[Green]曹操[Normal]再强大，[n]也无法轻易攻破。");
						Talk("龐德","[Green]張魯[Normal]大人有恩于我，[n]让我上阵吧！");
						DrawMulitStrBox("[Green]龐德[Normal]是[Green]馬超[Normal]的属下，[n]但因患病没能一同出战，[n]留在了汉中。");
						Talk("張魯","噢，你也参战，[n]我就更有信心了。");
						Talk("張魯","事已至此，除了增强兵力，[n]击退[Green]曹操[Normal]别无办法。");
						Talk("張魯","立刻准备人马！");
						Talk("張衛","遵命！");
					end
				end,
			[0111]=function()
					SetSceneID(61);
					DrawMulitStrBox("在『三国演义』登场的众多英杰们。[n]在这之中，能被称为英雄的人物，[n]究竟有多少呢？");
					DrawMulitStrBox("拥有民众声望的太平道教主·[Green]张角[Normal]、[n]为达目的不折手段的逆臣[Green]董卓[Normal]、[n]率领白马义从驰名[Red]幽州[Normal]的[Green]公孙瓒[Normal]、");
					LoadPic(127,"淡入");
					DrawMulitStrBox("以天下无双的武力，造成中原骚动的[Green]呂布[Normal]、[n]在[Red]凉州[Normal]贯彻对汉朝之忠义的[Green]马腾[Normal]、[n]称霸南蛮之地的[Green]孟获[Normal]、");
					LoadPic(127,"淡出");
					LoadPic(25,"淡入");
					DrawMulitStrBox("出生于名门[Red]袁[Normal]家，一起竞争[n]应拥有强大势力将称霸的[Green]袁紹[Normal]和[Green]袁术[Normal]、[n]平定并坚守[Red]荆州[Normal]的[Green]刘表[Normal]、");
					LoadPic(25,"淡出");
					LoadPic(111,"淡入");
					DrawMulitStrBox("江东之虎·[Green]孫堅[Normal]、小霸王·[Green]孫策[Normal]、[n]继承伟大的父亲与兄长的意志，[n]平定江东的吴太祖·[Green]孫權[Normal]、");
					LoadPic(111,"淡出");
					LoadPic(12,"淡入");
					DrawMulitStrBox("以卓越的才智制衡中原的[Green]曹操[Normal]、[n]继承其地盘统一天下[n]奠定晋国基础的[Green]司马懿[Normal]、");
					LoadPic(12,"淡出");
					LoadPic(13,"淡入");
					DrawMulitStrBox("以及流浪与苦难的终点，[n]在天命之地·蜀国称王的[Green]劉備[Normal]。");
					LoadPic(13,"淡出");
					LoadPic(119,"淡入");
					DrawMulitStrBox("英雄十三杰在此集结相争。[n]能称王的真英雄，究竟是谁呢？[n]激烈战争就此展开。");
					LoadPic(119,"淡出");
				end,
			[1001]=function()
					--XXX救援战
					local p1,p2,p3,p4,p5,p6,p7,p8,p9,p10;
					local wid;
					local plist={};
					--被救援者
					plist=FilterPerson("君主是",-1,	"排序","武力",	"保留",200);
					p1=TableRandom(plist);
					--敌军主帅
					plist=FilterPerson("君主是",-1,	"排序","统率",	"保留",300);
					p2=TableRandom(plist);
					
					--战场定义
					WarIni();
					DefineWarMap(0,"XXX救援战","一、击败？？？．",20,"主角",p2);
					--我军
					InsertWarPerson(0,"主角",3,18,"右",0,"我",false,"待机",0,0);
					SelectTeam(	2,17,"右",false,
								2,19,"右",false,
								3,20,"右",false,
								1,18,"右",false,
								1,20,"右",false,
								4,19,"右",false)
					
					--友军
					InsertWarPerson(1,p1,			10,12,"下",4,"友",false,"坚守",-1,-1);
					WarSetFlag(101,War.PersonNum);
					InsertWarPerson(1,GenPerson(true,p1,"弓兵队"),	11,12,"下",2,"友",false,"坚守",-1,-1);
					InsertWarPerson(1,GenPerson(true,p1,"步兵队"),	10,13,"下",2,"友",false,"坚守",-1,-1);
					InsertWarPerson(1,GenPerson(true,p1,"步兵队"),	9,12,"下",2,"友",false,"坚守",-1,-1);
					
					--敌军
						--主将 & 本营
					InsertWarPerson(2,p2,			16,2,"左",5,"敌",false,"待机",-1,-1);
					WarSetFlag(111,War.PersonNum);
					InsertWarPerson(2,GenPerson(true,p2,"万能"),	16,1,"左",2,"敌",false,"待机",-1,-1);
					InsertWarPerson(2,GenPerson(true,p2,"步兵队"),	16,3,"左",2,"敌",false,"待机",-1,-1);
					InsertWarPerson(2,GenPerson(true,p2,"骑兵队"),	17,2,"左",2,"敌",false,"待机",-1,-1);
					InsertWarPerson(2,GenPerson(true,p2,"骑兵队"),	17,1,"左",2,"敌",false,"待机",-1,-1);
						--底部部队，后续攻击我军
					InsertWarPerson(3,GenPerson(true,p2,"步兵队"),	10,17,"上",1,"敌",false,"出击",10,15);
					InsertWarPerson(3,GenPerson(true,p2,"步兵队"),	11,18,"上",0,"敌",false,"出击",11,16);
					InsertWarPerson(3,GenPerson(true,p2,"弓将"),	12,18,"上",0,"敌",false,"出击",10,16);
						--左翼
					InsertWarPerson(4,GenPerson(true,p2,"贼兵"),		5,11,"右",0,"敌",false,"出击",8,10);
					InsertWarPerson(4,GenPerson(true,p2,"步兵队"),	4,12,"右",1,"敌",false,"出击",7,12);
						--前锋
					InsertWarPerson(5,GenPerson(true,p2,"步将"),		11,4,"下",0,"敌",false,"出击",9,12);
					InsertWarPerson(5,GenPerson(true,p2,"步兵队"),	10,5,"下",0,"敌",false,"出击",12,12);
					InsertWarPerson(5,GenPerson(true,p2,"贼兵"),		12,5,"下",0,"敌",false,"出击",13,12);
					
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
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(2)) and WarCheckArea(-1,8,1,20,6) then
							WarSetFlag(2,2);	--敌军总攻
							WarTalk(WarGetFlag(111),"敌军已经不堪一击了[n]全军出击！");
							WarModifyTeamAI(2,"出击",WarGetFlag(111),-1);
							WarModifyAI(WarGetFlag(111),"出击",-1,-1)
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						--第2回合 友军AI修改，允许攻击
						if War.Turn==2 and (not WarCheckFlag(1)) then
							WarSetFlag(1,1);
							WarModifyTeamAI(1,"出击",WarGetFlag(101),-1);
							WarModifyAI(WarGetFlag(101),"坚守",-1,-1)
						end
						--敌军未总攻，敌军数量少于7
						if War.PersonNumEnemy<7 and (not WarCheckFlag(2)) then
							WarSetFlag(2,1);	--友军反攻
							WarTalk(WarGetFlag(101),"形势逆转了[n]全军，反击！");
							WarModifyAI(WarGetFlag(101),"出击",-1,-1)
						end
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						--友军未反攻，第12回合
						if War.Turn==12 and (not WarCheckFlag(2)) then
							WarSetFlag(2,2);	--敌军总攻
							WarTalk(WarGetFlag(111),"敌军已经不堪一击了[n]全军出击！");
							WarModifyTeamAI(2,"出击",WarGetFlag(111),-1);
							WarModifyAI(WarGetFlag(111),"出击",-1,-1)
						end
					end
					
					--[[
					时机
					回合开始前 我/友/敌
					武将行动后
					
					
					武将相邻测试
					武将进入指定地点/区域测试
					武将点击测试 ？？无用
					武将开始行动/结束行动测试？？
					武将状态测试 ？？时机
					战场人数测试 ？？时机
					行动方测试
					回合测试
					胜利测试
					失败测试
					]]--
				end,
			[1004]=function()
					--XXX救援战
					local p1,p2,p3,p4,p5,p6,p7,p8,p9,p10;
					local wid;
					local plist={};
					--被救援者
					plist=FilterPerson("君主是",-1,	"排序","武力",	"保留",200);
					p1=TableRandom(plist);
					--敌军主帅
					plist=FilterPerson("君主是",-1,	"排序","智谋",	"保留",300);
					p2=TableRandom(plist);
					
					--战场定义
					WarIni();
					DefineWarMap(1,"XXX救援战","一、击败？？？．",20,"主角",p2);
					--我军
					InsertWarPerson(0,"主角",20,7,"左",0,"我",false,"待机",0,0);
					SelectTeam(	20,6,"左",false,
								19,7,"左",false,
								20,8,"左",false,
								19,6,"左",false,
								19,8,"左",false,
								20,5,"左",false,
								20,9,"左",false,
								18,7,"左",false)
					
					--友军
					InsertWarPerson(1,p1,			11,11,"右",4,"友",false,"移动",16,11);
					WarSetFlag(101,War.PersonNum);
					InsertWarPerson(1,GenPerson(true,p1,"骑兵队"),	12,12,"右",0,"友",false,"移动",16,11);
					InsertWarPerson(1,GenPerson(true,p1,"步兵队"),	11,10,"右",0,"友",false,"移动",16,11);
					InsertWarPerson(1,GenPerson(true,p1,"步将"),		11,12,"右",1,"友",false,"移动",16,11);
					InsertWarPerson(1,GenPerson(true,p1,"弓兵队"),	10,11,"右",1,"友",false,"移动",16,11);
					InsertWarPerson(1,GenPerson(true,p1,"弓兵队"),	10,12,"右",0,"友",false,"移动",16,11);
					
					--敌军
						--主将 & 本营
					InsertWarPerson(2,p2,			3,9,"右",5,"敌",false,"待机",-1,-1);
					WarSetFlag(111,War.PersonNum);
					InsertWarPerson(2,GenPerson(true,p2,"步兵队"),	4,10,"右",2,"敌",false,"待机",-1,-1);
					InsertWarPerson(2,GenPerson(true,p2,"步兵队"),	4,11,"右",2,"敌",false,"待机",-1,-1);
					InsertWarPerson(2,GenPerson(true,p2,"弓兵队"),	4,9,"右",2,"敌",false,"待机",-1,-1);
					InsertWarPerson(2,GenPerson(true,p2,"弓兵队"),	4,12,"右",2,"敌",false,"待机",-1,-1);
					InsertWarPerson(2,GenPerson(true,p2,"骑将"),		3,10,"右",2,"敌",false,"待机",-1,-1);
					InsertWarPerson(2,GenPerson(true,p2,"骑将"),		3,11,"右",2,"敌",false,"待机",-1,-1);
						--伏兵 上
					InsertWarPerson(3,GenPerson(true,p2,"步将"),		9,6,"下",1,"敌",true,"出击",13,9);
					InsertWarPerson(3,GenPerson(true,p2,"弓兵队"),	10,5,"下",0,"敌",true,"出击",13,9);
					InsertWarPerson(3,GenPerson(true,p2,"步兵队"),	11,6,"下",1,"敌",true,"出击",13,9);
					InsertWarPerson(3,GenPerson(true,p2,"弓兵队"),	12,5,"下",0,"敌",true,"出击",13,9);
					InsertWarPerson(3,GenPerson(true,p2,"步兵队"),	13,6,"下",1,"敌",true,"出击",13,9);
						--伏兵 下
					InsertWarPerson(4,GenPerson(true,p2,"步兵队"),	9,15,"上",0,"敌",true,"出击",13,13);
					InsertWarPerson(4,GenPerson(true,p2,"步兵队"),	10,16,"上",1,"敌",true,"出击",13,13);
					InsertWarPerson(4,GenPerson(true,p2,"贼兵"),		11,15,"上",0,"敌",true,"出击",13,13);
					InsertWarPerson(4,GenPerson(true,p2,"弓将"),		12,16,"上",1,"敌",true,"出击",13,13);
					InsertWarPerson(4,GenPerson(true,p2,"贼兵"),		13,17,"上",0,"敌",true,"出击",13,13);
					JY.Status=GAME_WMAP;
					NextEvent(1005);
				end,
			[1005]=function()
					PlayBGM(11);
					WarTalk(WarGetFlag(101),"总算逃出来[n]到了这里应该安全了吧？");
					WarTalk(WarGetFlag(111),"哼，你是逃不掉的！[n]出来吧！");
					WarTalk(WarGetFlag(101),31);
					WarShowTeamArmy(3);
					WarShowTeamArmy(4);
					WarModifyTeamAI(3,"出击",WarGetFlag(101),-1);
					WarModifyTeamAI(4,"出击",WarGetFlag(101),-1);
					WarShowTarget(true);
					PlayBGM(19);
					NextEvent(1006);
				end,
			[1006]=function()
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						--第2回合 友军AI修改，允许攻击
						if War.Turn==2 and (not WarCheckFlag(1)) then
							WarSetFlag(1,1);
							WarModifyTeamAI(1,"出击",WarGetFlag(101),-1);
							WarModifyAI(WarGetFlag(101),"出击",1,-1)
						end
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						--前线作战不利
						if War.PersonNumEnemy<14 and (not WarCheckFlag(2)) then
							WarSetFlag(2,1);	--友军反攻
							WarTalk(WarGetFlag(111),"前线部队居然陷入苦战！[n]全军出击，不能给敌人喘息之机！");
							WarModifyTeamAI(2,"出击",WarGetFlag(111),-1);
							WarModifyAI(WarGetFlag(111),"出击",-1,-1)
						end
						--友军未反攻，第10回合
						if War.Turn==10 and (not WarCheckFlag(2)) then
							WarSetFlag(2,2);	--敌军总攻
							WarTalk(WarGetFlag(111),"敌军已经不堪一击了[n]全军出击！");
							WarModifyTeamAI(2,"出击",WarGetFlag(111),-1);
							WarModifyAI(WarGetFlag(111),"出击",-1,-1)
						end
					end
				end,
			[1007]=function()
					--XXX救援战
					local p1,p2,p3,p4,p5,p6,p7,p8,p9,p10;
					local wid;
					local plist={};
					--被救援者
					plist=FilterPerson("君主是",-1,	"排序","魅力",	"保留",200);
					p1=TableRandom(plist);
					--敌军主帅
					plist=FilterPerson("君主是",-1,	"排序","统率",	"保留",300);
					p2=TableRandom(plist);
					--敌军主帅2
					plist=FilterPerson("君主是",-1,	"排序","武力",	"保留",300);
					p3=TableRandom(plist);
					
					--战场定义
					WarIni();
					DefineWarMap(3,"XXX救援战","一、击败？？？．",20,"主角",p2);
					--我军
					InsertWarPerson(0,"主角",2,3,"下",0,"我",false,"待机",0,0);
					SelectTeam(	1,4,"下",false,
								3,4,"下",false,
								1,2,"下",false,
								3,2,"下",false,
								2,2,"下",false,
								1,3,"下",false,
								3,3,"下",false,
								2,4,"下",false)
					
					--友军
					InsertWarPerson(1,p1,			4,19,"上",4,"友",false,"坚守",0,0);
					WarSetFlag(101,War.PersonNum);
					InsertWarPerson(1,GenPerson(true,p1,"步兵队"),		3,18,"上",0,"友",false,"坚守",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"步兵队"),	4,18,"上",0,"友",false,"坚守",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"步兵队"),	5,18,"上",0,"友",false,"坚守",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"弓兵队"),		3,19,"上",1,"友",false,"坚守",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"弓兵队"),	5,19,"上",1,"友",false,"坚守",0,0);
					
					InsertWarPerson(2,GenPerson(true,p1,"武力"),	4,15,"上",0,"友",false,"坚守",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"骑兵队"),	4,14,"上",1,"友",false,"坚守",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"步兵队"),	3,15,"上",0,"友",false,"坚守",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"步兵队"),	5,15,"上",-1,"友",false,"坚守",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"弓兵队"),	4,16,"上",-1,"友",false,"坚守",0,0);
					
					InsertWarPerson(3,GenPerson(true,p1,"武力"),	9,17,"上",1,"友",false,"坚守",0,0);
					InsertWarPerson(3,GenPerson(true,p1,"骑兵队"),	8,16,"上",0,"友",false,"坚守",0,0);
					InsertWarPerson(3,GenPerson(true,p1,"骑兵队"),	10,16,"上",-1,"友",false,"坚守",0,0);
					InsertWarPerson(3,GenPerson(true,p1,"弓兵队"),	8,18,"上",1,"友",false,"坚守",0,0);
					InsertWarPerson(3,GenPerson(true,p1,"弓兵队"),	10,18,"上",0,"友",false,"坚守",0,0);
					
					--敌军
						--主将 & 本营
					InsertWarPerson(4,p2,			27,11,"左",5,"敌",false,"待机",-1,-1);
					WarSetFlag(111,War.PersonNum);
					InsertWarPerson(4,GenPerson(true,p2,"谋将"),	26,10,"左",3,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"步兵队"),	26,12,"左",3,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"骑兵队"),	27,10,"左",3,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"骑兵队"),	27,12,"左",3,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"骑兵队"),	28,11,"左",3,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"骑兵队"),	28,10,"左",3,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"骑兵队"),	28,12,"左",3,"敌",false,"待机",-1,-1);
						--主营 前阵
					InsertWarPerson(5,GenPerson(true,p2,"步将"),	23,9,"左",2,"敌",false,"待机",13,9);
					InsertWarPerson(5,GenPerson(true,p2,"弓兵队"),	24,9,"左",1,"敌",false,"待机",13,9);
					InsertWarPerson(5,GenPerson(true,p2,"弓兵队"),	25,9,"左",1,"敌",false,"待机",13,9);
					InsertWarPerson(5,GenPerson(true,p2,"步将"),	23,13,"左",2,"敌",false,"待机",13,9);
					InsertWarPerson(5,GenPerson(true,p2,"弓兵队"),	24,13,"左",1,"敌",false,"待机",13,9);
					InsertWarPerson(5,GenPerson(true,p2,"弓兵队"),	25,13,"左",1,"敌",false,"待机",13,9);
						--前锋 主营
					InsertWarPerson(6,p3,			9,10,"下",5,"敌",false,"坚守",-1,-1);
					WarSetFlag(112,War.PersonNum);
					InsertWarPerson(6,GenPerson(true,p3,"贼兵"),		8,10,"下",3,"敌",false,"坚守",-1,-1);
					InsertWarPerson(6,GenPerson(true,p3,"步兵队"),	8,9,"下",2,"敌",false,"坚守",-1,-1);
					InsertWarPerson(6,GenPerson(true,p3,"贼兵"),		9,11,"下",3,"敌",false,"坚守",-1,-1);
					InsertWarPerson(6,GenPerson(true,p3,"弓兵队"),	9,9,"下",2,"敌",false,"坚守",-1,-1);
					InsertWarPerson(6,GenPerson(true,p3,"步兵队"),	10,10,"下",2,"敌",false,"坚守",-1,-1);
					InsertWarPerson(6,GenPerson(true,p3,"贼兵"),		10,11,"下",3,"敌",false,"坚守",-1,-1);
						--前锋 左
					InsertWarPerson(4,GenPerson(true,p3,"弓兵队"),	5,10,"下",0,"敌",false,"出击",4,15);
					InsertWarPerson(4,GenPerson(true,p3,"弓兵队"),	4,9,"下",1,"敌",false,"出击",4,15);
					InsertWarPerson(4,GenPerson(true,p3,"步兵队"),	3,10,"下",0,"敌",false,"出击",4,15);
					InsertWarPerson(4,GenPerson(true,p3,"贼将"),		2,11,"下",2,"敌",false,"出击",4,15);
					InsertWarPerson(4,GenPerson(true,p3,"贼兵"),		1,12,"下",2,"敌",false,"出击",4,15);
						--前锋 右
					InsertWarPerson(4,GenPerson(true,p3,"万能"),	12,13,"左",1,"敌",false,"出击",9,17);
					InsertWarPerson(4,GenPerson(true,p3,"贼兵"),		13,14,"左",1,"敌",false,"出击",9,17);
					InsertWarPerson(4,GenPerson(true,p3,"弓兵队"),	14,15,"左",0,"敌",false,"出击",9,17);
					InsertWarPerson(4,GenPerson(true,p3,"步兵队"),	15,16,"左",0,"敌",false,"出击",9,17);
					InsertWarPerson(4,GenPerson(true,p3,"弓兵队"),	15,17,"左",0,"敌",false,"出击",9,17);
					JY.Status=GAME_WMAP;
					NextEvent(1008);
				end,
			[1008]=function()
					PlayBGM(11);
					WarTalk(WarGetFlag(111),30);
					WarTalk(WarGetFlag(101),31);
					WarTalk(WarGetFlag(112),"前军，出发！");
					WarShowTarget(true);
					PlayBGM(19);
					NextEvent(1009);
				end,
			[1009]=function()
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						--第2回合 友军AI修改，允许攻击
						if War.Turn==2 and (not WarCheckFlag(1)) then
							WarSetFlag(1,1);
							WarModifyTeamAI(2,"待机",0,0);
							WarModifyTeamAI(3,"待机",0,0);
						end
						--第5回合 友军AI修改，允许攻击
						if War.Turn==5 and (not WarCheckFlag(2)) then
							WarSetFlag(2,1);
							WarModifyTeamAI(1,"待机",0,0);
						end
						--敌军未总攻，敌军数量少于7
						if War.PersonNumEnemy<7 and (not WarCheckFlag(5)) then
							WarSetFlag(5,1);	--友军反攻
							WarTalk(WarGetFlag(101),"形势逆转了[n]全军，反击！");
							WarModifyTeamAI(1,"出击",0,0);
							WarModifyTeamAI(2,"出击",0,0);
							WarModifyTeamAI(3,"出击",0,0);
						end
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						--前线作战不利
						if War.PersonNumEnemy<18 and (not WarCheckFlag(4)) then
							WarSetFlag(4,1);	--敌军总攻
							WarTalk(WarGetFlag(111),"前线部队居然陷入苦战！[n]全军出击，不能给敌人喘息之机！");
							WarModifyTeamAI(4,"出击",WarGetFlag(111),-1);
							WarModifyAI(WarGetFlag(111),"出击",-1,-1)
							WarModifyTeamAI(5,"出击",0,0);
						end
						--友军未反攻，第8回合
						if War.Turn==8 and (not WarCheckFlag(3)) then
							WarSetFlag(3,1);	--敌军总攻
							WarTalk(WarGetFlag(111),"给我继续攻击！");
							WarModifyTeamAI(5,"出击",0,0);
						end
						
						if War.Turn==4 then
							WarTalk(WarGetFlag(112),"是时候了[n]全军出击！");
							WarModifyTeamAI(6,"出击",WarGetFlag(112),-1);
							WarModifyAI(WarGetFlag(112),"出击",-1,-1)
						end
					end
				end,
			[1010]=function()
					--XXX救援战
					local p1,p2,p3,p4,p5,p6,p7,p8,p9,p10;
					local wid;
					local plist={};
					--被救援者
					plist=FilterPerson("君主是",-1,	"排序","政务",	"保留",200);
					p1=TableRandom(plist);
					--敌军主帅
					plist=FilterPerson("君主是",-1,	"排序","魅力",	"保留",200);
					p2=TableRandom(plist);
					
					--战场定义
					WarIni();
					DefineWarMap(5,"XXX救援战","一、击败？？？．",20,"主角",p2);
					--我军
					InsertWarPerson(0,"主角",21,22,"上",0,"我",true,"待机",0,0);
					SelectTeam(	22,21,"上",true,
								20,23,"上",true,
								22,23,"上",true,
								23,20,"上",true,
								19,24,"上",true,
								23,22,"上",true,
								21,24,"上",true,
								23,24,"上",true)
					
					--友军
					InsertWarPerson(1,p1,						20,13,"左",4,"友",false,"坚守",0,0);
					WarSetFlag(101,War.PersonNum);
					InsertWarPerson(1,GenPerson(true,p1,"谋将"),		20,14,"左",2,"友",false,"坚守",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"步将"),		20,12,"左",2,"友",false,"坚守",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"步兵队"),	19,13,"左",1,"友",false,"坚守",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"步兵队"),	19,14,"左",0,"友",false,"坚守",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"步兵队"),	19,12,"左",0,"友",false,"坚守",0,0);
					
					InsertWarPerson(1,GenPerson(true,p1,"步将"),		16,13,"左",2,"友",false,"坚守",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"弓兵队"),	16,12,"左",0,"友",false,"坚守",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"弓兵队"),	16,14,"左",0,"友",false,"坚守",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"弓兵队"),	17,13,"左",0,"友",false,"坚守",0,0);
					
					InsertWarPerson(2,GenPerson(true,p1,"步兵队"),	19,8,"上",0,"友",false,"坚守",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"步兵队"),	20,8,"上",-1,"友",false,"坚守",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"步兵队"),	19,17,"下",0,"友",false,"坚守",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"步兵队"),	20,17,"下",-1,"友",false,"坚守",0,0);
					
					InsertWarPerson(3,GenPerson(true,p1,"骑将"),		16,10,"下",3,"友",false,"坚守",0,0);
					InsertWarPerson(3,GenPerson(true,p1,"骑兵队"),	16,11,"下",2,"友",false,"坚守",0,0);
					InsertWarPerson(3,GenPerson(true,p1,"骑兵队"),	17,11,"下",2,"友",false,"坚守",0,0);
					
					--敌军
						--主将 & 本营
					InsertWarPerson(4,p2,						1,13,"右",5,"敌",false,"待机",-1,-1);
					WarSetFlag(111,War.PersonNum);
					InsertWarPerson(4,GenPerson(true,p2,"谋将"),		1,14,"右",3,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"武力"),		1,12,"右",3,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"骑兵队"),	1,15,"右",2,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"骑兵队"),	1,11,"右",2,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"弓兵队"),	2,13,"右",1,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"弓兵队"),	2,14,"右",1,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"弓兵队"),	2,12,"右",1,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"步兵队"),	2,15,"右",1,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"步兵队"),	2,11,"右",1,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"步兵队"),	3,13,"右",1,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"步兵队"),	3,14,"右",1,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"步兵队"),	3,12,"右",1,"敌",false,"待机",-1,-1);
					
						--前锋 中
					InsertWarPerson(5,GenPerson(true,p2,"万能"),		8,13,"右",3,"敌",false,"坚守",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"统率"),		8,12,"右",2,"敌",false,"坚守",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"智谋"),		8,14,"右",2,"敌",false,"坚守",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"骑兵队"),	9,13,"右",2,"敌",false,"坚守",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"骑兵队"),	9,14,"右",1,"敌",false,"坚守",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"骑兵队"),	9,12,"右",2,"敌",false,"坚守",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"步兵队"),	10,11,"右",1,"敌",false,"出击",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"步兵队"),	11,10,"右",1,"敌",false,"出击",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"步兵队"),	10,15,"右",1,"敌",false,"出击",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"步兵队"),	11,16,"右",1,"敌",false,"出击",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"弓兵队"),	9,11,"右",1,"敌",false,"出击",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"弓兵队"),	10,10,"右",1,"敌",false,"出击",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"弓兵队"),	9,15,"右",1,"敌",false,"出击",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"弓兵队"),	10,16,"右",1,"敌",false,"出击",17,13);
						--前锋 上
					InsertWarPerson(5,GenPerson(true,p2,"步兵队"),	18,3,"下",2,"敌",false,"出击",21,10);
					InsertWarPerson(5,GenPerson(true,p2,"弓兵队"),	17,4,"下",0,"敌",false,"出击",21,10);
					InsertWarPerson(5,GenPerson(true,p2,"弓兵队"),	19,2,"下",0,"敌",false,"出击",21,10);
						--前锋 下
					InsertWarPerson(5,GenPerson(true,p2,"步兵队"),	17,22,"上",2,"敌",false,"出击",21,16);
					InsertWarPerson(5,GenPerson(true,p2,"弓兵队"),	16,21,"上",1,"敌",false,"出击",21,16);
					InsertWarPerson(5,GenPerson(true,p2,"步兵队"),	18,23,"上",0,"敌",false,"出击",21,16);
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
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						if War.Turn==3 then
							WarShowTeamArmy(0);
							WarModifyTeamAI(5,"出击",0,0);
							WarShowTarget(true);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						--第2回合 友军AI修改，允许攻击
						if War.Turn==3 then
							WarModifyTeamAI(2,"待机",0,0);
							WarModifyTeamAI(3,"待机",0,0);
						end
						if War.Turn==6 then
							WarModifyTeamAI(1,"待机",0,0);
							WarModifyAI(WarGetFlag(101),"坚守",0,0);
						end
						--敌军未总攻，敌军数量少于7
						if War.PersonNumEnemy<7 and (not WarCheckFlag(1)) then
							WarSetFlag(1,1);	--友军反攻
							WarTalk(WarGetFlag(101),"形势逆转了[n]全军，反击！");
							WarModifyTeamAI(1,"出击",WarGetFlag(101),0);
							WarModifyTeamAI(2,"出击",WarGetFlag(101),0);
							WarModifyTeamAI(3,"出击",WarGetFlag(101),0);
							WarModifyAI(WarGetFlag(101),"出击",-1,-1)
						end
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						--前线作战不利
						if War.PersonNumEnemy<20 and (not WarCheckFlag(2)) then
							WarSetFlag(2,1);	--敌军总攻
							WarTalk(WarGetFlag(111),"前线部队居然陷入苦战！[n]全军出击，不能给敌人喘息之机！");
							WarModifyTeamAI(4,"出击",WarGetFlag(111),-1);
							WarModifyAI(WarGetFlag(111),"出击",-1,-1)
							WarModifyTeamAI(5,"出击",0,0);
						end
					end
				end,
			[1013]=function()
					--XXX救援战
					local p1,p2,p3,p4,p5,p6,p7,p8,p9,p10;
					local wid;
					local plist={};
					--被救援者
					plist=FilterPerson("君主是",-1,	"排序","政务",	"保留",200);
					p1=TableRandom(plist);
					--敌军主帅
					plist=FilterPerson("君主是",-1,	"排序","魅力",	"保留",200);
					p2=TableRandom(plist);
					
					--战场定义
					WarIni();
					DefineWarMap(9,"XXX救援战","一、击败？？？．",20,"主角",p2);
					--我军
					InsertWarPerson(0,"主角",3,2,"下",0,"我",false,"待机",0,0);
					SelectTeam(	5,2,"下",false,
								4,3,"下",false,
								2,3,"下",false,
								6,3,"下",false,
								7,2,"下",false,
								5,4,"下",false,
								3,4,"下",false,
								7,4,"下",false)
					
					--友军
					InsertWarPerson(1,p1,						20,13,"左",4,"友",false,"坚守",0,0);
					WarSetFlag(101,War.PersonNum);
					InsertWarPerson(1,GenPerson(true,p1,"谋将"),		20,14,"左",2,"友",false,"坚守",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"步将"),		20,12,"左",2,"友",false,"坚守",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"步兵队"),	19,13,"左",1,"友",false,"坚守",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"步兵队"),	19,14,"左",0,"友",false,"坚守",0,0);
					InsertWarPerson(1,GenPerson(true,p1,"步兵队"),	19,12,"左",0,"友",false,"坚守",0,0);
					
					InsertWarPerson(1,GenPerson(true,p1,"步将"),		16,13,"左",2,"友",false,"坚守",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"弓兵队"),	16,12,"左",0,"友",false,"坚守",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"弓兵队"),	16,14,"左",0,"友",false,"坚守",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"弓兵队"),	17,13,"左",0,"友",false,"坚守",0,0);
					
					InsertWarPerson(2,GenPerson(true,p1,"步兵队"),	19,8,"上",0,"友",false,"坚守",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"步兵队"),	20,8,"上",-1,"友",false,"坚守",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"步兵队"),	19,17,"下",0,"友",false,"坚守",0,0);
					InsertWarPerson(2,GenPerson(true,p1,"步兵队"),	20,17,"下",-1,"友",false,"坚守",0,0);
					
					InsertWarPerson(3,GenPerson(true,p1,"骑将"),		16,10,"下",3,"友",false,"坚守",0,0);
					InsertWarPerson(3,GenPerson(true,p1,"骑兵队"),	16,11,"下",2,"友",false,"坚守",0,0);
					InsertWarPerson(3,GenPerson(true,p1,"骑兵队"),	17,11,"下",2,"友",false,"坚守",0,0);
					
					--敌军
						--主将 & 本营
					InsertWarPerson(4,p2,						8,14,"右",5,"敌",false,"待机",-1,-1);
					WarSetFlag(111,War.PersonNum);
					InsertWarPerson(4,GenPerson(true,p2,"谋将"),		8,15,"右",3,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"武力"),		8,13,"右",3,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"步兵队"),	7,14,"右",1,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"弓兵队"),	9,14,"右",1,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"弓兵队"),	9,15,"右",1,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"弓兵队"),	9,13,"右",1,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"步兵队"),	10,15,"右",1,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"步兵队"),	10,13,"右",1,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"步兵队"),	10,16,"右",1,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"步兵队"),	10,12,"右",1,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"骑兵队"),	11,16,"右",2,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"骑兵队"),	11,12,"右",2,"敌",false,"待机",-1,-1);
					
						--中军
					InsertWarPerson(5,GenPerson(true,p2,"骑将"),		16,16,"上",3,"敌",false,"待机",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"骑兵队"),	15,17,"上",0,"敌",false,"待机",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"骑兵队"),	15,18,"上",0,"敌",false,"待机",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"骑兵队"),	17,17,"上",1,"敌",false,"待机",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"骑兵队"),	17,18,"上",1,"敌",false,"待机",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"弓将"),		16,15,"上",2,"敌",false,"待机",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"弓兵队"),	15,15,"上",1,"敌",false,"待机",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"弓兵队"),	17,15,"上",1,"敌",false,"待机",17,13);
					InsertWarPerson(5,GenPerson(true,p2,"弓兵队"),	16,14,"上",1,"敌",false,"待机",17,13);
						--前锋
					InsertWarPerson(6,GenPerson(true,p2,"步将"),		19,7,"上",3,"敌",false,"坚守",21,10);
					InsertWarPerson(6,GenPerson(true,p2,"步兵队"),	17,5,"上",1,"敌",false,"待机",21,10);
					InsertWarPerson(6,GenPerson(true,p2,"步兵队"),	19,5,"上",1,"敌",false,"待机",21,16);
					InsertWarPerson(6,GenPerson(true,p2,"贼兵"),		12,2,"右",1,"敌",false,"坚守",21,16);
					InsertWarPerson(6,GenPerson(true,p2,"贼兵"),		13,4,"右",1,"敌",false,"坚守",21,16);
					InsertWarPerson(6,GenPerson(RND(0.5),p2,"弓兵队","步兵队"),	18,6,"上",2,"敌",false,"待机",21,10);
					InsertWarPerson(6,GenPerson(RND(0.5),p2,"弓兵队","步兵队"),	20,6,"上",1,"敌",false,"待机",21,16);
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
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(2)) and WarCheckArea(-1,1,10,12,20) then
							WarSetFlag(2,1);
							WarTalk(WarGetFlag(111),"可恶，居然让敌人杀到这里来了！");
							WarModifyTeamAI(4,"出击",0,0);
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						--第2回合 友军AI修改，允许攻击
						if War.Turn==2 then
							WarModifyTeamAI(1,"待机",0,0);
						end
						--敌军未总攻，敌军数量少于7
						if War.PersonNumEnemy<10 and (not WarCheckFlag(1)) then
							WarSetFlag(1,1);	--友军反攻
							WarTalk(WarGetFlag(101),"形势逆转了[n]全军，反击！");
							WarModifyTeamAI(1,"出击",WarGetFlag(101),0);
							WarModifyAI(WarGetFlag(101),"出击",-1,-1)
						end
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==2 then
							WarModifyTeamAI(6,"待机",0,0);
							WarModifyTeamAI(5,"出击",19,7);
						end
						if War.Turn==5 then
							WarModifyTeamAI(6,"出击",0,0);
							WarModifyTeamAI(5,"出击",0,0);
						end
						if (not WarCheckFlag(2)) and War.Turn==8 then
							WarSetFlag(2,2);
							WarModifyTeamAI(4,"出击",0,0);
						end
					end
				end,
			[1016]=function()
					--XXX救援战
					local p1,p2,p3,p4,p5,p6,p7,p8,p9,p10;
					local wid;
					local plist={};
					--被救援者
					plist=FilterPerson("君主是",-1,	"排序","福源",	"保留",200);
					p1=TableRandom(plist);
					--敌军主帅
					plist=FilterPerson("君主是",-1,	"排序","统率",	"保留",200);
					p2=TableRandom(plist);
					
					--战场定义
					WarIni();
					DefineWarMap(10,"XXX救援战","一、击败？？？．",20,"主角",p2);
					--我军
					InsertWarPerson(0,"主角",1,10,"右",0,"我",false,"待机",0,0);
					SelectTeam(	1,9,"右",false,
								1,11,"右",false,
								1,8,"右",false,
								1,12,"右",false,
								1,7,"右",false,
								1,13,"右",false,
								1,6,"右",false,
								1,14,"右",false)
					
					--友军
					InsertWarPerson(1,p1,								13,9,"下",4,"友",false,"坚守",0,0);
					WarSetFlag(101,War.PersonNum);
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"弓将"),	12,9,"下",2,"友",false,"坚守",0,0);
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"武力"),	13,10,"下",2,"友",false,"坚守",0,0);
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"骑兵队"),		14,9,"下",-1,"友",false,"坚守",0,0);
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"步兵队","弓兵队"),	12,10,"下",0,"友",false,"坚守",0,0);
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"步兵队"),	14,10,"下",-1,"友",false,"坚守",0,0);
					
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"武力"),	11,9,"左",2,"友",false,"出击",10,9);
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"骑兵队"),		11,8,"左",-1,"友",false,"出击",10,8);
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"骑兵队","步兵队"),	11,10,"左",0,"友",false,"出击",10,10);
					
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"统率"),	15,9,"右",2,"友",false,"出击",19,10);
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"步兵队"),		15,8,"右",-1,"友",false,"出击",19,9);
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"步兵队","弓兵队"),	15,10,"右",0,"友",false,"出击",19,11);
					
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"万能"),	13,11,"下",2,"友",false,"出击",15,12);
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"贼兵"),		12,11,"下",-1,"友",false,"出击",14,12);
					InsertWarPerson(1,GenPerson(RND(0.7),p1,"贼兵","步兵队"),	14,11,"下",0,"友",false,"出击",16,12);
					
					--敌军
						--主将 & 本营
					InsertWarPerson(4,p2,						15,20,"上",5,"敌",false,"待机",-1,-1);
					WarSetFlag(111,War.PersonNum);
					InsertWarPerson(4,GenPerson(true,p2,"武力"),		14,20,"上",3,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"武力"),		16,20,"上",3,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"步兵队"),	13,18,"上",1,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"步兵队"),	14,18,"上",0,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"步兵队"),	15,18,"上",-1,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"步兵队"),	16,18,"上",1,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"步兵队"),	17,18,"上",0,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"弓兵队"),	13,20,"上",0,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"弓兵队"),	17,20,"上",0,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"骑兵队"),	13,19,"上",1,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"骑兵队"),	14,19,"上",1,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"骑将"),	15,19,"上",2,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"骑兵队"),	16,19,"上",0,"敌",false,"待机",-1,-1);
					InsertWarPerson(4,GenPerson(true,p2,"骑兵队"),	17,19,"上",0,"敌",false,"待机",-1,-1);
					
					InsertWarPerson(4,GenPerson(true,p2,"骑兵队"),	11,15,"右",2,"敌",false,"出击",15,12);
					InsertWarPerson(4,GenPerson(true,p2,"步兵队"),	11,16,"右",0,"敌",false,"出击",15,12);
					InsertWarPerson(4,GenPerson(true,p2,"弓兵队"),	11,17,"右",1,"敌",false,"出击",15,12);
					InsertWarPerson(4,GenPerson(true,p2,"骑兵队"),	18,15,"左",2,"敌",false,"出击",15,12);
					InsertWarPerson(4,GenPerson(true,p2,"步兵队"),	18,16,"左",0,"敌",false,"出击",15,12);
					InsertWarPerson(4,GenPerson(true,p2,"弓兵队"),	18,17,"左",1,"敌",false,"出击",15,12);
					
						--左
					InsertWarPerson(5,GenPerson(true,p2,"贼将"),	8,19,"上",3,"敌",false,"出击",8,10);
					InsertWarPerson(5,GenPerson(true,p2,"贼兵"),	8,18,"上",2,"敌",false,"出击",8,10);
					InsertWarPerson(5,GenPerson(true,p2,"贼兵"),	7,19,"上",1,"敌",false,"出击",8,10);
					InsertWarPerson(5,GenPerson(true,p2,"贼兵"),	9,19,"上",1,"敌",false,"出击",8,10);
					InsertWarPerson(5,GenPerson(0.5,p2,"弓兵队"),	6,20,"上",1,"敌",false,"出击",8,10);
					InsertWarPerson(5,GenPerson(0.7,p2,"弓兵队"),	7,20,"上",0,"敌",false,"出击",8,10);
					InsertWarPerson(5,GenPerson(true,p2,"步兵队"),	8,20,"上",1,"敌",false,"出击",8,10);
					InsertWarPerson(5,GenPerson(true,p2,"步兵队"),	9,20,"上",-1,"敌",false,"出击",8,10);
					InsertWarPerson(5,GenPerson(true,p2,"弓兵队"),	10,20,"上",-1,"敌",false,"出击",8,10);
						--右
					InsertWarPerson(6,GenPerson(true,p2,"万能"),		22,18,"上",3,"敌",false,"出击",22,9);
					InsertWarPerson(6,GenPerson(true,p2,"步兵队"),		21,18,"上",2,"敌",false,"出击",22,9);
					InsertWarPerson(6,GenPerson(true,p2,"步兵队"),		21,19,"上",-1,"敌",false,"出击",22,9);
					InsertWarPerson(6,GenPerson(true,p2,"贼兵"),		20,19,"上",1,"敌",false,"出击",22,9);
					InsertWarPerson(6,GenPerson(true,p2,"贼兵"),		20,20,"上",-1,"敌",false,"出击",22,9);
					InsertWarPerson(6,GenPerson(RND(0.5),p2,"弓兵队","步兵队"),	19,20,"上",0,"敌",false,"出击",22,9);
					InsertWarPerson(6,GenPerson(RND(0.5),p2,"弓兵队","步兵队"),	21,20,"上",1,"敌",false,"出击",22,9);
						--援军
					InsertWarPerson(7,GenPerson(true,p2,"智谋"),		21,2,"左",3,"敌",true,"出击",14,7);
					InsertWarPerson(7,GenPerson(true,p2,"步兵队"),		19,1,"左",1,"敌",true,"出击",14,7);
					InsertWarPerson(7,GenPerson(true,p2,"步兵队"),		20,2,"左",0,"敌",true,"出击",14,7);
					InsertWarPerson(7,GenPerson(true,p2,"贼兵"),		21,3,"左",0,"敌",true,"出击",14,7);
					InsertWarPerson(7,GenPerson(true,p2,"贼兵"),		20,1,"左",1,"敌",true,"出击",14,7);
					InsertWarPerson(7,GenPerson(RND(0.5),p2,"骑兵队","弓兵队"),	22,3,"左",1,"敌",true,"出击",14,7);
					InsertWarPerson(7,GenPerson(RND(0.5),p2,"骑兵队","弓兵队"),	22,4,"左",1,"敌",true,"出击",14,7);
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
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(2)) and WarCheckArea(-1,8,17,21,20) then
							WarSetFlag(2,1);
							WarTalk(WarGetFlag(111),"可恶，居然让敌人杀到这里来了！");
							WarModifyTeamAI(4,"出击",0,0);
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						--第2回合 友军AI修改，允许攻击
						if War.Turn==4 then
							WarModifyTeamAI(1,"待机",0,0);
						end
						--敌军未总攻，敌军数量少于7
						if War.PersonNumEnemy<10 and (not WarCheckFlag(1)) then
							WarSetFlag(1,1);	--友军反攻
							WarTalk(WarGetFlag(101),"形势逆转了[n]全军，反击！");
							WarModifyTeamAI(1,"出击",WarGetFlag(101),0);
							WarModifyAI(WarGetFlag(101),"出击",-1,-1)
						end
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==3 then
							WarTalk(WarGetFlag(111),"哈哈，援军来啦！");
							WarShowTeamArmy(7);
							WarTeamAI(7);
						end
						if (not WarCheckFlag(2)) and War.Turn==7 then
							WarSetFlag(2,2);
							WarTalk(WarGetFlag(111),"全军，出击！");
							WarModifyTeamAI(4,"出击",0,0);
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
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(5,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军
					--InsertWarPerson(0,0,1,13,"右",0,"我",false,"待机",0,0);
					SelectTeam(	1,13,"右",false,
								2,14,"右",false,
								2,12,"右",false,
								1,11,"右",false,
								1,15,"右",false,
								2,16,"右",false,
								2,10,"右",false,
								1,9,"右",false,
								1,17,"右",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,20,13,"左","敌",false,"帅",1,"待机",0,0);
						InsertWarTeam(2,p,16,13,"左","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(3,p,19,8,"上","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(4,p,20,17,"下","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(5,p,17,10,"左","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(6,p,17,15,"左","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(7,p,22,10,"左","敌",false,"文",1,"坚守",0,0);
						InsertWarTeam(8,p,22,15,"左","敌",false,"文",1,"坚守",0,0);
						InsertWarTeam(9,p,18,12,"左","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(10,p,21,5,"左","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(11,p,21,20,"左","敌",false,"武",1,"坚守",0,0);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,20,13,"左","敌",false,"帅",1,"待机",0,0);
						InsertWarTeam(2,p,16,13,"左","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(3,p,19,8,"上","敌",false,"文",1,"出击",13,6);
						InsertWarTeam(4,p,20,17,"下","敌",false,"文",1,"出击",13,19);
						InsertWarTeam(5,p,14,13,"左","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(6,p,18,3,"左","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(7,p,17,22,"左","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(8,p,13,9,"左","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(9,p,13,16,"左","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(10,p,18,11,"左","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(11,p,18,15,"左","敌",false,"武",1,"出击",0,0);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2053);
					end
				end,
			[2052]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(51)) and WarCheckArea(-1,13,10,16,15) then	--敌人进入前方区域
							WarSetFlag(51,1);
							WarModifyTeamAI(2,"出击",16,13);
							WarModifyTeamAI(5,"出击",16,13);
							WarModifyTeamAI(6,"出击",16,13);
							WarModifyTeamAI(9,"出击",16,13);
						end
						if (not WarCheckFlag(52)) and WarCheckArea(-1,17,3,24,7) then	--敌人进入上方区域
							WarSetFlag(52,1);
							WarModifyTeamAI(3,"出击",19,8);
							WarModifyTeamAI(7,"出击",19,8);
							WarModifyTeamAI(10,"出击",19,8);
						end
						if (not WarCheckFlag(53)) and WarCheckArea(-1,17,18,24,22) then	--敌人进入下方区域
							WarSetFlag(53,1);
							WarModifyTeamAI(4,"出击",19,17);
							WarModifyTeamAI(8,"出击",19,17);
							WarModifyTeamAI(11,"出击",19,17);
						end
						if (not WarCheckFlag(54)) and WarCheckArea(-1,16,8,22,17) then	--敌人进入城内
							WarSetFlag(54,1);WarSetFlag(51,1);WarSetFlag(52,1);WarSetFlag(53,1);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2053]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==2 then
							WarModifyTeamAI(3,"出击",0,0);
							WarModifyTeamAI(4,"出击",0,0);
						end
						if War.Turn==3 then
							WarModifyTeamAI(1,"出击",0,0);
						end
					end
				end,
				
			[2060]=function()
					local wid;
					local p={};
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(6,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军
					--InsertWarPerson(0,0,1,13,"右",0,"我",false,"待机",0,0);
					SelectTeam(	4,2,"右",false,
								3,3,"右",false,
								6,2,"右",false,
								5,3,"右",false,
								4,4,"右",false,
								7,3,"右",false,
								6,4,"右",false,
								5,5,"右",false,
								4,6,"右",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,20,18,"上","敌",false,"帅",1,"待机",0,0);
						InsertWarTeam(2,p,22,18,"上","敌",false,"文",1,"坚守",0,0);
						InsertWarTeam(3,p,16,18,"左","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(4,p,21,14,"上","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(5,p,12,20,"上","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(6,p,23,10,"左","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(7,p,12,15,"下","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(8,p,18,10,"右","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(9,p,20,21,"下","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(10,p,25,18,"右","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(11,p,5,17,"上","敌",false,"武",1,"移动",14,19);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,20,18,"上","敌",false,"帅",1,"待机",0,0);
						InsertWarTeam(2,p,22,18,"上","敌",false,"文",1,"待机",0,0);
						InsertWarTeam(3,p,15,18,"左","敌",false,"文",1,"出击",0,0);
						InsertWarTeam(4,p,21,13,"上","敌",false,"文",1,"出击",0,0);
						InsertWarTeam(5,p,13,16,"左","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(6,p,19,11,"上","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(7,p,13,19,"左","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(8,p,22,11,"上","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(9,p,11,18,"左","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(10,p,21,9,"上","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(11,p,5,17,"上","敌",false,"武",1,"坚守",0,0);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2063);
					end
				end,
			[2062]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(51)) and WarCheckArea(-1,14,8,28,13) then	--敌人进入上方区域
							WarSetFlag(51,1);
							WarModifyTeamAI(4,"出击",20,12);
							WarModifyTeamAI(6,"出击",21,10);
							WarModifyTeamAI(8,"出击",20,11);
							WarModifyTeamAI(10,"出击",21,14);
						end
						if (not WarCheckFlag(52)) and WarCheckArea(-1,10,12,15,24) then	--敌人进入下方区域
							WarSetFlag(52,1);
							WarModifyTeamAI(3,"出击",14,18);
							WarModifyTeamAI(5,"出击",12,18);
							WarModifyTeamAI(7,"出击",13,17);
							WarModifyTeamAI(9,"出击",16,18);
							WarModifyTeamAI(11,"出击",14,19);
						end
						if (not WarCheckFlag(54)) and WarCheckArea(-1,14,12,28,24) then	--敌人进入城内
							WarSetFlag(54,1);WarSetFlag(51,1);WarSetFlag(52,1);
							WarModifyTeamAI(1,"出击",20,18);
							WarModifyTeamAI(2,"出击",20,18);
							for i=3,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2063]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==2 then
							WarModifyTeamAI(11,"出击",0,0);
						end
						if War.Turn==3 then
							WarModifyTeamAI(1,"出击",0,0);
							WarModifyTeamAI(2,"出击",0,0);
						end
					end
				end,
				
			[2080]=function()
					local wid;
					local p={};
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(8,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军
					--InsertWarPerson(0,0,1,13,"右",0,"我",false,"待机",0,0);
					SelectTeam(	2,22,"右",false,
								3,23,"右",false,
								2,20,"右",false,
								3,21,"右",false,
								4,22,"右",false,
								5,23,"右",false,
								4,20,"右",false,
								5,21,"右",false,
								6,22,"右",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,20,4,"下","敌",false,"帅",1,"待机",0,0);
						InsertWarTeam(2,p,21,3,"下","敌",false,"文",1,"坚守",0,0);
						InsertWarTeam(3,p,17,3,"左","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(4,p,21,6,"下","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(5,p,15,5,"左","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(6,p,19,8,"下","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(7,p,13,2,"左","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(8,p,22,9,"下","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(9,p,12,5,"左","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(10,p,21,11,"下","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(11,p,15,8,"下","敌",false,"武",1,"待机",0,0);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,20,4,"下","敌",false,"帅",1,"待机",0,0);
						InsertWarTeam(2,p,21,3,"下","敌",false,"文",1,"待机",0,0);
						InsertWarTeam(3,p,5,3,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(4,p,4,5,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(5,p,6,5,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(6,p,19,8,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(7,p,22,8,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(8,p,20,11,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(9,p,21,13,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(10,p,4,2,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(11,p,6,2,"下","敌",false,"武",1,"出击",0,0);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2083);
					end
				end,
			[2082]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(51)) and WarCheckArea(-1,9,1,15,9) then	--敌人进入上方区域
							WarSetFlag(51,1);
							WarModifyTeamAI(3,"出击",14,3);
							WarModifyTeamAI(5,"出击",13,5);
							WarModifyTeamAI(7,"出击",13,3);
							WarModifyTeamAI(9,"出击",12,4);
						end
						if (not WarCheckFlag(52)) and WarCheckArea(-1,9,8,24,14) then	--敌人进入下方区域
							WarSetFlag(52,1);
							WarModifyTeamAI(4,"出击",21,9);
							WarModifyTeamAI(6,"出击",20,10);
							WarModifyTeamAI(8,"出击",21,11);
							WarModifyTeamAI(10,"出击",20,11);
						end
						if (not WarCheckFlag(54)) and WarCheckArea(-1,14,1,14,9) then	--敌人进入城内
							WarSetFlag(54,1);WarSetFlag(51,1);WarSetFlag(52,1);
							WarModifyTeamAI(1,"出击",20,18);
							WarModifyTeamAI(2,"出击",20,18);
							for i=3,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2083]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==3 then
							WarModifyTeamAI(1,"出击",0,0);
							WarModifyTeamAI(2,"出击",0,0);
						end
					end
				end,
				
			[2100]=function()
					local wid;
					local p={};
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(10,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军
					SelectTeam(	14,19,"上",false,
								16,19,"上",false,
								15,20,"上",false,
								13,20,"上",false,
								17,20,"上",false,
								12,19,"上",false,
								11,20,"上",false,
								18,19,"上",false,
								19,20,"上",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,13,9,"下","敌",false,"帅",1,"坚守",0,0);
						InsertWarTeam(2,p,14,13,"下","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(3,p,16,9,"下","敌",false,"文",1,"警戒",0,0);
						InsertWarTeam(4,p,10,9,"左","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(5,p,19,9,"右","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(6,p,13,11,"下","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(7,p,16,11,"下","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(8,p,12,7,"下","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(9,p,17,7,"下","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(10,p,11,12,"下","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(11,p,18,12,"下","敌",false,"武",2,"警戒",0,0);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,13,9,"下","敌",false,"帅",1,"待机",0,0);
						InsertWarTeam(2,p,14,13,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(3,p,16,9,"下","敌",false,"文",2,"待机",0,0);
						InsertWarTeam(4,p,7,9,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(5,p,22,9,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(6,p,12,15,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(7,p,17,15,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(8,p,11,10,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(9,p,19,10,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(10,p,11,12,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(11,p,18,12,"下","敌",false,"武",1,"出击",0,0);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2103);
					end
				end,
			[2102]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(54)) and WarCheckArea(-1,9,6,20,13) then	--敌人进入城内
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"警戒",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2103]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==3 then
							WarModifyTeamAI(1,"出击",0,0);
							WarModifyTeamAI(3,"出击",0,0);
						end
					end
				end,
				
			[2110]=function()
					local wid;
					local p={};
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid)*100;
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(11,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军
					SelectTeam(	13,2,"下",false,
								15,2,"下",false,
								11,2,"下",false,
								17,2,"下",false,
								14,1,"下",false,
								12,1,"下",false,
								16,1,"下",false,
								18,1,"下",false,
								10,1,"下",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					enpcnum=1110;
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,13,13,"上","敌",false,"帅",1,"坚守",0,0);
						InsertWarTeam(2,p,11,9,"上","敌",false,"武",3,"警戒",0,0);
						InsertWarTeam(3,p,11,13,"左","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(4,p,15,13,"右","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(5,p,9,9,"上","敌",false,"武",3,"警戒",0,0);
						InsertWarTeam(6,p,17,9,"上","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(7,p,9,11,"上","敌",false,"武",3,"警戒",0,0);
						InsertWarTeam(8,p,9,15,"上","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(9,p,17,12,"上","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(10,p,12,17,"上","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(11,p,17,16,"上","敌",false,"武",2,"警戒",0,0);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,13,13,"上","敌",false,"帅",1,"待机",0,0);
						InsertWarTeam(2,p,11,9,"上","敌",false,"武",3,"警戒",0,0);
						InsertWarTeam(3,p,11,13,"左","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(4,p,15,13,"右","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(5,p,9,9,"上","敌",false,"武",3,"出击",0,0);
						InsertWarTeam(6,p,17,9,"上","敌",false,"武",2,"出击",0,0);
						InsertWarTeam(7,p,17,13,"右","敌",false,"武",3,"出击",0,0);
						InsertWarTeam(8,p,19,14,"右","敌",false,"武",2,"出击",0,0);
						InsertWarTeam(9,p,22,13,"上","敌",false,"武",2,"出击",0,0);
						InsertWarTeam(10,p,8,13,"上","敌",false,"武",2,"出击",0,0);
						InsertWarTeam(11,p,16,17,"上","敌",false,"武",2,"出击",0,0);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2113);
					end
				end,
			[2112]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(54)) and WarCheckArea(-1,9,9,17,17) then	--敌人进入城内
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"警戒",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2113]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==3 then
							WarModifyTeamAI(1,"出击",0,0);
							WarModifyTeamAI(2,"出击",0,0);
							WarModifyTeamAI(3,"出击",0,0);
						end
					end
				end,
				
			[2120]=function()
					local wid;
					local p={};
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(12,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军
					SelectTeam(	27,3,"左",false,
								27,5,"左",false,
								26,4,"左",false,
								25,5,"左",false,
								24,4,"左",false,
								24,6,"左",false,
								23,5,"左",false,
								23,7,"左",false,
								22,6,"左",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					-- 1 normal; 2弓箭; 3 水战; 4 贼兵; 5 骑兵
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,1,10,"右","敌",false,"帅",1,"坚守",0,0);
						InsertWarTeam(2,p,3,10,"右","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(3,p,7,11,"右","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(4,p,6,4,"右","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(5,p,6,17,"右","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(6,p,5,4,"右","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(7,p,5,17,"右","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(8,p,17,5,"下","敌",true,"武",4,"出击",0,0);
						InsertWarTeam(9,p,16,12,"上","敌",true,"武",4,"出击",0,0);
						InsertWarTeam(10,p,14,3,"下","敌",true,"武",4,"出击",0,0);
						InsertWarTeam(11,p,15,14,"上","敌",true,"武",4,"出击",0,0);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,1,10,"右","敌",false,"帅",1,"警戒",0,0);
						InsertWarTeam(2,p,3,10,"右","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(3,p,7,11,"右","敌",false,"武",5,"出击",0,0);
						InsertWarTeam(4,p,6,4,"右","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(5,p,6,17,"右","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(6,p,5,4,"右","敌",false,"文",2,"出击",0,0);
						InsertWarTeam(7,p,5,17,"右","敌",false,"文",2,"出击",0,0);
						InsertWarTeam(8,p,2,7,"右","敌",false,"武",5,"出击",0,0);
						InsertWarTeam(9,p,2,14,"右","敌",false,"武",5,"出击",0,0);
						InsertWarTeam(10,p,3,8,"右","敌",false,"武",4,"出击",0,0);
						InsertWarTeam(11,p,3,12,"右","敌",false,"武",4,"出击",0,0);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2123);
					end
				end,
			[2122]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(51)) and WarCheckArea(-1,1,1,11,20) then	--敌人接近城门，伏兵出现
							WarSetFlag(51,1);
							WarSetFlag(52,1);
						end
						if (not WarCheckFlag(54)) and WarCheckArea(-1,1,1,7,20) then	--敌人进入城内
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"警戒",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
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
									if pid>0 and JY.Person[pid]["台词"]>=0 then
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
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2123]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"出击",0,0);
						end
					end
				end,
				 
			[2130]=function()
					local wid;
					local p={};
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(13,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军
					SelectTeam(	3,3,"右",false,
								4,2,"右",false,
								2,4,"右",false,
								2,2,"右",false,
								5,3,"右",false,
								4,4,"右",false,
								3,5,"右",false,
								2,6,"右",false,
								6,2,"右",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,20,26,"左","敌",false,"帅",1,"坚守",0,0);
						InsertWarTeam(2,p,11,26,"上","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(3,p,20,23,"左","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(4,p,15,27,"上","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(5,p,12,6,"上","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(6,p,12,8,"上","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(7,p,11,15,"左","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(8,p,13,20,"左","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(9,p,5,23,"上","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(10,p,7,19,"左","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(11,p,17,11,"左","敌",false,"武",1,"警戒",0,0);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,20,26,"左","敌",false,"帅",1,"警戒",0,0);
						InsertWarTeam(2,p,11,26,"上","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(3,p,20,23,"左","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(4,p,15,27,"上","敌",false,"文",2,"出击",0,0);
						InsertWarTeam(5,p,12,6,"上","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(6,p,12,8,"上","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(7,p,11,15,"左","敌",false,"武",4,"出击",0,0);
						InsertWarTeam(8,p,13,20,"左","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(9,p,5,23,"上","敌",false,"武",4,"出击",0,0);
						InsertWarTeam(10,p,7,19,"左","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(11,p,17,11,"左","敌",false,"武",1,"出击",0,0);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2133);
					end
				end,
			[2132]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(54)) and WarCheckArea(-1,8,22,20,28) then	--敌人进入城内
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"警戒",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2133]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==2 then
							WarModifyTeamAI(2,"出击",0,0);
							WarModifyTeamAI(3,"出击",0,0);
						end
						if War.Turn==3 then
							WarModifyTeamAI(6,"出击",0,0);
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"出击",0,0);
							WarModifyTeamAI(5,"出击",0,0);
						end
					end
				end,
				
			[2140]=function()
					local wid;
					local p={};
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(14,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军
					SelectTeam(	27,3,"左",false,
								26,2,"左",false,
								28,4,"左",false,
								25,3,"左",false,
								26,4,"左",false,
								24,2,"左",false,
								27,5,"左",false,
								28,6,"左",false,
								25,1,"左",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,14,17,"上","敌",false,"帅",1,"坚守",0,0);
						InsertWarTeam(2,p,14,12,"上","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(3,p,20,17,"右","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(4,p,16,17,"上","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(5,p,14,15,"上","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(6,p,9,17,"左","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(7,p,14,21,"下","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(8,p,17,13,"上","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(9,p,19,14,"右","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(10,p,11,13,"上","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(11,p,19,19,"右","敌",false,"武",2,"警戒",0,0);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,14,17,"上","敌",false,"帅",1,"警戒",0,0);
						InsertWarTeam(2,p,14,12,"上","敌",false,"武",5,"出击",19,3);
						InsertWarTeam(3,p,20,17,"右","敌",false,"武",5,"出击",27,9);
						InsertWarTeam(4,p,16,17,"上","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(5,p,14,15,"上","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(6,p,9,17,"左","敌",false,"武",1,"出击",19,3);
						InsertWarTeam(7,p,14,21,"下","敌",false,"武",1,"出击",27,9);
						InsertWarTeam(8,p,17,13,"上","敌",false,"武",5,"出击",19,3);
						InsertWarTeam(9,p,19,14,"右","敌",false,"武",5,"出击",27,9);
						InsertWarTeam(10,p,11,13,"上","敌",false,"武",2,"出击",19,3);
						InsertWarTeam(11,p,19,19,"右","敌",false,"武",2,"出击",27,9);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2143);
					end
				end,
			[2142]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(54)) and WarCheckArea(-1,9,12,20,21) then	--敌人进入城内
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"警戒",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2143]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"出击",0,0);
						end
					end
				end,
				
			[2160]=function()
					local wid;
					local p={};
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(16,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军
					SelectTeam(	5,5,"右",false,
								6,4,"右",false,
								4,6,"右",false,
								6,6,"右",false,
								7,5,"右",false,
								5,7,"右",false,
								8,4,"右",false,
								4,8,"右",false,
								7,3,"右",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					-- 1 normal; 2弓箭; 3 水战; 4 贼兵; 5 骑兵
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,18,19,"上","敌",false,"帅",1,"坚守",0,0);
						InsertWarTeam(2,p,10,15,"左","敌",false,"武",5,"坚守",0,0);
						InsertWarTeam(3,p,17,10,"上","敌",false,"武",5,"坚守",0,0);
						InsertWarTeam(4,p,17,17,"上","敌",false,"文",1,"警戒",0,0);
						InsertWarTeam(5,p,16,20,"上","敌",false,"文",1,"警戒",0,0);
						InsertWarTeam(6,p,10,17,"左","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(7,p,15,10,"上","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(8,p,11,13,"左","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(9,p,19,11,"上","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(10,p,13,16,"左","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(11,p,17,13,"上","敌",false,"武",2,"警戒",0,0);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,18,19,"上","敌",false,"帅",1,"警戒",0,0);
						InsertWarTeam(2,p,10,15,"左","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(3,p,17,10,"上","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(4,p,17,17,"上","敌",false,"文",1,"警戒",0,0);
						InsertWarTeam(5,p,16,20,"上","敌",false,"文",1,"警戒",0,0);
						InsertWarTeam(6,p,10,17,"左","敌",false,"武",2,"出击",0,0);
						InsertWarTeam(7,p,15,10,"上","敌",false,"武",2,"出击",0,0);
						InsertWarTeam(8,p,11,13,"左","敌",false,"武",4,"出击",0,0);
						InsertWarTeam(9,p,19,11,"上","敌",false,"武",5,"出击",0,0);
						InsertWarTeam(10,p,13,16,"左","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(11,p,17,13,"上","敌",false,"武",2,"出击",0,0);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2163);
					end
				end,
			[2162]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(54)) and WarCheckArea(-1,12,11,20,20) then	--敌人进入城内
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"警戒",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2163]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"出击",0,0);
						end
					end
				end,
				
			[2170]=function()
					local wid;
					local p={};
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(17,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军
					SelectTeam(	7,3,"下",false,
								5,3,"下",false,
								9,3,"下",false,
								6,4,"下",false,
								8,4,"下",false,
								4,4,"下",false,
								10,4,"下",false,
								6,2,"下",false,
								8,2,"下",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					-- 1 normal; 2弓箭; 3 水战; 4 贼兵; 5 骑兵
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,12,22,"上","敌",false,"帅",1,"坚守",0,0);
						InsertWarTeam(2,p,5,17,"上","敌",false,"武",5,"坚守",0,0);
						InsertWarTeam(3,p,18,11,"上","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(4,p,12,23,"上","敌",false,"文",5,"警戒",0,0);
						InsertWarTeam(5,p,15,12,"上","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(6,p,21,13,"上","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(7,p,3,19,"上","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(8,p,5,21,"上","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(9,p,12,18,"上","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(10,p,10,21,"上","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(11,p,14,21,"上","敌",false,"文",2,"警戒",0,0);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,12,22,"上","敌",false,"帅",1,"警戒",0,0);
						InsertWarTeam(2,p,5,17,"上","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(3,p,18,11,"上","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(4,p,12,23,"上","敌",false,"文",5,"警戒",0,0);
						InsertWarTeam(5,p,15,12,"上","敌",false,"武",2,"出击",0,0);
						InsertWarTeam(6,p,21,13,"上","敌",false,"武",4,"出击",0,0);
						InsertWarTeam(7,p,3,19,"上","敌",false,"武",2,"出击",0,0);
						InsertWarTeam(8,p,5,21,"上","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(9,p,12,18,"上","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(10,p,10,21,"上","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(11,p,14,21,"上","敌",false,"文",2,"警戒",0,0);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2173);
					end
				end,
			[2172]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(54)) and WarCheckArea(-1,6,17,18,24) then	--敌人进入城内
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"警戒",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2173]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"出击",0,0);
						end
					end
				end,
				
			[2200]=function()
					local wid;
					local p={};
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(20,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军
					SelectTeam(	13,2,"下",false,
								12,1,"下",false,
								14,1,"下",false,
								12,3,"下",false,
								14,3,"下",false,
								11,2,"下",false,
								15,2,"下",false,
								10,1,"下",false,
								16,1,"下",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					-- 1 normal; 2弓箭; 3 水战; 4 贼兵; 5 骑兵
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,2,25,"上","敌",false,"帅",1,"坚守",0,0);
						InsertWarTeam(2,p,3,26,"右","敌",false,"文",2,"坚守",0,0);
						InsertWarTeam(3,p,3,23,"上","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(4,p,5,25,"上","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(5,p,14,14,"上","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(6,p,9,16,"上","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(7,p,10,12,"上","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(8,p,18,14,"上","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(9,p,5,20,"上","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(10,p,2,16,"上","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(11,p,12,22,"右","敌",false,"武",2,"警戒",0,0);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,2,25,"上","敌",false,"帅",1,"警戒",0,0);
						InsertWarTeam(2,p,3,26,"右","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(3,p,3,23,"上","敌",false,"武",5,"出击",0,0);
						InsertWarTeam(4,p,5,25,"上","敌",false,"武",5,"出击",0,0);
						InsertWarTeam(5,p,14,14,"上","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(6,p,9,16,"上","敌",false,"武",4,"出击",0,0);
						InsertWarTeam(7,p,10,12,"上","敌",false,"武",4,"出击",0,0);
						InsertWarTeam(8,p,18,14,"上","敌",false,"武",4,"出击",0,0);
						InsertWarTeam(9,p,5,20,"上","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(10,p,2,16,"上","敌",false,"武",4,"出击",0,0);
						InsertWarTeam(11,p,12,22,"右","敌",false,"武",2,"出击",0,0);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2203);
					end
				end,
			[2202]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(54)) and WarCheckArea(-1,1,16,13,28) then	--敌人进入城内
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"警戒",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2203]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"出击",0,0);
						end
					end
				end,
				
			[2220]=function()
					local wid;
					local p={};
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(22,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军
					SelectTeam(	31,10,"下",false,
								30,9,"下",false,
								32,9,"下",false,
								31,8,"下",false,
								30,7,"下",false,
								32,7,"下",false,
								31,6,"下",false,
								30,5,"下",false,
								32,5,"下",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					-- 1 normal; 2弓箭; 3 水战; 4 贼兵; 5 骑兵
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,1,3,"右","敌",false,"帅",1,"坚守",0,0);
						InsertWarTeam(2,p,4,10,"下","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(3,p,8,7,"右","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(4,p,5,7,"下","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(5,p,7,9,"右","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(6,p,2,5,"下","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(7,p,3,3,"右","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(8,p,12,10,"左","敌",true,"武",4,"出击",0,0);
						InsertWarTeam(9,p,13,11,"左","敌",true,"武",4,"出击",0,0);
						InsertWarTeam(10,p,11,13,"左","敌",true,"武",4,"出击",0,0);
						InsertWarTeam(11,p,13,14,"左","敌",true,"武",4,"出击",0,0);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,1,3,"右","敌",false,"帅",1,"警戒",0,0);
						InsertWarTeam(2,p,4,10,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(3,p,8,7,"右","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(4,p,5,7,"下","敌",false,"文",2,"出击",0,0);
						InsertWarTeam(5,p,7,9,"右","敌",false,"文",2,"出击",0,0);
						InsertWarTeam(6,p,2,5,"下","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(7,p,3,3,"右","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(8,p,21,2,"下","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(9,p,22,5,"下","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(10,p,19,4,"下","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(11,p,24,4,"下","敌",false,"武",5,"警戒",0,0);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2223);
					end
				end,
			[2222]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(51)) and (WarCheckArea(-1,1,4,11,9) or WarCheckArea(-1,1,1,8,13)) then	--敌人接近城门，伏兵出现
							WarSetFlag(51,1);
							WarSetFlag(52,1);
						end
						if (not WarCheckFlag(54)) and WarCheckArea(-1,1,1,8,10) then	--敌人进入城内
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"警戒",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
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
									if pid>0 and JY.Person[pid]["台词"]>=0 then
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
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2223]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"出击",0,0);
						end
					end
				end,
				
			[2230]=function()
					local wid;
					local p={};
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(23,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军
					--InsertWarPerson(0,0,1,13,"右",0,"我",false,"待机",0,0);
					SelectTeam(	2,18,"右",false,
								3,19,"右",false,
								2,16,"右",false,
								3,17,"右",false,
								4,18,"右",false,
								5,19,"右",false,
								4,16,"右",false,
								5,17,"右",false,
								6,18,"右",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					-- 1 normal; 2弓箭; 3 水战; 4 贼兵; 5 骑兵
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,19,2,"下","敌",false,"帅",1,"坚守",0,0);
						InsertWarTeam(2,p,18,4,"下","敌",false,"文",1,"警戒",0,0);
						InsertWarTeam(3,p,17,3,"左","敌",false,"文",1,"警戒",0,0);
						InsertWarTeam(4,p,15,10,"下","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(5,p,11,6,"左","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(6,p,17,9,"下","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(7,p,12,5,"左","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(8,p,13,9,"下","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(9,p,13,6,"左","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(10,p,15,8,"下","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(11,p,15,5,"左","敌",false,"武",1,"警戒",0,0);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,19,2,"下","敌",false,"帅",1,"警戒",0,0);
						InsertWarTeam(2,p,18,4,"下","敌",false,"文",1,"警戒",0,0);
						InsertWarTeam(3,p,17,3,"左","敌",false,"文",1,"警戒",0,0);
						InsertWarTeam(4,p,15,10,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(5,p,11,6,"左","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(6,p,17,9,"下","敌",false,"武",2,"出击",0,0);
						InsertWarTeam(7,p,12,5,"左","敌",false,"武",2,"出击",0,0);
						InsertWarTeam(8,p,13,9,"下","敌",false,"武",2,"出击",0,0);
						InsertWarTeam(9,p,13,6,"左","敌",false,"武",2,"出击",0,0);
						InsertWarTeam(10,p,15,8,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(11,p,15,5,"左","敌",false,"武",1,"出击",0,0);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2233);
					end
				end,
			[2232]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(54)) and WarCheckArea(-1,11,1,20,10) then	--敌人进入城内
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"警戒",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2233]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"出击",0,0);
						end
					end
				end,
				
			[2240]=function()
					local wid;
					local p={};
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(24,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军
					SelectTeam(	18,21,"左",false,
								19,20,"左",false,
								19,22,"左",false,
								20,21,"左",false,
								20,23,"左",false,
								21,22,"左",false,
								22,21,"左",false,
								22,23,"左",false,
								23,22,"左",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					-- 1 normal; 2弓箭; 3 水战; 4 贼兵; 5 骑兵
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,23,2,"下","敌",false,"帅",1,"坚守",0,0);
						InsertWarTeam(2,p,11,9,"左","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(3,p,23,4,"下","敌",false,"文",5,"警戒",0,0);
						InsertWarTeam(4,p,17,3,"左","敌",false,"文",5,"警戒",0,0);
						InsertWarTeam(5,p,16,10,"左","敌",false,"文",4,"警戒",0,0);
						InsertWarTeam(6,p,6,8,"下","敌",false,"文",4,"警戒",0,0);
						InsertWarTeam(7,p,10,7,"下","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(8,p,13,14,"左","敌",true,"武",4,"出击",0,0);
						InsertWarTeam(9,p,3,15,"右","敌",true,"武",5,"出击",0,0);
						InsertWarTeam(10,p,10,21,"上","敌",true,"武",5,"出击",0,0);
						InsertWarTeam(11,p,14,22,"上","敌",true,"武",4,"出击",0,0);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,23,2,"下","敌",false,"帅",1,"警戒",0,0);
						InsertWarTeam(2,p,11,9,"左","敌",false,"武",5,"出击",0,0);
						InsertWarTeam(3,p,23,4,"下","敌",false,"文",5,"警戒",0,0);
						InsertWarTeam(4,p,17,3,"左","敌",false,"文",5,"出击",0,0);
						InsertWarTeam(5,p,16,10,"左","敌",false,"文",4,"出击",0,0);
						InsertWarTeam(6,p,6,8,"下","敌",false,"文",4,"出击",0,0);
						InsertWarTeam(7,p,10,7,"下","敌",false,"文",2,"出击",0,0);
						InsertWarTeam(8,p,13,11,"左","敌",false,"武",4,"出击",0,0);
						InsertWarTeam(9,p,4,15,"右","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(10,p,6,18,"右","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(11,p,8,17,"右","敌",false,"武",4,"警戒",0,0);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2243);
					end
				end,
			[2242]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(51)) and WarCheckArea(-1,4,6,16,13) then	--敌人接近城门，伏兵出现
							WarSetFlag(51,1);
							WarSetFlag(52,1);
						end
						if (not WarCheckFlag(54)) and WarCheckArea(-1,17,1,24,8) then	--敌人进入城内
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"警戒",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
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
									if pid>0 and JY.Person[pid]["台词"]>=0 then
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
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2243]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"出击",0,0);
						end
					end
				end,
				
			[2250]=function()
					local wid;
					local p={};
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(25,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军;
					SelectTeam(	8,1,"下",false,
								9,2,"下",false,
								10,1,"下",false,
								11,2,"下",false,
								12,1,"下",false,
								13,2,"下",false,
								14,1,"下",false,
								15,2,"下",false,
								16,1,"下",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					-- 1 normal; 2弓箭; 3 水战; 4 贼兵; 5 骑兵
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,14,29,"左","敌",false,"帅",1,"坚守",0,0);
						InsertWarTeam(2,p,16,24,"左","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(3,p,7,30,"上","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(4,p,9,25,"上","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(5,p,13,20,"左","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(6,p,2,18,"右","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(7,p,14,15,"左","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(8,p,5,13,"右","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(9,p,15,10,"左","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(10,p,6,8,"右","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(11,p,12,9,"上","敌",false,"武",1,"警戒",0,0);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,14,29,"左","敌",false,"帅",1,"警戒",0,0);
						InsertWarTeam(2,p,16,24,"左","敌",false,"文",2,"出击",0,0);
						InsertWarTeam(3,p,7,30,"上","敌",false,"文",2,"出击",0,0);
						InsertWarTeam(4,p,9,25,"上","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(5,p,13,20,"左","敌",false,"武",4,"出击",0,0);
						InsertWarTeam(6,p,2,18,"右","敌",false,"武",4,"出击",0,0);
						InsertWarTeam(7,p,14,15,"左","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(8,p,5,13,"右","敌",false,"武",4,"出击",0,0);
						InsertWarTeam(9,p,15,10,"左","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(10,p,6,8,"右","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(11,p,12,9,"上","敌",false,"武",1,"警戒",0,0);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2253);
					end
				end,
			[2252]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(54)) and WarCheckArea(-1,1,24,20,32) then	--敌人进入城内
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"警戒",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2253]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"出击",0,0);
						end
					end
				end,
				
			[2300]=function()
					local wid;
					local p={};
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(30,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军
					SelectTeam(	16,19,"上",false,
								15,18,"上",false,
								17,18,"上",false,
								15,20,"上",false,
								17,20,"上",false,
								14,19,"上",false,
								18,19,"上",false,
								13,20,"上",false,
								19,20,"上",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					-- 1 normal; 2弓箭; 3 水战; 4 贼兵; 5 骑兵
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,15,6,"下","敌",false,"帅",1,"坚守",0,0);
						InsertWarTeam(2,p,16,5,"下","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(3,p,13,6,"左","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(4,p,15,12,"下","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(5,p,9,6,"左","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(6,p,13,11,"下","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(7,p,10,8,"左","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(8,p,17,11,"下","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(9,p,10,4,"左","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(10,p,15,8,"下","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(11,p,11,6,"左","敌",false,"武",1,"警戒",0,0);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,15,6,"下","敌",false,"帅",1,"警戒",0,0);
						InsertWarTeam(2,p,16,5,"下","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(3,p,13,6,"左","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(4,p,15,12,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(5,p,9,6,"左","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(6,p,13,11,"下","敌",false,"武",2,"出击",0,0);
						InsertWarTeam(7,p,10,8,"左","敌",false,"武",2,"出击",0,0);
						InsertWarTeam(8,p,17,11,"下","敌",false,"武",5,"出击",0,0);
						InsertWarTeam(9,p,10,4,"左","敌",false,"武",5,"出击",0,0);
						InsertWarTeam(10,p,15,8,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(11,p,11,6,"左","敌",false,"武",1,"出击",0,0);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2303);
					end
				end,
			[2302]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(54)) and WarCheckArea(-1,10,1,20,11) then	--敌人进入城内
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"警戒",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2303]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"出击",0,0);
						end
					end
				end,
				
			[2310]=function()
					local wid;
					local p={};
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(31,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军
					SelectTeam(	9,2,"下",false,
								10,2,"下",false,
								8,1,"下",false,
								11,1,"下",false,
								8,3,"下",false,
								11,3,"下",false,
								7,2,"下",false,
								12,2,"下",false,
								9,4,"下",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					-- 1 normal; 2弓箭; 3 水战; 4 贼兵; 5 骑兵
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,8,23,"上","敌",false,"帅",1,"坚守",0,0);
						InsertWarTeam(2,p,9,24,"上","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(3,p,8,26,"下","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(4,p,8,21,"上","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(5,p,10,22,"上","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(6,p,6,24,"左","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(7,p,11,24,"右","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(8,p,2,18,"右","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(9,p,15,18,"左","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(10,p,3,22,"上","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(11,p,14,22,"上","敌",false,"武",2,"警戒",0,0);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,8,23,"上","敌",false,"帅",1,"警戒",0,0);
						InsertWarTeam(2,p,9,24,"上","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(3,p,8,26,"下","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(4,p,8,21,"上","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(5,p,10,22,"上","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(6,p,6,24,"左","敌",false,"武",5,"出击",0,0);
						InsertWarTeam(7,p,11,24,"右","敌",false,"武",5,"出击",0,0);
						InsertWarTeam(8,p,2,18,"右","敌",false,"武",4,"出击",0,0);
						InsertWarTeam(9,p,15,18,"左","敌",false,"武",4,"出击",0,0);
						InsertWarTeam(10,p,3,22,"上","敌",false,"武",2,"出击",0,0);
						InsertWarTeam(11,p,14,22,"上","敌",false,"武",2,"出击",0,0);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2313);
					end
				end,
			[2312]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(54)) and WarCheckArea(-1,6,21,11,26) then	--敌人进入城内
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"警戒",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2313]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"出击",0,0);
						end
					end
				end,
				
			[2320]=function()
					local wid;
					local p={};
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(32,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军
					SelectTeam(	2,5,"右",false,
								3,6,"右",false,
								3,4,"右",false,
								1,4,"右",false,
								1,6,"右",false,
								4,5,"右",false,
								4,7,"右",false,
								3,8,"右",false,
								4,9,"右",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					-- 1 normal; 2弓箭; 3 水战; 4 贼兵; 5 骑兵
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,27,19,"上","敌",false,"帅",1,"坚守",0,0);
						InsertWarTeam(2,p,24,19,"左","敌",false,"文",1,"警戒",0,0);
						InsertWarTeam(3,p,26,16,"上","敌",false,"文",1,"警戒",0,0);
						InsertWarTeam(4,p,9,10,"左","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(5,p,16,12,"左","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(6,p,10,10,"左","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(7,p,13,14,"上","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(8,p,19,9,"左","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(9,p,17,13,"左","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(10,p,21,17,"左","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(11,p,25,12,"左","敌",false,"武",5,"警戒",0,0);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,27,19,"上","敌",false,"帅",1,"警戒",0,0);
						InsertWarTeam(2,p,24,19,"左","敌",false,"文",1,"警戒",0,0);
						InsertWarTeam(3,p,26,16,"上","敌",false,"文",1,"警戒",0,0);
						InsertWarTeam(4,p,9,10,"左","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(5,p,16,12,"左","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(6,p,10,10,"左","敌",false,"武",2,"出击",0,0);
						InsertWarTeam(7,p,13,14,"上","敌",false,"武",4,"出击",0,0);
						InsertWarTeam(8,p,19,9,"左","敌",false,"武",4,"出击",0,0);
						InsertWarTeam(9,p,17,13,"左","敌",false,"武",2,"出击",0,0);
						InsertWarTeam(10,p,21,17,"左","敌",false,"武",5,"出击",0,0);
						InsertWarTeam(11,p,25,12,"左","敌",false,"武",5,"出击",0,0);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2323);
					end
				end,
			[2322]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(54)) and WarCheckArea(-1,20,14,28,20) then	--敌人进入城内
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"警戒",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2323]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"出击",0,0);
						end
					end
				end,
				
			[2330]=function()
					local wid;
					local p={};
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid)*99;
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(33,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军
					SelectTeam(	3,31,"右",false,
								2,30,"右",false,
								5,31,"右",false,
								4,30,"右",false,
								3,29,"右",false,
								2,28,"右",false,
								6,30,"右",false,
								5,29,"右",false,
								7,31,"右",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					enpcnum=1
					-- 1 normal; 2弓箭; 3 水战; 4 贼兵; 5 骑兵
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,16,1,"下","敌",false,"帅",1,"坚守",0,0);
						InsertWarTeam(2,p,13,1,"下","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(3,p,15,3,"下","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(4,p,15,4,"下","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(5,p,16,11,"左","敌",false,"武",3,"警戒",0,0);
						InsertWarTeam(6,p,11,9,"下","敌",false,"武",3,"警戒",0,0);
						InsertWarTeam(7,p,17,13,"左","敌",false,"武",3,"警戒",0,0);
						InsertWarTeam(8,p,12,21,"下","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(9,p,11,20,"下","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(10,p,10,25,"下","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(11,p,11,23,"下","敌",false,"武",2,"警戒",0,0);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,16,1,"下","敌",false,"帅",1,"警戒",0,0);
						InsertWarTeam(2,p,13,1,"下","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(3,p,15,3,"下","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(4,p,15,4,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(5,p,16,11,"左","敌",false,"武",3,"出击",0,0);
						InsertWarTeam(6,p,11,9,"下","敌",false,"武",3,"出击",0,0);
						InsertWarTeam(7,p,17,13,"左","敌",false,"武",3,"出击",0,0);
						InsertWarTeam(8,p,12,21,"下","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(9,p,11,20,"下","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(10,p,10,25,"下","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(11,p,11,23,"下","敌",false,"武",2,"警戒",0,0);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2333);
					end
				end,
			[2332]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(54)) and WarCheckArea(-1,1,1,20,10) then	--敌人进入城内
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"警戒",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*22 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2333]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"出击",0,0);
						end
					end
				end,
			
			[2380]=function()
					local wid;
					local p={};
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(38,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军
					SelectTeam(	2,11,"右",false,
								1,10,"右",false,
								1,12,"右",false,
								2,9,"右",false,
								2,13,"右",false,
								1,8,"右",false,
								1,14,"右",false,
								2,7,"右",false,
								2,15,"右",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					-- 1 normal; 2弓箭; 3 水战; 4 贼兵; 5 骑兵
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,18,14,"左","敌",false,"帅",1,"坚守",0,0);
						InsertWarTeam(2,p,18,17,"下","敌",false,"文",1,"警戒",0,0);
						InsertWarTeam(3,p,16,15,"左","敌",false,"文",1,"警戒",0,0);
						InsertWarTeam(4,p,8,14,"左","敌",false,"武",1,"坚守",0,0);
						InsertWarTeam(5,p,8,17,"左","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(6,p,8,11,"左","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(7,p,10,16,"左","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(8,p,10,13,"左","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(9,p,2,21,"上","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(10,p,6,24,"上","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(11,p,15,30,"上","敌",false,"武",4,"出击",8,14);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,18,14,"左","敌",false,"帅",1,"坚守",0,0);
						InsertWarTeam(2,p,18,17,"下","敌",false,"文",1,"警戒",0,0);
						InsertWarTeam(3,p,16,15,"左","敌",false,"文",1,"警戒",0,0);
						InsertWarTeam(4,p,8,14,"左","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(5,p,8,17,"左","敌",false,"武",5,"出击",0,0);
						InsertWarTeam(6,p,8,11,"左","敌",false,"武",5,"出击",0,0);
						InsertWarTeam(7,p,10,16,"左","敌",false,"武",2,"出击",0,0);
						InsertWarTeam(8,p,10,13,"左","敌",false,"武",2,"出击",0,0);
						InsertWarTeam(9,p,2,21,"上","敌",false,"武",4,"出击",0,0);
						InsertWarTeam(10,p,6,24,"上","敌",false,"武",4,"出击",0,0);
						InsertWarTeam(11,p,15,30,"上","敌",false,"武",4,"出击",0,0);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2383);
					end
				end,
			[2382]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(54)) and WarCheckArea(-1,16,12,20,17) then	--敌人进入城内
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"警戒",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2383]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"出击",0,0);
						end
					end
				end,
				
			[2470]=function()
					local wid;
					local p={};
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(47,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军
					SelectTeam(	1,4,"右",false,
								1,6,"右",false,
								1,2,"右",false,
								2,5,"右",false,
								2,7,"右",false,
								3,6,"右",false,
								3,8,"右",false,
								4,7,"右",false,
								4,9,"右",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					-- 1 normal; 2弓箭; 3 水战; 4 贼兵; 5 骑兵
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,17,17,"左","敌",false,"帅",1,"坚守",0,0);
						InsertWarTeam(2,p,17,19,"下","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(3,p,14,17,"左","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(4,p,17,14,"上","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(5,p,12,10,"左","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(6,p,9,14,"上","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(7,p,14,5,"下","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(8,p,3,14,"上","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(9,p,4,19,"上","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(10,p,18,9,"左","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(11,p,9,20,"上","敌",false,"武",5,"警戒",0,0);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,17,17,"左","敌",false,"帅",1,"警戒",0,0);
						InsertWarTeam(2,p,17,19,"下","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(3,p,14,17,"左","敌",false,"武",5,"出击",0,0);
						InsertWarTeam(4,p,17,14,"上","敌",false,"武",5,"出击",0,0);
						InsertWarTeam(5,p,12,10,"左","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(6,p,9,14,"上","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(7,p,14,5,"下","敌",false,"武",4,"出击",0,0);
						InsertWarTeam(8,p,3,14,"上","敌",false,"武",4,"出击",0,0);
						InsertWarTeam(9,p,4,19,"上","敌",false,"武",4,"出击",0,0);
						InsertWarTeam(10,p,18,9,"左","敌",false,"武",5,"出击",0,0);
						InsertWarTeam(11,p,9,20,"上","敌",false,"武",5,"出击",0,0);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2473);
					end
				end,
			[2472]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(54)) and WarCheckArea(-1,10,10,24,24) then	--敌人进入城内
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"警戒",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2473]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"出击",0,0);
						end
					end
				end,
				
			[2410]=function()
					local wid;
					local p={};
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(41,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军
					SelectTeam(	20,2,"下",false,
								18,2,"下",false,
								22,2,"下",false,
								19,3,"下",false,
								21,3,"下",false,
								23,3,"下",false,
								17,3,"下",false,
								18,4,"下",false,
								22,4,"下",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					-- 1 normal; 2弓箭; 3 水战; 4 贼兵; 5 骑兵
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,21,26,"上","敌",false,"帅",1,"坚守",0,0);
						InsertWarTeam(2,p,20,26,"上","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(3,p,21,23,"上","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(4,p,15,10,"上","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(5,p,26,10,"上","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(6,p,12,26,"左","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(7,p,29,26,"右","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(8,p,16,11,"上","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(9,p,25,11,"上","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(10,p,13,25,"左","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(11,p,28,25,"右","敌",false,"武",2,"警戒",0,0);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,21,26,"上","敌",false,"帅",1,"警戒",0,0);
						InsertWarTeam(2,p,20,26,"上","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(3,p,21,23,"上","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(4,p,15,10,"上","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(5,p,26,10,"上","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(6,p,12,26,"左","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(7,p,29,26,"右","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(8,p,16,11,"上","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(9,p,25,11,"上","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(10,p,13,25,"左","敌",false,"武",2,"出击",0,0);
						InsertWarTeam(11,p,28,25,"右","敌",false,"武",2,"出击",0,0);
					end
						---
						InsertWarPerson(6,GenPerson(true,0,"步兵队"),7,21,"上",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						InsertWarPerson(6,GenPerson(true,0,"步兵队"),8,21,"上",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						InsertWarPerson(6,GenPerson(true,0,"弓兵队"),9,21,"上",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						
						InsertWarPerson(7,GenPerson(true,0,"步兵队"),33,21,"上",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						InsertWarPerson(7,GenPerson(true,0,"步兵队"),34,21,"上",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						InsertWarPerson(7,GenPerson(true,0,"弓兵队"),32,21,"上",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						
						InsertWarPerson(3,GenPerson(true,0,"步兵队"),20,19,"上",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						InsertWarPerson(3,GenPerson(true,0,"步兵队"),21,19,"上",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						InsertWarPerson(3,GenPerson(true,0,"弓兵队"),15,17,"上",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						InsertWarPerson(3,GenPerson(true,0,"弓兵队"),26,17,"上",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						
						InsertWarPerson(4,GenPerson(true,0,"步兵队"),7,12,"右",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						InsertWarPerson(4,GenPerson(true,0,"弓兵队"),9,14,"右",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						InsertWarPerson(5,GenPerson(true,0,"步兵队"),34,12,"左",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						InsertWarPerson(5,GenPerson(true,0,"弓兵队"),32,14,"左",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2413);
					end
				end,
			[2412]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(51)) and WarCheckArea(-1,5,11,36,16) then	--敌人进入城内
							WarSetFlag(51,1);
							WarModifyTeamAI(4,"出击",0,0);
							WarModifyTeamAI(5,"出击",0,0);
							WarModifyTeamAI(8,"出击",0,0);
							WarModifyTeamAI(9,"出击",0,0);
						end
						if (not WarCheckFlag(52)) and WarCheckArea(-1,12,17,29,22) then	--敌人进入城内
							WarSetFlag(52,1);
							WarModifyTeamAI(6,"出击",0,0);
							WarModifyTeamAI(7,"出击",0,0);
							WarModifyTeamAI(10,"出击",0,0);
							WarModifyTeamAI(11,"出击",0,0);
						end
						if (not WarCheckFlag(53)) and WarCheckArea(-1,18,23,23,28) then	--敌人进入城内
							WarSetFlag(53,1);
							WarModifyTeamAI(1,"警戒",0,0);
							WarModifyTeamAI(2,"出击",0,0);
							WarModifyTeamAI(3,"出击",0,0);
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2413]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"出击",0,0);
						end
					end
				end,
				
			[2420]=function()
					local wid;
					local p={};
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid)*99;
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(42,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军
					SelectTeam(	13,23,"上",false,
								12,24,"上",false,
								14,24,"上",false,
								11,23,"上",false,
								15,23,"上",false,
								10,24,"上",false,
								16,24,"上",false,
								9,23,"上",false,
								17,23,"上",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					enpcnum=0;
					-- 1 normal; 2弓箭; 3 水战; 4 贼兵; 5 骑兵
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,14,5,"下","敌",false,"帅",1,"坚守",0,0);
						InsertWarTeam(2,p,14,4,"下","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(3,p,14,15,"下","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(4,p,8,5,"左","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(5,p,14,7,"下","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(6,p,7,14,"右","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(7,p,5,10,"下","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(8,p,15,14,"下","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(9,p,9,4,"左","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(10,p,20,7,"下","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(11,p,5,8,"下","敌",false,"武",2,"警戒",0,0);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,14,5,"下","敌",false,"帅",1,"警戒",0,0);
						InsertWarTeam(2,p,14,4,"下","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(3,p,14,15,"下","敌",false,"武",1,"警戒",0,0);
						InsertWarTeam(4,p,8,5,"左","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(5,p,14,7,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(6,p,7,14,"右","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(7,p,5,10,"下","敌",false,"武",1,"出击",0,0);
						InsertWarTeam(8,p,15,14,"下","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(9,p,9,4,"左","敌",false,"武",2,"出击",0,0);
						InsertWarTeam(10,p,20,7,"下","敌",false,"武",2,"出击",0,0);
						InsertWarTeam(11,p,5,8,"下","敌",false,"武",2,"出击",0,0);
					end
						---
						InsertWarPerson(3,GenPerson(true,0,"步兵队"),16,5,"下",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						InsertWarPerson(3,GenPerson(true,0,"弓兵队"),16,4,"下",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						
						InsertWarPerson(3,GenPerson(true,0,"步兵队"),14,13,"下",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						InsertWarPerson(3,GenPerson(true,0,"弓兵队"),15,13,"下",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						
						InsertWarPerson(3,GenPerson(true,0,"步兵队"),7,14,"右",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						InsertWarPerson(3,GenPerson(true,0,"弓兵队"),6,14,"右",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						
						InsertWarPerson(3,GenPerson(true,0,"步兵队"),5,10,"下",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						InsertWarPerson(3,GenPerson(true,0,"弓兵队"),5,9,"下",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						
						InsertWarPerson(2,GenPerson(true,0,"弓兵队"),12,11,"下",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						InsertWarPerson(2,GenPerson(true,0,"弓兵队"),17,11,"下",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						InsertWarPerson(2,GenPerson(true,0,"弓兵队"),8,11,"下",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						InsertWarPerson(2,GenPerson(true,0,"弓兵队"),12,7,"下",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
						InsertWarPerson(2,GenPerson(true,0,"弓兵队"),17,7,"下",1+math.random(0,1)-math.random(0,1),"敌",false,"警戒",0,0);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2423);
					end
				end,
			[2422]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(54)) and WarCheckArea(-1,11,1,18,8) then	--敌人进入城内
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"警戒",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*22 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2423]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"出击",0,0);
						end
					end
				end,
				
			[2480]=function()
					local wid;
					local p={};
					--敌军势力评估
					local cid=JY.Base["攻打城池"];
					local pt=GetCityPT(cid);
					local fid=JY.City[cid]["势力"];
					if fid==0 then
						fid=52;	--贼势力
					end
					local bc_flag=false;
					if cid==JY.Force[fid]["本城"] then
						bc_flag=true;
					end
					p=FilterPerson(fid,pt,bc_flag);
					local enum=#p;
					local enpcnum=0;
					for i=1,enum do
						local pid=p[i];
						enpcnum=enpcnum+1+JY.Person[pid]["品级"];
					end
					
					--战场定义
					WarIni();
					DefineWarMap(48,JY.City[cid]["名称"].."攻略战","一、全灭敌军．",20,"主角",p[1]);
					--我军
					SelectTeam(	1,4,"右",false,
								1,2,"右",false,
								2,3,"右",false,
								2,5,"右",false,
								3,2,"右",false,
								3,4,"右",false,
								3,6,"右",false,
								4,3,"右",false,
								4,5,"右",false)
					WarSetFlag(101,War.Person[1].id);	--我方主帅ID
					local mnum=War.PersonNum;
					--敌军
					-- 1 normal; 2弓箭; 3 水战; 4 贼兵; 5 骑兵
					if mnum*1.5>enpcnum then	--坚守城池
						WarSetFlag(1,1);--我方攻击，敌方防守
						InsertWarTeam(1,p,17,3,"下","敌",false,"帅",1,"坚守",0,0);
						InsertWarTeam(2,p,14,5,"下","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(3,p,16,12,"下","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(4,p,14,11,"下","敌",false,"武",2,"警戒",0,0);
						InsertWarTeam(5,p,17,6,"下","敌",false,"文",1,"警戒",0,0);
						InsertWarTeam(6,p,16,16,"左","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(7,p,13,17,"左","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(8,p,9,15,"上","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(9,p,5,16,"上","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(10,p,6,14,"上","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(11,p,19,15,"左","敌",false,"武",2,"警戒",0,0);
					else
						WarSetFlag(1,2);--我方攻击，敌方出击
						InsertWarTeam(1,p,17,3,"下","敌",false,"帅",1,"警戒",0,0);
						InsertWarTeam(2,p,14,5,"下","敌",false,"文",2,"警戒",0,0);
						InsertWarTeam(3,p,16,12,"下","敌",false,"武",5,"出击",0,0);
						InsertWarTeam(4,p,14,11,"下","敌",false,"武",2,"出击",0,0);
						InsertWarTeam(5,p,17,6,"下","敌",false,"文",1,"出击",0,0);
						InsertWarTeam(6,p,16,16,"左","敌",false,"武",5,"出击",0,0);
						InsertWarTeam(7,p,13,17,"左","敌",false,"武",5,"出击",0,0);
						InsertWarTeam(8,p,9,15,"上","敌",false,"武",5,"警戒",0,0);
						InsertWarTeam(9,p,5,16,"上","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(10,p,6,14,"上","敌",false,"武",4,"警戒",0,0);
						InsertWarTeam(11,p,19,15,"左","敌",false,"武",2,"出击",0,0);
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
							if JY.Person[pid]["台词"]>=0 then
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
							if JY.Person[pid]["台词"]>=0 then
								WarTalk(pid,20);
							end
						end
						NextEvent(2483);
					end
				end,
			[2482]=function()	--敌人死守
					if JY.Status==GAME_WARWIN then
						--Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						if (not WarCheckFlag(54)) and WarCheckArea(-1,11,1,20,13) then	--敌人进入城内
							WarSetFlag(54,1);
							WarModifyTeamAI(1,"警戒",0,0);
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if (not WarCheckFlag(55)) and War.PersonNumEnemy>War.PersonNumWe*2 then
							PlayBGM(12);
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(111),14);
							for i=1,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
					end
				end,
			[2483]=function()	--敌人出击
					if JY.Status==GAME_WARWIN then
						Talk(WarGetFlag(101),"可、可恶……劉備小儿！哇！！");
					end
					if JY.EventType==War_Event_Action then	--行动后
						
					end
					if JY.EventType==War_Event_TurnM then	--我军回合开始
						--War.PersonNumWe=0;
						--War.PersonNumFriend=0;
						--War.PersonNumEnemy=0;
						if (not WarCheckFlag(55)) and War.PersonNumEnemy<War.PersonNumWe then
							WarSetFlag(55,1);
							WarTalk(WarGetFlag(101),14);
						end
					end
					if JY.EventType==War_Event_TurnF then	--友军回合开始
						
					end
					if JY.EventType==War_Event_TurnE then	--敌军回合开始
						if War.Turn==3 then
							for i=2,WarGetFlag(11) do
								WarModifyTeamAI(i,"出击",0,0);
							end
						end
						if War.Turn==4 then
							WarModifyTeamAI(1,"出击",0,0);
						end
					end
				end,
				
				
				
				
				
			[9999]=function()
					JY.Status=GAME_START;
				end,
		};
		
		