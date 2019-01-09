//
//  CurrentProgressTableCellView.swift
//  countit
//
//  Created by David Grew on 03/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

class CurrentProgressTableCellView: UITableViewCell {
    
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
        name.accessibilityIdentifier = "itemName"
        name.numberOfLines = 0
        name.textAlignment = .center
        
        activityCount.text = String(item.getActivityCount())
        activityCount.accessibilityIdentifier = "activityCount"
        activityCount.font = UIFont.boldSystemFont(ofSize: 20)
        activityCount.numberOfLines = 0
        activityCount.textAlignment = .center
        
        format(button: recordActivity, text: "Add")
        recordActivity.addTarget(self, action: #selector(recordActivityButtonPressed), for: .touchUpInside)
        
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
////            recordActivity.leftAnchor.constraint(equalTo: name.rightAnchor),
//            recordActivity.rightAnchor.constraint(equalTo: self.rightAnchor),
            subtractActivity.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3),
            subtractActivity.topAnchor.constraint(equalTo: self.topAnchor, constant: CELL_SPACING_TOP),
            subtractActivity.bottomAnchor.constraint(equalTo: activityCount.topAnchor, constant: CELL_SPACING_BOTTOM),
////            subtractActivity.rightAnchor.constraint(equalTo: name.leftAnchor),
//            subtractActivity.leftAnchor.constraint(equalTo: self.leftAnchor),
////            activityCount.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
////            activityCount.topAnchor.constraint(equalTo: name.bottomAnchor),
////            activityCount.topAnchor.constraint(equalTo: recordActivity.bottomAnchor),
////            activityCount.topAnchor.constraint(equalTo: subtractActivity.bottomAnchor),
            activityCount.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: CELL_SPACING_BOTTOM),
//            activityCount.rightAnchor.constraint(equalTo: self.rightAnchor),
//            activityCount.leftAnchor.constraint(equalTo: self.leftAnchor),
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

