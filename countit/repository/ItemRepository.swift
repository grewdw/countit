//
//  ItemRepository.swift
//  countit
//
//  Created by David Grew on 11/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import Foundation
import CoreData

protocol ItemRepository {
    
    func createItem(item: ItemDto) -> Bool
    
    func updateItem(id: NSManagedObjectID, updatedItem: ItemDto) -> Bool
    
    func getItem(with id: NSManagedObjectID) -> ItemDto?
    
    func getItems() -> [ItemDto]
}
