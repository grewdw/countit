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
    
    func buttonPressed(_ button: NavBarButtonType)
    
    func itemSelected(itemDetails: ItemDetailsDto)
    
    func recordActivityButtonPressedFor(item: ItemDetailsDto)
    
    func subtractActivityButtonPressedFor(item: ItemDetailsDto)
    
    func stateChange(item: ItemSummaryDto, state: ItemCellState)
    
    func updateTableHeights()
}
