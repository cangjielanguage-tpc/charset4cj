import textio.*
import charset.*
from stdx import io.*


// 需要先将 textio 编译 cjc -chir-cc -chir-llvm -backend-options="-fPIC --shared"   textio/*.cj -o libtextio.so
/*


cjc -chir-cc -chir-llvm -backend-options="-lencoding -lencoding.charset -lencoding.unicode -lencoding.singlebyte -lencoding.simplechinese -lencoding.korean -ltextio -L./" test/TextIO_test.cj 

*/

func main(){
    var infile = Directory.getWorkingDirectory().getPath() + "/README.md"
    var outfile = Directory.getWorkingDirectory().getPath() + "/a.txt"

    var srcFile = TextIO(infile,Charsets.utf8)
    var target = TextIO(outfile)

    var res:String*Bool = srcFile.readLine()
    print("abc")
    var line = res[0]
    var eof = res[1]
    print("line:${line}")
    while(!eof){
        print(line + "\n")

        res = srcFile.readLine()
        line = res[0]
        eof = res[1]

        target.writeLine(line)
    }
    srcFile.close()
    target.close()
    return 0
}