//
//  UITestBaseAssertions.swift
//  countitUITests
//
//  Created by David Grew on 14/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import XCTest

extension UITestBase {
    
    func assertTable(cell cellNumber: Int, is itemName: String) {
        XCTAssertEqual(itemTable!.cells.element(boundBy: cellNumber).staticTexts[AI.PROGRESS_CELL_NAME].label, itemName, "item name not correct in cell")
    }
    
    func assertItemForm(name: String?, description: String?, target: String?) {
        if let nameUnwrapped = name {
            XCTAssertEqual(nameField!.value as? String, nameUnwrapped, "item name not correct on form")
        }
        if let descriptionUnwrapped = description {
            XCTAssertEqual(descriptionField!.value as? String, descriptionUnwrapped, "item description not correct on form")
        }
        if let targetUnwrapped = target {
            XCTAssertEqual(targetField!.value as? String, targetUnwrapped, "target value not correct in cell")
        }
    }
    
    func assertItemFormErrorIs(_ error: String) {
        XCTAssertEqual(nameFieldError!.label, error)
    }
    
    func assertTableCountIs(_ count: Int) {
        XCTAssertTrue(itemTable!.cells.count == count)
    }
    
    func assertActivityCountFor(cell: Int, is activityCount: String) {
        XCTAssertEqual(itemTable!.cells.element(boundBy: cell).staticTexts[AI.PROGRESS_CELL_ACTIVITY_COUNT].label, activityCount, "activityCount not correct")
    }
}
