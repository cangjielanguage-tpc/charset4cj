// DEPENDENCE: ../LLT/字符集简介.md
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import fs.*
from charset import charset.*
from std import unittest.*
from std import unittest.testmacro.*

main() {
    let ccc = Test_ReadMe02()
    ccc.execute()
    ccc.printResult()
    0
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
        let des=Array<Char>(30,item:'0')
		let res = jpde.decode(src, des)
        jpde.decode(src2, des)
        @Assert(res[0], 11)
        @Assert(res[1], 11)
    }
}
