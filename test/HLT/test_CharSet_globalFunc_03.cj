// 3rd_party_lib:charset4cj/build/charset
// 3rd_party_lib_ohos:charset4cj/build/aarch64-linux-ohos/charset

import std.unittest.*
import std.unittest.testmacro.*
import charset4cj.charset.*
import charset4cj.charset.encoding.*
import charset4cj.charset.korean.*
import charset4cj.charset.japanese.*
import charset4cj.charset.traditionchinese.*
import charset4cj.charset.unicode.*
import charset4cj.charset.simplechinese.*
import charset4cj.charset.singlebyte.*
import std.collection.*

@Test
public class TestCharset{
    /*
        public operator func ==(rhs: String): Bool
        public operator func !=(rhs: String): Bool
        测试场景:与默认字符集结果一致
    */
    public var allCharset: Array<Charset>=[ Charsets.UTF8,Charsets.UTF16BE,Charsets.UTF16LE,Charsets.UTF32BE,Charsets.UTF32LE,Charsets.GB18030,Charsets.GBK,Charsets.EUCKR,Charsets.EUCJP,Charsets.SHIFT_JIS,Charsets.ISO_2022_JP,Charsets.BIG5_HKSCS,Charsets.BIG5,Charsets.IBM866,
                                                Charsets.ISO_8859_2,Charsets.ISO_8859_3,Charsets.ISO_8859_4,Charsets.ISO_8859_5,Charsets.ISO_8859_6,Charsets.ISO_8859_7,Charsets.ISO_8859_8,Charsets.ISO_8859_10,Charsets.ISO_8859_13,Charsets.ISO_8859_14,
                                                Charsets.ISO_8859_15,Charsets.ISO_8859_16,Charsets.KOI8_R,Charsets.KOI8_U,Charsets.MACINTOSH,Charsets.WINDOWS_874,Charsets.WINDOWS_1250,Charsets.WINDOWS_1251,Charsets.WINDOWS_1252,Charsets.WINDOWS_1253,
                                                Charsets.WINDOWS_1254,Charsets.WINDOWS_1255,Charsets.WINDOWS_1256,Charsets.WINDOWS_1257,Charsets.WINDOWS_1258,Charsets.X_MAC_CYRILLIC]
    public var allStr: Array<String>=[ "UTF-8","UTF-16BE","UTF-16LE","UTF-32BE","UTF-32LE","gb18030","gbk","EUC-KR","EUC-JP","Shift_JIS","ISO-2022-JP","big5-hkscs","Big5","IBM866",
                                                "ISO-8859-2","ISO-8859-3","ISO-8859-4","ISO-8859-5","ISO-8859-6","ISO-8859-7","ISO-8859-8","ISO-8859-10","ISO-8859-13","ISO-8859-14",
                                                "ISO-8859-15","ISO-8859-16","KOI8-R","KOI8-U","macintosh","windows-874","windows-1250","windows-1251","windows-1252","windows-1253",
                                                "windows-1254","windows-1255","windows-1256","windows-1257","windows-1258","x-mac-cyrillic"  ]

    @TestCase
    func testGlobalFunc0301(): Unit {
        for (index in 0..allCharset.size){
            @Assert(allCharset[index]==allStr[index],true)
        }
    }
    @TestCase
    func testGlobalFunc0302(): Unit {
        for (Key in allCharset){
             @Assert((Key=="other"),false)
        }
    }
}
