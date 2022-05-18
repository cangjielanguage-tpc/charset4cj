// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.korean.*
from charset import charset.simplechinese.*

main (){
    var charset = GB18030Charset()
    var euckrEncoder = charset.newEncoder()
    var src1 = "hfkjwefkjashekfh"
    var s1 = euckrEncoder.encode(src1)
    var euckrDncoder = charset.newDecoder()
    var src: Array<UInt8> = Array<UInt8>([0x80, 0x80, 0x80, 0x80, 0x80])
    var srcOffset: Int64 = 0
    var srcLimit: Int64 = 2
    var dest: Array<Char> = Array<Char>(6, {i => '\u{0}'})
    var destUnusedOffset: Int64 = 2
    var s2 = euckrDncoder.decode(src, srcOffset, srcLimit, dest, destUnusedOffset)
    return 0
}