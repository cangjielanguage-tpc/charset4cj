// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.korean.*
from charset import charset.traditionchinese.*

main (){
    var big5 = BIG5Charset()
    var encoder = big5.newEncoder()
    var str: String = "ewqerf"
    var s1 = encoder.encode(str)
    return 0
}