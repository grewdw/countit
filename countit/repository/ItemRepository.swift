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
    
    func create(item: ItemDto, atPosition position: Int) -> Bool
    
    func update(item: ItemDto, with id: NSManagedObjectID) -> Bool
    
    func getItem(with id: NSManagedObjectID) -> ItemDto?
    
    func getItems() -> [ItemDto]
    
    func getLowestListPosition() -> ItemDto?
    
    func delete(itemWithId _id: NSManagedObjectID) -> Bool
}
