//
//  ProgressTableView.swift
//  countit
//
//  Created by David Grew on 08/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

class CurrentProgressTableView: UITableView, NavBarButtonDelegate {

    let NAV_ITEM_TITLE = "COUNT IT"
    var tableDelegate: ProgressTableViewDelegate?
    
    func initialiseNavBar(for controller: UIViewController) {
        NavigationItemBuilder(for: controller)
            .with(rightButton: .ADD, forTarget: controller as! NavBarButtonDelegate)
            .build()
    }
    
    func initialiseNavBarWithSearch(for controller: UIViewController, searchResultsUpdater: UISearchResultsUpdating) {
        NavigationItemBuilder(for: controller)
            .with(title: NAV_ITEM_TITLE)
            .with(rightButton: .ADD, forTarget: self)
            .withSearchController(searchResultsUpdater: searchResultsUpdater, placeholder: "Search items")
            .build()
    }
    
    @objc func addButtonPressed() {
        if let controller = tableDelegate {
            controller.buttonPressed(NavBarButtonType.ADD)
        }
    }
}
