// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
import charset4cj.charset.*
import charset4cj.charset.unicode.*

main (){
    var charset = Charsets.UTF8
    charset.newDecoder()
    var encoder = charset.newEncoder()
    var src1: Array<Rune> = Array<Rune>([Rune(128),Rune(129),Rune(130),Rune(131)])
    var str1 :String = String(src1)
    encoder.encode(str1)
    return 0
}
