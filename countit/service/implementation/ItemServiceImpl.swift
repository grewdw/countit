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
            return itemRepository.update(item: item, with: id)
        }
        else {
            let previousLowestPosition = itemRepository.getLowestListPosition()?.getListPosition()
            let newLowestPosition = previousLowestPosition != nil ? previousLowestPosition! + 1 : 0
            return itemRepository.create(item: item, atPosition: newLowestPosition)
        }
    }
    
    func getItem(id: NSManagedObjectID) -> ItemDto? {
        return itemRepository.getItem(with: id)
    }
    
    func getItems() -> [ItemDto] {
        return itemRepository.getItems()
    }
    
    func persistTableOrder(for items: [ItemDto]) {
        let itemCount = items.count - 1
        
        for position in 0...itemCount {
            items[position].setListPosition(newPosition: position)
            itemRepository.update(item: items[position], with: items[position].getId()!)
        }
    }
}
