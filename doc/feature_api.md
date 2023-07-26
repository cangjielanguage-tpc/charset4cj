## Charset 库

### 介绍
仓颉语言字符编解码库

### 1 获取字符集 Charset

前置条件：NA
场景：
1、通过 Charsets 的常量获取，例如： Charsets.utf8
2、通过 Charsets 的forName 方法获取， 比如 Charsets.forName("UTF-8")
约束：NA 
性能： NA
可靠性： NA

#### 1.1 主要接口

所有支持的字符集的常量定义类
class charsets

```cangjie
   	/**
    * 构造方法，构造出一个 TrieBuilder 类对象
    * 
    * @return 返回一个 TrieBuilder 类对象
    */
    public static func forName(name:String): Option<Charset>
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

#### 1.2 其它接口

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

日语编码类
class EUCJPEncoder

```cangjie
    /**
    * 编码方法
    *
    * @param str - 传入一个 String 字符串
    *
    * @return 返回 UInt8 数组
    */
    public func encode(str:String): Array<UInt8>
```

日语解码类
class EUCJPDecoder

```cangjie

    /**
    * 解码字节数组到字符数组
    *
    * @param src - 输入字节数组
    * @param data - 输出字符数组
    *
    * @return 返回下一个未处理的数组下标
    */
    public func decode(src:Array<UInt8>, dest:Array<Char>): (Int64, Int64)
```

iso2022日本编码类
class ISO2022JPEncoder

```cangjie
    /**
    * 编码方法
    *
    * @param str - 传入一个 String 字符串
    *
    * @return 返回 UInt8 数组
    */
    public func encode(str:String): Array<UInt8>
```

iso2022日本解码类
class ISO2022JPDecoder

```cangjie
    /**
    * 解码字节数组到字符数组
    *
    * @param src - 输入字节数组
    * @param data - 输出字符数组
    *
    * @return 返回下一个未处理的数组下标
    */
    public func decode(src:Array<UInt8>, dest:Array<Char>): (Int64, Int64)
```

ISO2022日本字符集
class ISO2022JPCharset

```cangjie
    /**
    * ISO2022JPCharset 的无参构造器
    *
    */
    public init()
    
    /**
    * 新建一个编码器
    *
    * @return 返回编码器
    */
    public func newEncoder(): Encoder

    /**
    * 新建一个解码器
    *
    * @return 返回解码器
    */
    public func newDecoder():Decoder
```

EUC日本字符集

class EUCJPCharset

```cangjie
    /**
    * EUCJPCharset 的无参构造器
    *
    */
    public init()
    
    /**
    * 新建一个编码器
    *
    * @return 返回编码器
    */
    public func newEncoder(): Encoder

    /**
    * 新建一个解码器
    *
    * @return 返回解码器
    */
    public func newDecoder():Decoder
```

ShiftJIS日本字符集

class ShiftJISCharset

```cangjie
    /**
    * ShiftJISCharset 的无参构造器
    *
    */
    public init()
    
    /**
    * 新建一个编码器
    *
    * @return 返回编码器
    */
    public func newEncoder(): Encoder

    /**
    * 新建一个解码器
    *
    * @return 返回解码器
    */
    public func newDecoder():Decoder
```

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
```

EUC韩国字符集

class EUCKRCharset

```cangjie
    /**
    * EUCKRCharset 的无参构造器
    *
    */
    public init()
    
    /**
    * 新建一个编码器
    *
    * @return 返回编码器
    */
    public func newEncoder(): Encoder

    /**
    * 新建一个解码器
    *
    * @return 返回解码器
    */
    public func newDecoder():Decoder
```

top level

```cangjie
    /**
    * 新建一个 EUC 韩国字符集
    *
    * @return 返回一个字符集
    */
	public func newEUCKRCharset():Charset
```

EUC韩国编码类

class EUCKREncoder

```cangjie
    /**
    * 编码方法
    *
    * @param str - 传入一个 String 字符串
    *
    * @return 返回 UInt8 数组
    */
	public func encode(str:String): Array<UInt8>
```

EUC韩国解码类
class EUCKRDecoder

```cangjie
    /**
    * 解码字节数组到字符数组
    *
    * @param src - 输入字节数组
    * @param data - 输出字符数组
    *
    * @return 返回下一个未处理的数组下标
    */
    public func decode(src:Array<UInt8>, dest:Array<Char>): (Int64, Int64)
```

