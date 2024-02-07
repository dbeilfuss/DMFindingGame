//
//  GameModel.swift
//  DMFindingGame
//
//  Created by Daniel Beilfuss on 1/13/24.
//

import Foundation

import UIKit

class GameModel {
    
    let roundManager = RoundManager()
    let timerManager = TimerManager()
    let handManager = HandManager()
    let coreDataManager = CoreDataManager()
    
    var pointValue = 1
    var roundScore = 0
    var gameScore = 0
    var goal = 5
    var round = 0
    var roundChangeMessage = "Find 5 Letters!"
    
    func newRound(lettersNeeded: Int) {
        print("GM: newRound: round: \(round)")

        round += 1

        let newRoundData = roundManager.getRoundData(round: round)
        timerManager.setTime(newRoundData.secondsOnTheClock)
        roundChangeMessage = newRoundData.roundChangeMessage
        pointValue = newRoundData.pointValue
        
        roundScore = 0
        
        timerManager.setTimer()
    }
    
    func newHand(lettersNeededCount: Int) -> Hand {
        let newHand = handManager.newHand(lettersNeededCount)
        return newHand
    }
    
    func checkAnswer(answer: String, targetLetter: String) -> Bool {
        if answer == targetLetter {
            gameScore += pointValue
            roundScore += 1
            
            print("Correct")
            return true
        } else {
            print("Incorrect")
            return false
        }
    }
    
    func checkForWin() -> Bool {
        if roundScore >= goal {
            print("Win")
            
            let extraTimePoints = timerManager.secondsRemaining * pointValue
            print("added \(extraTimePoints) to score for extra time: \(gameScore) + \(extraTimePoints) = \(gameScore + extraTimePoints)")
            gameScore += extraTimePoints
            
            timerManager.stopTimer()
            return true
        } else {
            print("Not a Win")
            return false
        }
    }
    
    func saveHighScore (playerName: String) {
        coreDataManager.addScore(playerName: playerName, score: gameScore)
    }
    
    func responseEmoji(didAnswerCorrectly: Bool) -> String {
        let correctEmoji = ["😎", "🥰", "🤪", "🤩", "🥳"]
        let incorrectEmoji = ["😡", "🤬", "😤", "🥴", "🤕"]
        
        var emoji = String()
        
        if didAnswerCorrectly {
            emoji = correctEmoji.randomElement()!
        } else {
            emoji = incorrectEmoji.randomElement()!
        }
        
        return emoji
    }
    
}
