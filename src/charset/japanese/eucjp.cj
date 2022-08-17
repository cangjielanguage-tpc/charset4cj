/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

package charset.japanese

import charset.encoding.*

class EUCJPEncoder <: Encoder {
    
    /**
     * Encodes a string into a byte array
     *
     * @param str of String
     *
     * @return Type of Array<UInt8>
     * @since 0.28.4
     */
    public func encode(str:String): Array<UInt8> {
        // replacement : 0x63 ,0x3F
        if(str.size() == 0){
            return Array<UInt8>()
        }
        let ref = Array<UInt8>(str.size() * 2, {i => 0})
        var position = 0
        var arr = str.toCharArray()
        for(ch in arr){
            var codePoint:UInt32 = UInt32(ch)
            // If code point is an ASCII code point, return a byte whose value is code point.
            if(codePoint <= 0x7F){
                ref[position] = UInt8(codePoint)
                position += 1
            }else if(codePoint == 0x00A5){
                ref[position] = 0x5C
                position += 1                
            }else if(codePoint == 0x203E){
                ref[position] = 0x7E
                position += 1                
            }else if(codePoint >= 0xFF61 && codePoint <= 0xFF9F){
                ref[position] = 0x8E
                ref[position + 1] = UInt8(codePoint - 0xFF61 + 0xA1)
                position += 2                
            }else{
                if(codePoint == 0x2212){
                    codePoint = 0xFF0D              
                }          
                var index = indexPointer(jis0208EncodeMapping, jis0208DecodeMapping, codePoint)      
                if(index >= 0){
                    var pointer = UInt32(index)
                    let lead = pointer / 94 + 0xA1
                    let trail = pointer % 94 + 0xA1
                    ref[position] = UInt8(lead)
                    ref[position+1] = UInt8(trail)
                    position += 2                    
                }else{
                    // error
                    ref[position] = 0x63
                    ref[position+1] = 0x3F
                    position += 2
                }
            }
        }    
        return ref[0..position]
    }
}



/**
 * euc-jp Character set decoder
 * euc-jp The single byte part is the same as ASCII
 *        The double byte part is ordinary cjk characters
 * @author freeonsky
 * @since 0.28.4
 */
class EUCJPDecoder <: Decoder{
    // Replace character when decoding error
    let replacement = '\u{FFFD}'

    /**
     * Decode byte array SRC into character array dest
     * euc-jp   single byte part is the same as ASCII
     *          The double byte part: 
     *              Katakana characters: first is 0x8E, second in 0xA1-0xDF
     *              JIS X 0208: first in 0xA1-0xFE, second in 0xA1-0xFE
     *          The three byte part is JIS X 0212:
     *              first is 0x8F, second in 0xA1-0xFE, thrid in 0xA1-0xFE
     * @param src Range: [srcOffset, srcLimit]
     * @param srcOffset of Int64
     * @param srcLimit of Int64
     * @param dest Range: [destUnusedOffset, dest.size()) not include dest.size()
     * @param destUnusedOffset Indicates a dest subscript that is not currently in use
     *
     * @return Type of (Int64, Int64): (srcIndex, destIndex)
     *         srcIndex Next unprocessed SRC subscript
     *         destIndex Next unhandled dest subscript
     * @since 0.28.4
     */
    public func decode(src:Array<UInt8>, srcOffset:Int64, srcLimit:Int64, 
            dest:Array<Char>, destUnusedOffset:Int64): (Int64, Int64) {
        // Index being processed by SRC
        var srcIndex = srcOffset   
        // Dest index being processed
        var destIndex = destUnusedOffset
        while(srcIndex <= srcLimit){
            var u0 = src[srcIndex];
            // Single byte
            if(u0 <= 0x7F){
                var c = Char(UInt32(u0))
                dest[destIndex] = c
                destIndex += 1
                srcIndex += 1     
                continue           
            }else{
                if(srcIndex + 1 > srcLimit){
                    // If only half of the double bytes are in SRC, return and wait for the subsequent data to enter SRC for reprocessing
                    return (srcIndex, destIndex)                    
                }
                
                var u1 = src[srcIndex+1]
                var pointer:Int64 = 0
                var codePoint:Char = '\u{0}'
                // Katakana characters: first is 0x8E, second in 0xA1-0xDF
                if(u0 == 0x8E && u1 >= 0xA1 && u1 <= 0xDF){
                    codePoint = Char(0xFF61 - 0xA1 + UInt32(u1))
                    dest[destIndex] = codePoint
                    srcIndex += 2
                    destIndex += 1
                    continue                       
                }
                // The three byte part is JIS X 0212: first is 0x8F, second in 0xA1-0xFE, thrid in 0xA1-0xFE
                if(u0 == 0x8F && u1 >= 0xA1 && u1 <= 0xDF){
                    if(srcIndex + 2 > srcLimit){
                        return (srcIndex, destIndex)
                    }
                    let u2 = src[srcIndex + 2]
                    if(u2 >= 0xA1 && u2 <= 0xDF){
                        pointer = Int64(Int64(u1 - 0xA1) * 94 + Int64(u2) - 0xA1)
                        let c = jis0208DecodeMapping[pointer]
                        if(c == 0){
                            codePoint = replacement    
                        }else{
                            codePoint = Char(c)
                        }
                    }else{
                        codePoint = replacement
                    }
                    dest[destIndex] = codePoint
                    srcIndex += 3
                    destIndex += 1
                    continue                        
                }
                // JIS X 0208: first in 0xA1-0xFE, second in 0xA1-0xFE
                if(u0 >= 0xA1 && u0 <= 0xDF && u1 >= 0xA1 && u1 <= 0xDF){
                    pointer = Int64(Int64(u0 - 0xA1) * 94 + Int64(u1) - 0xA1)
                    let c = jis0208DecodeMapping[pointer]
                    if(c == 0){
                        codePoint = replacement    
                    }else{
                        codePoint = Char(c)
                    }
                    dest[destIndex] = codePoint
                    srcIndex += 2
                    destIndex += 1
                    continue                      
                }

                // error
                dest[destIndex] = replacement
                srcIndex += 2
                destIndex += 1
                continue                      
            }
        }
        return (srcIndex, destIndex)
    }    
}