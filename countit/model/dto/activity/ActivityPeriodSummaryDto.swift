//
//  ActivityPeriodSummaryDto.swift
//  countit
//
//  Created by David Grew on 18/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation

class ActivityPeriodSummaryDto {
    
    private let activityCount: Int
    private let overralDuration: DateInterval
    private let elapsedDuration: DateInterval
    private let remainingDuration: DateInterval
    
    init(activityCount: Int, overallDuration: DateInterval, elapsedDuration: DateInterval, remainingDuration: DateInterval) {
        self.activityCount = activityCount
        self.overralDuration = overallDuration
        self.elapsedDuration = elapsedDuration
        self.remainingDuration = remainingDuration
    }
    
    func getActivityCount() -> Int {
        return activityCount
    }
    
    func getOverallDuration() -> DateInterval {
        return overralDuration
    }
    
    func getElapsedDuration() -> DateInterval {
        return elapsedDuration
    }
    
    func getRemainingDuration() -> DateInterval {
        return remainingDuration
    }
}
