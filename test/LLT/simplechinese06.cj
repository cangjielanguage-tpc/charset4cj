// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.korean.*
from charset import charset.simplechinese.*

main (){
    var charset = GB18030Charset()
    var euckrDncoder = charset.newDecoder()
    var src: Array<UInt8> = Array<UInt8>([0x81, 0x36, 0x81, 0x37, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32])
    var srcOffset: Int64 = 0
    var srcLimit: Int64 = 6
    var dest: Array<Char> = Array<Char>(6, {i => '\u{0}'})
    var destStart: Int64 = 2
    var s2 = euckrDncoder.decode(src, srcOffset, srcLimit, dest, destStart)
    return 0
}