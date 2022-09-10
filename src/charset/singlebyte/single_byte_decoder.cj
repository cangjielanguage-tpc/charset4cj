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
     * @param src input byte array
     * @param dest output Char array
     *
     * @return Type of (Int64, Int64): (srcIndex, destIndex)
     *         srcIndex Next unprocessed SRC subscript
     *         destIndex Next unhandled dest subscript
     * @since 0.28.4
     */
    public func decode(src:Array<UInt8>, dest:Array<Char>): (Int64, Int64) {
        var srcOffset:Int64 = 0
        var srcLimit:Int64 = src.size - 1
        var destStart:Int64 = 0                      
        // src processing index
        var srcIndex = srcOffset   
        // dest processing index
        var destIndex = destStart
        while(srcIndex <= srcLimit){
            if(destIndex >= dest.size){
                return (srcIndex, destIndex)
            }            
            var byte = src[srcIndex]
            if(byte <= 0x7F){
                dest[destIndex] = Char(UInt32(byte))
                destIndex += 1
            }else{
                var pointer = Int64(byte - 0x80)
                dest[destIndex] = match(decodeMapping.get(pointer)){
                    case Some(c) => Char(c)
                    case None => replacement
                }
                destIndex += 1
            }
            srcIndex += 1  
        }
        return (srcIndex, destIndex)                
    }
}