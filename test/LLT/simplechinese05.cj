// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.simplechinese.*

main (){
    var charset = Charsets.gb18030
    var euckrDncoder = charset.newDecoder()
    var src: Array<UInt8> = Array<UInt8>([0x81, 0x31, 0x31, 0x30, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32])
    var srcOffset: Int64 = 1
    var srcLimit: Int64 = 1
    var dest: Array<Char> = Array<Char>(6, {i => '\u{0}'})
    var destStart: Int64 = 2
    return 0
}