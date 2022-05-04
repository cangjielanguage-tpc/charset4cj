package charset.unicode

import charset.encoding.*

/**
* UTF8 字符集
*/
public class UTF16Charset <: Charset{
    // 是否大端， be = true 大端模式； be = false 小端模式
    var be:Bool
    public init(be:Bool){
        this.be = be
        if(be){
            this.name = "UTF-16BE"
            this.labels = ["unicodefffe", "utf-16be"]
        }else{
            this.name = "UTF-16LE"
            this.labels = ["csunicode", "iso-10646-ucs-2", "ucs-2", "unicode", "unicodefeff", "utf-16", "utf-16le"]
        }
    }
    public func newEncoder():Encoder{
        let encoder = UTF16Encoder(be)
        return encoder
    }
    public func newDecoder():Decoder{
        let decoder = UTF16Decoder(be)
        return decoder
    }
}

/**
* UTF-16编码器 
* 功能： 将unicode codepoint 编码成 utf16 字节序列
*/
class UTF16Encoder <: Encoder {
    // 是否大端， be = true 大端模式； be = false 小端模式
    var be:Bool
    init(be:Bool){
        this.be = be
    }
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
            var codePoint:UInt32 = ord(ch)
            // 双字节
            if(codePoint <= 0xFFFF){
                var high = UInt8((codePoint >> 8) & 0xFF)
                var low = UInt8(codePoint & 0xFF)
                if(be){
                    Array[position] = high
                    position += 1
                    Array[position] = low;
                    position += 1
                }
            }else{
                // 四字节
                codePoint -= 0x10000;
                var surrogateHigh:UInt16 = 0xD800 + UInt16((codePoint >> 10) & 0x3FF)
                var surrogateLow:UInt16 = 0xDC00 + UInt16(codePoint & 0x3FF)
                var u0 = UInt8((surrogateHigh >> 8 ) & 0xFF)
                var u1 = UInt8(surrogateHigh & 0xFF)
                var u2 = UInt8((surrogateLow >> 8) & 0xFF)
                var u3 = UInt8(surrogateLow & 0xFF)
                if(be){
                    Array[position] = u0
                    position += 1
                    Array[position] = u1
                    position += 1
                    Array[position] = u2
                    position += 1
                    Array[position] = u3
                    position += 1                                                            
                }else{
                    Array[position] = u1
                    position += 1
                    Array[position] = u0
                    position += 1
                    Array[position] = u3
                    position += 1
                    Array[position] = u2
                    position += 1                    
                }
            }
        }
        return Array[0..position]
    }
}

/**
* UTF8 解码器
* 功能：将utf8字节序列解码成 unicode codepoint 数组
*/
class UTF16Decoder <: Decoder{
    let replacement = '\u{FFFD}'
    // 是否大端， be = true 大端模式； be = false 小端模式
    var be:Bool
    init(be:Bool){
        this.be = be
    }


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
            // 位数不够
            if(srcIndex+1 > srcLimit){
                return (srcIndex, destIndex)
            }
            var u1 = src[srcIndex + 1]
            // print("u0:${u0}      u1:${u1}")
            // [0xd800, 0xdc00) 高
            // [0xdc00, 0xe000) 低          
            var codeUnit:UInt32 = 0
            if(be){
                codeUnit = (UInt32(u0) << 8) + UInt32(u1)
            }else{
                codeUnit = (UInt32(u1) << 8) + UInt32(u0)
            }
            // 4字节
            if(codeUnit >=0xd800 && codeUnit < 0xe000){
                if(srcIndex+3 > srcLimit){
                    //位数不够
                    return (srcIndex, destIndex)
                }
                var u2 = src[srcIndex + 2]
                var u3 = src[srcIndex + 3]
                var codeUnit2:UInt32 = 0
                if(be){
                    codeUnit2 = (UInt32(u2) << 8) + UInt32(u3)
                }else{
                    codeUnit2 = (UInt32(u3) << 8) + UInt32(u2)
                }
                var codePoint:UInt32 = 0x10000 + (UInt32(codeUnit - 0xD800) << 10) + codeUnit2 - 0xDC00
                dest[destIndex] = chr(codePoint)
                srcIndex += 4
                destIndex += 1
                continue
            }else{
                // 双字节
                dest[destIndex] = chr(codeUnit)
                print("${dest[destIndex]}")
                srcIndex += 2
                destIndex += 1
                continue                
            }
        }        
        (srcIndex, destIndex)
    }    
}

