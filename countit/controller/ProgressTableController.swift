//
//  CurrentProgressController.swift
//  countit
//
//  Created by David Grew on 03/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit
import CoreData

class ProgressTableController: UIViewController, UISearchBarDelegate {
    
    private let controllerResolver: ControllerResolver
    private let viewResolver: ViewResolver
    private let itemService: ItemService
    private let activityService: ActivityService
    
    private let refreshControl = UIRefreshControl()
    
    var items: [ItemSummaryDto] = []
    var filteredItems: [ItemSummaryDto] = []
    
    var filteringItems: Bool = false
    
    init(_ controllerResolver: ControllerResolver, _ viewResolver: ViewResolver, _ itemService: ItemService, _ activityService: ActivityService) {
        self.controllerResolver = controllerResolver
        self.viewResolver = viewResolver
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
        refreshTable()
    }

    func initiateView() {
        let tableView = viewResolver.getCurrentProgressTableView(frame: self.view.bounds)
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        tableView.refreshControl = refreshControl
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized(gestureRecognizer:)))
        tableView.accessibilityIdentifier = AccessibilityIdentifiers.ITEM_TABLE
        tableView.addGestureRecognizer(longpress)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableDelegate = self
        tableView.initialiseNavBarWithSearch(for: self, searchResultsUpdater: self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 22.0
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = Colours.TABLE_BACKGROUND
        self.view = tableView
    }
}

extension ProgressTableController: UITableViewDelegate, UITableViewDataSource {
    
    func getItems() {
        items = itemService.getItems()
    }
    
    @objc func refreshTable() {
        getItems()
        reloadTableData()
        refreshControl.endRefreshing()
    }
    
    func filterItems(containing searchText: String) {
        filteredItems = items.filter({( item : ItemSummaryDto) -> Bool in
        return item.getItemDetailsDto().getName().lowercased().contains(searchText.lowercased())
        })
        reloadTableData()
    }
    
    private func reloadTableData() {
        let table = self.view as? UITableView
        table?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteringItems ? filteredItems.count : items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemsArray = filteringItems ? filteredItems : items
        
        let cell = CurrentProgressTableCellView(itemsArray[indexPath.row])
        cell.delegate = self
        cell.accessibilityIdentifier = "Cell" + String(indexPath.row)
        cell.accessoryType = UITableViewCell.AccessoryType.detailButton
        return cell
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let itemsArray = filteringItems ? filteredItems : items
        
        toItemController(item: itemsArray[indexPath.row].getItemDetailsDto())
    }
    
    private func toItemController(item: ItemDetailsDto?) {
        if let parentController = controllerResolver.get(ControllerType.PRIMARY_NAV_CONTROLLER) as? UINavigationController {
            if let itemFormController = controllerResolver.get(ControllerType.ITEM_FORM_CONTROLLER) as? FormController {
                if let itemToAdd = item {
                    itemFormController.with(item: itemToAdd)
                }
                parentController.pushViewController(itemFormController as! UIViewController, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let itemId = items[indexPath.row].getItemDetailsDto().getId() {
                self.items.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                let _ = itemService.delete(itemWithId: itemId)
            }
        }
    }
}

extension ProgressTableController: ProgressTableViewDelegate {
    
    func buttonPressed(_ button: NavBarButtonType) {
        switch button {
        case NavBarButtonType.ADD:
            addButtonPressed()
        default:
            break
        }
    }
    
    private func addButtonPressed() {
        toItemController(item: nil)
    }
    
    func recordActivityButtonPressedFor(item: ItemDetailsDto) {
        let _ = activityService.record(activityUpdate: ActivityUpdateDto(item: item, value: 1))
        refreshTable()
    }
    
    func subtractActivityButtonPressedFor(item: ItemDetailsDto) {
        let _ = activityService.record(activityUpdate: ActivityUpdateDto(item: item, value: -1))
        refreshTable()
    }
}

extension ProgressTableController {
    
    @objc func longPressGestureRecognized(gestureRecognizer: UIGestureRecognizer) {
        
        let tableView = self.view as! CurrentProgressTableView
        
        let longpress = gestureRecognizer as! UILongPressGestureRecognizer
        let state = longpress.state
        let locationInView = longpress.location(in: tableView)
        var indexPath = tableView.indexPathForRow(at: locationInView)
        
        switch state {
        case .began:
            if indexPath != nil {
                Path.initialIndexPath = indexPath
                let cell = tableView.cellForRow(at: indexPath!) as! CurrentProgressTableCellView
                My.cellSnapShot = snapshopOfCell(inputView: cell)
                var center = cell.center
                My.cellSnapShot?.center = center
                My.cellSnapShot?.alpha = 0.0
                tableView.addSubview(My.cellSnapShot!)
                
                UIView.animate(withDuration: 0.25, animations: {
                    center.y = locationInView.y
                    My.cellSnapShot?.center = center
                    My.cellSnapShot?.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                    My.cellSnapShot?.alpha = 0.98
                    cell.alpha = 0.0
                }, completion: { (finished) -> Void in
                    if finished {
                        cell.isHidden = true
                    }
                })
            }
            
        case .changed:
            var center = My.cellSnapShot?.center
            center?.y = locationInView.y
            My.cellSnapShot?.center = center!
            if ((indexPath != nil) && (indexPath != Path.initialIndexPath)) {
                
                self.items.swapAt((indexPath?.row)!, (Path.initialIndexPath?.row)!)
                //swap(&self.wayPoints[(indexPath?.row)!], &self.wayPoints[(Path.initialIndexPath?.row)!])
                tableView.moveRow(at: Path.initialIndexPath!, to: indexPath!)
                Path.initialIndexPath = indexPath
                if !filteringItems {
                  itemService.persistTableOrder(for: items)
                }
            }
            
        default:
            if let cell = tableView.cellForRow(at: Path.initialIndexPath!) as? CurrentProgressTableCellView {
                cell.isHidden = false
                cell.alpha = 0.0
                UIView.animate(withDuration: 0.25, animations: {
                    My.cellSnapShot?.center = cell.center
                    My.cellSnapShot?.transform = .identity
                    My.cellSnapShot?.alpha = 0.0
                    cell.alpha = 1.0
                }, completion: { (finished) -> Void in
                    if finished {
                        Path.initialIndexPath = nil
                        My.cellSnapShot?.removeFromSuperview()
                        My.cellSnapShot = nil
                    }
                })
            }
        }
    }
    
    func snapshopOfCell(inputView: UIView) -> UIView {
        
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        let cellSnapshot : UIView = UIImageView(image: image)
        cellSnapshot.layer.masksToBounds = false
        cellSnapshot.layer.cornerRadius = 0.0
        cellSnapshot.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
        cellSnapshot.layer.shadowRadius = 5.0
        cellSnapshot.layer.shadowOpacity = 0.4
        return cellSnapshot
    }
    
    struct My {
        static var cellSnapShot: UIView? = nil
    }
    
    struct Path {
        static var initialIndexPath: IndexPath? = nil
    }
}

extension ProgressTableController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text?.isEmpty ?? false || searchController.searchBar.text == "" {
            filteringItems = false
            refreshTable()
        } else {
            filteringItems = true
            filterItems(containing: searchController.searchBar.text!)
        }
    }
}

