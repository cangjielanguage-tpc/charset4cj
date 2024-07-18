// 3rd_party_lib:charset4cj/build/charset
// 3rd_party_lib_ohos:charset4cj/build/aarch64-linux-ohos/charset

import std.unittest.*
import std.unittest.testmacro.*
import charset4cj.charset.*
import charset4cj.charset.encoding.*
import std.collection.*

@Test
public class TestIndexPointer{
    /*
        public func indexPointer(encodeMapping:Map<UInt32, UInt32>, decodeMapping:Array<UInt32>, codePoint:UInt32):Int64
    */
    public var encodeMapping=HashMap<UInt32, UInt32>()
    public var decodeMapping=Array<UInt32>()
    public var codePoint:UInt32=9

    //encodeMapping为空,decodeMapping为空
    @TestCase
    func testIndexPointer01(): Unit {
        encodeMapping=HashMap<UInt32, UInt32>()
        decodeMapping=Array<UInt32>()
        var re=indexPointer(encodeMapping,decodeMapping,codePoint)
        @Assert(re,-1)
    }
    //encodeMapping为空,decodeMapping非空，decodeMapping中存在值等于codePoint
    @TestCase
    func testIndexPointer02(): Unit {
        encodeMapping=HashMap<UInt32, UInt32>()
        decodeMapping=Array<UInt32>([1,2,3,4,9,7,6,5])
        codePoint=UInt32(9)
        var re=indexPointer(encodeMapping,decodeMapping,codePoint)
        @Assert(re,4)
    }
    //encodeMapping为空,decodeMapping非空，decodeMapping中均不等于codePoint
    @TestCase
    func testIndexPointer03(): Unit {
        encodeMapping=HashMap<UInt32, UInt32>()
        decodeMapping=Array<UInt32>([1,2,3])
        codePoint=UInt32(9)
        var re=indexPointer(encodeMapping,decodeMapping,codePoint)
        @Assert(re,-1)
    }
    //encodeMapping非空,encodeMapping包含codePoint
    @TestCase
    func testIndexPointer04(): Unit {
        encodeMapping=HashMap<UInt32, UInt32>([(1,9),(9,1),(1,1)])
        decodeMapping=Array<UInt32>()
        codePoint=UInt32(9)
        var re=indexPointer(encodeMapping,decodeMapping,codePoint)
        @Assert(re,1)
    }
    //encodeMapping非空,encodeMapping不包含codePoint
    @TestCase
    func testIndexPointer05(): Unit {
        encodeMapping=HashMap<UInt32, UInt32>([(1,9),(8,1),(1,1)])
        decodeMapping=Array<UInt32>()
        codePoint=UInt32(9)
        var re=indexPointer(encodeMapping,decodeMapping,codePoint)
        @Assert(re,-1)
    }
}
