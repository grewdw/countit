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
    private let calendar: Calendar
    
    init(activityRepository: ActivityRepository, clock: Clock, calendar: Calendar) {
        self.activityRepository = activityRepository
        self.clock = clock
        self.calendar = calendar
    }
    
    func record(activityUpdate activity: ActivityUpdateDto) -> Bool {
        let timestamp = activity.getTimestamp() != nil ? activity.getTimestamp()! : clock.now()
        return activityRepository.save(activity: activity, withTimestamp: timestamp)
    }
    
    func getActivityCountFor(item: NSManagedObjectID, between: DateInterval) -> Int {
        let activities = activityRepository.getActivitiesFor(item: item, fromStartDate: between.start, toEndDate: between.end)
        var activityCount = 0
        for activity in activities {
            activityCount += Int(activity.value)
        }
        return activityCount
    }
    
    func getActivityHistoryFor(item: NSManagedObjectID) -> ActivityHistoryDto {
        return ActivityHistoryDto(id: item, activity: activityRepository.getActivitiesFor(item: item))
    }
    
    func delete(activityRecord: ActivityRecordDto) -> Bool {
        return activityRepository.delete(activityRecord: activityRecord)
    }
}
