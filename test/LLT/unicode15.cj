// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.unicode.*

main (){
    var charset = Charsets.UTF16LE
    charset.newEncoder()
    charset.newDecoder()
    var _ : Array<UInt8> = Array<UInt8>([0x84, 0x36, 0x81, 0x42, 0x32, 0x32, 0x32])
    var _: Int64 = 2
    var _: Int64 = 4
    var _: Array<Char> = Array<Char>(6, {_ => '\u{0}'})
    var _: Int64 = 2
    return 0
}
