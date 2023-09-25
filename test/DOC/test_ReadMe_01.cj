// DEPENDENCE: ../LLT/字符集简介.md
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import fs.*
from charset import charset.*
from std import unittest.*
from std import unittest.testmacro.*

main() {
    let ccc = Test_ReadMe01()
    ccc.execute()
    ccc.printResult()
    0
}
@Test
public class Test_ReadMe01 {
    @TestCase
    public func testReadMe01(): Unit {
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