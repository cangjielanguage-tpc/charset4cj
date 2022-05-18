// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.korean.*
from charset import charset.simplechinese.*

main (){
    var charset = GB18030Charset()
    var euckrDncoder = charset.newEncoder()
    var src = "hfkjwefkjashekfh"

    var s1 = euckrDncoder.encode(src)
    return 0
}