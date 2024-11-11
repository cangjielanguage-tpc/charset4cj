//3rd_party_lib:charset4cj/build/charset

import fuzz.fuzz.*
import charset4cj.charset.*
import charset4cj.charset.singlebyte.*
import std.collection.*

public func fuzzFunc_Decoder_decode(dp:DataProvider):Int32 {
    var decoder=Charsets.ISO_8859_4.newDecoder()
    try{
        decoder.decode(dp.consumeUInt8s(1024))
    }catch(e:Exception){}
    return 0
}
main(){
    Fuzzer(fuzzFunc_Decoder_decode).startFuzz()
    0
}
