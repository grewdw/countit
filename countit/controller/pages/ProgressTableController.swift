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
    
    func addButtonPressed()
    
    func itemSelected(itemDetails: ItemDetailsDto)
    
    func recordActivityButtonPressedFor(item: ItemDetailsDto)
    
    func subtractActivityButtonPressedFor(item: ItemDetailsDto)
    
    func itemCellStateChange(item: ItemProgressSummaryDto, state: ItemCellState)
    
    func updateCellHeights()
    
    func refreshTableData()
    
    func itemPositionsChanged(itemOneRow: Int, itemTwoRow: Int)
}
