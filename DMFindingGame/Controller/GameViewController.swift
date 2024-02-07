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
//        goalLabel.text = "Goal: \(gameModel.goal)"
        gameModel.newRound(lettersNeeded: activeLetterButtons.count)
        self.newHand(didAnswerCorrectly: true)
        
        // Timer Callback
        gameModel.timerManager.updateTimerLabel = { [weak self] secondsRemaining in DispatchQueue.main.async {
            if secondsRemaining > 0 {
                
                // update timerLabel
                self?.timerLabel.text = "\(secondsRemaining)"
                
            } else if secondsRemaining <= 0 {
                self!.timerLabel.text = "Time's Up!"
                self!.timesUp = true
                self!.saveHighScoreAlertController.saveHighScore(gameModel: self!.gameModel, viewController: self!)
//                self!.revealViews(views: [self!.doneButton as UIView])
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
    
    func newHand(didAnswerCorrectly: Bool) {
        print("VC: newHand")
        let newHand: Hand = gameModel.newHand(lettersNeededCount: activeLetterButtons.count)
        updateTargetLetterLabel(didAnswerCorrectly: didAnswerCorrectly, targetLetter: newHand.targetLetter)
        updateLetterButtons(letters: newHand.availableLetters)
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
    
    func getActiveLetterButtons(round: Int) -> [UIButton] {
        print("getting active letter buttons")
        let activeButtons = letterButtons.filter { $0.tag <= round }
        return activeButtons
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
        gameModel.newRound(lettersNeeded: activeLetterButtons.count)
        activeLetterButtons = getActiveLetterButtons(round: gameModel.round)
        resetGameScreen(didWin: false)
        newHand(didAnswerCorrectly: true)
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
