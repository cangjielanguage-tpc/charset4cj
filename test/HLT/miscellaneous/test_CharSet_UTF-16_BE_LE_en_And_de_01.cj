// 3rd_party_lib:charset/build/charset
// 3rd_party_lib_ohos:charset/build/aarch64-linux-ohos/charset

from std import unittest.*
from std import unittest.testmacro.*
from charset import charset.encoding.*
from charset import charset.*
from std import collection.*

@Test
public class TestCharsetUTF16{
    /*
        public func newDecoder():Decoder
        public func newEncoder():Encoder
        func encode(str:String): Array<UInt8>
        func decode(src:Array<UInt8>):String
        测试场景:编码字符串为空/非空
    */
    var encode_String="䖦丄ПРヲァŤŹÀÁÂЎЏАБВГДЕЖضطظعغΌ½ΎΏÁÂÃלםמĘĒČÊËÌゞ〃仝ίϊΐόςЁ╢╣ў╞╟╠╡ЁЄ╣òôöฝพฟťžźˇ˘¤Ґ¦§Ё©Є«¿ÀÁÂ»Ό½ΎΏΐ£₪¥¦§ŹĖĢĶÂĂИЙКЛМНОП"
    @TestCase
    func testCharsetUTF1601(): Unit {
        var encoder=Charsets.UTF16BE.newEncoder()
        var en_re=encoder.encode(encode_String)
        var exp_re=Array<UInt8>([69, 166, 78, 4, 4, 31, 4, 32, 48, 242, 48, 161, 1, 100, 1, 121, 0, 192, 0, 193, 0, 194, 4, 14, 4, 15, 4,
                                  16, 4, 17, 4, 18, 4, 19, 4, 20, 4, 21, 4, 22, 6, 54, 6, 55, 6, 56, 6, 57, 6, 58, 3, 140, 0, 189, 3, 142,
                                  3, 143, 0, 193, 0, 194, 0, 195, 5, 220, 5, 221, 5, 222, 1, 24, 1, 18, 1, 12, 0, 202, 0, 203, 0, 204, 48,
                                  158, 48, 3, 78, 221, 3, 175, 3, 202, 3, 144, 3, 204, 3, 194, 4, 1, 37, 98, 37, 99, 4, 94, 37, 94, 37, 95,
                                  37, 96, 37, 97, 4, 1, 4, 4, 37, 99, 0, 242, 0, 244, 0, 246, 14, 29, 14, 30, 14, 31, 1, 101, 1, 126, 1, 122,
                                  2, 199, 2, 216, 0, 164, 4, 144, 0, 166, 0, 167, 4, 1, 0, 169, 4, 4, 0, 171, 0, 191, 0, 192, 0, 193, 0, 194,
                                  0, 187, 3, 140, 0, 189, 3, 142, 3, 143, 3, 144, 0, 163, 32, 170, 0, 165, 0, 166, 0, 167, 1, 121, 1, 22, 1, 34,
                                  1, 54, 0, 194, 1, 2, 4, 24, 4, 25, 4, 26, 4, 27, 4, 28, 4, 29, 4, 30, 4, 31])
        @Assert(en_re,exp_re)
        var decoder=Charsets.UTF16BE.newDecoder()
        var de_re=decoder.decode(en_re)
        @Assert(de_re,encode_String)
    }
    @TestCase
    func testCharsetUTF1602(): Unit {
        var encoder=Charsets.UTF16LE.newEncoder()
        var en_re=encoder.encode(encode_String)
        var exp_re=Array<UInt8>([166, 69, 4, 78, 31, 4, 32, 4, 242, 48, 161, 48, 100, 1, 121, 1, 192, 0, 193, 0, 194, 0, 14, 4, 15, 4, 16, 4, 17, 4,
                                  18, 4, 19, 4, 20, 4, 21, 4, 22, 4, 54, 6, 55, 6, 56, 6, 57, 6, 58, 6, 140, 3, 189, 0, 142, 3, 143, 3, 193, 0, 194, 0,
                                  195, 0, 220, 5, 221, 5, 222, 5, 24, 1, 18, 1, 12, 1, 202, 0, 203, 0, 204, 0, 158, 48, 3, 48, 221, 78, 175, 3, 202, 3,
                                  144, 3, 204, 3, 194, 3, 1, 4, 98, 37, 99, 37, 94, 4, 94, 37, 95, 37, 96, 37, 97, 37, 1, 4, 4, 4, 99, 37, 242, 0, 244,
                                  0, 246, 0, 29, 14, 30, 14, 31, 14, 101, 1, 126, 1, 122, 1, 199, 2, 216, 2, 164, 0, 144, 4, 166, 0, 167, 0, 1, 4, 169,
                                  0, 4, 4, 171, 0, 191, 0, 192, 0, 193, 0, 194, 0, 187, 0, 140, 3, 189, 0, 142, 3, 143, 3, 144, 3, 163, 0, 170, 32, 165,
                                  0, 166, 0, 167, 0, 121, 1, 22, 1, 34, 1, 54, 1, 194, 0, 2, 1, 24, 4, 25, 4, 26, 4, 27, 4, 28, 4, 29, 4, 30, 4, 31, 4])
        @Assert(en_re,exp_re)
        var decoder=Charsets.UTF16LE.newDecoder()
        var de_re=decoder.decode(en_re)
        @Assert(de_re,encode_String)
    }
    @TestCase
    func testCharsetUTF1603(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.UTF16BE.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size+1,item:'c')
        var decoder=Charsets.UTF16BE.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetUTF1604(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.UTF16BE.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size,item:'c')
        var decoder=Charsets.UTF16BE.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetUTF1605(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.UTF16BE.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(encode_String.size-1,item:'c')
        var decoder=Charsets.UTF16BE.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],encoder.encode(encode_String[..encode_String.size-1]).size)
        @Assert(de_re[1],desc.size)
    }
    @TestCase
    func testCharsetUTF1606(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.UTF16LE.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size+1,item:'c')
        var decoder=Charsets.UTF16LE.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetUTF1607(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.UTF16LE.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size,item:'c')
        var decoder=Charsets.UTF16LE.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetUTF1608(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.UTF16LE.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(encode_String.size-1,item:'c')
        var decoder=Charsets.UTF16LE.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],encoder.encode(encode_String[..encode_String.size-1]).size)
        @Assert(de_re[1],desc.size)
    }
}
