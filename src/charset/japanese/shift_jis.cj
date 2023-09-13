/*
 * Copyright (c) Cangjie Library Team 2022-2022. All rights resvered.
 */

package charset.japanese

import charset.encoding.*

class ShiftJISEncoder <: Encoder {

    /**
     * Encodes a string into a byte array
     *
     * @param str of String
     *
     * @return Type of Array<UInt8>
     * @since 0.28.4
     */
    public func encode(str:String): Array<UInt8> {
        if(str.size == 0){
            return Array<UInt8>()
        }
        let ref = Array<UInt8>(str.size * 2, item:0)
        var position = 0
        var arr = str.toCharArray()
        for(ch in arr){
            var codePoint:UInt32 = UInt32(ch)
            // If code point is an ASCII code point, return a byte whose value is code point.
            if(codePoint <= 0x80){
                ref[position] = UInt8(codePoint)
                position += 1
            }else if(codePoint == 0x00A5){
                ref[position] = 0x5C
                position += 1
            }else if(codePoint == 0x203E){
                ref[position] = 0x7E
                position += 1
            }else if(codePoint >= 0xFF61 && codePoint <= 0xFF9F){
                ref[position] = UInt8(codePoint - 0xFF61 + 0xA1)
                position += 1
            }else{
                if(codePoint == 0x2212){
                    codePoint = 0xFF0D
                }
                var index = indexShiftJISPointer(jis0208EncodeMapping, jis0208DecodeMapping, codePoint)
                if(index >= 0){
                    var pointer = UInt32(index)
                    let lead = UInt8(pointer / 188)
                    let leadOffset:UInt8 = if(lead < 0x1F) {0x81} else {0xC1}
                    let trail = UInt8(pointer % 188)
                    let offset:UInt8 = if(trail < 0x3F) {0x40} else {0x41}
                    ref[position] = UInt8(lead + leadOffset)
                    ref[position+1] = UInt8(trail + offset)
                    position += 2
                }else{
                    throw Exception("can't encode character "+ch.toString()+" illegal multibyte sequence")
                    // error
                    // ref[position] = replacement
                    // position += 1
                }
            }
        }
        return ref[0..position]
    }
    func indexShiftJISPointer(encodeMapping:Map<UInt32, UInt32>, decodeMapping:Array<UInt32>, codePoint:UInt32):Int64{
        var res:Int64 = -1
        if(!encodeMapping.isEmpty()){
            if(encodeMapping.contains(codePoint)){
                res = Int64(encodeMapping[codePoint])
            }
        }else{
            for(i in 0..decodeMapping.size){
                if(i >= 8272 && i <= 8835){
                    continue
                }
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



/**
 * ShiftJIS Character set decoder
 * ShiftJIS The single byte part is the same as ASCII
 *        The double byte part is ordinary cjk characters
 * @author freeonsky
 * @since 0.28.4
 */
class ShiftJISDecoder <: Decoder{
    // Replace character when decoding error
    let replacement = '\u{FFFD}'

    /**
     * Decode byte array SRC into character array dest
     * @param src input byte array
     * @param dest output Char array
     *
     * @return Type of (Int64, Int64): (srcIndex, destIndex)
     *         srcIndex Next unprocessed SRC subscript
     *         destIndex Next unhandled dest subscript
     * @since 0.28.4
     */
    public func decode(src:Array<UInt8>, dest:Array<Char>): (Int64, Int64) {
        var srcOffset:Int64 = 0
        var srcLimit:Int64 = src.size - 1
        var destStart:Int64 = 0
        // Index being processed by SRC
        var srcIndex = srcOffset
        // Dest index being processed
        var destIndex = destStart
        while(srcIndex <= srcLimit){
            if(destIndex >= dest.size){
                return (srcIndex, destIndex)
            }
            var u0 = src[srcIndex];
            // ASCII byte or 0x80, return a code point whose value is byte
            if(u0 <= 0x80){
                var c = Char(UInt32(u0))
                dest[destIndex] = c
                destIndex += 1
                srcIndex += 1
                continue
            }
            // If byte is in the range 0xA1 to 0xDF, inclusive, return a code point whose value is 0xFF61 - 0xA1 + byte
            if(u0 >= 0xA1 && u0 <= 0xDF){
                var c = Char(UInt32(0xFF61 - 0xA1 + UInt32(u0)))
                dest[destIndex] = c
                destIndex += 1
                srcIndex += 1
                continue
            }
            // two byte
            if((u0 >= 0x81 && u0 <= 0x9F) || (u0 >= 0xE0 && u0 <= 0xFC)){
                if(srcIndex + 1 > srcLimit){
                    // If only half of the double bytes are in SRC, return and wait for the subsequent data to enter SRC for reprocessing
                    return (srcIndex, destIndex)
                }
                var u1 = src[srcIndex+1]
                var pointer:Int64 = -1
                var codePoint:Char = '\u{0}'
                var offset:UInt8 = assignOffset(u1)
                var leadOffset:UInt8 = assignLeadOffset(u0)
                if((u1 >= 0x40 && u1 <= 0x7E) || (u1 >= 0x80 && u1 <=0xFC)){
                    pointer = Int64(u0 - leadOffset) * 188 + Int64(u1) - Int64(offset)
                }
                if(pointer >= 8836 && pointer <= 10715){
                    codePoint = Char(0xE000 - 8836 + pointer)
                    dest[destIndex] = codePoint
                    srcIndex += 2
                    destIndex += 1
                    continue
                }
                codePoint = match(jis0208DecodeMapping.get(pointer)){
                    case Some(c) => Char(c)
                    case None => replacement
                }
                dest[destIndex] = codePoint
                srcIndex += 2
                destIndex += 1
                continue
            }
            dest[destIndex] = replacement
            srcIndex += 1
            destIndex += 1
            continue
        }
        return (srcIndex, destIndex)
    }

    private func assignOffset(u1: UInt8): UInt8 {
        var offset: UInt8
        if (u1 < 0x7F) {
            offset = 0x40
        } else {
            offset = 0x41
        }
        return offset
    }

    private func assignLeadOffset(u0: UInt8): UInt8 {
        var leadOffset: UInt8
        if (u0 < 0xA0) {
            leadOffset = 0x81
        } else {
            leadOffset = 0xC1
        }
        return leadOffset
    }
}
