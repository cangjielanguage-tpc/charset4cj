<p align="center">
<img src="./doc/assets/logo.png" width="60%" >
</p>

<p align="center">
<img alt="" src="https://badg.now.sh/badge/release/v0.0.1?color=green" style="display: inline-block;" />
<img alt="" src="https://badg.now.sh/badge/build/pass?color=green" style="display: inline-block;" />
<img alt="" src="https://badg.now.sh/badge/cjc/v0.28.4?color=green" style="display: inline-block;" />
<img alt="" src="https://badg.now.sh/badge/cjcov/90%25?color=green" style="display: inline-block;" />
<img alt="" src="https://badg.now.sh/badge/project/open?color=green" style="display: inline-block;" />
</p>

## <img alt="" src="./doc/assets/readme-icon-introduction.png" style="display: inline-block;" width=3%/>简介

仓颉语言编解码库。基于 [WHATWG 字符编码标准](http://encoding.spec.whatwg.org/) 

### 特性

+ 🚀 只有两种方式获取字符集Charset

  + 通过 Charsets 的常量获取，例如： Charsets.utf8 
  + 通过 Charsets 的forName 方法获取， 比如 Charsets.forName("UTF-8")

- 🚀 通过 Charset 创建编码解码器

+ 💪 待开发特性

  + 使用仓颉重写 自动生成字符映射表代码
  + 支持gbk ， gb2312，gb18030 的区分
  + 支持 gb18030的编码
  + 支持 big5 编解码
  + 支持日韩字符集
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
func decode(src:Array<UInt8>, srcOffset:Int64, srcLimit:Int64, 
            dest:Array<Char>, destUnusedOffset:Int64): Int64 * Int64
```
io流（包含文件流、网络流）读取的都是字节数组，要将字节数组转成String，就需要上面2个方法。每种字符集的解码方法各不相同

- 将String转成字节数组

要将String写入到io流，需要将String转成字节数组，此时就需要编码器，
编码器提供了编码方法，能将String转成字节数组
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

├── README.md
├── doc
│   ├── assets     
│   └── 字符集简介.md 
├── src
│   └── charset
│       ├── Charsets.cj		// 常量类，提供forName方法根据字符集名称获取字符集类型，并提供所有支持的字符集常量
│       ├── encoding		// 字符集接口
│       │   ├── Charset.cj
│       │   ├── Decoder.cj
│       │   └── Encoder.cj
│       ├── korean			// 韩语字符集编解码实现
│       │   ├── EUC_KR_mapping.cj
│       │   └── euckr.cj
│       ├── simplechinese	// 简体中文字符集编解码实现
│       │   ├── GB18030Charset.cj
│       │   ├── GB18030Decoder.cj
│       │   ├── GB18030Encoder.cj
│       │   ├── gb18030_mapping.cj
│       │   └── gb18030_ranges_mapping.cj
│       ├── singlebyte		// 西欧、阿拉伯单字节字符集编解码实现
│       │   ├── ibm866_mapping.cj
│       │   ├── iso_8859_2_mapping.cj
│       │   ├── iso_8859_3_mapping.cj
│       │   ├── iso_8859_4_mapping.cj
│       │   ├── iso_8859_5_mapping.cj
│       │   ├── ......
│       │   └── x_mac_cyrillic_mapping.cj
│       │── traditionchinese	// 繁体中文字符集编解码实现
│       │   ├── big5.cj
│       │   └── big5_mapping.cj
│       └── unicode			// unicode 编解码实现
│           ├── utf8.cj
│           ├── utf16.cj
│           └── utf32.cj         
├── test
│   └── UT
│       └── charset_test.cj
└── tools 
    ├── generate
    │   ├── PrintMapping.cj
    │   └── cj
    │       ├── JapanGen.cj
    │       └── SingleByteGen.cj
    └── textio
        ├── IntegerFormat.cj
        ├── StringScanner.cj
        ├── StringUtils.cj
        ├── TextIO_test.cj
        └── TextIO.cj

```

- `doc`是库的设计文档、提案、库的使用文档
- `src`是库源码目录
- `test`是存放测试用例，包括HLT用例、LLT 用例和UT用例
- `encoding`是存放的编解码库文件
- `generate`是代码生成器，用来生成映射表

## <img alt="" src="./doc/assets/readme-icon-compile.png" style="display: inline-block;" width=3%/>编译运行

### 编译

```
cpm build

# 单元测试
cpm test test/UT/
```

### 示例1

```cangjie
from charset import charset.*

main (){
    var charset = Charsets.big5
    var encoder = charset.newEncoder()
    var decoder = charset.newDecoder()
    var buf1 = Array<UInt8>([0xB0, 0xDA, 0xA7, 0x41])
    var s1 = decoder.decode(buf1)
    if (!s1.equals("碉峴")) {
        return 1
    }
    return 0
}
```

## <img alt="" src="./doc/assets/readme-icon-contribute.png" style="display: inline-block;" width=3%/>参与贡献

[@freeonsky](https://gitee.com/freeonsky)
