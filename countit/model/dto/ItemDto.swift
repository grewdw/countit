//
//  ItemDto.swift
//  countit
//
//  Created by David Grew on 11/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import Foundation
import CoreData

class ItemDto {
    
    private let id: NSManagedObjectID?
    private let name: String
    private let description: String?
    private let currentTargetDto: TargetDto
    private var listPosition: Int?
    
    init(_ id: NSManagedObjectID?, _ name: String, _ description: String?, _ targetDto: TargetDto, _ listPosition: Int?) {
        self.id = id
        self.name = name
        self.description = description
        self.currentTargetDto = targetDto
        self.listPosition = listPosition
    }
    
    init(itemForm: ItemForm) {
        self.id = itemForm.getId()
        self.name = itemForm.getName()!
        self.description = itemForm.getDescription()
        self.currentTargetDto = TargetDto(targetForm: itemForm.getTargetForm())
        self.listPosition = itemForm.getListPosition()
    }
    
    init(itemEntity: ItemEntity, targetEntity: TargetEntity) {
        self.id = itemEntity.objectID
        self.name = itemEntity.name!
        self.description = itemEntity.itemDescription
        self.currentTargetDto = TargetDto(
            direction: TargetDirection(rawValue: targetEntity.direction!)!,
            value: Int(targetEntity.value),
            timePeriod: TargetTimePeriod(rawValue: targetEntity.timePeriod!)!)
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
    
    func getListPosition() -> Int? {
        return listPosition
    }
    
    func getCurrentTargetDto() -> TargetDto {
        return currentTargetDto
    }
    
    func setListPosition(newPosition: Int) {
        self.listPosition = newPosition
    }
}
