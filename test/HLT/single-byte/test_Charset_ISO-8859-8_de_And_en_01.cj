// 3rd_party_lib:charset/build/charset
// 3rd_party_lib_ohos:charset/build/aarch64-linux-ohos/charset

from std import unittest.*
from std import unittest.testmacro.*
from charset import charset.*
from charset import charset.exception.*
from std import collection.*

@Test
public class TestCharsetISO_8859_8{
    /*
        public func newDecoder():Decoder
        public func newEncoder():Encoder
        func encode(str:String): Array<UInt8>
        func decode(src:Array<UInt8>):String
        测试场景:ISO-编码字符串为非空
    */
    var encode_String="i'm peiqi"
    @TestCase
    func testCharsetISO_8859_801(): Unit {
        encode_String="¢£¤¥¦§¨©×«¬®¯°±²³´µ¶·¸¹÷»¼½¾‗אבגדהוזחטיךכלםמןנסעףפץצקרשת"
        var encoder=Charsets.ISO_8859_8.newEncoder()
        var en_re=encoder.encode(encode_String)
        var exp_re=Array<UInt8>([162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 174, 175, 176, 177, 178, 179, 180,
                                 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 223, 224, 225, 226, 227, 228, 229, 230,
                                 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250])
        @Assert(en_re,exp_re)
        var decoder=Charsets.ISO_8859_8.newDecoder()
        var de_re=decoder.decode(en_re)
        @Assert(de_re,encode_String)
    }
    @TestCase
    func testCharsetISO_8859_802(): Unit {
        encode_String="吴爱华嘎嘎嘎估计覅而地方就是附近偶然FAFIDSGJOferegee324525"
        var encoder=Charsets.ISO_8859_8.newEncoder()
        var excp_flag=1
        try{
            encoder.encode(encode_String)
        }catch(e:EncoderException){
            if(e.toString().contains("EncoderException: can't encode character 吴 character maps to <undefined>")){
                excp_flag=0
            }
        }
        @Assert(excp_flag,0)
    }
    @TestCase
    func testCharsetISO_8859_803(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.ISO_8859_8.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size+1,item:'c')
        var decoder=Charsets.ISO_8859_8.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetISO_8859_804(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.ISO_8859_8.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size,item:'c')
        var decoder=Charsets.ISO_8859_8.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetISO_8859_805(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.ISO_8859_8.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size-1,item:'c')
        var decoder=Charsets.ISO_8859_8.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],encoder.encode(encode_String.substring(0,desc.size)).size)
        @Assert(de_re[1],desc.size)
    }
}