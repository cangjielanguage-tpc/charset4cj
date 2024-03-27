// 3rd_party_lib:charset/build/charset
// 3rd_party_lib_ohos:charset/build/aarch64-linux-ohos/charset
// data_file: big5.txt

from std import unittest.*
from std import unittest.testmacro.*
from charset import charset.*
from charset import charset.exception.*
from std import collection.*
from std import fs.*

@Test
public class testCharsetBIG5HKSCS5{
    /*
        public func newDecoder():Decoder
        public func newEncoder():Encoder
        func encode(str:String): Array<UInt8>
        func decode(src:Array<UInt8>):String
        测试场景:编码字符串为空/非空
    */
    var encode_String="吴爱华嘎嘎嘎估计覅而地方就是附近偶然FAFIDSGJOferegee324525"
    @TestCase
    func testCharsetBIG5HKSCS501(): Unit {
        var file=File("big5.txt",OpenOption.Open(true, true))
        encode_String=String.fromUtf8(file.readToEnd())
        var encoder=Charsets.BIG5_HKSCS.newEncoder()
        var en_re=encoder.encode(encode_String)
        var decoder=Charsets.BIG5_HKSCS.newDecoder()
        var de_re=decoder.decode(en_re)
        @Assert(de_re,encode_String)
    }
    @TestCase
    func testCharsetBIG5HKSCS502(): Unit {
        encode_String="吴爱华嘎嘎嘎估计覅而地方就是附近偶然FAFIDSGJOferegee324525"
        var encoder=Charsets.BIG5_HKSCS.newEncoder()
        var excp_flag=1
        try{
            encoder.encode(encode_String)
        }catch(e:EncoderException){
            if(e.toString().contains("EncoderException: can't encode character 爱 character maps to <undefined>")){
                excp_flag=0
            }
        }
        @Assert(excp_flag,0)
    }
    @TestCase
    func testCharsetBIG5HKSCS503(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.BIG5_HKSCS.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size+1,item:'c')
        var decoder=Charsets.BIG5_HKSCS.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetBIG5HKSCS504(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.BIG5_HKSCS.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size,item:'c')
        var decoder=Charsets.BIG5_HKSCS.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetBIG5HKSCS505(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.BIG5_HKSCS.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Char>(en_re.size-1,item:'c')
        var decoder=Charsets.BIG5_HKSCS.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],encoder.encode(encode_String[..desc.size]).size)
        @Assert(de_re[1],desc.size)
    }
}
