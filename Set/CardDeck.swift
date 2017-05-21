//
//  CardsDeck.swift
//  Set
//
//  Created by .jsber on 24/03/17.
//  Copyright © 2017 jo.on. All rights reserved.
//

import Foundation

class CardDeck {
    var cards: [Card]
    
    init(ofSet cards: [Card]) {
        self.cards = cards
    }
    
    func getRandomCards(amount: Int) -> [Card] {
//        guard let _ = cards else { print("no cards in deck yet"); return []}
            var cardsToReturn: [Card] = []
            for _ in 1...amount {
                let index = arc4random_uniform(UInt32(cards.count))
                print("index in cardDeck: \(index)")
                let cardToReturn = cards.remove(at: Int(index))
                cardsToReturn.append(cardToReturn)
            }
            return cardsToReturn
    }
}
