//
//  PlayerListView.swift
//  LifeCounter
//
//  Created by Ben Basinski on 1/30/19.
//  Copyright © 2019 Ben Basinski. All rights reserved.
//

import UIKit

class PlayerListView: UIStackView {
    
    var playerViews: [PlayerView] = []
    
    func addPlayer(){
        let playerNumber: Int = playerViews.count
        
        let playerView = PlayerView();
        
        playerView.playerNum = playerNumber
        playerView.name.text = "Player \(playerNumber + 1)"
        
        for btn in playerView.updateScoreBtns {
            btn.playerNumber = playerNumber
        }
        
        self.addArrangedSubview(playerView)
        
        playerViews.append(playerView)
    }
    
    func removeLastPlayer() {
        removePlayer(playerNumber: playerViews.count - 1)
    }
    
    func removePlayer(playerNumber: Int) {
        playerViews.remove(at: playerNumber)
        
        for view in self.subviews {
            let playerView = view as! PlayerView
            if playerView.playerNum == playerNumber {
                playerView.removeFromSuperview()
            }
        }
    }
    
    
    func updateScore(playerNumber: Int, newScore: Int) {
        self.playerViews[playerNumber].score.text = String(newScore)
    }
    
    func getButtons(playerNumber: Int) -> [ScoreUpdateButton] {
        return self.playerViews[playerNumber].updateScoreBtns
    }
    
    func resetList() {
        playerViews = []
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
}
