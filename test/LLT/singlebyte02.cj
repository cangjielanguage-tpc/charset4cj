// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.korean.*
from charset import charset.singlebyte.*

main (){

    var charset = SingleByteCharset("ISO-8859-6")
    var charname = charset.newEncoder()
    var src: String = "ISO-8859-8"
    var s1 = charname.encode(src)
    return 0
}