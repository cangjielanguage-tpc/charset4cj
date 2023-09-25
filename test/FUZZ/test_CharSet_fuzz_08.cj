//3rd_party_lib:charset/build/charset

from fuzz import fuzz.*
from charset import charset.*
from charset import charset.traditionchinese.*

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