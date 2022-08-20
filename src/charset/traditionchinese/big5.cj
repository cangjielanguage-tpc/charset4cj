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
        var table = Big5EncodeMapping
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
            }else{
                var index = indexPointer(Big5EncodeMapping, Big5DecodeMapping, codePoint)
                if(index >= 0){
                    var pointer = UInt32(index)
                    let lead = pointer / 157 + 0x81
                    let trail = UInt8(pointer % 157)
                    let offset:UInt8 = if(trail < 0x3F) {0x40} else {0x62}
                    ref[position] = UInt8(lead)
                    ref[position+1] = UInt8(trail + offset)
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
     * @param dest Range: [destStart, dest.size()) not include dest.size()
     * @param destStart Indicates a dest subscript that is not currently in use
     *
     * @return Type of (Int64, Int64): (srcIndex, destIndex)
     *         srcIndex Next unprocessed SRC subscript
     *         destIndex Next unhandled dest subscript
     * @since 0.28.4
     */
    public func decode(src:Array<UInt8>, srcOffset:Int64, srcLimit:Int64, 
            dest:Array<Char>, destStart:Int64): (Int64, Int64) {
        // Index being processed by SRC
        var srcIndex = srcOffset   
        // Dest index being processed
        var destIndex = destStart
        while(srcIndex <= srcLimit){
            var u0 = src[srcIndex];
            // Single byte
            if(u0 <= 0x7F){
                var c = Char(UInt32(u0))
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
                        dest[destIndex] = Char(table[pointer])
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
