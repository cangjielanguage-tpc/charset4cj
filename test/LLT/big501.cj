// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.traditionchinese.*

main (){
    var big5 = Charsets.big5
    var encoder = big5.newEncoder()
    var str: String = "ewqerf"
    var s1 = encoder.encode(str)
    return 0
}