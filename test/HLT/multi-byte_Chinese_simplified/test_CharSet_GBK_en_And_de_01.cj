// 3rd_party_lib:charset/build/charset
// 3rd_party_lib_ohos:charset/build/aarch64-linux-ohos/charset
// data_file: gb18030.txt

from std import unittest.*
from std import unittest.testmacro.*
from charset import charset.*
from std import collection.*
from std import fs.*

@Test
public class TestCharsetGBK{
    /*
        public func newDecoder():Decoder
        public func newEncoder():Encoder
        func encode(str:String): Array<UInt8>
        func decode(src:Array<UInt8>):String
        测试场景:编码字符串非空,在范围内,不在范围内很难找，暂不测试
    */
    var encode_String="吴爱华嘎嘎嘎估计覅而地方就是附近偶然FAFIDSGJOferegee324525"
    @TestCase
    func testCharsetGBK01(): Unit {
        var file=File("gb18030.txt",OpenOption.Open(true, true))
        encode_String=String.fromUtf8(file.readToEnd())
        var encoder=Charsets.GBK.newEncoder()
        var en_re=encoder.encode(encode_String)
        var decoder=Charsets.GBK.newDecoder()
        var de_re=decoder.decode(en_re)
        @Assert(de_re,encode_String)
    }
    @TestCase
    func testCharsetGBK02(): Unit {
        encode_String="吴爱华嘎嘎嘎估计覅而地方就是附近偶然FAFIDSGJOferegee324525"
        var encoder=Charsets.GBK.newEncoder()
        var en_re=encoder.encode(encode_String)
        var decoder=Charsets.GBK.newDecoder()
        var de_re=decoder.decode(en_re)
        @Assert(de_re,encode_String)
    }
    @TestCase
    func testCharsetGBK03(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.GBK.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size+1,item:'c')
        var decoder=Charsets.GBK.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetGBK04(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.GBK.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size,item:'c')
        var decoder=Charsets.GBK.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetGBK05(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.GBK.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size-1,item:'c')
        var decoder=Charsets.GBK.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],encoder.encode(encode_String[..desc.size]).size)
        @Assert(de_re[1],desc.size)
    }
}
