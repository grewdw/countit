//
//  PrimaryNavigationController.swift
//  countit
//
//  Created by David Grew on 27/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class PrimaryNavigationController: UINavigationController {
    
    override init(rootViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        self.pushViewController(rootViewController, animated: false)
        self.navigationBar.barTintColor = Colours.LOGO_RED
        self.navigationBar.tintColor = .white
        self.navigationBar.isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
