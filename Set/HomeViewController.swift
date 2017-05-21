//
//  HomeViewController.swift
//  Set
//
//  Created by .jsber on 12/04/17.
//  Copyright © 2017 jo.on. All rights reserved.
//

import UIKit



class HomeViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var dualPlayerSwitch: UISwitch!
    @IBOutlet weak var chooseGameButton: UIButton!
    @IBOutlet weak var setDifficultyButton: UIButton!
    
    var gameTypeString = ""
    var difficulty: Difficulty?
    var dualPlayer: Bool {
        return dualPlayerSwitch.isOn
    }
    
    lazy var gameTypeTranslation: [String:GameType] = {[unowned self] in
        guard let difficulty = self.difficulty else {
            print("no difficulty set yet.")
            return [:]
        }
        return ["set" : GameType.setGame(withDifficulty: difficulty)]
    }()
    
    var gameSettings: GameSettings?

    // MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "StartGameSegue" {
            if gameSettings == nil {
                print("gameSettings not set yet")
            }
            guard self.difficulty != nil else {
                print("You have to set a difficulty before you can continue")
                return false
            }
            
            guard self.gameTypeString != "" else {
                print("You have to select a game type")
                return false
            }
            
            guard let gameType = gameTypeTranslation[gameTypeString] else {
                print("The gameType seems to be wrong :/")
                return false
            }
            
            // set game settings
            gameSettings = GameSettings(gameType: gameType, difficulty: difficulty!, dualPlayer: dualPlayer)
        }
        return true
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartGameSegue", let destinationVC = segue.destination as? GameBoardViewController {
            destinationVC.gameSettings = self.gameSettings
        }
    }
 
    
    // MARK: - IBActions
    @IBAction func chooseGame(_ sender: UIButton) {
        let setAction = UIAlertAction(title: "Set", style: .default, handler: {_ in
            self.gameTypeString = "set"
            self.chooseGameButton.setTitle("SET", for: .normal)
        })
        showActionSheet("Choose a game", withTitle: "", actions: [setAction])
    }
    
    @IBAction func setDifficulty(_ sender: UIButton) {
        let actions = [
            UIAlertAction(title: "easy", style: .default, handler: {_ in
                self.difficulty = .easy
                self.setDifficultyButton.setTitle("Easy", for: .normal)
            }),
            UIAlertAction(title: "medium", style: .default, handler: {_ in
                self.difficulty = .medium
                self.setDifficultyButton.setTitle("Medium", for: .normal)
            }),
            UIAlertAction(title: "difficult", style: .default, handler: {_ in
                self.difficulty = .difficult
                self.setDifficultyButton.setTitle("Difficult", for: .normal)
            })
        ]
        
        showActionSheet("Set difficulty:", withTitle: "", actions: actions)
    }
//    
//    @IBAction func setDualplayer(_ sender: UISwitch) {
//        self.gameSettings?.dualplayer = sender.isOn
//    }
    
    // MARK: - Private Methods
    private func showActionSheet(_ alert: String, withTitle title: String, actions: [UIAlertAction]){
        let alertController = UIAlertController(title: title, message: alert, preferredStyle: .actionSheet)
        _ = actions.map { alertController.addAction($0) }
        present(alertController, animated: true, completion: nil)
    }
}
