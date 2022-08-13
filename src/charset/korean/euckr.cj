/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * This file is about charset korean
 */

package charset.korean

import charset.encoding.*

/**
 * EUC-KR korean encoding
 * @author freeonsky
 * @since 0.28.4
 */
public class EUCKRCharset <: Charset{

    /**
     * The Function is init constructor
     *
     * @since 0.28.4
     */
    public init(){
        // super("EUC-KR", ["cseuckr",  "csksc56011987",  "euc-kr",  "iso-ir-149",  "korean",  "ks_c_5601-1987",  "ks_c_5601-1989",  "ksc5601",  "ksc_5601",  "windows-949"])
        this.name = "EUC-KR"
        this.labels = ["cseuckr",  "csksc56011987",  "euc-kr",  "iso-ir-149",  "korean",  "ks_c_5601-1987",  "ks_c_5601-1989",  "ksc5601",  "ksc_5601",  "windows-949"]
    }

    /**
     * The Function is newEncoder
     *
     * @return Type of Encoder
     * @since 0.28.4
     */
    public func newEncoder():Encoder{
        let encoder = EUCKREncoder()
        return encoder
    }

    /**
     * The Function is newDecoder
     *
     * @return Type of Decoder
     * @since 0.28.4
     */
    public func newDecoder():Decoder{
        let decoder = EUCKRDecoder()
        return decoder
    }
}

/*
 * The class is EUCKREncoder inherited from Encoder
 * @author freeonsky
 * @since 0.28.4
 */
class EUCKREncoder <: Encoder {

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
 */

/*
 * The class is EUCKRDecoder inherited from Decoder
 * @author freeonsky
 * @since 0.28.4
 */
class EUCKRDecoder <: Decoder{
    // Replace character when decoding error
    let replacement = '\u{FFFD}' 
    let table = EUC_KRDecodeMapping

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
                if(u0 < 0xc7){
                    var pointer = 178 * Int64(u0 - 0x81)
                    if(u1 >= 0x41 && u1 < 0x5b){
                        pointer += Int64(u1) - 0x41
                    }else if(0x61 <= u1 && u1 < 0x7b){
                        pointer += Int64(u1) - (0x61 - 26)
                    }else if(0x81 <= u1 && u1 < 0xff){
                        pointer += Int64(u1) - (0x81 - 2*26)
                    }else{
                        // error
                        srcIndex += 2
                        destIndex += 1
                        dest[destIndex] = replacement
                        continue                              
                    }

                }else if(0xa1 <= u1 && u1 < 0xff){
                    pointer = 178*(0xc7-0x81) + Int64(u0-0xc7)*94 + Int64(u1-0xa1)
                }else{
                    // Replace with fffd after error
                    dest[destIndex] = replacement     
                    destIndex += 1
                    srcIndex += 1
                    continue                                       
                }  
                print("pointer:${pointer}\n")
                dest[destIndex] = Char(table[pointer])
                srcIndex += 2
                destIndex += 1
                continue                
            }
        }
        return (srcIndex, destIndex)
    }    
}
