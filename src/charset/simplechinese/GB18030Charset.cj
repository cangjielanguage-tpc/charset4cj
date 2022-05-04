package charset.simplechinese

import charset.encoding.*


public class GB18030Charset <: Charset{
    public init(){
        // 实际字符数量 gb18030 > gbk > gb2312 ， 为了方便处理，将 gb2312, gbk 都当做 gb18030
        // super("gb18030", ["gb18030", "chinese", "csgb2312", "csiso58gb231280", "gb2312", "gb_2312", "gb_2312-80", "gbk", "iso-ir-58", "x-gbk"])
        this.name = "gb18030"
        this.labels = ["gb18030", "chinese", "csgb2312", "csiso58gb231280", "gb2312", "gb_2312", "gb_2312-80", "gbk", "iso-ir-58", "x-gbk"]
    }
    public func newEncoder():Encoder{
        var encoder = GB18030Encoder()
        return encoder
    }
    public func newDecoder():Decoder{
        var decoder = GB18030Decoder()
        return decoder
    }
}