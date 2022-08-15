// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*

main (){

    var charset = Charsets.iso_8859_14
    var decoder = charset.newDecoder()
    var encoder = charset.newEncoder()
    var s1 = "ÅÊÍŴêô"
    var arr = encoder.encode(s1)
    var s2 = decoder.decode(arr)
    println("s2:${s2}")
    if(s1 != s2){
        return 1
    }
    return 0
}