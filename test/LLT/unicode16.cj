// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.unicode.*

main (){
    var charset = Charsets.UTF8
    charset.newDecoder()
    var encoder = charset.newEncoder()
    var src1: Array<Char> = Array<Char>([Char(128),Char(129),Char(130),Char(131)])
    var str1 :String = String(src1)
    encoder.encode(str1)
    return 0
}
