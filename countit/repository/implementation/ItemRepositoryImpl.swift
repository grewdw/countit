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
    
    func updateItem(id: NSManagedObjectID, updatedItem: ItemDto) -> Bool {
        let item: ItemEntity? = getItem(with: id)
        if item != nil {
            item!.name = updatedItem.getName()
            item!.itemDescription = updatedItem.getDescription()
            return saveContext()
        }
        return false
    }
    
    private func saveContext() -> Bool {
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func getItem(with id: NSManagedObjectID) -> ItemDto? {
        let item: ItemEntity? = getItem(with: id)
        if item != nil {
            return ItemDto(itemEntity: item!)
        }
        return nil
    }
    
    private func getItem(with id: NSManagedObjectID) -> ItemEntity? {
        return context.object(with: id) as? ItemEntity ?? nil
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
