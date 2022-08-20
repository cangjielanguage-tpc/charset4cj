// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.unicode.*

main (){
    var charset = UTF16Charset(false)
    var encoder =charset.newEncoder()
    var decoder = charset.newDecoder()
    var src: Array<UInt8> = Array<UInt8>([0x84, 0x36, 0x81, 0x42, 0x32, 0x32, 0x32])
    var srcOffset: Int64 = 2
    var srcLimit: Int64 = 4
    var dest: Array<Char> = Array<Char>(6, {i => '\u{0}'})
    var destStart: Int64 = 2
    var s2 = decoder.decode(src, srcOffset, srcLimit, dest, destStart)
    
    return 0
}
