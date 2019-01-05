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
    
    func createWithTarget(item: ItemDto, atPosition position: Int) -> Bool
    
    func create(target: TargetDto, forItem itemId: NSManagedObjectID)  -> Bool
    
    func update(item: ItemDto, with id: NSManagedObjectID) -> Bool
    
    func updateItemWith(id: NSManagedObjectID, toListPosition position: Int) -> Bool
    
    func delete(itemWithId _id: NSManagedObjectID) -> Bool
    
    func getItemWithCurrentTarget(with id: NSManagedObjectID) -> ItemDto?
    
    func getItemsWithCurrentTargets() -> [ItemDto]
    
    func getLowestListPosition() -> Int?
    
}
