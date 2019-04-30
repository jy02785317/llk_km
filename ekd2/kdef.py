#coding=utf-8
import os
resPath = '.\\res\\'

roleName = ("诸葛亮","刘备","关羽","张飞","姜维","马谡","赵云","魏延","关兴","张苞","马岱","王平","徐庶","庞统","马超","蒋琬","费禕","诸葛瞻","杨仪","邓芝","廖化","关索","诸葛均","刘禅","吴懿","吴班","张翼","张嶷","马忠","高翔","李严","杜琼","李恢","向宠","陈式","董允","郭攸之","马良","杨兰","李明","孟达","霍峻","王伉","吕凯","赵统","赵广","吕义","黄忠","法正","张松","伊籍","孙乾","糜竺","糜芳","简雍","刘封","关平","周仓","严颜","王甫","沙摩可","吴兰","雷铜","傅士仁","张南","曹操","夏侯惇","夏侯渊","曹仁","曹洪","荀彧","荀攸","郭嘉","程昱","张辽","许褚","徐晃","于禁","乐进","李典","贾诩","朱灵","庞德","毛玠","陈矫","夏侯尚","韩浩","夏侯德","曹彰","夏侯恩","夏侯杰","张郃","曹植","曹休","满宠","刘晔","司马懿","曹丕","曹睿","曹真","钟繇","华歆","王朗","陈群","夏侯楙","崔谅","马遵","曹遵","朱赞","司马师","司马昭","郝昭","王双","费耀","郭淮","孙礼","张虎","乐綝","郑文","秦郎","秦明","韩德","陈造","万政","夏侯霸","夏侯威","夏侯惠","夏侯和","贾逵","辛毗","徐商","邓艾","曹芳","曹爽","曹羲","曹训","曹彦","彻里吉","钟会","张球","韩瑛","杨陵","粱绪","梁虔","尹赏","申耽","申仪","戴陵","秦良","孙权","周瑜","鲁肃","诸葛瑾","诸葛恪","吕蒙","陆逊","潘璋","徐盛","甘宁","凌统","周泰","蒋钦","吕范","张昭","陈武","虞翻","步骘","薛综","陆绩","孙瑜","黄盖","孙皓","朱然","朱桓","孙韶","董袭","宋宪","全琮","张达","范疆","顾雍","严畯","孟获","金环结","董茶那","阿会喃","忙牙长","孟优","祝融","朵思王","木鹿王","兀突骨","杨锋","带来","孟节","刘表","蒯越","蔡瑁","刘琦","刘琮","刘度","刘贤","邢道荣","赵范","陈应","金旋","巩志","韩玄","杨龄","刘璋","刘循","刘贵","张任","杨怀","高沛","雍闓","高定","朱褒","鄂焕","张鲁","张卫","阎圃","冷苞","雅丹","越吉","轲比能","文聘","杨修","张绍","黄权","孙亮","阚泽","韩当","丁奉","张允","杨松","步兵队","步兵队","步兵队","步兵队","步兵队","步兵队","步兵队","步兵队","步兵队","步兵队","步兵队","步兵队","弓兵队","弓兵队","弓兵队","弓兵队","弓兵队","弓兵队","弓兵队","弓兵队","弓兵队","弓兵队","弓兵队","弓兵队","骑兵队","骑兵队","骑兵队","骑兵队","骑兵队","骑兵队","骑兵队","骑兵队","骑兵队","骑兵队","骑兵队","骑兵队","战车队","战车队","战车队","战车队","战车队","战车队","战车队","战车队","战车队","战车队","战车队","战车队","弓骑兵","弓骑兵","弓骑兵","弓骑兵","弓骑兵","弓骑兵","弓骑兵","弓骑兵","弓骑兵","弓骑兵","弓骑兵","弓骑兵","贼","贼","贼","贼","贼","贼","贼","贼","贼","贼","贼","贼","武术家","武术家","武术家","武术家","武术家","武术家","武术家","武术家","武术家","武术家","武术家","武术家","虎兵团","虎兵团","虎兵团","虎兵团","虎兵团","虎兵团","虎兵团","虎兵团","虎兵团","虎兵团","虎兵团","虎兵团","军乐队","军乐队","军乐队","军乐队","军乐队","军乐队","军乐队","首","物资队","物资队","物资队","物资队","物资队","物资队","物资队","物资队","运粮队","运粮队","运粮队","运粮队","运粮队","运粮队","运粮队","运粮队","南蛮兵","南蛮兵","南蛮兵","南蛮兵","南蛮兵","南蛮兵","南蛮兵","南蛮兵","南蛮兵","南蛮兵","南蛮兵","南蛮兵","南蛮兵","南蛮兵","南蛮兵","南蛮兵","南蛮兵","南蛮兵","南蛮兵","南蛮兵","南蛮兵","南蛮兵","南蛮兵","南蛮兵","藤甲兵","藤甲兵","藤甲兵","藤甲兵","藤甲兵","藤甲兵","藤甲兵","藤甲兵","藤甲兵","藤甲兵","藤甲兵","藤甲兵","羌族兵","羌族兵","羌族兵","羌族兵","羌族兵","羌族兵","羌族兵","羌族兵","羌族兵","羌族兵","羌族兵","羌族兵","象兵团","象兵团","象兵团","象兵团","象兵团","象兵团","象兵团","象兵团","象兵团","象兵团","象兵团","象兵团","蛇兵团","蛇兵团","蛇兵团","蛇兵团","蛇兵团","蛇兵团","蛇兵团","蛇兵团","蛇兵团","蛇兵团","蛇兵团","蛇兵团","幻术师","幻术师","幻术师","幻术师","藤甲兵","藤甲兵","藤甲兵","藤甲兵","藤甲兵","藤甲兵","藤甲兵","藤甲兵","北狄兵","北狄兵","北狄兵","北狄兵","北狄兵","北狄兵","北狄兵","北狄兵","北狄兵","北狄兵","北狄兵","北狄兵","炮车队","炮车队","炮车队","炮车队","炮车队","炮车队","炮车队","炮车队","炮车队","炮车队","炮车队","炮车队","宫吏","宫吏","民","民","老翁","老妇","男孩","女孩","美人","美人","士兵","士兵","商人","商人","仙人","仙人","旅客","旅客","官差","官差","使者","使者","文官","文官","武官","武官","黄氏","民","民","民","黄承彦","崔州平","童子","献帝","诸葛亮","诸葛亮","诸葛瑾","诸葛均","诸葛均","诸葛瞻","诸葛瞻","诸葛瞻","徐庶","黄氏","黄氏","武器屋","道具屋","黄氏")
forceName = ('蜀', '魏', '吴', '南蛮', '异民族', '独立', '刘备', '刘备', '蜀', '无所属')
cityName = ('隆中', '新野', '江夏','柴桑','赤壁', '江陵', '葭萌关', '成都', '汉中', '长安', '越隽', '永昌', '泸水', '西耳湖', '秃龙洞', '银坑洞', '洛阳', '祁山', '南安', '陈仓', '渭水', '卤城', '五丈原', '眉城', '函谷关', '巴西', '博望坡', '长阪坡', '长沙', '定军山', '汉水', '阳平关', '麦城', '夷陵', '西平关', '建宁', '朱提', '五溪峰', '夹山谷', '三江城', '桃叶江', '盘蛇谷', '凤鸣山', '安定', '天水', '冀城', '街亭', '箕谷', '斜谷', '首阳', '葫芦谷', '太白山', '武功', '西塞山', '华山', '琅琊', '许昌', '襄阳', '绵竹关', '白帝城', '上庸', '江南', '建业', '上圭')
itemName = ('焦热书', '火龙书', '猛火书', '大焦热书', '大火龙书', '大猛火书', '落石书', '山崩书', '山洪书', '大落石书', '大山崩书', '大山洪书', '查看书', '侦察书', '谍报书', '压迫书', '威压书', '骂声书', '挑拨书', '假情报书', '伪兵书', '反间书', '流言书', '牵制书', '止步书', '恢复豆', '恢复麦', '恢复米', '恢复肉', '援队书', '援部书', '援军书', '援国书', '药', '中药', '华佗药', '苏醒书', '恢复书', '释放书', '轻功书', '奋起书', '鼓舞书', '坚固书', '强阵书', '对策书', '回归书', '没有', '封策书', '短剑', '刀', '长刀', '两刃剑', '雌雄双剑', '倚天剑', '弯刀', '斩马剑', '三尖刀', '神刀', '七星剑', '古锭刀', '大刀', '三色宝剑', '青釭剑', '古灵剑', '英雄之剑', '霸王之剑', '棍棒', '枪', '钩', '戟', '蛇矛', '青龙偃月刀', '长枪', '半月枪', '狼牙棒', '长戟', '铁脊蛇矛', '铁蒺藜骨朵', '铁鞭', '大斧', '流星锤', '双铁戟', '方天画戟', '项羽矛', '竹木弓', '半弓', '石弓', '长弓', '蛮弓', '优弓', '良弓', '弹弓', '弩', '强弩', '连发弩', '元戎弩', '名弓', '十矢弩', '诸葛弩', '神弓', '吕布弓', '青龙弓', '小石弹炮', '石弹炮', '手炮', '泥弹炮', '岩石弹炮', '破裂弹炮', '火弹炮', '旋风炮', '玄武炮', '虎', '黑虎', '饿虎', '猛虎', '双眼虎', '白虎', '青铜爪牙', '铁制爪牙', '白银爪牙', '不败爪牙', '大鹰爪牙', '朱雀爪牙', '笙', '钲', '笛', '箫笛', '铜锣', '鼓', '单轮车', '双轮车', '三轮车', '四轮车', '木牛', '流马', '铁扇', '蒲扇', '阵扇', '银扇', '军扇', '鹤羽扇', '鹰羽扇', '黑羽扇', '白羽扇', '皮甲', '青铜甲', '锦铠', '环锁铠', '铁甲', '两当铠', '赤甲', '裲裆甲', '明光铠', '黑光铠', '筒袖铠', '将军铠', '白银制铠', '黄金制铠', '高祖铠', '蚩尤铠', '木制盾', '小型盾', '皮盾', '藤盾', '青铜盾', '铁制盾', '大盾', '手牌', '圆牌', '燕尾牌', '推牌', '步兵旁牌', '无敌神牌', '神兽盾', '咒文盾', '鬼神盾', '栗毛马', '苇毛马', '黄骠马', '白马', '绝影', '爪黄飞电', '的卢', '赤兔马', '人车', '牛车', '大车', '马车', '轻车', '双牛车', '双马车', '疾风马车', '长兵器指南书', '近卫兵心得', '弩的奥秘', '连弩的奥秘', '马镫', '近卫马镫', '战车战术读本', '战车战术其二', '投石机', '投石车', '弩骑兵镫', '连弩骑兵镫', '侠义精神', '武道全书', '猛虎鞭', '牙旗', '龙牙旗', '仁爱种', '武勇种', '智谋种', '根性种', '精神种', '经验种', '仁爱果', '武勇果', '智谋果', '根性果', '精神果', '经验果', '三略', '六韬', '孟德新书', '孙子兵法', '没有', '没有', '没有', '没有', '没有', '没有', '没有', '没有', '没有', '没有', '没有', '没有', '没有', '没有', '没有', '没有', '没有', '没有', '没有', '没有', '没有', '没有', '没有', '没有', '没有', '没有', '没有', '没有', '没有', '没有')
unitName = ("短兵","长兵","近卫兵","弓兵","弩兵","连弩兵","轻骑兵","重骑兵","亲卫队","轻战车","重战车","大战车","小炮车","大炮车","霹雳车","弓骑兵","弩骑兵","连弩骑兵","军师","名军师","大军师","山贼","义贼","武术家","大武术家","虎兵团","猛虎兵团","运粮队","物资队","军乐队","南蛮兵","南蛮骑兵","皇帝","都督","藤甲兵","羌族兵","象兵团","蛇兵团","幻术师","北狄兵","羌族兵","象兵团","蛇兵团","幻术师","北狄兵")
terrainName = ('平原', '草原', '树林', '荒地', '山脉', '城内', '桥梁', '村庄', '鹿砦', '兵营', '粮仓', '宝物库', '城池', '关隘', '民宅', '城门', '栅栏', '河流', '悬崖', '城墙', '石山', '火焰', '泥石流')
sceneName = ('议事厅', '集会所', '酒馆', '武器屋', '道具屋', '宫殿', '官邸', '民宅', '营帐', '出口')
warfareName= ('博望坡战役','新野城战役','江夏急行战','长阪坡战役','赤壁战役','荆州南部战役Ⅰ','绵竹关·葭萌关战役','汉水战役','麦城战役','彝陵战役','阳平关战役','益州南部战役','五溪峰战役','夹山谷战役','泸水战役','西耳湖战役','秃龙洞战役','三江城战役','蛮都战役','桃叶江战役','盘蛇谷战役','凤鸣山战役','南安·安定战役','天水城战役','冀城战役','祁山战役Ⅰ','西平关战役','街亭战役','汉中撤退战','陈仓·祁山战役','陈仓攻城战','祁山追击战','二谷道战役','祁山战役Ⅱ','渭水战役','葫芦谷战役','五丈原战役','眉城战役','武功战役','长安攻城战Ⅰ','巴西战役','白帝城战役','江陵战役','成都防卫战Ⅰ','建宁战役','长安攻城战Ⅱ','华山战役','函谷关战役','洛阳战役Ⅰ','洛阳战役Ⅱ')
directionName = ['上','右','下','左',]
aiName = ['原地警戒', '主动出击', '原地待命', '攻击指定部队', '攻击指定坐标', '前往指定部队', '前往指定坐标']

