// 3rd_party_lib:charset4cj/build/charset
// 3rd_party_lib_ohos:charset4cj/build/aarch64-linux-ohos/charset

import std.unittest.*
import std.unittest.testmacro.*
import charset4cj.charset.encoding.*
import charset4cj.charset.*
import std.collection.*

@Test
public class TestCharSets{
    /*
        public func nameEquals(name:String):Bool
    */
    public var allCharset: Array<(Charset,Array<String>)>=[(Charsets.UTF8,["unicode-1-1-utf-8","unicode11utf8","unicode20utf8","utf-8","utf8","x-unicode20utf8"]),
        (Charsets.UTF16BE,["unicodefffe","utf-16be"]),
        (Charsets.UTF16LE,["csunicode","iso-10646-ucs-2","ucs-2","unicode","unicodefeff","utf-16","utf-16le"]),
        (Charsets.UTF32BE,["utf-32be","UTF-32BE"]),
        (Charsets.UTF32LE,["utf-32le","UTF-32LE"]),
        (Charsets.GB18030,["gb18030"]),
        (Charsets.GBK,["chinese","csgb2312","csiso58gb231280","gb2312","gb_2312","gb_2312-80","gbk","iso-ir-58","x-gbk"]),
        (Charsets.EUCKR,["cseuckr","csksc56011987","euc-kr","iso-ir-149","korean","ks_c_5601-1987","ks_c_5601-1989","ksc5601","ksc_5601","windows-949"]),
        (Charsets.EUCJP,["cseucpkdfmtjapanese","euc-jp","x-euc-jp"]),
        (Charsets.SHIFT_JIS,["csshiftjis","ms932","ms_kanji","shift-jis","shift_jis","sjis","windows-31j","x-sjis"]),
        (Charsets.ISO_2022_JP,["csiso2022jp","iso-2022-jp"]),
        (Charsets.BIG5_HKSCS,["big5-hkscs"]),
        (Charsets.IBM866,["866","cp866","csibm866","ibm866"]),
        (Charsets.ISO_8859_2,["csisolatin2","iso-8859-2","iso-ir-101","iso8859-2","iso88592","iso_8859-2","iso_8859-2,1987","l2","latin2"]),
        (Charsets.ISO_8859_3,["csisolatin3","iso-8859-3","iso-ir-109","iso8859-3","iso88593","iso_8859-3","iso_8859-3,1988","l3","latin3"]),
        (Charsets.ISO_8859_4,["csisolatin4","iso-8859-4","iso-ir-110","iso8859-4","iso88594","iso_8859-4","iso_8859-4,1988","l4","latin4"]),
        (Charsets.ISO_8859_5,["csisolatincyrillic","cyrillic","iso-8859-5","iso-ir-144","iso8859-5","iso88595","iso_8859-5","iso_8859-5,1988"]),
        (Charsets.ISO_8859_6,["arabic","asmo-708","csiso88596e","csiso88596i","csisolatinarabic","ecma-114","iso-8859-6","iso-8859-6-e","iso-8859-6-i","iso-ir-127","iso8859-6","iso88596","iso_8859-6","iso_8859-6,1987"]),
        (Charsets.ISO_8859_7,["csisolatingreek","ecma-118","elot_928","greek","greek8","iso-8859-7","iso-ir-126","iso8859-7","iso88597","iso_8859-7","iso_8859-7,1987","sun_eu_greek"]),
        (Charsets.ISO_8859_8,["csiso88598e","csisolatinhebrew","hebrew","iso-8859-8","iso-8859-8-e","iso-ir-138","iso8859-8","iso88598","iso_8859-8","iso_8859-8,1988","visual"]),
        (Charsets.ISO_8859_10,["csisolatin6","iso-8859-10","iso-ir-157","iso8859-10","iso885910","l6","latin6"]),
        (Charsets.ISO_8859_13,["iso-8859-13","iso8859-13","iso885913"]),
        (Charsets.ISO_8859_14,["iso-8859-14","iso8859-14","iso885914"]),
        (Charsets.ISO_8859_15,["csisolatin9","iso-8859-15","iso8859-15","iso885915","iso_8859-15","l9"]),
        (Charsets.ISO_8859_16,[	"iso-8859-16"]),
        (Charsets.KOI8_R,["cskoi8r","koi","koi8","koi8-r","koi8_r"]),
        (Charsets.KOI8_U,["koi8-ru","koi8-u"]),
        (Charsets.MACINTOSH,["csmacintosh","mac","macintosh","x-mac-roman"]),
        (Charsets.WINDOWS_874,["dos-874","iso-8859-11","iso8859-11","iso885911","tis-620","windows-874"]),
        (Charsets.WINDOWS_1250,["cp1250","windows-1250","x-cp1250"]),
        (Charsets.WINDOWS_1251,["cp1251","windows-1251","x-cp1251"]),
        (Charsets.WINDOWS_1252,["ansi_x3.4-1968","ascii","cp1252","cp819","csisolatin1","ibm819","iso-8859-1","iso-ir-100","iso8859-1","iso88591","iso_8859-1","iso_8859-1,1987","l1","latin1","us-ascii","windows-1252","x-cp1252"]),
        (Charsets.WINDOWS_1253,["cp1253","windows-1253","x-cp1253"]),
        (Charsets.WINDOWS_1254,["cp1254","csisolatin5","iso-8859-9","iso-ir-148","iso8859-9","iso88599","iso_8859-9","iso_8859-9,1989","l5","latin5","windows-1254","x-cp1254"]),
        (Charsets.WINDOWS_1255,["cp1255","windows-1255","x-cp1255"]),
        (Charsets.WINDOWS_1256,["cp1256","windows-1256","x-cp1256"]),
        (Charsets.WINDOWS_1257,["cp1257","windows-1257","x-cp1257"]),
        (Charsets.WINDOWS_1258,["cp1258","windows-1258","x-cp1258"]),
        (Charsets.X_MAC_CYRILLIC,["x-mac-cyrillic","x-mac-ukrainian"])
     ]
    //name与字符集名称相同
    var re=false
    @TestCase
    func testNameEquals01():Unit {
        for ((K,V) in allCharset){
            for(str in V){
                re=false
                re=K.nameEquals(str)
                if(re==false){
                    println(str)
                }
                @Assert(re,true)
            }
        }
    }
    //name与字符集名称不同
    @TestCase
    func testNameEquals02():Unit {
        for (K in allCharset){
            re=true
            re=K[0].nameEquals("error")
            @Assert(re,false)
        }
    }
}