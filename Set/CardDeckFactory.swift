//
//  CardsDeckFactory.swift
//  Set
//
//  Created by .jsber on 24/03/17.
//  Copyright © 2017 jo.on. All rights reserved.
//

import Foundation

protocol CardDeckFactory {
    static func generateCardDeck(withDifficulty: Difficulty) -> CardDeck
}
