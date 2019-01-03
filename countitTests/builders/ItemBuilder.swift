//
//  ItemBuilder.swift
//  countitTests
//
//  Created by David Grew on 01/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import CoreData
@testable import countit

class ItemBuilder {
    
    private var id: NSManagedObjectID?
    private var name: String
    private var description: String?
    private var target: TargetDto
    private var listPosition: Int?
    
    init() {
        self.id = nil
        self.name = "itemName"
        self.description = nil
        self.target = TargetBuilder().build()
        self.listPosition = nil
    }
    
    func with(id: NSManagedObjectID) -> ItemBuilder {
        self.id = id
        return self
    }
    
    func with(name: String) -> ItemBuilder {
        self.name = name
        return self
    }
    
    func with(description: String) -> ItemBuilder {
        self.description = description
        return self
    }
    
    func with(target: TargetDto) -> ItemBuilder {
        self.target = target
        return self
    }
    
    func with(listPosition: Int) -> ItemBuilder {
        self.listPosition = listPosition
        return self
    }
    
    func build() -> ItemDto {
        return ItemDto(id, name, description, target, listPosition)
    }
}
