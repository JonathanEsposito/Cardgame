//
//  Shape.swift
//  Set
//
//  Created by .jsber on 24/03/17.
//  Copyright © 2017 jo.on. All rights reserved.
//

import Foundation

enum Shape: UInt32 {
    case oval, diamond, squiggle
    
    var index: Int {
        switch self {
        case .diamond: //["A","B","C","J","K","L","S","T","U"]
            return 0
        case .oval: //["D","E","F","M","N","O","V","W","X"]
            return 1
        case .squiggle: //["G","H","I","P","Q","R","Y","Z","a"]
            return 2
        }
    }
    
    private static let count: Shape.RawValue = {
        // find the maximum enum value
        var maxValue: UInt32 = 0
        while let _ = Shape(rawValue: maxValue) {
            maxValue += 1
        }
        return maxValue
    }()
    
    static func randomShape() -> Shape {
        // pick and return a new value
        let random = arc4random_uniform(count)
        return Shape(rawValue: random)!
    }
}
