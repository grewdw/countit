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
    
    func saveItem(_ item: ItemUpdateDto) -> Bool
    
    func getItem(id: NSManagedObjectID) -> ItemSummaryDto?
    
    func getItems() -> [ItemSummaryDto]
    
    func persistTableOrder(for items: [ItemSummaryDto])
    
    func delete(itemWithId _id: NSManagedObjectID) -> Bool
}
