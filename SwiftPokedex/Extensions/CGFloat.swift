//
//  CGFloat.swift
//  SwiftPokedex
//
//  Created by Viktor Gidlöf on 2021-06-19.
//

import UIKit

extension CGFloat {
    typealias Range = (min: CGFloat, max: CGFloat)

    static func scale(value: CGFloat, xValue: CGFloat, toRange: Range = (min: 0.0, max: 1.0)) -> CGFloat {
        let inRange = Range(min: 0.0, max: xValue)

        assert(inRange.max > inRange.min)
        assert(toRange.max > toRange.min)

        if value < inRange.min {
            return toRange.min
        } else if value > inRange.max {
            return toRange.max
        } else {
            let ratio = (value - inRange.min) / (inRange.max - inRange.min)
            return toRange.min + ratio * (toRange.max - toRange.min)
        }
    }
}
