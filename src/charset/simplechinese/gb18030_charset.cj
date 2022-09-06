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
public func newGB18030Charset():Charset {
    GB18030Charset()
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
        // Actual number of characters gb18030 > gbk > gb2312 , for ease of handling, 将 gb2312, gbk all as gb18030
        // super("gb18030", ["gb18030", "chinese", "csgb2312", "csiso58gb231280", "gb2312", "gb_2312", "gb_2312-80", "gbk", "iso-ir-58", "x-gbk"])
        this.name = "gb18030"
        this.labels = ["gb18030", "chinese", "csgb2312", "csiso58gb231280", "gb2312", "gb_2312", "gb_2312-80", "gbk", "iso-ir-58", "x-gbk"]
    }

    /**
     * The Function is newEncoder
     *
     * @return Type of Encoder
     * @since 0.28.4
     */
    public func newEncoder():Encoder{
        var encoder = GB18030Encoder()
        return encoder
    }
    
    /**
     * The Function is newDecoder
     *
     * @return Type of Decoder
     * @since 0.28.4
     */
    public func newDecoder():Decoder{
        var decoder = GB18030Decoder()
        return decoder
    }
}