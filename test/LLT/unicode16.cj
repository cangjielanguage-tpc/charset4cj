// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.unicode.*

main (){
    var charset = Charsets.utf8
    var decoder = charset.newDecoder()
    var encoder = charset.newEncoder()
    var src1: Array<Char> = Array<Char>([chr(128),chr(129),chr(130),chr(131)])
    var str1 :String = String(src1)
    var s1 = encoder.encode(str1)
    return 0
}