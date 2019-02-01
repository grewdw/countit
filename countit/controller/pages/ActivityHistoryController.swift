//
//  ActivityHistoryController.swift
//  countit
//
//  Created by David Grew on 01/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit
import CoreData

protocol ActivityHistoryController {
    
    func withItem(id: NSManagedObjectID) -> ActivityHistoryController
}
