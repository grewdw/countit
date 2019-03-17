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
        let id = activity.getItem().getId()
        if let item = getItemWith(id: id) {
            let activityEntity = ActivityEntity(context: context)
            activityEntity.value = Int32(activity.getValue())
            activityEntity.createdTimestamp = timestamp
            activityEntity.note = activity.getNote()
            item.addToActivity(activityEntity)
            return saveContext()
        }
        return false
    }
    
    func getActivitiesFor(item: NSManagedObjectID) -> [ActivityRecordDto] {
        let request: NSFetchRequest<ActivityEntity> = ActivityEntity.fetchRequest()
        request.predicate = NSPredicate(format: "item == %@", item)
        request.sortDescriptors = [NSSortDescriptor(key: "createdTimestamp", ascending: false)]
        return toDtoFrom(activityEntities: getActivities(with: request))
    }
    
    func getActivitiesFor(item: NSManagedObjectID, fromStartDate start: Date, toEndDate end: Date) -> [ActivityEntity] {
        let request: NSFetchRequest<ActivityEntity> = ActivityEntity.fetchRequest()
        request.predicate = NSPredicate(format: "item == %@ AND createdTimestamp >= %@ AND createdTimestamp < %@", item, start as NSDate, end as NSDate)
        return getActivities(with: request)
    }
    
    func delete(activityRecord: ActivityRecordDto) -> Bool {
        if let activity = context.object(with: activityRecord.getId()) as? ActivityEntity {
            context.delete(activity)
            return saveContext()
        }
        else {
            return false
        }
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
    
    private func toDtoFrom(activityEntities: [ActivityEntity]) -> [ActivityRecordDto] {
        var dtoArray: [ActivityRecordDto] = []
        for entity in activityEntities {
            dtoArray.append(ActivityRecordDto(activityEntity: entity))
        }
        return dtoArray
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
