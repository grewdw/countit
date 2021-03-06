//
//  ActivityHistory.swift
//  countitUITests
//
//  Created by David Grew on 01/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import XCTest
@testable import countit

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
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: nil, targetDirection: nil, targetValue: ITEM_TARGET_VALUE_TEN, targetTimePeriod: nil)
        select(FIRST_CELL)
        assertItemFormShowActivityButton(isEnabled: true)
        clickOnShowActivityButton()
        assertActivityHistoryTableCountIs(0)
        assertActivityHistoryNavBarButtonIs(expectedButton: "None")
    }
    
    func testAccessActivityHistoryFromItemCell() {
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: nil, targetDirection: nil, targetValue: ITEM_TARGET_VALUE_TEN, targetTimePeriod: nil)
        clickActivityHistoryButtonFor(cell: 0)
        assertActivityHistoryTableCountIs(0)
    }
    
    func testActivityHistoryShowsRecordedActivity() {
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: nil, targetDirection: nil, targetValue: ITEM_TARGET_VALUE_TEN, targetTimePeriod: nil)
        clickPlusOneButtonFor(cell: FIRST_CELL)
        clickPlusOneButtonFor(cell: FIRST_CELL)
        select(FIRST_CELL)
        clickOnShowActivityButton()
        assertActivityHistoryTableCountIs(2)
        assertActivityHistoryTable(cell: 0, hasValue: "+1", andNote: nil)
        assertActivityHistoryTable(cell: 0, hasValue: "+1", andNote: nil)
        assertActivityHistoryNavBarButtonIs(expectedButton: "Edit")
    }
    
    func testActivityHistoryDisplaysActivityNotes() {
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: nil, targetDirection: nil, targetValue: ITEM_TARGET_VALUE_TEN, targetTimePeriod: nil)
        clickAddButtonFor(cell: FIRST_CELL)
        updateRecordActivityFormWith(value: "2", note: "newNote")
        clickSaveButtonOnRecordActivityForm()
        select(FIRST_CELL)
        clickOnShowActivityButton()
        assertActivityHistoryTableCountIs(1)
        assertActivityHistoryTable(cell: 0, hasValue: "+2", andNote: "newNote")
    }
    
    func testDeleteActivitySwipe() {
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: nil, targetDirection: nil, targetValue: ITEM_TARGET_VALUE_TEN, targetTimePeriod: nil)
        clickPlusOneButtonFor(cell: FIRST_CELL)
        clickPlusOneButtonFor(cell: FIRST_CELL)
        select(FIRST_CELL)
        clickOnShowActivityButton()
        assertActivityHistoryTableCountIs(2)
        swipeToDeleteActivityIn(cell: SECOND_CELL)
        assertActivityHistoryTableCountIs(1)
        backButton?.tap()
        clickOnShowActivityButton()
        assertActivityHistoryTableCountIs(1)
        swipeToDeleteActivityIn(cell: FIRST_CELL)
        assertActivityHistoryTableCountIs(0)
        backButton?.tap()
        clickOnShowActivityButton()
        assertActivityHistoryTableCountIs(0)
    }
    
    func testDeleteActivityEdit() {
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: nil, targetDirection: nil, targetValue: ITEM_TARGET_VALUE_TEN, targetTimePeriod: nil)
        clickPlusOneButtonFor(cell: FIRST_CELL)
        clickActivityHistoryButtonFor(cell: 0)
        activityHistoryEditButton?.tap()
        assertActivityHistoryNavBarButtonIs(expectedButton: "Done")
        activityHistoryDoneButton?.tap()
        assertActivityHistoryNavBarButtonIs(expectedButton: "Edit")
    }
}
