// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from charset import charset.*
from charset import charset.japanese.*
from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*

main(): Int64 {
    let encodeTest01 = EncodeTest01()

    encodeTest01.testEUCJPEncode01()
    encodeTest01.testEUCJPEncode02()
    encodeTest01.testISO2022JPEncode01()
    encodeTest01.testISO2022JPEncode02()
    encodeTest01.testISO2022JPEncode03()
    encodeTest01.testISO2022JPEncode04()
    encodeTest01.testShiftJISEncode01()
    encodeTest01.testShiftJISEncode02()
    encodeTest01.testEUCKREncode01()
    encodeTest01.testEUCKREncode02()
    encodeTest01.testGB18030Encode01()
    encodeTest01.testGB18030Encode02()
    encodeTest01.testGB18030Encode03()
    encodeTest01.testGB18030Encode04()
    encodeTest01.testIBM866Encode01()
    encodeTest01.testIBM866Encode02()
    encodeTest01.testBIG5Encode01()
    encodeTest01.testBIG5Encode02()
    encodeTest01.testBIG5HKSCSEncode01()
    encodeTest01.testUTF8Encode01()
    encodeTest01.testUTF8Encode02()
    encodeTest01.testUTF16BEEncode01()
    encodeTest01.testUTF16LEEncode01()
    encodeTest01.testUTF16BEEncode02()
    encodeTest01.testUTF16LEEncode02()
    encodeTest01.testUTF32BEEncode01()
    encodeTest01.testUTF32LEEncode01()
    encodeTest01.testGB18030Encode05()
    encodeTest01.testGB18030Encode06()
    encodeTest01.testIBM866Encode03()
    encodeTest01.testIBM866Encode04()
    encodeTest01.testBIG5Encode04()
    encodeTest01.testBIG5Encode05()
    encodeTest01.testBIG5HKSCSEncode03()
    encodeTest01.testUTF8Encode03()
    encodeTest01.testUTF8Encode04()
    encodeTest01.testUTF16BEEncode03()
    encodeTest01.testUTF16LEEncode04()
    encodeTest01.testUTF16BEEncode05()
    encodeTest01.testUTF16LEEncode06()
    encodeTest01.testUTF32BEEncode03()
    encodeTest01.testUTF32LEEncode04()

    return 0
}

@Test
public class EncodeTest01 {

    let str: String = "dqkn5rmq,nfmz,vbn q2nm,1m4312k"
    let str_en: String = "嘿哟艾瑞，你还"
    let str_emp: String = ""
    let str_te: String = "¥‾｡（ﾟ）−"
    let str_te2: String = "¥‾゛゜ \\~`!@#$%^&*()_+-=[]{}|"
    let str_te3: String = "婥€ḿ"

    @TestCase
    public func testEUCJPEncode01(): Unit {
        var jp = Charsets.EUCJP
        var jpen = jp.newEncoder()
        jpen.encode(str)
        jpen.encode(str_en)
    }

    @TestCase
    public func testEUCJPEncode02(): Unit {
        var jp = Charsets.EUCJP
        var jpen = jp.newEncoder()
        jpen.encode(str_te)
    }

    @TestCase
    public func testISO2022JPEncode01(): Unit {
        var jp = Charsets.ISO_2022_JP
        var jpen = jp.newEncoder()
        jpen.encode(str)
    }

    @TestCase
    public func testISO2022JPEncode02(): Unit {
        var jp = Charsets.ISO_2022_JP
        var jpen = jp.newEncoder()
        jpen.encode(str_te)
    }

    @TestCase
    public func testISO2022JPEncode03(): Unit {
        var jp = Charsets.ISO_2022_JP
        var jpen = jp.newEncoder()
        jpen.encode(str_te2)
    }

    @TestCase
    public func testISO2022JPEncode04(): Unit {
        let s = "A¥C\u{1B}\u{28}\u{42}ｱ中🐱B日‾ｲ文"
        var jp = Charsets.ISO_2022_JP
        var jpen = jp.newEncoder()
        jpen.encode(s)
    }
    
