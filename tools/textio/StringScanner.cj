package textio

/**
* 字符串解析
*/
public class StringScanner{
    let s:String
    // 下一个要处理的位置
    var position:Int64
    let separator:String
    init(s:String, separator:String){
        this.s = s    
        this.position = 0
        this.separator = separator
    }
    init(s:String){
        // table,换行，空格
        this(s, "\t\r\n ")
    }
    func hasNext():Bool{
        return position < s.size
    }
    func nextToken():String{
        var start:Int64 = -1
        var end:Int64 = -1
        // 1. 过滤掉 separator 字符
        while(position < s.size){
            var ch = s[position..position+1]
            if(separator.contains(ch)){
                position += 1
                continue
            }else{
                break;
            }
        }
        start = position
        // 2. 找到下一个 separator 字符
        position += 1
        while(position < s.size){
            var ch = s[position..position+1]
            if(separator.contains(ch)){
                break
            }
            position += 1
        }
        end = position
        return s[start..end]
    }
}

