//
//  CurrentProgressTableCellView.swift
//  countit
//
//  Created by David Grew on 03/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

class CurrentProgressTableCellView: UITableViewCell {
    
    typealias AI = AccessibilityIdentifiers
    
    var name = UILabel()
    var recordActivity = UIButton()
    var subtractActivity = UIButton()
    var activityCount = UILabel()
    
    var item: ItemSummaryDto
    
    var delegate: ProgressTableViewDelegate?
    
    let CELL_SPACING_TOP: CGFloat = 10
    let CELL_SPACING_BOTTOM: CGFloat = -10
    
    init(_ item: ItemSummaryDto) {
        self.item = item
        super.init(style: .default, reuseIdentifier: "ProgressCell")
        initialiseNameField(item)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialiseNameField(_ item: ItemSummaryDto) {
        self.addSubview(name)
        self.addSubview(recordActivity)
        self.addSubview(subtractActivity)
        self.addSubview(activityCount)
        name.text = item.getItemDetailsDto().getName()
        name.accessibilityIdentifier = AI.PROGRESS_CELL_NAME
        name.numberOfLines = 0
        name.textAlignment = .center
        
        activityCount.text = String(String(item.getActivityCount()) + " / " + String(item.getItemDetailsDto().getValue()))
        activityCount.accessibilityIdentifier = AI.PROGRESS_CELL_ACTIVITY_COUNT
        activityCount.font = UIFont.boldSystemFont(ofSize: 20)
        activityCount.numberOfLines = 0
        activityCount.textAlignment = .center
        
        recordActivity.accessibilityIdentifier = AI.PROGRESS_CELL_RECORD_ACTIVITY
        format(button: recordActivity, text: "Add")
        recordActivity.addTarget(self, action: #selector(recordActivityButtonPressed), for: .touchUpInside)
        
        subtractActivity.accessibilityIdentifier = AI.PROGRESS_CELL_SUBTRACT_ACTIVITY
        format(button: subtractActivity, text: "Subtract")
        subtractActivity.addTarget(self, action: #selector(subtractActivityButtonPressed), for: .touchUpInside)
        
        name.translatesAutoresizingMaskIntoConstraints = false
        recordActivity.translatesAutoresizingMaskIntoConstraints = false
        subtractActivity.translatesAutoresizingMaskIntoConstraints = false
        activityCount.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            name.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3),
            name.topAnchor.constraint(equalTo: self.topAnchor, constant: CELL_SPACING_TOP),
            name.bottomAnchor.constraint(equalTo: activityCount.topAnchor, constant: CELL_SPACING_BOTTOM),
            name.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            name.leftAnchor.constraint(equalTo: subtractActivity.rightAnchor),
            name.rightAnchor.constraint(equalTo: recordActivity.leftAnchor),
            recordActivity.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3),
            recordActivity.topAnchor.constraint(equalTo: self.topAnchor, constant: CELL_SPACING_TOP),
            recordActivity.bottomAnchor.constraint(equalTo: activityCount.topAnchor, constant: CELL_SPACING_BOTTOM),
            subtractActivity.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3),
            subtractActivity.topAnchor.constraint(equalTo: self.topAnchor, constant: CELL_SPACING_TOP),
            subtractActivity.bottomAnchor.constraint(equalTo: activityCount.topAnchor, constant: CELL_SPACING_BOTTOM),
            activityCount.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: CELL_SPACING_BOTTOM),
            activityCount.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    @objc func recordActivityButtonPressed() {
        delegate?.recordActivityButtonPressedFor(item: item.getItemDetailsDto().getId()!)
    }
    
    @objc func subtractActivityButtonPressed() {
        print("subtract button pressed")
    }
    
    private func format(button: UIButton, text: String?) {
        let attributedString = NSAttributedString(
            string: text ?? "",
            attributes:[
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.underlineStyle: 1.0
            ])
        button.setAttributedTitle(attributedString, for: .normal)
        button.titleLabel?.textAlignment = .left
    }
}

