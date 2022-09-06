/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * This file is about byte array decoding
 */
package charset.encoding

/**
 * The interface is interface Decoder
 * @author freeonsky
 * @since 0.28.4
 */
public interface Decoder{

    /*
     * Decodes a byte array into a string
     *
     * @param src Byte array
     *
     * @return Type of String
     * @since 0.28.4
     */
    func decode(src:Array<UInt8>):String{
        var dest:Array<Char> = Array<Char>(src.size, item: '\0')
        var res = decode(src, 0, src.size-1, dest, 0)
        var s = String(dest[0..res[1]])
        return s    
    }

    /*
     * Decode byte array src into character array dest
     *
     * @param src Range: [srcOffset, srcLimit]
     * @param srcOffset Range
     * @param srcLimit Range
     * @param dest Range: [destStart, dest.size), not include dest.size
     * @param destStart 
     *
     * @return (Int64, Int64), return (srcIndex, destIndex)
     *          srcIndex: Next unprocessed src subscript
     *          destIndex: Next unhandled dest subscript
     * @since 0.28.4
     */
    func decode(src:Array<UInt8>, srcOffset:Int64, srcLimit:Int64, 
            dest:Array<Char>, destStart:Int64): (Int64, Int64)
}