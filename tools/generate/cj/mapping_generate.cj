/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

import net.http.*
import net.tls.*
import std.io.*
import std.collection.*
import std.convert.*

let encodeMapFlag = false
func downloadFile(encodeName: String){
    let path = encodeName.toAsciiLower() + ".txt"
    if(File.exist(path)){
        return
    }
    let url = ""
    var cfg = TlsClientConfig("/etc/ssl/certs/ca-certificates.crt")
    let client = Client(cfg)
    try(fs = File(path, AccessMode.Write, OpenMode.Create)){
        let res = client.get(url)
        res.copyTo(fs)
    }catch(e: Exception){
    }
}

func readFileToMap(encodeName: String):Map<UInt32, UInt32>{
    var map = HashMap<UInt32, UInt32>()
    let path = encodeName.toAsciiLower() + ".txt"
    if(!File.exist(path)){
        downloadFile(encodeName)
    }    
    let fs = File(path, AccessMode.Read, OpenMode.Open)
    let sr = StringReader(fs)
    var lineOp = sr.readln()
    while(lineOp != None){
        var line = lineOp.getOrThrow()
        lineOp = sr.readln()
        if(line.startsWith("#")){
            continue
        }
        if(line == ""){
            continue
        }
        let items = line.split("\t")
        if(items.size <2){
            continue
        }
        let pointer = UInt32.parse(items[0].trimAscii())
        let codePoint = UInt32.parse(items[1].trimAscii())
        map.put(pointer, codePoint)
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
    for(v in 0..list.size){
        var i = list[v]
        if(map.contains(UInt32(i))){
            var codePoint = map[UInt32(i)]
            decodeMappingStr = decodeMappingStr + "\t\t[${i}, 0x" + codePoint.format("04x") + "]"
        }else{
            decodeMappingStr = decodeMappingStr + "\t\t0"
        }
        if(v != (list.size - 1)){
            decodeMappingStr = decodeMappingStr + ",\n"
        }else{
            decodeMappingStr = decodeMappingStr + "\n"
        }
    }
    decodeMappingStr = decodeMappingStr + "]\n\n"
    s = s + decodeMappingStr

    
    let fileName = encodeName.toAsciiLower().replace("-", "_") + "_mapping.cj"
    let path = "../../../src/charset/" + pkg + "/" + fileName
    try(fs = File(path, AccessMode.Write, OpenMode.OpenOrCreate)){
        fs.write(s.toUtf8Array())
    }catch(e:Exception){

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
    if(encodeMapFlag){
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
    }
    encodeMappingStr = encodeMappingStr + "])\n\n"
    s = s + encodeMappingStr
    let fileName = encodeName.toAsciiLower().replace("-", "_") + "_mapping.cj"
    let path = "../../../src/charset/" + pkg + "/" + fileName
    File.delete(path)
    try(fs = File(path, AccessMode.Write, OpenMode.OpenOrCreate)){
        fs.write(s.toUtf8Array())
    }catch(e:Exception){
        
    }
}

main(){
    writeMappingFile("EUC-KR", "korean")
    writeMappingFile("Big5", "traditionchinese")
    writeMappingFile("gb18030", "simplechinese")
    writeMappingFile("jis0208", "japanese")
    writeMappingFile("jis0212", "japanese")
    writeMappingFile("iso-2022-jp-katakana", "japanese")
    writeRangeMappingFile("gb18030-ranges", "simplechinese")

    let singlebyteencoding = [
            "ibm866",
            "iso-8859-2",
            "iso-8859-3",
            "iso-8859-4",
            "iso-8859-5",
            "iso-8859-6",
            "iso-8859-7",
            "iso-8859-8",
            "iso-8859-10",
            "iso-8859-13",
            "iso-8859-14",
            "iso-8859-15",
            "iso-8859-16",
            "koi8-r",
            "koi8-u",
            "macintosh",
            "windows-874",
            "windows-1250",
            "windows-1251",
            "windows-1252",
            "windows-1253",
            "windows-1254",
            "windows-1255",
            "windows-1256",
            "windows-1257",
            "windows-1258",
            "x-mac-cyrillic"
    ]
    for(encodeName in singlebyteencoding){
        writeMappingFile(encodeName, "singlebyte")
    }

    0
}
