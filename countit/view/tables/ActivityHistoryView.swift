//
//  ActivityHistoryView.swift
//  countit
//
//  Created by David Grew on 01/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class ActivityHistoryView: UITableView {
    
    let historyViewController: ActivityHistoryController
    
    init(frame: CGRect, historyViewController: ActivityHistoryController) {
        self.historyViewController = historyViewController
        super.init(frame: frame, style: .plain)
        self.accessibilityIdentifier = AccessibilityIdentifiers.ACTIVITY_HISTORY_TABLE
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 22.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ActivityHistoryView: NavBarButtonDelegate {
    
    func navBarToEdit(for controller: UIViewController) {
        NavigationItemBuilder(for: controller)
            .with(title: "activityHistory")
            .with(rightButton: .EDIT, forTarget: self)
            .build()
    }
    
    func navBarToDone(for controller: UIViewController) {
        NavigationItemBuilder(for: controller)
            .with(title: "activityHistory")
            .with(rightButton: .DONE, forTarget: self)
            .build()
    }
    
    func navBarNoButtons(for controller: UIViewController) {
        NavigationItemBuilder(for: controller)
            .with(title: "activityHistory")
            .with(rightButton: .NONE, forTarget: self)
            .build()
    }
    
    @objc func editButtonPressed() {
        historyViewController.editButtonPressed()
    }
    
    @objc func doneButtonPressed() {
        historyViewController.doneButtonPressed()
    }
}
