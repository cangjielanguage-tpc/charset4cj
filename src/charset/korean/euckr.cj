package charset.korean

import charset.encoding.*

/**
* EUC-KR korean encoding
*/
public class EUCKRCharset <: Charset{
    public init(){
        // super("EUC-KR", ["cseuckr",  "csksc56011987",  "euc-kr",  "iso-ir-149",  "korean",  "ks_c_5601-1987",  "ks_c_5601-1989",  "ksc5601",  "ksc_5601",  "windows-949"])
        this.name = "EUC-KR"
        this.labels = ["cseuckr",  "csksc56011987",  "euc-kr",  "iso-ir-149",  "korean",  "ks_c_5601-1987",  "ks_c_5601-1989",  "ksc5601",  "ksc_5601",  "windows-949"]
    }
    public func newEncoder():Encoder{
        let encoder = EUCKREncoder()
        return encoder
    }
    public func newDecoder():Decoder{
        let decoder = EUCKRDecoder()
        return decoder
    }
}

class EUCKREncoder <: Encoder {
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
class EUCKRDecoder <: Decoder{
    // 解码出错时的替换字符
    let replacement = '\u{FFFD}' 
    let table = EUC_KRDecodeMapping

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
                if(u0 < 0xc7){
                    var pointer = 178 * Int64(u0 - 0x81)
                    if(u1 >= 0x41 && u1 < 0x5b){
                        pointer += Int64(u1) - 0x41
                    }else if(0x61 <= u1 && u1 < 0x7b){
                        pointer += Int64(u1) - (0x61 - 26)
                    }else if(0x81 <= u1 && u1 < 0xff){
                        pointer += Int64(u1) - (0x81 - 2*26)
                    }else{
                        // 出错
                        srcIndex += 2
                        destIndex += 1
                        dest[destIndex] = replacement
                        continue                              
                    }

                }else if(0xa1 <= u1 && u1 < 0xff){
                    pointer = 178*(0xc7-0x81) + Int64(u0-0xc7)*94 + Int64(u1-0xa1)
                }else{
                    // 出错后，使用 FFFD 替换
                    dest[destIndex] = replacement     
                    destIndex += 1
                    srcIndex += 1
                    continue                                       
                }  
                print("pointer:${pointer}\n")
                dest[destIndex] = chr(table[pointer])
                srcIndex += 2
                destIndex += 1
                continue                
            }
        }
        return (srcIndex, destIndex)
    }    
}
