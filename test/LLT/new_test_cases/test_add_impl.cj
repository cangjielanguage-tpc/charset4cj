// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import charset4cj.charset.*
import charset4cj.charset.encoding.*
import std.unittest.*
import std.unittest.testmacro.*
import std.collection.*

main(): Int64 {
    let testAddImpl = TestAddImpl()
    testAddImpl.testIndexPointer()
    testAddImpl.testEucjpnewEncoder()
    testAddImpl.testJPCharset()
    testAddImpl.testJPCharset02()
    testAddImpl.testJPCharset03()
    testAddImpl.testJPCharset04()
    testAddImpl.testKRCharset()
    testAddImpl.testKRCharset02()
    testAddImpl.testKRCharset03()
    testAddImpl.testKRCharset04()
    testAddImpl.testGBKCharset()
    testAddImpl.testGBKCharset02()
    testAddImpl.testGBKCharset03()
    testAddImpl.testGBKCharset04()
    testAddImpl.testGBCharset01()
    testAddImpl.testGBCharset02()
    testAddImpl.testBIG5Charset()
    testAddImpl.testBIG5Charset02()
    testAddImpl.testBIG5Charset03()
    testAddImpl.testUTF32Charset()
    testAddImpl.testUTF16Charset()
    testAddImpl.testUTF8Charset()
    return 0
}

@Test
public class TestAddImpl {

    var map: HashMap<UInt32, UInt32> = HashMap<UInt32, UInt32>()
    var des: Array<Rune> = Array<Rune>(100, {_ => r'\u{0}'})

    @TestCase
    public func testIndexPointer(): Unit {
        map.put(1, 2)
        map.put(110, 120)
        var i: Int64 = indexPointer(map, Array<UInt32>(), 1)
        @Assert(i, 2)
    }

    @TestCase
    public func testEucjpnewEncoder(): Unit {
        var flag = 0
        var jp = Charsets.EUCJP
        var jpe = jp.newEncoder()
        var jp2 = Charsets.EUCJP
        var iso = Charsets.ISO_2022_JP
        var isoe = iso.newEncoder()
        jpe.encode("")
        isoe.encode("")
        if (jp == jp2) {
            flag = 1
        }
        if (jp != jp2) {
            flag = 0
        }
        var str = "euc"
        var str2 = "EUC-JP"
        if (jp ==str) {
            flag = 1
        }
        if (jp2 !=str) {
            flag = 0
        }
        if (jp ==str2) {
            flag = 1
        }
        if (jp2 !=str2) {
            flag = 0
        }
        @Assert(flag, 1)
    }

    @TestCase
    public func testJPCharset(): Unit {
        var jp = Charsets.EUCJP
        var jis = Charsets.SHIFT_JIS
        jp.hashCode()
        var flag = 0
        var str = jp.toString()
        if (jp == jis) {
            flag = 1
        }
        if (jp != jis) {
            flag = 0
        }
        if (str == "eucjp") {
            flag = 1
        }
        if (str != "eucjp") {
            flag = 0
        }
        @Assert(flag, 0)
    }

    @TestCase
    public func testJPCharset02(): Unit {
        var jp = Charsets.ISO_2022_JP
        var jis = Charsets.SHIFT_JIS
        jp.hashCode()
        var flag = 1
        var str = jp.toString()
        if (jp == jis) {
            flag = 0
        }
        if (jp != jis) {
            flag = 1
        }
        if (str == "eucjp") {
            flag = 0
        }
        if (str != "eucjp") {
            flag = 1
        }
        @Assert(flag, 1)
    }

    @TestCase
    public func testJPCharset03(): Unit {
        var iso1 = Charsets.ISO_2022_JP
        var iso2 = Charsets.ISO_2022_JP
        var flag = 1
        if (iso1 == iso2) {
            flag = 0
        }
        if (iso1 != iso2) {
            flag = 1
        }
        var str2 = "iso_2022"
        var str3 = "ISO-2022-JP"
        if (iso1 ==str2) {
            flag = 0
        }
        if (iso1 ==str3) {
            flag = 1
        }
        if (iso1 !=str3) {
            flag = 0
        }
        if (iso2 !=str2) {
            flag = 1
        }
        @Assert(flag, 1)
    }

    @TestCase
    public func testJPCharset04(): Unit {
        var iso1 = Charsets.ISO_2022_JP
        var s1 = Charsets.SHIFT_JIS
        var s2 = Charsets.SHIFT_JIS
        var flag = 1
        if (s1 == iso1) {
            flag = 0
        }
        if (s1 == s2) {
            flag = 1
        }
        if (iso1 != s1) {
            flag = 0
        }
        if (s1 != s2) {
            flag = 1
        }
        s1.hashCode()
        s1.toString()
        var str = "shift"
        var str2 = "Shift_JIS"
        if (s1 ==str) {
            flag = 0
        }
        if (s2 !=str) {
            flag = 1
        }
        if (s1 ==str2) {
            flag = 0
        }
        if (s2 !=str2) {
            flag = 1
        }
        @Assert(flag, 0)
    }

