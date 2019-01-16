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
    
    func assertTable(cell cellNumber: Int, is expectedName: String, file: StaticString = #file, line: UInt = #line) {
        let actualName = itemTable!.cells.element(boundBy: cellNumber).staticTexts[AI.PROGRESS_CELL_NAME].label
        XCTAssertEqual(actualName, expectedName,
                       "item name incorrect for cell \(cellNumber). Expected \(expectedName) but was \(actualName)",
                       file: file, line: line)
    }
    
    func assertItemForm(name: String?, description: String?, target: String?, file: StaticString = #file, line: UInt = #line) {
        if let expectedName = name {
            let actualName = nameField!.value as? String
            XCTAssertEqual(expectedName, actualName,
                           "item name incorrect. Expected \(expectedName) but was \(actualName ?? "")",
                           file: file, line: line)
        }
        if let expectedDescription = description {
            let actualDescription = descriptionField!.value as? String
            XCTAssertEqual(actualDescription, expectedDescription,
                           "item description incorrect. Expected \(expectedDescription) but was \(actualDescription ?? "")",
                           file: file, line: line)
        }
        if let expectedTarget = target {
            let actualTarget = targetField!.value as? String
            XCTAssertEqual(actualTarget, expectedTarget,
                           "target value incorrect. Expected \(expectedTarget) but was \(actualTarget ?? "")",
                           file: file, line: line)
        }
    }
    
    func assertItemFormErrorIs(_ expectedError: String, file: StaticString = #file, line: UInt = #line) {
        let actualError = nameFieldError!.label
        XCTAssertEqual(actualError, expectedError,
                       "error is incorrect. Expected \(expectedError) but was \(actualError)",
                       file: file, line: line)
    }
    
    func assertTableCountIs(_ expectedCount: Int, file: StaticString = #file, line: UInt = #line) {
        let actualCount = itemTable!.cells.count
        XCTAssertTrue(expectedCount == actualCount,
                      "table count incorrect. Expected \(expectedCount) but was \(actualCount)",
                      file: file, line: line)
    }
    
    func assertActivityCountFor(cell: Int, is activityCount: Int, file: StaticString = #file, line: UInt = #line) {
        let expectedActivityCount  = String(activityCount) + " / " + "0"
        let actualActivityCount = itemTable!.cells.element(boundBy: cell).staticTexts[AI.PROGRESS_CELL_ACTIVITY_COUNT].label
        XCTAssertEqual(actualActivityCount, expectedActivityCount,
                       "activityCount incorrect. Expected \(expectedActivityCount) but was \(actualActivityCount)",
                       file: file, line: line)
    }
}
