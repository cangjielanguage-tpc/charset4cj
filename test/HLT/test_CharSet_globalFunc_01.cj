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
        var encoder01=EUCJPCharset.instance.newEncoder()
        var encoder02=Charsets.EUCJP.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=EUCJPCharset.instance.newDecoder()
        var decoder02=Charsets.EUCJP.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc02(): Unit {
        var encoder01=ShiftJISCharset.instance.newEncoder()
        var encoder02=Charsets.SHIFT_JIS.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=ShiftJISCharset.instance.newDecoder()
        var decoder02=Charsets.SHIFT_JIS.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc03(): Unit {
        var encoder01=ISO2022JPCharset.instance.newEncoder()
        var encoder02=Charsets.ISO_2022_JP.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=ISO2022JPCharset.instance.newDecoder()
        var decoder02=Charsets.ISO_2022_JP.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc04(): Unit {
        var encoder01=EUCKRCharset.instance.newEncoder()
        var encoder02=Charsets.EUCKR.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=EUCKRCharset.instance.newDecoder()
        var decoder02=Charsets.EUCKR.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc05(): Unit {
        var encoder01=GB18030Charset.instance.newEncoder()
        var encoder02=Charsets.GB18030.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=GB18030Charset.instance.newDecoder()
        var decoder02=Charsets.GB18030.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc06(): Unit {
        var encoder01=BIG5HKSCSCharset.instance.newEncoder()
        var encoder02=Charsets.BIG5_HKSCS.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=BIG5HKSCSCharset.instance.newDecoder()
        var decoder02=Charsets.BIG5_HKSCS.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc0601(): Unit {
        var encoder01=BIG5Charset.instance.newEncoder()
        var encoder02=Charsets.BIG5.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=BIG5Charset.instance.newDecoder()
        var decoder02=Charsets.BIG5.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc07(): Unit {
        var encoder01=UTF16Charset.beInstance.newEncoder()
        var encoder02=Charsets.UTF16BE.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=UTF16Charset.beInstance.newDecoder()
        var decoder02=Charsets.UTF16BE.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc08(): Unit {
        var encoder01=UTF16Charset.leInstance.newEncoder()
        var encoder02=Charsets.UTF16LE.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=UTF16Charset.leInstance.newDecoder()
        var decoder02=Charsets.UTF16LE.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc09(): Unit {
        var encoder01=UTF32Charset.beInstance.newEncoder()
        var encoder02=Charsets.UTF32BE.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=UTF32Charset.beInstance.newDecoder()
        var decoder02=Charsets.UTF32BE.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc10(): Unit {
        var encoder01=UTF32Charset.leInstance.newEncoder()
        var encoder02=Charsets.UTF32LE.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=UTF32Charset.leInstance.newDecoder()
        var decoder02=Charsets.UTF32LE.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc11(): Unit {
        var encoder01=UTF8Charset.instance.newEncoder()
        var encoder02=Charsets.UTF8.newEncoder()
        var en_re01=encoder01.encode(encode_String)
        var en_re02=encoder02.encode(encode_String)
        @Assert(en_re01,en_re02)
        var decoder01=UTF8Charset.instance.newDecoder()
        var decoder02=Charsets.UTF8.newDecoder()
        var de_re01=decoder01.decode(en_re01)
        var de_re02=decoder02.decode(en_re02)
        @Assert(de_re01,de_re02)
    }
    @TestCase
    func testGlobalFunc12(): Unit {
        var charset01=SingleByteCharset.IBM866
        @Assert(charset01 is Charset,true)
        // var flag=1
        // try{
        //     newSingleByteCharset("EUCK-R")
        // }catch(e:NoneValueException){
        //     if(e.toString().contains("Value does not exist")){
        //         flag=0
        //     }
        // }
        // @Assert(flag,0)
    }
}
