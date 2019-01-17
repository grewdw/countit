//
//  ActivityRepository.swift
//  countit
//
//  Created by David Grew on 07/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import CoreData

protocol ActivityRepository {
    
    func save(activity: NewActivityDto, withTimestamp timestamp: Date) -> Bool
    
    func getActivitiesFor(item: NSManagedObjectID) -> [ActivityEntity]
    
    func getActivitiesFor(item: NSManagedObjectID, fromStartDate start: Date, toEndDate end: Date) -> [ActivityEntity]
}
