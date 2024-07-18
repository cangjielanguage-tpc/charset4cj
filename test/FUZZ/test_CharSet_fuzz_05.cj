//3rd_party_lib:charset4cj/build/charset

import fuzz.fuzz.*
import charset4cj.charset.*
import charset4cj.charset.encoding.*
import std.collection.*

public func fuzzFunc_indexPointer(dp:DataProvider):Int32 {
    try{
        indexPointer(HashMap<UInt32, UInt32>(),dp.consumeUInt32s(1024),dp.consumeUInt32())
    }catch(e:Exception){}
    return 0
}
main(){
    Fuzzer(fuzzFunc_indexPointer).startFuzz()
    0
}