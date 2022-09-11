// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from charset import charset.*

main (){
    var charset = match(Charsets.forName("gbk")){
      case Some(v) => v
      case None => Charsets.GBK
    }
    var rt = charset.nameEquals("chinese")
    if(!rt){
      return 1
    }
    return 0
}