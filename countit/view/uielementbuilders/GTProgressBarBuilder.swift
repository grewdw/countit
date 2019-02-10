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
    
    private let BORDER_WIDTH: CGFloat = 1
    private let FILL_INSET: CGFloat = 2
    private let MAX_HEIGHT: CGFloat = 20
    
    private let MAX_PROGRESS: CGFloat = 1.0
    
    private var borderColor: UIColor
    private var fillColor: UIColor
    private var backgroundColor: UIColor
    private var progress: CGFloat
    
    init() {
        borderColor = Colors.PROGRESS_BLUE
        fillColor = Colors.PROGRESS_BLUE
        backgroundColor = Colors.PROGRESS_BLUE_BACKGROUND
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
        self.progress = progress >= MAX_PROGRESS ? MAX_PROGRESS : progress
        return self
    }
    
    func build() -> GTProgressBar {
        let bar = GTProgressBar(frame: CGRect())
        bar.barBorderColor = borderColor
        bar.barFillColor = fillColor
        bar.barBackgroundColor = backgroundColor
        bar.barBorderWidth = BORDER_WIDTH
        bar.barFillInset = FILL_INSET
        bar.barMaxHeight = MAX_HEIGHT
        bar.displayLabel = false
        bar.progress = progress
        return bar
    }
    
    private func setToGreen() {
        borderColor = Colors.PROGRESS_GREEN
        fillColor = Colors.PROGRESS_GREEN
        backgroundColor = Colors.PROGRESS_GREEN_BACKGROUND
    }
    
    private func setToYellow() {
        borderColor = Colors.PROGRESS_YELLOW
        fillColor = Colors.PROGRESS_YELLOW
        backgroundColor = Colors.PROGRESS_YELLOW_BACKGROUND
    }
    
    private func setToRed() {
        borderColor = Colors.PROGRESS_RED
        fillColor = Colors.PROGRESS_RED
        backgroundColor = Colors.PROGRESS_RED_BACKGROUND
    }
}
