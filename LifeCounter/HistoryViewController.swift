//
//  ViewController.swift
//  LifeCounter
//
//  Created by Ben Basinski on 1/24/19.
//  Copyright © 2019 Ben Basinski. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    
    
    @IBOutlet weak var historyView: UIStackView!
    var history: [(Int, Int)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (player, change) in self.history {
            createPlayerHistoryLabel(player: player, change: change)
        }
    }
    
    func createPlayerHistoryLabel(player: Int, change: Int) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .center
        if (change < 0) {
            label.text = "Player \(player + 1) lost \(abs(change)) live(s)"
        } else {
            label.text = "Player \(player + 1) gained \(abs(change)) live(s)"
        }
        self.historyView.addArrangedSubview(label)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toHome") {
            let vc = segue.destination as! ViewController
            vc.history = self.history
        }
    }
}

