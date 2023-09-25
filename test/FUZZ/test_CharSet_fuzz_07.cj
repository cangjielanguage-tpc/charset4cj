//3rd_party_lib:charset/build/charset

from fuzz import fuzz.*
from charset import charset.*
from charset import charset.simplechinese.*
from charset import charset.singlebyte.*
from std import collection.*

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