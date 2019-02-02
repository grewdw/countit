//
//  ActivityRecordDto.swift
//  countit
//
//  Created by David Grew on 01/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import CoreData

class ActivityRecordDto {
    
    let id: NSManagedObjectID
    let timestamp: Date
    let value: Int
    
    init(activityEntity: ActivityEntity) {
        id = activityEntity.objectID
        timestamp = activityEntity.createdTimestamp!
        value = Int(activityEntity.value)
    }
    
    func getId() -> NSManagedObjectID {
        return id
    }
    
    func getTimestamp() -> Date {
        return timestamp
    }
    
    func getValue() -> Int {
        return value
    }
}
