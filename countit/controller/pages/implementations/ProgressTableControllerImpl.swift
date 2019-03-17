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
    private let progressService: ProgressService
    private let itemService: ItemService
    private let activityService: ActivityService
    
    var items: [ItemProgressSummaryDto] = []
    var itemToStateMap: [NSManagedObjectID:ItemCellState] = [:]
    
    var instructionsDisplayed: Bool = true
    
    init(_ controllerResolver: ControllerResolver, _ progressService: ProgressService, _ itemService: ItemService, _ activityService: ActivityService) {
        self.controllerResolver = controllerResolver
        self.progressService = progressService
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
        reloadData()
    }
    
    func initiateView() {
        let tableView = ProgressTableView(delegate: self)
        tableView.initialiseNavBar(for: self)
        self.view = tableView
    }
    
    func set(instructionsDisplayed: Bool) {
        self.instructionsDisplayed = instructionsDisplayed
    }
}

extension ProgressTableControllerImpl: UITableViewDelegate, UITableViewDataSource {
    
    func getItems() {
        items = progressService.getItemsProgresss()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !instructionsDisplayed && items.count == 0 {
            return 1
        }
        instructionsDisplayed = true
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !instructionsDisplayed && items.count == 0 {
            return EmptyItemListCell()
        }
        return createItemCellFor(indexPath: indexPath)
    }
    
    func createItemCellFor(indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
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
    
    func addNewItemButtonPressed() {
        toItemFormController(item: nil)
    }
    
    func itemSelected(itemDetails: ItemDetailsDto) {
        toItemFormController(item: itemDetails)
    }
    
    func transitionToRecordActivityFormControllerFor(item: ItemDetailsDto) {
        controllerResolver.getPrimaryNavController().pushViewController(
            controllerResolver.getRecordActivityFormController(item: item) as! UIViewController, animated: true)
    }
    
    func recordActivityFor(item: ItemDetailsDto, value: Int, timestamp: Date?) {
        let _ = activityService.record(activityUpdate: ActivityUpdateDto(item: item, value: value, timestamp: timestamp, note: nil))
        reloadData()
    }
    
    func itemCellStateChange(item: ItemProgressSummaryDto, state: ItemCellState) {
        itemToStateMap.updateValue(state, forKey: item.getItemDetailsDto().getId())
    }
    
    func updateCellHeights() {
        let tableView = view as? UITableView
        tableView?.beginUpdates()
        tableView?.endUpdates()
    }
    
    @objc func refreshTableData() {
        itemToStateMap.removeAll()
        reloadData()
    }
    
    private func reloadData() {
        getItems()
        let table = self.view as? UITableView
        table?.reloadData()
    }
    
    func itemPositionsChanged(itemOneRow: Int, itemTwoRow: Int) {
        self.items.swapAt(itemOneRow, itemTwoRow)
        itemService.persistTableOrder(for: toItemDetails(items: items))
    }
    
    func transitionToActivityHistoryControllerFor(item: NSManagedObjectID) {
        let historyController = controllerResolver.getActivityHistoryController().withItem(id: item)
        controllerResolver.getPrimaryNavController().pushViewController(historyController as! UIViewController, animated: true)
    }
    
    private func toItemDetails(items: [ItemProgressSummaryDto]) -> [ItemDetailsDto] {
        var itemDetails = [ItemDetailsDto]()
        for item in items {
            itemDetails.append(item.getItemDetailsDto())
        }
        return itemDetails
    }
    
    private func toItemFormController(item: ItemDetailsDto?) {
        let itemFormController = controllerResolver.getItemFormController()
        if let itemToAdd = item {
            itemFormController.with(item: itemToAdd)
        }
        controllerResolver.getPrimaryNavController()
            .pushViewController(itemFormController as! UIViewController, animated: true)
    }
}


