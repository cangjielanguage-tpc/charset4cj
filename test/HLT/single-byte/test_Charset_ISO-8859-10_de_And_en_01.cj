// 3rd_party_lib:charset/build/charset
// 3rd_party_lib_ohos:charset/build/aarch64-linux-ohos/charset

from std import unittest.*
from std import unittest.testmacro.*
from charset import charset.*
from std import collection.*

@Test
public class TestCharsetISO_8859_10{
    /*
        public func newDecoder():Decoder
        public func newEncoder():Encoder
        func encode(str:String): Array<UInt8>
        func decode(src:Array<UInt8>):String
        测试场景:ISO-编码字符串为非空
    */
    var encode_String="i'm peiqi"
    @TestCase
    func testCharsetISO_8859_1001(): Unit {
        encode_String="ĄĒĢĪĨĶ§ĻĐŠŦŽŪŊ°ąēģīĩķ·ļđšŧž―ūŋĀÁÂÃÄÅÆĮČÉĘËĖÍÎÏÐŅŌÓÔÕÖŨØŲÚÛÜÝÞßāáâãäåæįčéęëėíîïðņōóôõöũøųúûüýþĸ"
        var encoder=Charsets.ISO_8859_10.newEncoder()
        var en_re=encoder.encode(encode_String)
        var exp_re=Array<UInt8>([161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 174,
                                 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187,
                                 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200,
                                 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213,
                                 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226,
                                 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239,
                                 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255])
        @Assert(en_re,exp_re)
        var decoder=Charsets.ISO_8859_10.newDecoder()
        var de_re=decoder.decode(en_re)
        @Assert(de_re,encode_String)
    }
    @TestCase
    func testCharsetISO_8859_1002(): Unit {
        encode_String="吴爱华嘎嘎嘎估计覅而地方就是附近偶然FAFIDSGJOferegee324525"
        var encoder=Charsets.ISO_8859_10.newEncoder()
        var excp_flag=1
        try{
            encoder.encode(encode_String)
        }catch(e:Exception){
            if(e.toString().contains("can't encode character 吴")){
                excp_flag=0
            }
        }
        @Assert(excp_flag,0)
    }
    @TestCase
    func testCharsetISO_8859_1003(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.ISO_8859_10.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size+1,item:'c')
        var decoder=Charsets.ISO_8859_10.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetISO_8859_1004(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.ISO_8859_10.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size,item:'c')
        var decoder=Charsets.ISO_8859_10.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetISO_8859_1005(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.ISO_8859_10.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size-1,item:'c')
        var decoder=Charsets.ISO_8859_10.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],encoder.encode(encode_String.substring(0,desc.size)).size)
        @Assert(de_re[1],desc.size)
    }
}