//3rd_party_lib:charset/build/charset

from fuzz import fuzz.*
from charset import charset.*
from charset import charset.simplechinese.*
from std import collection.*

public func fuzzFunc_newGB18030Charset(dp:DataProvider):Int32 {
    try{
        newGB18030Charset(dp.consumeBool())
    }catch(e:Exception){}
    return 0
}
main(){
    Fuzzer(fuzzFunc_newGB18030Charset).startFuzz()
    0
}