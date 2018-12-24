//
//  CoreDataConfig.swift
//  countitTests
//
//  Created by David Grew on 23/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import Foundation
import CoreData

class TestCoreDataConfig {
    
    public static func getCoreDataContext() -> NSManagedObjectContext {
        
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
}
