//
//  ProgressDelegate.swift
//  countit
//
//  Created by David Grew on 09/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import UIKit

class ProgressDelegate {
    
    private let buttonSection: ButtonSection
    private let progressSection: ProgressSection
    
    
    init(delegate: ItemCellButtonDelegate, item: ItemProgressSummaryDto) {
        var activityProgress: CGFloat
        var color: ProgressBarColor
        
        let timeProgress: CGFloat = CGFloat(item.getActivityPeriodSummaryDto().getElapsedDuration().duration / item.getActivityPeriodSummaryDto().getOverallDuration().duration)
        let timeRemaining = Int(item.getActivityPeriodSummaryDto().getRemainingDuration().duration)
    
        let activityCount = item.getActivityPeriodSummaryDto().getActivityCount()
        let target = item.getItemDetailsDto().getValue()
        let targetDirection = item.getItemDetailsDto().getDirection()
        
        if activityCount > target {
            if target == 0 {
                activityProgress = 0
            }
            else {
                activityProgress = CGFloat(integerLiteral: activityCount) / CGFloat(integerLiteral: target)
            }
            color = targetDirection == TargetDirection.AT_LEAST ? .GREEN : .RED
        }
        else if target == activityCount {
            activityProgress = activityCount == 0 ? 0 : 1
            color =  .GREEN
        }
        else {
            activityProgress = CGFloat(integerLiteral: activityCount) / CGFloat(integerLiteral: target)
            if targetDirection == TargetDirection.AT_MOST {
                color = .GREEN
            }
            else {
                color = activityProgress >= timeProgress ? .GREEN : .YELLOW
            }
        }
        
        buttonSection = ButtonSection(delegate: delegate, percentage: String(Int(activityProgress * 100)), color: color)
        progressSection = ProgressSection(activityProgress: activityProgress, timeProgress: timeProgress, color: color, activityCount: activityCount, target: target, remainingSeconds: timeRemaining)
    }
    
    func getActionButtons() -> ButtonSection {
        return buttonSection
    }
    
    func getProgressSection() -> ProgressSection {
        return progressSection
    }
}
