// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*

main (){
    var charset = Charsets.BIG5
    var decoder = charset.newDecoder()
    var buf1 = Array<UInt8>([0xB8, 0x4D, 0xAE, 0x73, 0xB6])
    var buf2 = Array<UInt8>([65, 66, 67, 65, 66, 67, 89])
    var s1 = decoder.decode(buf1)
    var s2 = decoder.decode(buf2)
    if (s1 != "碉峴") {
        return 1
    }
    if (s2 != "ABCABCY") {
        return 2
    }
    return 0
}
