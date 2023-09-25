//3rd_party_lib:charset/build/charset

from fuzz import fuzz.*
from charset import charset.*
from charset import charset.unicode.*

public func fuzzFunc_newUTF16Charset(dp:DataProvider):Int32 {
    try{
        newUTF16Charset(dp.consumeBool())
    }catch(e:Exception){}
    return 0
}
main(){
    Fuzzer(fuzzFunc_newUTF16Charset).startFuzz()
    0
}