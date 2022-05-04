package charset.encoding

public interface Encoder{
    /**
    * 将字符串编码成字节数组
    */
    func encode(str:String): Array<UInt8>
    
}