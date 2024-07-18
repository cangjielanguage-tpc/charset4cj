// 3rd_party_lib:charset4cj/build/charset
// 3rd_party_lib_ohos:charset4cj/build/aarch64-linux-ohos/charset

import std.unittest.*
import std.unittest.testmacro.*
import charset4cj.charset.*
import std.io.*

@Test
public class TestTextWriter01{
    /*
        public init(output:OutputStream, charset!:Charset = Charsets.UTF8)
        public init(input:InputStream, charset!:Charset = Charsets.UTF8, bufSize!:Int64 = 8192)
        public func readAllLine():ArrayList<String>
        public func readln(): Option<String>
        public func write(s:String)
        public func read(): Option<Rune>
        测试场景：空流,charset,bufSize均使用默认值,写入内容为空/单行/多行
    */
    var content_singleLine="hello cangjie"
    var content_MultiLine="""
hello cangjie
hello cangjie
hello cangjie
hello cangjie
hello cangjie
"""
    @TestCase
    func testTextWriterTextReader01(): Unit {
        var temp=ByteArrayStream()
        var tw=TextWriter(temp)
        tw.write("")
        var tr=TextReader(temp)
        var re=tr.read()
        var flag=0
        try{
            re.getOrThrow()
        }catch(e:NoneValueException){
            flag=1
        }
        @Assert(flag,1)
    }
    @TestCase
    func testTextWriterTextReader02(): Unit {
        var temp=ByteArrayStream()
        var tw=TextWriter(temp)
        tw.write("")
        var tr=TextReader(temp)
        var re=tr.readln()
        re=tr.readln()
        var flag=0
        try{
            re.getOrThrow()
        }catch(e:NoneValueException){
            flag=1
        }
        @Assert(flag,1)
    }
    @TestCase
    func testTextWriterTextReader03(): Unit {
        var temp=ByteArrayStream()
        var tw=TextWriter(temp)
        tw.write("")
        var tr=TextReader(temp)
        var re=tr.readAllLine()
        @Assert(re.size,0)
    }
    @TestCase
    func testTextWriterTextReader04(): Unit {
        var temp=ByteArrayStream()
        var tw=TextWriter(temp)
        tw.write(content_singleLine)
        var tr=TextReader(temp)
        var exp_content=content_singleLine.toRuneArray()
        var re=r'a'
        var exp_re=r'a'
        for (index in 0..exp_content.size){
            re=tr.read().getOrThrow()
            exp_re=exp_content[index]
            @Assert(re,exp_re)
        }
    }
    @TestCase
    func testTextWriterTextReader05(): Unit {
        var temp=ByteArrayStream()
        var tw=TextWriter(temp)
        tw.write(content_singleLine)
        var tr=TextReader(temp)
        var re=tr.readln().getOrThrow()
        @Assert(re,content_singleLine)
    }
    @TestCase
    func testTextWriterTextReader06(): Unit {
        var temp=ByteArrayStream()
        var tw=TextWriter(temp)
        tw.write(content_singleLine)
        var tr=TextReader(temp)
        var re=tr.readAllLine()
        @Assert(re.size,1)
        @Assert(re.get(0),content_singleLine)
    }

    @TestCase
    func testTextWriterTextReader07(): Unit {
        var temp=ByteArrayStream()
        var tw=TextWriter(temp)
        tw.write(content_MultiLine)
        var tr=TextReader(temp)
        var exp_content=content_MultiLine.toRuneArray()
        var re=r'a'
        var exp_re=r'a'
        for (index in 0..exp_content.size){
            re=tr.read().getOrThrow()
            exp_re=exp_content[index]
            @Assert(re,exp_re)
        }
    }
    @TestCase
    func testTextWriterTextReader08(): Unit {
        var temp=ByteArrayStream()
        var tw=TextWriter(temp)
        tw.write(content_MultiLine)
        var tr=TextReader(temp)
        var exp_content=content_MultiLine.split("\n")
        var re=""
        var exp_re=""
        for (index in 0..exp_content.size-1){
            re=tr.readln().getOrThrow()
            exp_re=exp_content[index]
            @Assert(re,exp_re)
        }
    }
    @TestCase
    func testTextWriterTextReader09(): Unit {//这里空行实际结果不算一行，与问题2矛盾
        var temp=ByteArrayStream()
        var tw=TextWriter(temp)
        tw.write(content_MultiLine)
        var tr=TextReader(temp)
        var re=tr.readAllLine()
        var exp_content=content_MultiLine.split("\n")
        @Assert(re.size,exp_content.size-1)
        for (index in 0..exp_content.size-1){
            @Assert(re[index] ,exp_content[index])
        }
    }
}
