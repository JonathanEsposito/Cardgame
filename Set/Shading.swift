//
//  Shading.swift
//  Set
//
//  Created by .jsber on 24/03/17.
//  Copyright © 2017 jo.on. All rights reserved.
//

import Foundation

enum Shading: UInt32 {
    case solid, striped, outlined
    
    var index: Int {
        switch self {
        case .outlined: //["A","B","C","D","E","F","G","H","I"]
            return 0
        case .striped: //["J","K","L","M","N","O","P","Q","R"]
            return 1
        case .solid: //["S","T","U","V","W","X","Y","Z","a"]
            return 2
        }
    }
    
    private static let count: Shading.RawValue = {
        // find the maximum enum value
        var maxValue: UInt32 = 0
        while let _ = Shading(rawValue: maxValue) {
            maxValue += 1
        }
        return maxValue
    }()
    
    static func randomShading() -> Shading {
        // pick and return a new value
        let random = arc4random_uniform(count)
        return Shading(rawValue: random)!
    }
}
