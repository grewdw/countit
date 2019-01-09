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

class CommonSteps {
    
    static func getItemService() -> ItemService {
        let context = TestCoreDataConfig.getCoreDataContext()
        let clock = Clock()
        let activityRepository = ActivityRepositoryImpl(context: context)
        let activityService = ActivityServiceImpl(activityRepository: activityRepository, clock: clock)
        let itemRepository = ItemRepositoryImpl(context: context)
        return ItemServiceImpl(activityService: activityService, itemRepository: itemRepository, clock: clock)
    }
}
