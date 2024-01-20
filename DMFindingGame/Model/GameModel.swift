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
    var targetLetter = ""
    var score = 0
    var goal = 5
    
    func newGame() {
        score = 0
        print("score: \(score)")
        newRound()
    }
    
    func newRound() {
        letters = generateRandomLetters(numLetters: 9)
        
        if letters.count > 1 {
            targetLetter = letters.randomElement()!
        }
        
    }
    
    func nextLetter() -> String {
        let letterAndUpdatedArray = drawFromArray(array: letters)
        let nextLetter = letterAndUpdatedArray[0][0]
        letters = letterAndUpdatedArray[1]
        return nextLetter
    }
    
    func generateRandomLetters(numLetters: Int) -> [String] {
        
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
            score += 1
            print("Correct")
            return true
        } else {
            print("Incorrect")
            return false
        }
    }
    
    func checkForWin() -> Bool {
        if score >= goal {
            print("Win")
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
    
}
