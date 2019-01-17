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
    
    func record(newActivity activity: NewActivityDto) -> Bool
    
    func getCurrentTargetProgressFor(item: ItemDetailsDto) -> ItemSummaryDto
}
