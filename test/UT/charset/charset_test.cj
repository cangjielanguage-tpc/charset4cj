package charset

@Test
public class CharsetsTest {

    // cjc test/UT/charset_test.cj --test --import-path ./build  -L ./build/charset/ -l charsetcharset -l charsetcharset.encoding -l charsetcharset.traditionchinese -l charsetcharset.simplechinese -l charsetcharset.korean -l charsetcharset.singlebyte -l charsetcharset.unicode
    // export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/work/charset/build/charset
    @TestCase
    public func big5(): Unit{
        var charset = Charsets.big5
        var encoder = charset.newEncoder()
        var decoder = charset.newDecoder()
        var buf1 = Array<UInt8>([0xB0, 0xDA, 0xA7, 0x41])
        var s1 = decoder.decode(buf1)
        @Assert(s1, "碉峴")
    }

    @TestCase
    public func gb18030():Unit {
        var charset = match(Charsets.forName("gb18030")){
            case Some(cs) => cs
            case _ => Charsets.gb18030
        }
        var decoder = charset.newDecoder()

        // 单 字节解码
        var buf1 = Array<UInt8>([65, 66, 67, 65, 66, 67])
        var s1 = decoder.decode(buf1)
        @Assert(s1, "ABCABC")

        // 双 字节解码
        var buf2 = Array<UInt8>([0xC4, 0xE3, 0xBA, 0xC3,0xCE, 0xD2])
        var s2 = decoder.decode(buf2)
        @Assert(s2, "你好我")

        // 四字节 𬌗
        var buf4 = Array<UInt8>([0x99,0x31,0xD2,0x39,0x99,0x31,0xD2,0x39,0x99,0x31,0xD2,0x39,0x99,0x31,0xD2,0x39,0x99,0x31,0xD2,0x39])
        var s4 = decoder.decode(buf4)
        @Assert(s4, "𬌗𬌗𬌗𬌗𬌗")
    }

    @TestCase
    public func ibm866():Unit{
        var charset = match(Charsets.forName("IBM866")){
            case Some(cs) => cs
            case _ => Charsets.ibm866      
        }
        // var charset = SingleByteCharset("IBM866")
        var decoder = charset.newDecoder()
        var buf1 = Array<UInt8>([0x80, 0x81,0x82,0x83,0x84,0x85])
        var s1 = decoder.decode(buf1)
        @Assert(s1, "АБВГД")
        print("s1:${s1}\t")    
    }

    @TestCase
    public func euk():Unit{
        // var charset = EUCKRCharset()
        var charset = match(Charsets.forName("EUCKR")){
            case Some(cs) => cs
            case _ => Charsets.euckr      
        }        
        var encoder = charset.newEncoder()
        var decoder = charset.newDecoder()

        var buf1 = Array<UInt8>([0xA2, 0xDB, 0xA4, 0xA6])
        
        var s1 = decoder.decode(buf1)
        @Assert(s1, "갂갂")
    }

    @TestCase
    public func utf8():Unit{
        var charset = match(Charsets.forName("UTF8")){
            case Some(cs) => cs
            case _ => Charsets.utf8      
        }            
        // abc 是单字节
        // \u{00A1} ¡ 是双字节
        // 𡃁 是4字节
        // 普通汉字是3字节
        var s = "abc\u{00A1}𡃁abc 是单字节"
        // var charset = UTF8Charset()
        var encoder = charset.newEncoder()
        var arr = encoder.encode(s)
        // for(a in arr){
        //     print("a:${a}\n")
        // }
        var decoder = charset.newDecoder()
        var s1 = decoder.decode(arr)
        @Assert(s1, "abc\u{00A1}𡃁abc 是单字节")
    }

    @TestCase
    func utf16betest():Unit{
        // var charset = UTF16Charset(true) // 大端
        var charset = match(Charsets.forName("UTF-16BE")){
            case Some(cs) => cs
            case _ => Charsets.utf16be      
        }          
        var decoder = charset.newDecoder()

        var encoder = charset.newEncoder()
        var arr = encoder.encode("啊𬌗𬌗𬌗𬌗𬌗𬌗𬌗𬌗")

        var s = decoder.decode(arr)
        @Assert(s, "啊𬌗𬌗𬌗𬌗𬌗𬌗𬌗𬌗")
        var buf1 = Array<UInt8>([0x55, 0x4a,0x62,0x11,0xD8, 0x70, 0xDF, 0x17])
        var s1 = decoder.decode(buf1)
        print("s1：${s1}\n")
    }

    @TestCase
    func utf16letest():Unit{
        // var charset = UTF16Charset(false) // 小端
        var charset = match(Charsets.forName("UTF-16LE")){
            case Some(cs) => cs
            case _ => Charsets.utf16    
        }            
        var decoder = charset.newDecoder()
        var encoder = charset.newEncoder()
        var arr = encoder.encode("啊𬌗𬌗𬌗𬌗𬌗𬌗𬌗𬌗")

        var s = decoder.decode(arr)
        @Assert(s, "啊𬌗𬌗𬌗𬌗𬌗𬌗𬌗𬌗")
    }

    @TestCase
    func utf32test1():Unit{
        // var charset = UTF32Charset(true)
        var charset = match(Charsets.forName("UTF-32BE")){
            case Some(cs) => cs
            case _ => Charsets.utf32be      
        }             
        // abc 是单字节
        // \u{00A1} ¡ 是双字节
        // 𡃁 是4字节
        // 普通汉字是3字节
        var s = "abc\u{00A1}𡃁abc 是单字节"
        var encoder = charset.newEncoder()
        var arr = encoder.encode(s)

        var decoder = charset.newDecoder()
        var s1 = decoder.decode(arr)
        @Assert(s1, s)
        // print("s1:${s1}")
    }

    @TestCase
    func utf32test():Unit{
        // var charset = UTF32Charset(true)
        var charset = match(Charsets.forName("UTF-32LE")){
            case Some(cs) => cs
            case _ => Charsets.utf32      
        }          
        var arr:Array<UInt8> = Array<UInt8>([0x00,0x00,0xFE,0xFF,0x00,0x00,0x55,0x4A])
        var decoder = charset.newDecoder()
        var s1 = decoder.decode(arr)
        // print("s1:${s1}")
    }
}