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
    
    func saveItem(itemDto: ItemDto) -> Bool {
        if let id = itemDto.getId() {
            return updateItem(id, itemDto)
        }
        else {
            return createItem(itemDto)
        }
    }
    
    private func createItem(_ item: ItemDto) -> Bool {
        let newItem = ItemEntity(context: context)
        newItem.name = item.getName()
        newItem.itemDescription = item.getDescription()
        return saveContext()
    }
    
    private func updateItem(_ id: NSManagedObjectID, _ item: ItemDto) -> Bool {
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
}
