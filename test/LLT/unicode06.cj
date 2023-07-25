// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.unicode.*

main (){
    var charset = Charsets.UTF8
    charset.newDecoder()
    var encoder = charset.newEncoder()
    var str1: String = "你好我𬌗𬌗𬌗𬌗𬌗"
    var s1 = encoder.encode(str1)
    var _: Array<UInt8> = Array<UInt8>([0x00,0x02,0xc3,0x17])
    var _: Int64 = 2
    var _: Int64 = 3
    var _: Array<Char> = Array<Char>(6, {_ => '\u{0}'})
    var _: Int64 = 4
    println(s1.size)
    if (s1.size != 29) {
        return 1
    }
    return 0
}
