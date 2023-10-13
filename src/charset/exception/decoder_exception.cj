/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights resvered.
 */

/**
 * @file
 * This file is about encoder exception
 */

package charset.exception

public class DecoderException <: CharsetException {

    public init(msg: String) {
        super(msg)
    }

    public func toString(): String {
        return "DecoderException: " + message
    }
}
