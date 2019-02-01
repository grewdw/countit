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

    func assertItemForm(isDisplayed expected: Bool, file: StaticString = #file, line: UInt = #line) {
        if let actual = itemForm?.exists {
            XCTAssertEqual(expected, actual,
                           "item form status incorrect. Expected \(expected) but was \(actual)",
                file: file, line: line)
        }
    }
    
    func assertItemForm(name: String?, description: String?, targetDirection: String?, targetValue: String?, targetTimePeriod: String?, file: StaticString = #file, line: UInt = #line) {
        if let expectedName = name {
            let actualName = nameFieldText!.value as? String
            XCTAssertEqual(expectedName, actualName,
                           "item name incorrect. Expected \(expectedName) but was \(actualName ?? "")",
                           file: file, line: line)
        }
        if let expectedDescription = description {
            let actualDescription = descriptionFieldText!.value as? String
            XCTAssertEqual(actualDescription, expectedDescription,
                           "item description incorrect. Expected \(expectedDescription) but was \(actualDescription ?? "")",
                           file: file, line: line)
        }
        if let expectedTargetDirection = targetDirection {
            let actualTargetDirection = targetDirectionFieldLabel!.label
            XCTAssertEqual(actualTargetDirection, expectedTargetDirection,
                           "target direction incorrect. Expected \(expectedTargetDirection) but was \(actualTargetDirection)",
                file: file, line: line)
        }
        if let expectedTargetValue = targetValue {
            let actualTargetValue = targetValueFieldText!.value as? String
            XCTAssertEqual(actualTargetValue, expectedTargetValue,
                           "target value incorrect. Expected \(expectedTargetValue) but was \(actualTargetValue ?? "")",
                           file: file, line: line)
        }
        if let expectedTargetTimePeriod = targetTimePeriod {
            let actualTargetTimePeriod = targetTimePeriodFieldLabel!.label
            XCTAssertEqual(actualTargetTimePeriod, expectedTargetTimePeriod,
                           "target timePeriod incorrect. Expected \(expectedTargetTimePeriod) but was \(actualTargetTimePeriod)",
                file: file, line: line)
        }
    }
    
    func assertItemFormSaveButton(isEnabled expected: Bool, file: StaticString = #file, line: UInt = #line) {
        if let actual = itemFormSaveButton?.isEnabled {
            XCTAssertTrue(actual == expected,
                          "save button status incorrect. Expected \(expected) but was \(actual)",
                file: file, line: line)
        }
    }
    
    func assertProgressTable(cell cellNumber: Int, is expectedName: String, file: StaticString = #file, line: UInt = #line) {
        let actualName = itemTable!.cells.element(boundBy: cellNumber).staticTexts[AI.PROGRESS_CELL_NAME].label
        XCTAssertEqual(actualName, expectedName,
                       "item name incorrect for cell \(cellNumber). Expected \(expectedName) but was \(actualName)",
            file: file, line: line)
    }
    
    func assertProgressTableCountIs(_ expectedCount: Int, file: StaticString = #file, line: UInt = #line) {
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
    
    func assertItemFormShowActivityButton(isEnabled expected: Bool, file: StaticString = #file, line: UInt = #line) {
        if let actual = showActivityButton?.exists {
            XCTAssertTrue(actual == expected,
                          "save button status incorrect. Expected \(expected) but was \(actual)",
                file: file, line: line)
        }
    }
    
    func assertActivityHistoryTable(cell cellNumber: Int, hasValue expectedValue: String, file: StaticString = #file, line: UInt = #line) {
        let cell = activityHistoryTable!.cells.element(boundBy: cellNumber)
        let actualValue = cell.staticTexts[AI.ACTIVITY_RECORD_VALUE].label
        XCTAssertEqual(actualValue, expectedValue,
                       "activity record value incorrect for cell \(cellNumber). Expected \(expectedValue) but was \(actualValue)",
            file: file, line: line)
    }
    
    func assertActivityHistoryTableCountIs(_ expectedCount: Int, file: StaticString = #file, line: UInt = #line) {
        let actualCount = activityHistoryTable!.cells.count
        XCTAssertTrue(expectedCount == actualCount,
                      "activity history table count incorrect. Expected \(expectedCount) but was \(actualCount)",
            file: file, line: line)
    }
}
