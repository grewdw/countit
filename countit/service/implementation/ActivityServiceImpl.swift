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
        return activity.getValue() < 0 ? processSubtract(activity: activity) : processAdd(activity: activity)

    }
    
    func getActivityHistoryFor(item: NSManagedObjectID) -> ActivityHistoryDto {
        return ActivityHistoryDto(id: item, activity: activityRepository.getActivitiesFor(item: item))
    }
    
    func delete(activityRecord: ActivityRecordDto) -> Bool {
        return activityRepository.delete(activityRecord: activityRecord)
    }
    
    private func processSubtract(activity: ActivityUpdateDto) -> Bool {
        let activityInPeriod = calculateActivityInCurrentPeriodFor(item: activity.getItem())
        if activityInPeriod <= 0 {
            return true
        }
        else {
            return activityInPeriod >= activity.getValue()
                ? activityRepository.save(activity: activity, withTimestamp: clock.now())
                : activityRepository.save(
                    activity: ActivityUpdateDto(item: activity.getItem(), value: activityInPeriod),
                    withTimestamp: clock.now())
        }
    }
    
    private func processAdd(activity: ActivityUpdateDto) -> Bool {
        return activityRepository.save(activity: activity, withTimestamp: clock.now())
    }
    
    func getCurrentTargetProgressFor(item: ItemDetailsDto) -> ItemSummaryDto {
        return ItemSummaryDto(itemDetailsDto: item, activityCount: calculateActivityInCurrentPeriodFor(item: item))
    }
    
    private func calculateActivityInCurrentPeriodFor(item: ItemDetailsDto) -> Int {
        if let targetDuration = getTargetDuration(timePeriod: item.getTimePeriod()) {
            let activities = activityRepository.getActivitiesFor(item: item.getId(), fromStartDate: targetDuration.start, toEndDate: targetDuration.end)
            var activityCount = 0
            for activity in activities {
                activityCount += Int(activity.value)
            }
            return activityCount
        }
        return 0
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
