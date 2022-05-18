// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.korean.*
from charset import charset.encoding.*

main (){

    var charset = EUCKRCharset()
    var euckrEncoder = charset.newEncoder()
    var buf1: String = "adafdsa"
    var s1 = euckrEncoder.encode(buf1)
    if (!s1.isEmpty()) {
        return 1
    }
    return 0
}