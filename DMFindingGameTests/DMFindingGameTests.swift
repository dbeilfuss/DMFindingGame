//
//  DMFindingGameTests.swift
//  DMFindingGameTests
//
//  Created by David Ruvinskiy on 3/1/23.
//

import XCTest
@testable import DMFindingGame

final class DMFindingGameTests: XCTestCase {
    
    var viewController: GameViewController!
    var gameModel: GameModel!

    override func setUp() {
        super.setUp()
        
        viewController = GameViewController()
        gameModel = GameModel()
        
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewController = nil
    }
    
    func testGenerateRandomLetters() {
        for _ in 1...100 {
            let targetLetter = gameModel.alphabet.randomElement()!
            gameModel.targetLetter = targetLetter
            
            let numLetters = Int.random(in: 1...12)
            let randomLetters = gameModel.generateRandomLetters(numLetters: numLetters)
            
            XCTAssertEqual(randomLetters.count, numLetters)
            XCTAssertEqual(Set(randomLetters).count, randomLetters.count)
            XCTAssertTrue(randomLetters.contains(targetLetter))
        }
    }
    
    func testCalculateNewScore() {
        for _ in 1...100 {
            let targetLetter = gameModel.alphabet.randomElement()!
            gameModel.targetLetter = targetLetter
            
            let randomScore = Int.random(in: 1...100)
            gameModel.score = randomScore
            
            let userChoseCorrectLetter = Bool.random()
            
            if userChoseCorrectLetter {
                gameModel.checkAnswer(answer: targetLetter)
                XCTAssertEqual(gameModel.score, randomScore + 1)
            } else {
                let filteredArray = gameModel.alphabet.filter { $0 != targetLetter }
                let randomLetter = filteredArray.randomElement()!
                gameModel.checkAnswer(answer: randomLetter)
                
                XCTAssertEqual(gameModel.score, randomScore)
            }
        }
    }
}
