//
//  HighSoresViewController.swift
//  DMFindingGame
//
//  Created by Daniel Beilfuss on 2/8/24.
//

import UIKit

class HighSoresViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let coreDataManager = CoreDataManager()
    var highScoresArray: [HighScore] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHighScoresArray()
        configureTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HighScoreCell", bundle: nil), forCellReuseIdentifier: "HighScoreCell")
    }
    
    func configureHighScoresArray() {
        highScoresArray = coreDataManager.fetchAllScores()
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
}

extension HighSoresViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScoresArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighScoreCell", for: indexPath) as! HighScoreCell
        let scoreData = highScoresArray[indexPath.row]
        cell.set(scoreData: scoreData)
        return cell
    }
    
}
