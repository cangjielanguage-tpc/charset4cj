// 3rd_party_lib:charset/build/charset
// 3rd_party_lib_ohos:charset/build/aarch64-linux-ohos/charset

from std import unittest.*
from std import unittest.testmacro.*
from charset import charset.*
from charset import charset.encoding.*
from charset import charset.korean.*
from charset import charset.japanese.*
from charset import charset.traditionchinese.*
from charset import charset.unicode.*
from charset import charset.simplechinese.*
from charset import charset.singlebyte.*
from std import collection.*

@Test
public class TestCharset{
    /*
        public func newEUCJPCharset():Charset
        public func newShiftJISCharset():Charset
        public func newISO2022JPCharset():Charset
        public func newEUCKRCharset():Charset
        public func newGB18030Charset(gbk: Bool):Charset
        public func newBIG5Charset(hkscs:Bool):Charset
        public func newUTF16Charset(be:Bool):Charset
        public func newUTF32Charset(be:Bool):Charset
        public func newUTF8Charset():Charset
        public func newSingleByteCharset(name:String):Charset
        测试场景:与默认字符集结果一致
    */
    var encode_String="FAFIDSGJOferegee324525"
    @TestCase
    func testGlobalFunc01(): Unit {
        var encoder01=newEUCJPCharset().newEncoder()
        var encoder02=Charsets.EUCJP.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=newEUCJPCharset().newDecoder()
        var decoder02=Charsets.EUCJP.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc02(): Unit {
        var encoder01=newShiftJISCharset().newEncoder()
        var encoder02=Charsets.SHIFT_JIS.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=newShiftJISCharset().newDecoder()
        var decoder02=Charsets.SHIFT_JIS.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc03(): Unit {
        var encoder01=newISO2022JPCharset().newEncoder()
        var encoder02=Charsets.ISO_2022_JP.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=newISO2022JPCharset().newDecoder()
        var decoder02=Charsets.ISO_2022_JP.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc04(): Unit {
        var encoder01=newEUCKRCharset().newEncoder()
        var encoder02=Charsets.EUCKR.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=newEUCKRCharset().newDecoder()
        var decoder02=Charsets.EUCKR.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc05(): Unit {
        var encoder01=newGB18030Charset(false).newEncoder()
        var encoder02=Charsets.GB18030.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=newGB18030Charset(false).newDecoder()
        var decoder02=Charsets.GB18030.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc06(): Unit {
        var encoder01=newBIG5Charset(true).newEncoder()
        var encoder02=Charsets.BIG5_HKSCS.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=newBIG5Charset(true).newDecoder()
        var decoder02=Charsets.BIG5_HKSCS.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc0601(): Unit {
        var encoder01=newBIG5Charset(false).newEncoder()
        var encoder02=Charsets.BIG5.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=newBIG5Charset(false).newDecoder()
        var decoder02=Charsets.BIG5.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc07(): Unit {
        var encoder01=newUTF16Charset(true).newEncoder()
        var encoder02=Charsets.UTF16BE.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=newUTF16Charset(true).newDecoder()
        var decoder02=Charsets.UTF16BE.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc08(): Unit {
        var encoder01=newUTF16Charset(false).newEncoder()
        var encoder02=Charsets.UTF16LE.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=newUTF16Charset(false).newDecoder()
        var decoder02=Charsets.UTF16LE.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc09(): Unit {
        var encoder01=newUTF32Charset(true).newEncoder()
        var encoder02=Charsets.UTF32BE.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=newUTF32Charset(true).newDecoder()
        var decoder02=Charsets.UTF32BE.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc10(): Unit {
        var encoder01=newUTF32Charset(false).newEncoder()
        var encoder02=Charsets.UTF32LE.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=newUTF32Charset(false).newDecoder()
        var decoder02=Charsets.UTF32LE.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc11(): Unit {
        var encoder01=newUTF8Charset().newEncoder()
        var encoder02=Charsets.UTF8.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=newUTF8Charset().newDecoder()
        var decoder02=Charsets.UTF8.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc12(): Unit {
        var charset01=newSingleByteCharset("IBM866")
        @Assert(charset01 is Charset,true)
        var flag=1
        try{
            newSingleByteCharset("EUCK-R")
        }catch(e:NoneValueException){
            if(e.toString().contains("Value does not exist")){
                flag=0
            }
        }
        @Assert(flag,0)
    }
}