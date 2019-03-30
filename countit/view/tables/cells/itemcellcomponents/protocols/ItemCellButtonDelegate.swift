//
//  ItemCellButtonDelegate.swift
//  countit
//
//  Created by David Grew on 06/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation

protocol ItemCellButtonDelegate: class {
    
    func moreInfoButtonPressed()
    
    func addButtonPressed()
    
    func plusOneButtonPressed()
    
    func progressButtonPressed()
    
    func performanceButtonPressed()
    
    func activityHistoryButtonPressed()
}
