//
//  Game.swift
//  Set
//
//  Created by .jsber on 29/03/17.
//  Copyright © 2017 jo.on. All rights reserved.
//

import Foundation

protocol GameModel {
    var numberOfCardsToSelectFromBoard: Int { get }
    var cardDeck: CardDeck { get set }
    var cardsOnBoard: [Card]? { get set }
    var totalScore: (player1: Int, player2: Int) { get set }
    
    var endOfGame: Bool { get }
    
    func dealCards()
    func validate(_: [Card], for: Player) -> Bool
    func timePenalty(for: Player)
}

class SetGameModel: GameModel {
    // MARK: - Properties
    let numberOfCardsToSelectFromBoard = 3
    let initialNumberOfCardsOnBoard = 12
    
    var cardDeck: CardDeck
    var cardsOnBoard: [Card]?
    
    var scoreForCorrect = 1
    var scoreForIncorrect = -1
    
    var timePenaltyValue = 1
    
    var totalScore: (player1: Int, player2: Int) = (0,0)
    
    var endOfGame: Bool {
        return cardDeck.cards.isEmpty
    }
    
    // MARK: - Init
    init(withDifficulty difficulty: Difficulty) {
        self.cardDeck = setCardDeckFactory.generateCardDeck(withDifficulty: difficulty)
    }
    
    // MARK: - Instance Methods
    func dealCards() {
        self.cardsOnBoard = self.cardDeck.getRandomCards(amount: initialNumberOfCardsOnBoard)
        print("deal done")
    }
    
    func validate(_ selectedCards: [Card], for player: Player) -> Bool {
        let selectedSetCards = getSetCards(fromCards: selectedCards)
        let selectedSet = makeASet(fromCards: selectedSetCards)
        
        var scoreToAdd = 0
        
        // deside what to add score
        if selectedSet.isCorrect {
            scoreToAdd = scoreForCorrect
        } else {
            scoreToAdd = scoreForIncorrect
        }
        
        // deside to wich palyer to add score
        if player == 1 {
            totalScore.player1 += scoreToAdd
        } else {
            totalScore.player2 += scoreToAdd
        }
        
        return selectedSet.isCorrect
    }
    
    func timePenalty(for player: Player) {
        // deside to wich palyer to add score
        if player == 1 {
            totalScore.player1 -= timePenaltyValue
        } else {
            totalScore.player2 -= timePenaltyValue
        }
    }
    
    // MARK: - Private Methods
    private func makeASet(fromCards cards: [SetCard]) -> aSet {
        var set = aSet()
        _ = cards.map {
            set.color.append($0.hexColor)
            
            // OPTIONALS STILL NEED TO BE CONTROLLED!!
            set.number.append($0.number)
            set.shading.append($0.shading)
            set.shape.append($0.shape)
        }
        return set
    }
    
    private func getSetCards(fromCards cards: [Card]) -> [SetCard]{
        return cards.map { SetCard(ofCharacter: $0.character, andHexColor: $0.hexColor) }
    }
}


struct aSet {
    var color: [Int]
    var number: [Number]
    var shading: [Shading]
    var shape: [Shape]
    
    init(color: [Int] = [], number: [Number] = [], shading: [Shading] = [], shape: [Shape] = []) {
        self.color = []
        self.number = []
        self.shading = []
        self.shape = []
    }
    
    var isCorrect: Bool {
        return colorIsCorrect && numberIsCorrect && shadingIsCorrect && shapeIsCorrect
    }
    
    private var colorIsCorrect: Bool {
        let uniqueColor = Set(self.color)
        return uniqueColor.count == 1 || uniqueColor.count == 3
    }
    
    private var numberIsCorrect: Bool {
        let uniqueNumber = Set(self.number)
        return uniqueNumber.count == 1 || uniqueNumber.count == 3
    }
    
    private var shadingIsCorrect: Bool {
        let uniqueShading = Set(self.shading)
        return uniqueShading.count == 1 || uniqueShading.count == 3
    }
    
    private var shapeIsCorrect: Bool {
        let uniqueShape = Set(self.shape)
        return uniqueShape.count == 1 || uniqueShape.count == 3
    }
}
