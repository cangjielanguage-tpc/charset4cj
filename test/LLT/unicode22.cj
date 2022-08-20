// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.unicode.*

main (){
    var charset = Charsets.utf8
    var decoder = charset.newDecoder()
    var encoder = charset.newEncoder()
    var src: Array<UInt8> = Array<UInt8>([0xf2, 0xb4, 0xb4, 0xb4, 0x32, 0x32, 0x32])
    var srcOffset: Int64 = 0
    var srcLimit: Int64 = 4
    var dest: Array<Char> = Array<Char>(6, {i => '\u{0}'})
    var destStart: Int64 = 4
    var s2 = decoder.decode(src, srcOffset, srcLimit, dest, destStart)
    return 0
}