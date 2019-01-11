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

class ItemDetailsBuilder {
    
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
    
    func with(id: NSManagedObjectID) -> ItemDetailsBuilder {
        self.id = id
        return self
    }
    
    func with(name: String) -> ItemDetailsBuilder {
        self.name = name
        return self
    }
    
    func with(description: String) -> ItemDetailsBuilder {
        self.description = description
        return self
    }
    
    func with(direction: TargetDirection) -> ItemDetailsBuilder {
        self.direction = direction
        return self
    }
    
    func with(value: Int) -> ItemDetailsBuilder {
        self.value = value
        return self
    }
    
    func with(timePeriod: TargetTimePeriod) -> ItemDetailsBuilder {
        self.timePeriod = timePeriod
        return self
    }
    
    func with(listPosition: Int) -> ItemDetailsBuilder {
        self.listPosition = listPosition
        return self
    }
    
    func build() -> ItemDetailsDto {
        return ItemDetailsDto(id, name, description, direction, value, timePeriod, listPosition)
    }
}
