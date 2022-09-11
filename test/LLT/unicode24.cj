// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.unicode.*

main (){
    var charset = Charsets.UTF8
    var decoder = charset.newDecoder()
    var encoder = charset.newEncoder()
    var src: Array<UInt8> = Array<UInt8>([0xfa, 0xc3])
    var srcOffset: Int64 = 0
    var srcLimit: Int64 = 1
    var dest: Array<Char> = Array<Char>(6, {i => '\u{0}'})
    var destStart: Int64 = 4
    return 0
}