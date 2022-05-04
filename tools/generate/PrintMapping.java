import java.io.*;
import java.net.URL;
import java.net.URLConnection;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 生成编解码映射
 * 编码： 从unicode 到 其它编码
 * 解码： 从其它编码 到 unicode
 cd generate/
 javac PrintMapping.java
 java -cp . PrintMapping
 mv *.cj ../mapping/
 */
public class PrintMapping {
    private static String packageName;

    public static void main(String[] args) {
//        writegb18030();
//        writegb18030range();

//          writeEUCKR();

//        writeAllSingleByteencoding();

        wiretebig5();
    }

    public static void writeAllSingleByteencoding(){
        packageName = "encoding.singlebyte";
        String[] singlebyteencoding = new String[]{
                "ibm866",
                "iso-8859-2",
                "iso-8859-3",
                "iso-8859-4",
                "iso-8859-5",
                "iso-8859-6",
                "iso-8859-7",
                "iso-8859-8",
                "iso-8859-10",
                "iso-8859-13",
                "iso-8859-14",
                "iso-8859-15",
                "iso-8859-16",
                "koi8-r",
                "koi8-u",
                "macintosh",
                "windows-874",
                "windows-1250",
                "windows-1251",
                "windows-1252",
                "windows-1253",
                "windows-1254",
                "windows-1255",
                "windows-1256",
                "windows-1257",
                "windows-1258",
                "x-mac-cyrillic"
        };
        for(String encodingName:singlebyteencoding){
            downloadFile(encodingName);
            writeSingleByteEncoding(encodingName);
        }
    }