    @TestCase
    public func testKRCharset(): Unit {
        var jp = Charsets.EUCJP
        var kr = Charsets.EUCKR
        kr.hashCode()
        var flag = 0
        var str = kr.toString()
        if (jp == kr) {
            flag = 1
        }
        if (jp != kr) {
            flag = 0
        }
        if (str == "euckr") {
            flag = 1
        }
        if (str != "euckr") {
            flag = 0
        }
        @Assert(flag, 0)
    }

    @TestCase
    public func testKRCharset02(): Unit {
        var kr = Charsets.EUCKR
        var kr2 = Charsets.EUCKR
        var flag = 1
        if (kr == kr2) {
            flag = 0
        }
        if (kr != kr2) {
            flag = 1
        }
        if (kr.toString() == "euckr") {
            flag = 0
        }
        if (kr2.toString() != "euckr") {
            flag = 1
        }
        @Assert(flag, 1)
    }

    @TestCase
    public func testKRCharset03(): Unit {
        var kr = Charsets.EUCKR
        var kr2 = Charsets.EUCKR
        var flag = 1
        var str = "EUC-KR"
        var str2 = "euc"
        if (kr ==str) {
            flag = 1
        }
        if (kr !=str) {
            flag = 0
        }
        if (kr2 ==str2) {
            flag = 1
        }
        if (kr2 !=str2) {
            flag = 0
        }
        @Assert(flag, 0)
    }

    @TestCase
    public func testKRCharset04(): Unit {
        var iso1 = Charsets.ISO_2022_JP
        var kr = Charsets.EUCKR
        var flag = 1
        if (kr == iso1) {
            flag = 0
        }
        if (kr != iso1) {
            flag = 0
        }
        kr.hashCode()
        kr.toString()
        @Assert(flag, 0)
    }

    @TestCase
    public func testGBKCharset(): Unit {
        var gbk = Charsets.GBK
        var g18030 = Charsets.GB18030
        g18030.hashCode()
        var flag = 0
        var str = g18030.toString()
        if (gbk == g18030) {
            flag = 1
        }
        if (gbk != g18030) {
            flag = 0
        }
        if (str == "gb18030") {
            flag = 1
        }
        if (str != "gb18030") {
            flag = 0
        }
        @Assert(flag, 1)
    }

    @TestCase
    public func testGBKCharset02(): Unit {
        var jp = Charsets.ISO_2022_JP
        var g18030 = Charsets.GB18030
        var flag = 1
        if (jp == g18030) {
            flag = 0
        }
        if (jp != g18030) {
            flag = 1
        }
        @Assert(flag, 1)
    }

    @TestCase
    public func testGBKCharset03(): Unit {
        var b1 = Charsets.GBK
        var b2 = Charsets.GBK
        var flag = 1
        var str = "gbk"
        var str2 = "gb18030"
        if (b1 == b2) {
            flag = 0
        }
        if (b1 != b2) {
            flag = 1
        }
        if (b1 ==str) {
            flag = 1
        }
        if (b1 !=str) {
            flag = 0
        }
        if (b2 ==str2) {
            flag = 1
        }
        if (b2 !=str2) {
            flag = 0
        }
        @Assert(flag, 0)
    }

    @TestCase
    public func testGBKCharset04(): Unit {
        var kr = Charsets.EUCKR
        var b1 = Charsets.GBK
        b1.newDecoder()
        var flag = 1
        if (b1 == kr) {
            flag = 0
        }
        if (b1 != kr) {
            flag = 0
        }
        b1.hashCode()
        b1.toString()
        @Assert(flag, 0)
    }

    @TestCase
    public func testGBCharset01(): Unit {
        var b1 = Charsets.GB18030
        var b2 = Charsets.GB18030
        var flag = 1
        var str = "gb18030"
        var str2 = "gb"
        if (b1 ==str) {
            flag = 1
        }
        if (b1 !=b2) {
            flag = 0
        }
        if (b1 ==b2) {
            flag = 1
        }
        if (b1 !=str) {
            flag = 0
        }
        if (b2 ==str2) {
            flag = 1
        }
        if (b2 !=str2) {
            flag = 0
        }
        @Assert(flag, 0)
    }

    @TestCase
    public func testGBCharset02(): Unit {
        var kr = Charsets.EUCKR
        var b1 = Charsets.GB18030
        var flag = 1
        if (b1 == kr) {
            flag = 0
        }
        if (b1 != kr) {
            flag = 0
        }
        @Assert(flag, 0)
    }

