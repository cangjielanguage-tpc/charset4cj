/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * This file is about encodes a string into a byte array
 */

package charset.encoding

from std import collection.*

/**
 * The interface is ic interface Encoder
 * @author freeonsky
 * @since 0.28.4
 */
public interface Encoder{

    /*
     * Encodes a string into a byte array
     *
     * @param str of String
     *
     * @return Type of Array<UInt8>
     * @since 0.28.4
     */
     
    func encode(str:String): Array<UInt8>

    func indexPointer(encodeMapping:Map<UInt32, UInt32>, decodeMapping:Array<UInt32>, codePoint:UInt32):Int64{
        var res:Int64 = -1
        if(!encodeMapping.isEmpty()){
            if(encodeMapping.contains(codePoint)){
                res = Int64(encodeMapping[codePoint])
            }
        }else{
            for(i in 0..decodeMapping.size){
                let item = decodeMapping[i]
                if(item == codePoint){
                    res = i
                    break
                }
            }
        }
        return res
    }
    
}