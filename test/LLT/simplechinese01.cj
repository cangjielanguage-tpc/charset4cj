// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.simplechinese.*

main (){
    var charset = Charsets.gb18030
    var euckrDncoder = charset.newEncoder()
    var src = "hfkjwefkjashekfh"

    var s1 = euckrDncoder.encode(src)
    return 0
}