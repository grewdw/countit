//
//  CoreDataConfig.swift
//  countit
//
//  Created by David Grew on 23/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import Foundation
import CoreData

class CoreDataConfig {
    
    public static func getCoreDataContext(isSQLDatabase: Bool) -> NSManagedObjectContext {
        
        if !isSQLDatabase {
            let managedObjectModel: NSManagedObjectModel = {
                let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
                return managedObjectModel
            }()
            
            let persistantContainer: NSPersistentContainer = {
                let container = NSPersistentContainer(name: "countit", managedObjectModel: managedObjectModel)
                let description = NSPersistentStoreDescription()
                description.type = NSInMemoryStoreType
                description.shouldAddStoreAsynchronously = false
                
                container.persistentStoreDescriptions = [description]
                container.loadPersistentStores { (description, error) in
                    print("error loading persistent stores")
                }
                return container
            }()
            
            return persistantContainer.viewContext
        }
        else {
            let container = NSPersistentContainer(name: "countit")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container.viewContext
        }
    }
}
