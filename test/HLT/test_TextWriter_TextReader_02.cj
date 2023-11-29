// 3rd_party_lib:charset/build/charset
// 3rd_party_lib_ohos:charset/build/aarch64-linux-ohos/charset

from std import unittest.*
from std import unittest.testmacro.*
from charset import charset.*
from std import io.*

@Test
public class TestTextWriter{
    /*
        public init(output:OutputStream, charset!:Charset = Charsets.UTF8)
        public init(input:InputStream, charset!:Charset = Charsets.UTF8, bufSize!:Int64 = 8192)
        public func readAllLine():ArrayList<String>
        public func readln(): Option<String>
        public func write(s:String)
        public func read(): Option<Char>
        测试场景：非空流,charset,bufSize均使用非默认值
    */
    var content_singleLine="hello cangjie"
    //测试场景：写入和读取时charset一致
    @TestCase
    func testTextWriterTextReader10(): Unit {
        var temp=ByteArrayStream()
        temp.write(content_singleLine.toArray())
        var tw=TextWriter(temp,charset:Charsets.ISO_2022_JP)
        tw.write(content_singleLine)
        var tr=TextReader(temp,charset:Charsets.ISO_2022_JP,bufSize:10240)
        var re=tr.readAllLine()
        @Assert(re.size,1)
        @Assert(re.get(0),content_singleLine+content_singleLine)
    }
    //测试场景：写入和读取时charset不一致
    @TestCase
    func testTextWriterTextReader11(): Unit {
        var temp=ByteArrayStream()
        temp.write(content_singleLine.toArray())
        var tw=TextWriter(temp,charset:Charsets.ISO_2022_JP)
        tw.write(content_singleLine)
        var tr=TextReader(temp,charset:Charsets.ISO_8859_13,bufSize:10240)
        var re=tr.readAllLine()
        @Assert(re.size,1)
        @Assert(re.get(0),content_singleLine+content_singleLine)
    }
}
