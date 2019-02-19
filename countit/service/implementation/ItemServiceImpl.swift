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
    
    private let itemRepository: ItemRepository
    private let clock: Clock
    
    init (itemRepository: ItemRepository, clock: Clock) {
        self.itemRepository = itemRepository
        self.clock = clock
    }
    
    func saveItem(_ item: ItemUpdateDto) -> Bool {
        if let id = item.getId() {
            return updateItem(id: id, toItem: item)
        }
        else {
            return create(item: item)
        }
    }
    
    private func create(item: ItemUpdateDto) -> Bool {
        let previousLowestPosition = itemRepository.getLowestListPosition()
        let newLowestPosition = previousLowestPosition != nil ? previousLowestPosition!+1 : 0
        return itemRepository.createWithTarget(item: item, atPosition: newLowestPosition, withTimestamp: clock.now())
    }
    
    private func updateItem(id: NSManagedObjectID, toItem item: ItemUpdateDto) -> Bool {
        if let currentItem = itemRepository.getItemWithCurrentTarget(with: id) {
            if currentItem.getValue() == item.getValue() {
                return itemRepository.update(item: item, with: id)
            }
            else {
                let updatedTarget = TargetDto(direction: item.getDirection(), value: item.getValue(), timePeriod: item.getTimePeriod())
                let oldTarget = TargetDto(direction: currentItem.getDirection(), value: currentItem.getValue(), timePeriod: currentItem.getTimePeriod())
                let newTarget = create(newTarget: updatedTarget, fromOldTarget: oldTarget)
                return itemRepository.update(item: item, with: id) && itemRepository.create(target: newTarget, forItem: id, withTimestamp: clock.now())
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
    
    func getItem(id: NSManagedObjectID) -> ItemDetailsDto? {
        if let item = itemRepository.getItemWithCurrentTarget(with: id) {
            return item
        }
        return nil

    }
    
    func getItems() -> [ItemDetailsDto] {
        return itemRepository.getItemsWithCurrentTargets()
    }
    
    func persistTableOrder(for items: [ItemDetailsDto]) {
        if items.count > 0 {
            var listPosition = 0
            for position in 0...items.count-1 {
                let itemId = items[position].getId()
                items[position].setListPosition(newPosition: listPosition)
                let _ = itemRepository.updateItemWith(id: itemId, toListPosition: listPosition)
                listPosition += 1
            }
        }
    }
    
    func delete(itemWithId id: NSManagedObjectID) -> Bool {
        return itemRepository.delete(itemWithId: id)
    }
}
