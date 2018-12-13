//
//  NewItemForm.swift
//  countit
//
//  Created by David Grew on 08/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import Foundation

class NewItemForm: Form {
    
    private var id: ItemId?
    private var name: String?
    private var description: String?
    
    init(_ name: String) {
        self.name = name
    }
    
    init(_ name: String?, _ description: String?) {
        self.name = name
        self.description = description
    }
    
    init(_ id: ItemId, _ name: String?, _ description: String?) {
        self.id = id
        self.name = name
        self.description = description
    }
    
    func getId() -> ItemId? {
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
