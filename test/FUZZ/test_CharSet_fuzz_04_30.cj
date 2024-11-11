//3rd_party_lib:charset4cj/build/charset

import fuzz.fuzz.*
import charset4cj.charset.*
import charset4cj.charset.singlebyte.*
import std.collection.*

public func fuzzFunc_Encoder_encode(dp:DataProvider):Int32 {
    var encoder=Charsets.WINDOWS_1250.newEncoder()
    try{
        encoder.encode(dp.consumeString(1024))
    }catch(e:Exception){}
    return 0
}
main(){
    Fuzzer(fuzzFunc_Encoder_encode).startFuzz()
    0
}
