//
//  ActivityHistory.swift
//  countitUITests
//
//  Created by David Grew on 01/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import XCTest

class ActivityHistory: UITestBase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testActivityHistoryButtonNotShownForNewItem() {
        openItemForm()
        assertItemFormShowActivityButton(isEnabled: false)
    }
    
    func testActivityHistoryIsEmptyWithNoActivity() {
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: nil, targetDirection: nil, targetValue: nil, targetTimePeriod: nil)
        select(FIRST_CELL)
        assertItemFormShowActivityButton(isEnabled: true)
        clickOnShowActivityButton()
        assertActivityHistoryTableCountIs(0)
    }
    
    func testActivityHistoryShowsRecordedActivity() {
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: nil, targetDirection: nil, targetValue: nil, targetTimePeriod: nil)
        clickAddActivityButtonFor(cell: FIRST_CELL)
        clickAddActivityButtonFor(cell: FIRST_CELL)
        select(FIRST_CELL)
        clickOnShowActivityButton()
        assertActivityHistoryTableCountIs(2)
        assertActivityHistoryTable(cell: 0, hasValue: "+1")
        assertActivityHistoryTable(cell: 0, hasValue: "+1")
    }
    
    func testDeleteActivity() {
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: nil, targetDirection: nil, targetValue: nil, targetTimePeriod: nil)
        clickAddActivityButtonFor(cell: FIRST_CELL)
        clickAddActivityButtonFor(cell: FIRST_CELL)
        select(FIRST_CELL)
        clickOnShowActivityButton()
        assertActivityHistoryTableCountIs(2)
        deleteActivityIn(cell: SECOND_CELL)
        assertActivityHistoryTableCountIs(1)
        backButton?.tap()
        clickOnShowActivityButton()
        assertActivityHistoryTableCountIs(1)
        deleteActivityIn(cell: FIRST_CELL)
        assertActivityHistoryTableCountIs(0)
        backButton?.tap()
        clickOnShowActivityButton()
        assertActivityHistoryTableCountIs(0)
    }
}
