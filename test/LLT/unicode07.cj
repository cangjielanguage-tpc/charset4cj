// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*
from charset import charset.unicode.*

main (){
    var charset = UTF32Charset(true)
    var encoder =charset.newEncoder()
    var decoder = charset.newDecoder()
    var str2: String = "欢迎你的到来"
    var src: Array<UInt8> = Array<UInt8>([0x00,0x02,0xc3,0x17])
    var srcOffset: Int64 = 0
    var srcLimit: Int64 = 4
    var dest: Array<Char> = Array<Char>(6, {i => '\u{0}'})
    var destStart: Int64 = 0
    var s1 = decoder.decode(src, srcOffset, srcLimit, dest, destStart)
    var destStr:String = String(dest, start:destStart, length:(s1[1] - destStart))
    if(destStr == "𬌗"){
        return 0
    }else{
        return 1
    }
    return 0
}