CID = 0 #章
SCID = 1 #幕
SID = 0 #段落
SSID = 0 #阶段
GID = 0 #事件
indent1 = indent2 = 0
def log(s):
    if indent2 > 0:
        s = '    ' + s
    elif indent1 > 0:
        s = '  ' + s
    output.write(s + '\n')
def readTextRaw():
    address = talk.tell()
    txt = b''
    while True:
        s = talk.read(1)
        if s == b'\x00':
            break;
        txt += s
    #handle some big5 char
    # print('offset = 0x{:0>4x}, {}'.format(address, txt))
    txt = txt.replace(b'\xa1\x40', b'  ').replace(b'\n', b'\\n').replace(b'\r', b'')
    # txt = txt.replace(b'\x0d\x0a', b' ')
    # print('offset = 0x{:0>4x}, {}'.format(address, txt))
    # print(txt.decode('gbk'))
    return txt.decode('gbk')
def readText(offset):
    talk.seek(2 * SCID)
    offsetSCID = int.from_bytes(talk.read(2), byteorder = 'little', signed = False)
    talk.seek(offsetSCID + offset)
    return readTextRaw()
def readTalk(offset):
    talk.seek(2 * SCID)
    offsetSCID = int.from_bytes(talk.read(2), byteorder = 'little', signed = False)
    talk.seek(offsetSCID + offset)
    talkArray = []
    while True:
        pid = int.from_bytes(talk.read(2), byteorder = 'little', signed = False)
        if pid == 0xFFFF:
            break
        talkArray.append({
            'pid': pid,
            'text': readTextRaw(),
        })
    return talkArray

