import textio.*
from stdx import io.*


/*
1. 下载映射文件
wget https://encoding.spec.whatwg.org/index-jis0208.txt
wget https://encoding.spec.whatwg.org/index-jis0212.txt

todo:
2. 处理下载的文件，生成仓颉语言的mapping
*/

// cjc -chir-cc -chir-llvm -backend-options="-lencoding.charset -lencoding.unicode -ltextio -L./" generate/JapanGen.cj
func main(){
    let infile = Directory.getWorkingDirectory().getPath() + "/generate/index-jis0208.txt"
    print("${infile}\n")
    var srcFile = TextIO(infile)

    var res:String*Bool = srcFile.readLine()
    var line = res[0]
    var eof = res[1]
    while(!eof){
        line = res[0]
        eof = res[1]
        print("${line}\n")
        res = srcFile.readLine()
    }  

    srcFile.close()

    return 0
}