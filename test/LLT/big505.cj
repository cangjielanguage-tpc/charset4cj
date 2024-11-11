// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
import charset4cj.charset.*
import charset4cj.charset.traditionchinese.*

main (){
    var big5 = Charsets.BIG5
    big5.newDecoder()
    var _: Array<UInt8> = [0xFE, 0xDA, 0xA7, 0x41, 0xB6]
    var _: Int64 = 0
    var _: Int64 = 4
    var _: Array<Rune> = Array<Rune>(6, {_ => r'\u{0}'})
    var _: Int64 = 2
    return 0
}
