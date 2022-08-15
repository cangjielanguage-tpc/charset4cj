// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from charset import charset.*

main (){
    if (big5() != 0) {
        print("big5 fail")
        return 1
    }
    if (gb18030() != 0) {
        print("gb18030 fail")
        return 1
    }
    if (ibm866() != 0) {
        print("ibm866 fail")
        return 1
    }
    if (euk() != 0) {
        print("euk fail")
        return 1
    }
    return 0
}

public func big5(){
    var charset = Charsets.big5
    var encoder = charset.newEncoder()
    var decoder = charset.newDecoder()
    var buf1 = Array<UInt8>([0xB0, 0xDA, 0xA7, 0x41])
    var s1 = decoder.decode(buf1)
//@Assert(s1, "碉峴")
    if (!s1.equals("碉峴")) {
        return 1
    }
    return 0
}

public func gb18030() {
    var charset = match(Charsets.forName("gb18030")){
        case Some(cs) => cs
        case _ => Charsets.gb18030
    }
    var decoder = charset.newDecoder()

    // 单 字节解码
    var buf1 = Array<UInt8>([65, 66, 67, 65, 66, 67])
    var s1 = decoder.decode(buf1)
    if (!s1.equals("ABCABC")) {
        return 1
    }

    // 双 字节解码
    var buf2 = Array<UInt8>([0xC4, 0xE3, 0xBA, 0xC3,0xCE, 0xD2])
    var s2 = decoder.decode(buf2)
    if (!s2.equals("你好我")) {
        return 1
    }
    // 四字节 𬌗
    var buf4 = Array<UInt8>([0x99,0x31,0xD2,0x39,0x99,0x31,0xD2,0x39,0x99,0x31,0xD2,0x39,0x99,0x31,0xD2,0x39,0x99,0x31,0xD2,0x39])
    var s4 = decoder.decode(buf4)
    if (!s4.equals("𬌗𬌗𬌗𬌗𬌗")) {
        return 1
    }

    return 0
}

public func ibm866(){
    var charset = match(Charsets.forName("IBM866")){
    case Some(cs) => cs
    case _ => Charsets.ibm866
    }
    // var charset = SingleByteCharset("IBM866")
    var decoder = charset.newDecoder()
    var buf1 = Array<UInt8>([0x80, 0x81,0x82,0x83,0x84,0x85])
    var s1 = decoder.decode(buf1)
    if (!s1.equals("АБВГД")) {
        return 1
    }
    print("s1:${s1}\t")
    return 0
}

public func euk(){
    // var charset = EUCKRCharset()
    var charset = match(Charsets.forName("EUCKR")){
    case Some(cs) => cs
    case _ => Charsets.euckr
    }
    var encoder = charset.newEncoder()
    var decoder = charset.newDecoder()

    var buf1 = Array<UInt8>([0xB9, 0xD0])

    var s1 = decoder.decode(buf1)
    println(s1)
    // b9d0	밀
    if (s1 != "밀") {
        return 1
    }
    return 0
}


func utf16betest(){
    // var charset = UTF16Charset(true) // 大端
    var charset = match(Charsets.forName("UTF-16BE")){
    case Some(cs) => cs
    case _ => Charsets.utf16be
    }
    var decoder = charset.newDecoder()

    var encoder = charset.newEncoder()
    var arr = encoder.encode("啊𬌗𬌗𬌗𬌗𬌗𬌗𬌗𬌗")

    var s = decoder.decode(arr)
    // @Assert(s, "啊𬌗𬌗𬌗𬌗𬌗𬌗𬌗𬌗")
    var buf1 = Array<UInt8>([0x55, 0x4a,0x62,0x11,0xD8, 0x70, 0xDF, 0x17])
    var s1 = decoder.decode(buf1)
    print("s1：${s1}\n")
    if (!s.equals("啊𬌗𬌗𬌗𬌗𬌗𬌗𬌗𬌗")) {
        return 1
    }
    return 0
}
