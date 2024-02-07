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
//        CoreDataManager.context = persistentContainer.viewContext
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
    
    /**
     Add the passed score to CoreData.
     */
    func addScore(playerName: String, score: Int) {
        let newHighScore: HighScore = HighScore(context: context!)
        newHighScore.playerName = playerName
        newHighScore.score = Int16(score)
        print("highScore Data: \(newHighScore)")
        saveContext()
    }
    
    /**
     Retrieve all the scores from CoreData.
     */
//    func fetchScores() -> [Score] {
//        return []
//    }
    
    /**
     Calculate the high score.
     */
    func calculateHighScore() -> Int {
        return 0
    }
    

    
}
