// DEPENDENCE: ../LLT/字符集简介.md
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.fs.*
import charset4cj.charset.*
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let ccc = Test_ReadMe02()
	let res = ccc.asTestSuite().runTests()
	let fail = res.failedCount + res.errorCount
	if (fail == 0) {
		return 0
	}
    return 1
}
@Test
public class Test_ReadMe02 {
    let str: String = "z,ncm,xzjiu"
    let str_en: String = "￡％＃＆＊＠§"
    @TestCase
    public func testReadMe02(): Unit {
        var jp = Charsets.EUCJP
        var jpen = jp.newEncoder()
        var jpde = jp.newDecoder()
        let src: Array<UInt8> = jpen.encode(str)
        let src2: Array<UInt8> = jpen.encode(str_en)
        let des=Array<Rune>(30,item:r'0')
		let res = jpde.decode(src, des)
        jpde.decode(src2, des)
        @Assert(res[0], 11)
        @Assert(res[1], 11)
    }
}
