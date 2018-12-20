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
    private var listPosition: Int?
    
    private var fieldErrors: [ItemFormFields] = []
    
    init(_ name: String) {
        self.name = name
    }
    
    init(_ name: String?, _ description: String?) {
        self.name = name
        self.description = description
    }
    
    init(_ id: NSManagedObjectID?, _ name: String?, _ description: String?) {
        self.id = id
        self.name = name
        self.description = description
    }
    
    init(_ id: NSManagedObjectID?, _ name: String?, _ description: String?, _ listPosition: Int?) {
        self.id = id
        self.name = name
        self.description = description
        self.listPosition = listPosition
    }
    
    init(_ dto: ItemDto) {
        self.id = dto.getId()
        self.name = dto.getName()
        self.description = dto.getDescription()
        self.listPosition = dto.getListPosition()
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
    
    func getListPosition() -> Int? {
        return self.listPosition
    }
    
    func isValid() -> Bool {
        if name != nil && name != "" {
            return true
        }
        else {
            fieldErrors.append(ItemFormFields.NAME)
            return false
        }
    }
    
    func getFieldErrors() -> [ItemFormFields] {
        return fieldErrors
    }
}

enum ItemFormFields {
    
    case NAME
    case DESCRIPTION
}
