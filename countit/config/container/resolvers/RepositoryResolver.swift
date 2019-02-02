//
//  RepositoryResolver.swift
//  countit
//
//  Created by David Grew on 02/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import CoreData

class RepositoryResolver {
    
    private let context: NSManagedObjectContext
    
    private var itemRepository: ItemRepository?
    private var activityRepository: ActivityRepository?
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func getItemRepository() -> ItemRepository {
        if itemRepository != nil {
            return itemRepository!
        }
        else {
            itemRepository = ItemRepositoryImpl(context: context)
            return itemRepository!
        }
    }
    
    func getActivityRepository() -> ActivityRepository {
        if activityRepository != nil {
            return activityRepository!
        }
        else {
            activityRepository = ActivityRepositoryImpl(context: context)
            return activityRepository!
        }
    }
}
