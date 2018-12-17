//
//  ItemService.swift
//  countit
//
//  Created by David Grew on 11/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import Foundation
import CoreData

protocol ItemService {
    
    func saveItem(_ item: ItemDto) -> Bool
    
    func getItem(id: NSManagedObjectID) -> ItemDto?
    
    func getItems() -> [ItemDto]
}
