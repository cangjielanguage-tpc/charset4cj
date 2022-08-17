/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * Single byte character set encoder
 */

package charset.singlebyte

from std import collection.*
import charset.encoding.*

/**
 * Single byte character set encoder
 * @author freeonsky
 * @since 0.28.4
 */
class SingleByteEncoder <: Encoder {
    // Todo currently uses 0x1a uniformly, and each single byte character set has a different replacement
    var replacement:UInt8 = 0x1a
    var encodeMapping:Map<UInt32, UInt32>
    var decodeMapping:Array<UInt32> = []

    init(charset: SingleByteCharset){
        var name = charset.charsetName()
        encodeMapping = charset.encodeDic[name]
        decodeMapping = charset.decodeDic[name]
    }

    /**
     * Encodes a string into a byte array
     *
     * @param str of String
     *
     * @return Type of Array<UInt8>
     * @since 0.28.4
     */
    public func encode(str:String): Array<UInt8>{
        var buf:Array<Char> = str.toCharArray()
        let ref = Array<UInt8>(buf.size(), {i => 0})
        var i = 0
        for(character in buf){
            if(UInt32(character) <= 0x7F){
                ref[i] = UInt8(UInt32(character))
            }else{
                var index = indexPointer(encodeMapping, decodeMapping, UInt32(character))
                if(index < 0){
                    ref[i] = replacement
                }else{
                    ref[i] = UInt8(index) + 0x80
                }
            }
            i += 1
        }
        return ref
    }
}

