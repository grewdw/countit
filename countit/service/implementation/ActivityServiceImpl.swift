//
//  ActivityServiceImpl.swift
//  countit
//
//  Created by David Grew on 07/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import CoreData

class ActivityServiceImpl: ActivityService {
    
    private let activityRepository: ActivityRepository
    private let clock: Clock
    
    init(activityRepository: ActivityRepository, clock: Clock) {
        self.activityRepository = activityRepository
        self.clock = clock
    }
    
    func record(newActivity activity: NewActivityDto) -> Bool {
        return activityRepository.save(activity: activity, withTimestamp: clock.now())
    }
    
    func getActivityCountForItem(id: NSManagedObjectID) -> Int {
        let activities = activityRepository.getActivitiesFor(item: id)
        var activityCount = 0
        for activity in activities {
            activityCount += Int(activity.value)
        }
        return activityCount
    }
}
