// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.unicode.*

main (){
    var charset = Charsets.UTF32BE
    charset.newEncoder()
    var decoder = charset.newDecoder()
    var src: Array<UInt8> = Array<UInt8>([0x00,0x02,0xc3,0x17])
    var _: Int64 = 0
    var _: Int64 = 4
    var dest: Array<Char> = Array<Char>(6, {_ => '\u{0}'})
    var destStart: Int64 = 0
    var s1 = decoder.decode(src, dest)
    var destStr:String = "𬌗"
    if(destStr == "𬌗"){
        return 0
    } else{
        return 1
    }
}
