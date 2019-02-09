//
//  ProgressBar.swift
//  countit
//
//  Created by David Grew on 09/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import UIKit
import GTProgressBar

class ProgressBar: UIView {
    
    init(progress: CGFloat, status: ProgressStatus) {
        super.init(frame: CGRect())
        
        let progressBar = GTProgressBar(frame: bounds)
        
        progressBar.barBorderColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.barFillColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.barBackgroundColor = UIColor(red:0.77, green:0.93, blue:0.78, alpha:1.0)
        progressBar.barBorderWidth = 1
        progressBar.barFillInset = 2
        progressBar.barMaxHeight = 20
        progressBar.displayLabel = false
        progressBar.progress = progress >= 1 ? 1 : progress
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum ProgressStatus {
    
    case ON_TARGET
    case BEHIND_TARGET
    case COMPLETE
    case EXCEEDED
}
