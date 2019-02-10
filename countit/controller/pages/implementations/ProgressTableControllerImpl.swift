//
//  ProgressTableControllerImpl.swift
//  countit
//
//  Created by David Grew on 03/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit
import CoreData

class ProgressTableControllerImpl: UIViewController, UISearchBarDelegate {
    
    private let controllerResolver: ControllerResolver
    private let itemService: ItemService
    private let activityService: ActivityService
    
    var items: [ItemSummaryDto] = []
    var filteredItems: [ItemSummaryDto] = []
    var itemToStateMap: [NSManagedObjectID:ItemCellState] = [:]
    
    var filteringItems: Bool = false
    
    init(_ controllerResolver: ControllerResolver, _ itemService: ItemService, _ activityService: ActivityService) {
        self.controllerResolver = controllerResolver
        self.itemService = itemService
        self.activityService = activityService
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
        refreshTableData()
    }
    
    func initiateView() {
        let tableView = ProgressTableView(delegate: self)
        tableView.initialiseNavBarWithSearch(for: self, searchResultsUpdater: self)
        self.view = tableView
    }
}

extension ProgressTableControllerImpl: UITableViewDelegate, UITableViewDataSource {
    
    func getItems() {
        items = itemService.getItems()
    }
    
    func filterItems(containing searchText: String) {
        filteredItems = items.filter({( item : ItemSummaryDto) -> Bool in
            return item.getItemDetailsDto().getName().lowercased().contains(searchText.lowercased())
        })
        let table = self.view as? UITableView
        table?.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteringItems ? filteredItems.count : items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = filteringItems ? filteredItems[indexPath.row] : items[indexPath.row]
        let state: ItemCellState
        let itemId = item.getItemDetailsDto().getId()
        state = itemToStateMap[itemId] != nil ? itemToStateMap[itemId]! : .CLOSED
        itemToStateMap.updateValue(state, forKey: item.getItemDetailsDto().getId())
        let cell = ItemCell(item: item, delegate: self, state: state)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let itemId = items[indexPath.row].getItemDetailsDto().getId()
            self.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            let _ = itemService.delete(itemWithId: itemId)
        }
    }
}

extension ProgressTableControllerImpl: ProgressTableController {
    
    func addButtonPressed() {
        toItemController(item: nil)
    }
    
    func itemSelected(itemDetails: ItemDetailsDto) {
        toItemController(item: itemDetails)
    }
    
    func recordActivityButtonPressedFor(item: ItemDetailsDto) {
        let _ = activityService.record(activityUpdate: ActivityUpdateDto(item: item, value: 1))
        refreshTableData()
    }
    
    func subtractActivityButtonPressedFor(item: ItemDetailsDto) {
        let _ = activityService.record(activityUpdate: ActivityUpdateDto(item: item, value: -1))
        refreshTableData()
    }
    
    func itemCellStateChange(item: ItemSummaryDto, state: ItemCellState) {
        itemToStateMap.updateValue(state, forKey: item.getItemDetailsDto().getId())
    }
    
    func updateCellHeights() {
        let tableView = view as? UITableView
        tableView?.beginUpdates()
        tableView?.endUpdates()
    }
    
    @objc func refreshTableData() {
        getItems()
        let table = self.view as? UITableView
        table?.reloadData()
    }
    
    func itemPositionsChanged(itemOneRow: Int, itemTwoRow: Int) {
        self.items.swapAt(itemOneRow, itemTwoRow)
        if !filteringItems {
            itemService.persistTableOrder(for: items)
        }
    }
    
    private func toItemController(item: ItemDetailsDto?) {
        let itemFormController = controllerResolver.getItemFormController()
        if let itemToAdd = item {
            itemFormController.with(item: itemToAdd)
        }
        controllerResolver.getPrimaryNavController()
            .pushViewController(itemFormController as! UIViewController, animated: true)
    }
}

extension ProgressTableControllerImpl: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text?.isEmpty ?? false || searchController.searchBar.text == "" {
            filteringItems = false
            refreshTableData()
        } else {
            filteringItems = true
            filterItems(containing: searchController.searchBar.text!)
        }
    }
}

