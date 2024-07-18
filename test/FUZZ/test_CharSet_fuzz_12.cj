//3rd_party_lib:charset4cj/build/charset

import fuzz.fuzz.*
import charset4cj.charset.*
import std.collection.*
import std.io.*

public func fuzzFunc_TextWriter_write(dp:DataProvider):Int32 {
    var temp=ByteArrayStream()
    var tw=TextWriter(temp)
    try{
        tw.write(dp.consumeString(1024))
    }catch(e:Exception){}
    return 0
}
main(){
    Fuzzer(fuzzFunc_TextWriter_write).startFuzz()
    0
}