def handleSection(offset):
    SSID = 0
    GID = 0
    count = 0
    while True:
        kdef.seek(offset + 10 * count)
        trigger = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
        num = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
        v1 = v2 = v3 = v4 = v5 = -1
        if trigger == 0xFF:
            break
        elif trigger == 0x02:
            v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
            kdef.seek(1, 1)
            v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
        elif trigger == 0x03:
            v1 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
        elif trigger == 0x04:
            v1 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
            v2 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
        elif trigger == 0x05:
            v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
        elif trigger == 0x06:
            v1 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
            v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
            v3 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
        elif trigger == 0x09:
            v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
        elif trigger == 0x0b:
            v1 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
            v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
            v3 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
            v4 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
            v5 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
        elif trigger == 0x0c:
            v1 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)

        if num & 0x7F != SSID:
            GID = 0
        SSID = num & 0x7F
        kdef.seek(offset + 10 * count + 8)
        sessionOffset = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
        # print('SID {}, SSID {}, GID {}, trigger: 0x{:0>2x}, 0x{:0>4x}'.format(SID, SSID, GID, trigger, sessionOffset))
        groupInfo.append({
            'CID': CID,
            'SCID': SCID,
            'SID': SID,
            'SSID': SSID,
            'GID': GID,
            'trigger': trigger,
            'v1': v1,
            'v2': v2,
            'v3': v3,
            'v4': v4,
            'v5': v5,
            'offset': offset + sessionOffset
        })
        GID += 1
        count += 1

