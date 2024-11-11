// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
import charset4cj.charset.*
import charset4cj.charset.unicode.*

main (){
    var charset = Charsets.UTF16LE
    charset.newEncoder()
    charset.newDecoder()
    var _ : Array<UInt8> = [0x84, 0x36, 0x81, 0x42, 0x32, 0x32, 0x32]
    var _: Int64 = 2
    var _: Int64 = 4
    var _: Array<Rune> = Array<Rune>(6, {_ => r'\u{0}'})
    var _: Int64 = 2
    return 0
}
