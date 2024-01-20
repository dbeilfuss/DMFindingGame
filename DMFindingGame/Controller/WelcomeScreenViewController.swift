//
//  WelcomeScreen.swift
//  DMFindingGame
//
//  Created by Daniel Beilfuss on 1/18/24.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func newGameButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "welcomeToGame", sender: self)
    }
    
    
}
