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
            return itemRepository.updateItem(id: id, updatedItem: item)
        }
        else {
            return itemRepository.createItem(item: item)
        }
    }
    
    func getItem(id: NSManagedObjectID) -> ItemDto? {
        return itemRepository.getItem(with: id)
    }
    
    func getItems() -> [ItemDto] {
        return itemRepository.getItems()
    }
}
