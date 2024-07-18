// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
import charset4cj.charset.*
import charset4cj.charset.unicode.*

main (){
    var charset = Charsets.UTF16BE
    var encoder =charset.newEncoder()
    charset.newDecoder()
    var str1: String = "你好我𬌗𬌗𬌗𬌗𬌗"
    var s1 = encoder.encode(str1)
    var _: Array<UInt8> = Array<UInt8>([0xB0, 0xDA, 0xA7, 0x41, 0xB6])
    var _: Int64 = 1
    var _: Int64 = 4
    var _: Array<Rune> = Array<Rune>(6, {_ => r'\u{0}'})
    var _: Int64 = 2
    if (s1.size != 26) {
        return 1
    }
    return 0
}