    public static void writeSingleByteEncoding(String encodingName){
        String urlStr = "https://encoding.spec.whatwg.org/index-" + encodingName + ".txt";
        List<String> strings = aquireContextLine(encodingName);
        Map<Integer,Integer> map = new LinkedHashMap<>();
        strings.stream().forEach(s -> {
            String[] split = s.trim().split("\\s+");
            if (split.length >= 2) {
                Integer index = Integer.parseInt(split[0]);
                Integer value = Integer.parseInt(split[1].substring(2), 16);
                map.put(index,value);
            }
        });

        StringBuilder sb = new StringBuilder();
        sb.append("// 基于 " + urlStr + " 文档自动生成");
        sb.append("\npackage " + packageName);
        sb.append("\n\nfrom std import collection.*\n");
        // sb.append("\n\nimport charset.charset.*\n");
        sb.append("\n\n\n");

        // 编码
        sb.append("let " + encodingName.replace("-", "_") + "DecodeMapping: List<UInt32> = [\n");
        final int size = strings.size();
        for(int i=0;i<128;i++){
            if(map.containsKey(i)){
                sb.append("\t");
                final String format = String.format("0x%04X", map.get(i));
                sb.append(format);
            }else{
                sb.append("\t0xFFFF");
            }
            if(i != 128 -1){
                sb.append(",\n");
            }
        }
        sb.append("\n]\n\n");

        // 解码
        sb.append("let " + encodingName.replace("-", "_") + "EncodeMapping = HashMap<UInt32, UInt8>([\n");
        final int size1 = map.size();
        int i = 0;
        for(Map.Entry<Integer,Integer> entry: map.entrySet()){
            i++;
            final Integer key = entry.getKey();
            final Integer value = entry.getValue();
            String s = "\t(" + value + ", " + (key +0x80) + ")";
            if(i < size){
                s +=  ",\n";
            }else{
                s += "\n";
            }
            sb.append(s);
        }
        sb.append("])");

        try (
                BufferedWriter bw = Files.newBufferedWriter(
                        Paths.get(encodingName.replace("-", "_") + "_mapping.cj"),
                        StandardCharsets.UTF_8);
        ){

            bw.write(sb.toString());

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void downloadFile(String encodingName) {
        String fileName = "index-" + encodingName + ".txt";
        if (!Files.exists(Paths.get(fileName))) {
            String urlStr = "https://encoding.spec.whatwg.org/index-" + encodingName + ".txt";
            URL url = null;
            try {
                url = new URL(urlStr);
                URLConnection connection = url.openConnection();
                InputStream inputStream = connection.getInputStream();
                Files.copy(inputStream, Paths.get(fileName));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public static List<String> aquireFileContent(String encodingName) {
        downloadFile(encodingName);
        String fileName = "index-" + encodingName + ".txt";
        try {
            final List<String> lines = Files.readAllLines(Paths.get(fileName), StandardCharsets.UTF_8);
            return lines;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return new ArrayList<>();
    }

    public static List<String> aquireContextLine(String encodingName){
        downloadFile(encodingName);
        String fileName = "index-" + encodingName + ".txt";
        final List<String> lines = aquireFileContent(encodingName);
        // 获取解码映射
        final List<String> decodeStr = lines.stream()
                .filter(s -> !s.trim().isEmpty())
                .filter(s -> !s.startsWith("#"))
                .collect(Collectors.toList());
        return decodeStr;
    }
    public static List<String> aquireDecodeIndex(String encodingName) {
        final List<String> contextLine = aquireContextLine(encodingName);
        final List<String> decodeStr = contextLine.stream().map(s -> {
            String[] split = s.split("\t");
            if (split.length >= 2) {
                String s1 = split[1].toLowerCase();
                return s1;
            } else {
                return "";
            }
        }).filter(s -> !s.isEmpty()).collect(Collectors.toList());
        return decodeStr;
    }


    private static void writegb18030range(){
        String encodingName = "gb18030-ranges";

        final List<String> indexList = aquireContextLine(encodingName);
        File file = new File(encodingName.replace("-", "_") + "_mapping.cj");

        try (
                FileOutputStream fout = new FileOutputStream(file)
        ) {
            OutputStreamWriter fw = new OutputStreamWriter(fout);
            String urlStr = "https://encoding.spec.whatwg.org/index-" + encodingName + ".txt";
            fw.write("// 基于 " + urlStr + " 文档自动生成");
            fw.write("\npackage " + packageName);
            fw.write("\n\n\n");
            fw.write("let " + encodingName.replace("-", "_") + "Mapping: List<List<UInt32>> = [\n");
            final List<String> collect = indexList.stream().map(s -> {
                return "\t[" + s.trim().replaceAll("\\s+", ", ") + "]";
            }).collect(Collectors.toList());
            final String join = String.join(",\n", collect);
            fw.write(join);
            fw.write("\n]\n");
            fw.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void wiretebig5(){
        String encodingName = "Big5";
         String packageName = "encoding.traditionchinese";
        final List<String> indexList = aquireDecodeIndex(encodingName.toLowerCase());

        List<String> lines = aquireContextLine(encodingName.toLowerCase());
        Map<Integer,Integer> map = new LinkedHashMap<>();
        lines.stream().forEach(s -> {
            String[] split = s.trim().split("\\s+");
            if (split.length >= 2) {
                Integer index = Integer.parseInt(split[0]);
                Integer value = Integer.parseInt(split[1].substring(2), 16);
                map.put(index,value);
            }
        });
        final Optional<Integer> max = map.keySet().stream().max(Integer::compare);
        final Integer[] decodes = new Integer[max.get()];
        for(int i=0;i<decodes.length;i++){
            if(map.containsKey(i)){
                decodes[i] = map.get(i);
            }else{
                decodes[i] = 0;
            }

        }
//        final List<Integer> indexList = new ArrayList<Integer>(Arrays.asList(decodes));

        File file = new File(encodingName.replace("-", "_").toLowerCase() + "_mapping.cj");

        try (
                FileOutputStream fout = new FileOutputStream(file)
        ) {
            OutputStreamWriter fw = new OutputStreamWriter(fout);
            String urlStr = "https://encoding.spec.whatwg.org/index-" + encodingName.toLowerCase() + ".txt";
            fw.write("// 基于 " + urlStr + " 文档自动生成");
            fw.write("\npackage " + packageName);
            fw.write("\n\n\n");


            // 解码
            fw.write("let " + encodingName.replace("-", "_") + "DecodeMapping: Array<UInt32> = [\n");

            final List<String> collect = indexList.stream().map(s -> "\t\t" + s).collect(Collectors.toList());
            final String decodeString = String.join(",\n", collect);
            fw.write(decodeString);

            fw.write("\n]\n\n\n");

            // 编码
            fw.write("let " + encodingName.replace("-", "_") + "EncodeMapping = HashMap<UInt32, UInt32>([\n");

            final List<String> collect1 = new ArrayList<>();
            indexList.stream().map(s -> "\t\t" + s).collect(Collectors.toList());
            for(int i=0;i< indexList.size();i++){
                String s = indexList.get(i);
                String s2 = "\t\t(" + s + ", " + i + ")";
                collect1.add(s2);
            }

            final String decodeString1 = String.join(",\n", collect1);
            fw.write(decodeString1);

            fw.write("\n])\n\n\n");


            /*
            fw.write("external class " + encodingName.replace("-", "").toUpperCase() + "Mapping{\n");
            encodingName = encodingName.replace("-", "_").toLowerCase();
            final int size = indexList.size();
            // 由于仓颉暂不支持超长 List 字面量，故将 解码映射拆分
            final int constSize = 5000;
            int num = size / constSize + (size % constSize == 0 ? 0:1);


            List<String> varNames = new ArrayList<>();
            if(size > constSize){
                for(int i=0;i<num;i++){
                    int from = constSize * i;
                    int to = from + constSize;
                    if(to > size){
                        to = size;
                    }
                    final List<Integer> strings = indexList.subList(from, to);
                    writeDecodeTableNumber(encodingName, strings, fw, i);
                    if(i == 0){
                        String str = "*" + encodingName + "DecodeMapping";
                        varNames.add(str);
                    }else{
                        String str = "*" + encodingName + "DecodeMapping" + i;
                        varNames.add(str);
                    }
                }

            }else{
                writeDecodeTableNumber(encodingName, indexList, fw, 0);
                String str = "*" + encodingName + "DecodeMapping";
                varNames.add(str);
            }
            fw.write("\tvar decodeMapping:List<UInt32>\n\n");
            fw.write("\tinit(){\n");
            fw.write("\t\tdecodeMapping = [");
            fw.write(String.join(", ", varNames));
            fw.write("]\n");
            fw.write("\t}\n\n");

            fw.write("\tfunc mapping():List<UInt32>{\n");
            fw.write("\t\treturn decodeMapping\n");
            fw.write("\t}\n");
            fw.write("}\n");
            */


            fw.close();

        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    private static void writeDecodeTableNumber(String encodingName, List<Integer> indexList, OutputStreamWriter fw, int i) throws IOException {
        String str = "";
        if(i == 0){
            str = "\tvar " + encodingName + "DecodeMapping" + ":List<UInt32> = [\n";
        }else{
            str = "\tvar " + encodingName + "DecodeMapping" + i + ":List<UInt32> = [\n";
        }
        fw.write(str);
        final List<String> collect = indexList.stream().map(s -> "\t\t" + String.format("0x%04X", s)).collect(Collectors.toList());
        final String decodeString = String.join(",\n", collect);
        fw.write(decodeString);
        fw.write("\n\t]\n\n\n");
    }

    private static void writeEUCKR(){
        String encodingName = "EUC-KR";
         String packageName = "encoding.korean";
        final List<String> indexList = aquireDecodeIndex(encodingName.toLowerCase());

        List<String> lines = aquireContextLine(encodingName);
        File file = new File(encodingName.replace("-", "_").toLowerCase() + "_mapping.cj");

        try (
                FileOutputStream fout = new FileOutputStream(file)
        ) {
            OutputStreamWriter fw = new OutputStreamWriter(fout);
            String urlStr = "https://encoding.spec.whatwg.org/index-" + encodingName.toLowerCase() + ".txt";
            fw.write("// 基于 " + urlStr + " 文档自动生成");
            fw.write("\npackage " + packageName);
            fw.write("\n\n\n");


            // 解码
            fw.write("let " + encodingName.replace("-", "_") + "DecodeMapping: Array<UInt32> = [\n");

            final List<String> collect = indexList.stream().map(s -> "\t\t" + s).collect(Collectors.toList());
            final String decodeString = String.join(",\n", collect);
            fw.write(decodeString);

            fw.write("\n]\n\n\n");

            // 编码
            fw.write("let " + encodingName.replace("-", "_") + "EncodeMapping = HashMap<UInt32, UInt32>([\n");

            final List<String> collect1 = new ArrayList<>();
            indexList.stream().map(s -> "\t\t" + s).collect(Collectors.toList());
            for(int i=0;i< indexList.size();i++){
                String s = indexList.get(i);
                String s2 = "\t\t(" + s + ", " + i + ")";
                collect1.add(s2);
            }

            final String decodeString1 = String.join(",\n", collect1);
            fw.write(decodeString1);

            fw.write("\n])\n\n\n");

            /*
            fw.write("external class " + encodingName.replace("-", "").toUpperCase() + "Mapping{\n");
            encodingName = encodingName.replace("-", "_").toLowerCase();
            final int size = indexList.size();
            // 由于仓颉暂不支持超长 List 字面量，故将 解码映射拆分
            final int constSize = 5000;
            int num = size / constSize + (size % constSize == 0 ? 0:1);


            List<String> varNames = new ArrayList<>();
            if(size > constSize){
                for(int i=0;i<num;i++){
                    int from = constSize * i;
                    int to = from + constSize;
                    if(to > size){
                        to = size;
                    }
                    final List<String> strings = indexList.subList(from, to);
                    writeDecodeTable(encodingName, strings, fw, i);
                    if(i == 0){
                        String str = "*" + encodingName + "DecodeMapping";
                        varNames.add(str);
                    }else{
                        String str = "*" + encodingName + "DecodeMapping" + i;
                        varNames.add(str);
                    }
                }

            }else{
                writeDecodeTable(encodingName, indexList, fw, 0);
                String str = "*" + encodingName + "DecodeMapping";
                varNames.add(str);
            }
            fw.write("\tvar decodeMapping:List<UInt32>\n\n");
            fw.write("\tinit(){\n");
            fw.write("\t\tdecodeMapping = [");
            fw.write(String.join(", ", varNames));
            fw.write("]\n");
            fw.write("\t}\n\n");

            fw.write("\tfunc mapping():List<UInt32>{\n");
            fw.write("\t\treturn decodeMapping\n");
            fw.write("\t}\n");
            fw.write("}\n");
            */


            fw.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    private static void writegb18030() {
        String encodingName = "gb18030";
        // String packageName = "encoding";
        packageName = "encoding.simplechinese";
        final List<String> indexList = aquireDecodeIndex(encodingName);

        List<String> lines = aquireContextLine(encodingName);
        Map<Integer,Integer> map = new LinkedHashMap<>();
        Map<Integer,Integer> reverseMap = new LinkedHashMap<>();

        lines.stream().forEach(s -> {
            String[] split = s.trim().split("\\s+");
            if (split.length >= 2) {
                Integer index = Integer.parseInt(split[0]);
                Integer value = Integer.parseInt(split[1].substring(2), 16);
                map.put(index,value);
                // gbk 范围8140－FEFE ，第二字节没有 0x7F, 第一字节当做行，工126行，第二字节当做列，共190列
                int row = index / 190;
                int col = index % 190;
                if(col >= 0x3f){
                    // 第二字节是 0x40 ~ 0xFE, 中间少了 0x7F, 故 0x7f - 0x40 后面的列要加1
                    col += 1;
                }
                int gbkCodePoint = ((row + 0x81) << 8)  + (col + 0x40);
                if(gbkCodePoint <= 0){
                    System.out.println(gbkCodePoint);
                }
                reverseMap.put(value, gbkCodePoint);
            }
        });
        final Optional<Integer> max = reverseMap.keySet().stream().max(Integer::compare);
        final Optional<Integer> min = reverseMap.keySet().stream().min(Integer::compare);


        File file = new File(encodingName + "_mapping.cj");

        try (
                FileOutputStream fout = new FileOutputStream(file)
        ) {
            OutputStreamWriter fw = new OutputStreamWriter(fout);
            String urlStr = "https://encoding.spec.whatwg.org/index-" + encodingName + ".txt";
            fw.write("// 基于 " + urlStr + " 文档自动生成");
            fw.write("\npackage " + packageName);
            fw.write("\n\n\n");

            // 解码
            fw.write("let " + encodingName.replace("-", "_") + "DecodeMapping: List<UInt32> = [\n");

            final List<String> collect = indexList.stream().map(s -> "\t\t" + s).collect(Collectors.toList());
            final String decodeString = String.join(",\n", collect);
            fw.write(decodeString);

            fw.write("\n]\n\n\n");

            // 编码
            fw.write("let " + encodingName.replace("-", "_") + "EncodeMapping = HashMap<UInt32, UInt32>([\n");

            final List<String> collect1 = new ArrayList<>();
            indexList.stream().map(s -> "\t\t" + s).collect(Collectors.toList());
            for(int i=0;i< indexList.size();i++){
                String s = indexList.get(i);
                String s2 = "\t\t(" + s + ", " + i + ")";
                collect1.add(s2);
            }

            final String decodeString1 = String.join(",\n", collect1);
            fw.write(decodeString1);

            fw.write("\n])\n\n\n");

            /*
            fw.write("external class " + encodingName.toUpperCase() + "Mapping{\n");
            final int size = indexList.size();
            // 由于仓颉暂不支持超长 List 字面量，故将 解码映射拆分
            final int constSize = 5000;
            int num = size / constSize + (size % constSize == 0 ? 0:1);


            List<String> varNames = new ArrayList<>();
            if(size > constSize){
                for(int i=0;i<num;i++){
                    int from = constSize * i;
                    int to = from + constSize;
                    if(to > size){
                        to = size;
                    }
                    final List<String> strings = indexList.subList(from, to);
                    writeDecodeTable(encodingName, strings, fw, i);
                    if(i == 0){
                        String str = "*" + encodingName + "DecodeMapping";
                        varNames.add(str);
                    }else{
                        String str = "*" + encodingName + "DecodeMapping" + i;
                        varNames.add(str);
                    }
                }

            }else{
                writeDecodeTable(encodingName, indexList, fw, 0);
                String str = "*" + encodingName + "DecodeMapping";
                varNames.add(str);
            }
            fw.write("\tvar decodeMapping:List<UInt32>\n\n");
            fw.write("\tinit(){\n");
            fw.write("\t\tdecodeMapping = [");
            fw.write(String.join(", ", varNames));
            fw.write("]\n");
            fw.write("\t}\n\n");

            fw.write("\tfunc mapping():List<UInt32>{\n");
            fw.write("\t\treturn decodeMapping\n");
            fw.write("\t}\n");
            fw.write("}\n");

            */

            fw.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void writeDecodeTable(String encodingName, List<String> indexList, OutputStreamWriter fw, int i) throws IOException {
        String str = "";
        if(i == 0){
            str = "\tvar " + encodingName + "DecodeMapping" + ":List<UInt32> = [\n";
        }else{
            str = "\tvar " + encodingName + "DecodeMapping" + i + ":List<UInt32> = [\n";
        }
        fw.write(str);
        final List<String> collect = indexList.stream().map(s -> "\t\t" + s).collect(Collectors.toList());
        final String decodeString = String.join(",\n", collect);
        fw.write(decodeString);
        fw.write("\n\t]\n\n\n");
    }
}
