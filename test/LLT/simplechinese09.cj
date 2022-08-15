// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*

main() {
    var charset = Charsets.gb18030
    var decoder = charset.newDecoder()
    var encoder = charset.newEncoder() 
    var src: Array<UInt8> = Array<UInt8>([0xCB, 0xAE, 0xB5, 0xE7, 0xB7, 0xD1])
    var destStr = decoder.decode(src)    
    if(destStr == "水电费"){
        return 0
    }else{
        return 1
    }
}
