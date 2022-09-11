// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.simplechinese.*

main (){
    var charset = Charsets.GB18030
    var euckrEncoder = charset.newEncoder()
    var src1 = "hfkjwefkjashekfh"
    var s1 = euckrEncoder.encode(src1)
    var euckrDncoder = charset.newDecoder()
    var src: Array<UInt8> = Array<UInt8>([0xB0, 0xDA, 0xA7, 0x41, 0xB6])
    var srcOffset: Int64 = 1
    var srcLimit: Int64 = 4
    var dest: Array<Char> = Array<Char>(6, {i => '\u{0}'})
    var destStart: Int64 = 2
    return 0
}