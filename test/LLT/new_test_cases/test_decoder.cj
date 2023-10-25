// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from charset import charset.*
from charset import charset.japanese.*
from charset import charset.exception.*
from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*

main(): Int64 {
    let decodeTest01 = DecodeTest01()

    decodeTest01.testEUCJPDecode01()
    decodeTest01.testEUCJPDecode02()
    decodeTest01.testISO2022JPDecode01()
    decodeTest01.testISO2022JPDecode02()
    decodeTest01.testISO2022JPDecode03()
    decodeTest01.testISO2022JPDecode04()
    decodeTest01.testShiftJISDecode01()
    decodeTest01.testShiftJISDecode02()
    decodeTest01.testEUCKRDecode01()
    decodeTest01.testEUCKRDecode02()
    decodeTest01.testGB18030Decode01()
    decodeTest01.testGB18030Decode02()
    decodeTest01.testGB18030Decode03()
    decodeTest01.testGB18030Decode04()
    decodeTest01.testIBM866Decode01()
    decodeTest01.testIBM866Decode02()
    decodeTest01.testBIG5Decode01()
    decodeTest01.testBIG5Decode02()
    decodeTest01.testBIG5HKSCSDecode01()
    decodeTest01.testUTF8Decode01()
    decodeTest01.testUTF8Decode02()
    decodeTest01.testUTF16BEDecode01()
    decodeTest01.testUTF16LEDecode01()
    decodeTest01.testUTF16BEDecode02()
    decodeTest01.testUTF16LEDecode02()
    decodeTest01.testUTF32BEDecode01()
    decodeTest01.testUTF32LEDecode01()

    return 0
}

@Test
public class DecodeTest01 {

    let str: String = "z,ncm,xzjiu"
    let str_en: String = "中有华为，华有仓颉"
    let str_emp: String = ""
    let str_te: String = "¥‾｡（ﾟ）−"
    let str_te2: String = "¥‾゛゜ \\~`!@#$%^&*()_+-=[]{}|"
    let str_te3: String = "婥€ḿ"
    var des: Array<Char> = Array<Char>(6, {_ => '\u{0}'})

    @TestCase
    public func testEUCJPDecode01(): Unit {
        var jp = Charsets.EUCJP
        var jpen = jp.newEncoder()
        var jpde = jp.newDecoder()
        let src: Array<UInt8> = jpen.encode(str)
        jpde.decode(src, des)
        try {
            let src2: Array<UInt8> = jpen.encode(str_en)
            jpde.decode(src2, des)
        } catch (e: EncoderException) {
            e.printStackTrace()
        }
    }

    @TestCase
    public func testEUCJPDecode02(): Unit {
        var jp = Charsets.EUCJP
        var jpen = jp.newEncoder()
        var jpde = jp.newDecoder()
        let src: Array<UInt8> = jpen.encode(str_te)
        let res = jpde.decode(src, des)
        @Assert(res[0], 10)
        @Assert(res[1], 6)
    }

    @TestCase
    public func testISO2022JPDecode01(): Unit {
        var jp = Charsets.ISO_2022_JP
        var jpen = jp.newEncoder()
        var jpde = jp.newDecoder()
        let src: Array<UInt8> = jpen.encode(str)
        let res = jpde.decode(src, des)
        @Assert(res[0], 6)
        @Assert(res[1], 6)
    }

    @TestCase
    public func testISO2022JPDecode02(): Unit {
        var jp = Charsets.ISO_2022_JP
        var jpen = jp.newEncoder()
        var jpde = jp.newDecoder()
        let src: Array<UInt8> = jpen.encode(str_te)
        let res = jpde.decode(src, des)
        @Assert(res[0], 12)
        @Assert(res[1], 6)
    }

    @TestCase
    public func testISO2022JPDecode03(): Unit {
        var jp = Charsets.ISO_2022_JP
        var jpen = jp.newEncoder()
        var jpde = jp.newDecoder()
        let src: Array<UInt8> = jpen.encode(str_te2)
        let res = jpde.decode(src, des)
        @Assert(res[0], 14)
        @Assert(res[1], 6)
    }

    @TestCase
    public func testISO2022JPDecode04(): Unit {
        var flag = false
        try{
            let s = "A¥C\u{1B}\u{28}\u{42}ｱ中🐱B日‾ｲ文"
            var jp = Charsets.ISO_2022_JP
            var jpen = jp.newEncoder()
            var jpde = jp.newDecoder()
            let src: Array<UInt8> = jpen.encode(s)
            jpde.decode(src, des)
        }catch(e:EncoderException){
            flag = true
        }
        @Assert(flag,true)
    }

