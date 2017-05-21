//
//  Number.swift
//  Set
//
//  Created by .jsber on 24/03/17.
//  Copyright © 2017 jo.on. All rights reserved.
//

import Foundation

enum Number: UInt32 {
    case one, two, three
    
    var index: Int {
        switch self {
        case .one: //["A","D","G","J","M","P","S","V","Y"]
            return 0
        case .two: //["B","E","H","K","N","Q","T","W","Z"]
            return 1
        case .three: //["C","F","I","L","O","R","U","X","a"]
            return 2
        }
    }
    
    private static let count: Number.RawValue = {
        // find the maximum enum value
        var maxValue: UInt32 = 0
        while let _ = Number(rawValue: maxValue) {
            maxValue += 1
        }
        return maxValue
    }()
    
    static func randomNumber() -> Number {
        // pick and return a new value
        let random = arc4random_uniform(count)
        return Number(rawValue: random)!
    }
}
