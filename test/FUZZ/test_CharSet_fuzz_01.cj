//3rd_party_lib:charset/build/charset

from fuzz import fuzz.*
from charset import charset.*
from std import collection.*

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