GBK字符集

class GBKCharset

```cangjie
    /**
    * GBKCharset 的无参构造器
    *
    */
    public init()
    
    /**
    * 新建一个编码器
    *
    * @return 返回编码器
    */
    public func newEncoder(): Encoder

    /**
    * 新建一个解码器
    *
    * @return 返回解码器
    */
    public func newDecoder():Decoder
```

GB18030字符集

class GB18030Charset

```cangjie
    /**
    * GB18030Charset 的无参构造器
    *
    */
    public init()
    
    /**
    * 新建一个编码器
    *
    * @return 返回编码器
    */
    public func newEncoder(): Encoder

    /**
    * 新建一个解码器
    *
    * @return 返回解码器
    */
    public func newDecoder():Decoder
```

top level

```cangjie
    /**
    * 选择创建 GBK 字符集还是 GB18030 字符集
    *
    * @param gbk - 传入一个 Bool 类型
    *
    * @return 返回一个字符集
    */
	public func newGB18030Charset(gbk: Bool): Charset
```

GB18030简体编码类

class GB18030Encoder

```cangjie
    /**
    * GB18030Encoder 的有参构造器
    *
    * @param gbk - 传入一个 Bool 类型
    */    
	public init(gbk: Bool)
	
    /**
    * 编码方法
    *
    * @param str - 传入一个 String 字符串
    *
    * @return 返回 UInt8 数组
    */
	public func encode(str:String): Array<UInt8>
```

GB18030Decoder简体解码类
class GB18030Decoder

```cangjie
    /**
    * 解码字节数组到字符数组
    *
    * @param src - 输入字节数组
    * @param data - 输出字符数组
    *
    * @return 返回下一个未处理的数组下标
    */
    public func decode(src:Array<UInt8>, dest:Array<Char>): (Int64, Int64)
```

SingleByte单字节字符集

class SingleByteCharset

```cangjie
    /**
    * SingleByteCharset 的有参构造器
    *
    * @param name - 传入一个 String 字符串
    *
    */
    public init(name: String)
    
    /**
    * 新建一个编码器
    *
    * @return 返回编码器
    */
    public func newEncoder(): Encoder

    /**
    * 新建一个解码器
    *
    * @return 返回解码器
    */
    public func newDecoder():Decoder
```

top level

```cangjie
    /**
    * 选择创建不同类型的单字节编码集
    *
    * @param name - 传入一个 String 类型
    *
    * @return 返回一个字符集
    */
	public func newSingleByteCharset(name: String): Charset
```

SingleByteEncoder单字节编码类

class SingleByteEncoder

```cangjie
    /**
    * 编码方法
    *
    * @param str - 传入一个 String 字符串
    *
    * @return 返回 UInt8 数组
    */
	public func encode(str:String): Array<UInt8>
```

SingleByteDecoder单字节解码类
class SingleByteDecoder

```cangjie
    /**
    * 解码字节数组到字符数组
    *
    * @param src - 输入字节数组
    * @param data - 输出字符数组
    *
    * @return 返回下一个未处理的数组下标
    */
    public func decode(src:Array<UInt8>, dest:Array<Char>): (Int64, Int64)
```

BIG5HKSCSCharset字符集

class BIG5HKSCSCharset

```cangjie
    /**
    * BIG5HKSCSCharset 的无参构造器
    *
    */
    public init()
    
    /**
    * 新建一个编码器
    *
    * @return 返回编码器
    */
    public func newEncoder(): Encoder

    /**
    * 新建一个解码器
    *
    * @return 返回解码器
    */
    public func newDecoder():Decoder
```

top level

```cangjie
    /**
    * 选择创建 BIG5 字符集还是 BIG5HKSCS 字符集
    *
    * @param hkscs - 传入一个 Bool 类型
    *
    * @return 返回一个字符集
    */
	public func newBIG5Charset(hkscs:Bool): Charset
```

BIG5Charset字符集

class BIG5Charset

```cangjie
    /**
    * BIG5Charset 的无参构造器
    *
    */
    public init()
    
    /**
    * 新建一个编码器
    *
    * @return 返回编码器
    */
    public func newEncoder(): Encoder

    /**
    * 新建一个解码器
    *
    * @return 返回解码器
    */
    public func newDecoder():Decoder
```

BIG5Encoder编码类

class BIG5Encoder

