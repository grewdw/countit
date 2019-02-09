//
//  ActionButtonRow.swift
//  countit
//
//  Created by David Grew on 06/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit
import GTProgressBar

class ActionButtonRow: UIStackView {
    
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
        
        let progress = ActionButton(buttonPressAction: self.delegate.ProgressButtonPressed, image: UIImage(named: "ProgressIcon")!, selectedImage: nil)
        let performance = ActionButton(buttonPressAction: self.delegate.PerformanceButtonPressed, image: UIImage(named: "StatsIcon")!, selectedImage: nil)
        let add = ActionButton(buttonPressAction: self.delegate.AddButtonPressed, image: UIImage(named: "AddIcon")!, selectedImage: nil)
        let plusOne = ActionButton(buttonPressAction: self.delegate.PlusOneButtonPressed, image: UIImage(named: "PlusOneIcon")!, selectedImage: nil)
        
        percentageLabel.text = "\(percentage)%"
        setPercentage(color: color)
        percentageLabel.textAlignment = .center
        percentageLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
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
            percentageLabel.textColor = Colours.PROGRESS_BLUE
        case .GREEN:
            percentageLabel.textColor = Colours.PROGRESS_GREEN
        case .YELLOW:
            percentageLabel.textColor = Colours.PROGRESS_YELLOW
        case .RED:
            percentageLabel.textColor = Colours.PROGRESS_RED
        }
    }
}
