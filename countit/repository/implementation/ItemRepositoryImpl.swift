//
//  ItemRepository.swift
//  countit
//
//  Created by David Grew on 11/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class ItemRepositoryImpl: ItemRepository {
    
    private final let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init () {
    }
    
    func createItem(item: ItemEntity) -> Bool {
        return saveContext()
    }
    
    func updateItem(id: NSManagedObjectID, item: ItemEntity) -> Bool {
       return true
    }
    
    private func saveContext() -> Bool {
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func getItems() -> [ItemEntity] {
        let request: NSFetchRequest<ItemEntity> = ItemEntity.fetchRequest()
        do {
            let items: [ItemEntity] = try context.fetch(request)
            return items
        } catch {
            return [ItemEntity]()
        }
        
    }
}
