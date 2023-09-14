## Charset 库

### 介绍
仓颉语言字符编解码库

### 1 获取字符集 Charset

前置条件：NA
场景：
1、通过 Charsets 的常量获取，例如： Charsets.UTF8
2、通过 Charsets 的forName 方法获取， 比如 Charsets.forName("UTF-8")
约束：NA 
性能： NA
可靠性： NA

#### 1.1 主要接口

当前库支持的字符集
public class Charsets

```cangjie

    // UTF-8
    public static let UTF8:Charset
    // utf-16 be
    public static let UTF16BE:Charset
    // utf16 le
    public static let UTF16LE:Charset
    // utf32 be
    public static let UTF32BE:Charset
    // utf32 le
    public static let UTF32LE:Charset
    // gb18030
    public static let GB18030:Charset
    // gbk
    public static let GBK:Charset
    // EUC-KR
    public static let EUCKR:Charset
    // EUC-JP
    public static let EUCJP:Charset
    // ShiftJIS
    public static let SHIFT_JIS:Charset
    // ISO-2022-JP
    public static let ISO_2022_JP:Charset
    // Big5
    public static let BIG5:Charset
    // Big5-hkscs
    public static let BIG5_HKSCS:Charset
    // IBM866
    public static let IBM866:Charset
    // ISO-8859-2
    public static let ISO_8859_2:Charset
    // ISO-8859-3
    public static let ISO_8859_3:Charset
    // ISO-8859-4
    public static let ISO_8859_4:Charset
    // ISO-8859-5
    public static let ISO_8859_5:Charset
    // ISO-8859-6
    public static let ISO_8859_6:Charset
    // ISO-8859-7
    public static let ISO_8859_7:Charset
    // ISO-8859-8
    public static let ISO_8859_8:Charset
    // ISO-8859-10
    public static let ISO_8859_10:Charset
    // ISO-8859-13
    public static let ISO_8859_13:Charset
    // ISO-8859-14
    public static let ISO_8859_14:Charset
    // ISO-8859-15
    public static let ISO_8859_15:Charset
    // ISO-8859-16
    public static let ISO_8859_16:Charset
    // KOI8-R
    public static let KOI8_R:Charset
    // KOI8-U
    public static let KOI8_U:Charset
    // macintosh
    public static let MACINTOSH:Charset
    // windows-874
    public static let WINDOWS_874:Charset
    // windows-1250
    public static let WINDOWS_1250:Charset
    // windows-1251
    public static let WINDOWS_1251:Charset
    // windows-1252
    public static let WINDOWS_1252:Charset
    // windows-1253
    public static let WINDOWS_1253:Charset
    // windows-1254
    public static let WINDOWS_1254:Charset
    // windows-1255
    public static let WINDOWS_1255:Charset
    // windows-1256
    public static let WINDOWS_1256:Charset
    // windows-1257
    public static let WINDOWS_1257:Charset
    // windows-1258
    public static let WINDOWS_1258:Charset
    // x-mac-cyrillic
    public static let X_MAC_CYRILLIC:Charset

   	/**
    * 获取基于字符集名称的字符编码类型
    * 
    * @param 传入 String 类型的字符集名称
    *
    * @return 返回一个 Option 类对象
    */
    public static func forName(name:String): Option<Charset>

```

编码器接口
public interface Encoder

```cangjie

   	/**
    * 编码器的编码方法
    * 
    * @param str - 传入一个 String 字符串
    *
    * @return 返回编码后的 UInt8 数组
    */
    func encode(str:String): Array<UInt8>
```

解码器接口
public interface Decoder

```cangjie

   	/**
    * 解码器的解码方法
    * 
    * @param src - 编码后的字节数组
    *
    * @return 返回解码后的 String 字符串
    */
    func decode(src:Array<UInt8>):String

    /**
    * 解码字节数组到字符数组
    *
    * @param src - 使用特定编码方式编码后的字节数组
    * @param dest - 解码后数据存放的容器数组
    *
    * @return 返回元组类型，第一个 Int64 表示下一个未处理的 src 下标，第二个 Int64 表示下一个未处理的 dest 下标
    */
    func decode(src:Array<UInt8>, dest:Array<Char>): (Int64, Int64)
```

文本输入器
class TextReader

```cangjie
    /**
    * TextReader 的有参构造器
    *
    * @param input - 传入一个 InputStream 类
    * @param charset - 传入一个 Charset 类，默认是 Charsets.UTF8
    * @param bufSize - 传入一个 Int64 类型，默认是 8192
    *
    */
    public init(input:InputStream, charset!:Charset = Charsets.UTF8, bufSize!:Int64 = 8192)

    /**
    * 读取所有数据，返回一个 ArrayList 集合
    *
    * @return 返回一个 ArrayList 集合
    */
    public func readAllLine(): ArrayList<String>

    /**
    * 读取解码后的数据
    *
    * @return 返回一个 Option 类型
    */
    public func read(): Option<Char>

    /**
    * 读取一行数据，返回一个字符串
    *
    * @return 返回一个 Option 类型
    */
    public func readln(): Option<String>
```

