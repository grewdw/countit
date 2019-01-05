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
    
}

// create functions
extension ItemRepositoryImpl {
    
    func createWithTarget(item: ItemDto, atPosition position: Int) -> Bool {
        let itemEntity = itemEntityFrom(itemDto: item)
        itemEntity.listPosition = Int16(position)
        let targetEntity = targetEntityFrom(targetDto: item.getCurrentTargetDto())
        targetEntity.current = true
        itemEntity.addToTarget(targetEntity)
        return saveContext()
    }
    
    func create(target: TargetDto, forItem itemId: NSManagedObjectID) -> Bool {
        if let item: ItemEntity = getItem(with: itemId) {
            if let currentTarget: TargetEntity = getCurrentTargetFor(item: item) {
                currentTarget.current = false
                let newTarget = targetEntityFrom(targetDto: target)
                newTarget.current = true
                item.addToTarget(newTarget)
                return saveContext()
            }
            else {
                return false
            }
        }
        else {
            return false
        }
    }
}

// update functions
extension ItemRepositoryImpl {
    
    func update(item: ItemDto, with id: NSManagedObjectID) -> Bool {
        if let itemEntity = getItem(with: id) {
            itemEntity.name = item.getName()
            itemEntity.itemDescription = item.getDescription()
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
}

// delete functions
extension ItemRepositoryImpl {
    
    func delete(itemWithId id: NSManagedObjectID) -> Bool {
        if let item = context.object(with: id) as? ItemEntity {
            context.delete(context.object(with: item.objectID))
            return saveContext()
        }
        else {
            return false
        }
    }
}

// get functions
extension ItemRepositoryImpl {
    
    func getItemWithCurrentTarget(with id: NSManagedObjectID) -> ItemDto? {
        if let item: ItemEntity = getItem(with: id) {
            let currentTarget = getCurrentTargetFor(item: item)
            return currentTarget == nil
                ? nil
                : ItemDto(itemEntity: item, targetEntity: currentTarget!)
        }
        else {
            return nil
        }
    }
    
    func getItemsWithCurrentTargets() -> [ItemDto] {
        var itemEntities = getItems()
        var targetEntities = [TargetEntity]()
        if itemEntities.count == 0 {
            return [ItemDto]()
        }
        for item in 0 ... itemEntities.count - 1 {
            if let target = getCurrentTargetFor(item: itemEntities[item]) {
                targetEntities.append(target)
            }
            else {
                itemEntities.remove(at: item)
            }
        }
        return itemAndTargetEntityToDto(itemEntities: itemEntities, targetEntities: targetEntities)
    }
    
    func getLowestListPosition() -> Int? {
        let request: NSFetchRequest<ItemEntity> = ItemEntity.fetchRequest()
        request.fetchLimit = 1
        request.sortDescriptors = [NSSortDescriptor(key: "listPosition", ascending: false)]
        let resultsArray = getItems(with: request)
        
        if resultsArray.count != 0 {
            return Int(resultsArray[0].listPosition)
        }
        else {
            return nil
        }
    }
    
    private func getItem(with id: NSManagedObjectID) -> ItemEntity? {
        return context.object(with: id) as? ItemEntity ?? nil
    }
    
    private func getItems() -> [ItemEntity] {
        let request: NSFetchRequest<ItemEntity> = ItemEntity.fetchRequest()
        request.predicate = NSPredicate(format: "ANY target.current == true")
        request.sortDescriptors = [NSSortDescriptor(key: "listPosition", ascending: true)]
        return getItems(with: request)
    }
    
    private func getCurrentTargetFor(item: ItemEntity) -> TargetEntity? {
        let request: NSFetchRequest<TargetEntity> = TargetEntity.fetchRequest()
        request.predicate = NSPredicate(format: "item == %@ AND current == true", item)
        let targets = getTargets(with: request)
        return targets.count != 0 ? targets[0] : nil
    }
    
    private func getItems(with request: NSFetchRequest<ItemEntity>) -> [ItemEntity] {
        do {
            let items: [ItemEntity] = try context.fetch(request)
            return items
        } catch {
            return [ItemEntity]()
        }
    }
    
    private func getTargets(with request: NSFetchRequest<TargetEntity>) -> [TargetEntity] {
        do {
            let targets: [TargetEntity] = try context.fetch(request)
            return targets
        } catch {
            return [TargetEntity]()
        }
    }
}

// utility functions
extension ItemRepositoryImpl {
 
    // conversions from dto to entities
    private func itemEntityFrom(itemDto: ItemDto) -> ItemEntity {
        let item = ItemEntity(context: context)
        item.name = itemDto.getName()
        item.itemDescription = itemDto.getDescription()
        return item
    }
    
    private func targetEntityFrom(targetDto: TargetDto) -> TargetEntity {
        let target = TargetEntity(context: context)
        target.direction = targetDto.getDirection().rawValue
        target.value = Int32(targetDto.getValue())
        target.timePeriod = targetDto.getTimePeriod().rawValue
        return target
    }
    
    // conversion from entities to dto
    private func itemAndTargetEntityToDto(itemEntities: [ItemEntity], targetEntities: [TargetEntity]) -> [ItemDto] {
        var itemDtos: [ItemDto] = []
        for item in 0 ... itemEntities.count - 1 {
            itemDtos.append(ItemDto(itemEntity: itemEntities[item], targetEntity: targetEntities[item]))
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
