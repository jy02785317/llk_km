#coding=utf-8
import os
resPath = '.\\res\\'

ekd2 = open(os.path.join(resPath, 'EKD2W95_Cracked.exe'), 'rb')
bakdata = open(os.path.join(resPath, 'BAKDATA.E2'), 'rb')
output = open(os.path.join('.\\', 'r.txt'), 'w')

def readTextRaw(fp):
    address = fp.tell()
    txt = b''
    while True:
        s = fp.read(1)
        if s == b'\x00':
            break;
        txt += s
    #handle some big5 char
    txt = txt.replace(b'\xa1\x40', b'  ')
    # print('offset = 0x{:0>4x}, {}'.format(address, txt))
    return txt.decode('gbk')

def mPrint(str):
    if False:
        print(str)
    else:
        output.write(str + '\n')

#role
#bakdata有每个武将的初始数据，以0x3af0H诸葛亮的数据开始
#０６　　０Ａ　　１８　　２Ｄ　　２Ｃ　００　　２８　　００　　１２　　０１　　００　　　88 ff ff ff ff ff ff ff ff ff ff ff ff ff ff
#阵营　　武力　　统御力　智力　　耐力　　　　　策略　　　　　　职业　　等级　　经验值　　15个道具位置(诸葛亮自带蒲扇)
mPrint('int_编号\tstring_名称\tint_阵营\tint_武力\tint_统御\tint_智力\tint_耐久\tint_策略\tint_兵种\tint_等级\tint_经验\tint_道具1\tint_道具2\tint_道具3\tint_道具4\tint_道具5\tint_道具6\tint_道具7\tint_道具8\tint_道具9\tint_道具10\tint_道具11\tint_道具12\tint_道具13\tint_道具14\tint_道具15')
for id in range(512):
    bakdata.seek(0x18f0 + 0x11 * id)
    name = readTextRaw(bakdata)
    bakdata.seek(0x3af0 + 0x1a * id)
    role = [id, name]
    role.append( int.from_bytes(bakdata.read(1), byteorder = 'little', signed = True) )
    for i in range(3):
        role.append( int.from_bytes(bakdata.read(1), byteorder = 'little', signed = False) )
    for i in range(2):
        role.append( int.from_bytes(bakdata.read(2), byteorder = 'little', signed = False) )
    for i in range(3):
        role.append( int.from_bytes(bakdata.read(1), byteorder = 'little', signed = False) )
    for i in range(15):
        item = int.from_bytes(bakdata.read(1), byteorder = 'little', signed = False)
        if item == 0xFF:
            item = -1
        role.append( item )
    mPrint( '\t'.join([str(v) for v in role]) )

#item name
item = []
for id in range(256):
    bakdata.seek(0x0900 + 0x10 * id)
    name = readTextRaw(bakdata)
    item.append(name)
mPrint(item)

output.close()
ekd2.close()
bakdata.close()

# print(groupInfo)