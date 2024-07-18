// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
// DEPENDENCE: utf8.txt
// DEPENDENCE: gbk.txt

import charset4cj.charset.*
import std.fs.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    let t = Trans()
    t.testTextReader01()
    return 0
}

@Test
public class Trans {

    @TestCase
    public func testTextReader01(): Unit {
        var input = File("utf8.txt", Open(true, true))
        var output = ByteArrayStream(4096)
        CharsetTransfer.transfer(input, output, Charsets.UTF8, Charsets.GBK)
        var outputBytes: Array<Byte> = output.bytes()
        var expectedOutput = File("gbk.txt", Open(true, true))
        var expectedOutputBytes: Array<Byte> = expectedOutput.readToEnd()
        println(outputBytes)
        println("----------------------------------")
        println(expectedOutputBytes)
    }
}
