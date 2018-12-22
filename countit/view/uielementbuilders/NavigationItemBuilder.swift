//
//  NavigationBarBuilder.swift
//  GuitarPracticeApp
//
//  Created by David Grew on 28/10/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

class NavigationItemBuilder {
    
    var controller: UIViewController
    var title: String? = nil
    var leftButton: NavBarButtonType?
    var rightButton: NavBarButtonType?
    var leftButtonTarget: NavBarButtonDelegate?
    var rightButtonTarget: NavBarButtonDelegate?
    var searchController: UISearchController?
    
    init(for controller: UIViewController) {
        self.controller = controller
    }
    
    func with(title: String) -> NavigationItemBuilder {
        self.title = title
        return self
    }
    
    func with(leftButton: NavBarButtonType, forTarget leftButtonTarget: NavBarButtonDelegate) -> NavigationItemBuilder {
        self.leftButton = leftButton
        self.leftButtonTarget = leftButtonTarget
        return self
    }
    
    func with(rightButton: NavBarButtonType, forTarget rightButtonTarget: NavBarButtonDelegate) -> NavigationItemBuilder {
        self.rightButton = rightButton
        self.rightButtonTarget = rightButtonTarget
        return self
    }
    
    func withSearchController(searchResultsUpdater: UISearchResultsUpdating, placeholder: String?) -> NavigationItemBuilder {
        searchController = UISearchController(searchResultsController: nil)
        searchController!.searchResultsUpdater = searchResultsUpdater
        searchController!.obscuresBackgroundDuringPresentation = false
        searchController!.searchBar.placeholder = placeholder
        return self
    }
    
    func build() {
        controller.navigationItem.title = title
        if leftButton != nil {
            controller.navigationItem.leftBarButtonItem = getBarButton(leftButton!, leftButtonTarget!)
        }
        if rightButton != nil {
            controller.navigationItem.rightBarButtonItem = getBarButton(rightButton!, rightButtonTarget!)
        }
        controller.navigationItem.searchController = searchController
    }
    
    private func getBarButton(_ buttonType: NavBarButtonType?, _ target: NavBarButtonDelegate) -> UIBarButtonItem? {
        if let button = buttonType {
            switch button {
            case NavBarButtonType.ADD :
                return NavBarButtonBuilder().getAddButton(target)
            case NavBarButtonType.CANCEL :
                return NavBarButtonBuilder().getCancelButton(target)
            case NavBarButtonType.DONE :
                return NavBarButtonBuilder().getDoneButton(target)
            case NavBarButtonType.EDIT :
                return NavBarButtonBuilder().getEditButton(target)
            case NavBarButtonType.SAVE :
                return NavBarButtonBuilder().getSaveButton(target)
            }
        }
        return nil
    }
}
