// 3rd_party_lib:charset/build/charset
// 3rd_party_lib_ohos:charset/build/aarch64-linux-ohos/charset

from std import unittest.*
from std import unittest.testmacro.*
from charset import charset.encoding.*
from charset import charset.*
from std import collection.*

@Test
public class TestCharset{
    /*
        public func newDecoder():Decoder
        public func newEncoder():Encoder
        func encode(str:String): Array<UInt8>
        func decode(src:Array<UInt8>):String
        测试场景:编解码字符串为空
    */
    public var allCharset=Array<Charset>([ Charsets.UTF8,Charsets.UTF16BE,Charsets.UTF16LE,Charsets.UTF32BE,Charsets.UTF32LE,Charsets.GB18030,Charsets.GBK,Charsets.EUCKR,Charsets.EUCJP,Charsets.SHIFT_JIS,Charsets.ISO_2022_JP,Charsets.BIG5_HKSCS,Charsets.IBM866,
                                                Charsets.ISO_8859_2,Charsets.ISO_8859_3,Charsets.ISO_8859_4,Charsets.ISO_8859_5,Charsets.ISO_8859_6,Charsets.ISO_8859_7,Charsets.ISO_8859_8,Charsets.ISO_8859_10,Charsets.ISO_8859_13,Charsets.ISO_8859_14,
                                                Charsets.ISO_8859_15,Charsets.ISO_8859_16,Charsets.KOI8_R,Charsets.KOI8_U,Charsets.MACINTOSH,Charsets.WINDOWS_874,Charsets.WINDOWS_1250,Charsets.WINDOWS_1251,Charsets.WINDOWS_1252,Charsets.WINDOWS_1253,
                                                Charsets.WINDOWS_1254,Charsets.WINDOWS_1255,Charsets.WINDOWS_1256,Charsets.WINDOWS_1257,Charsets.WINDOWS_1258,Charsets.X_MAC_CYRILLIC  ])
    @TestCase
    func testCharSetDecoding01(): Unit {
        var src=Array<UInt8>()
        for (index in 0..allCharset.size){
            var decoder=allCharset[index].newDecoder()
            var re=decoder.decode(src)
            @Assert(re,"")
        }
    }
    @TestCase
    func testCharSetEncoding01(): Unit {
        var exp_re=Array<UInt8>()
        for (index in 0..allCharset.size){
            var encoder=allCharset[index].newEncoder()
            var re=encoder.encode("")
            @Assert(re,exp_re)
        }
    }
}