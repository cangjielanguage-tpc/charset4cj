# encoding

#### 介绍
仓颉语言编解码库。基于 [WHATWG 字符编码标准](http://encoding.spec.whatwg.org/) 

#### 这个库有什么用
解码器提供了下面两个方法，能够将字节数组转成String对象
```
func decode(src:Array<UInt8>):String
func decode(src:Array<UInt8>, srcOffset:Int64, srcLimit:Int64, 
            dest:Array<Char>, destUnusedOffset:Int64): Int64 * Int64
```
io流（包含文件流、网络流）读取的都是字节数组，要将字节数组转成String,就需要上面2个方法。每种字符集的解码方法各不相同

要将String写入到io流，需要将String转成字节数组，此时就需要编码器
编码器提供了编码方法，能否将String转成字节数组
```
func encode(str:String): Array<UInt8>
```






### 字符集分类
1. unicode。 仓颉的String是Char数组，一个Char是32位，表示一个unicode代码点。仓颉的String转utf8,utf16le, utf16be,utf32都可以通过计算得到编码
2. 简体中文，如gbk, 无法通过计算与unicode互相转化，需要维护一个gbk代码点与unicode代码点映射表，通过查表方式去转化
3. 繁体中文，big5, 无法通过计算与unicode互相转化，需要维护一个big5代码点与unicode代码点映射表，通过查表方式去转化
4. 韩语，EUC-KR， 需要映射表
5. 日语，需要映射表
6. 阿拉伯语，拉丁语等等这些字符数量少于256，一个字节就能保存下来的字符集。这些字符集有个特点，代码点小于128的与ascii相同，无需转码。128~256的字符转码unicode需要查表


#### 项目代码简介
* generate 目录下存放的是代码生成器，用来生成映射表
* encoding 目录存放的是编解码库文件
```
charset
├── Charsets.cj		// 常量类，提供forName方法根据字符集名称获取字符集类型，并提供所有支持的字符集常量
├── encoding		// 字符集接口
│   ├── Charset.cj
│   ├── Decoder.cj
│   └── Encoder.cj
├── korean			// 韩语字符集编解码实现
│   ├── EUC_KR_mapping.cj
│   └── euckr.cj
├── simplechinese	// 简体中文字符集编解码实现
│   ├── GB18030Charset.cj
│   ├── GB18030Decoder.cj
│   ├── GB18030Encoder.cj
│   ├── gb18030_mapping.cj
│   └── gb18030_ranges_mapping.cj
├── singlebyte		// 西欧、阿拉伯单字节字符集编解码实现
│   ├── SingleByteCharset.cj
│   ├── SingleByteDecoder.cj
│   ├── SingleByteEncoder.cj
│   ├── ibm866_mapping.cj
│   ├── iso_8859_10_mapping.cj
│   ├── ......
│   └── x_mac_cyrillic_mapping.cj
├── traditionchinese	// 繁体中文字符集编解码实现
│   ├── big5.cj
│   └── big5_mapping.cj
└── unicode				// unicode 编解码实现
    └── utf8.cj
```


#### 编解码原理
1. 解码，是指将传统字符集的字节数组转成Unicode代码点数组，比如gb18030解码的意思是把gb18030编码的 字节数组转成 unicode code point 数组

gb18030解码原则：

小于等于0x7F的，直接将字节返回， gb18030 小于等于0x7F的是和ascii码相同的，与unicode代码点数值相同

对于双字节编码，编码范围8140－FEFE。 gb18030 字符编码 与 unicode编码的转换是需要一个映射表来查询的

这个映射关系在 [WHATWG 标准的index-gb18030.txt](https://encoding.spec.whatwg.org/index-gb18030.txt) 文件中

文件内容节选， 第一列是下标，第二列是unicode代码点
```
    0	0x4E02	丂 (<CJK Ideograph>)
    1	0x4E04	丄 (<CJK Ideograph>)
    2	0x4E05	丅 (<CJK Ideograph>)
    3	0x4E06	丆 (<CJK Ideograph>)
    4	0x4E0F	丏 (<CJK Ideograph>)
    5	0x4E12	丒 (<CJK Ideograph>)
    6	0x4E17	丗 (<CJK Ideograph>)
    ......
```

我们根据这个文件，生成一个数组，数组的下标是 [WHATWG 标准的index-gb18030.txt文件中](https://encoding.spec.whatwg.org/index-gb18030.txt) 文件的第一列，下标对应的值是unicode代码点
```
	var gb18030DecodeMapping:Array<UInt32> = [
		0X4E02,
		0X4E04,
		0X4E05,
		0X4E06,
		0X4E0F,
		0X4E12,
		0X4E17,
		...
	]    
```

gb18030双字节编码范围是 8140－FEFE, "丂" 这个字符 gb18030 编码后的字节数组是 [0x81, 0x40]

解码时计算 index = (第一个字节 - 0x81)  << 8 + (第二个字节 - 0x40), 得到的值是 0

unicode代码点 = gb18030DecodeMapping[index] 得到的值是 0x4E02

对于字符串 “丂丄丅丆”，它的gb18030编码的字节数组是[0x81, 0x40, 0x81, 0x41, 0x81, 0x42, 0x81, 0x43]

按照上面的规则，解码后得到的unicode代码点数组是[0X4E02, 0X4E04, 0X4E05, 0X4E06]

附注：
```
gbk字符集第二个字节的的范围是[0x40, 0x7E],[0x80, 0xFE]，中间少了0x7F。
故计算index的时候，需要考虑到这一特殊情况，故完整的index计算方法是：

if(第二个字节 < 0x7F){
    index = (第一个字节 - 0x81) << 8 + (第二个字节 - 0x40)
}else(第二个字节 > 0x7F){
    index = (第一个字节 - 0x81) << 8 + (第二个字节 - 0x41)
}
```

2. 编码，是指将unicode 代码点数组转成 字符集的 字节数组，比如gb18030编码的意思是把unicode代码点数组编码成 gb18030字符集的 字节数组

编码是解码的逆向操作，反查映射表就能做到。但是由于字符集对应的unicode代码点是分散的，并不是顺序的，故无法直接构造一个按照下标顺序获取编码的表

有3种解决方法：

（1） 构造一个map, map的key 是 unicode代码点，value 是 要编码的字符集的 代码点。对于要编码的unicode代码点，直接通过map.get就能得到字符集编码。但是map的速度显然没有数组下标访问快

（2） 用空间换时间，普通字符集对应的unicode代码点小于0xFFFF。 可以创建大小为0xFFFF的数组，下标是unicode代码点，下标对应位置存储字符集的编码数值。这样做会有很多浪费，比如gbk编码，有 21886 多字符，如果创建一个 0xFFFF(65535)的数组，有一半以上是空闲的，可以进行分组去优化，对于unicode代码点分布比较稠密的范围，单独创建一个数组，这样创建好几个数组，将空闲范围剔除出去，可以节省大约一半的空间，这对gbk这样的字符集就可以接受了

（3） 空间换时间的策略对于字符数量比较多的字符集编码有优势，但是对于字符集少的，比如单字节字符集，只有最大256个字符，小于128的字符还与ascii是相同的，需要编码的只有最多128个字符，为了这128个字符去创建0xFFFF个数组，浪费太大了。这个时候可以使用 Double Array Trie 树进行优化，通过创建2个数组， 索引两次数组就能得到unicode代码点对应的字符集编码


### 接口


### 编译

```
cpm build

```

```
// 单元测试
cjc test/UT/charset_test.cj --test --import-path ./build  -L ./build/charset/ -l charsetcharset -l charsetcharset.encoding -l charsetcharset.traditionchinese -l charsetcharset.simplechinese -l charsetcharset.korean -l charsetcharset.singlebyte -l charsetcharset.unicode
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/work/charset/build/charset
./main
```


#### 使用指南
1. 只有两种方式获取字符集Charset
第一种是通过 Charsets 的常量获取，例如： Charsets.utf8 
第二种是通过 Charsets 的forName 方法获取， 比如 Charsets.forName("UTF-8")

2. 通过 Charset 创建编码解码器





### todo
- 使用仓颉重写 自动生成字符映射表代码
- 支持gbk ， gb2312，gb18030 的区分
- 支持 gb18030的编码
- 支持 big5 编解码
- 支持日韩字符集
- 增加bom支持
