//
//  RecordActivity.swift
//  countitUITests
//
//  Created by David Grew on 17/03/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation

class RecordActivity: UITestBase {
    
    override func setUp() {
        super.setUp()
        
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: nil, targetDirection: nil, targetValue: ITEM_TARGET_VALUE_TEN, targetTimePeriod: nil)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testActivityDoesNotSaveWithoutValue() {
        clickAddButtonFor(cell: FIRST_CELL)
        clickSaveButtonOnRecordActivityForm()
        
        assertRecordActivityForm(isDisplayed: true)
    }
    
    func testActivitySavesWithValueEnteredAndUpdatesItemTable() {
        clickAddButtonFor(cell: FIRST_CELL)
        updateRecordActivityFormWith(value: "1", note: "note")
        clickSaveButtonOnRecordActivityForm()
        clickProgressButtonFor(cell: FIRST_CELL)
        
        assertRecordActivityForm(isDisplayed: false)
        assertProgressFor(cell: FIRST_CELL, isPercentage: "10%", withCount: "1 of 10")
    }
    
    func testNoteFieldIsOptional() {
        clickAddButtonFor(cell: FIRST_CELL)
        updateRecordActivityFormWith(value: "1", note: nil)
        clickSaveButtonOnRecordActivityForm()
        clickProgressButtonFor(cell: FIRST_CELL)
        
        assertRecordActivityForm(isDisplayed: false)
        assertProgressFor(cell: FIRST_CELL, isPercentage: "10%", withCount: "1 of 10")
    }
}
