// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
import charset4cj.charset.*
import charset4cj.charset.simplechinese.*

main (){
    var charset = match(Charsets.forName("gbk")){
        case Some(v)    => v
        case None       => Charsets.GBK
    }
    var encoder = charset.newEncoder()
    var src = "𠍁𠜎𠝹𠯿𠳓𡁵"
    var a1 = encoder.encode(src)
    var a2:Array<UInt8> = [0x3F,0x3F,0x3F,0x3F,0x3F,0x3F]
    for(i in 0..a1.size){
        if(a1[i] != a2[i]){
            return 1
        }
    }
    return 0
}
