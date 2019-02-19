//
//  ActivityService.swift
//  countit
//
//  Created by David Grew on 07/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import CoreData

protocol ActivityService {
    
    func record(activityUpdate activity: ActivityUpdateDto) -> Bool
    
    func getActivityCountFor(item: NSManagedObjectID, between: DateInterval) -> Int

    func getActivityHistoryFor(item: NSManagedObjectID) -> ActivityHistoryDto
    
    func delete(activityRecord: ActivityRecordDto) -> Bool
}
