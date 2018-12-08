//
//  CurrentProgressController.swift
//  countit
//
//  Created by David Grew on 03/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

class ProgressTableController: UIViewController, UITableViewDelegate, UITableViewDataSource, TableController {
    
    let items: [String] = ["item1", "item2", "item3"]
    
    override func viewDidLoad() {
        let tableView = CurrentProgressTableView(frame: self.view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableDelegate = self
        tableView.initialiseNavBar(controller: self)
        self.view = tableView
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return CurrentProgressTableCellView(items[indexPath.row])
    }
    
    func buttonPressed(_ button: NavBarButtonType) {
        switch button {
        case NavBarButtonType.ADD:
            addButtonPressed()
        default:
            break
        }
    }
    
    func addButtonPressed() {
        if let parentController = self.parent as? UINavigationController {
            parentController.pushViewController(ItemFormController(), animated: true)
        }
    }
}
