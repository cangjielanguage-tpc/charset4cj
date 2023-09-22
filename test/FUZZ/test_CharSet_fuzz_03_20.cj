//3rd_party_lib:charset/build/charset

from fuzz import fuzz.*
from charset import charset.*
from charset import charset.singlebyte.*
from std import collection.*

public func fuzzFunc_Decoder_decode(dp:DataProvider):Int32 {
    var decoder=Charsets.ISO_8859_8.newDecoder()
    try{
        decoder.decode(dp.consumeUInt8s(1024),Array<Char>(1024,item:'c'))
    }catch(e:Exception){}
    return 0
}
main(){
    Fuzzer(fuzzFunc_Decoder_decode).startFuzz()
    0
}