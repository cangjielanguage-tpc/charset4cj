// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import fs.*
from charset import charset.*
from std import unittest.*
from std import unittest.testmacro.*

main() {
    let ccc = Test_FeatureApi02()
    ccc.execute()
    ccc.printResult()
    0
}
@Test
public class Test_FeatureApi02 {
    @TestCase
    public func testFeatureApi02(): Unit {
		var charset = Charsets.GB18030
		var decoder = charset.newDecoder()
		charset.newEncoder()
		var src: Array<UInt8> = Array<UInt8>([0xCB, 0xAE, 0xB5, 0xE7, 0xB7, 0xD1])
		var destStr = decoder.decode(src)
        @Assert(destStr,"水电费")
    }
}
