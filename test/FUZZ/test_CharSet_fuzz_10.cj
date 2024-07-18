//3rd_party_lib:charset4cj/build/charset

import fuzz.fuzz.*
import charset4cj.charset.*
import charset4cj.charset.unicode.*

public func fuzzFunc_newUTF32Charset(dp:DataProvider):Int32 {
    try{
        newUTF32Charset(dp.consumeBool())
    }catch(e:Exception){}
    return 0
}
main(){
    Fuzzer(fuzzFunc_newUTF32Charset).startFuzz()
    0
}