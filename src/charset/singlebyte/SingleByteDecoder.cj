package charset.singlebyte

from std import collection.*
import charset.encoding.*

/**
* 单字节字符集解码器
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
    * 将字节数组src解码成字符数组 dest
    * 字节数组src的可用范围 [srcOffset, srcLimit]
    *   srcOffset 表示当前没有处理的 src 下标
    * 字符数组dest的可用范围 [destUnusedOffset, dest.size()) ,不包含dest.size();
    *   destUnusedOffset 表示当前没有使用的 dest 下标
    * 返回值 (srcIndex, destIndex)； 
    *   srcIndex 下一个没有处理的src下标
    *   destIndex 下一个没有处理的dest下标
    */
    public func decode(src:Array<UInt8>, srcOffset:Int64, srcLimit:Int64, 
            dest:Array<Char>, destUnusedOffset:Int64): Int64 * Int64 {
        // src正在处理的index
        var srcIndex = srcOffset   
        // dest 正在处理的 index
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