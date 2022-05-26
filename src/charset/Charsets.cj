/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * Constant definitions for all the supported Charsets.
 */

package charset

import charset.unicode.UTF8Charset
import charset.unicode.UTF16Charset
import charset.unicode.UTF32Charset
import charset.singlebyte.*
import charset.simplechinese.*
import charset.traditionchinese.*
import charset.korean.*

import charset.encoding.*

/**
 * Constant definitions for all the supported Charsets. 
 * @author freeonsky
 * @since 0.28.4
 */
public class Charsets {

    // UTF-8
    public static let utf8:Charset = UTF8Charset()
    // utf-16 be
    public static let utf16be:Charset = UTF16Charset(true)
    // utf16 
    public static let utf16:Charset = UTF16Charset(false)
    // utf32be
    public static let utf32be:Charset = UTF32Charset(true)
    // utf32
    public static let utf32:Charset = UTF32Charset(false)
    // gb18030
    public static let gb18030:Charset = GB18030Charset()
    // EUC-KR
    public static let euckr:Charset = EUCKRCharset()
    // Big5
    public static let big5:Charset = BIG5Charset()

    // IBM866
    public static let ibm866:Charset = SingleByteCharset("IBM866")
    // ISO-8859-2
    public static let iso_8859_2:Charset = SingleByteCharset("ISO-8859-2")
    // ISO-8859-3
    public static let iso_8859_3:Charset = SingleByteCharset("ISO-8859-3")
    // ISO-8859-4
    public static let iso_8859_4:Charset = SingleByteCharset("ISO-8859-4")
    // ISO-8859-5
    public static let iso_8859_5:Charset = SingleByteCharset("ISO-8859-5")
    // ISO-8859-6
    public static let iso_8859_6:Charset = SingleByteCharset("ISO-8859-6")
    // ISO-8859-7
    public static let iso_8859_7:Charset = SingleByteCharset("ISO-8859-7")
    // ISO-8859-8
    public static let iso_8859_8:Charset = SingleByteCharset("ISO-8859-8")
    // ISO-8859-10
    public static let iso_8859_10:Charset = SingleByteCharset("ISO-8859-10")
    // ISO-8859-13
    public static let iso_8859_13:Charset = SingleByteCharset("ISO-8859-13")
    // ISO-8859-14
    public static let iso_8859_14:Charset = SingleByteCharset("ISO-8859-14")
    // ISO-8859-15
    public static let iso_8859_15:Charset = SingleByteCharset("ISO-8859-15")
    // ISO-8859-16
    public static let iso_8859_16:Charset = SingleByteCharset("ISO-8859-16")
    // KOI8-R
    public static let koi8_r:Charset = SingleByteCharset("KOI8-R")
    // KOI8-U
    public static let koi8_u:Charset = SingleByteCharset("KOI8-U")
    // macintosh
    public static let macintosh:Charset = SingleByteCharset("macintosh")
    // windows-874
    public static let windows_874:Charset = SingleByteCharset("windows-874")
    // windows-1250
    public static let windows_1250:Charset = SingleByteCharset("windows-1250")
    // windows-1251
    public static let windows_1251:Charset = SingleByteCharset("windows-1251")
    // windows-1252
    public static let windows_1252:Charset = SingleByteCharset("windows-1252")
    // windows-1253
    public static let windows_1253:Charset = SingleByteCharset("windows-1253")
    // windows-1254
    public static let windows_1254:Charset = SingleByteCharset("windows-1254")
    // windows-1255
    public static let windows_1255:Charset = SingleByteCharset("windows-1255")
    // windows-1256
    public static let windows_1256:Charset = SingleByteCharset("windows-1256")
    // windows-1257
    public static let windows_1257:Charset = SingleByteCharset("windows-1257")
    // windows-1258
    public static let windows_1258:Charset = SingleByteCharset("windows-1258")
    // x-mac-cyrillic
    public static let x_mac_cyrillic:Charset = SingleByteCharset("x-mac-cyrillic")    

    private static let cache:Array<Charset> = [
        utf8,
        utf16be,
        utf16,
        utf32be,
        utf32,
        gb18030,
        euckr,
        big5,
        ibm866,
        iso_8859_2,
        iso_8859_3,
        iso_8859_4,
        iso_8859_5,
        iso_8859_6,
        iso_8859_7,
        iso_8859_8,
        iso_8859_10,
        iso_8859_13,
        iso_8859_14,
        iso_8859_15,
        iso_8859_16,
        koi8_r,
        koi8_u,
        macintosh,
        windows_874,
        windows_1250,
        windows_1251,
        windows_1252,
        windows_1253,
        windows_1254,
        windows_1255,
        windows_1256,
        windows_1257,
        windows_1258,
        x_mac_cyrillic
    ]

    /**
     * Gets the character encoding type based on the character set name
     *
     * @param name of String
     *
     * @return Type of Option<Charset>
     * @since 0.28.4
     */
    public static func forName(name:String):Option<Charset>{
        for(charset in cache){
            if(charset.nameEquals(name)){
                return Option.Some(charset)
            }
        }
        return Option<Charset>.None
    }
}