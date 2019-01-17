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
    
    func record(newActivity activity: NewActivityDto) -> Bool {
        return activityRepository.save(activity: activity, withTimestamp: clock.now())
    }
    
    func getCurrentTargetProgressFor(item: ItemDetailsDto) -> ItemSummaryDto {
        if let targetDuration = getTargetDuration(timePeriod: item.getTimePeriod()) {
            let now = clock.now()
            let end = targetDuration.end
            let start = targetDuration.start
            let activities = activityRepository.getActivitiesFor(item: item.getId()!, fromStartDate: targetDuration.start, toEndDate: targetDuration.end)
            var activityCount = 0
            for activity in activities {
                activityCount += Int(activity.value)
            }
            return ItemSummaryDto(itemDetailsDto: item, activityCount: activityCount)
        }
        return ItemSummaryDto(itemDetailsDto: item, activityCount: 0)
    }
    
    private func getTargetDuration(timePeriod: TargetTimePeriod) -> DateInterval? {
        switch timePeriod {
        case .DAY:
            return calendar.dateInterval(of: .day, for: clock.now())
        case .WEEK:
            return calendar.dateInterval(of: .weekOfYear, for: clock.now())
        case .MONTH:
            return calendar.dateInterval(of: .month, for: clock.now())
        }
    }
}
