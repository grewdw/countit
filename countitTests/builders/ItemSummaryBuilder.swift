//
//  ItemSummaryBuilder.swift
//  countitTests
//
//  Created by David Grew on 07/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import CoreData
@testable import countit

class ItemSummaryBuilder {
    
    private var id: NSManagedObjectID?
    private var name: String
    private var description: String?
    private var direction: TargetDirection
    private var value: Int
    private var timePeriod: TargetTimePeriod
    private var listPosition: Int?
    private var activityCount: Int
    
    init() {
        self.id = nil
        self.name = "itemName"
        self.description = nil
        self.direction = .AT_LEAST
        self.value = 5
        self.timePeriod = .DAY
        self.listPosition = nil
        self.activityCount = 5
    }
    
    func with(id: NSManagedObjectID) -> ItemSummaryBuilder {
        self.id = id
        return self
    }
    
    func with(name: String) -> ItemSummaryBuilder {
        self.name = name
        return self
    }
    
    func with(description: String) -> ItemSummaryBuilder {
        self.description = description
        return self
    }
    
    func with(direction: TargetDirection) -> ItemSummaryBuilder {
        self.direction = direction
        return self
    }
    
    func with(value: Int) -> ItemSummaryBuilder {
        self.value = value
        return self
    }
    
    func with(timePeriod: TargetTimePeriod) -> ItemSummaryBuilder {
        self.timePeriod = timePeriod
        return self
    }
    
    func with(listPosition: Int) -> ItemSummaryBuilder {
        self.listPosition = listPosition
        return self
    }
    
    func with(activityCount: Int) -> ItemSummaryBuilder {
        self.activityCount = activityCount
        return self
    }
    
    func build() -> ItemSummaryDto {
        return ItemSummaryDto(itemDetailsDto: ItemDetailsDto(id, name, description, direction, value, timePeriod, listPosition), activityCount: activityCount)
    }
}
