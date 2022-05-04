package charset.unicode

import charset.encoding.*

/**
* UTF32 字符集
*/
public class UTF32Charset <: Charset{
    // 是否大端， be = true 大端模式； be = false 小端模式
    var be:Bool
    public init(be:Bool){
        this.be = be
        if(be){
            this.name = "UTF-32BE"
            this.labels = ["utf-32be"]
        }else{
            this.name = "UTF-32LE"
            this.labels = ["utf-32le"]
        }
    }
    public func newEncoder():Encoder{
        let encoder = UTF32Encoder(be)
        return encoder
    }
    public func newDecoder():Decoder{
        let decoder = UTF32Decoder(be)
        return decoder
    }
}

/**
* UTF-32编码器 
* 功能： 将unicode codepoint 编码成 utf32 字节序列
*/
class UTF32Encoder <: Encoder {
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
            var u0 = UInt8((codePoint >> 24) & 0xFF)
            var u1 = UInt8((codePoint >> 16) & 0xFF)
            var u2 = UInt8((codePoint >> 8) & 0xFF)
            var u3 = UInt8(codePoint & 0xFF)
            
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
                Array[position] = u3
                position += 1
                Array[position] = u2
                position += 1
                Array[position] = u1
                position += 1
                Array[position] = u0
                position += 1                       
            }
        }
        return Array[0..position]
    }
}

/**
* UTF8 编码器
* 功能：将utf32字节序列解码成 unicode codepoint 数组
*/
class UTF32Decoder <: Decoder{
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
            // 位数不够
            if(srcIndex+3 > srcLimit){
                return (srcIndex, destIndex)
            }
            var u0 = src[srcIndex];
            var u1 = src[srcIndex + 1]
            var u2 = src[srcIndex + 2]     
            var u3 = src[srcIndex + 3]     
            var codeUnit:UInt32 = if(be){
                (UInt32(u0) << 24) + (UInt32(u1) << 16) + (UInt32(u2) << 8) + UInt32(u3)
            }else{
                (UInt32(u3) << 24) + (UInt32(u2) << 16) + (UInt32(u1) << 8) + UInt32(u0)
            }
            dest[destIndex] = chr(codeUnit)
            destIndex += 1
            srcIndex += 4
            continue
        }        
        (srcIndex, destIndex)
    }    
}

