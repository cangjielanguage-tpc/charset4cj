//3rd_party_lib:charset/build/charset

from fuzz import fuzz.*
from charset import charset.*

public func fuzzFunc_Charsets_forName(dp:DataProvider):Int32 {
    try{
        Charsets.forName(dp.consumeString(1024))
    }catch(e:Exception){}
    return 0
}
main(){
    Fuzzer(fuzzFunc_Charsets_forName).startFuzz()
    0
}