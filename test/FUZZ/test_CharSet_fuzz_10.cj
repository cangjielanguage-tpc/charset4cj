//3rd_party_lib:charset/build/charset

from fuzz import fuzz.*
from charset import charset.*
from charset import charset.unicode.*

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