    @TestCase
    public func testShiftJISDecode01(): Unit {
        var flag = false
        try{
            var jp = Charsets.SHIFT_JIS
            var jpen = jp.newEncoder()
            var jpde = jp.newDecoder()
            let src: Array<UInt8> = jpen.encode(str_en)
            jpde.decode(src, des)
        }catch(e:EncoderException){
            flag = true
        }
        @Assert(flag,true)
    }

    @TestCase
    public func testShiftJISDecode02(): Unit {
        var jp = Charsets.SHIFT_JIS
        var jpen = jp.newEncoder()
        var jpde = jp.newDecoder()
        let src: Array<UInt8> = jpen.encode(str_te)
        let res = jpde.decode(src, des)
        @Assert(res[0], 8)
        @Assert(res[1], 6)
    }

    @TestCase
    public func testEUCKRDecode01(): Unit {
        var flag = false
        var kr = Charsets.EUCKR
        var kren = kr.newEncoder()
        var krde = kr.newDecoder()
        try {
            let src: Array<UInt8> = kren.encode(str_te)
            krde.decode(src, des)
        } catch(e:EncoderException){
            flag = true
        }
        @Assert(flag,true)
    }

    @TestCase
    public func testEUCKRDecode02(): Unit {
        var kr = Charsets.EUCKR
        var kren = kr.newEncoder()
        var krde = kr.newDecoder()
        let src: Array<UInt8> = kren.encode(str)
        let res = krde.decode(src, des)
        @Assert(res[0], 6)
        @Assert(res[1], 6)
    }

    @TestCase
    public func testGB18030Decode01(): Unit {
        var gb = Charsets.GB18030
        var gben = gb.newEncoder()
        var gbde = gb.newDecoder()
        let src: Array<UInt8> = gben.encode(str_te)
        let res = gbde.decode(src, des)
        @Assert(res[0], 20)
        @Assert(res[1], 6)
    }

    @TestCase
    public func testGB18030Decode02(): Unit {
        var gb = Charsets.GB18030
        var gben = gb.newEncoder()
        var gbde = gb.newDecoder()
        let src: Array<UInt8> = gben.encode(str)
        let res = gbde.decode(src, des)
        @Assert(res[0], 6)
        @Assert(res[1], 6)
    }

    @TestCase
    public func testGB18030Decode03(): Unit {
        var gb = Charsets.GB18030
        var gben = gb.newEncoder()
        var gbde = gb.newDecoder()
        let src: Array<UInt8> = gben.encode(str_te3)
        let res = gbde.decode(src, des)
        @Assert(res[0], 6)
        @Assert(res[1], 3)
    }

    @TestCase
    public func testGB18030Decode04(): Unit {
        let s = "A€\u{1B}\u{28}\u{42}中！𠀀🐱\u{81}\u{3F}🐱"
        var gb = Charsets.GB18030
        var gben = gb.newEncoder()
        var gbde = gb.newDecoder()
        let src: Array<UInt8> = gben.encode(s)
        let res = gbde.decode(src, des)
        @Assert(res[0], 8)
        @Assert(res[1], 6)
    }

    @TestCase
    public func testIBM866Decode01(): Unit {
        var ib = Charsets.IBM866
        var iben = ib.newEncoder()
        var ibde = ib.newDecoder()
        let src: Array<UInt8> = iben.encode(str)
        let res = ibde.decode(src, des)
        @Assert(res[0], 6)
        @Assert(res[1], 6)
    }

    @TestCase
    public func testIBM866Decode02(): Unit {
        var flag = false
        try{
            var ib = Charsets.IBM866
            var iben = ib.newEncoder()
            var ibde = ib.newDecoder()
            let src: Array<UInt8> = iben.encode(str_te)
            ibde.decode(src, des)
        }catch(e:EncoderException){
            flag = true
        }
        @Assert(flag,true)
    }

    @TestCase
    public func testBIG5Decode01(): Unit {
        var flag = false
        try{
            var b5 = Charsets.BIG5
            var b5en = b5.newEncoder()
            var b5de = b5.newDecoder()
            let src: Array<UInt8> = b5en.encode(str)
            b5en.encode(str_te)
            b5de.decode(src, des)
        }catch(e:EncoderException){
            flag = true
        }
        @Assert(flag,true)
    }

