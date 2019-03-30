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
    private let messageBroker: MessageBroker
    
    private var primaryNavController: UINavigationController?
    private var progressTableController: ProgressTableController?
    
    init(serviceResolver: ServiceResolver, properties: Properties, messageBroker: MessageBroker) {
        self.serviceResolver = serviceResolver
        self.properties = properties
        self.messageBroker = messageBroker
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
        return ItemFormControllerImpl(self, serviceResolver.getItemService(), messageBroker: messageBroker)
    }
    
    func getActivityHistoryController() -> ActivityHistoryController {
        return ActivityHistoryControllerImpl(activityService:
            serviceResolver.getActivityService())
    }
    
    func getRecordActivityFormController(item: ItemDetailsDto) -> RecordActivityFormController {
        return RecordActivityFormControllerImpl(controllerResolver: self,
                                                activityService: serviceResolver.getActivityService(),
                                                item: item,
                                                messageBroker: messageBroker)
    }
}
