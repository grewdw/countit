//
//  NewCount.swift
//  countit
//
//  Created by David Grew on 07/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import CoreData

class NewActivityDto {
    
    private let item: NSManagedObjectID
    private let value: Int
    
    init(item: NSManagedObjectID, value: Int) {
        self.item = item
        self.value = value
    }
    
    func getItem() -> NSManagedObjectID {
        return item
    }
    
    func getValue() -> Int {
        return value
    }
}
