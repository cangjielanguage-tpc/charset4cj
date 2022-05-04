package textio

public class StringUtils{
    static func isBlank(str:String){
        for(c in str){
            if(c != ' ' && c != '\t'){
                return false
            }
        }
        return true
    }
}