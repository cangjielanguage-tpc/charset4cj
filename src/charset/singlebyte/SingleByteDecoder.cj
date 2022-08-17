/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * Single byte character set decoder
 */

package charset.singlebyte

from std import collection.*
import charset.encoding.*

/**
 * Single byte character set decoder
 * @author freeonsky
 * @since 0.28.4
 */
class SingleByteDecoder <: Decoder{
    let replacement = '\u{FFFD}'
    var decodeMapping:Array<UInt32> = []


    init(charset: SingleByteCharset){
        var name = charset.charsetName()
        decodeMapping = charset.decodeDic[name]
    }
    
    /**
     * Decode byte array SRC into character array dest
     *
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
        // src processing index
        var srcIndex = srcOffset   
        // dest processing index
        var destIndex = destUnusedOffset
        while(srcIndex <= srcLimit){
            var byte = src[srcIndex]
            if(byte <= 0x7F){
                dest[destIndex] = Char(UInt32(byte))
                destIndex += 1
            }else{
                var pointer = Int64(byte - 0x80)
                var value = decodeMapping[pointer]
                if(value == 0xFFFF){
                    dest[destIndex] = replacement    
                }else{
                    dest[destIndex] = Char(value)
                }
                destIndex += 1
            }
            srcIndex += 1  
        }
        return (srcIndex, destIndex)                
    }
}