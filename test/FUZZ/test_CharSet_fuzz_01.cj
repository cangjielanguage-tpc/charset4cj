//3rd_party_lib:charset4cj/build/charset

import fuzz.fuzz.*
import charset4cj.charset.*
import std.collection.*

public func fuzzFunc_Charset_nameEquals(dp:DataProvider):Int32 {
    try{
        Charsets.UTF8.nameEquals(dp.consumeString(1024))
    }catch(e:Exception){}
    return 0
}
main(){
    Fuzzer(fuzzFunc_Charset_nameEquals).startFuzz()
    0
}