    @TestCase
    public func testBIG5Decode02(): Unit {
        let s = ""
        var b5 = Charsets.BIG5
        var b5en = b5.newEncoder()
        b5en.encode(s)
    }

    @TestCase
    public func testBIG5HKSCSDecode01(): Unit {
        var flag = false
        try{
            var b5hk = Charsets.BIG5_HKSCS
            var b5hken = b5hk.newEncoder()
            var b5hkde = b5hk.newDecoder()
            let src: Array<UInt8> = b5hken.encode(str_te)
            b5hkde.decode(src, des)
        }catch(e:EncoderException){
            flag = true
        }
        @Assert(flag,true)
    }

    @TestCase
    public func testUTF8Decode01(): Unit {
        var u8 = Charsets.UTF8
        var u8en = u8.newEncoder()
        var u8de = u8.newDecoder()
        let src: Array<UInt8> = u8en.encode(str)
        u8en.encode(str_te)
        let res = u8de.decode(src, des)
        @Assert(res[0], 6)
        @Assert(res[1], 6)
    }

    @TestCase
    public func testUTF8Decode02(): Unit {
        let s: String = "ìíîïðñòóôõöùúûüýþÿþÿíîïð"
        var u8 = Charsets.UTF8
        var ds: Array<Char> = Array<Char>(255, {_ => '\u{0}'})
        var u8en = u8.newEncoder()
        var u8de = u8.newDecoder()
        let src: Array<UInt8> = u8en.encode(s)
        let src2: Array<UInt8> = u8en.encode("ABC")
        let src3: Array<UInt8> = u8en.encode("äöü")
        let src4: Array<UInt8> = u8en.encode(str_en)
        let src5: Array<UInt8> = u8en.encode("😁")
        let src6: Array<UInt8> = u8en.encode("ä日")
        let res = u8de.decode(src, ds)
        u8de.decode(src2, ds)
        u8de.decode(src3, ds)
        u8de.decode(src4, ds)
        u8de.decode(src5, ds)
        u8de.decode(src6, ds)
        @Assert(res[0], 99)
        @Assert(res[1], 50)
    }

    @TestCase
    public func testUTF16BEDecode01(): Unit {
        var u16be = Charsets.UTF16BE
        var u16been = u16be.newEncoder()
        var u16bede = u16be.newDecoder()
        let src: Array<UInt8> = u16been.encode(str_te)
        let res = u16bede.decode(src, des)
        @Assert(res[0], 12)
        @Assert(res[1], 6)
    }

    @TestCase
    public func testUTF16BEDecode02(): Unit {
        var u16be = Charsets.UTF16BE
        var u16been = u16be.newEncoder()
        var u16bede = u16be.newDecoder()
        let src: Array<UInt8> = u16been.encode(str)
        let res = u16bede.decode(src, des)
        @Assert(res[0], 12)
        @Assert(res[1], 6)
    }

    @TestCase
    public func testUTF16LEDecode01(): Unit {
        var u16le = Charsets.UTF16LE
        var u16leen = u16le.newEncoder()
        var u16lede = u16le.newDecoder()
        let src: Array<UInt8> = u16leen.encode(str_te)
        let res = u16lede.decode(src, des)
        @Assert(res[0], 12)
        @Assert(res[1], 6)
    }

    @TestCase
    public func testUTF16LEDecode02(): Unit {
        var u16le = Charsets.UTF16LE
        var u16leen = u16le.newEncoder()
        var u16lede = u16le.newDecoder()
        let src: Array<UInt8> = u16leen.encode(str)
        let res = u16lede.decode(src, des)
        @Assert(res[0], 12)
        @Assert(res[1], 6)
    }

    @TestCase
    public func testUTF32BEDecode01(): Unit {
        var u32be = Charsets.UTF32BE
        var u32been = u32be.newEncoder()
        var u32bede = u32be.newDecoder()
        let src: Array<UInt8> = u32been.encode(str_te)
        let res = u32bede.decode(src, des)
        @Assert(res[0], 24)
        @Assert(res[1], 6)
    }

    @TestCase
    public func testUTF32LEDecode01(): Unit {
        var u32le = Charsets.UTF32LE
        var u32leen = u32le.newEncoder()
        var u32lede = u32le.newDecoder()
        let src: Array<UInt8> = u32leen.encode(str_te)
        let res = u32lede.decode(src, des)
        @Assert(res[0], 24)
        @Assert(res[1], 6)
    }

}
