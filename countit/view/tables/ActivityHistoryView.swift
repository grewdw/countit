//
//  ActivityHistoryView.swift
//  countit
//
//  Created by David Grew on 01/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class ActivityHistoryView: UITableView {
    
    init(frame: CGRect) {
        super.init(frame: frame, style: .plain)
        self.accessibilityIdentifier = AccessibilityIdentifiers.ACTIVITY_HISTORY_TABLE
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialiseNavBar(for controller: UIViewController) {
        NavigationItemBuilder(for: controller)
            .with(title: "activityHistory")
            .build()
    }
}
