//
//  NewItemForm.swift
//  countit
//
//  Created by David Grew on 08/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import Foundation
import CoreData

class ItemForm: Form {
    
    private var id: NSManagedObjectID?
    private var name: String?
    private var description: String?
    
    init(_ name: String) {
        self.name = name
    }
    
    init(_ name: String?, _ description: String?) {
        self.name = name
        self.description = description
    }
    
    init(_ id: NSManagedObjectID, _ name: String?, _ description: String?) {
        self.id = id
        self.name = name
        self.description = description
    }
    
    init(_ dto: ItemDto) {
        self.id = dto.getId()
        self.name = dto.getName()
        self.description = dto.getDescription()
    }
    
    func getId() -> NSManagedObjectID? {
        return id
    }
    
    func getName() -> String? {
        return name
    }
    
    func getDescription() -> String? {
        return description
    }
    
    func isValid() -> Bool {
        return true
    }    
}
