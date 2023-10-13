/*
 * Copyright (c) Cangjie Library Team 2023-2023. All rights resvered.
 */

/**
 * @file
 * This file is about encoder exception
 */

package charset.exception

public open class CharsetException <: Exception {

    public init(msg: String) {
        super(msg)
    }

    public open func toString(): String {
        return "CharsetException: " + message
    }
}
