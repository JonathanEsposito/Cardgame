//
//  Card.swift
//  Set
//
//  Created by .jsber on 24/03/17.
//  Copyright © 2017 jo.on. All rights reserved.
//

import Foundation

class Card {
    let character: String
    let hexColor: Int
    
    init(ofCharacter character: String, andHexColor hexColor: Int) {
        self.character = character
        self.hexColor = hexColor
    }
}

// Make Cards comparable
extension Card: Equatable {
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.character == rhs.character && lhs.hexColor == rhs.hexColor
    }
    
    
}
