// 文本读写io
package textio

import charset.unicode.*
import charset.encoding.*

from std import io.*
from std import collection.*

/**
* 文件接口
* 能够按行读取/写入utf8编码文件
*/
public class TextIO{

    let src:Array<UInt8>
    // 位置，下一个要被读或写的元素的索引，每次读写缓冲区数据时都会改变改值，为下次读写作准备
    var srcPosition:Int64 = 0
    let dest:Array<Char>
    var destPosition:Int64 = 0
    var eof:Bool = false
    var fs:FileStream
    // 字符集
    var charset:Charset

    init(path:String, charset:Charset, bufSize:Int64){
        this.src = Array<UInt8>(bufSize, {i => 0})
        this.dest = Array<Char>(bufSize, {i => '\u{0}'})
        this.charset = charset 
        this.fs = FileStream(path)
        this.fs.openFile()
    }
    init(path:String, charset:Charset){
        this(path, charset, 8192)
    }    
    init(path:String){
        this(path, UTF8Charset(), 8192)
    }
    /**
    * 从文件里面读取字符到 src 字节数组
    */
    private func readSrc(){
        // 如果src已满，直接返回
        if(srcPosition >= src.size){
            return
        }
        // 如果文件已经结束，直接返回
        if(eof){
            return
        }
        // func read (b: Array< UInt8 >, off: Int64, cnt: Int64): Int64 	
        var cnt = fs.read(this.src, srcPosition, src.size - srcPosition)
        if(cnt <= 0){
            eof = true
        }
        srcPosition += cnt
    }
    /**
    * 将src字节数组里面的数据解码成dest字符数组，使用utf8编码
    */
    private func decodeSrc(){
        // 如果dest已满，直接返回
        if(destPosition >= dest.size){
            return
        }
        // 1， 在开始解码前，先从文件读取数据到src
        readSrc()
        // 2, 创建解码器
        var decoder = charset.newDecoder()
        // 3， 解码
        var res = decoder.decode(src, 0, srcPosition - 1, dest, destPosition)
        
        
        // 如果文件已经读完，直接返回
        if(eof){
            return
        }
        // 4， 如果没有读完，重置src
        var srcIndex = res[0] // 下一个没有处理的src下标
        // 4.1. 清理src
        if(srcIndex < srcPosition){
            // 前移src，从srcIndex开始
            var i= 0
            while(i < srcPosition){
                src[i] = src[srcIndex +i]
                i += 1
            }
            srcPosition = srcPosition - srcIndex
        }else{
            // 4.2清空src
            srcPosition = 0
        }
        // 2. 设置dest的destPosition位置, res[1] 表示已经处理过的最后一个 dest 下标 + 1
        destPosition = res[1]
    }

    func writeLine(str:String){
        var encoder = charset.newEncoder()
        var arr = encoder.encode(str + "\n")
        fs.write(arr, 0, arr.size)
    }
    
    /**
    * 以utf8编码读取一行
    */
    func readLine():String*Bool{
        var str = ""

        // 1, 如果dest里面没有数据，就从 src(字节数组) 里面解析 数据到 dest（字符数组）
        if(destPosition <= 0){
            decodeSrc()
        }
        // 2, 如果dest里面有数据，检测dest里面的换行符
        var i = 0
        var find:Bool = false
        while(i < destPosition){
            var ch = dest[i]
            
            // 2.1 如果检测到换行符，截取行
            if(ch == '\n'){
                find = true
                var lineEnd = i

                if((i > 0) && (dest[i-1] == '\r')){
                    lineEnd = i - 1
                }
                if(lineEnd == 0){
                    str = ""
                }else{
                    str = String(dest[0..lineEnd])
                }
                // 2.2 截取dest前面的字符串后， 将后面的字符前移
                if(i + 1 == destPosition){
                    // 2.2.1 如果dest里面没有字符了，将destPosition设置为0，表示dest可以继续从0下标重新用
                    destPosition = 0
                }else{
                    // 2.2.2 前移dest， 从 i+1 位置开始
                    var j = 0
                    while(j < destPosition - i - 1){
                        dest[j] = dest[i+1+j]
                        j += 1
                    }
                    destPosition = j
                }
                break;
            }
            i += 1
        }

        // 3, 如果没有找到
        if(!find){
            // 3.1 如果文件没有读取完，并且dest未满,再次解码src
            if(!eof && dest.size > destPosition){
                decodeSrc()
            }
            // 3.2 将所有 dest里面的字符返回，并清空dest
            var mysize = dest.size
            str = String(dest[0..destPosition])
            destPosition = 0
        }
        return (str, eof)
    }

    func readAllLine():Array<String>{
        var allLine = ArrayList<String>()

        var res:String*Bool = this.readLine()
        var line = res[0]
        var eof = res[1]
        while(!eof){
            line = res[0]
            eof = res[1]
            allLine.add(line)
            res = this.readLine()
        }    
        return Array(allLine)
    }

    func close(){
        fs.close()
    }
}
