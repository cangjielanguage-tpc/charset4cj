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
        this.name = "ISO-2022-JP"
        this.labels = ["ISO-2022-JP",  "csiso2022jp"]
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
        this.name = "EUC-JP"
        this.labels = ["cseucpkdfmtjapanese",  "euc-jp",  "x-euc-jp"]
    }

    /**
     * The Function is newEncoder
     *
     * @return Type of Encoder
     * @since 0.28.4
     */
    public func newEncoder():Encoder{
        let encoder = EUCJPEncoder()
        return encoder
    }

    /**
     * The Function is newDecoder
     *
     * @return Type of Decoder
     * @since 0.28.4
     */
    public func newDecoder():Decoder{
        let decoder = EUCJPDecoder()
        return decoder
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
        this.name = "Shift_JIS"
        this.labels = ["csshiftjis","ms932","ms_kanji","shift-jis","shift_jis","sjis","windows-31j","x-sjis"]
    }

    /**
     * The Function is newEncoder
     *
     * @return Type of Encoder
     * @since 0.28.4
     */
    public func newEncoder():Encoder{
        let encoder = ShiftJISEncoder()
        return encoder
    }

    /**
     * The Function is newDecoder
     *
     * @return Type of Decoder
     * @since 0.28.4
     */
    public func newDecoder():Decoder{
        let decoder = ShiftJISDecoder()
        return decoder
    }
}