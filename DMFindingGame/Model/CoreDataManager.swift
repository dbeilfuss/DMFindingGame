//
//  CoreDataManager.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 4/24/23.
//

import CoreData

class CoreDataManager {
    //MARK: - Setup
    static let shared = CoreDataManager()
    var context: NSManagedObjectContext?
    
    init () {
        context = persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Fatal error loading DataModel: \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    func saveContext () {
        if context!.hasChanges {
            do{
                try context!.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.localizedDescription)")
            }
        }
    }
    
    //MARK: - CRUD
    
    func addScore(playerName: String, score: Int) {
        let newHighScore: HighScore = HighScore(context: context!)
        newHighScore.playerName = playerName
        newHighScore.score = Int16(score)
        saveContext()
    }

    func fetchAllScores() -> [HighScore] {
        var highScoresArray: [HighScore] = []
        let request : NSFetchRequest<HighScore> = HighScore.fetchRequest()
        do {
            try highScoresArray = context!.fetch(request)
        } catch {
            print("error fetching data from context: \(error)")
        }
        highScoresArray = highScoresArray.sorted { $0.score > $1.score } // sort descending
        return highScoresArray
    }
    
    func fetchHighScore() -> Int {
        let highScoresAray = fetchAllScores()
        var highScore: Int = 0
        if highScoresAray.count > 0 {
            highScore = Int(highScoresAray[0].score)}
        
        return highScore
    }
    
}
