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
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do{
                try context.save()
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
    func addScore(score: Int) {
        
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
