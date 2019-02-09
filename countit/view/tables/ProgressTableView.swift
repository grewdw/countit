//
//  ProgressTableView.swift
//  countit
//
//  Created by David Grew on 08/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

class ProgressTableView: UITableView {

    var progressTableDelegate: ProgressTableController
    
    init(delegate: ProgressTableController) {
        progressTableDelegate = delegate
        super.init(frame: CGRect(), style: .plain)
        
        accessibilityIdentifier = AccessibilityIdentifiers.ITEM_TABLE
        
        setupRefreshControl()
        setupOrderChange()
        separatorStyle = .none
        dataSource = delegate as? UITableViewDataSource
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 22.0
        tableFooterView = UIView()
        backgroundColor = Colors.TABLE_BACKGROUND
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
    }
    
    func setupOrderChange() {
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized(gestureRecognizer:)))
        addGestureRecognizer(longpress)
    }
}

extension ProgressTableView: NavBarButtonDelegate {
    
    func initialiseNavBarWithSearch(for controller: UIViewController, searchResultsUpdater: UISearchResultsUpdating) {
        NavigationItemBuilder(for: controller)
            .with(rightButton: .ADD, forTarget: self)
            .with(title: "countIt")
            .withSearchController(searchResultsUpdater: searchResultsUpdater, placeholder: "Search items")
            .build()
    }
    
    @objc func addButtonPressed() {
       progressTableDelegate.addButtonPressed()
    }
}

extension ProgressTableView {
    
    @objc func refreshTable() {
        progressTableDelegate.refreshTableData()
        refreshControl?.endRefreshing()
    }
}

extension ProgressTableView {
    
    @objc func longPressGestureRecognized(gestureRecognizer: UIGestureRecognizer) {
        
        let tableView = self
        
        let longpress = gestureRecognizer as! UILongPressGestureRecognizer
        let state = longpress.state
        let locationInView = longpress.location(in: tableView)
        var indexPath = tableView.indexPathForRow(at: locationInView)
        
        switch state {
        case .began:
            if indexPath != nil {
                Path.initialIndexPath = indexPath
                let cell = tableView.cellForRow(at: indexPath!) as! ItemCell
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
                
                progressTableDelegate.itemPositionsChanged(itemOneRow: (indexPath?.row)!, itemTwoRow: (Path.initialIndexPath?.row)!)
                tableView.moveRow(at: Path.initialIndexPath!, to: indexPath!)
                Path.initialIndexPath = indexPath
            }
            
        default:
            if let cell = tableView.cellForRow(at: Path.initialIndexPath!) as? ItemCell {
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
