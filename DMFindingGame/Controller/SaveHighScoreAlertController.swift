//
//  SaveHighScoreAlertController.swift
//  DMFindingGame
//
//  Created by Daniel Beilfuss on 2/6/24.
//

import Foundation
import UIKit

class SaveHighScoreAlertController {
    func saveHighScore (gameModel: GameModel, viewController: UIViewController) {
        let score = gameModel.gameScore
        requestUserName(score: score, viewController: viewController) { [weak viewController] username in
            guard let self = viewController, let username = username else {
                return
            }
            gameModel.saveHighScore(username: username)
            viewController?.dismiss(animated: true)
        }
        
        // proceed with any other actions, such as revealing views
        
    }
    
    func requestUserName (score: Int, viewController: UIViewController, completion: @escaping (String?) -> Void) {
        let title = "You scored \(score) points!"
        let message = "Enter your name to save your score."
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField {textField in textField.placeholder = "Name"}
        
        let confirmAction = UIAlertAction(title: "Save", style: .default) { _ in let username = alert.textFields?.first?.text
            completion(username)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {_ in completion(nil)}
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
