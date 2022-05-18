// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*

main (){
    var charset = Charsets.big5
    var encoder = charset.newEncoder()
    var decoder = charset.newDecoder()
    var buf1 = Array<UInt8>([0xB0, 0xDA, 0xA7, 0x41])
    var s1 = decoder.decode(buf1)
    if (!s1.equals("碉峴")) {
        return 1
    }
    println(s1)
    return 0
}