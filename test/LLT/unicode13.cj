// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.unicode.*

main (){
    var charset = UTF16Charset(false)
    var encoder = charset.newEncoder()
    var decoder = charset.newDecoder()
    var str1: String = "你好我个"
    var s1 = encoder.encode(str1)
    var str2: String = ""
    var s2 = encoder.encode(str2)
    return 0
}