package charset.encoding

/**
* 字符集
*/
public abstract class Charset{
    protected var name:String = ""
    protected var labels:Array<String> = Array<String>()

    /**
    * 判断字符集名称（或者labels）是否是给定字符串
    */
    public func nameEquals(name:String):Bool{
        var res = false
        if(name == this.name){
            return true
        }
        for(label in labels){
            if(label == name){
                return true
            }
        }
        return res
    }
    public func newEncoder():Encoder
    public func newDecoder():Decoder
}







