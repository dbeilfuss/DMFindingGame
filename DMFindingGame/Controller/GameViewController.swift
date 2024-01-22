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
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var nextRoundButton: UIButton!
    
    var activeLetterButtons = [UIButton]()
    var timesUp = false
    
    let gameModel = GameModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideViews(views: letterButtons)
        activeLetterButtons = getActiveLetterButtons()
        resetGameScreen(didWin: false)
        gameModel.newHand()
//        goalLabel.text = "Goal: \(gameModel.goal)"
        newHand(didAnswerCorrectly: true)
        timerLabel.text = "Find 5 Letters"
        
        // Timer Callback
        gameModel.updateTimerLabel = { [weak self] secondsRemaining in DispatchQueue.main.async {
            if secondsRemaining > 0 {
                
                // update timerLabel
                self?.timerLabel.text = "\(secondsRemaining)"
                
            } else if secondsRemaining <= 0 {
                self?.timerLabel.text = "Time's Up!"
                self?.timesUp = true
                self?.revealViews(views: [self!.doneButton! as UIView])
            }
        }
        }
        
    }
    
    func resetGameScreen(didWin: Bool) {
        print("resetting game screen: didWin: \(didWin)")
        let controlButtons: [UIView] = [doneButton, nextRoundButton]
                
        if didWin {
            revealViews(views: controlButtons)
            hideViews(views: letterButtons)
        } else {
            hideViews(views: controlButtons)
            revealViews(views: activeLetterButtons)
            gameModel.lettersNeeded = activeLetterButtons.count
        }
        updateScoreLabel()
    }
    
    func hideViews(views: [UIView]) {
        print("hiding \(views.count) views")
        for view in views {
            view.alpha = 0
        }
    }
    
    func revealViews(views: [UIView]) {
        print("revealing \(views.count) views")
        for view in views {
            view.alpha = 1
        }
    }
    
    func newHand(didAnswerCorrectly: Bool) {
        print("VC: newHand")
        gameModel.newHand()
        updateTargetLetterLabel(didAnswerCorrectly: didAnswerCorrectly)
        updateLetterButtons()
//        hideViews(views: [doneButton, nextRoundButton])
    }
    
    func updateTargetLetterLabel(didAnswerCorrectly: Bool) {
        print("updating target letter label: didAnswerCorrectly: \(didAnswerCorrectly)")
        let responseEmoji = gameModel.responseEmoji(didAnswerCorrectly: didAnswerCorrectly)
        
        timerLabel.text = responseEmoji
        
        targetLetterLabel.text = gameModel.targetLetter
        
    }
    
    func updateLetterButtons() {
        print("updating letter Buttons \(activeLetterButtons.count) times")
        for button in activeLetterButtons {
            button.setTitle(gameModel.nextLetter(), for: .normal)
            button.tintColor = UIColor.systemBlue
        }
    }
    
    func updateScoreLabel() {
        scoreLabel.text = "Score: \(gameModel.gameScore)"
    }
    
    func getActiveLetterButtons() -> [UIButton] {
        print("getting active letter buttons")
        let activeButtons = letterButtons.filter { $0.tag <= gameModel.round }
        return activeButtons
    }
    
    
    
    @IBAction func letterButtonTapped(_ sender: UIButton) {
        
        if timesUp != true {
            
            let answer: String = (sender.titleLabel?.text!)!
            
            let isCorrect = gameModel.checkAnswer(answer: answer)
            let didWin = gameModel.checkForWin()
            
            if didWin {
                
                // Victory Message
                let victoryMessage = "\(gameModel.responseEmoji(didAnswerCorrectly: true))\(gameModel.responseEmoji(didAnswerCorrectly: true))\(gameModel.responseEmoji(didAnswerCorrectly: true))"
                targetLetterLabel.text = victoryMessage
                
                var messageNumber = Int()
                
                if (gameModel.round - 1) > gameModel.gameChangeMessage.count {
                    messageNumber = gameModel.gameChangeMessage.count - 1
                } else {
                    messageNumber = gameModel.round - 2
                }
                
                timerLabel.text = gameModel.gameChangeMessage[messageNumber]
                
            }
            else {
                newHand(didAnswerCorrectly: isCorrect)
            }
            
            resetGameScreen(didWin: didWin)
        }
    }
    
    @IBAction func letterButtonTouchedDown(_ sender: UIButton) {
        
        if sender.titleLabel!.text! == targetLetterLabel.text {
            sender.tintColor = UIColor.systemGreen
        } else {
            sender.tintColor = UIColor.red
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            sender.tintColor = UIColor.systemBlue
        }
        
    }
    
    @IBAction func nextRoundButtonTapped(_ sender: UIButton) {
        activeLetterButtons = getActiveLetterButtons()
        resetGameScreen(didWin: false)
        gameModel.newRound()
        newHand(didAnswerCorrectly: true)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
}
