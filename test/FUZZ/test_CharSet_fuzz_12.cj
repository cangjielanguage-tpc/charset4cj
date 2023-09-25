//3rd_party_lib:charset/build/charset

from fuzz import fuzz.*
from charset import charset.*
from std import collection.*
from std import io.*

public func fuzzFunc_TextWriter_write(dp:DataProvider):Int32 {
    var temp=ByteArrayStream()
    var tw=TextWriter(temp)
    try{
        tw.write(dp.consumeString(1024))
    }catch(e:Exception){}
    return 0
}
main(){
    Fuzzer(fuzzFunc_TextWriter_write).startFuzz()
    0
}
