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
    private let viewResolver: ViewResolver
    private let itemService: ItemService
    
    private let refreshControl = UIRefreshControl()
    
    var items: [ItemDto] = []
    
    init(_ controllerResolver: ControllerResolver, _ viewResolver: ViewResolver, _ itemService: ItemService) {
        self.controllerResolver = controllerResolver
        self.viewResolver = viewResolver
        self.itemService = itemService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        getItems()
        initiateView()
    }

    override func viewWillAppear(_ animated: Bool) {
        refreshTable()
    }

    func initiateView() {
        let tableView = viewResolver.getCurrentProgressTableView(frame: self.view.bounds)
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableDelegate = self
        tableView.initialiseNavBar(for: self)
        self.view = tableView
    }
}

extension ProgressTableController: UITableViewDelegate, UITableViewDataSource {
    
    func getItems() {
        items = itemService.getItems()
    }
    
    @objc func refreshTable() {
        getItems()
        let table = self.view as? UITableView
        table?.reloadData()
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CurrentProgressTableCellView(items[indexPath.row].getName())
        cell.accessoryType = UITableViewCell.AccessoryType.detailButton
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        toItemController(item: items[indexPath.row])
    }
    
    private func toItemController(item: ItemDto?) {
        if let parentController = controllerResolver.get(ControllerType.PRIMARY_NAV_CONTROLLER) as? UINavigationController {
            if let itemFormController = controllerResolver.get(ControllerType.ITEM_FORM_CONTROLLER) as? FormController {
                if let itemToAdd = item {
                    itemFormController.with(item: itemToAdd)
                }
                parentController.pushViewController(itemFormController as! UIViewController, animated: true)
            }
        }
        
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
        toItemController(item: nil)
    }
}

