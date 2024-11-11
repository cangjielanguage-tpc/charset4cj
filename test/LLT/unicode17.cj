// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
import charset4cj.charset.*
import charset4cj.charset.unicode.*

main (){
    var charset = Charsets.UTF8
    charset.newDecoder()
    charset.newEncoder()
    var _: Array<UInt8> = [0x84, 0xC3, 0x81, 0x42, 0x32, 0x32, 0x32]
    var _: Int64 = 0
    var _: Int64 = 3
    var _: Array<Rune> = Array<Rune>(6, {_ => r'\u{0}'})
    var _: Int64 = 4
    return 0
}
