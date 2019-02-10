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
    
    private let activityService: ActivityService
    private let itemRepository: ItemRepository
    private let clock: Clock
    
    init (activityService: ActivityService, itemRepository: ItemRepository, clock: Clock) {
        self.activityService = activityService
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
    
    func getItem(id: NSManagedObjectID) -> ItemSummaryDto? {
        if let item = itemRepository.getItemWithCurrentTarget(with: id) {
            return activityService.getCurrentTargetProgressFor(item: item)
        }
        return nil

    }
    
    func getItems() -> [ItemSummaryDto] {
        let itemDetailDtos = itemRepository.getItemsWithCurrentTargets()
        var itemSummaryDtos = [ItemSummaryDto]()
        for item in itemDetailDtos {
            itemSummaryDtos.append(activityService.getCurrentTargetProgressFor(item: item))
        }
        return itemSummaryDtos
    }
    
    func persistTableOrder(for items: [ItemSummaryDto]) {
        if items.count > 0 {
            var listPosition = 0
            for position in 0...items.count-1 {
                let itemId = items[position].getItemDetailsDto().getId()
                items[position].getItemDetailsDto().setListPosition(newPosition: listPosition)
                let _ = itemRepository.updateItemWith(id: itemId, toListPosition: listPosition)
                listPosition += 1
            }
        }
    }
    
    func delete(itemWithId id: NSManagedObjectID) -> Bool {
        return itemRepository.delete(itemWithId: id)
    }
}
