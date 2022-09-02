import charset.*
from std import io.*

main(){
    var f:File = File("/opt/work/charset/doc/字符集简介.md", AccessMode.Read, OpenMode.Open)
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