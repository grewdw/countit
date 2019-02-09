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
    
    private let SEPARATOR_HEIGHT: CGFloat = 1
    private let SEPARATOR_PADDING_LEFT: CGFloat = 30
    private let SEPARATOR_PADDING_RIGHT: CGFloat = -30
    private let SEPARATOR_PADDING_TOP: CGFloat = 2
    private let PROGRESS_BAR_PADDING_TOP: CGFloat = 22.5
    private let PROGRESS_LABEL_PADDING_TOP: CGFloat = 5
    
    init(progress: CGFloat, color: ProgressBarColor, activityCount: Int, target: Int) {
        super.init(frame: CGRect())

        let topPadding = UIView()
        let progressBar = GTProgressBarBuilder().with(color: color).with(progress: progress).build()
        let progressLabel = UILabel()
        
        progressLabel.text = "\(activityCount) of \(target)"
        progressLabel.font = UIFont.systemFont(ofSize: 14)
        progressLabel.textAlignment = .center
        
        addSubview(topPadding)
        addSubview(progressBar)
        addSubview(progressLabel)
        topPadding.translatesAutoresizingMaskIntoConstraints = false
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topPadding.topAnchor.constraint(equalTo: topAnchor),
            topPadding.heightAnchor.constraint(equalToConstant: PROGRESS_BAR_PADDING_TOP),
            progressBar.leftAnchor.constraint(equalTo: leftAnchor),
            progressBar.rightAnchor.constraint(equalTo: rightAnchor),
            progressBar.topAnchor.constraint(equalTo: topPadding.bottomAnchor),
            progressLabel.leftAnchor.constraint(equalTo: leftAnchor),
            progressLabel.rightAnchor.constraint(equalTo: rightAnchor),
            progressLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: PROGRESS_LABEL_PADDING_TOP),
            progressLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
