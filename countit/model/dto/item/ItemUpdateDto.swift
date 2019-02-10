//
//  ItemUpdateDto.swift
//  countit
//
//  Created by David Grew on 10/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import CoreData

class ItemUpdateDto {
    
    private let id: NSManagedObjectID?
    private let name: String
    private let description: String?
    private let direction: TargetDirection
    private let value: Int
    private let timePeriod: TargetTimePeriod
    private var listPosition: Int?
    
    init(_ id: NSManagedObjectID?, _ name: String, _ description: String?, _ direction: TargetDirection, _ value: Int, _ timePeriod: TargetTimePeriod, _ listPosition: Int?) {
        self.id = id
        self.name = name
        self.description = description
        self.direction = direction
        self.value = value
        self.timePeriod = timePeriod
        self.listPosition = listPosition
    }
    
    func getId() -> NSManagedObjectID? {
        return id
    }
    
    func getName() -> String {
        return name
    }
    
    func getDescription() -> String? {
        return description
    }
    
    func getDirection() -> TargetDirection {
        return direction
    }
    
    func getValue() -> Int {
        return value
    }
    
    func getTimePeriod() -> TargetTimePeriod {
        return timePeriod
    }
    
    func getListPosition() -> Int? {
        return listPosition
    }
    
    func setListPosition(newPosition: Int) {
        self.listPosition = newPosition
    }
}

