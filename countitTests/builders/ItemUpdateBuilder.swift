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

class ItemUpdateBuilder {
    
    private var id: NSManagedObjectID?
    private var name: String
    private var description: String?
    private var direction: TargetDirection
    private var value: Int
    private var timePeriod: TargetTimePeriod
    private var listPosition: Int?
    
    init() {
        self.id = nil
        self.name = "itemName"
        self.description = nil
        self.direction = .AT_LEAST
        self.value = 5
        self.timePeriod = .DAY
        self.listPosition = nil
    }
    
    func with(id: NSManagedObjectID) -> ItemUpdateBuilder {
        self.id = id
        return self
    }
    
    func with(name: String) -> ItemUpdateBuilder {
        self.name = name
        return self
    }
    
    func with(description: String) -> ItemUpdateBuilder {
        self.description = description
        return self
    }
    
    func with(direction: TargetDirection) -> ItemUpdateBuilder {
        self.direction = direction
        return self
    }
    
    func with(value: Int) -> ItemUpdateBuilder {
        self.value = value
        return self
    }
    
    func with(timePeriod: TargetTimePeriod) -> ItemUpdateBuilder {
        self.timePeriod = timePeriod
        return self
    }
    
    func with(listPosition: Int) -> ItemUpdateBuilder {
        self.listPosition = listPosition
        return self
    }
    
    func build() -> ItemUpdateDto {
        return ItemUpdateDto(id, name, description, direction, value, timePeriod, listPosition)
    }
}
