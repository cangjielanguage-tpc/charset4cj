package charset.traditionchinese

import charset.encoding.*

/**
* Big5 encoding
*/
public class BIG5Charset <: Charset{
    public init(){
        this.name = "Big5"
        this.labels = ["big5", "big5-hkscs", "cn-big5", "csbig5", "x-x-big5"]
    }
    public func newEncoder():Encoder{
        let encoder = BIG5Encoder()
        return encoder
    }
    public func newDecoder():Decoder{
        let decoder = BIG5Decoder()
        return decoder
    }
}

class BIG5Encoder <: Encoder {
    /**
    * 将字符串编码成字节数组
    */
    public func encode(str:String): Array<UInt8>{
        let ref = Array<UInt8>()
        // TODO
        return ref
    }
}

/**
* gb18030 字符集解码器
* gb18030   单字节部分与ascii相同
*           双字节部分是普通汉字
*           四字节部分与unicode通过一个表做映射
*/
class BIG5Decoder <: Decoder{
    // 解码出错时的替换字符
    let replacement = '\u{FFFD}' 
    let table = Big5DecodeMapping

    /**
    * 将字节数组src解码成字符数组 dest
    * 字节数组src的可用范围 [srcOffset, srcLimit]
    *   srcOffset 表示当前没有处理的 src 下标
    * 字符数组dest的可用范围 [destUnusedOffset, dest.size()) ,不包含dest.size();
    *   destUnusedOffset 表示当前没有使用的 dest 下标
    * 返回值 (srcIndex, destIndex)； 
    *   srcIndex 下一个没有处理的src下标
    *   destIndex 下一个没有处理的dest下标
    */
    public func decode(src:Array<UInt8>, srcOffset:Int64, srcLimit:Int64, 
            dest:Array<Char>, destUnusedOffset:Int64): Int64 * Int64 {
        // src正在处理的index
        var srcIndex = srcOffset   
        // dest 正在处理的 index
        var destIndex = destUnusedOffset
        while(srcIndex <= srcLimit){
            var u0 = src[srcIndex];
            // 单字节
            if(u0 <= 0x7F){
                var c = chr(UInt32(u0))
                dest[destIndex] = c
                destIndex += 1
                srcIndex += 1     
                continue           
            }else if(u0 >= 0x81 && u0 <= 0xFE){
                if(srcIndex + 1 > srcLimit){
                    // 如果双字节只有 一半在 src里面，则返回，等待后面的数据进入src后重新处理
                    return (srcIndex, destIndex)                    
                }
                
                var u1 = src[srcIndex+1]
                var pointer:Int64 = 0
                if(u1 >= 0x40 && u1 < 0x7F){
                    u1 -= 0x40
                }else if(0xa1 <= u1 && u1 < 0xff){
                    u1 -= 0x62
                }else {
                    // 出错后，使用 FFFD 替换
                    dest[destIndex] = replacement     
                    destIndex += 1
                    srcIndex += 1
                    continue     
                }
                pointer = Int64(u0-0x81)*157 + Int64(u1)
                if(pointer < table.size()){
                    var s:Array<Char>
                    //  = Array<Char>(2, {i => '\u{0}'})
                    if(pointer == 1133){
                        s = "\u{00CA}\u{0304}".toCharArray()
                    }else if(pointer == 1135){
                        s = "\u{00CA}\u{030C}".toCharArray()
                    }else if(pointer == 1164){
                        s = "\u{00EA}\u{0304}".toCharArray()
                    }else if(pointer == 1166){
                        s = "\u{00EA}\u{030C}".toCharArray()
                    }else{
                        dest[destIndex] = chr(table[pointer])
                        srcIndex += 2
                        destIndex += 1
                        continue                      
                    }
                    dest[destIndex] = s[0]
                    destIndex += 1
                    dest[destIndex] = s[1]
                    destIndex += 1
                    srcIndex += 2
                    continue
                }else{
                    // 出错后，使用 FFFD 替换
                    dest[destIndex] = replacement     
                    destIndex += 1
                    srcIndex += 1
                    continue                   
                }
            }
        }
        return (srcIndex, destIndex)
    }    
}
