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
    
    func createWithTarget(item: ItemDetailsDto, atPosition position: Int, withTimestamp timestamp: NSDate) -> Bool
    
    func create(target: TargetDto, forItem itemId: NSManagedObjectID, withTimestamp timestamp: NSDate) -> Bool
    
    func update(item: ItemDetailsDto, with id: NSManagedObjectID) -> Bool
    
    func updateItemWith(id: NSManagedObjectID, toListPosition position: Int) -> Bool
    
    func delete(itemWithId _id: NSManagedObjectID) -> Bool
    
    func getItemWithCurrentTarget(with id: NSManagedObjectID) -> ItemDetailsDto?
    
    func getItemsWithCurrentTargets() -> [ItemDetailsDto]
    
    func getLowestListPosition() -> Int?
    
}
