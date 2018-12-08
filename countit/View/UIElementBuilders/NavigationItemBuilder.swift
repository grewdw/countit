//
//  NavigationBarBuilder.swift
//  GuitarPracticeApp
//
//  Created by David Grew on 28/10/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

class NavigationItemBuilder {
    
    static func setNavBar(title: String?, leftButton: NavBarButtonType?, leftButtonTarget: NavBarButtonDelegate, rightButton: NavBarButtonType?, rightButtonTarget: NavBarButtonDelegate, controller: UIViewController) {
        controller.navigationItem.title = title
        controller.navigationItem.leftBarButtonItem = getBarButton(leftButton, leftButtonTarget)
        controller.navigationItem.rightBarButtonItem = getBarButton(rightButton, rightButtonTarget)
    }
    
    private static func getBarButton(_ buttonType: NavBarButtonType?, _ target: NavBarButtonDelegate) -> UIBarButtonItem? {
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