    @TestCase
    public func testShiftJISEncode01(): Unit {
        var jp = Charsets.SHIFT_JIS
        var jpen = jp.newEncoder()
        jpen.encode(str_en)
    }

    @TestCase
    public func testShiftJISEncode02(): Unit {
        var jp = Charsets.SHIFT_JIS
        var jpen = jp.newEncoder()
        jpen.encode(str_te)
    }

    @TestCase
    public func testEUCKREncode01(): Unit {
        var kr = Charsets.EUCKR
        var kren = kr.newEncoder()
        kren.encode(str_te)
    }

    @TestCase
    public func testEUCKREncode02(): Unit {
        var kr = Charsets.EUCKR
        var kren = kr.newEncoder()
        kren.encode(str)
    }

    @TestCase
    public func testGB18030Encode01(): Unit {
        var gb = Charsets.GB18030
        var gben = gb.newEncoder()
        gben.encode(str_te)
    }

    @TestCase
    public func testGB18030Encode02(): Unit {
        var gb = Charsets.GB18030
        var gben = gb.newEncoder()
        gben.encode(str)
    }

    @TestCase
    public func testGB18030Encode03(): Unit {
        var gb = Charsets.GB18030
        var gben = gb.newEncoder()
        gben.encode(str_te3)
    }

    @TestCase
    public func testGB18030Encode04(): Unit {
        let s = "A€\u{1B}\u{28}\u{42}中！𠀀🐱\u{81}\u{3F}🐱"
        var gb = Charsets.GB18030
        var gben = gb.newEncoder()
        gben.encode(s)
    }

    @TestCase
    public func testIBM866Encode01(): Unit {
        var ib = Charsets.IBM866
        var iben = ib.newEncoder()
        iben.encode(str)
    }

    @TestCase
    public func testIBM866Encode02(): Unit {
        var ib = Charsets.IBM866
        var iben = ib.newEncoder()
        iben.encode(str_te)
    }

    @TestCase
    public func testBIG5Encode01(): Unit {
        var b5 = Charsets.BIG5
        var b5en = b5.newEncoder()
        b5en.encode(str)
        b5en.encode(str_te)
    }

    @TestCase
    public func testBIG5Encode02(): Unit {
        let s = ""
        var b5 = Charsets.BIG5
        var b5en = b5.newEncoder()
        b5en.encode(s)
    }

    @TestCase
    public func testBIG5HKSCSEncode01(): Unit {
        var b5hk = Charsets.BIG5_HKSCS
        var b5hken = b5hk.newEncoder()
        b5hken.encode(str_te)
    }

    @TestCase
    public func testUTF8Encode01(): Unit {
        var u8 = Charsets.UTF8
        var u8en = u8.newEncoder()
        u8en.encode(str)
        u8en.encode(str_te)
    }

    @TestCase
    public func testUTF8Encode02(): Unit {
        let s: String = "ìíîïðñòóôõöùúûüýþÿþÿíîïð"
        var u8 = Charsets.UTF8
        var u8en = u8.newEncoder()
        u8en.encode(s)
        u8en.encode("äöü")
        u8en.encode(str_en)
        u8en.encode("😁")
        u8en.encode("ä日")
    }

    @TestCase
    public func testUTF16BEEncode01(): Unit {
        var u16be = Charsets.UTF16BE
        var u16been = u16be.newEncoder()
        u16been.encode(str_te)
    }

    @TestCase
    public func testUTF16BEEncode02(): Unit {
        var u16be = Charsets.UTF16BE
        var u16been = u16be.newEncoder()
        u16been.encode(str)
    }

    @TestCase
    public func testUTF16LEEncode01(): Unit {
        var u16le = Charsets.UTF16LE
        var u16leen = u16le.newEncoder()
        u16leen.encode(str_te)
    }

