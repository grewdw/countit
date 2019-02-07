//
//  ActionButtonRow.swift
//  countit
//
//  Created by David Grew on 06/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class ActionButtonRow: UIStackView {
    
    let delegate: ItemCellButtonDelegate
    
    init(delegate: ItemCellButtonDelegate) {
        self.delegate = delegate
        super.init(frame: CGRect())
        
        axis = .horizontal
        distribution = .fillEqually
        alignment = .center
        
        let progress = ActionButton(buttonPressAction: self.delegate.ProgressButtonPressed, image: UIImage(named: "ProgressIcon")!, selectedImage: nil)
        let performance = ActionButton(buttonPressAction: self.delegate.PerformanceButtonPressed, image: UIImage(named: "StatsIcon")!, selectedImage: nil)
        let add = ActionButton(buttonPressAction: self.delegate.AddButtonPressed, image: UIImage(named: "AddIcon")!, selectedImage: nil)
        let plusOne = ActionButton(buttonPressAction: self.delegate.PlusOneButtonPressed, image: UIImage(named: "PlusOneIcon")!, selectedImage: nil)
        
        addArrangedSubview(progress)
        addArrangedSubview(performance)
        addArrangedSubview(add)
        addArrangedSubview(plusOne)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
