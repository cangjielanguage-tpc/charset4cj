//3rd_party_lib:charset4cj/build/charset

import fuzz.fuzz.*
import charset4cj.charset.*
import charset4cj.charset.simplechinese.*
import std.collection.*

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