// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.simplechinese.*

main (){
    var charset = Charsets.gb18030
    var euckrEncoder = charset.newEncoder()
    var src1 = "hfkjwefkjashekfh"
    var s1 = euckrEncoder.encode(src1)
    var euckrDncoder = charset.newDecoder()
    var src: Array<UInt8> = Array<UInt8>([0x80, 0x80, 0x80, 0x80, 0x80])
    var srcOffset: Int64 = 0
    var srcLimit: Int64 = 2
    var dest: Array<Char> = Array<Char>(6, {i => '\u{0}'})
    var destStart: Int64 = 2
    var s2 = euckrDncoder.decode(src, srcOffset, srcLimit, dest, destStart)
    return 0
}