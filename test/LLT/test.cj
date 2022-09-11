// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*

main (){
    var charset = Charsets.BIG5
    var encoder = charset.newEncoder()
    var decoder = charset.newDecoder()
    var s1 = "碉峴"
    var arr = encoder.encode(s1)
    var s2 = decoder.decode(arr)
    if (s1 != s2) {
        return 1
    }
    return 0
}