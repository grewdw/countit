//
//  ActivityRecordCell.swift
//  countit
//
//  Created by David Grew on 01/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class ActivityRecordCell: UITableViewCell {
    
    init(activityRecord: ActivityRecordDto) {
        super.init(style: .subtitle, reuseIdentifier: "activityRecordCell")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy - HH:mm"
        textLabel?.text = dateFormatter.string(from: activityRecord.getTimestamp())
        textLabel?.font = UIFont.systemFont(ofSize: 15)
        textLabel?.accessibilityIdentifier = AccessibilityIdentifiers.ACTIVITY_RECORD_DATE
        
        detailTextLabel?.text = "+" + String(activityRecord.getValue())
        detailTextLabel?.textColor = .blue
        detailTextLabel?.font = UIFont.systemFont(ofSize: 19)
        detailTextLabel?.accessibilityIdentifier = AccessibilityIdentifiers.ACTIVITY_RECORD_VALUE
        
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
