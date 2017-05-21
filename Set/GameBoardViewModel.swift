//
//  CardBoard.swift
//  Set
//
//  Created by .jsber on 24/03/17.
//  Copyright © 2017 jo.on. All rights reserved.
//

import UIKit

typealias Player = Int

enum Difficulty {
    case easy, medium, difficult
    
//    var numberOfProperties: Int {
//        switch self {
//        case .easy:
//            return 2
//        case .medium:
//            return 3
//        case .difficult:
//            return 4
//        }
//    }
}

enum GameType {
    case setGame(withDifficulty: Difficulty)
    
    var model: GameModel {
        switch self {
        case .setGame(let difficulty):
            return SetGameModel(withDifficulty: difficulty)
        }
    }
}

/// The game board ViewModel
class GameBoardViewModel: NSObject {
    // MARK: - Properties
    var gameType: GameType?
    var game: GameModel?
    var numberOfItemsInSection: Int = 3
    lazy var maximumSelectedCells: Int = {
        if let game = self.game {
            return game.numberOfCardsToSelectFromBoard
        }
        print("No game started yet. Try starting a game first!")
        return 0
    }()
    
    var numberOfSections: Int {
        if let cardsOnBoard = game?.cardsOnBoard {
            return cardsOnBoard.count / self.numberOfItemsInSection
        }
        return 0
    }
    
    var cardsForBoard: [Card] {
        if let game = game, let cardsOnBoard = game.cardsOnBoard {
            return cardsOnBoard
        }
        print("no cards on board")
        return []
    }
    var randomCardFromDeck: Card? {
        if let currentGame = game, !currentGame.endOfGame {
            return game!.cardDeck.getRandomCards(amount: 1).first!
        }
        print("no card to return")
        return nil
    }
    
    // MARK: - Instance Methods    
    func startGame(ofType gameType: GameType) {
        self.gameType = gameType
        self.game = self.gameType?.model
        
        game?.dealCards()
    }
    
    /// Returns a Boolean value that indicates whether the selected cards make a valid SET
    ///
    /// - Parameter selectedCards: <#selectedCards description#>
    /// - Returns: <#return value description#>
    func validate(_ selectedCards: [Card], for player: Player) -> Bool {
        print("checking cards....")
        guard let game = game else {
            print("There is no game??")
            return false
        }
        
        let validation = game.validate(selectedCards, for: player)
        print("validation: \(validation)")
//        print("score: \(game.totalScore)")
        
        // do we have to replace the selected cards with new cards
        return  validation
    }
    
    func timePenalty(for player: Player) {
        game?.timePenalty(for: player)
    }
    
    // MARK: - Private Methods
    func getScores() -> (player1: String, player2: String){
        guard let totalScore = game?.totalScore else {
            print("no scores found")
            return ("Score: 0","Score: 0")
        }
        let scoreInString = (player1: "Score: \(totalScore.player1)", player2: "Score: \(totalScore.player2)")
        return scoreInString
    }
}
