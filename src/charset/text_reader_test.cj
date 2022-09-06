package charset

from std import io.*

from std import unittest.*
from std import unittest.testmacro.*

@Test
public class TextReaderTest {
    @TestCase
    func testRead():Unit{
        var f:File = File("doc/字符集简介.md", AccessMode.Read, OpenMode.Open)
        var sr = TextReader(f, charset: Charsets.utf8, bufSize:100)
        while(true){
            var chOp = sr.read()
            var end = match(chOp){
                case Some(s) => false
                case None => true
            }
            var ch = match(chOp){
                case Some(s) => s
                case None => '\u{0}'
            }
            if(end){
                break
            }
            print("${ch}")          
        }
    }
    // @TestCase
    func testUtf8():Unit{
        var f:File = File("doc/字符集简介.md", AccessMode.Read, OpenMode.Open)
        
        var sr = TextReader(f, charset: Charsets.utf8, bufSize:100)
        while(true){
            var lineOp:Option<String> = sr.readln()
            var end = match(lineOp){
                case Some(s) => false
                case None => true
            }
            var line = match(lineOp){
                case Some(s) => s
                case None => ""
            }
            println("${line}")
            if(end){
                break
            }
        }   
    }
}



func testallline(){
    var f:File = File("/home/zft/下载/红楼梦utf8.txt", AccessMode.Read, OpenMode.Open)
    var sr = TextReader(f, charset: Charsets.utf8, bufSize:8192)
    var list = sr.readAllLine()
    for(line in list){
        println("${line}")
    }    
}

