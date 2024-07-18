// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
import charset4cj.charset.*

main (){
    var charset = match(Charsets.forName("gbk")){
      case Some(v) => v
      case None => throw Exception()
    }
    var rt = charset.nameEquals("chinese")
    if(!rt){
      return 1
    }
    return 0
}
