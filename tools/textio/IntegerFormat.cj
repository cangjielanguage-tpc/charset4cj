package textio

/**
* 字符串解析成int
*/
public class IntegerFormat{
    static func toHexString(num:Int64, pad:Int64):String{
        var radix:Int64 = 16
        var s = "0x"
        if(num == 0){
            s = s +"0"
            return s
        }
        if(num < 0){
            s = s + "-"
        }
        var nstr = ""
        var i = 0
        var t = num
        while(t > 0){
            var mod = t % radix
            t = t / radix
            var c = if(mod >9){
                chr(UInt32(mod + 55))
            } else{
                chr(UInt32(mod + 0x30))
            }
            nstr = nstr + String([c])
        }
        if(nstr.size() < pad){
            
        }
        s = s + nstr.reverse()
        return s
    }
    static func toString(num:Int64):String{
        var s = ""
        if(num == 0){
            s = "0"
            return s
        }
        if(num < 0){
            s = s + "-"
        }
        var nstr = ""
        var i = 0
        var t = num
        while(t > 0){
            var mod = t % 10
            t = t / 10
            var c = chr(UInt32(mod + 0x30))
            nstr = nstr + String([c])
        }
        s = s + nstr.reverse()
        return s
    }
    static func parseInt(str:String):Int64{
        var s = str
        if(str.startsWith("0x") || str.startsWith("0X")){
            s = str.substring(2)
            return parseInt(s, 16)
        }
        var res = 0
        var p:String = ""
        match(s.indexOf('.')){
            case Some(index) => p = s[0..index]
            case $None => p = s
        }
        var numstr = p.reverse()
        var i = 0
        while(i<numstr.size()){
            var n = numstr[i]
            var t = charToInt(numstr[i])
            res += t * pow(10, i)
            i += 1
        }
        return res
    }
    static func parseInt(s:String, radix:Int64):Int64{
        var res = 0
        var p:String = ""
        match(s.indexOf('.')){
            case Some(index) => p = s[0..index]
            case $None => p = s
        }
        var numstr = p.reverse()
        var i = 0
        while(i<numstr.size()){
            var n = numstr[i]
            var t = charToInt(numstr[i])
            res += t * pow(radix, i)
            i += 1
        }
        return res
    }    
    private static func charToInt(ch:Char):Int64{
        return Int64(ord(ch) - 0x30)
    }
    private static func pow(x:Int64, y:Int64){
        var i = 0
        var res = 1
        while(i<y){
            res = res * x
            i++
        }
        return res
    }
}