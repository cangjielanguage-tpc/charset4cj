// 3rd_party_lib:charset/build/charset
// 3rd_party_lib_ohos:charset/build/aarch64-linux-ohos/charset

from std import unittest.*
from std import unittest.testmacro.*
from charset import charset.*
from std import collection.*
from std import io.*

@Test
public class TestCharsetTransfer{
    /*
        public static func transfer(input: InputStream, output: OutputStream, inputCharset: Charset, outputCharset: Charset): Unit
        测试场景:编码一致/不一致,转化过程中有/无异常
    */
   @TestCase
    func testCharsetTransferTransfer01(): Unit {
        var input=ByteArrayStream()
        var src="fhsfhuigidgfdfsfgt758932745987"
        var encoder=Charsets.ISO_2022_JP.newEncoder()
        input.write(encoder.encode(src))
        var output=ByteArrayStream()
        CharsetTransfer.transfer(input,output,Charsets.ISO_2022_JP,Charsets.UTF8)
        var desc=output.readToEnd()
        var decoder=Charsets.UTF8.newDecoder()
        var de_re=decoder.decode(desc)
        @Assert(de_re,src)
    }
   @TestCase
    func testCharsetTransferTransfer02(): Unit {
        var input=ByteArrayStream()
        var src="fhsfhuigidgfdfsfgt758932745987"
        input.write(src.toUtf8Array())
        var output=ByteArrayStream()
        CharsetTransfer.transfer(input,output,Charsets.ISO_2022_JP,Charsets.ISO_2022_JP)
        var desc=output.readToEnd()
        var decoder=Charsets.ISO_2022_JP.newDecoder()
        var de_re=decoder.decode(desc)
        @Assert(de_re,src)
    }
   @TestCase
    func testCharsetTransferTransfer03(): Unit {
        var input=ByteArrayStream()
        var src="吴爱华嘎嘎嘎估计覅而地方就是附近偶然FAFIDSGJOferegee324525"
        input.write(src.toUtf8Array())
        var output=ByteArrayStream()
        var flag=0
        try{
            CharsetTransfer.transfer(input,output,Charsets.UTF8,Charsets.ISO_2022_JP)
        }catch(e:Exception){
            println(e.toString())
            if(e.toString().contains("can't encode character 吴")){
                flag=1
            }
        }
        @Assert(flag,1)
    }
}