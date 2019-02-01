//
//  UITestBaseActivityHistorySteps.swift
//  countitUITests
//
//  Created by David Grew on 01/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import XCTest

extension UITestBase {
    
    func deleteActivityIn(cell: Int) {
        activityHistoryTable!.cells.element(boundBy: cell).swipeLeft()
        activityHistoryTable!.cells.element(boundBy: cell).buttons["Delete"].tap()
    }
}
