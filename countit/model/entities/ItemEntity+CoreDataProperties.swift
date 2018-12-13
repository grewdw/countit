//
//  ItemEntity+CoreDataProperties.swift
//  countit
//
//  Created by David Grew on 13/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//
//

import Foundation
import CoreData


extension ItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemEntity> {
        return NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var itemDescription: String?

}
