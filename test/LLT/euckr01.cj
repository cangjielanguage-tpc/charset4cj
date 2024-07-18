// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
import charset4cj.charset.*

main (){

    var charset = Charsets.EUCKR
    var euckrEncoder = charset.newEncoder()
    var euckrDecoder = charset.newDecoder()
    // 0xAC34	갴
    // 0xC989	즉
    // 0x9438	鐸
    var s1: String = "갴즉鐸"
    var arr = euckrEncoder.encode(s1)
    for(a in arr){
        print("${a}")
    }
    var s2 = euckrDecoder.decode(arr)
    if(s1 == s2){
        return 0
    }else{
        return 1
    }
}
