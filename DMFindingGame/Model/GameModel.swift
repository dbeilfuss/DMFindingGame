//
//  GameModel.swift
//  DMFindingGame
//
//  Created by Daniel Beilfuss on 1/13/24.
//

import Foundation

import UIKit

class GameModel {
    
    let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    var letters = [String]()
    var lettersNeeded = 9
    var targetLetter = ""
    var roundScore = 0
    var gameScore = 0
    var goal = 5
    var round = 1
    var secondsOnTheClock = 15
    var secondsRemaining = 0
    var timer: Timer?
    var updateTimerLabel: ((Int) -> Void)? // Callback
    
    let gameChangeMessage = [
    "15 Seconds on the Clock",
    "Adding More Letters",
    "Adding More Letters",
    "Adding More Letters",
    "Adding More Letters",
    "Adding More Letters",
    "Less Time"
    ]
    
    func newRound() {
        print("GM: newRound: round: \(round)")
        roundScore = 0
        newHand()
        setTimer(secondsOnTheClock: secondsOnTheClock)
    }
    
    func newHand() {
        letters = generateRandomLetters(numLetters: lettersNeeded)
        
        if letters.count > 1 {
            targetLetter = letters.randomElement()!
        }
        
        
    }
    
    func nextLetter() -> String {
        let letterAndUpdatedArray = drawFromArray(array: letters)
        print("letterAndUpdateArray: \(letterAndUpdatedArray)")
        let nextLetter = letterAndUpdatedArray[0][0]
        letters = letterAndUpdatedArray[1]
        return nextLetter
    }
    
    func generateRandomLetters(numLetters: Int) -> [String] {
        print("generating \(numLetters) letters")
        
        var remainingLetters = alphabet
        var randomLetters = [String]()
        
        for _ in 1...numLetters {
            
            let letterAndUpdatedArray = drawFromArray(array: remainingLetters)
            let letter = letterAndUpdatedArray[0][0]
            remainingLetters = letterAndUpdatedArray[1]
            
            // add to the randomLetters Array
            randomLetters.append(letter)
        }
        
        print("randomLetters: \(randomLetters)")
        return randomLetters
    }
    
    func drawFromArray(array: [String]) -> [[String]] {
        var workingArray = array
        
        // safety first
        if workingArray.isEmpty {
            print("no data in array")
            return [[""]]
        }
        
        let randomItem: String = workingArray.randomElement()!
        if let index = array.firstIndex(of: randomItem) {
            workingArray.remove(at: index)
        }
        return [[randomItem], workingArray]
    }
    
    func checkAnswer(answer: String) -> Bool {
        if answer == targetLetter {
            gameScore += round
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
            round += 1
            timer?.invalidate()
            if round > 7 { secondsOnTheClock -= 2 }
            return true
        } else {
            print("Not a Win")
            return false
        }
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
    
    func setTimer(secondsOnTheClock: Int) {
        
        timer?.invalidate() // kill the timer if it is already running
        
        secondsRemaining = secondsOnTheClock

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        updateTimerLabel?(secondsRemaining)
        if secondsRemaining > 0 {
//            print("secondsRemaining: \(secondsRemaining)")
            secondsRemaining -= 1
        } else {
            timer?.invalidate()
            print ("Time's Up!")
        }
    }
    
}
