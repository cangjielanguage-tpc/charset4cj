from net import http.*
from net import tls.*
from std import io.*
from std import collection.*


func downloadFile(encodeName: String){
    let path = encodeName.toAsciiLower() + ".txt"
    if(File.exist(path)){
        return
    }
    // 1. download file
    let url = "https://encoding.spec.whatwg.org/index-${encodeName.toAsciiLower()}.txt"
    var cfg = TlsClientConfig("/etc/ssl/certs/ca-certificates.crt")
    let client = Client(cfg)
    try{
        let res = client.get(url)
        let s = String.fromUtf8(res.readToEnd())
        let fs = FileStream(path)
        if(fs.openFile()){
            fs.write(s)
            fs.close()
        }
    }catch(e: Throwable){
        println(e)
    }
}

func readFileToMap(encodeName: String):Map<UInt32, UInt32>{
    var map = HashMap<UInt32, UInt32>()
    let path = encodeName.toAsciiLower() + ".txt"
    if(!File.exist(path)){
        downloadFile(encodeName)
    }    
    let fs = FileStream(path)
    if(fs.openFile()){
        var str = fs.readAllText()
        var lines = str.split("\n")
        for(line in lines){
            if(line.startsWith("#")){
                continue
            }
            if(line == ""){
                continue
            }
            let items = line.split("\t")
            if(items.size() <2){
                continue
            }
            let pointer = UInt32.parse(items[0].trimAscii())
            let codePoint = UInt32.parse(items[1].trimAscii())
            map.put(pointer, codePoint)
        }
        fs.close()
    }
    return map
}

func maxMapKey(map:Map<UInt32, UInt32>):UInt32{
    let keys = map.keys()
    var max:UInt32 = 0
    for(key in keys){
        if(max <= key){
            max = key
        }
    }
    return max
}

func writeRangeMappingFile(encodeName:String, pkg:String){
    var s = """
/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * https://encoding.spec.whatwg.org/index-${encodeName.toAsciiLower()}.txt Automatic document generation
 */

package charset.${pkg}


"""
    let map = readFileToMap(encodeName)
    var decodeMappingStr = "let " + encodeName.replace("-", "_")  + "Mapping: Array<Array<UInt32>> = [\n"
    let keys = map.keys()
    let list = ArrayList(keys)
    list.sort()
    for(v in 0..list.size()){
        var i = list[v]
        if(map.contains(UInt32(i))){
            var codePoint = map[UInt32(i)]
            decodeMappingStr = decodeMappingStr + "\t\t[${i}, 0x" + codePoint.format("04x") + "]"
        }else{
            decodeMappingStr = decodeMappingStr + "\t\t0"
        }
        if(v != (list.size() - 1)){
            decodeMappingStr = decodeMappingStr + ",\n"
        }else{
            decodeMappingStr = decodeMappingStr + "\n"
        }
    }
    decodeMappingStr = decodeMappingStr + "]\n\n"
    s = s + decodeMappingStr

    
    let fileName = encodeName.toAsciiLower().replace("-", "_") + "_mapping.cj"
    let path = "../../../src/charset/" + pkg + "/" + fileName
    let fs = FileStream(path)
    if(fs.openFile()){
        fs.write(s)
        fs.close()
    }
}

func writeMappingFile(encodeName:String, pkg:String){
    var s = """
/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * https://encoding.spec.whatwg.org/index-${encodeName.toAsciiLower()}.txt Automatic document generation
 */

package charset.${pkg}

from std import collection.*

"""
    let map = readFileToMap(encodeName)
    var decodeMappingStr = "let " + encodeName.replace("-", "_")  + "DecodeMapping: Array<UInt32> = [\n"
    let maxPointer = maxMapKey(map)
    for(i in 0..maxPointer+1){
        if(map.contains(UInt32(i))){
            var codePoint = map[UInt32(i)]
            decodeMappingStr = decodeMappingStr + "\t\t0x" + codePoint.format("04x") 
        }else{
            decodeMappingStr = decodeMappingStr + "\t\t0"
        }
        if(i != maxPointer){
            decodeMappingStr = decodeMappingStr + ",\n"
        }else{
            decodeMappingStr = decodeMappingStr + "\n"
        }
    }
    decodeMappingStr = decodeMappingStr + "]\n\n"
    s = s + decodeMappingStr

    var encodeMappingStr = "let " + encodeName.replace("-", "_")  + "EncodeMapping = HashMap<UInt32, UInt32>([\n"
    for(i in 0..maxPointer+1){
        if(map.contains(UInt32(i))){
            var codePoint = map[UInt32(i)]
            encodeMappingStr = encodeMappingStr + "\t\t(0x" + codePoint.format("04x") + ", ${i})"
            if(i != maxPointer){
                encodeMappingStr = encodeMappingStr + ",\n"
            }else{
                encodeMappingStr = encodeMappingStr + "\n"
            }            
        }
    }
    encodeMappingStr = encodeMappingStr + "])\n\n"
    s = s + encodeMappingStr
    let fileName = encodeName.toAsciiLower().replace("-", "_") + "_mapping.cj"
    let path = "../../../src/charset/" + pkg + "/" + fileName
    let fs = FileStream(path)
    if(fs.openFile()){
        fs.write(s)
        fs.close()
    }
}

main(){
    let encodeName = "EUC-KR"
    writeMappingFile(encodeName, "korean")
    writeMappingFile("gb18030", "simplechinese")
    writeRangeMappingFile("gb18030-ranges", "simplechinese")

    0
}