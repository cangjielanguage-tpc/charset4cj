// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.unicode.*

main (){
    var charset = Charsets.utf16be
    var encoder =charset.newEncoder()
    var decoder = charset.newDecoder()
    var str1: String = "你好我"
    var s1 = encoder.encode(str1)
    if (s1.size != 6) {
        return 1
    }
    return 0
}