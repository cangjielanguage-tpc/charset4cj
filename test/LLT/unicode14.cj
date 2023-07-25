// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.unicode.*

main (){
    var charset = Charsets.UTF16BE
    charset.newEncoder()
    charset.newDecoder()
    var _: Array<UInt8> = Array<UInt8>([0xB0, 0xDA, 0xA7, 0x41, 0xB6])
    var _: Int64 = 4
    var _: Int64 = 4
    var _: Array<Char> = Array<Char>(6, {_ => '\u{0}'})
    var _: Int64 = 2
    
    return 0
}
