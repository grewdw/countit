//
//  ServiceResolver.swift
//  countit
//
//  Created by David Grew on 02/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation

class ServiceResolver {
    
    private let repositoryResolver: RepositoryResolver
    private let clock: Clock
    private let calendar: Calendar
    
    private var itemService: ItemService?
    private var activityService: ActivityService?
    private var progressService: ProgressService?
    
    init(repositoryResolver: RepositoryResolver, clock: Clock, calendar: Calendar) {
        self.repositoryResolver = repositoryResolver
        self.clock = clock
        self.calendar = calendar
    }
    
    func getItemService() -> ItemService {
        if itemService != nil {
            return itemService!
        }
        else {
            itemService = ItemServiceImpl(itemRepository: repositoryResolver.getItemRepository(),
                                          clock: clock)
            return itemService!
        }
    }
    
    func getActivityService() -> ActivityService {
        if activityService != nil {
            return activityService!
        }
        else {
            activityService = ActivityServiceImpl(activityRepository: repositoryResolver.getActivityRepository(),
                                              clock: clock, calendar: calendar)
            return activityService!
        }
    }
    
    func getProgressService() -> ProgressService {
        if progressService != nil {
            return progressService!
        }
        else {
            progressService = ProgressServiceImpl(itemService: getItemService(), activityService: getActivityService(),
                                                  calendar: calendar, clock: clock)
            return progressService!
        }
    }
}
