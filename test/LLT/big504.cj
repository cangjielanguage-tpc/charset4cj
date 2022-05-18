// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.korean.*
from charset import charset.traditionchinese.*

main (){
    var big5 = BIG5Charset()
    var encoder = big5.newDecoder()
    var src: Array<UInt8> = Array<UInt8>([0xB0, 0xDA, 0xA7, 0x41, 0xB6])
    var srcOffset: Int64 = 0
    var srcLimit: Int64 = 4
    var dest: Array<Char> = Array<Char>(6, {i => '\u{0}'})
    var destUnusedOffset: Int64 = 2
    var s1 = encoder.decode(src, srcOffset, srcLimit, dest, destUnusedOffset)
    return 0
}