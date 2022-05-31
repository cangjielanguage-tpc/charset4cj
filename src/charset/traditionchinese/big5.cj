/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * This file is about Big5 encoding
 */
package charset.traditionchinese

import charset.encoding.*

/**
 * Big5 encoding
 * @author freeonsky
 * @since 0.28.4
 */
public class BIG5Charset <: Charset{

    /**
     * The Function is init constructor
     *
     * @since 0.28.4
     */
    public init(){
        this.name = "Big5"
        this.labels = ["big5", "big5-hkscs", "cn-big5", "csbig5", "x-x-big5"]
    }

    /**
     * The Function is newEncoder
     *
     * @return Type of Encoder
     * @since 0.28.4
     */
    public func newEncoder():Encoder{
        let encoder = BIG5Encoder()
        return encoder
    }

    /**
     * The Function is newDecoder
     *
     * @return Type of Decoder
     * @since 0.28.4
     */
    public func newDecoder():Decoder{
        let decoder = BIG5Decoder()
        return decoder
    }
}

/*
 * The class is BIG5Encoder inherited from Encoder
 * @author freeonsky
 * @since 0.28.4
 */
class BIG5Encoder <: Encoder {

    /**
     * Encodes a string into a byte array
     *
     * @param str of String
     *
     * @return Type of Array<UInt8>
     * @since 0.28.4
     */
    public func encode(str:String): Array<UInt8>{
        let ref = Array<UInt8>()
        // TODO
        return ref
    }
}

/*
 * gb18030 Character set decoder
 * gb18030 The single byte part is the same as ASCII
 *         The double byte part is ordinary Chinese characters
 *         The four byte part is mapped with Unicode through a table
 * 
 * @author freeonsky
 * @since 0.28.4
 */
class BIG5Decoder <: Decoder{
    // Replace character when decoding error
    let replacement = '\u{FFFD}' 
    let table = Big5DecodeMapping

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
        // Index being processed by SRC
        var srcIndex = srcOffset   
        // Dest index being processed
        var destIndex = destUnusedOffset
        while(srcIndex <= srcLimit){
            var u0 = src[srcIndex];
            // Single byte
            if(u0 <= 0x7F){
                var c = chr(UInt32(u0))
                dest[destIndex] = c
                destIndex += 1
                srcIndex += 1     
                continue           
            }else if(u0 >= 0x81 && u0 <= 0xFE){
                if(srcIndex + 1 > srcLimit){
                    // If only half of the double bytes are in SRC, return and wait for the subsequent data to enter SRC for reprocessing
                    return (srcIndex, destIndex)                    
                }
                
                var u1 = src[srcIndex+1]
                var pointer:Int64 = 0
                if(u1 >= 0x40 && u1 < 0x7F){
                    u1 -= 0x40
                }else if(0xa1 <= u1 && u1 < 0xff){
                    u1 -= 0x62
                }else {
                    // Replace with fffd after error
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
                    // Replace with fffd after error
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
