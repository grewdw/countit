//
//  ProgressTableController.swift
//  countit
//
//  Created by David Grew on 08/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol ProgressTableController {
    
    func addNewItemButtonPressed()
    
    func itemSelected(itemDetails: ItemDetailsDto)
    
    func recordActivityFor(item: ItemDetailsDto, value: Int, timestamp: Date?)
    
    func itemCellStateChange(item: ItemProgressSummaryDto, state: ItemCellState)
    
    func updateCellHeights()
    
    func refreshTableData()
    
    func itemPositionsChanged(itemOneRow: Int, itemTwoRow: Int)
    
    func transitionToRecordActivityFormControllerFor(item: ItemDetailsDto)
    
    func transitionToActivityHistoryControllerFor(item: NSManagedObjectID)
}