def dumpKdef(int_CID, int_SCID):
    global roleName, forceName, cityName, itemName, unitName, terrainName, sceneName, directionName, aiName
    global CID, SCID, SID, SSID, GID
    global kdef, talk, output
    global groupInfo, indent1, indent2
    print('dump {}-{}...'.format(int_CID, int_SCID))
    CID = int_CID
    SCID = int_SCID
    SID = 0
    SSID = 0
    GID = 0
    groupInfo = []
    kdef = open(os.path.join(resPath, 'SNR{}D.{:0>3}'.format(CID, SCID)), 'rb')
    talk = open(os.path.join(resPath, 'SNR{}M.E2'.format(CID)), 'rb')
    output = open(os.path.join('.\\snr\\', 'SNR{}-{}.txt'.format(CID + 1, SCID + 1)), 'w', encoding = 'utf-8')

    while True:
        kdef.seek(2 * SID)
        sectionOffset = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
        if sectionOffset == 0xFFFF:
            break
        # print('SID {}, 0x{:0>4x}'.format(SID, sectionOffset))
        handleSection(sectionOffset)
        SID += 1

    kdef.seek(0, os.SEEK_END)
    groupInfo.append({
        'offset': kdef.tell()
    })
    log('# 剧本文件')
    log('# #后面的内容为注释')
    log('# <>包裹起来的内容也是注释')
    log('# 第{}章 第{}幕'.format(CID, SCID))

    SID = -1
    SSID = -1
    for i in range(len(groupInfo) - 1):
        st = groupInfo[i]['offset']
        ed = groupInfo[i + 1]['offset']
        kdef.seek(st)
        # print(i)
        # print('--> SID {SID}, SSID {SSID}, GID {GID} Trig {trigger} Offset {offset}'.format(**groupInfo[i]))
        if groupInfo[i]['SID'] != SID:
            SID = groupInfo[i]['SID']
            log('\n场 ########第{}场########'.format(SID + 1))
        if groupInfo[i]['SSID'] != SSID:
            SSID = groupInfo[i]['SSID']
            log('\n  节 #________________第{}章/第{}幕/第{}场/第{}节'.format(CID + 1, SCID + 1, SID + 1, SSID + 1))
        # log('\n  事件 {}'.format(groupInfo[i]['GID']))
        if groupInfo[i]['trigger'] == 0x00:
            log('\n    事件: 自动')
        elif groupInfo[i]['trigger'] == 0x01:
            log('\n    事件: 分支选择 #选择第一项则执行下个事件, 选择第二项则执行下下个事件, 以此类推')
        elif groupInfo[i]['trigger'] == 0x02:
            s1 = sceneName[groupInfo[i]['v1']]
            s2 = cityName[groupInfo[i]['v2']]
            log('\n    事件: 进入建筑时, {}<{}>, {}<{}>'.format(groupInfo[i]['v2'] + 1, s2, groupInfo[i]['v1'], s1))
        elif groupInfo[i]['trigger'] == 0x03:
            log('\n    事件: 选择人物时, {}<{}>'.format(groupInfo[i]['v1'] + 1, roleName[groupInfo[i]['v1']]))
        elif groupInfo[i]['trigger'] == 0x04:
            if groupInfo[i]['v1'] >= 0x0400:
                groupInfo[i]['v1'] = -1
                s1 = '任意我方'
            else:
                s1 = roleName[groupInfo[i]['v1']]
            if groupInfo[i]['v2'] >= 0x0400:
                groupInfo[i]['v2'] = -1
                s2 = '任意敌方'
            else:
                s2 = roleName[groupInfo[i]['v2']]
            log('\n    事件: 部队相邻时, {}<{}>, {}<{}>'.format(groupInfo[i]['v1'], s1, groupInfo[i]['v2'], s2))
        elif groupInfo[i]['trigger'] == 0x05:
            #孔明传未使用
            s1 = cityName[groupInfo[i]['v1']]
            log('\n    事件: 进入城市时, {}<{}>'.format(groupInfo[i]['v1'] + 1, s1))
        elif groupInfo[i]['trigger'] == 0x06:
            if groupInfo[i]['v1'] >= 0x200:
                groupInfo[i]['v1'] = -1
                name = '任意我方'
            else:
                name = roleName[groupInfo[i]['v1']]
            log('\n    事件: 进入坐标时, {}<{}>, <坐标>{}, {}'.format(groupInfo[i]['v1'], name, groupInfo[i]['v2'], groupInfo[i]['v3']))
        elif groupInfo[i]['trigger'] == 0x07:
            log('\n    事件: 战斗胜利时')
        elif groupInfo[i]['trigger'] == 0x08:
            log('\n    事件: 战斗失败时')
        elif groupInfo[i]['trigger'] == 0x09:
            log('\n    事件: 回合开始时, <回合>{}'.format(groupInfo[i]['v1']))
        elif groupInfo[i]['trigger'] == 0x0b:
            if groupInfo[i]['v1'] >= 0x200:
                groupInfo[i]['v1'] = -1
                name = '任意我方'
            else:
                name = roleName[groupInfo[i]['v1']]
            log('\n    事件: 进入区域时, {}<{}>, <区域左上角坐标>{}, {}, <区域右下角坐标>{}, {}'.format(groupInfo[i]['v1'], name, groupInfo[i]['v2'], groupInfo[i]['v3'], groupInfo[i]['v4'], groupInfo[i]['v5']))
        elif groupInfo[i]['trigger'] == 0x0c:
            log('\n    事件: 部队撤退时, {}<{}>'.format(groupInfo[i]['v1'], roleName[groupInfo[i]['v1']]))
        else:
            log('\n    事件: 自动 #未识别的触发条件0x{:0>2x}'.format(groupInfo[i]['trigger']))

        indent1 = indent2 = 0
        while kdef.tell() < ed:
            # print('pos=0x{:0>4x}'.format(kdef.tell()))
            if indent2 > 0:
                indent2 -= 1
            elif indent1 > 0:
                indent1 -= 1
            inst = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
            if inst == 0xff:
                break
            elif inst == 0x00:
                pos = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                talkArray = readTalk(pos)
                # flag = True
                for j in talkArray:
                    log('    对话: {}<{}>, {}'.format(j['pid'] + 1, roleName[j['pid']], j['text']))
                    # if flag:
                    #     flag = False
                    #     log('    对话: {}<{}>, {}'.format(j['pid'], roleName[j['pid']], j['text']))
                    # else:
                    #     log('      {}<{}>, {}'.format(j['pid'], roleName[j['pid']], j['text']))
            elif inst == 0x01:
                v1 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v3 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v4 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                log('    人物移动: {}<{}>, <移动至>{}, {}, <方向>{}<{}>'.format(v1 + 1, roleName[v1], v2, v3, v4, directionName[v4]))
            elif inst == 0x02:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                log('    未知指令0x02: {}'.format(v1))
            elif inst == 0x03:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v3 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                kdef.seek(2, 1)
                v4 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                kdef.seek(2, 1)
                v5 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                if v1 == 0x00:
                    s1 = '禁止撤退'
                else:
                    s1 = '允许撤退'
                if v3 == 0x01:
                    s3 = '是'
                else:
                    s3 = '否'
                if v4 == 0xffff:
                    v4 = -1
                    s4 = '无'
                else:
                    s4 = roleName[v4]
                if v5 == 0xffff:
                    v5 = -1
                    s5 = '无'
                else:
                    s5 = roleName[v5]
                log('    战斗初始化: {}<{}>, <限制回合>{}, <继承上场战斗回合数>{}<{}>, <敌方主帅>{}<{}>, <我方主帅>{}<{}>'.format(v1, s1, v2, v3, s3, v4 + 1, s4, v5 + 1, s5))
                for j in range(30):
                    vv1 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                    if vv1 == 0xffff:
                        kdef.seek(7, 1)
                        continue
                    elif vv1 == 0x0400:
                        vv1 = -1
                        ss1 = '自选'
                    else:
                        ss1 = roleName[vv1]
                    vv2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                    vv3 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                    kdef.seek(1, 1)
                    vv4 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                    if vv4 == 0x01:
                        ss4 = '是'
                    else:
                        ss4 = '否'
                    vv5 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                    vv6 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = True)
                    if vv6 >=0 and vv6 <= 3:
                        ss6 = directionName[vv6]
                    else:
                        ss6 = '自动'
                    vv7 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                    if vv7 == 0x01:
                        ss7 = '是'
                    else:
                        ss7 = '否'
                    log('    部署我军: {}<{}>, <坐标>{}, {}, <判断标记出场>{}<{}>, <标记>{}, <方向>{}<{}>, <伏兵>{}<{}>'.format(vv1 + 1, ss1, vv2 + 1, vv3 + 1, vv4, ss4, vv5, vv6, ss6, vv7, ss7))
            elif inst == 0x05:
                log('    显示场景'.format(inst))
            elif inst == 0x06:
                log('    未知指令0x06 # 怀疑是黑屏')
            elif inst == 0x07:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                if v2 == 0x00:
                    s2 = '淡入'
                elif v2 == 0x01:
                    s2 = '淡出'
                else:
                    s2 = '未知'
                log('    显示图片: <图片编号>{}, {}<{}>'.format(v1, v2, s2))
            elif inst == 0x08:
                pos = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                text = readText(pos)
                log('    显示多行信息: {}'.format(text))
            elif inst == 0x09:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                if v2 == 0x00:
                    log('    指定地图: 1<城市>, {}<{}>'.format(v1 + 1, cityName[v1]))
                elif v2 == 0x10:
                    log('    指定地图: 0<大地图>')
                elif v2 == 0x20:
                    if v1 < len(sceneName):
                        s1 = sceneName[v1]
                    else:
                        s1 = '地图编号'
                    log('    指定地图: 2<场所>, {}<{}>'.format(v1, s1))
                elif v2 == 0x30:
                    s1 = warfareName[v1]
                    log('    指定地图: 3<战场>, {}<{}>'.format(v1 + 1, s1))
                else:
                    log('    inst 0x{:0>2x} ([错误])指定战场/场景/大地图: 0x{:0>2x} 0x{:0>2x}'.format(inst, v1, v2))
            elif inst == 0x0a:
                v1 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v3 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v4 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                kdef.seek(1, 1) #未知
                log('    人物出现: {}<{}>, <坐标>{}, {}, <方向>{}<{}>'.format(v1 + 1, roleName[v1], v2, v3, v4, directionName[v4]))
            elif inst == 0x0b:
                pos = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                text = readText(pos)
                log('    显示信息: {}'.format(text))
            elif inst == 0x0d:
                pos = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                text = readText(pos)
                log('    设置章节名: {}'.format(text))
            elif inst == 0x0e:
                pos = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                text = readText(pos)
                log('    显示信息: {}'.format(text))
            elif inst == 0x0f:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False) + 1
                log('    场跳转: {} #结束当前事件, 执行第{}场'.format(v1, v1))
            elif inst == 0x10:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = True)
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = True)
                v3 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = True)
                log('    播放动画: {}, {}, {} #依次播放三个动画'.format(v1, v2, v3))
            elif inst == 0x11:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                log('    结束战斗')
                if v2 == 0x00:
                    log('    指定地图: 1<城市>, {}<{}>'.format(v1 + 1, cityName[v1]))
                elif v2 == 0x10:
                    log('    指定地图: 0<大地图>')
                elif v2 == 0x20:
                    if v1 < len(sceneName):
                        s1 = sceneName[v1]
                    else:
                        s1 = '地图编号'
                    log('    指定地图: 2<场所>, {}<{}>'.format(v1, s1))
                elif v2 == 0x30:
                    s1 = warfareName[v1]
                    log('    指定地图: 3<战场>, {}<{}>'.format(v1 + 1, s1))
                else:
                    log('    inst 0x{:0>2x} ([错误])指定战场/场景/大地图: 0x{:0>2x} 0x{:0>2x}'.format(inst, v1, v2))
            elif inst == 0x12:
                log('    结束本章')
            elif inst == 0x13:
                log('    结束本节')
            elif inst == 0x14:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                if v2 == 0x00:
                    log('    设置标记: {}, 真'.format(v1))
                elif v2 == 0x01:
                    log('    设置标记: {}, 假'.format(v1))
                else:
                    log('    [错误] 设置标记: {}, {}'.format(v1, v2))
            elif inst == 0x15:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                if v1 == 0x00:
                    s1 = "是"
                elif v1 == 0x01:
                    s1 = "否"
                else:
                    s1 = "[错误]"
                # log('    询问是否: <若选择>{}<{}>, <跳过下面>{}<个指令>'.format(v1, s1, v2))
                log('    询问是否: {}<{}> # 若满足条件 则执行下面缩进的指令'.format(v1, s1))
                if indent2 > 0:
                    print('[Warning!!!]subInst in subInst @{} {} {} {}'.format(CID, SCID, SID, SSID, GID))
                    log('[Warning!!!]subInst in subInst')
                elif indent1 > 0:
                    indent2 = v2 + 1
                else:
                    indent1 = v2 + 1
            elif inst == 0x17:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                if v1 == 0x00:
                    text = '可以操作'
                elif v1 == 0x01:
                    text = '无法操作'
                else:
                    text = '未知'
                log('    设置模式: {}<{}>'.format(v1, text))
            elif inst == 0x18:
                v1 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                kdef.seek(6, 1)
                log('    人物消失: {}<{}> #人物消失、部队撤退'.format(v1 + 1, roleName[v1]))
            elif inst == 0x1a:
                v1 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                log('    援军出现: {}<{}>'.format(v1 + 1, roleName[v1]))
            elif inst == 0x1b:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                log('    获得道具: {}<{}>'.format(v1 + 1, itemName[v1]))
            elif inst == 0x1c:
                v1 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                if v2 == 0x00 or v2 == 0x01 or v2 == 0x02:
                    kdef.seek(2, 1)
                    log('    改变AI: {}<{}>, {}<{}>'.format(v1 + 1, roleName[v1], v2, aiName[v2]))
                elif v2 == 0x03 or v2 == 0x05:
                    v3 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                    log('    改变AI: {}<{}>, {}<{}>, <目标>{}<{}>'.format(v1 + 1, roleName[v1], v2, aiName[v2], v3 + 1, roleName[v3]))
                elif v2 == 0x04 or v2 == 0x06:
                    v3 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                    v4 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                    log('    改变AI: {}<{}>, {}<{}>, <目标>{}, {}'.format(v1 + 1, roleName[v1], v2, aiName[v2], v3, v4))
            elif inst == 0x1d:
                # 指令1D可能是强行移动，比如虎牢关的吕布，长沙的魏延。
                # v1似乎和城市有关
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                s1 = cityName[v1]
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v3 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v4 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                log('    未知指令0x1d: {}<{}>, {}, {}, {} # 怀疑和城市相关'.format(v1 + 1, s1, v2, v3, v4))
            elif inst == 0x1e:
                log('    未知指令0x1e # 怀疑是黑屏')
            elif inst == 0x1f:
                log('    未知指令0x1f')
            elif inst == 0x20:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                # kdef.seek(v1 & 0x7f, 1)
                citys = list(range(len(cityName)))
                for j in range(v1 & 0x7f):
                    v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                    citys.remove(v2)
                s0 = [ '{}<{}>'.format(j + 1, cityName[j]) for j in citys]
                log('    开启城市: {}'.format(', '.join(s0)))
                # log('    inst 0x{:0>2x} 待分析: {}'.format(inst, v1))
                #猜测，指令20可能是在非剧情模式（可以使用鼠标）的情况下指定可以去的城市代码。
            elif inst == 0x21:
                s = '    判断标记: '
                parms = []
                jmp = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                if v1 > 0:
                    for j in range(v1):
                        eid = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                        parms.append(str(eid))
                        # if j > 0:
                        #     s += ','
                        # s += str(eid)
                    # s += ' 为真'
                    parms.append('真')
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                if v2 > 0:
                    # if v1 > 0:
                    #     s += ' 且 '
                    for j in range(v2):
                        eid = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                        parms.append(str(eid))
                    #     if j > 0:
                    #         s += ','
                    #     s += str(eid)
                    # s += ' 为假'
                    parms.append('假')
                s += ', '.join(parms)
                # s += '时 跳过下面{}个指令 #下面缩进的指令'.format(jmp)
                s += ' # 若满足条件 则执行下面缩进的指令'
                log(s)
                if indent2 > 0:
                    print('[Warning!!!]subInst in subInst @{} {} {} {}'.format(CID, SCID, SID, SSID, GID))
                    log('[Warning!!!]subInst in subInst')
                elif indent1 > 0:
                    indent2 = jmp + 1
                else:
                    indent1 = jmp + 1
            elif inst == 0x22:
                kdef.seek(1, 1)
                for j in range(30):
                    # log('0x{:0>4x}'.format(kdef.tell()))
                    vv1 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                    if vv1 >= 0x0400:
                        kdef.seek(17, 1)
                        continue
                    else:
                        ss1 = roleName[vv1]
                    vv2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                    vv3 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                    vv4 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                    if vv4 == 0x01:
                        ss4 = '是'
                    else:
                        ss4 = '否'
                    vv5 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                    vv6 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = True)
                    if vv6 >=0 and vv6 <= 3:
                        ss6 = directionName[vv6]
                    else:
                        ss6 = '自动'
                    vv7 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                    if vv7 == 0x01:
                        ss7 = '是'
                    else:
                        ss7 = '否'
                    vv8 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                    if vv8 == 0x00 or vv8 == 0x01 or vv8 == 0x02:
                        kdef.seek(2, 1)
                        ss8 = '<{}>'.format(aiName[vv8])
                    elif vv8 == 0x03 or vv8 == 0x05:
                        vv9 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                        ss9 = roleName[vv9]
                        ss8 = '<{}>, <目标>{}<{}>'.format(aiName[vv8], vv9 + 1, ss9)
                    elif vv8 == 0x04 or vv8 == 0x06:
                        vv9 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                        vv10 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                        ss8 = '<{}>, <目标>{}, {}'.format(aiName[vv8], vv9, vv10)
                    vv11 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                    ss11 = unitName[vv11]
                    vv12 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                    kdef.seek(6, 1)
                    log('    部署敌军: {}<{}>, <坐标>{}, {}, <判断标记出场>{}<{}>, <标记>{}, <方向>{}<{}>, <伏兵>{}<{}>, {}<{}>, <等级>{}, <AI>{}{}'.format(vv1 + 1, ss1, vv2 + 1, vv3 + 1, vv4, ss4, vv5, vv6, ss6, vv7, ss7, vv11 + 1, ss11, vv12, vv8, ss8, vv11, vv12))
            elif inst == 0x23:
                log('    选择部队')
            elif inst == 0x24:
                v1 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                log('    修改阵营: {}<{}>, {}<{}> #只有1和7是我军'.format(v1 + 1, roleName[v1], v2 + 1, forceName[v2]))
            elif inst == 0x25:
                pos = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                text = readText(pos).replace('\\n\\n', '\\n')
                log('    显示选单: {}'.format(text))
            elif inst == 0x26:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v3 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                log('    改变地形: <坐标>{}, {}, {}<{}>'.format(v1, v2, v3, terrainName[v3]))
            elif inst == 0x27:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v3 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                if v3 == 0x00:
                    log('    放火: <坐标>{}, {}'.format(v1, v2))
                elif v3 == 0x01:
                    log('    放水: <坐标>{}, {}'.format(v1, v2))
                elif v3 == 0x02:
                    log('    取消放水: <坐标>{}, {}'.format(v1, v2))
                elif v3 == 0x03:
                    log('    取消放火: <坐标>{}, {}'.format(v1, v2))
                else:
                    log('    [错误] 放火或放水 {} {}'.format(v1, v2, v3))
            elif inst == 0x28:
                v1 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                # log('    战斗时修改阵营: {}<{}>, {}'.format(v1, roleName[v1], v2))
                log('    修改阵营: {}<{}>, {}<{}> #只有0和6是我军'.format(v1 + 1, roleName[v1], v2, forceName[v2]))
            elif inst == 0x29:
                log('    游戏失败')
            elif inst == 0x2a:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                log('    显示结局: {}'.format(v1))
            elif inst == 0x2b:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v2 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                if v1 == 0x00:
                    log('    孔明寿命: <减少>{}'.format(v2))
                elif v1 == 0x02:
                    log('    计数器增加: {}'.format(v2))
                elif v1 == 0x03:
                    log('    计数器赋值: {}'.format(v2))
                elif v1 == 0x04:
                    log('    获得黄金: {}'.format(v2))
                elif v1 == 0x05:
                    log('    获得经验: {} #仅残余部队'.format(v2))
                elif v1 == 0x06:
                    log('    未知指令0x2b: {}, {} # 怀疑和数据修改相关'.format(v1, v2))
                else:
                    log('    [错误] 获得黄金或经验 {} {}'.format(v1, v2))
            elif inst == 0x2c:
                log('    未知指令0x2c # 怀疑是等待移动完毕')
            elif inst == 0x2d:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                log('    兵力士气减半: {}, {}'.format(v1, v2))
            elif inst == 0x2e:
                v1 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                # v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                kdef.seek(3, 1) # 后面三字节总是为 0 0 -1 怀疑没有用处
                log('    切换城市: {}<{}>'.format(v1 + 1, cityName[v1]))
            elif inst == 0x2f:
                v1 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                log('    修改人物未知属性: {}<{}>, {}'.format(v1 + 1, roleName[v1], v2))
            elif inst == 0x30:
                pos = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                text = readText(pos)
                log('    设置任务目标: {}'.format(text))
            elif inst == 0x31:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v3 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                if v3 == 0x00:
                    s3 = '大于等于'
                elif v3 == 0x01:
                    s3 = '小于'
                else:
                    s3 = '[错误]'
                v4 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                if v1 == 0x00:
                    log('    判断条件: 0<孔明寿命>, {}<{}>, {} # 若满足条件 则执行下面缩进的指令'.format(v3, s3, v2, v4))
                elif v1 == 0x01:
                    log('    判断条件: 1<计数器>, {}<{}>, {} # 若满足条件 则执行下面缩进的指令'.format(v3, s3, v2, v4))
                else:
                    log('    inst 0x{:0>2x} (未确认)>>> {} {} {} {} @ 0x{:0>4x}'.format(inst, v1, v2, v3, v4, kdef.tell() - 1))
                if indent2 > 0:
                    print('[Warning!!!]subInst in subInst @{} {} {} {}'.format(CID, SCID, SID, SSID, GID))
                    log('[Warning!!!]subInst in subInst')
                elif indent1 > 0:
                    indent2 = v4 + 1
                else:
                    indent1 = v4 + 1
                # kdef.seek(4, 1)
            elif inst == 0x32:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v2 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                s2 = roleName[v2]
                v4 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v5 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v6 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v7 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v8 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                if v8 == 0x00:
                    s8 = '我军'
                elif v8 == 0x01:
                    s8 = '敌军'
                elif v8 == 0x02:
                    s8 = '全体'
                else:
                    s8 = '[错误]'
                v9 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                s9 = ('攻击', '防御', '耐久', '状态')[v9]
                v10 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                if v9 == 0x00 or v9 == 0x01:
                    s10 = ('双升', '单升', '正常', '单降', '双降')[v10]
                elif v9 == 0x02:
                    s10 = '兵力{:-0}'.format(v10)
                elif v9 == 0x03:
                    s10 = ''
                    if v10 & 0x01 > 0:
                        s10 += '移动力下降'
                    if v10 & 0x02 > 0:
                        s10 += '攻击速度下降'
                    if v10 & 0x04 > 0:
                        s10 += '封策'
                    if v10 & 0x08 > 0:
                        s10 += '对策'
                    if v10 & 0x10 > 0:
                        s10 += '混乱'
                    if v10 & 0x20 > 0:
                        s10 += '耐久力每回合减少'
                else:
                    s10 = '[错误]'
                # log('    inst 0x32: {} {} {} {} {} {} {} {} {} @0x{:0>4x}'.format(v1, v2, v4, v5, v6, v7, v8, v9, v10, kdef.tell() - 11))
                if v1 == 0x00:
                    log('    改变部队状态: {}<{}>, {}<{}>, {}<{}>'.format(v2 + 1, s2, v9, s9, v10, s10))
                elif v1 == 0x01:
                    log('    范围改变部队状态: <左上角坐标>{}, {}, <右下角坐标>{}, {}, {}<{}>, {}<{}>, {}<{}>'.format(v4, v5, v6, v7, v8, s8, v9, s9, v10, s10))
                else:
                    log('    inst 0x32[错误]: {} {} {} {} {} {} {} {} {} @0x{:0>4x}'.format(v1, v2, v4, v5, v6, v7, v8, v9, v10, kdef.tell() - 11))
            elif inst == 0x33:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                log('    未知指令0x33: {}, {} # 一般在放火前后出现'.format(v1, v2))
            elif inst == 0x34:
                v1 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                s1 = roleName[v1]
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                log('    人物表情: {}<{}>, {} # 可能不准确'.format(v1 + 1, s1, v2))
            elif inst == 0x35:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v3 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v4 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                s1 = cityName[v1]
                s2 = cityName[v2]
                s3 = forceName[v3]
                log('    大地图部队移动: <从>{}<{}>, <到>{}<{}>, <势力>{}<{}>, {}'.format(v1 + 1, s1, v2 + 1, s2, v3, s3, v4))
            elif inst == 0x36:
                log('    进入战斗')
            elif inst == 0x37:
                v1 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                s1 = roleName[v1]
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v3 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                s3 = directionName[v3]
                log('    人物动作: {}<{}>, <动作编号>{}, <方向>{}<{}>'.format(v1 + 1, s1, v2, v3, s3))
            elif inst == 0x38:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = True)
                log('    播放音乐: {}'.format(v1))
            elif inst == 0x39:
                v1 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                log('    升级: {}<{}>, {}'.format(v1 + 1, roleName[v1], v2))
            elif inst == 0x3a:
                v1 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                log('    转职: {}<{}>, {}<{}>'.format(v1 + 1, roleName[v1], v2, unitName[v2]))
            elif inst == 0x3b:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                v2 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                log('    移动镜头: <坐标>{}, {}'.format(v1, v2))
            elif inst == 0x3c:
                v1 = int.from_bytes(kdef.read(2), byteorder = 'little', signed = False)
                log('    定位部队: {}<{}> #可能不对'.format(v1 + 1, roleName[v1]))
            elif inst == 0x3d:
                v1 = int.from_bytes(kdef.read(1), byteorder = 'little', signed = False)
                if v1 == 0x00:
                    log('    提示存档: 通常')
                elif v1 == 0x01:
                    log('    提示存档: 战场')
                else:
                    log('    [错误] 存档: {}'.format(v1))
            else:
                log('    unknown inst: 0x{:0>2x} @ 0x{:0>4x}'.format(inst, kdef.tell() - 1))
                break

    output.close()
    kdef.close()
    talk.close()
# print(groupInfo)

dumpKdef(0, 0)
dumpKdef(0, 1)
dumpKdef(0, 2)
dumpKdef(1, 0)
dumpKdef(1, 1)
dumpKdef(1, 2)
dumpKdef(2, 0)
dumpKdef(2, 1)
dumpKdef(2, 2)
dumpKdef(2, 3)
dumpKdef(3, 0)
dumpKdef(3, 1)
dumpKdef(4, 0)
dumpKdef(4, 1)
dumpKdef(4, 2)
dumpKdef(5, 0)
dumpKdef(5, 1)
dumpKdef(5, 2)
dumpKdef(5, 3)