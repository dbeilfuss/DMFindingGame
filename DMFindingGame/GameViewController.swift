//
//  GameViewController.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 2/19/23.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var targetLetterLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    let gameModel = GameModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameModel.newGame()
        goalLabel.text = "Goal: \(gameModel.goal)"
        targetLetterLabel.text = ""
        resetGameScreen(didWin: true)
    }
    
    func resetGameScreen(didWin: Bool) {
        if didWin {
            resetButton.alpha = 1
            for button in letterButtons{button.alpha = 0
            }
        } else {
            resetButton.alpha = 0
            for button in letterButtons{button.alpha = 1
            }
        }
        updateScoreLabel()
    }
    
    func newRound(didAnswerCorrectly: Bool) {
        gameModel.newRound()
        updateTargetLetterLabel(didAnswerCorrectly: didAnswerCorrectly)
        updateLetterButtons()
    }
    
    func updateTargetLetterLabel(didAnswerCorrectly: Bool) {
        let responseEmoji = gameModel.responseEmoji(didAnswerCorrectly: didAnswerCorrectly)
        
        targetLetterLabel.text = responseEmoji
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.targetLetterLabel.text = self.gameModel.targetLetter
        }
        
    }
    
    func updateLetterButtons() {
        for button in letterButtons {
            button.setTitle(gameModel.nextLetter(), for: .normal)
         }
    }
    
    func updateScoreLabel() {
        scoreLabel.text = "Score: \(gameModel.score)"
    }
    
    
    @IBAction func letterButtonTapped(_ sender: UIButton) {
        
        let answer: String = (sender.titleLabel?.text!)!
        
        let isCorrect = gameModel.checkAnswer(answer: answer)
        let didWin = gameModel.checkForWin()
        
        if didWin {
            let victoryMessage = "\(gameModel.responseEmoji(didAnswerCorrectly: true))\(gameModel.responseEmoji(didAnswerCorrectly: true))\(gameModel.responseEmoji(didAnswerCorrectly: true))"
            targetLetterLabel.text = victoryMessage
        } else {
            newRound(didAnswerCorrectly: isCorrect)
        }

        resetGameScreen(didWin: didWin)

    }
    
    @IBAction func newGameButtonTapped(_ sender: UIButton) {
        gameModel.newGame()
        resetGameScreen(didWin: false)
        newRound(didAnswerCorrectly: true)
    }
    
}
