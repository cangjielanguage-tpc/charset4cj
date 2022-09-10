// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.unicode.*

main (){
    var utf8 = Charsets.utf8
    var encoder = utf8.newEncoder()
    var decoder = utf8.newDecoder()
    var str1: String = "你好我"
    var s1 = encoder.encode(str1)
    var src: Array<UInt8> = Array<UInt8>([0xB0, 0xDA, 0xA7, 0x41, 0xB6])
    var srcOffset: Int64 = 1
    var srcLimit: Int64 = 4
    var dest: Array<Char> = Array<Char>(6, {i => '\u{0}'})
    var destStart: Int64 = 2
    if (s1.size != 9) {
        return 1
    }
    return 0
}