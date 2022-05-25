/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * This file is about encodes a string into a byte array
 */

package charset.encoding

/**
 * The interface is ic interface Encoder
 * @author @freeonsky
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
    
}