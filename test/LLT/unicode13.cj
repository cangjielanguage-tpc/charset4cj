// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
import charset4cj.charset.*
import charset4cj.charset.unicode.*

main (){
    var charset = Charsets.UTF16LE
    var encoder = charset.newEncoder()
    charset.newDecoder()
    var str1: String = "你好我个"
    encoder.encode(str1)
    var str2: String = ""
    encoder.encode(str2)
    return 0
}
