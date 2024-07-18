//3rd_party_lib:charset4cj/build/charset

import fuzz.fuzz.*
import charset4cj.charset.*
import charset4cj.charset.traditionchinese.*

public func fuzzFunc_newBIG5Charset(dp:DataProvider):Int32 {
    try{
        newBIG5Charset(dp.consumeBool())
    }catch(e:Exception){}
    return 0
}
main(){
    Fuzzer(fuzzFunc_newBIG5Charset).startFuzz()
    0
}