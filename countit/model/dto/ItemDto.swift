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
    
    init(_ id: NSManagedObjectID?, _ name: String, _ description: String?) {
        self.id = id
        self.name = name
        self.description = description
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
}
