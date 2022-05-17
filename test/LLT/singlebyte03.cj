// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.korean.*
from charset import charset.singlebyte.*

main (){

    var charset = SingleByteCharset("IBM866")
    var charset4 = SingleByteCharset("ISO-8859-6")
    var charnamee = charset4.newEncoder()
    var src1: String = "ISO-8859-8"
    var s1 = charnamee.encode(src1)
    var charname = charset.newDecoder()
    var src: Array<UInt8> = Array<UInt8>([0xB0, 0xDA, 0xA7, 0x41, 0xB6])
    var srcOffset: Int64 = 1
    var srcLimit: Int64 = 4
    var dest: Array<Char> = Array<Char>(6, {i => '\u{0}'})
    var destUnusedOffset: Int64 = 2
    var s2 = charname.decode(src, srcOffset, srcLimit, dest, destUnusedOffset)
    return 0
}