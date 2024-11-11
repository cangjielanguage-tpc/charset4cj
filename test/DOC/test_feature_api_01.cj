// DEPENDENCE: ../LLT/字符集简介.md
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.fs.*
import charset4cj.charset.*
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let ccc = Test_FeatureApi01()
	let res = ccc.asTestSuite().runTests()
	let fail = res.failedCount + res.errorCount
	if (fail == 0) {
		return 0
	}
    return 1
}
@Test
public class Test_FeatureApi01 {
    @TestCase
    public func testFeatureApi01(): Unit {
		var f:File = File("./字符集简介.md", Open(true, false))
		var sr = TextReader(f, charset: Charsets.GB18030, bufSize:120)
		var lineOp:Option<String>=Option<String>.Some("origin")
		while(true){
			lineOp = sr.readln()
			if(lineOp == None){
				break
			}
			lineOp.getOrThrow()
		}   		
        @Assert(lineOp==None, true)
    }
}