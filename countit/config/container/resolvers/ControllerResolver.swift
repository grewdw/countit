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
    
    private let serviceResolver: ServiceResolver
    
    private let properties: Properties
    
    private var primaryNavController: UINavigationController?
    private var progressTableController: ProgressTableController?
    private var itemFormController: ItemFormController?
    private var activityHistoryController: ActivityHistoryController?
    
    init(serviceResolver: ServiceResolver, properties: Properties) {
        self.serviceResolver = serviceResolver
        self.properties = properties
    }

    func getPrimaryNavController() -> UINavigationController {
        if primaryNavController != nil {
            return primaryNavController!
        }
        else {
            primaryNavController = PrimaryNavigationController(
                rootViewController: getProgressTableController() as! UIViewController)
            return primaryNavController!
        }
    }
    
    func getProgressTableController() -> ProgressTableController {
        if progressTableController != nil {
            return progressTableController!
        }
        else {
            let newController = ProgressTableControllerImpl(self,
                                                                  serviceResolver.getProgressService(),
                                                                  serviceResolver.getItemService(),
                                                                  serviceResolver.getActivityService())
            newController.set(instructionsDisplayed: properties.getInstructionsDisplayed())
            progressTableController = newController
            return progressTableController!
        }
    }
    
    func getItemFormController() -> ItemFormController {
        if itemFormController != nil {
            return itemFormController!
        }
        else {
            itemFormController = ItemFormControllerImpl(self, serviceResolver.getItemService())
            return itemFormController!
        }
    }
    
    func getActivityHistoryController() -> ActivityHistoryController {
        return ActivityHistoryControllerImpl(activityService:
            serviceResolver.getActivityService())
    }
    
    func getRecordActivityFormController(item: ItemDetailsDto) -> RecordActivityFormController {
        return RecordActivityFormControllerImpl(controllerResolver: self, activityService: serviceResolver.getActivityService(), item: item)
    }
}
