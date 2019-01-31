//
//  ViewController.swift
//  LifeCounter
//
//  Created by Ben Basinski on 1/24/19.
//  Copyright © 2019 Ben Basinski. All rights reserved.
//

import UIKit

@IBDesignable class PlayerButtons: UIStackView {
    @IBInspectable var playerNumber: Int = 0
}

class ViewController: UIViewController {
    
    var playerScores: [Int] = [20,20,20,20]
    var numberOfPlayers: Int = 4
    @IBOutlet weak var numPlayersLabel: UILabel!
    
    @IBOutlet weak var addRemovePlayers: UIStepper!
    
    @IBOutlet weak var playerList: PlayerListView!
    
    @IBOutlet weak var allAlive: UILabel!
    @IBOutlet weak var allAliveContainer: UIView!
    
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var historyBtn: UIButton!
    var history: [(Int, Int)] = []
    
    var gameInProgress = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set state of all alive label and background
        allAlive.text = "All Players Alive"
        allAliveContainer.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
    
        // set state of number of players
        numPlayersLabel.text = "Number of Players: \(4)"
        
        for playerN in 0..<numberOfPlayers {
            playerList.addPlayer()
            for btn in playerList.getButtons(playerNumber: playerN) {
                btn.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
            }
        }
        
        addRemovePlayers.addTarget(self, action: #selector(changeNumberOfPlayers(sender:)), for: .touchUpInside)
        resetBtn.addTarget(self, action: #selector(resetGameAction(sender:)), for: .touchUpInside)
    }
    
    @objc func resetGameAction(sender: UIButton) {
        resetGame()
    }
    
    @objc func changeNumberOfPlayers(sender: UIStepper) {
        if self.numberOfPlayers != Int(sender.value) {
            self.numberOfPlayers = Int(sender.value)
            self.numPlayersLabel.text = "Number of Players: \(self.numberOfPlayers)"
            
            if playerList.playerViews.count < numberOfPlayers {
                playerList.addPlayer()
                playerScores.append(20)
                for btn in playerList.getButtons(playerNumber: numberOfPlayers - 1) {
                    btn.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
                }
            } else {
                playerList.removeLastPlayer()
                playerScores.removeLast()
            }
        }
    }
    
    @objc func buttonPressed(sender: ScoreUpdateButton) {
        if !gameInProgress {
            startGame()
        }
        
        let playerNum: Int = sender.playerNumber
        let scoreChange: Int = sender.tag
        
        updatePlayerScore(player: playerNum, scoreChange: scoreChange)
    }
    
    func startGame() {
        gameInProgress = true
        addRemovePlayers.isEnabled = false
    }
    
    func resetGame() {
        gameInProgress = false
        addRemovePlayers.isEnabled = true
        allAlive.text = "All Players Alive"
        allAliveContainer.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        numPlayersLabel.text = "Number of Players: \(4)"
        playerScores = [20,20,20,20]
        history = []
        playerList.resetList()
        for playerN in 0..<4 {
            playerList.addPlayer()
            for btn in playerList.getButtons(playerNumber: playerN) {
                btn.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
            }
        }
    }
    
    func updatePlayerScore(player: Int, scoreChange: Int) {
        self.playerScores[player] += scoreChange
        checkPlayerStatus(player: player)
        playerList.updateScore(playerNumber: player, newScore: playerScores[player])
        
        history.append((player, scoreChange))
    }
    
    func checkPlayerStatus(player: Int) {
        if (self.playerScores[player] < 1) {
            self.allAlive.text = "Player \(player + 1) LOSES!"
            self.allAliveContainer.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toHistorySegue") {
            let vc = segue.destination as! HistoryViewController
            vc.history = self.history
        }
    }
}

