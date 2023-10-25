/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

package charset.japanese

import charset.encoding.*

// EUC-JP japanese encoding charset
public func newEUCJPCharset():Charset{
    EUCJPCharset()
}

// ShiftJIS japanese encoding charset
public func newShiftJISCharset():Charset{
    ShiftJISCharset()
}

// ISO-2022-JP japanese encoding charset
public func newISO2022JPCharset():Charset{
    ISO2022JPCharset()
}

/**
 * ISO-2022-JP japanese encoding charset
 * @author freeonsky
 * @since 0.28.4
 */
class ISO2022JPCharset <: Charset{

    /**
     * The Function is init constructor
     *
     * @since 0.28.4
     */
    public init(){
        this.labels = ["ISO-2022-JP",  "csiso2022jp"]
        this.name = "ISO-2022-JP"
    }

    /**
     * The Function is newEncoder
     *
     * @return Type of Encoder
     * @since 0.28.4
     */
    public func newEncoder():Encoder{
        ISO2022JPEncoder()
    }

    /**
     * The Function is newDecoder
     *
     * @return Type of Decoder
     * @since 0.28.4
     */
    public func newDecoder():Decoder{
        ISO2022JPDecoder()
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
 * EUC-JP japanese encoding charset
 * @author freeonsky
 * @since 0.28.4
 */
class EUCJPCharset <: Charset{

    /**
     * The Function is init constructor
     *
     * @since 0.28.4
     */
    public init(){
        this.labels = ["cseucpkdfmtjapanese",  "euc-jp",  "x-euc-jp"]
        this.name = "EUC-JP"
    }

    /**
     * The Function is newEncoder
     *
     * @return Type of Encoder
     * @since 0.28.4
     */
    public func newEncoder():Encoder{
        EUCJPEncoder()
    }

    /**
     * The Function is newDecoder
     *
     * @return Type of Decoder
     * @since 0.28.4
     */
    public func newDecoder():Decoder{
        EUCJPDecoder()
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
 * ShiftJIS japanese encoding charset
 * @author freeonsky
 * @since 0.28.4
 */
class ShiftJISCharset <: Charset{

    /**
     * The Function is init constructor
     *
     * @since 0.28.4
     */
    public init(){
        this.labels = ["csshiftjis","ms932","ms_kanji","shift-jis","shift_jis","sjis","windows-31j","x-sjis"]
        this.name = "Shift_JIS"
    }

    /**
     * The Function is newEncoder
     *
     * @return Type of Encoder
     * @since 0.28.4
     */
    public func newEncoder():Encoder{
        ShiftJISEncoder()
    }

    /**
     * The Function is newDecoder
     *
     * @return Type of Decoder
     * @since 0.28.4
     */
    public func newDecoder():Decoder{
        ShiftJISDecoder()
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
