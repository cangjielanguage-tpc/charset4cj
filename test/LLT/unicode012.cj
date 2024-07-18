// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
import charset4cj.charset.*
import charset4cj.charset.unicode.*

main (){
    var utf8 = Charsets.UTF8
    utf8.newDecoder()
    var _: Array<UInt8> = Array<UInt8>([0xF8, 0xDA, 0xA7, 0x41, 0xB6])
    var _: Int64 = 3
    var _: Int64 = 4
    var _: Array<Rune> = Array<Rune>(6, {_ => r'\u{0}'})
    var _: Int64 = 2
    return 0
}
