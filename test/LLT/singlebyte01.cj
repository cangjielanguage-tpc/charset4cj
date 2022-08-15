// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*

main (){
    var charset = Charsets.ibm866
    var decoder = charset.newDecoder()
    var encoder = charset.newEncoder()
    var s1 = "АГЦмт"
    var arr = encoder.encode(s1)
    var s2 = decoder.decode(arr)
    if(s1 != s2){
        return 1
    }
    return 0
}