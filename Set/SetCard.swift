//
//  Card.swift
//  Set
//
//  Created by .jsber on 24/03/17.
//  Copyright © 2017 jo.on. All rights reserved.
//

import Foundation

enum SetCardProperties: UInt32 {
    case color
    case number
    case shading
    case shape
    
    private static let count: SetCardProperties.RawValue = {
        // find the maximum enum value
        var maxValue: UInt32 = 0
        while let _ = SetCardProperties(rawValue: maxValue) {
            maxValue += 1
        }
        return maxValue
    }()
    
    static func randomProperties(_ n: Int) -> [SetCardProperties] {
        // pick and return a new value
        let rawValues = Array(0...(count - 1))
        let choosenValues = rawValues.shuffled.choose(n)
        return choosenValues.map { SetCardProperties(rawValue: $0)! }
    }
}



/// Card for a SET game
class SetCard: Card {
    var shape: Shape {
        guard let properties = stringToCardPropertiesTranslation[character] else {
            fatalError("You are playing with the wrong cards!")
        }
        return properties.shape
    }
    var number: Number {
        guard let properties = stringToCardPropertiesTranslation[character] else {
            fatalError("You are playing with the wrong cards!")
        }
        return properties.number
    }
    var shading: Shading {
        guard let properties = stringToCardPropertiesTranslation[character] else {
            fatalError("You are playing with the wrong cards!")
        }
        return properties.shading
    }
    
//    cardPropertyRepresentationOf
//    var character: String {
//        return characterArray[shape.index][shading.index][number.index]
//    }
    
//    init(shape: Shape, color: Int, shading: Shading, number: Number) {
//        self.shape = shape
//        self.color = color
//        self.number = number
//        self.shading = shading
//        self.character = ""
//        self.hexColor = 3
//    }
}
