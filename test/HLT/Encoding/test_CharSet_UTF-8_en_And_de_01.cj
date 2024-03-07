// 3rd_party_lib:charset/build/charset
// 3rd_party_lib_ohos:charset/build/aarch64-linux-ohos/charset

from std import unittest.*
from std import unittest.testmacro.*
from charset import charset.*
from std import collection.*
from std import fs.*

@Test
public class TestCharsetUTF8{
    /*
        public func newDecoder():Decoder
        public func newEncoder():Encoder
        func encode(str:String): Array<UInt8>
        func decode(src:Array<UInt8>):String
        测试场景:编码字符串为空/非空
    */
    var encode_String="䖦丄ПРヲァŤŹÀÁÂЎЏАБВГДЕЖضطظعغΌ½ΎΏÁÂÃלםמĘĒČÊËÌゞ〃仝ίϊΐόςЁ╢╣ў╞╟╠╡ЁЄ╣òôöฝพฟťžźˇ˘¤Ґ¦§Ё©Є«¿ÀÁÂ»Ό½ΎΏΐ£₪¥¦§ŹĖĢĶÂĂИЙКЛМНОП"
    @TestCase
    func testCharsetUTF801(): Unit {
        var encoder=Charsets.UTF8.newEncoder()
        var en_re=encoder.encode(encode_String)
        var exp_en=Array<UInt8>([228, 150, 166, 228, 184, 132, 208, 159, 208, 160, 227, 131, 178, 227, 130, 161, 197, 164, 197, 185, 195,
                                 128, 195, 129, 195, 130, 208, 142, 208, 143, 208, 144, 208, 145, 208, 146, 208, 147, 208, 148, 208, 149,
                                 208, 150, 216, 182, 216, 183, 216, 184, 216, 185, 216, 186, 206, 140, 194, 189, 206, 142, 206, 143, 195,
                                 129, 195, 130, 195, 131, 215, 156, 215, 157, 215, 158, 196, 152, 196, 146, 196, 140, 195, 138, 195, 139,
                                 195, 140, 227, 130, 158, 227, 128, 131, 228, 187, 157, 206, 175, 207, 138, 206, 144, 207, 140, 207, 130,
                                 208, 129, 226, 149, 162, 226, 149, 163, 209, 158, 226, 149, 158, 226, 149, 159, 226, 149, 160, 226, 149,
                                 161, 208, 129, 208, 132, 226, 149, 163, 195, 178, 195, 180, 195, 182, 224, 184, 157, 224, 184, 158, 224,
                                 184, 159, 197, 165, 197, 190, 197, 186, 203, 135, 203, 152, 194, 164, 210, 144, 194, 166, 194, 167, 208,
                                 129, 194, 169, 208, 132, 194, 171, 194, 191, 195, 128, 195, 129, 195, 130, 194, 187, 206, 140, 194, 189,
                                 206, 142, 206, 143, 206, 144, 194, 163, 226, 130, 170, 194, 165, 194, 166, 194, 167, 197, 185, 196, 150,
                                 196, 162, 196, 182, 195, 130, 196, 130, 208, 152, 208, 153, 208, 154, 208, 155, 208, 156, 208, 157, 208, 158, 208, 159])
        @Assert(exp_en,en_re)
        var decoder=Charsets.UTF8.newDecoder()
        var de_re=decoder.decode(en_re)
        @Assert(de_re,encode_String)
    }
    @TestCase
    func testCharsetUTF803(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.UTF8.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size+1,item:'c')
        var decoder=Charsets.UTF8.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetUTF804(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.UTF8.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size,item:'c')
        var decoder=Charsets.UTF8.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetUTF805(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.UTF8.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size-1,item:'c')
        var decoder=Charsets.UTF8.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],encoder.encode(encode_String[..desc.size]).size)
        @Assert(de_re[1],desc.size)
    }
}
