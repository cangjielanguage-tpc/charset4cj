// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.unicode.*

main (){
    var charset = Charsets.utf32be
    var encoder =charset.newEncoder()
    var decoder = charset.newDecoder()
    var str1: String = "你好我𬌗𬌗𬌗𬌗𬌗"
    var str2: String = "欢迎你的到来"
    var s1 = encoder.encode(str1)
    var s2 = encoder.encode(str2)
    if (s1.size != 32) {
        return 1
    }
    if (s2.size != 24) {
        return 2
    }
    return 0
}