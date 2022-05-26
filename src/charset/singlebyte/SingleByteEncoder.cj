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
    var encodeMapping:HashMap<UInt32, UInt8>
    let encodeDic = HashMap<String, HashMap<UInt32, UInt8>>([
        ("IBM866", ibm866EncodeMapping),
        ("ISO-8859-2", iso_8859_2EncodeMapping),
        ("ISO-8859-3", iso_8859_3EncodeMapping),
        ("ISO-8859-4", iso_8859_4EncodeMapping),
        ("ISO-8859-5", iso_8859_5EncodeMapping),
        ("ISO-8859-6", iso_8859_6EncodeMapping),
        ("ISO-8859-7", iso_8859_7EncodeMapping),
        ("ISO-8859-8", iso_8859_8EncodeMapping),
        // "ISO-8859-8-I", iso_8859_8_iEncodeMapping),
        ("ISO-8859-10", iso_8859_10EncodeMapping),
        ("ISO-8859-13", iso_8859_13EncodeMapping),
        ("ISO-8859-14", iso_8859_14EncodeMapping),
        ("ISO-8859-15", iso_8859_15EncodeMapping),
        ("ISO-8859-16", iso_8859_16EncodeMapping),
        ("KOI8-R", koi8_rEncodeMapping),
        ("KOI8-U", koi8_uEncodeMapping),
        ("macintosh", macintoshEncodeMapping),
        ("windows-874", windows_874EncodeMapping),
        ("windows-1250", windows_1250EncodeMapping),
        ("windows-1251", windows_1251EncodeMapping),
        ("windows-1252", windows_1252EncodeMapping),
        ("windows-1253", windows_1253EncodeMapping),
        ("windows-1254", windows_1254EncodeMapping),
        ("windows-1255", windows_1255EncodeMapping),
        ("windows-1256", windows_1256EncodeMapping),
        ("windows-1257", windows_1257EncodeMapping),
        ("windows-1258", windows_1258EncodeMapping),
        ("x-mac-cyrillic", x_mac_cyrillicEncodeMapping)    
    ])
    init(charset: SingleByteCharset){
        var name = charset.charsetName()
        encodeMapping = encodeDic[name]
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
            ref[i] = encodeMapping.get(ord(character)) ?? replacement
            i += 1
        }
        return ref
    }
}