    @TestCase
    public func testBIG5Charset(): Unit {
        var b1 = Charsets.BIG5
        var b2 = Charsets.BIG5
        b1.hashCode()
        var flag = 0
        var str = b1.toString()
        if (b1 == b2) {
            flag = 1
        }
        if (b1 != b2) {
            flag = 0
        }
        if (str == "big5") {
            flag = 1
        }
        if (str != "big5") {
            flag = 0
        }
        @Assert(flag, 0)
    }

    @TestCase
    public func testBIG5Charset02(): Unit {
        var b1 = Charsets.BIG5
        var b2 = Charsets.BIG5_HKSCS
        b2.hashCode()
        var str = b2.toString()
        var flag = 1
        if (b1 == b2) {
            flag = 0
        }
        if (b1 != b2) {
            flag = 1
        }
        if (str == "big5") {
            flag = 1
        }
        if (str != "big5") {
            flag = 0
        }
        @Assert(flag, 0)
    }

    @TestCase
    public func testBIG5Charset03(): Unit {
        var b1 = Charsets.BIG5_HKSCS
        var b2 = Charsets.BIG5_HKSCS
        var b3 = Charsets.BIG5
        b3.newEncoder().encode("")
        var flag = 1
        if (b1 == b2) {
            flag = 0
        }
        if (b1 != b2) {
            flag = 1
        }
        if (b1 == b3) {
            flag = 0
        }
        if (b1 != b3) {
            flag = 1
        }
        var str = "Big5"
        var str2 = "big5"
        if (b1 == str) {
            flag = 0
        }
        if (b1 != str) {
            flag = 1
        }
        if (b1 == str2) {
            flag = 0
        }
        if (b1 != str2) {
            flag = 1
        }
        if (b3 == str) {
            flag = 0
        }
        if (b3 != str) {
            flag = 1
        }
        @Assert(flag, 0)
    }

    @TestCase
    public func testUTF8Charset(): Unit {
        var u1 = Charsets.UTF8
        var u2 = Charsets.UTF8
        var u3 = Charsets.UTF16BE
        u1.hashCode()
        var flag = 0
        var str = u1.toString()
        if (u1 == u2) {
            flag = 1
        }
        if (u1 != u2) {
            flag = 0
        }
        if (u1 == u3) {
            flag = 1
        }
        if (u1 != u3) {
            flag = 0
        }
        if (str == "utf-8") {
            flag = 1
        }
        if (str != "utf-8") {
            flag = 0
        }
        var str2 = "UTF-8"
        var str3 = "uu"
        if (u1 == str3) {
            flag = 1
        }
        if (u1 != str3) {
            flag = 0
        }
        if (u1 == str2) {
            flag = 1
        }
        if (u1 != str2) {
            flag = 0
        }
        @Assert(flag, 1)
    }

    @TestCase
    public func testUTF16Charset(): Unit {
        var u1 = Charsets.UTF16BE
        var u2 = Charsets.UTF16LE
        var u3 = Charsets.UTF16BE
        u1.hashCode()
        var str = u2.toString()
        var flag = 1
        if (u1 == u2) {
            flag = 0
        }
        if (u1 != u2) {
            flag = 1
        }
        if (u1 == u3) {
            flag = 0
        }
        if (u1 != u3) {
            flag = 1
        }
        if (str == "utf16") {
            flag = 1
        }
        if (str != "utf16") {
            flag = 0
        }
        var str2 = "UTF-16BE"
        var str3 = "UTF-16LE"
        if (u1 == str2) {
            flag = 0
        }
        if (u1 != str2) {
            flag = 1
        }
        if (u1 == str3) {
            flag = 0
        }
        if (u1 != str3) {
            flag = 1
        }
        if (u2 == str3) {
            flag = 0
        }
        if (u2 != str3) {
            flag = 1
        }
        @Assert(flag, 0)
    }

    @TestCase
    public func testUTF32Charset(): Unit {
        var u1 = Charsets.UTF32BE
        var u2 = Charsets.UTF32LE
        var u3 = Charsets.UTF32BE
        u2.hashCode()
        var str = u2.toString()
        var flag = 1
        if (u1 == u2) {
            flag = 0
        }
        if (u1 != u2) {
            flag = 1
        }
        if (u1 == u3) {
            flag = 0
        }
        if (u1 != u3) {
            flag = 0
        }
        if (str == "utf32") {
            flag = 1
        }
        if (str != "utf32") {
            flag = 0
        }
        var str2 = "UTF-32BE"
        var str3 = "UTF-32LE"
        if (u1 == str2) {
            flag = 0
        }
        if (u1 != str2) {
            flag = 1
        }
        if (u1 == str3) {
            flag = 0
        }
        if (u1 != str3) {
            flag = 1
        }
        if (u2 == str3) {
            flag = 0
        }
        if (u2 != str3) {
            flag = 1
        }
        @Assert(flag, 0)
    }
}
