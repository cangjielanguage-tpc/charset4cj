// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.unicode.*

main (){
    var charset = UTF32Charset(true)
    var encoder =charset.newEncoder()
    var decoder = charset.newDecoder()
    var str2: String = "欢迎你的到来"
    var src: Array<UInt8> = Array<UInt8>([0xB0, 0xDA, 0xA7, 0x41, 0xB6])
    var srcOffset: Int64 = 1
    var srcLimit: Int64 = 4
    var dest: Array<Char> = Array<Char>(6, {i => '\u{0}'})
    var destUnusedOffset: Int64 = 2
    var s1 = decoder.decode(src, srcOffset, srcLimit, dest, destUnusedOffset)
    var s2 = encoder.encode(str2)
    return 0
}