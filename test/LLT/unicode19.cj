// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.unicode.*

main (){
    var charset = Charsets.UTF8
    charset.newDecoder()
    charset.newEncoder()
    var _: Array<UInt8> = Array<UInt8>([0xeb, 0xC3, 0xC3, 0x42, 0x32, 0x32, 0x32])
    var _: Int64 = 0
    var _: Int64 = 1
    var _: Array<Char> = Array<Char>(6, {_ => '\u{0}'})
    var _: Int64 = 4
    return 0
}
