// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*

main (){
    var charset = Charsets.big5
    var decoder = charset.newDecoder()
    var buf1 = Array<UInt8>([0xB0, 0xDA, 0xA7, 0x41, 0xB6])
    var buf2 = Array<UInt8>([65, 66, 67, 65, 66, 67, 89])
    var s1 = decoder.decode(buf1)
    var s2 = decoder.decode(buf2)
    if (!s1.equals("碉峴")) {
        return 1
    }
    if (!s2.equals("ABCABCY")) {
        return 2
    }
    return 0
}