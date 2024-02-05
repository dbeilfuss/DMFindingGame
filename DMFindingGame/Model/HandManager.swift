//
//  HandManager.swift
//  DMFindingGame
//
//  Created by Daniel Beilfuss on 2/4/24.
//

import Foundation

struct Hand {
    let targetLetter: String
    let availableLetters: [String]
}

class HandManager {
    let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    func newHand(_ lettersNeeded: Int) -> Hand {
        let availableLetters: [String] = generateRandomLetters(numLetters: lettersNeeded)
        let targetLetter: String = availableLetters.randomElement()!
        let newHand = Hand(targetLetter: targetLetter, availableLetters: availableLetters)
        return newHand
    }
    
    func getTargetLetter(_ availableLetters: [String]) -> String {
        let targetLetter = drawFromArray(array: availableLetters)[0][0]
        return targetLetter
    }
    
    func generateRandomLetters(numLetters: Int) -> [String] {
        print("generating \(numLetters) letters")
        
        var remainingLetters = alphabet
        var randomLetters = [String]()
        
        for _ in 1...numLetters {
            
            let letterAndUpdatedArray = drawFromArray(array: remainingLetters)
            let letter = letterAndUpdatedArray[0][0]
            remainingLetters = letterAndUpdatedArray[1]
            
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
    
}
