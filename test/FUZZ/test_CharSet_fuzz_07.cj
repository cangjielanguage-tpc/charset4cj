//3rd_party_lib:charset4cj/build/charset

import fuzz.fuzz.*
import charset4cj.charset.*
import charset4cj.charset.simplechinese.*
import charset4cj.charset.singlebyte.*
import std.collection.*

public func fuzzFunc_newSingleByteCharset(dp:DataProvider):Int32 {
    try{
        newSingleByteCharset(dp.consumeString(1024))
    }catch(e:Exception){}
    return 0
}
main(){
    Fuzzer(fuzzFunc_newSingleByteCharset).startFuzz()
    0
}