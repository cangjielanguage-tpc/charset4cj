// 3rd_party_lib:charset4cj/build/charset
// 3rd_party_lib_ohos:charset4cj/build/aarch64-linux-ohos/charset

import std.unittest.*
import std.unittest.testmacro.*
import charset4cj.charset.encoding.*
import charset4cj.charset.*
import std.collection.*

@Test
public class TestCharsets{
    /*
        public static func forName(name:String):Option<Charset>
    */
    public var allCharset=Array<Array<String>>([Array<String>(["unicode-1-1-utf-8","unicode11utf8","unicode20utf8","utf-8","utf8","x-unicode20utf8"]),
        Array<String>(["unicodefffe","utf-16be"]),
        Array<String>(["csunicode","iso-10646-ucs-2","ucs-2","unicode","unicodefeff","utf-16","utf-16le"]),
        Array<String>(["utf-32be","UTF-32BE"]),
        Array<String>(["utf-32le","UTF-32LE"]),
        Array<String>(["gb18030"]),
        Array<String>(["chinese","csgb2312","csiso58gb231280","gb2312","gb_2312","gb_2312-80","gbk","iso-ir-58","x-gbk"]),
        Array<String>(["cseuckr","csksc56011987","euc-kr","iso-ir-149","korean","ks_c_5601-1987","ks_c_5601-1989","ksc5601","ksc_5601","windows-949"]),
        Array<String>(["cseucpkdfmtjapanese","euc-jp","x-euc-jp"]),
        Array<String>(["csshiftjis","ms932","ms_kanji","shift-jis","shift_jis","sjis","windows-31j","x-sjis"]),
        Array<String>(["csiso2022jp","iso-2022-jp"]),
        Array<String>(["big5-hkscs"]),
        Array<String>(["866","cp866","csibm866","ibm866"]),
        Array<String>(["csisolatin2","iso-8859-2","iso-ir-101","iso8859-2","iso88592","iso_8859-2","iso_8859-2,1987","l2","latin2"]),
        Array<String>(["csisolatin3","iso-8859-3","iso-ir-109","iso8859-3","iso88593","iso_8859-3","iso_8859-3,1988","l3","latin3"]),
        Array<String>(["csisolatin4","iso-8859-4","iso-ir-110","iso8859-4","iso88594","iso_8859-4","iso_8859-4,1988","l4","latin4"]),
        Array<String>(["csisolatincyrillic","cyrillic","iso-8859-5","iso-ir-144","iso8859-5","iso88595","iso_8859-5","iso_8859-5,1988"]),
        Array<String>(["arabic","asmo-708","csiso88596e","csiso88596i","csisolatinarabic","ecma-114","iso-8859-6","iso-8859-6-e","iso-8859-6-i","iso-ir-127","iso8859-6","iso88596","iso_8859-6","iso_8859-6,1987"]),
        Array<String>(["csisolatingreek","ecma-118","elot_928","greek","greek8","iso-8859-7","iso-ir-126","iso8859-7","iso88597","iso_8859-7","iso_8859-7,1987","sun_eu_greek"]),
        Array<String>(["csiso88598e","csisolatinhebrew","hebrew","iso-8859-8","iso-8859-8-e","iso-ir-138","iso8859-8","iso88598","iso_8859-8","iso_8859-8,1988","visual"]),
        Array<String>(["csisolatin6","iso-8859-10","iso-ir-157","iso8859-10","iso885910","l6","latin6"]),
        Array<String>(["iso-8859-13","iso8859-13","iso885913"]),
        Array<String>(["iso-8859-14","iso8859-14","iso885914"]),
        Array<String>(["csisolatin9","iso-8859-15","iso8859-15","iso885915","iso_8859-15","l9"]),
        Array<String>([	"iso-8859-16"]),
        Array<String>(["cskoi8r","koi","koi8","koi8-r","koi8_r"]),
        Array<String>(["koi8-ru","koi8-u"]),
        Array<String>(["csmacintosh","mac","macintosh","x-mac-roman"]),
        Array<String>(["dos-874","iso-8859-11","iso8859-11","iso885911","tis-620","windows-874"]),
        Array<String>(["cp1250","windows-1250","x-cp1250"]),
        Array<String>(["cp1251","windows-1251","x-cp1251"]),
        Array<String>(["ansi_x3.4-1968","ascii","cp1252","cp819","csisolatin1","ibm819","iso-8859-1","iso-ir-100","iso8859-1","iso88591","iso_8859-1","iso_8859-1,1987","l1","latin1","us-ascii","windows-1252","x-cp1252"]),
        Array<String>(["cp1253","windows-1253","x-cp1253"]),
        Array<String>(["cp1254","csisolatin5","iso-8859-9","iso-ir-148","iso8859-9","iso88599","iso_8859-9","iso_8859-9,1989","l5","latin5","windows-1254","x-cp1254"]),
        Array<String>(["cp1255","windows-1255","x-cp1255"]),
        Array<String>(["cp1256","windows-1256","x-cp1256"]),
        Array<String>(["cp1257","windows-1257","x-cp1257"]),
        Array<String>(["cp1258","windows-1258","x-cp1258"]),
        Array<String>(["x-mac-cyrillic","x-mac-ukrainian"])
     ])
    //name是已有字符集
    @TestCase
    func testForName01(): Unit {
        var re=false
        for(V in allCharset){
            for (charsetStr in V){
                re=false
                re=Charsets.forName(charsetStr).getOrThrow().nameEquals(charsetStr)
                @Assert(re,true)
            }
        }
    }
    //name非已有字符集
    @TestCase
    func testForName02(): Unit {
        var flag=0
        try{
            Charsets.forName("").getOrThrow().nameEquals("charsetStr")
        }catch(e:NoneValueException){
            flag=1
        }
        @Assert(flag,1)
    }
}