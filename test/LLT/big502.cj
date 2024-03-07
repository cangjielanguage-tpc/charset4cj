// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.traditionchinese.*

main (){
    var big5 = Charsets.BIG5
    var encoder = big5.newDecoder()
    var src: Array<UInt8> = Array<UInt8>([0xA4, 0xF4, 0xB9, 0x71, 0xB6, 0x4F])
    var s1 = encoder.decode(src)
    if(s1 != "水電費"){
        return 1
    }
    return 0
}
