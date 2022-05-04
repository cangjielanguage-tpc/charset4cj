import textio.*
from stdx import io.*


/*
1. 下载映射文件
wget -P generate/ https://encoding.spec.whatwg.org/index-ibm866.txt 

todo:
2. 处理下载的文件，生成仓颉语言的mapping
*/

// cjc -chir-cc -chir-llvm -backend-options="-lencoding.charset -lencoding.unicode -ltextio -L./" generate/SingleByteGen.cj

func aquireUrl(encodingName:String):String{
    return "https://encoding.spec.whatwg.org/index-" + encodingName + ".txt"
}

func aquirePath(encodingName:String):String{
    return Directory.getWorkingDirectory().getPath() + "/generate/index-" + encodingName + ".txt"
}

func aquireTable(encodingName:String):ArrayList<Int64*Int64>{
    var Array = ArrayList<Int64*Int64>()
    var filePath = aquirePath(encodingName)
    var srcFile = TextIO(filePath)
    var res:String*Bool = srcFile.readLine()
    var line = res[0]
    var eof = res[1]
    while(!eof){
        line = res[0]
        eof = res[1]
        res = srcFile.readLine()

        if(line.startsWith("#") || StringUtils.isBlank(line)){
            continue
        }
        var scan = StringScanner(line)
        var index = scan.nextToken()
        var codePoint = scan.nextToken()
        var i = IntegerFormat.parseInt(index)
        var c = IntegerFormat.parseInt(codePoint)
        var item = (i, c)
        Array.add(item)
    } 
    srcFile.close()
    return Array
}

func generateMapping(encodingName:String) {
    var Array = aquireTable(encodingName)
    for(a in Array){
        var b = a[0]
        var c = IntegerFormat.toHexString(a[1])
        print("b:${b}     c:${c}\n")
    }

}

func main(){
    generateMapping("ibm866")

    return 0
}