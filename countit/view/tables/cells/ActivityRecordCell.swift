//
//  ActivityRecordCell.swift
//  countit
//
//  Created by David Grew on 01/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class ActivityRecordCell: UITableViewCell {
    
    private let PADDING_LEFT: CGFloat = 20
    private let PADDING_RIGHT: CGFloat = -20
    private let PADDING_TOP: CGFloat = 7.5
    private let PADDING_BOTTOM: CGFloat = -7.5
    private let NOTE_PADDING_LEFT: CGFloat = 10
    private let NOTE_PADDING_TOP: CGFloat = 50
    
    init(activityRecord: ActivityRecordDto) {
        super.init(style: .subtitle, reuseIdentifier: "activityRecordCell")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy - HH:mm"
        
        let dateLabel = UILabel()
        let valueLabel = UILabel()
        let noteLabel = UILabel()
        
        dateLabel.text = dateFormatter.string(from: activityRecord.getTimestamp())
        dateLabel.font = UIFont.systemFont(ofSize: 15)
        dateLabel.accessibilityIdentifier = AccessibilityIdentifiers.ACTIVITY_RECORD_DATE
        
        valueLabel.text = "+" + String(activityRecord.getValue())
        valueLabel.textColor = .blue
        valueLabel.font = UIFont.systemFont(ofSize: 19)
        valueLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        valueLabel.accessibilityIdentifier = AccessibilityIdentifiers.ACTIVITY_RECORD_VALUE
        
        noteLabel.numberOfLines = 0
        noteLabel.text = activityRecord.getNote()
        noteLabel.textColor = .gray
        noteLabel.font = UIFont.systemFont(ofSize: 15)
        noteLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        noteLabel.accessibilityIdentifier = AccessibilityIdentifiers.ACTIVITY_RECORD_NOTE
        
        addSubview(dateLabel)
        addSubview(valueLabel)
        addSubview(noteLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: PADDING_LEFT),
            dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: PADDING_RIGHT),
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: PADDING_TOP),
            valueLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: PADDING_LEFT),
            valueLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: PADDING_BOTTOM),
            noteLabel.leftAnchor.constraint(equalTo: valueLabel.rightAnchor, constant: 10),
            noteLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: PADDING_RIGHT),
            noteLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            noteLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: PADDING_BOTTOM),
            noteLabel.centerYAnchor.constraint(equalTo: valueLabel.centerYAnchor)
        ])
        
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
