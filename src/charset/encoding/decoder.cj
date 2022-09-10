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
        var res = decode(src, dest)
        var s = String(dest[0..res[1]])
        return s    
    }

    /*
     * Decode byte array src into character array dest
     *
     * @param src input byte array
     * @param dest output Char array
     *
     * @return (Int64, Int64), return (srcIndex, destIndex)
     *          srcIndex: Next unprocessed src subscript
     *          destIndex: Next unhandled dest subscript
     * @since 0.28.4
     */
    func decode(src:Array<UInt8>, dest:Array<Char>): (Int64, Int64)
}