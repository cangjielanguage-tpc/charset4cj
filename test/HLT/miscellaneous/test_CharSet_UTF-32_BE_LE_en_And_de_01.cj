// 3rd_party_lib:charset/build/charset
// 3rd_party_lib_ohos:charset/build/aarch64-linux-ohos/charset

from std import unittest.*
from std import unittest.testmacro.*
from charset import charset.encoding.*
from charset import charset.*
from std import collection.*

@Test
public class TestCharsetUTF32{
    /*
        public func newDecoder():Decoder
        public func newEncoder():Encoder
        func encode(str:String): Array<UInt8>
        func decode(src:Array<UInt8>):String
        测试场景:编码字符串为空/非空
    */
    var encode_String="䖦丄ПРヲァŤŹÀÁÂЎЏАБВГДЕЖضطظعغΌ½ΎΏÁÂÃלםמĘĒČÊËÌゞ〃仝ίϊΐόςЁ╢╣ў╞╟╠╡ЁЄ╣òôöฝพฟťžźˇ˘¤Ґ¦§Ё©Є«¿ÀÁÂ»Ό½ΎΏΐ£₪¥¦§ŹĖĢĶÂĂИЙКЛМНОП"
    @TestCase
    func testCharsetUTF3201(): Unit {
        var encoder=Charsets.UTF32BE.newEncoder()
        var en_re=encoder.encode(encode_String)
        var exp_re=Array<UInt8>([0, 0, 69, 166, 0, 0, 78, 4, 0, 0, 4, 31, 0, 0, 4, 32, 0, 0, 48, 242, 0, 0, 48, 161, 0, 0, 1, 100, 0, 0, 1, 121, 0, 0,
                                   0, 192, 0, 0, 0, 193, 0, 0, 0, 194, 0, 0, 4, 14, 0, 0, 4, 15, 0, 0, 4, 16, 0, 0, 4, 17, 0, 0, 4, 18, 0, 0, 4, 19, 0, 0,
                                   4, 20, 0, 0, 4, 21, 0, 0, 4, 22, 0, 0, 6, 54, 0, 0, 6, 55, 0, 0, 6, 56, 0, 0, 6, 57, 0, 0, 6, 58, 0, 0, 3, 140, 0, 0, 0,
                                   189, 0, 0, 3, 142, 0, 0, 3, 143, 0, 0, 0, 193, 0, 0, 0, 194, 0, 0, 0, 195, 0, 0, 5, 220, 0, 0, 5, 221, 0, 0, 5, 222, 0,
                                   0, 1, 24, 0, 0, 1, 18, 0, 0, 1, 12, 0, 0, 0, 202, 0, 0, 0, 203, 0, 0, 0, 204, 0, 0, 48, 158, 0, 0, 48, 3, 0, 0, 78, 221, 0,
                                   0, 3, 175, 0, 0, 3, 202, 0, 0, 3, 144, 0, 0, 3, 204, 0, 0, 3, 194, 0, 0, 4, 1, 0, 0, 37, 98, 0, 0, 37, 99, 0, 0, 4, 94, 0,
                                   0, 37, 94, 0, 0, 37, 95, 0, 0, 37, 96, 0, 0, 37, 97, 0, 0, 4, 1, 0, 0, 4, 4, 0, 0, 37, 99, 0, 0, 0, 242, 0, 0, 0, 244, 0, 0,
                                    0, 246, 0, 0, 14, 29, 0, 0, 14, 30, 0, 0, 14, 31, 0, 0, 1, 101, 0, 0, 1, 126, 0, 0, 1, 122, 0, 0, 2, 199, 0, 0, 2, 216, 0,
                                    0, 0, 164, 0, 0, 4, 144, 0, 0, 0, 166, 0, 0, 0, 167, 0, 0, 4, 1, 0, 0, 0, 169, 0, 0, 4, 4, 0, 0, 0, 171, 0, 0, 0, 191, 0,
                                    0, 0, 192, 0, 0, 0, 193, 0, 0, 0, 194, 0, 0, 0, 187, 0, 0, 3, 140, 0, 0, 0, 189, 0, 0, 3, 142, 0, 0, 3, 143, 0, 0, 3, 144,
                                    0, 0, 0, 163, 0, 0, 32, 170, 0, 0, 0, 165, 0, 0, 0, 166, 0, 0, 0, 167, 0, 0, 1, 121, 0, 0, 1, 22, 0, 0, 1, 34, 0, 0, 1, 54,
                                    0, 0, 0, 194, 0, 0, 1, 2, 0, 0, 4, 24, 0, 0, 4, 25, 0, 0, 4, 26, 0, 0, 4, 27, 0, 0, 4, 28, 0, 0, 4, 29, 0, 0, 4, 30, 0, 0, 4, 31])

        @Assert(en_re,exp_re)
        var decoder=Charsets.UTF32BE.newDecoder()
        var de_re=decoder.decode(en_re)
        @Assert(de_re,encode_String)
    }
    @TestCase
    func testCharsetUTF3202(): Unit {
        var encoder=Charsets.UTF32LE.newEncoder()
        var en_re=encoder.encode(encode_String)
        var exp_re=Array<UInt8>([166, 69, 0, 0, 4, 78, 0, 0, 31, 4, 0, 0, 32, 4, 0, 0, 242, 48, 0, 0, 161, 48, 0, 0, 100, 1, 0, 0, 121, 1, 0, 0, 192,
                                  0, 0, 0, 193, 0, 0, 0, 194, 0, 0, 0, 14, 4, 0, 0, 15, 4, 0, 0, 16, 4, 0, 0, 17, 4, 0, 0, 18, 4, 0, 0, 19, 4, 0, 0, 20,
                                  4, 0, 0, 21, 4, 0, 0, 22, 4, 0, 0, 54, 6, 0, 0, 55, 6, 0, 0, 56, 6, 0, 0, 57, 6, 0, 0, 58, 6, 0, 0, 140, 3, 0, 0, 189,
                                  0, 0, 0, 142, 3, 0, 0, 143, 3, 0, 0, 193, 0, 0, 0, 194, 0, 0, 0, 195, 0, 0, 0, 220, 5, 0, 0, 221, 5, 0, 0, 222, 5, 0, 0,
                                  24, 1, 0, 0, 18, 1, 0, 0, 12, 1, 0, 0, 202, 0, 0, 0, 203, 0, 0, 0, 204, 0, 0, 0, 158, 48, 0, 0, 3, 48, 0, 0, 221, 78, 0,
                                  0, 175, 3, 0, 0, 202, 3, 0, 0, 144, 3, 0, 0, 204, 3, 0, 0, 194, 3, 0, 0, 1, 4, 0, 0, 98, 37, 0, 0, 99, 37, 0, 0, 94, 4, 0,
                                  0, 94, 37, 0, 0, 95, 37, 0, 0, 96, 37, 0, 0, 97, 37, 0, 0, 1, 4, 0, 0, 4, 4, 0, 0, 99, 37, 0, 0, 242, 0, 0, 0, 244, 0, 0, 0,
                                  246, 0, 0, 0, 29, 14, 0, 0, 30, 14, 0, 0, 31, 14, 0, 0, 101, 1, 0, 0, 126, 1, 0, 0, 122, 1, 0, 0, 199, 2, 0, 0, 216, 2, 0, 0,
                                  164, 0, 0, 0, 144, 4, 0, 0, 166, 0, 0, 0, 167, 0, 0, 0, 1, 4, 0, 0, 169, 0, 0, 0, 4, 4, 0, 0, 171, 0, 0, 0, 191, 0, 0, 0, 192,
                                  0, 0, 0, 193, 0, 0, 0, 194, 0, 0, 0, 187, 0, 0, 0, 140, 3, 0, 0, 189, 0, 0, 0, 142, 3, 0, 0, 143, 3, 0, 0, 144, 3, 0, 0, 163, 0,
                                  0, 0, 170, 32, 0, 0, 165, 0, 0, 0, 166, 0, 0, 0, 167, 0, 0, 0, 121, 1, 0, 0, 22, 1, 0, 0, 34, 1, 0, 0, 54, 1, 0, 0, 194, 0, 0, 0,
                                  2, 1, 0, 0, 24, 4, 0, 0, 25, 4, 0, 0, 26, 4, 0, 0, 27, 4, 0, 0, 28, 4, 0, 0, 29, 4, 0, 0, 30, 4, 0, 0, 31, 4, 0, 0])

        @Assert(en_re,exp_re)
        var decoder=Charsets.UTF32LE.newDecoder()
        var de_re=decoder.decode(en_re)
        @Assert(de_re,encode_String)
    }
    @TestCase
    func testCharsetUTF3203(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.UTF32BE.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size+1,item:'c')
        var decoder=Charsets.UTF32BE.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetUTF3204(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.UTF32BE.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size,item:'c')
        var decoder=Charsets.UTF32BE.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetUTF3205(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.UTF32BE.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(encode_String.size-1,item:'c')
        var decoder=Charsets.UTF32BE.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],encoder.encode(encode_String.substring(0,encode_String.size-1)).size)
        @Assert(de_re[1],desc.size)
    }
    @TestCase
    func testCharsetUTF3206(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.UTF32LE.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size+1,item:'c')
        var decoder=Charsets.UTF32LE.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetUTF3207(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.UTF32LE.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size,item:'c')
        var decoder=Charsets.UTF32LE.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetUTF3208(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.UTF32LE.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(encode_String.size-1,item:'c')
        var decoder=Charsets.UTF32LE.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],encoder.encode(encode_String.substring(0,encode_String.size-1)).size)
        @Assert(de_re[1],desc.size)
    }
}