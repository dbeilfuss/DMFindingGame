//
//  TimerManager.swift
//  DMFindingGame
//
//  Created by Daniel Beilfuss on 2/4/24.
//

import Foundation

class TimerManager {
    
    var secondsOnTheClock: Int? = 15
    var secondsRemaining = 0
    var timer: Timer?
    var updateTimerLabel: ((Int) -> Void)? // Callback
    
    func setTimer() {
        
        timer?.invalidate() // kill the timer if it is already running
        
        if let secondsOnTheClock = self.secondsOnTheClock {
            secondsRemaining = secondsOnTheClock
            
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    @objc func updateTimer() {
        updateTimerLabel?(secondsRemaining)
        if secondsRemaining > 0 {
            secondsRemaining -= 1
        } else {
            timer?.invalidate()
            print ("Time's Up!")
        }
    }
    
    func setTime(_ secondsOnTheClock: Int?) {
        self.secondsOnTheClock = secondsOnTheClock
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
}
