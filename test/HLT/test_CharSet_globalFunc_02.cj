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
        public operator func ==(rhs: Charset): Bool
        public operator func !=(rhs: Charset): Bool
        测试场景:与默认字符集结果一致
    */
    public var allCharset: Array<Charset>=[ Charsets.UTF8,Charsets.UTF16BE,Charsets.UTF16LE,Charsets.UTF32BE,Charsets.UTF32LE,Charsets.GB18030,Charsets.GBK,Charsets.EUCKR,Charsets.EUCJP,Charsets.SHIFT_JIS,Charsets.ISO_2022_JP,Charsets.BIG5_HKSCS,Charsets.IBM866,
                                                Charsets.ISO_8859_2,Charsets.ISO_8859_3,Charsets.ISO_8859_4,Charsets.ISO_8859_5,Charsets.ISO_8859_6,Charsets.ISO_8859_7,Charsets.ISO_8859_8,Charsets.ISO_8859_10,Charsets.ISO_8859_13,Charsets.ISO_8859_14,
                                                Charsets.ISO_8859_15,Charsets.ISO_8859_16,Charsets.KOI8_R,Charsets.KOI8_U,Charsets.MACINTOSH,Charsets.WINDOWS_874,Charsets.WINDOWS_1250,Charsets.WINDOWS_1251,Charsets.WINDOWS_1252,Charsets.WINDOWS_1253,
                                                Charsets.WINDOWS_1254,Charsets.WINDOWS_1255,Charsets.WINDOWS_1256,Charsets.WINDOWS_1257,Charsets.WINDOWS_1258,Charsets.X_MAC_CYRILLIC  ]

    @TestCase
    func testGlobalFunc0201(): Unit {
        for (index in 0..allCharset.size){
            if(index==0){
                @Assert(allCharset[0]==allCharset[index],true)
            }else{
                @Assert(allCharset[0]==allCharset[index],false)
            }
        }
    }
    @TestCase
    func testGlobalFunc0202(): Unit {
        for (index in 0..allCharset.size){
            if(index==0){
                @Assert(allCharset[0]!=allCharset[index],false)
            }else{
                @Assert(allCharset[0]!=allCharset[index],true)
            }
        }
    }
}