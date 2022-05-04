from stdx import io.*
import charset.*
import textio.*

// 在文件上级目录下执行命令
// cjc -chir-cc -chir-llvm -backend-options="-fPIC --shared" textio/*.cj -o libtextio.so
// cjc -chir-cc -chir-llvm -backend-options="-lencoding -ltextio -lencodingmapping -L./" generate/PrintMapping.cj -o PrintMapping



func readMapping(path: String):Array<UInt16*UInt16>{
    var fio = TextIO(path)
    var lines = fio.readAllLine()
    var arr = ArrayList<UInt16*UInt16>(lines.size())
    for(line in lines){
        var str = line.trim()
        // 过滤掉空行与 #开头的行
        if(str.isEmpty() || str.startsWith("#")){
            continue
        }
        var scan = StringScanner(line)
        var s1 = if(scan.hasNext()) {scan.nextToken()} else {"0"}
        var s2 = if(scan.hasNext()) {scan.nextToken()} else {"0x00"}
        s2 = s2.replace("0x","").replace("0X","")
        var n1 = IntegerFormat.parseInt(s1)
        var n2 = IntegerFormat.parseInt(s2, 16)
        arr.add((UInt16(n1), UInt16(n2)))
    }
    fio.close()
    var ls = Array<UInt16*UInt16>(arr)
    return ls
}

func getFilePath(encodeName:String):String{
    var fileName = "index-" + encodeName + ".txt";
    var dir = Directory.getWorkingDirectory().getPath()
    var path = dir + "/generate/" + fileName
    return path
}

func main(){
    // var a = 0xfa34
    // var b = IntegerFormat.toString(a,16)
    // print(b)

    var encodeName = "ibm866"
    var path = getFilePath(encodeName)
    // let mapping:ArrayList<UInt32> = ArrayList<UInt32>(128) 这一行会出错
    let mapping:RefArray<UInt16> = RefArray<UInt16>(128, {i => 0xFFFF})

    var whatwgTable:Array<UInt16*UInt16> = readMapping(path)
    var i = 0
    for(item in whatwgTable){
        mapping[i] = item[1]
        i += 1
    }

    var outName = Directory.getWorkingDirectory().getPath() + "/mapping/" + encodeName + "_mapping.cj"
    var fout = TextIO(outName)
    fout.writeLine("// 基于 https://encoding.spec.whatwg.org/index-ibm866.txt 文档自动生成")
    fout.writeLine("package charsetmapping")
    fout.writeLine("\n\n")
    fout.writeLine("public let ibm866DecodeMapping: Array<UInt32> = [")
    for(item in mapping){
        fout.writeLine("\t" + IntegerFormat.toString(Int64(item), 16) + ",")
    }
    fout.writeLine("]")
    fout.close()


    // var whatwgTable:Array<Array<UInt32>> = Array<Array<UInt32>>([[2,23,23],[2,23,23],[2,23,23]])
    // let abcmappindddg:RefArray<UInt32> = RefArray<UInt32>(128, {i => 0xFFFF})
    // let mapping:ArrayList<UInt32> = ArrayList(128)
    // var i:Int64=0
    // while(i < whatwgTable.size()){
    //     var wt:Array<UInt32> = whatwgTable[i]
    //     // mapping[i] = wt[0]
    //     i += 1
    // }

    // for(m in mapping){
    //     print("m:${m}\n")
    // }
    // print("path:${path}")
    // var fio = TextIO(path)
    // var lines:Array<String> = fio.readAllLine()
    // for(s in lines){    
    //     print("s")
    // }
    // fio.close()
    return 0
}