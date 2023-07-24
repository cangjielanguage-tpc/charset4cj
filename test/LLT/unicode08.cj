// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.unicode.*

main (){
    var utf8 = Charsets.UTF8
    var encoder = utf8.newEncoder()
    var str1: String = "h"
    encoder.encode(str1)
    return 0
}
