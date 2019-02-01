//
//  ActivityHistoryDto.swift
//  countit
//
//  Created by David Grew on 01/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import CoreData

class ActivityHistoryDto {
    
    let id: NSManagedObjectID
    let activity: [ActivityRecordDto]
    
    init(id: NSManagedObjectID, activity: [ActivityRecordDto]) {
        self.id = id
        self.activity = activity
    }
    
    func getId() -> NSManagedObjectID {
        return id
    }
    
    func getActivity() -> [ActivityRecordDto] {
        return activity
    }
}
