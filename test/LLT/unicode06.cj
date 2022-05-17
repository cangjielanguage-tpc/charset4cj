// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.unicode.*

main (){
    var charset = Charsets.utf8
    var decoder = charset.newDecoder()
    var encoder = charset.newEncoder()
    var str1: String = "你好我𬌗𬌗𬌗𬌗𬌗"
    var s1 = encoder.encode(str1)
    var src: Array<UInt8> = Array<UInt8>([0xB0, 0xDA, 0xA7, 0x41, 0xB6])
    var srcOffset: Int64 = 2
    var srcLimit: Int64 = 3
    var dest: Array<Char> = Array<Char>(6, {i => '\u{0}'})
    var destUnusedOffset: Int64 = 4
    var s2 = decoder.decode(src, srcOffset, srcLimit, dest, destUnusedOffset)
    println(s1.size())
    if (s1.size() != 29) {
        return 1
    }
    return 0
}