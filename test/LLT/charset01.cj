// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.encoding.*
from charset import charset.*
from charset import charset.simplechinese.*
public class Charse <: Charset{
    public init(src:String){
    super.name = src
    }
     public func newEncoder():Encoder {
        let encoder = GB18030Encoder()
        return encoder
     }
     public func newDecoder():Decoder {
        let encoder = GB18030Decoder()
        return encoder
     }
}
main (){
    var charset = Charse("你好")
    var src = "你好"
    var decoder = charset.nameEquals(src)
    println(decoder)
    return 0
}