// 3rd_party_lib:charset/build/charset
// 3rd_party_lib_ohos:charset/build/aarch64-linux-ohos/charset

from std import unittest.*
from std import unittest.testmacro.*
from charset import charset.*
from std import collection.*

@Test
public class TestCharsetWINDOWS_1252{
    /*
        public func newEncoder():Encoder
        func encode(str:String): Array<UInt8>
        测试场景:Windows-编码字符串为空/非空
    */
    var encode_String="i'm peiqi"
    @TestCase
    func testCharsetWINDOWS_125201(): Unit {
        encode_String="€‚ƒ„…†‡ˆ‰Š‹ŒŽ‘’“”•–—˜™š›œžŸ¡¢£¤¥¦§¨©ª«¬®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ"
        var encoder=Charsets.WINDOWS_1252.newEncoder()
        var en_re=encoder.encode(encode_String)
        var exp_re=Array<UInt8>([128, 130, 131, 132, 133, 134, 135, 136, 137,
                                 138, 139, 140, 142, 145, 146, 147, 148, 149,
                                 150, 151, 152, 153, 154, 155, 156, 158, 159,
                                 161, 162, 163, 164, 165, 166, 167, 168, 169,
                                 170, 171, 172, 174, 175, 176, 177, 178, 179,
                                 180, 181, 182, 183, 184, 185, 186, 187, 188,
                                 189, 190, 191, 192, 193, 194, 195, 196, 197,
                                 198, 199, 200, 201, 202, 203, 204, 205, 206,
                                 207, 208, 209, 210, 211, 212, 213, 214, 215,
                                 216, 217, 218, 219, 220, 221, 222, 223, 224,
                                 225, 226, 227, 228, 229, 230, 231, 232, 233,
                                 234, 235, 236, 237, 238, 239, 240, 241, 242,
                                 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255])

        @Assert(en_re,exp_re)
        var decoder=Charsets.WINDOWS_1252.newDecoder()
        var de_re=decoder.decode(en_re)
        @Assert(de_re,encode_String)
    }
    @TestCase
    func testCharsetWINDOWS_125202(): Unit {
        encode_String="吴爱华嘎嘎嘎估计覅而地方就是附近偶然FAFIDSGJOferegee324525"
        var encoder=Charsets.WINDOWS_1252.newEncoder()
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
    func testCharsetWINDOWS_125203(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.WINDOWS_1252.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size+1,item:'c')
        var decoder=Charsets.WINDOWS_1252.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetWINDOWS_125204(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.WINDOWS_1252.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size,item:'c')
        var decoder=Charsets.WINDOWS_1252.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetWINDOWS_125205(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.WINDOWS_1252.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size-1,item:'c')
        var decoder=Charsets.WINDOWS_1252.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],encoder.encode(encode_String.substring(0,desc.size)).size)
        @Assert(de_re[1],desc.size)
    }
}