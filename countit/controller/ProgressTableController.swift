//
//  CurrentProgressController.swift
//  countit
//
//  Created by David Grew on 03/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

class ProgressTableController: UIViewController {
    
    private let controllerResolver: ControllerResolver
    private let itemService: ItemService
    
    private let refreshControl = UIRefreshControl()
    
    var items: [ItemDto] = []
    var tableView: UITableView?
    
    override func viewDidLoad() {
        getItems()
        initiateView()
    }

    override func viewWillAppear(_ animated: Bool) {
        refreshTable()
    }

    func initiateView() {
        let tableView = CurrentProgressTableView(frame: self.view.bounds)
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableDelegate = self
        tableView.initialiseNavBar(for: self)
        self.view = tableView
    }
    
    @objc func refreshTable() {
        getItems()
        let table = self.view as? UITableView
        table?.reloadData()
        refreshControl.endRefreshing()
    }
    
    init(_ controllerResolver: ControllerResolver, _ itemService: ItemService) {
        self.controllerResolver = controllerResolver
        self.itemService = itemService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProgressTableController: UITableViewDelegate, UITableViewDataSource {
    
    func getItems() {
        items = itemService.getItems()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return CurrentProgressTableCellView(items[indexPath.row].getName())
    }
}

extension ProgressTableController: TableController {
    
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

extension ProgressTableController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        print("will show")
        getItems()
        tableView?.reloadData()
    }
}
