//
//  ProgressService.swift
//  countit
//
//  Created by David Grew on 18/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import CoreData

class ProgressServiceImpl: ProgressService {
    
    let itemService: ItemService
    let activityService: ActivityService
    let calendar: Calendar
    let clock: Clock
    
    init(itemService: ItemService, activityService: ActivityService, calendar: Calendar, clock: Clock) {
        self.itemService = itemService
        self.activityService = activityService
        self.calendar = calendar
        self.clock = clock
    }
    
    func getItemsProgresss() -> [ItemProgressSummaryDto] {
        let items = itemService.getItems()
        var itemSummaries = [ItemProgressSummaryDto]()
        
        for item in items {
            itemSummaries.append(ItemProgressSummaryDto(itemDetailsDto: item,
                                                        periodSummary: getActivityCountFor(item: item)))
        }
        return itemSummaries
    }
    
    private func getActivityCountFor(item: ItemDetailsDto) -> ActivityPeriodSummaryDto {
        let now = clock.now()
        let targetDuration = getTargetDuration(timePeriod: item.getTimePeriod(), time: now)!
        
        return ActivityPeriodSummaryDto(activityCount: activityService.getActivityCountFor(item: item.getId(), between: targetDuration),
                                        overallDuration: targetDuration,
                                        elapsedDuration: DateInterval(start: targetDuration.start, end: now),
                                        remainingDuration: DateInterval(start: now, end: targetDuration.end))
    }
    
    private func getTargetDuration(timePeriod: TargetTimePeriod, time: Date) -> DateInterval? {
        switch timePeriod {
        case .DAY:
            return calendar.dateInterval(of: .day, for: time)
        case .WEEK:
            return calendar.dateInterval(of: .weekOfYear, for: time)
        case .MONTH:
            return calendar.dateInterval(of: .month, for: time)
        }
    }
}
