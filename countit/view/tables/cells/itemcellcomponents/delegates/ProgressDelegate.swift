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
    
    
    init(delegate: ItemCellButtonDelegate, item: ItemSummaryDto) {
        var progress: CGFloat
        var color: ProgressBarColor
    
        let activityCount = item.getActivityCount()
        let target = item.getItemDetailsDto().getValue()
        let targetDirection = item.getItemDetailsDto().getDirection()
        
        if activityCount > target {
            progress = 1
            color = targetDirection == TargetDirection.AT_LEAST ? .GREEN : .RED
        }
        else if target == activityCount {
            progress = 1
            color =  .GREEN
        }
        else {
            progress = CGFloat(integerLiteral: activityCount) / CGFloat(integerLiteral: target)
            color = targetDirection == TargetDirection.AT_LEAST ? .YELLOW : .GREEN
        }
        
        buttonSection = ButtonSection(delegate: delegate, percentage: String(Int(progress * 100)), color: color)
        progressSection = ProgressSection(progress: progress, color: color, activityCount: activityCount, target: target)
    }
    
    func getActionButtons() -> ButtonSection {
        return buttonSection
    }
    
    func getProgressSection() -> ProgressSection {
        return progressSection
    }
}
