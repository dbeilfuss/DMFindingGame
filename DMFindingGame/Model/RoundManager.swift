//
//  Round.swift
//  DMFindingGame
//
//  Created by Daniel Beilfuss on 2/4/24.
//

import Foundation

struct RoundData {
    let round: Int
    let secondsOnTheClock: Int?
    let roundChangeMessage: String
    let pointValue: Int
    
    init(round: Int, secondsOnTheClock: Int?, roundChangeMessage: String, pointValue: Int) {
        self.round = round
        self.secondsOnTheClock = secondsOnTheClock
        self.roundChangeMessage = roundChangeMessage
        self.pointValue = pointValue
    }
}

class RoundManager {
    let roundsList: [RoundData] = [
        RoundData(round: 1, secondsOnTheClock: nil, roundChangeMessage: "Adding a Time Limit!", pointValue: 1),
        RoundData(round: 2, secondsOnTheClock: 15, roundChangeMessage: "Adding More Letters", pointValue: 1),
        RoundData(round: 3, secondsOnTheClock: 15, roundChangeMessage: "Adding More Letters", pointValue: 2),
        RoundData(round: 4, secondsOnTheClock: 15, roundChangeMessage: "Adding More Letters", pointValue: 5),
        RoundData(round: 5, secondsOnTheClock: 15, roundChangeMessage: "Adding More Letters", pointValue: 7),
        RoundData(round: 6, secondsOnTheClock: 15, roundChangeMessage: "Adding More Letters", pointValue: 10),
        RoundData(round: 7, secondsOnTheClock: 15, roundChangeMessage: "Less Time", pointValue: 12),
        RoundData(round: 8, secondsOnTheClock: 13, roundChangeMessage: "Less Time", pointValue: 15),
        RoundData(round: 9, secondsOnTheClock: 11, roundChangeMessage: "Less Time", pointValue: 20),
        RoundData(round: 10, secondsOnTheClock: 9, roundChangeMessage: "Less Time", pointValue: 35),
        RoundData(round: 11, secondsOnTheClock: 8, roundChangeMessage: "Less Time", pointValue: 50),
        RoundData(round: 12, secondsOnTheClock: 7, roundChangeMessage: "Less Time", pointValue: 75),
        RoundData(round: 13, secondsOnTheClock: 6, roundChangeMessage: "Less Time", pointValue: 100),
        RoundData(round: 14, secondsOnTheClock: 5, roundChangeMessage: "Keep Going!", pointValue: 200),
        RoundData(round: 15, secondsOnTheClock: 5, roundChangeMessage: "Keep Going!", pointValue: 300),
        RoundData(round: 16, secondsOnTheClock: 5, roundChangeMessage: "Keep Going!", pointValue: 400),
        RoundData(round: 17, secondsOnTheClock: 5, roundChangeMessage: "Keep Going!", pointValue: 500)
    ]
    
    func getRoundData(round passedRound: Int) -> RoundData {
        var roundData: RoundData = roundsList.first!
        
        if passedRound <= roundsList.count {
            roundData = roundsList.first(where: { $0.round == passedRound })!
        } else {
            roundData = roundsList.last!
        }
        
        return roundData
    }
    
}
