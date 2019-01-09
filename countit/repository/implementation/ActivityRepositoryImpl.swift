//
//  ActivityRepositoryImpl.swift
//  countit
//
//  Created by David Grew on 07/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import CoreData
import Foundation

class ActivityRepositoryImpl: ActivityRepository {

    private let context: NSManagedObjectContext
    
    init (context: NSManagedObjectContext) {
        self.context = context
    }
    
    func save(activity: NewActivityDto, withTimestamp timestamp: NSDate) -> Bool {
        if let item = getItemWith(id: activity.getItem()) {
            let activityEntity = ActivityEntity(context: context)
            activityEntity.value = Int32(activity.getValue())
            activityEntity.createdTimestamp = timestamp as Date
            item.addToActivity(activityEntity)
            return saveContext()
        }
        return false
    }
    
    func getActivityCountFor(item: NSManagedObjectID) -> Int {
        return getItemWith(id: item)?.activity?.count ?? 0
    }
    
    private func getItemWith(id: NSManagedObjectID) -> ItemEntity? {
        return context.object(with: id) as? ItemEntity
    }
    
    private func saveContext() -> Bool {
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
}
