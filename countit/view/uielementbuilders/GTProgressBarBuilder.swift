//
//  GtProgressBarBuilder.swift
//  countit
//
//  Created by David Grew on 09/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import GTProgressBar

class GTProgressBarBuilder {
    
    private var borderColor: UIColor
    private var fillColor: UIColor
    private var backgroundColor: UIColor
    private var progress: CGFloat
    
    init() {
        borderColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        fillColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        backgroundColor = UIColor(red:0.77, green:0.93, blue:0.78, alpha:1.0)
        progress = 0
    }
    
    func with(color: ProgressBarColor) -> GTProgressBarBuilder {
        switch color {
        case .BLUE:
            return self
        case .GREEN:
            setToGreen()
        case .YELLOW:
            setToYellow()
        case .RED:
            setToRed()
        }
        return self
    }
    
    func with(progress: CGFloat) -> GTProgressBarBuilder {
        self.progress = progress >= 1.0 ? 1.0 : progress
        return self
    }
    
    func build() -> GTProgressBar {
        let bar = GTProgressBar(frame: CGRect())
        bar.barBorderColor = borderColor
        bar.barFillColor = fillColor
        bar.barBackgroundColor = backgroundColor
        bar.barBorderWidth = 1
        bar.barFillInset = 2
        bar.barMaxHeight = 20
        bar.displayLabel = false
        bar.progress = progress
        return bar
    }
    
    private func setToGreen() {
        borderColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        fillColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        backgroundColor = UIColor(red:0.77, green:0.93, blue:0.78, alpha:1.0)
    }
    
    private func setToYellow() {
        borderColor = UIColor(red:0.85, green:0.85, blue:0.20, alpha:1.0)
        fillColor = UIColor(red:0.90, green:0.90, blue:0.20, alpha:1.0)
        backgroundColor = UIColor(red:0.95, green:0.95, blue:0.78, alpha:1.0)
    }
    
    private func setToRed() {
        borderColor = UIColor(red:0.80, green:0.36, blue:0.36, alpha:1.0)
        fillColor = UIColor(red:0.80, green:0.36, blue:0.36, alpha:1.0)
        backgroundColor = UIColor(red:0.93, green:0.78, blue:0.78, alpha:1.0)
    }
}
