// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*

main (){
    var charset = Charsets.BIG5
    var decoder = charset.newDecoder()
    var buf1 = Array<UInt8>([65, 57, 88, 95,86])
    var s1 = decoder.decode(buf1)
	println(s1)
    if (s1 != "A9X_V") {
        return 1
    }
    return 0
}
