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
    
    func createItem(item: ItemEntity) -> Bool
    
    func updateItem(id: NSManagedObjectID, item: ItemEntity) -> Bool
    
    func getItems() -> [ItemEntity]
}