```cangjie
	/**
    * SingleByteEncoder 的有参构造器
    *
    * @param hkscs - 传入一个 Bool 类型
    */    
    public init(hkscs:Bool)

	/**
    * 编码方法
    *
    * @param str - 传入一个 String 字符串
    *
    * @return 返回 UInt8 数组
    */
	public func encode(str:String): Array<UInt8>
```

BIG5Decoder解码类
class BIG5Decoder

```cangjie
    /**
    * 解码字节数组到字符数组
    *
    * @param src - 输入字节数组
    * @param data - 输出字符数组
    *
    * @return 返回下一个未处理的数组下标
    */
    public func decode(src:Array<UInt8>, dest:Array<Char>): (Int64, Int64)
```

UTF8Charset字符集

class UTF8Charset

```cangjie
    /**
    * UTF8Charset 的无参构造器
    *
    */
    public init()
    
    /**
    * 新建一个编码器
    *
    * @return 返回编码器
    */
    public func newEncoder(): Encoder

    /**
    * 新建一个解码器
    *
    * @return 返回解码器
    */
    public func newDecoder():Decoder
```

UTF8Encoder编码类

class UTF8Encoder

```cangjie
	/**
    * 编码方法
    *
    * @param str - 传入一个 String 字符串
    *
    * @return 返回 UInt8 数组
    */
	public func encode(str:String): Array<UInt8>
```

UTF8Decoder解码类
class UTF8Decoder

```cangjie
    /**
    * 解码字节数组到字符数组
    *
    * @param src - 输入字节数组
    * @param data - 输出字符数组
    *
    * @return 返回下一个未处理的数组下标
    */
    public func decode(src:Array<UInt8>, dest:Array<Char>): (Int64, Int64)
```

top level

```cangjie
  	/**
    * 创建 UTF8 字符集
    *
    * @return 返回一个字符集
    */
	public func newUTF8Charset():Charset
```

UTF16Charset字符集

class UTF16Charset

```cangjie
    /**
    * UTF16Charset 的无参构造器
    *
    * @param be - 传入一个 Bool 类型
    *
    */
    public init(be: Bool)
    
    /**
    * 新建一个编码器
    *
    * @return 返回编码器
    */
    public func newEncoder(): Encoder

    /**
    * 新建一个解码器
    *
    * @return 返回解码器
    */
    public func newDecoder():Decoder
```

UTF16Encoder编码类

class UTF16Encoder

```cangjie
	/**
    * 编码方法
    *
    * @param str - 传入一个 String 字符串
    *
    * @return 返回 UInt8 数组
    */
	public func encode(str:String): Array<UInt8>
```

UTF16Decoder解码类
class UTF16Decoder

```cangjie
    /**
    * 解码字节数组到字符数组
    *
    * @param src - 输入字节数组
    * @param data - 输出字符数组
    *
    * @return 返回下一个未处理的数组下标
    */
    public func decode(src:Array<UInt8>, dest:Array<Char>): (Int64, Int64)
```

top level

```cangjie
  	/**
    * 选择创建 UTF-16BE 字符集还是 UTF-16LE 字符集
    *
    * @param be - 传入一个 Bool 类型
    *
    * @return 返回一个字符集
    */
	public func newUTF16Charset(be:Bool):Charset
```

UTF32Charset字符集

class UTF32Charset

```cangjie
    /**
    * UTF32Charset 的无参构造器
    *
    * @param be - 传入一个 Bool 类型
    *
    */
    public init(be: Bool)
    
    /**
    * 新建一个编码器
    *
    * @return 返回编码器
    */
    public func newEncoder(): Encoder

    /**
    * 新建一个解码器
    *
    * @return 返回解码器
    */
    public func newDecoder():Decoder
```

UTF32Encoder编码类

class UTF32Encoder

```cangjie
	/**
    * 编码方法
    *
    * @param str - 传入一个 String 字符串
    *
    * @return 返回 UInt8 数组
    */
	public func encode(str:String): Array<UInt8>
```

UTF32Decoder解码类
class UTF32Decoder

```cangjie
    /**
    * 解码字节数组到字符数组
    *
    * @param src - 输入字节数组
    * @param data - 输出字符数组
    *
    * @return 返回下一个未处理的数组下标
    */
    public func decode(src:Array<UInt8>, dest:Array<Char>): (Int64, Int64)
```

top level

```cangjie
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

字符集抽象类

abstract class Charset

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

abstract class Charset

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