文本输出器
class TextWriter

```cangjie
    /**
    * TextWriter 的有参构造
    *
    * @param output - 传入一个 OutputStream 类
    * @param charset - 传入一个 Charset 类，默认是 Charsets.UTF8
    *
    */
    public init(output: OutputStream, charset!: Charset = Charsets.UTF8)

    /**
    * 写数据
    *
    * @param s - 传入一个 String 字符串
    */
    public func write(s:String): Unit
```

#### 1.2 其它接口

top level

```cangjie
    /**
    * 新建一个 EUC 日本字符集
    *
	* @return 返回一个字符集
    */
	public func newEUCJPCharset():Charset
	
    /**
    * 新建一个 ShiftJIS 日本字符集
    *
    * @return 返回一个字符集
    */
	public func newShiftJISCharset():Charset
	
    /**
    * 新建一个 ISO2022 日本字符集
    *
    * @return 返回一个字符集
    */
	public func newISO2022JPCharset():Charset

    /**
    * 新建一个 EUC 韩国字符集
    *
    * @return 返回一个字符集
    */
	public func newEUCKRCharset():Charset

    /**
    * 选择创建 GBK 字符集还是 GB18030 字符集
    *
    * @param gbk - 传入一个 Bool 类型
    *
    * @return 返回一个字符集
    */
	public func newGB18030Charset(gbk: Bool): Charset

    /**
    * 选择创建不同类型的单字节编码集
    *
    * @param name - 传入一个 String 类型
    *
    * @return 返回一个字符集
    */
	public func newSingleByteCharset(name: String): Charset

    /**
    * 选择创建 BIG5 字符集还是 BIG5HKSCS 字符集
    *
    * @param hkscs - 传入一个 Bool 类型
    *
    * @return 返回一个字符集
    */
	public func newBIG5Charset(hkscs:Bool): Charset

  	/**
    * 创建 UTF8 字符集
    *
    * @return 返回一个字符集
    */
	public func newUTF8Charset():Charset

  	/**
    * 选择创建 UTF-16BE 字符集还是 UTF-16LE 字符集
    *
    * @param be - 传入一个 Bool 类型
    *
    * @return 返回一个字符集
    */
	public func newUTF16Charset(be:Bool):Charset

  	/**
    * 选择创建 UTF-32BE 字符集还是 UTF-32LE 字符集
    *
    * @param be - 传入一个 Bool 类型
    *
    * @return 返回一个字符集
    */
	public func newUTF32Charset(be:Bool):Charset
```

#### 1.3 示例

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

### 2 通过 Charset 字符集创建编码解码器

前置条件：NA
场景：NA
约束：NA 
性能： NA
可靠性： NA

#### 2.1 主要接口

字符集抽象类，它实现了 Hashable, Equatable, ToString 接口

public abstract class Charset <: Hashable & Equatable<Charset> & Equatable<String> & ToString

```cangjie
  	/**
    * 根据已有字符集创建其编码器
    *
    * @return 返回一个编码器
    */
	public func newEncoder():Encoder

  	/**
    * 根据已有字符集创建其解码器
    *
    * @return 返回一个解码器
    */
	public func newDecoder():Decoder
```

#### 2.2 其他接口

字符集抽象类

public abstract class Charset

```cangjie
  	/**
    * 判断字符集名称(或标签)是否为给定字符串
    *
    * @param name - 传入一个 String 字符串
    *
    * @return 返回一个 Bool 类型
    */
	public func nameEquals(name:String):Bool
```

top level

```cangjie
  	/**
    * 在charsetmapping中找codePoint的索引，仅在字符集模块中使用
    *
    * @param encodeMapping - 传入一个 Map 集合
    * @param decodeMapping - 传入一个 Array 数组
    * @param codePoint - 传入一个 UInt32 类型
    *
    * @return 返回一个 Int64 类型
    */
	public func indexPointer(encodeMapping:Map<UInt32, UInt32>, decodeMapping:Array<UInt32>, codePoint:UInt32) :Int64
```

#### 2.3 示例

```cangjie
from charset import charset.*

main() {
    var charset = Charsets.GB18030
    var decoder = charset.newDecoder()
    charset.newEncoder() 
    var src: Array<UInt8> = Array<UInt8>([0xCB, 0xAE, 0xB5, 0xE7, 0xB7, 0xD1])
    var destStr = decoder.decode(src)    
    if(destStr == "水电费"){
        return 0
    } else {
        return 1
    }
}
```

执行结果如下：

```shell
0
```

