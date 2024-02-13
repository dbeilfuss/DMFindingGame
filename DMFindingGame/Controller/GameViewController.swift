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
    let saveHighScoreAlertController = SaveHighScoreAlertController()
    
    //MARK: - Initilization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeUIViews()
        initializeGame()
    }
    
    func initializeUIViews(){
        hideViews(views: letterButtons)
        activeLetterButtons = getActiveLetterButtons(round: 1)
        resetGameScreen(didWin: false)
    }
    
    func initializeGame() {
        gameModel.newRound(lettersNeeded: activeLetterButtons.count, timerDelegate: self)
        self.newHand(didAnswerCorrectly: true)
    }
    
    //MARK: - View Visibility
    
    func resetGameScreen(didWin: Bool) {
        print("resetting game screen: didWin: \(didWin)")
        let controlButtons: [UIView] = [doneButton, nextRoundButton]
                
        if didWin {
            revealViews(views: controlButtons)
            hideViews(views: letterButtons)
            timerLabel.text = gameModel.roundChangeMessage
        } else {
            hideViews(views: controlButtons)
            revealViews(views: activeLetterButtons)
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
    
    
    //MARK: - Game Functionality
    
    func newHand(didAnswerCorrectly: Bool) {
        print("VC: newHand")
        let newHand: Hand = gameModel.newHand(lettersNeededCount: activeLetterButtons.count)
        updateTargetLetterLabel(didAnswerCorrectly: didAnswerCorrectly, targetLetter: newHand.targetLetter)
        updateLetterButtons(letters: newHand.availableLetters)
    }
    
    func getActiveLetterButtons(round: Int) -> [UIButton] {
        print("getting active letter buttons")
        let activeButtons = letterButtons.filter { $0.tag <= round }
        return activeButtons
    }
    
    func updateTargetLetterLabel(didAnswerCorrectly: Bool, targetLetter: String) {
        print("updating target letter label: didAnswerCorrectly: \(didAnswerCorrectly)")
        let responseEmoji = gameModel.responseEmoji(didAnswerCorrectly: didAnswerCorrectly)
        
        timerLabel.text = responseEmoji
        
        targetLetterLabel.text = targetLetter
    }
    
    func updateLetterButtons(letters: [String]) {
        print("updating letter Buttons")
        var i = 0
        for button in activeLetterButtons {
            button.setTitle(letters[i], for: .normal)
            i += 1
            button.tintColor = UIColor.systemBlue
        }
    }
    
    func updateScoreLabel() {
        scoreLabel.text = "Score: \(gameModel.gameScore)"
    }
    
    func displayVictoryMessage () {
        let victoryMessage = "\(gameModel.responseEmoji(didAnswerCorrectly: true))\(gameModel.responseEmoji(didAnswerCorrectly: true))\(gameModel.responseEmoji(didAnswerCorrectly: true))"
        targetLetterLabel.text = victoryMessage
    }
    

    //MARK: - Buttons
    
    @IBAction func letterButtonTapped(_ sender: UIButton) {
        
        if timesUp != true {
            
            let answer: String = (sender.titleLabel?.text!)!
            let targetLetter: String = self.targetLetterLabel.text!
            
            let isCorrect = gameModel.checkAnswer(answer: answer, targetLetter: targetLetter)
            let didWin = gameModel.checkForWin()
            
            if didWin {
                displayVictoryMessage()
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
        gameModel.newRound(lettersNeeded: activeLetterButtons.count, timerDelegate: self)
        activeLetterButtons = getActiveLetterButtons(round: gameModel.round)
        resetGameScreen(didWin: false)
        newHand(didAnswerCorrectly: true)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}


//MARK: - Extension: TimerDelegate

extension GameViewController: TimerDelegate {
    func updateTimeLabel(timeRemaining: Int) {
        if timeRemaining > 0 {
            
            // update timerLabel
            timerLabel.text = "\(timeRemaining)"
            
        } else {
            timerLabel.text = "Time's Up!"
            timesUp = true
            saveHighScoreAlertController.saveHighScore(gameModel: gameModel, viewController: self)
        }
    }
    
}
