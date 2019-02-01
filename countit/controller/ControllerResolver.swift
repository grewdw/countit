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
    
    private let activityService: ActivityService
    private let itemService: ItemService
    private let viewResolver: ViewResolver
    
    private var primaryNavController: UINavigationController?
    private var progressTableController: ProgressTableController?
    private var itemFormController: ItemFormController?
    private var activityHistoryController: ActivityHistoryController?
    
    init(activityService: ActivityService, itemService: ItemService) {
        viewResolver = ViewResolver()
        self.activityService = activityService
        self.itemService = itemService
    }

    func getPrimaryNavController() -> UINavigationController {
        if primaryNavController != nil {
            return primaryNavController!
        }
        else {
            primaryNavController = PrimaryNavigationController(rootViewController: getProgressTableController() as! UIViewController)
            return primaryNavController!
        }
    }
    
    func getProgressTableController() -> ProgressTableController {
        if progressTableController != nil {
            return progressTableController!
        }
        else {
            progressTableController = ProgressTableControllerImpl(self, viewResolver, itemService, activityService)
            return progressTableController!
        }
    }
    
    func getItemFormController() -> ItemFormController {
        if itemFormController != nil {
            return itemFormController!
        }
        else {
            itemFormController = ItemFormControllerImpl(self, viewResolver, itemService)
            return itemFormController!
        }
    }
    
    func getActivityHistoryController() -> ActivityHistoryController {
        if activityHistoryController != nil {
            return activityHistoryController!
        }
        else {
            activityHistoryController = ActivityHistoryControllerImpl(activityService: activityService)
            return activityHistoryController!
        }
    }
}
