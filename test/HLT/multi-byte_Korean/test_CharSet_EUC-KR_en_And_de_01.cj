// 3rd_party_lib:charset4cj/build/charset
// 3rd_party_lib_ohos:charset4cj/build/aarch64-linux-ohos/charset
// data_file: euc-kr.txt

import std.unittest.*
import std.unittest.testmacro.*
import charset4cj.charset.encoding.*
import charset4cj.charset.*
import charset4cj.charset.exception.*
import std.collection.*
import std.fs.*

@Test
public class TestCharsetEUCKR{
    /*
        public func newDecoder():Decoder
        public func newEncoder():Encoder
        func encode(str:String): Array<UInt8>
        func decode(src:Array<UInt8>):String
        测试场景:编码字符串为空/非空
    */
    var encode_String="吴爱华嘎嘎嘎估计覅而地方就是附近偶然FAFIDSGJOferegee324525"
    @TestCase
    func testCharsetEUCKR01(): Unit {
        var file=File("euc-kr.txt",OpenOption.Open(true, true))
        encode_String=String.fromUtf8(File.readFrom(file.info.path))
        var encoder=Charsets.EUCKR.newEncoder()
        var en_re=encoder.encode(encode_String)
        var decoder=Charsets.EUCKR.newDecoder()
        var de_re=decoder.decode(en_re)
        @Assert(de_re,encode_String)
    }
    @TestCase
    func testCharsetEUCKR02(): Unit {
        encode_String="吴爱华嘎嘎嘎估计覅而地方就是附近偶然FAFIDSGJOferegee324525"
        var encoder=Charsets.EUCKR.newEncoder()
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
    func testCharsetEUCKR03(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.EUCKR.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Rune>(en_re.size+1,item:r'c')
        var decoder=Charsets.EUCKR.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetEUCKR04(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.EUCKR.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Rune>(en_re.size,item:r'c')
        var decoder=Charsets.EUCKR.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],en_re.size)
        @Assert(de_re[1],encode_String.size)
    }
    @TestCase
    func testCharsetEUCKR05(): Unit {
        encode_String="FAFIDSGJOferegee324525"
        var encoder=Charsets.EUCKR.newEncoder()
        var en_re=encoder.encode(encode_String)
        var desc=Array<Rune>(en_re.size-1,item:r'c')
        var decoder=Charsets.EUCKR.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],encoder.encode(encode_String[..desc.size]).size)
        @Assert(de_re[1],desc.size)
    }
}
