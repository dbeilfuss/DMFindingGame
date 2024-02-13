//
//  WelcomeScreen.swift
//  DMFindingGame
//
//  Created by Daniel Beilfuss on 1/18/24.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    let coreDataManager = CoreDataManager()
    
    override func viewDidAppear(_ animated: Bool) {
        showHighScore()
    }
    
    func showHighScore() {
        let highScore = coreDataManager.fetchHighScore()
        highScoreLabel.text = String(highScore)
    }
    
    @IBAction func newGameButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "welcomeToGame", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "welcomeToGame" {
            let gameViewController = segue.destination as! GameViewController
            gameViewController.modalPresentationStyle = .fullScreen
        }
    }
    
}
