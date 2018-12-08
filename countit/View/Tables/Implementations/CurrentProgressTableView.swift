//
//  ProgressTableView.swift
//  countit
//
//  Created by David Grew on 08/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

class CurrentProgressTableView: UITableView, TableView, NavBarButtonDelegate {

    let NAV_ITEM_TITLE = "COUNT IT"
    var tableDelegate: TableController?
    
    func initialiseNavBar(controller: TableController) {
        if let controller = tableDelegate as? UIViewController {
            NavigationItemBuilder.setNavBar(title: NAV_ITEM_TITLE, leftButton: nil, leftButtonTarget: self, rightButton: NavBarButtonType.ADD, rightButtonTarget: self, controller: controller)
        }
    }
    
    @objc func addButtonPressed() {
        if let controller = tableDelegate {
            controller.buttonPressed(NavBarButtonType.ADD)
        }
    }
}
