package charset.unicode

import charset.encoding.*

/**
* UTF8 字符集
*/
public class UTF8Charset <: Charset{
    public init(){
        this.name = "UTF-8"
        this.labels = ["unicode-1-1-utf-8", "unicode11utf8", "unicode20utf8", "utf-8", "utf8", "x-unicode20utf8"]
    }
    public func newEncoder():Encoder{
        let encoder = UTF8Encoder()
        return encoder
    }
    public func newDecoder():Decoder{
        let decoder = UTF8Decoder()
        return decoder
    }
}

/**
* UTF-8编码器 
* 功能： 将unicode codepoint 编码成 utf8 字节序列
* utf8 代码点（codepoint）与编码映射关系：
* 0x00000000 - 0x0000007F:
*     0xxxxxxx
* 
* 0x00000080 - 0x000007FF:
*     110xxxxx 10xxxxxx
* 
* 0x00000800 - 0x0000FFFF:
*     1110xxxx 10xxxxxx 10xxxxxx
* 
* 0x00010000 - 0x001FFFFF:
*     11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
*/
class UTF8Encoder <: Encoder {
    /**
    * 将字符串编码成字节数组
    */
    public func encode(str:String): Array<UInt8>{
        if(str.size() == 0){
            return Array<UInt8>()
        }
        // 创建返回值数组，数组最长是str.size()的4倍
        var Array = Array<UInt8>(str.size()*4,{i => 0})
        // Array 的 第一个未被处理的下标
        var position = 0
        var arr = str.toCharArray()
        for(ch in arr){
            var codepoint = ord(ch)
            if(codepoint <= 0x7F){
                Array[position] = UInt8(codepoint)
                position += 1
            }else if(codepoint >= 0x80 && codepoint <= 0x7FF){
                Array[position] = UInt8(0xC0 | ((codepoint >> 6) & 0x1F))
                position += 1
                Array[position] = UInt8(0x80 | (codepoint & 0x3F))
                position += 1
            }else if(codepoint >= 0x800 && codepoint <= 0xFFFF){
                Array[position] = UInt8(0xE0 | ((codepoint >> 12) & 0x0F))
                position += 1
                Array[position] = UInt8(0x80 | ((codepoint >> 6) & 0x3F))
                position += 1  
                Array[position] = UInt8(0x80 | (codepoint & 0x3F))
                position += 1                                
            }else{
                Array[position] = UInt8(0xF0 | ((codepoint >> 18) & 0x07))
                position += 1
                Array[position] = UInt8(0x80 | ((codepoint >> 12) & 0x3F))
                position += 1  
                Array[position] = UInt8(0x80 | ((codepoint >> 6) & 0x3F))
                position += 1                     
                Array[position] = UInt8(0x80 | (codepoint & 0x3F))
                position += 1                     
            }
        }
        return Array[0..position]
    }
}

/**
* UTF8 解码器
* 功能：将utf8字节序列解码成 unicode codepoint 数组
*/
class UTF8Decoder <: Decoder{
    let replacement = '\u{FFFD}'


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
        var srcIndex = srcOffset    
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
            }else if(u0 > 0x7F && u0 <= 0b11011111){
                // 双字节
                if(srcIndex+1 <= srcLimit){
                    var u1 = src[srcIndex+1]
                    if(u1 <= 0b10111111){
                        var codePoint = UInt32(UInt32(u0 & 0b00011111) << 6) + UInt32(u1 & 0b00111111)
                        dest[destIndex] = chr(codePoint)
                    }else{
                        // 出错后，使用 FFFD 替换
                        dest[destIndex] = replacement
                    }
                    destIndex += 1
                    srcIndex += 2
                    continue
                }else{
                    // 如果双字节只有 一半在 src里面，则返回，等待后面的数据进入src后重新处理
                    return (srcIndex, destIndex)
                }
            }else if(u0 > 0b11011111 && u0 <= 0b11101111){
                // 三字节
                if(srcIndex + 2 <= srcLimit){
                    var u1 = src[srcIndex+1]
                    var u2 = src[srcIndex + 2]
                    if(u1 <= 0b10111111 && u2 <= 0b10111111){
                        var codePoint = UInt32(UInt32(u0 & 0b00001111) << 12) + UInt32(UInt32(u1 & 0b00111111) << 6) + 
                                            UInt32(u2 & 0b00111111)
                        dest[destIndex] = chr(codePoint)
                    }else{
                        // 出错后，使用 FFFD 替换
                        dest[destIndex] = replacement
                    }
                    srcIndex += 3
                    destIndex += 1
                    continue
                }else{
                    // 如果三字节只有 一部分在 src里面，则返回，等待后面的数据进入src后重新处理
                    return (srcIndex, destIndex)
                }
            }else if(u0 > 0b11101111 && u0 <= 0b11110111){
                // 四字节
                if(srcIndex + 3 <= srcLimit){
                    var u1 = src[srcIndex+1]
                    var u2 = src[srcIndex + 2]                
                    var u3 = src[srcIndex + 3]     
                    if(u1 <= 0b10111111 && u2 <= 0b10111111 && u3 <= 0b10111111){
                        var codePoint = UInt32(UInt32(u0 & 0b00000111) << 18) + UInt32(UInt32(u1 & 0b00111111) << 12) + 
                                            UInt32(UInt32(u2 & 0b00111111) << 6) + UInt32(u2 & 0b00111111)
                        dest[destIndex] = chr(codePoint)
                    }else{
                        // 出错后，使用 FFFD 替换
                        dest[destIndex] = replacement
                    }         
                    srcIndex += 4
                    destIndex += 1
                    continue
                }else{
                    // 如果四字节只有 一部分在 src里面，则返回，等待后面的数据进入src后重新处理
                    return (srcIndex, destIndex)
                }
            }else{
                // 出错后，使用 FFFD 替换
                dest[destIndex] = replacement
                srcIndex += 1
                destIndex += 1
                continue
            }
        }        
        (srcIndex, destIndex)
    }    
}

