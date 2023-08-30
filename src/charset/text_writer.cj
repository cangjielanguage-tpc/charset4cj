package charset

from std import io.*
from std import collection.*


import charset.encoding.*

/**
* process text writer
*/
public class TextWriter{
    var output:OutputStream
    var charset:Charset
    var encoder:Encoder

    public init(output:OutputStream, charset!:Charset = Charsets.UTF8){
        this.output = output
        this.charset = charset
        this.encoder = charset.newEncoder()
    }   
    public func write(s:String){
        let bytes = this.encoder.encode(s)
        this.output.write(bytes)
    } 
}
