//
//  CommonSteps.swift
//  countitTests
//
//  Created by David Grew on 01/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
@testable import countit
import CoreData

class ServiceConfig {
    
    let activityService: ActivityService
    let itemService: ItemService
    let progressService: ProgressService
    let userInstructionService: UserInstructionService
    
    init(clock: Clock) {
        let context = TestCoreDataConfig.getCoreDataContext()
        let calendar = Calendar.current
        let properties = TestProperties()
        let messageBroker = MessageBrokerNcImpl()
        
        let activityRepository = ActivityRepositoryImpl(context: context)
        let itemRepository = ItemRepositoryImpl(context: context)
        activityService = ActivityServiceImpl(activityRepository: activityRepository, clock: clock, calendar: calendar)
        itemService =  ItemServiceImpl(itemRepository: itemRepository, messageBroker: messageBroker, clock: clock)
        progressService = ProgressServiceImpl(itemService: itemService, activityService: activityService, calendar: calendar, clock: clock)
        userInstructionService = UserInstructionServiceImpl(messageBroker: messageBroker, properties: properties)
    }
    
    func getActivityService() -> ActivityService {
        return activityService
    }
    
    func getItemService() -> ItemService {
        return itemService
    }
    
    func getProgressService() -> ProgressService {
        return progressService
    }
}
