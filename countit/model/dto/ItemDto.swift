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
    private let countTarget: CountTargetDto
    private var listPosition: Int?
    
    init(_ id: NSManagedObjectID?, _ name: String, _ description: String?, _ countTarget: CountTargetDto, _ listPosition: Int?) {
        self.id = id
        self.name = name
        self.description = description
        self.countTarget = countTarget
        self.listPosition = listPosition
    }
    
    init(itemForm: ItemForm) {
        self.id = itemForm.getId()
        self.name = itemForm.getName()!
        self.description = itemForm.getDescription()
        self.countTarget = CountTargetDto(countTargetForm: itemForm.getCountTargetForm())
        self.listPosition = itemForm.getListPosition()
    }
    
    init(itemEntity: ItemEntity) {
        self.id = itemEntity.objectID
        self.name = itemEntity.name!
        self.description = itemEntity.itemDescription
        // TODO: Needs changing
        self.countTarget = CountTargetDto(direction: .AT_LEAST, value: 0, timePeriod: .DAY)
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
    
    func getCountTarget() -> CountTargetDto {
        return countTarget
    }
    
    func setListPosition(newPosition: Int) {
        self.listPosition = newPosition
    }
}
