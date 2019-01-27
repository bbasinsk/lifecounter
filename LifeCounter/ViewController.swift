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
    
    @IBOutlet var scores: [UILabel]!
    @IBOutlet var playerButtons: [PlayerButtons]!
    @IBOutlet weak var allAlive: UILabel!
    @IBOutlet weak var allAliveContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Update labels to reflect state of scores
        for (idx, scoreLabel) in self.scores.enumerated() {
            scoreLabel.text = String(self.playerScores[idx])
        }
        // Set state of all alive label and background
        allAlive.text = "All Players Alive"
        allAliveContainer.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0)
        
        // initialize player controls buttons
        for (idx, playerBtnGroup) in self.playerButtons.enumerated() {
            // set a player number for each set of player controls
            playerBtnGroup.playerNumber = idx
            
            // attach a button pressed event to each button
            for subview in playerBtnGroup.subviews {
                if let btn = subview as? UIButton {
                    btn.addTarget(self,
                                  action: #selector(ViewController.buttonPressed(sender:)),
                                  for: .touchUpInside)
                }
            }
        }
    }
    
    @objc func buttonPressed(sender: UIButton) {
        // get player number from the super view
        let playerNum: Int = (sender.superview as? PlayerButtons)?.playerNumber ?? 0

        switch sender.currentTitle! {
        case "-1": updatePlayerScore(player: playerNum, scoreChange: -1)
        case "+1": updatePlayerScore(player: playerNum, scoreChange: 1)
        case "-5": updatePlayerScore(player: playerNum, scoreChange: -5)
        case "+5": updatePlayerScore(player: playerNum, scoreChange: 5)
        default: return
        }
    }
    
    func updatePlayerScore(player: Int, scoreChange: Int) {
        self.playerScores[player] += scoreChange
        if (self.playerScores[player] < 1) {
            self.allAlive.text = "Player \(player + 1) LOSES!"
            self.allAliveContainer.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
        scores[player].text = String(self.playerScores[player])
    }
}

