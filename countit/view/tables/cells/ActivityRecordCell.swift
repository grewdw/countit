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
        super.init(style: .value1, reuseIdentifier: "activityRecordCell")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        textLabel?.text = dateFormatter.string(from: activityRecord.getTimestamp())
        detailTextLabel?.text = "+" + String(activityRecord.getValue())
        
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
