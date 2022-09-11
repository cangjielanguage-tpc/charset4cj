// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.unicode.*

main (){
    var utf8 = Charsets.UTF8
    var decoder = utf8.newDecoder()
    var src: Array<UInt8> = Array<UInt8>([0xF2, 0xDA, 0xA7, 0x41, 0xB6])
    var srcOffset: Int64 = 3
    var srcLimit: Int64 = 4
    var dest: Array<Char> = Array<Char>(6, {i => '\u{0}'})
    var destStart: Int64 = 2
    return 0
}