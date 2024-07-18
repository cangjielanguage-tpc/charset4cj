// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
import charset4cj.charset.*
import charset4cj.charset.simplechinese.*

main (){
    var charset = Charsets.GB18030
    var euckrEncoder = charset.newEncoder()
    var src1 = "hfkjwefkjashekfh"
    euckrEncoder.encode(src1)
    charset.newDecoder()
    var _: Array<UInt8> = Array<UInt8>([0x80, 0x80, 0x80, 0x80, 0x80])
    var _: Int64 = 0
    var _: Int64 = 2
    var _: Array<Rune> = Array<Rune>(6, {_ => r'\u{0}'})
    var _: Int64 = 2
    return 0
}
