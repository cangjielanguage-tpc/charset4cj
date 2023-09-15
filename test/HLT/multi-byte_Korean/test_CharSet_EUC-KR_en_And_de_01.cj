// 3rd_party_lib:charset/build/charset
// 3rd_party_lib_ohos:charset/build/aarch64-linux-ohos/charset
// data_file: euc-kr.txt

from std import unittest.*
from std import unittest.testmacro.*
from charset import charset.encoding.*
from charset import charset.*
from std import collection.*
from std import fs.*

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
        encode_String=String.fromUtf8(file.readToEnd())
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
        }catch(e:Exception){
            if(e.toString().contains("can't encode character 吴")){
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
        var desc=Array<Char>(en_re.size+1,item:'c')
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
        var desc=Array<Char>(en_re.size,item:'c')
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
        var desc=Array<Char>(en_re.size-1,item:'c')
        var decoder=Charsets.EUCKR.newDecoder()
        var de_re=decoder.decode(en_re,desc)
        @Assert(de_re[0],encoder.encode(encode_String.substring(0,desc.size)).size)
        @Assert(de_re[1],desc.size)
    }    
}