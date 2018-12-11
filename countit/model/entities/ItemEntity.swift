//
//  ItemEntity.swift
//  countit
//
//  Created by David Grew on 11/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import Foundation
import CoreData

class ItemEntity: NSManagedObject {

    init (of item: ItemDto, context: NSManagedObjectContext) {
        super.init(entity: ItemEntity.entity(), insertInto: context)
        self.id = item.id!.get()
        self.name = item.name
        self.itemDescription = item.description
    }
}
