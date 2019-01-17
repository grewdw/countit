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
    
    func save(activity: ActivityUpdateDto, withTimestamp timestamp: Date) -> Bool {
        if let id = activity.getItem().getId() {
            if let item = getItemWith(id: id) {
                let activityEntity = ActivityEntity(context: context)
                activityEntity.value = Int32(activity.getValue())
                activityEntity.createdTimestamp = timestamp
                item.addToActivity(activityEntity)
                return saveContext()
            }
            return false
        }
        return false
    }
    
    func getActivitiesFor(item: NSManagedObjectID) -> [ActivityEntity] {
        let request: NSFetchRequest<ActivityEntity> = ActivityEntity.fetchRequest()
        request.predicate = NSPredicate(format: "item == %@", item)
        return getActivities(with: request)
    }
    
    func getActivitiesFor(item: NSManagedObjectID, fromStartDate start: Date, toEndDate end: Date) -> [ActivityEntity] {
        let request: NSFetchRequest<ActivityEntity> = ActivityEntity.fetchRequest()
        request.predicate = NSPredicate(format: "item == %@ AND createdTimestamp >= %@ AND createdTimestamp < %@", item, start as NSDate, end as NSDate)
        return getActivities(with: request)
    }
    
    private func getActivities(with request: NSFetchRequest<ActivityEntity>) -> [ActivityEntity] {
        do {
            let items: [ActivityEntity] = try context.fetch(request)
            return items
        } catch {
            return [ActivityEntity]()
        }
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
