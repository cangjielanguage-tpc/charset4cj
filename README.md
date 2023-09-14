<div align="center">
<h1> charset </h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v0.0.2-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.39.7-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-89.4%25-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>

## <img alt="" src="./doc/assets/readme-icon-introduction.png" style="display: inline-block;" width=3%/> 介绍

仓颉语言编解码库。基于 [WHATWG 字符编码标准](http://encoding.spec.whatwg.org/) 

### 特性

+ 🚀 只有两种方式获取字符集Charset

  + 通过 Charsets 的常量获取，例如： Charsets.UTF8 
  + 通过 Charsets 的forName 方法获取， 比如 Charsets.forName("UTF-8")

- 🚀 通过 Charset 创建编码解码器

+ 💪 待开发特性
  + 增加bom支持

##    <img alt="" src="./doc/assets/readme-icon-framework.png" style="display: inline-block;" width=3%/> 架构

### 架构图：

<p align="center">
<img src="./doc/assets/framework.png" width="60%" >
</p>

- 将字节数组转成String对象
  
解码器提供了下面两个方法，能够将字节数组转成String对象
```
func decode(src:Array<UInt8>):String
func decode(src:Array<UInt8>, dest:Array<Char>): (Int64, Int64)
```
io流（包含文件流、网络流）读取的都是字节数组，要将字节数组转成String，就需要上面2个方法。每种字符集的解码方法各不相同

- 将String转成字节数组

要将String写入到io流，需要将String转成字节数组，此时就需要编码器，
编码器提供了编码方法，能将String转成字节数组，传统字符集的字符数量小于unicode， 一些字符在传统字符集中没有，
从unicode(String)编码到传统字符集，会将没有的字符替换成其它（如：0xF3）字节
```
func encode(str:String): Array<UInt8>
```

+ 字符集分类

  + unicode。 仓颉的String是Char数组，一个Char是32位，表示一个unicode代码点。仓颉的String转utf8,utf16le, utf16be,utf32都可以通过计算得到编码
  + 简体中文，如gbk, 无法通过计算与unicode互相转化，需要维护一个gbk代码点与unicode代码点映射表，通过查表方式去转化
  + 繁体中文，big5, 无法通过计算与unicode互相转化，需要维护一个big5代码点与unicode代码点映射表，通过查表方式去转化
  + 韩语，EUC-KR， 需要映射表
  + 日语，需要映射表
  + 阿拉伯语，拉丁语等等这些字符数量少于256，一个字节就能保存下来的字符集。这些字符集有个特点，代码点小于128的与ascii相同，无需转码。128~256的字符转码unicode需要查表

### 源码目录：

```
├── doc
│   └── assets
│   └── 字符集简介.md
│   └── feature_api.md
├── src
│   └── charset
│       ├── charsets.cj     // 常量类，提供forName方法根据字符集名称获取字符集类型，并提供所有支持的字符集常量
│       ├── text_reader.cj
│       ├── text_writer.cj
│       ├── encoding        // 字符集接口
│       │   ├── charset.cj
│       │   ├── decoder.cj
│       │   └── encoder.cj
│       ├── japanese        // 日语字符集编码实现
│       │   ├── eucjp.cj
│       │   ├── iso_2022_jp_katakana_mapping.cj
│       │   ├── iso_2022_jp.cj
│       │   ├── jis0208_mapping.cj
│       │   ├── jis0212_mapping.cj
│       │   ├── jp_charset.cj
│       │   └── shift_jis.cj
│       ├── korean          // 韩语字符集编码实现
│       │   ├── euc_kr_mapping.cj
│       │   └── euckr.cj
│       ├── simplechinese   // 简体中文字符集编码实现
│       │   ├── gb18030_charset.cj
│       │   ├── gb18030_decoder.cj
│       │   ├── gb18030_encoder.cj
│       │   ├── gb18030_mapping.cj
│       │   └── gb18030_ranges_mapping.cj
│       ├── singlebyte      //  西欧、阿拉伯单字节字符集编解码实现
│       │   ├── ibm866_mapping.cj
│       │   ├── iso_8859_10_mapping.cj
│       │   ├── ......
│       │   ├── windows_874_mapping.cj
│       │   └── x_mac_cyrillic_mapping.cj
│       ├── traditionchinese  // 繁体中文字符集编解码实现
│       │   ├── big5.cj
│       │   └── big5_mapping.cj
│       └── unicode           // unicode 编解码实现
│           ├── utf16.cj
│           ├── utf32.cj
│           └── utf8.cj
├── test
│   └── HLT
│   └── LLT
│   └── UT
├── gitee_gate.cfg
├── LICENSE
├── module.json
├── README.md
```

- `doc` 存放库使用文档
- `src` 是库源码目录
- `test` 是存放测试用例的文件夹，含有 HLT 测试用例、LLT 自测用例 和 UT测试用例

### 接口说明

主要是核心类和成员函数说明,详情见 [API](./doc/feature_api.md)

#### class TextReader

```
public init(input:InputStream, charset!:Charset = Charsets.UTF8, bufSize!:Int64 = 8192)
public func readln(): Option<String>
```
#### class Charset

```
public func nameEquals(name:String):Bool
public func newEncoder():Encoder
public func newDecoder():Decoder
```
#### interface Decoder

```
func decode(src:Array<UInt8>):String
func decode(src:Array<UInt8> dest:Array<Char>): (Int64, Int64)
```
#### interface Encoder

```
func encode(str:String): Array<UInt8>
```

#### class Charsets

```
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
public static func forName(name:String):Option<Charset>
```

## <img alt="" src="./doc/assets/readme-icon-compile.png" style="display: inline-block;" width=3%/> 使用说明

### 编译构建

```shell
cjpm build
```

### 读取字符集功能示例

注意：字符集简介文件存放于项目的 test/LLT 目录下

```cangjie
from std import fs.*
from charset import charset.*

main() {
    var f:File = File("./字符集简介.md", Open(true, false))
    var sr = TextReader(f, charset: Charsets.GB18030, bufSize:120)
    while(true){
        var lineOp:Option<String> = sr.readln()
        if(lineOp == None){
            break
        }
        lineOp.getOrThrow()
    }   
    0
}
```

执行结果如下：
```shell
0
```

### EUCJP 字符集编码解码功能示例

```cangjie
from charset import charset.*
from charset import charset.japanese.*
from std import unittest.*
from std import unittest.testmacro.*
from std import collection.*

main(): Int64 {
    let encodeTest01 = EncodeTest01()
    encodeTest01.testEUCJPEncode01()
    return 0
}

@Test
public class EncodeTest01 {

    let str: String = "z,ncm,xzjiu"
    let str_en: String = "中有华为，华有仓颉"

    @TestCase
    public func testEUCJPEncode01(): Unit {
        var jp = Charsets.EUCJP
        var jpen = jp.newEncoder()
        var jpde = jp.newDecoder()
        let src: Array<UInt8> = jpen.encode(str)
        let src2: Array<UInt8> = jpen.encode(str_en)
        let res = jpde.decode(src, des)
        jpde.decode(src2, des)
        @Assert(res[0], 6)
        @Assert(res[1], 6)
    }
}
```

执行结果如下：
```shell
0
```

注意：用例需放入 `test/LLT` 下，执行步骤是: 本项目编译运行方式

## <img alt="" src="./doc/assets/readme-icon-contribute.png" style="display: inline-block;" width=3%/> 参与贡献

欢迎给我们提交 PR，欢迎给我们提交 issue，欢迎参与任何形式的贡献。
