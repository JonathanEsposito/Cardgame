//
//  ViewController.swift
//  Set
//
//  Created by .jsber on 24/03/17.
//  Copyright © 2017 jo.on. All rights reserved.
//

import UIKit

class GameBoardViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    @IBOutlet weak var gameBoardCollectionView: UICollectionView!
    @IBOutlet var gameBoardViewModel: GameBoardViewModel!
    
    @IBOutlet weak var player1SetButton: UIButton!
    @IBOutlet weak var player2SetButton: UIButton!
    
    @IBOutlet weak var player1ScoreLabel: UILabel!
    @IBOutlet weak var player2ScoreLabel: UILabel!
    
    @IBOutlet weak var player1CountDownLabel: UILabel!
    @IBOutlet weak var player2CountDownLabel: UILabel!
    
    var gameSettings: GameSettings?
    let defaultCountDownTime = 10
    var counter = 10
    
    var timer: Timer?
    
    // MARK: Get Cells / Cards / IndexPaths
    private var selectedIndexPaths: [IndexPath] {
        guard let indexPaths = gameBoardCollectionView.indexPathsForSelectedItems else {
            print("You have to select \(gameBoardViewModel.maximumSelectedCells) cards")
            return []
        }
        return indexPaths
    }
    
    private var selectedCells: [CardCellCollectionViewCell] {
        return selectedIndexPaths.flatMap { gameBoardCollectionView.cellForItem(at: $0) as? CardCellCollectionViewCell }
    }
    
    private var selectedCards: [Card] {
        return selectedCells.map { Card(ofCharacter: $0.cardLabel.text!, andHexColor: $0.cardLabel.textColor.asHexInt) }
    }
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get recieved game settings
        guard let gameSettings = self.gameSettings else {
            print("game settings not set!")
            return
        }
        // Do game Type
        gameBoardViewModel.startGame(ofType: gameSettings.gameType)
        print("start game done")
        
        // Do dualPlayer or singlePlayer
        //
        // To be implemented. Now by default only dual player
        //
        //
        
        // Make it possible to select multiple cells in collectionView
        gameBoardCollectionView.allowsMultipleSelection = true
        // Disable interaction untile player hits <<SET>> Button
        gameBoardCollectionView.isUserInteractionEnabled = false
        
        updateScores()
        
        player2CountDownLabel.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        player2SetButton.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        player2ScoreLabel.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        
        counter = defaultCountDownTime
        player2CountDownLabel.text = "\(defaultCountDownTime)"
        player1CountDownLabel.text = "\(defaultCountDownTime)"
    }

    // MARK: - CollectionView
    // MARK: DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return gameBoardViewModel.numberOfSections
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameBoardViewModel.numberOfItemsInSection
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CardCellCollectionViewCell else {
            fatalError("")
        }
        // Configure the cell
        print("indexPath: \(indexPath)")
        let index = (indexPath.section * gameBoardViewModel.numberOfItemsInSection) + indexPath.row
        let card = gameBoardViewModel.cardsForBoard[index]
        
        cell.cardLabel.text = card.character
        cell.cardLabel.textColor = UIColor(fromHexInt: card.hexColor)
        
        return cell
    }
    
    // MARK: Selection
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard selectedCells.count <= gameBoardViewModel.maximumSelectedCells else {
            self.gameBoardCollectionView.deselectItem(at: indexPath, animated: false)
            print("Player already selected maximum amount of cells")
            return
        }
        
        let cell = collectionView.cellForItem(at: indexPath)
        if cell?.isSelected == true {
            cell?.layer.borderWidth = 2.0
            cell?.layer.cornerRadius = 6
            cell?.layer.borderColor = UIColor.lightGray.cgColor
        } else {
            cell?.layer.borderWidth = 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 0
    }
    
    //// MARK: Delegate
    
    // MARK: FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width
        let availableHeight = collectionView.frame.height
        let widthPerItem = availableWidth / CGFloat(gameBoardViewModel.numberOfItemsInSection)
        let heightPerItem = availableHeight / CGFloat(gameBoardViewModel.cardsForBoard.count / gameBoardViewModel.numberOfItemsInSection)
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }

    // MARK: - IBActions
    @IBAction func playerFoundSet(_ sender: UIButton) {
        print("button pressed")
        // Enable user interaction on CollectionView
        gameBoardCollectionView.isUserInteractionEnabled = true
        
        // disable opponent's button
        if sender == player1SetButton {
            player2SetButton.isEnabled = false
        } else {
            player1SetButton.isEnabled = false
        }
        
        // choose action to take
        if sender.currentTitle == "Take!" {
            // if player selected enough cells
            if selectedIndexPaths.count == gameBoardViewModel.maximumSelectedCells {
                gameBoardCollectionView.isUserInteractionEnabled = false
                
                // player selected the correct cards
                if gameBoardViewModel.validate(selectedCards, for: sender.tag) {
                    // In each selected cell:
                    _ = selectedCells.map {
                        guard let newCard = gameBoardViewModel.randomCardFromDeck else {
                            print("End Of Game")
                            return
                        }
                        
                        // display a new card from our game deck
                        $0.cardLabel.text = newCard.character
                        $0.cardLabel.textColor = UIColor(fromHexInt: newCard.hexColor)
                    }
                }
                
                // stop timer and invalidate it
                stopTimer(for: sender.tag)
                
                // reset all turn related settings and prepair for next turn
                turnEnds(for: sender.tag)
                
                // update scores
                updateScores()
            } else {
                // do something!
                print("you have to select more cards!")
            }
            
            
        } else {
//            gameBoardViewModel.startTurn(for: sender.tag)
            sender.setTitle("Take!", for: .normal)
            startTimer(for: sender.tag)
        }
    }
    
    // MARK: - Private Methods
    private func updateScores() {
        (player1: player1ScoreLabel.text!, player2: player2ScoreLabel.text!) = gameBoardViewModel.getScores()
    }
    
    private func startTimer(for player: Player) {
        // defaultCountDownTime is already displayed and timer waits 1 interval before taking effect
        counter -= 1
        
        let countDownLabel = getCountDownLabel(for: player)
        
        countDownLabel.isHidden = false
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in
            if self.counter >= 0 {
                // display
                countDownLabel.text = "\(self.counter)"
                self.counter -= 1
            } else {
                self.stopTimer(for: player)
                self.turnEnds(for: player)
                self.timeIsUp(for: player)
                self.updateScores()
            }
        })
    }
    
    private func timeIsUp(for player: Player) {
        print("Time is up!")
        gameBoardViewModel.timePenalty(for: player)
    }
    
    private func stopTimer(for player: Player) {
        // hide countDownLabel for player
        getCountDownLabel(for: player).isHidden = true
        
        getCountDownLabel(for: player).text = "\(defaultCountDownTime)"
        // invalidate timer
        self.timer?.invalidate()
        self.counter = self.defaultCountDownTime
    }

    private func turnEnds(for player: Player) {
        // Disable interaction untile player hits <<SET>> Button
        gameBoardCollectionView.isUserInteractionEnabled = false
        // deselect all selected cells
        deselectAllSelectedCells()
        
        getSetButton(for: player).setTitle(">> SET <<", for: .normal)
        getSetButtonOfOpponent(for: player).isEnabled = true
    }
    
    private func deselectAllSelectedCells() {
        _ = selectedCells.map { $0.layer.borderWidth = 0 }
        
        // deselect all selected cells
        _ = selectedIndexPaths.map {
            self.gameBoardCollectionView.deselectItem(at: $0, animated: false)
        }
    }
    
    // MARK: get player UI elements
    private func getCountDownLabel(for player: Player) -> UILabel {
        if player == 1 {
            return player1CountDownLabel
        }
        return player2CountDownLabel
    }
    
    private func getSetButton(for player: Player) -> UIButton {
        if player == 1 {
            return player1SetButton
        }
        return player2SetButton
    }
    
    private func getSetButtonOfOpponent(for player: Player) -> UIButton {
        if player == 1 {
            return player2SetButton
        }
        return player1SetButton
    }
}

