//
//  ItemServiceImpl.swift
//  countit
//
//  Created by David Grew on 11/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ItemServiceImpl: ItemService {
    
    private final var itemRepository: ItemRepository
    
    init (itemRepository: ItemRepository) {
        self.itemRepository = itemRepository
    }
    
    func saveItem(_ item: ItemDto) -> Bool {
        if let id = item.getId() {
            return updateItem(id: id, toItem: item)
        }
        else {
            return create(item: item)
        }
    }
    
    private func create(item: ItemDto) -> Bool {
        let previousLowestPosition = itemRepository.getLowestListPosition()
        let newLowestPosition = previousLowestPosition != nil ? previousLowestPosition!+1 : 0
        return itemRepository.createWithTarget(item: item, atPosition: newLowestPosition)
    }
    
    private func updateItem(id: NSManagedObjectID, toItem item: ItemDto) -> Bool {
        if let currentItem = itemRepository.getItemWithCurrentTarget(with: id) {
            if currentItem.getCurrentTargetDto().getValue() == item.getCurrentTargetDto().getValue() {
                return itemRepository.update(item: item, with: id)
            }
            else {
                let newTarget = create(newTarget: item.getCurrentTargetDto(), fromOldTarget: currentItem.getCurrentTargetDto())
                return itemRepository.update(item: item, with: id) && itemRepository.create(target: newTarget, forItem: id)
            }
        }
        return false
    }
    
    private func create(newTarget: TargetDto, fromOldTarget oldTarget: TargetDto) -> TargetDto {
        return TargetDto(
            direction: oldTarget.getDirection(),
            value: newTarget.getValue(),
            timePeriod: oldTarget.getTimePeriod())
    }
    
    func getItem(id: NSManagedObjectID) -> ItemDto? {
        return itemRepository.getItemWithCurrentTarget(with: id)
    }
    
    func getItems() -> [ItemDto] {
        return itemRepository.getItemsWithCurrentTargets()
    }
    
    func persistTableOrder(for items: [ItemDto]) {
        if items.count > 0 {
            var listPosition = 0
            for position in 0...items.count-1 {
                if let itemId = items[position].getId() {
                    items[position].setListPosition(newPosition: listPosition)
                    let _ = itemRepository.updateItemWith(id: itemId, toListPosition: listPosition)
                    listPosition += 1
                }
            }
        }
    }
    
    func delete(itemWithId id: NSManagedObjectID) -> Bool {
        return itemRepository.delete(itemWithId: id)
    }
}
