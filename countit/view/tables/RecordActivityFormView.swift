//
//  RecordActivityFormView.swift
//  countit
//
//  Created by David Grew on 12/03/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import UIKit

class RecordActivityFormView: UITableView {
    
    private let recordActivityFormController: RecordActivityFormController
    
    init(frame: CGRect, delegate: UITableViewDelegate, dataSource: UITableViewDataSource, recordActivityFormController: RecordActivityFormController) {
        self.recordActivityFormController = recordActivityFormController
        super.init(frame: frame, style: .grouped)
        self.delegate = delegate
        self.dataSource = dataSource
        keyboardDismissMode = .onDrag
        accessibilityIdentifier = AccessibilityIdentifiers.RECORD_ACTIVITY_TABLE
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecordActivityFormView: NavBarButtonDelegate {
    
    func initialiseNavBar(for controller: UIViewController) {
        NavigationItemBuilder(for: controller)
            .with(title: "recordActivityForm")
            .build()
    }
}
