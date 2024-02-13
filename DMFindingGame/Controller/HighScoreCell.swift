//
//  HighScoreCell.swift
//  DMFindingGame
//
//  Created by Daniel Beilfuss on 2/8/24.
//

import UIKit

class HighScoreCell: UITableViewCell {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    func set(scoreData: HighScore) {
        let playerName: String = scoreData.playerName ?? "No High Scores"
        let score: Int = Int(scoreData.score)
        playerNameLabel.text = playerName
        highScoreLabel.text = String(score)
    }
    
}
