// 3rd_party_lib:charset/build/charset
// 3rd_party_lib_ohos:charset/build/aarch64-linux-ohos/charset

from std import unittest.*
from std import unittest.testmacro.*
from charset import charset.*
from charset import charset.exception.*
from std import fs.*
@Test
public class TestCharsetKOI8_U{
    /*
        public func newDecoder():Decoder
        public func newEncoder():Encoder
        func encode(str:String): Array<UInt8>
        func decode(src:Array<UInt8>):String
        测试场景:其他-编码字符串为非空
    */
    var encode_String="i'm peiqi"
    @TestCase
    func testCharsetKOI8_U01(): Unit {
        encode_String="─│┌┐└┘├┤┬┴┼▀▄█▌▐░▒▓⌠■∙√≈≤≥⌡°²·÷═║╒ёє╔ії╗╘╙╚╛ґў╞╟╠╡ЁЄ╣ІЇ╦╧╨╩╪ҐЎ©юабцдефгхийклмнопярстужвьызшэщчъЮАБЦДЕФГХИЙКЛМНОПЯРСТУЖВЬЫЗШЭЩЧЪ"
        var encoder=Charsets.KOI8_U.newEncoder()
        var en_re=encoder.encode(encode_String)
        var exp_re=Array<UInt8>([128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145,
                                 146, 147, 148, 149, 150, 151, 152, 153, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164,
                                 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182,
                                 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200,
                                 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218,
                                 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236,
                                 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255])
        @Assert(en_re,exp_re)
        var decoder=Charsets.KOI8_U.newDecoder()
        var de_re=decoder.decode(en_re)
        @Assert(de_re,encode_String)
    }
    @TestCase
    func testCharsetKOI8_U02(): Unit {
        encode_String="吴爱华嘎嘎嘎估计覅而地方就是附近偶然FAFIDSGJOferegee324525"
        var encoder=Charsets.KOI8_U.newEncoder()
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
    func testCharsetKOI8_U03(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.KOI8_U.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size+1,item:'c')
        var decoder=Charsets.KOI8_U.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetKOI8_U04(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.KOI8_U.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size,item:'c')
        var decoder=Charsets.KOI8_U.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetKOI8_U05(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.KOI8_U.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size-1,item:'c')
        var decoder=Charsets.KOI8_U.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],encoder.encode(encode_String[..desc.size]).size)
        @Assert(de_re[1],desc.size)
    }
}
