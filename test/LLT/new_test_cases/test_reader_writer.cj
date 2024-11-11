// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import charset4cj.charset.*
import std.unittest.*
import std.unittest.testmacro.*
import std.io.*

main(): Int64 {
    let readerWriter = ReaderWriter01()

    readerWriter.testTextReader01()
    readerWriter.testTextReader02()
    readerWriter.testTextWriter01()

    return 0
}

@Test
public class ReaderWriter01 {

    let str = "AndersonThomasJacksonWhiteHarrisMartinThompsonGarciaMartinezRobinson"
    let str2 = ""
    var bas: ByteArrayStream = ByteArrayStream()

    @TestCase
    public func testTextReader01(): Unit {
        bas.write(str.toArray())
        var reader: TextReader = TextReader(bas)
        reader.read()
        reader.readln()
        reader.readAllLine()
    }

    @TestCase
    public func testTextReader02(): Unit {
        bas.write(str2.toArray())
        var reader: TextReader = TextReader(bas)
        reader.read()
        reader.readln()
        reader.readAllLine()
    }

    @TestCase
    public func testTextWriter01(): Unit {
        var writer: TextWriter = TextWriter(bas)
        writer.write(str)
    }

}
