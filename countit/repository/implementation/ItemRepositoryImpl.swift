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
    
    func createItem(item: ItemDto) -> Bool {
        itemEntityFrom(itemDto: item)
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
    
    func getItems() -> [ItemDto] {
        let request: NSFetchRequest<ItemEntity> = ItemEntity.fetchRequest()
        do {
            let items: [ItemEntity] = try context.fetch(request)
            return itemEntityArrayToDto(items)
        } catch {
            return [ItemDto]()
        }
    }
    
    private func itemEntityFrom(itemDto: ItemDto) -> ItemEntity {
        let item = ItemEntity(context: context)
        item.name = itemDto.getName()
        item.itemDescription = itemDto.getDescription()
        return item
    }
    
    private func itemEntityArrayToDto(_ entities: [ItemEntity]) -> [ItemDto] {
        var itemDtos: [ItemDto] = []
        for item in entities {
            itemDtos.append(ItemDto(itemEntity: item))
        }
        return itemDtos
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
