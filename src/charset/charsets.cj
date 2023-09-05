/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * Constant definitions for all the supported Charsets.
 */

package charset

import charset.unicode.*
import charset.singlebyte.*
import charset.simplechinese.*
import charset.traditionchinese.*
import charset.korean.*
import charset.japanese.*

import charset.encoding.*

/**
 * Constant definitions for all the supported Charsets. 
 * @author freeonsky
 * @since 0.28.4
 */
public class Charsets {

    // UTF-8
    public static let UTF8:Charset = newUTF8Charset()
    // utf-16 be
    public static let UTF16BE:Charset = newUTF16Charset(true)
    // utf16 le
    public static let UTF16LE:Charset = newUTF16Charset(false)
    // utf32 be
    public static let UTF32BE:Charset = newUTF32Charset(true)
    // utf32 le
    public static let UTF32LE:Charset = newUTF32Charset(false)
    // gb18030
    public static let GB18030:Charset = newGB18030Charset(false)
    // gbk
    public static let GBK:Charset = newGB18030Charset(true)
    // EUC-KR
    public static let EUCKR:Charset = newEUCKRCharset()
    // EUC-JP
    public static let EUCJP:Charset = newEUCJPCharset()
    // ShiftJIS
    public static let SHIFT_JIS:Charset = newShiftJISCharset()
    // ISO-2022-JP
    public static let ISO_2022_JP:Charset = newISO2022JPCharset()
    // Big5
    public static let BIG5:Charset = newBIG5Charset(false)
    // Big5-hkscs
    public static let BIG5_HKSCS:Charset = newBIG5Charset(true)    
    // IBM866
    public static let IBM866:Charset = newSingleByteCharset("IBM866")
    // ISO-8859-2
    public static let ISO_8859_2:Charset = newSingleByteCharset("ISO-8859-2")
    // ISO-8859-3
    public static let ISO_8859_3:Charset = newSingleByteCharset("ISO-8859-3")
    // ISO-8859-4
    public static let ISO_8859_4:Charset = newSingleByteCharset("ISO-8859-4")
    // ISO-8859-5
    public static let ISO_8859_5:Charset = newSingleByteCharset("ISO-8859-5")
    // ISO-8859-6
    public static let ISO_8859_6:Charset = newSingleByteCharset("ISO-8859-6")
    // ISO-8859-7
    public static let ISO_8859_7:Charset = newSingleByteCharset("ISO-8859-7")
    // ISO-8859-8
    public static let ISO_8859_8:Charset = newSingleByteCharset("ISO-8859-8")
    // ISO-8859-10
    public static let ISO_8859_10:Charset = newSingleByteCharset("ISO-8859-10")
    // ISO-8859-13
    public static let ISO_8859_13:Charset = newSingleByteCharset("ISO-8859-13")
    // ISO-8859-14
    public static let ISO_8859_14:Charset = newSingleByteCharset("ISO-8859-14")
    // ISO-8859-15
    public static let ISO_8859_15:Charset = newSingleByteCharset("ISO-8859-15")
    // ISO-8859-16
    public static let ISO_8859_16:Charset = newSingleByteCharset("ISO-8859-16")
    // KOI8-R
    public static let KOI8_R:Charset = newSingleByteCharset("KOI8-R")
    // KOI8-U
    public static let KOI8_U:Charset = newSingleByteCharset("KOI8-U")
    // macintosh
    public static let MACINTOSH:Charset = newSingleByteCharset("macintosh")
    // windows-874
    public static let WINDOWS_874:Charset = newSingleByteCharset("windows-874")
    // windows-1250
    public static let WINDOWS_1250:Charset = newSingleByteCharset("windows-1250")
    // windows-1251
    public static let WINDOWS_1251:Charset = newSingleByteCharset("windows-1251")
    // windows-1252
    public static let WINDOWS_1252:Charset = newSingleByteCharset("windows-1252")
    // windows-1253
    public static let WINDOWS_1253:Charset = newSingleByteCharset("windows-1253")
    // windows-1254
    public static let WINDOWS_1254:Charset = newSingleByteCharset("windows-1254")
    // windows-1255
    public static let WINDOWS_1255:Charset = newSingleByteCharset("windows-1255")
    // windows-1256
    public static let WINDOWS_1256:Charset = newSingleByteCharset("windows-1256")
    // windows-1257
    public static let WINDOWS_1257:Charset = newSingleByteCharset("windows-1257")
    // windows-1258
    public static let WINDOWS_1258:Charset = newSingleByteCharset("windows-1258")
    // x-mac-cyrillic
    public static let X_MAC_CYRILLIC:Charset = newSingleByteCharset("x-mac-cyrillic")    

    private static let cache:Array<Charset> = [
        UTF8,
        UTF16BE,
        UTF16LE,
        UTF32BE,
        UTF32LE,
        GB18030,
        GBK,
        EUCKR,
        BIG5,
        BIG5_HKSCS,
        EUCJP,
        SHIFT_JIS,
        ISO_2022_JP,
        IBM866,
        ISO_8859_2,
        ISO_8859_3,
        ISO_8859_4,
        ISO_8859_5,
        ISO_8859_6,
        ISO_8859_7,
        ISO_8859_8,
        ISO_8859_10,
        ISO_8859_13,
        ISO_8859_14,
        ISO_8859_15,
        ISO_8859_16,
        KOI8_R,
        KOI8_U,
        MACINTOSH,
        WINDOWS_874,
        WINDOWS_1250,
        WINDOWS_1251,
        WINDOWS_1252,
        WINDOWS_1253,
        WINDOWS_1254,
        WINDOWS_1255,
        WINDOWS_1256,
        WINDOWS_1257,
        WINDOWS_1258,
        X_MAC_CYRILLIC
    ]

    /**
     * Gets the character encoding type based on the character set name
     *
     * @param name of String
     *
     * @return Type of Option<Charset>
     * @since 0.28.4
     */
    public static func forName(n:String):Option<Charset>{
        for(charset in cache){
            if(charset.nameEquals(n)){
                return Option.Some(charset)
            }
        }
        return Option<Charset>.None
    }
}
