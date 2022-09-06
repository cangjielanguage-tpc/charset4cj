package charset

from std import io.*
from std import collection.*


import charset.encoding.*

public class TextReader{
    var input:InputStream
    var charset:Charset
    var bufSize: Int64
    var buf:Array<UInt8>
    var src:Array<UInt8>
    var position:Int64
    var eof = false

    public init(input:InputStream, charset!:Charset = Charsets.utf8, bufSize!:Int64 = 8192){
        this.input = input
        this.charset = charset
        this.bufSize = bufSize
        buf = Array<UInt8>(bufSize, item:0)
        src = buf
        position = 0
    }
    public func readAllLine():ArrayList<String>{
        let list = ArrayList<String>()
        while(true){
            var lineOp:Option<String> = readln()
            var end = match(lineOp){
                case Some(s) => false
                case None => true
            }
            if(end){
                break
            }else{
                var line = match(lineOp){
                    case Some(s) => s
                    case None => ""
                }
                list.append(line)
            }
        }        
        return list
    }
    public func read(): Option<Char>{
        if(eof && this.position == 0){
            return None
        }
        fillBuf()       
        var decoder = charset.newDecoder()
        var dest = Array<Char>(1, item:'\0')
        var (srcIndex, destIndex) = decoder.decode(src, 0, src.size - 1, dest, 0)
        if(destIndex == 1){
            rotateLeft(srcIndex)
            return dest[0]
        }
        return None
    }
    /**
    * read a of line String, when eof, return None
    */
    public func readln(): Option<String>{
        if(eof && this.position == 0){
            return None
        }
        fillBuf()
        // 如果有换行符
        var linefeed = UInt8(UInt32('\n'))
        var enter = UInt8(UInt32('\r'))
        var indexOp:Int64 = match(indexOf(src, linefeed)){
            case Some(index) => index
            case None => -1
        }
        var decoder = charset.newDecoder()
        if(indexOp >= 0){
            // 判断\n 前面是不是\r
            var len = indexOp + 1
            if(indexOp > 0 && src[indexOp - 1] == enter){
                len -= 1
            }
            let line = decoder.decode(src.slice(0, len))
            // 剩余buf前移
            rotateLeft(indexOp + 1)
            return Some(line)
        }else{
            var dest = Array<Char>(src.size, item:'\0')
            var (srcIndex, destIndex) = decoder.decode(src, 0, src.size - 1, dest, 0)
            rotateLeft(srcIndex)
            return Some(String(dest.slice(0, destIndex)))
        }
    }
    // 将 src 从 index 位置移动到0，依次左移
    private func rotateLeft(index:Int64){
        for(i in index..src.size){
            src[i - index] = src[i]
        }
        this.position = src.size - index
    }
    private func fillBuf(){
        while(this.position < buf.size - 1){
            var subArray = buf.slice(0, buf.size - this.position)
            let len = input.read(subArray)
            if(len == 0){ // if end of stream break loop
                eof = true
                break
            }
            this.position += len
        }
        this.src = this.buf.slice(0, this.position)
    }
    
}

