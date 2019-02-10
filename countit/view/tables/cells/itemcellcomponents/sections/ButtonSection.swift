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
        distribution = .fillProportionally
        alignment = .center
        
        let progress = ActionButton(buttonPressAction: self.delegate.ProgressButtonPressed,
                                    image: UIImage(named: "ProgressIcon")!,
                                    accessibilityIdentifier: AI.ITEM_CELL_PROGRESS_BUTTON)
        let performance = ActionButton(buttonPressAction: self.delegate.PerformanceButtonPressed,
                                       image: UIImage(named: "StatsIcon")!,
                                       accessibilityIdentifier: AI.ITEM_CELL_PERFORMANCE_BUTTON)
        let add = ActionButton(buttonPressAction: self.delegate.AddButtonPressed,
                               image: UIImage(named: "AddIcon")!,
                               accessibilityIdentifier: AI.ITEM_CELL_ADD_BUTTON)
        let plusOne = ActionButton(buttonPressAction: self.delegate.PlusOneButtonPressed,
                                   image: UIImage(named: "PlusOneIcon")!,
                                   accessibilityIdentifier: AI.ITEM_CELL_PLUSONE_BUTTON)
        
        percentageLabel.text = "\(percentage)%"
        setPercentage(color: color)
        percentageLabel.textAlignment = .center
        percentageLabel.font = UIFont.boldSystemFont(ofSize: 25)
        percentageLabel.accessibilityIdentifier = AccessibilityIdentifiers.ITEM_CELL_PROGRESS_PERCENTAGE
        
        addArrangedSubview(progress)
        addArrangedSubview(performance)
        addArrangedSubview(percentageLabel)
        addArrangedSubview(add)
        addArrangedSubview(plusOne)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setPercentage(color: ProgressBarColor) {
        switch color {
        case .BLUE:
            percentageLabel.textColor = Colors.PROGRESS_BLUE
        case .GREEN:
            percentageLabel.textColor = Colors.PROGRESS_GREEN
        case .YELLOW:
            percentageLabel.textColor = Colors.PROGRESS_YELLOW
        case .RED:
            percentageLabel.textColor = Colors.PROGRESS_RED
        }
    }
}