    @TestCase
    public func testUTF16LEEncode02(): Unit {
        var u16le = Charsets.UTF16LE
        var u16leen = u16le.newEncoder()
        u16leen.encode(str)
    }

    @TestCase
    public func testUTF32BEEncode01(): Unit {
        var u32be = Charsets.UTF32BE
        var u32been = u32be.newEncoder()
        u32been.encode(str_te)
    }

    @TestCase
    public func testUTF32LEEncode01(): Unit {
        var u32le = Charsets.UTF32LE
        var u32leen = u32le.newEncoder()
        u32leen.encode(str_te)
    }

    @TestCase
    public func testGB18030Encode05(): Unit {
        var gb = Charsets.GB18030
        var gben = gb.newEncoder()
        gben.encode(str_te)
    }

    @TestCase
    public func testGB18030Encode06(): Unit {
        let s = "A€\u{1B}\u{28}\u{42}中！𠀀🐱\u{81}\u{3F}🐱1111122"
        var gb = Charsets.GB18030
        var gben = gb.newEncoder()
        gben.encode(s)
    }

    @TestCase
    public func testIBM866Encode03(): Unit {
        var ib = Charsets.IBM866
        var iben = ib.newEncoder()
        iben.encode(str_te)
    }

    @TestCase
    public func testIBM866Encode04(): Unit {
        var ib = Charsets.IBM866
        var iben = ib.newEncoder()
        iben.encode(str)
    }

    @TestCase
    public func testBIG5Encode03(): Unit {
        var b5 = Charsets.BIG5
        var b5en = b5.newEncoder()
        b5en.encode(str_te3)
    }

    @TestCase
    public func testBIG5Encode04(): Unit {
        let s = "dasasfgzxv214"
        var b5 = Charsets.BIG5
        var b5en = b5.newEncoder()
        b5en.encode(s)
    }

    @TestCase
    public func testBIG5Encode05(): Unit {
        let s = "12312452125o0890789y214"
        var b5 = Charsets.BIG5
        var b5en = b5.newEncoder()
        b5en.encode(s)
    }

    @TestCase
    public func testBIG5HKSCSEncode03(): Unit {
        var b5hk = Charsets.BIG5_HKSCS
        var b5hken = b5hk.newEncoder()
        b5hken.encode(str_te3)
    }

    @TestCase
    public func testUTF8Encode03(): Unit {
        var u8 = Charsets.UTF8
        var u8en = u8.newEncoder()
        u8en.encode(str_te3)
    }

    @TestCase
    public func testUTF8Encode04(): Unit {
        var u8 = Charsets.UTF8
        var u8en = u8.newEncoder()
        u8en.encode("😁")
        u8en.encode("ä日")
    }

    @TestCase
    public func testUTF16BEEncode03(): Unit {
        var u16be = Charsets.UTF16BE
        var u16been = u16be.newEncoder()
        u16been.encode(str_te3)
    }

    @TestCase
    public func testUTF16BEEncode05(): Unit {
        var u16be = Charsets.UTF16BE
        var u16been = u16be.newEncoder()
        u16been.encode(str_te)
    }

    @TestCase
    public func testUTF16LEEncode04(): Unit {
        var u16le = Charsets.UTF16LE
        var u16leen = u16le.newEncoder()
        u16leen.encode(str_te3)
    }

    @TestCase
    public func testUTF16LEEncode06(): Unit {
        var u16le = Charsets.UTF16LE
        var u16leen = u16le.newEncoder()
        u16leen.encode(str_te)
    }

    @TestCase
    public func testUTF32BEEncode03(): Unit {
        var u32be = Charsets.UTF32BE
        var u32been = u32be.newEncoder()
        u32been.encode(str_te3)
    }

    @TestCase
    public func testUTF32LEEncode04(): Unit {
        var u32le = Charsets.UTF32LE
        var u32leen = u32le.newEncoder()
        u32leen.encode(str_te3)
    }

}
