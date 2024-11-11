//3rd_party_lib:charset4cj/build/charset

import fuzz.fuzz.*
import charset4cj.charset.*
import charset4cj.charset.korean.*
import std.collection.*

public func fuzzFunc_Decoder_decode(dp:DataProvider):Int32 {
    var decoder=Charsets.EUCKR.newDecoder()
    try{
        decoder.decode(dp.consumeUInt8s(1024),Array<Rune>(1024,item:'c'))
    }catch(e:Exception){}
    return 0
}
main(){
    Fuzzer(fuzzFunc_Decoder_decode).startFuzz()
    0
}
