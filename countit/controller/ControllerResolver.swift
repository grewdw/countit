//
//  ControllerResolver.swift
//  countit
//
//  Created by David Grew on 13/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import Foundation
import UIKit

class ControllerResolver {
    
    var controllers: [ControllerType : UIViewController] = [:]
    
    func add(controller: UIViewController, called controllerName: ControllerType) {
        controllers.updateValue(controller, forKey: controllerName)
    }
    
    func get(_ controllerType: ControllerType) -> UIViewController? {
        return controllers[controllerType]
    }
}
