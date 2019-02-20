//
//  ProgressSection.swift
//  countit
//
//  Created by David Grew on 07/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit
import GTProgressBar

class ProgressSection: UIView {
 
    private let PROGRESS_BAR_PADDING_TOP: CGFloat = 22.5
    private let LABEL_PADDING_TOP: CGFloat = 7.5
    private let TIME_PROGRESS_BAR_PADDING_TOP: CGFloat = 7.5
    
    init(activityProgress: CGFloat, timeProgress: CGFloat, color: ProgressBarColor, activityCount: Int, target: Int, remainingSeconds: Int) {
        super.init(frame: CGRect())

//        let topPadding = UIView()
        let activityProgressBar = GTProgressBarBuilder().with(color: color).with(progress: activityProgress).build()
        let activityProgressLabel = UILabel()
        let timeProgressBar = GTProgressBarBuilder().with(color: .BLUE).with(progress: timeProgress).build()
        let timeProgressLabel = UILabel()
        
        activityProgressLabel.text = "\(activityCount) of \(target)"
        activityProgressLabel.font = UIFont.systemFont(ofSize: 14)
        activityProgressLabel.textAlignment = .center
        activityProgressLabel.accessibilityIdentifier = AccessibilityIdentifiers.ITEM_CELL_PROGRESS_COUNT
        
        timeProgressLabel.text = createTextFor(timeRemaining: remainingSeconds)
        timeProgressLabel.font = UIFont.systemFont(ofSize: 14)
        timeProgressLabel.textAlignment = .center
//        timeProgressLabel = AccessibilityIdentifiers.ITEM_CELL_PROGRESS_COUNT
        
//        addSubview(topPadding)
        addSubview(activityProgressBar)
        addSubview(activityProgressLabel)
        addSubview(timeProgressBar)
        addSubview(timeProgressLabel)
//        topPadding.translatesAutoresizingMaskIntoConstraints = false
        activityProgressBar.translatesAutoresizingMaskIntoConstraints = false
        activityProgressLabel.translatesAutoresizingMaskIntoConstraints = false
        timeProgressBar.translatesAutoresizingMaskIntoConstraints = false
        timeProgressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
//            topPadding.topAnchor.constraint(equalTo: topAnchor),
//            topPadding.leftAnchor.constraint(equalTo: leftAnchor),
//            topPadding.rightAnchor.constraint(equalTo: rightAnchor),
//            topPadding.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.10),
            activityProgressBar.leftAnchor.constraint(equalTo: leftAnchor),
            activityProgressBar.rightAnchor.constraint(equalTo: rightAnchor),
            activityProgressBar.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.20),
            activityProgressBar.topAnchor.constraint(equalTo: topAnchor),
            activityProgressLabel.leftAnchor.constraint(equalTo: leftAnchor),
            activityProgressLabel.rightAnchor.constraint(equalTo: rightAnchor),
            activityProgressLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.30),
            activityProgressLabel.topAnchor.constraint(equalTo: activityProgressBar.bottomAnchor),
            timeProgressBar.leftAnchor.constraint(equalTo: leftAnchor),
            timeProgressBar.rightAnchor.constraint(equalTo: rightAnchor),
            timeProgressBar.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.20),
            timeProgressBar.topAnchor.constraint(equalTo: activityProgressLabel.bottomAnchor),
            timeProgressLabel.leftAnchor.constraint(equalTo: leftAnchor),
            timeProgressLabel.rightAnchor.constraint(equalTo: rightAnchor),
            timeProgressLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.30),
            timeProgressLabel.topAnchor.constraint(equalTo: timeProgressBar.bottomAnchor),
            timeProgressLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createTextFor(timeRemaining: Int) -> String {
        var time = timeRemaining
        let days: Int = time / 86400
        time -= days * 86400
        let hours: Int = time / 3600
        time -= hours * 3600
        let minutes: Int = time / 60
        let seconds = time - (minutes * 60)
        
        if days > 0 {
            return days != 1
                ? String.init(format: "%i days remaining", days)
                : String.init(format: "%i day %i hours remaining", days, hours)
        }
        else if hours > 0 {
            return hours != 1
                ? String.init(format: "%i hours %i minutes remaining", hours, minutes)
                : String.init(format: "%i hour %i minutes, %i seconds remaining", hours, minutes, seconds)
        }
        else if minutes > 0 {
            return minutes != 1
                ? String.init(format: "%i minutes, %i seconds remaining", minutes, seconds)
                : String.init(format: "%i minute, %i seconds remaining", minutes, seconds)
        }
        else {
            return seconds != 1
                ? String.init(format: "%i seconds remaining", seconds)
                : String.init(format: "%i second remaining", seconds)
        }
    }
}
