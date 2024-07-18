// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
import charset4cj.charset.*
import charset4cj.charset.unicode.*

main (){
    var charset = Charsets.UTF16BE
    var encoder = charset.newEncoder()
    charset.newDecoder()
    var str1: String = "你好我"
    var s1 = encoder.encode(str1)
    if (s1.size != 6) {
        return 1
    }
    return 0
}
