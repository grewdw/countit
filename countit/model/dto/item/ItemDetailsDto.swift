//
//  ItemDto.swift
//  countit
//
//  Created by David Grew on 11/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import Foundation
import CoreData

class ItemDetailsDto {
    
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
    
    init(itemForm: ItemForm) {
        self.id = itemForm.getId()
        self.name = itemForm.getName()!
        self.description = itemForm.getDescription()
        self.direction = itemForm.getTargetForm().getDirection()
        self.value = itemForm.getTargetForm().getValue()
        self.timePeriod = itemForm.getTargetForm().getTimePeriod()
        self.listPosition = nil
    }
    
    init(itemEntity: ItemEntity, targetEntity: TargetEntity) {
        self.id = itemEntity.objectID
        self.name = itemEntity.name!
        self.description = itemEntity.itemDescription
        self.direction = TargetDirection(rawValue: targetEntity.direction!)!
        self.value = Int(targetEntity.value)
        self.timePeriod = TargetTimePeriod(rawValue: targetEntity.timePeriod!)!
        self.listPosition = Int(itemEntity.listPosition)
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
