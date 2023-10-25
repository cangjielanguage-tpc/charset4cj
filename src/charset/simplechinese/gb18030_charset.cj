/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

/**
 * @file
 * This file is about GB18030Charset
 */
package charset.simplechinese

import charset.encoding.*

// create GB18030Charset
public func newGB18030Charset(gbk: Bool):Charset {
    if(gbk){
        GBKCharset()
    }else{
        GB18030Charset()
    }
}


/**
 * The class is GBKCharset inherited from Charset
 * @author freeonsky
 * @since 0.28.4
 */
class GBKCharset <: Charset{
    /**
     * The Function is init constructor
     *
     * @since 0.28.4
     */
    public init(){
        // Actual number of characters gbk > gb2312 , for ease of handling,  use gb2312 as gbk
        this.labels = ["chinese", "csgb2312", "csiso58gb231280", "gb2312", "gb_2312", "gb_2312-80", "gbk", "iso-ir-58", "x-gbk"]
        this.name = "gbk"
    }

    /**
     * The Function is newEncoder
     *
     * @return Type of Encoder
     * @since 0.28.4
     */
    public func newEncoder():Encoder{
        GB18030Encoder(true)
    }
    
    /**
     * The Function is newDecoder
     *
     * @return Type of Decoder
     * @since 0.28.4
     */
    public func newDecoder():Decoder{
        GB18030Decoder()
    }

    public operator func ==(rhs: Charset): Bool {
        if (this.name.toAsciiLower() == rhs.name.toAsciiLower()) {
            return true
        }
        for(lable in this.labels) {
            if(lable.toAsciiLower() == rhs.name.toAsciiLower()){
                return true
            }
        }
        return false
    }

    public operator func !=(rhs: Charset): Bool {
        if (this.name.toAsciiLower() != rhs.name.toAsciiLower()) {
            return true
        }
        for(lable in this.labels) {
            if(lable.toAsciiLower() != rhs.name.toAsciiLower()){
                return true
            }
        }
        return false
    }

    public operator func ==(rhs: String): Bool {
        if (this.name.equals(rhs)) {
            return true
        }
        return false
    }

    public operator func !=(rhs: String): Bool {
        if (!this.name.equals(rhs)) {
            return true
        }
        return false
    }

    public func hashCode(): Int64 {
        var hash: Int64 = 0
        hash = 31 * hash + this.name.hashCode()
        return hash
    }

    public func toString(): String {
        return this.name
    }
}

/**
 * The class is GB18030Charset inherited from Charset
 * @author freeonsky
 * @since 0.28.4
 */
class GB18030Charset <: Charset{
    /**
     * The Function is init constructor
     *
     * @since 0.28.4
     */
    public init(){
        this.labels = ["gb18030"]
        this.name = "gb18030"
    }

    /**
     * The Function is newEncoder
     *
     * @return Type of Encoder
     * @since 0.28.4
     */
    public func newEncoder():Encoder{
        GB18030Encoder(false)
    }
    
    /**
     * The Function is newDecoder
     *
     * @return Type of Decoder
     * @since 0.28.4
     */
    public func newDecoder():Decoder{
        GB18030Decoder()
    }

    public operator func ==(rhs: Charset): Bool {
        if (this.name.toAsciiLower() == rhs.name.toAsciiLower()) {
            return true
        }
        for(lable in this.labels) {
            if(lable.toAsciiLower() == rhs.name.toAsciiLower()){
                return true
            }
        }
        return false
    }

    public operator func !=(rhs: Charset): Bool {
        if (this.name.toAsciiLower() != rhs.name.toAsciiLower()) {
            return true
        }
        for(lable in this.labels) {
            if(lable.toAsciiLower() != rhs.name.toAsciiLower()){
                return true
            }
        }
        return false
    }

    public operator func ==(rhs: String): Bool {
        if (this.name.equals(rhs)) {
            return true
        }
        return false
    }

    public operator func !=(rhs: String): Bool {
        if (!this.name.equals(rhs)) {
            return true
        }
        return false
    }

    public func hashCode(): Int64 {
        var hash: Int64 = 0
        hash = 31 * hash + this.name.hashCode()
        return hash
    }

    public func toString(): String {
        return this.name
    }
}
