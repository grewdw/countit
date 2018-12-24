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
    
    private let context: NSManagedObjectContext
    
    init (context: NSManagedObjectContext) {
        self.context = context
    }
    
    func create(item: ItemDto, atPosition position: Int) -> Bool {
        let item = itemEntityFrom(itemDto: item)
        item.listPosition = Int16(position)
        return saveContext()
    }
    
    func update(item: ItemDto, with id: NSManagedObjectID) -> Bool {
        let itemEntity: ItemEntity? = getItem(with: id)
        if itemEntity != nil {
            itemEntity!.name = item.getName()
            itemEntity!.itemDescription = item.getDescription()
            return saveContext()
        }
        return false
    }
    
    func updateItemWith(id: NSManagedObjectID, toListPosition position: Int) -> Bool {
        let itemEntity: ItemEntity? = getItem(with: id)
        if itemEntity != nil {
            itemEntity!.listPosition = Int16(position)
            return saveContext()
        }
        return false
    }

    func getItem(with id: NSManagedObjectID) -> ItemDto? {
        let item: ItemEntity? = getItem(with: id)
        if item == nil || item?.name == nil {
            return nil
        }
        return ItemDto(itemEntity: item!)
    }
    
    private func getItem(with id: NSManagedObjectID) -> ItemEntity? {
        return context.object(with: id) as? ItemEntity ?? nil
    }
    
    func getItems() -> [ItemDto] {
        let request: NSFetchRequest<ItemEntity> = ItemEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "listPosition", ascending: true)]
        return itemEntityArrayToDto(getItems(with: request))
    }
    
    func getLowestListPosition() -> ItemDto? {
        let request: NSFetchRequest<ItemEntity> = ItemEntity.fetchRequest()
        request.fetchLimit = 1
        request.sortDescriptors = [NSSortDescriptor(key: "listPosition", ascending: false)]
        let resultsArray = getItems(with: request)
        
        if resultsArray.count != 0 {
            return ItemDto(itemEntity: resultsArray[0])
        }
        else {
            return nil
        }
    }
    
    func delete(itemWithId id: NSManagedObjectID) -> Bool {
        if let item = context.object(with: id) as? ItemEntity {
            context.delete(context.object(with: item.objectID))
            return saveContext()
        }
        else {
            return false
        }
    }
    
    private func getItems(with request: NSFetchRequest<ItemEntity>) -> [ItemEntity] {
        do {
            let items: [ItemEntity] = try context.fetch(request)
            return items
        } catch {
            return [ItemEntity]()
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
