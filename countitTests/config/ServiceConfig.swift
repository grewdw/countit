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
    
    init(clock: Clock) {
        let context = TestCoreDataConfig.getCoreDataContext()
        let calendar = Calendar.current
        let activityRepository = ActivityRepositoryImpl(context: context)
        let itemRepository = ItemRepositoryImpl(context: context)
        activityService = ActivityServiceImpl(activityRepository: activityRepository, clock: clock, calendar: calendar)
        itemService =  ItemServiceImpl(activityService: activityService, itemRepository: itemRepository, clock: clock)
    }
    
    func getActivityService() -> ActivityService {
        return activityService
    }
    
    func getItemService() -> ItemService {
        return itemService
    }
}
