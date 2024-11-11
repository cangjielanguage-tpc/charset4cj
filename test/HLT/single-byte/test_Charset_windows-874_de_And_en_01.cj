// 3rd_party_lib:charset4cj/build/charset
// 3rd_party_lib_ohos:charset4cj/build/aarch64-linux-ohos/charset

import std.unittest.*
import std.unittest.testmacro.*
import charset4cj.charset.*
import charset4cj.charset.exception.*
import std.collection.*

@Test
public class TestCharsetWINDOWS_874{
    /*
        public func newEncoder():Encoder
        func encode(str:String): Array<UInt8>
        测试场景:Windows-编码字符串为空/非空
    */
    var encode_String="i'm peiqi"
    @TestCase
    func testCharsetWINDOWS_87401(): Unit {
        encode_String="€…‘’“”•–—กขฃคฅฆงจฉชซฌญฎฏฐฑฒณดตถทธนบปผฝพฟภมยรฤลฦวศษสหฬอฮฯ"
        var encoder=Charsets.WINDOWS_874.newEncoder()
        var en_re=encoder.encode(encode_String)
        var exp_re: Array<UInt8>=[128, 133, 145, 146, 147, 148, 149, 150, 151, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175,
                                 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199,
                                 200, 201, 202, 203, 204, 205, 206, 207]
        @Assert(en_re,exp_re)
        var decoder=Charsets.WINDOWS_874.newDecoder()
        var de_re=decoder.decode(en_re)
        @Assert(de_re,encode_String)
    }
    @TestCase
    func testCharsetWINDOWS_87402(): Unit {
        encode_String="吴爱华嘎嘎嘎估计覅而地方就是附近偶然FAFIDSGJOferegee324525"
        var encoder=Charsets.WINDOWS_874.newEncoder()
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
    func testCharsetWINDOWS_87403(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.WINDOWS_874.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Rune>(en_re.size+1,item:r'c')
        var decoder=Charsets.WINDOWS_874.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetWINDOWS_87404(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.WINDOWS_874.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Rune>(en_re.size,item:r'c')
        var decoder=Charsets.WINDOWS_874.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetWINDOWS_87405(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.WINDOWS_874.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Rune>(en_re.size-1,item:r'c')
        var decoder=Charsets.WINDOWS_874.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],encoder.encode(encode_String[..desc.size]).size)
        @Assert(de_re[1],desc.size)
    }
}
