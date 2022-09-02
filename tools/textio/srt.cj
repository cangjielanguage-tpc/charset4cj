import charset.*
from std import io.*

func testUtf8(){
    var f:File = File("/home/zft/下载/红楼梦utf8.txt", AccessMode.Read, OpenMode.Open)
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

func testallline(){
    var f:File = File("/home/zft/下载/红楼梦utf8.txt", AccessMode.Read, OpenMode.Open)
    var sr = TextReader(f, charset: Charsets.utf8, bufSize:8192)
    var list = sr.readAllLine()
    for(line in list){
        println("${line}")
    }    
}

main(){

    testUtf8()

}