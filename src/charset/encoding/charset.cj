/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * This file is about chart set
 */

package charset.encoding

/**
 * The class is Charset
 * @author freeonsky
 * @since 0.28.4
 */
public abstract class Charset <: Hashable & Equatable<Charset> & Equatable<String> & ToString {
    protected var name:String = ""
    protected var labels:Array<String> = Array<String>()

    /**
     * Judge whether the character set name (or labels) is a given string
     *
     * @param name Character set name 
     *
     * @return Bool 
     * @since 0.28.4
     */
    public func nameEquals(name:String):Bool{
        var res = false
        if(name.toAsciiLower().equals(this.name.toAsciiLower())){
            return true
        }
        for(i in 0..labels.size){
            if(labels[i].toAsciiLower() == name.toAsciiLower()){
                return true
            }
        }
        return res
    }

    /**
     * Encodes a string into a byte array
     *
     * @return Type of Encoder
     * @since 0.28.4
     */
    public func newEncoder():Encoder

    /**
     * Decodes a byte array into a string
     *
     * @return Type of Decoder
     * @since 0.28.4
     */
    public func newDecoder():Decoder
}
