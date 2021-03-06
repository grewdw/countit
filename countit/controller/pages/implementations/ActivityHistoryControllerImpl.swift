//
//  ActivityHistoryControllerImpl.swift
//  countit
//
//  Created by David Grew on 01/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit
import CoreData

class ActivityHistoryControllerImpl: UIViewController {
    
    let activityService: ActivityService
    var item: NSManagedObjectID?
    var activityRecords: [ActivityRecordDto] = []
    
    init(activityService: ActivityService) {
        self.activityService = activityService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let itemUnwrapped = item {
            activityRecords = activityService.getActivityHistoryFor(item: itemUnwrapped).getActivity()
        }
        let tableView = ActivityHistoryView(frame: self.view.bounds, historyViewController: self)
        if activityRecords.count == 0 {
            tableView.navBarNoButtons(for: self)
        }
        else {
            tableView.navBarToEdit(for: self)
        }
        tableView.delegate = self
        tableView.dataSource = self
        self.view = tableView
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        item = nil
        activityRecords.removeAll()
        self.view = nil
    }
}

extension ActivityHistoryControllerImpl: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityRecords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return ActivityRecordCell(activityRecord: activityRecords[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        return [UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            let _ = self.activityService.delete(activityRecord: self.activityRecords[indexPath.row])
            self.activityRecords.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            if self.activityRecords.count == 0 {
                let historyView = tableView as? ActivityHistoryView
                historyView?.navBarNoButtons(for: self)
            }
        }]
    }
}

extension ActivityHistoryControllerImpl: ActivityHistoryController {
    func withItem(id: NSManagedObjectID) -> ActivityHistoryController {
        item = id
        return self
    }
    
    func editButtonPressed() {
        let tableView = self.view as? ActivityHistoryView
        tableView?.setEditing(true, animated: true)
        tableView?.navBarToDone(for: self)
    }
    
    func doneButtonPressed() {
        let tableView = self.view as? ActivityHistoryView
        tableView?.setEditing(false, animated: true)
        tableView?.navBarToEdit(for: self)
    }
}
