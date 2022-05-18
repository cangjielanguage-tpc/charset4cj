// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.unicode.*

main (){
    var utf8 = UTF8Charset()
    var decoder = utf8.newDecoder()
    var src: Array<UInt8> = Array<UInt8>([0xF2, 0xDA, 0xA7, 0x41, 0xB6])
    var srcOffset: Int64 = 1
    var srcLimit: Int64 = 4
    var dest: Array<Char> = Array<Char>(6, {i => '\u{0}'})
    var destUnusedOffset: Int64 = 2
    var s2 = decoder.decode(src, srcOffset, srcLimit, dest, destUnusedOffset)
    return 0
}