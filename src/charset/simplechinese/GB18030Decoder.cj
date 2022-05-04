package charset.simplechinese

import charset.encoding.*



/**
* gb18030 字符集解码器
* gb18030   单字节部分与ascii相同
*           双字节部分是普通汉字
*           四字节部分与unicode通过一个表做映射
*/
public class GB18030Decoder <: Decoder{
    // 解码出错时的替换字符
    let replacement = '\u{FFFD}' 
    let table = gb18030DecodeMapping

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
            }else if(u0 == 0x80){
                dest[destIndex] = chr(0x20AC)
                destIndex += 1      
                srcIndex += 1
                continue                 
            }else if(u0 >= 0x81 && u0 <= 0xFE){
                if(srcIndex + 1 > srcLimit){
                    // 如果双字节只有 一半在 src里面，则返回，等待后面的数据进入src后重新处理
                    return (srcIndex, destIndex)                    
                }
                
                var u1 = src[srcIndex+1]
                // 双字节
                if((u1 >= 0x40 && u1 <= 0x7E) || (u1 >= 0x80 && u1 <= 0xFE)){
                    var offset:UInt8 = if (u1 <= 0x7F){
                                            0x40
                                        }else{
                                            0x41
                                        }                
                    var pointer = Int64(Int64(u0 - 0x81) * 190) + Int64(u1 - offset)
                    var codePoint = if(pointer < 23940){
                                        chr(table[pointer])
                                    }else{
                                        replacement;
                                    }
                    dest[destIndex] = codePoint
                    destIndex += 1
                    srcIndex += 2
                    continue                    
                }else if(u1 >= 0x30 && u1 <= 0x39){
                    if(srcIndex + 3 > srcLimit){
                        // 如果四字节只有一部分在 src里面，则返回，等待后面的数据进入src后重新处理
                        return (srcIndex, destIndex)
                    }
                    // 四字节
                    var u2 = src[srcIndex + 2]
                    var u3 = src[srcIndex + 3]
                    if((u2 >= 0x81 && u2 <= 0xFE) && (u3 >= 0x30 || u3 <= 0x39)){
                        var pointer = Int64(u0 - 0x81) * (10 * 126 * 10) +
                                    Int64(u1 - 0x30) * (10 * 126) +
                                    Int64(u2 - 0x81) * 10 +
                                    Int64(u3) - 0x30      
                        if(pointer == 7457){
                            dest[destIndex] = '\u{E7C7}' 
                            srcIndex += 4
                            destIndex += 1
                            continue
                        }else if(pointer > 39419 && pointer < 189000){
                            srcIndex += 4
                            destIndex += 1
                            dest[destIndex] = replacement
                            continue          
                        }else{
                            var start = 0
                            var end = gb18030_rangesMapping.size()
                            while(start < end){
                                var h = start + (end-start) / 2
                                if(pointer >= Int64(gb18030_rangesMapping[h][0])){
                                    start = h + 1
                                }else{
                                    end = h
                                }
                            }
                            var code:Array<UInt32> = gb18030_rangesMapping[start - 1]   
                            var codePoint = UInt32(UInt32(pointer) + UInt32(code[1]) - UInt32(code[0]))
                            dest[destIndex] = chr(codePoint)
                            destIndex += 1
                            srcIndex += 4
                            continue                                                                             
                        }                                                     
                    }else{
                        // 出错
                        srcIndex += 4
                        destIndex += 1
                        dest[destIndex] = replacement
                        continue                               
                    }
                
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