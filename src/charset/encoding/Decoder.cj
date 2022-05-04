package charset.encoding

public interface Decoder{
    /**
    * 将字节数组解码成字符串
    */
    func decode(src:Array<UInt8>):String{
        var dest:Array<Char> = Array<Char>(src.size(),{i => '\u{0}'})
        var res = decode(src, 0, src.size()-1, dest, 0)
        var s = String(dest[0..res[1]])
        return s    
    }

    /**
    * 将字节数组src解码成字符数组 dest
    * 字节数组src的可用范围 [srcOffset, srcLimit]
    *   srcOffset 表示当前没有处理的 src 下标
    * 字符数组dest的可用范围 [destUnusedOffset, dest.size()) ,不包含dest.size();
    *   destUnusedOffset 表示当前没有使用的 dest 下标
    * 返回值 (srcIndex, destIndex)； 
    *   srcIndex 下一个没有处理的src下标
    *   destIndex 下一个没有处理的dest下标
    */
    func decode(src:Array<UInt8>, srcOffset:Int64, srcLimit:Int64, 
            dest:Array<Char>, destUnusedOffset:Int64): Int64 * Int64
}