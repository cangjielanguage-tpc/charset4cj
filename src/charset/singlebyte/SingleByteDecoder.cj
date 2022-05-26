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
    let decodeDic = HashMap<String, Array<UInt32>>([
        ("IBM866", ibm866DecodeMapping),
        ("ISO-8859-2", iso_8859_2DecodeMapping),
        ("ISO-8859-3", iso_8859_3DecodeMapping),
        ("ISO-8859-4", iso_8859_4DecodeMapping),
        ("ISO-8859-5", iso_8859_5DecodeMapping),
        ("ISO-8859-6", iso_8859_6DecodeMapping),
        ("ISO-8859-7", iso_8859_7DecodeMapping),
        ("ISO-8859-8", iso_8859_8DecodeMapping),
        // "ISO-8859-8-I", iso_8859_8_iDecodeMapping),
        ("ISO-8859-10", iso_8859_10DecodeMapping),
        ("ISO-8859-13", iso_8859_13DecodeMapping),
        ("ISO-8859-14", iso_8859_14DecodeMapping),
        ("ISO-8859-15", iso_8859_15DecodeMapping),
        ("ISO-8859-16", iso_8859_16DecodeMapping),
        ("KOI8-R", koi8_rDecodeMapping),
        ("KOI8-U", koi8_uDecodeMapping),
        ("macintosh", macintoshDecodeMapping),
        ("windows-874", windows_874DecodeMapping),
        ("windows-1250", windows_1250DecodeMapping),
        ("windows-1251", windows_1251DecodeMapping),
        ("windows-1252", windows_1252DecodeMapping),
        ("windows-1253", windows_1253DecodeMapping),
        ("windows-1254", windows_1254DecodeMapping),
        ("windows-1255", windows_1255DecodeMapping),
        ("windows-1256", windows_1256DecodeMapping),
        ("windows-1257", windows_1257DecodeMapping),
        ("windows-1258", windows_1258DecodeMapping),
        ("x-mac-cyrillic", x_mac_cyrillicDecodeMapping)    
    ]) 

    init(charset: SingleByteCharset){
        var name = charset.charsetName()
        decodeMapping = decodeDic[name]
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
     * @return Type of Int64 * Int64: (srcIndex, destIndex)
     *         srcIndex Next unprocessed SRC subscript
     *         destIndex Next unhandled dest subscript
     * @since 0.28.4
     */
    public func decode(src:Array<UInt8>, srcOffset:Int64, srcLimit:Int64, 
            dest:Array<Char>, destUnusedOffset:Int64): Int64 * Int64 {
        // src processing index
        var srcIndex = srcOffset   
        // dest processing index
        var destIndex = destUnusedOffset
        while(true){
            if(srcIndex > srcLimit){
                srcIndex -= 1
                destIndex -= 1
                break
            }

            var byte = src[srcIndex]
            if(byte <= 0x7F){
                dest[destIndex] = chr(UInt32(byte))
                destIndex += 1
            }else{
                var pointer = Int64(byte - 0x80)
                var value = decodeMapping[pointer]
                if(value == 0xFFFF){
                    dest[destIndex] = replacement    
                }else{
                    dest[destIndex] = chr(value)
                }
                destIndex += 1
            }
            srcIndex += 1  
        }
        return (srcIndex, destIndex)                
    }
}