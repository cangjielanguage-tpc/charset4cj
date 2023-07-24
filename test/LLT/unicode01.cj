// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.unicode.*

main (){
    var utf8 = Charsets.UTF8
    var encoder = utf8.newEncoder()
    utf8.newDecoder()
    var str1: String = "啊𬌗𬌗𬌗𬌗𬌗𬌗𬌗𬌗"
    var str2: String = ""
    var s1 = encoder.encode(str1)
    encoder.encode(str2)
    if (s1.size != 35) {
        return 1
    }
    return 0
}
