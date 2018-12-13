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
    private let controllerResolver: ControllerResolver
    
    override func viewDidLoad() {
        let tableView = CurrentProgressTableView(frame: self.view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableDelegate = self
        tableView.initialiseNavBar(for: self)
        self.view = tableView
    }
    
    init(_ controllerResolver: ControllerResolver) {
        self.controllerResolver = controllerResolver
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
            if let itemFormController = controllerResolver.get(ControllerType.ITEM_FORM_CONTROLLER) {
                parentController.pushViewController(itemFormController, animated: true)
            }
        }
    }
}
