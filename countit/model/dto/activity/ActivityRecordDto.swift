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
    
    private let id: NSManagedObjectID
    private let timestamp: Date
    private let value: Int
    private let note: String?
    
    init(activityEntity: ActivityEntity) {
        id = activityEntity.objectID
        timestamp = activityEntity.createdTimestamp!
        value = Int(activityEntity.value)
        note = activityEntity.note
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
    
    func getNote() -> String? {
        return note
    }
}
