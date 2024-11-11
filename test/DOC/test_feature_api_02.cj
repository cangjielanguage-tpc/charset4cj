// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.fs.*
import charset4cj.charset.*
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let ccc = Test_FeatureApi02()
	let res = ccc.asTestSuite().runTests()
	let fail = res.failedCount + res.errorCount
	if (fail == 0) {
		return 0
	}
    return 1
}
@Test
public class Test_FeatureApi02 {
    @TestCase
    public func testFeatureApi02(): Unit {
		var charset = Charsets.GB18030
		var decoder = charset.newDecoder()
		charset.newEncoder()
		var src: Array<UInt8> = [0xCB, 0xAE, 0xB5, 0xE7, 0xB7, 0xD1]
		var destStr = decoder.decode(src)
        @Assert(destStr,"水电费")
    }
}
