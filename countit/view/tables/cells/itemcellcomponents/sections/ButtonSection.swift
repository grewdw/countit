//
//  ActionButtonRow.swift
//  countit
//
//  Created by David Grew on 06/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit
import GTProgressBar

class ButtonSection: UIStackView {
    
    typealias AI = AccessibilityIdentifiers
    
    let delegate: ItemCellButtonDelegate
    let percentageLabel = UILabel()
    let percentage: String
    
    init(delegate: ItemCellButtonDelegate, percentage: String, color: ProgressBarColor) {
        self.delegate = delegate
        self.percentage = percentage
        super.init(frame: CGRect())
        
        axis = .horizontal
        distribution = .fillEqually
        alignment = .center
        
        let progress = ActionButton(buttonPressAction: self.delegate.ProgressButtonPressed,
                                    image: UIImage(named: "ProgressIcon")!,
                                    accessibilityIdentifier: AI.ITEM_CELL_PROGRESS_BUTTON)
        let performance = ActionButton(buttonPressAction: self.delegate.PerformanceButtonPressed,
                                       image: UIImage(named: "StatsIcon")!,
                                       accessibilityIdentifier: AI.ITEM_CELL_PERFORMANCE_BUTTON)
        let plusOne = ActionButton(buttonPressAction: self.delegate.PlusOneButtonPressed,
                                   image: UIImage(named: "PlusOneIcon")!,
                                   accessibilityIdentifier: AI.ITEM_CELL_PLUSONE_BUTTON)
        let add = ActionButton(buttonPressAction: self.delegate.AddButtonPressed,
                               image: UIImage(named: "AddIcon")!,
                               accessibilityIdentifier: AI.ITEM_CELL_ADD_BUTTON)
        let activityHistory = ActionButton(buttonPressAction: self.delegate.ActivityHistoryButtonPressed,
                                   image: UIImage(named: "ActivityListIcon")!,
                                   accessibilityIdentifier: AI.ITEM_CELL_ACTIVITY_HISTORY_BUTTON)
        
        addArrangedSubview(progress)
        addArrangedSubview(performance)
        addArrangedSubview(plusOne)
        addArrangedSubview(add)
        addArrangedSubview(activityHistory)
        
        progress.translatesAutoresizingMaskIntoConstraints = false
        performance.translatesAutoresizingMaskIntoConstraints = false
        plusOne.translatesAutoresizingMaskIntoConstraints = false
        add.translatesAutoresizingMaskIntoConstraints = false
        activityHistory.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progress.heightAnchor.constraint(equalTo: performance.heightAnchor),
            progress.heightAnchor.constraint(equalTo: add.heightAnchor),
            progress.heightAnchor.constraint(equalTo: performance.heightAnchor),
            progress.heightAnchor.constraint(equalTo: activityHistory.heightAnchor),
            progress.heightAnchor.constraint(equalTo: plusOne.heightAnchor, multiplier: 0.4)
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
