/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

package charset.japanese

import charset.encoding.*

/**
 * EUC-JP japanese encoding charset
 * @author freeonsky
 * @since 0.28.4
 */
public class EUCJPCharset <: Charset{

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
 * EUC-JP japanese encoding charset
 * @author freeonsky
 * @since 0.28.4
 */
public class ShiftJISCharset <: Charset{

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