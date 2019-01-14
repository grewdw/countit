//
//  RecordActivity.swift
//  countitUITests
//
//  Created by David Grew on 10/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import XCTest

class RecordActivity: UITestBase {

    override func setUp() {
        super.setUp()
        
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: nil, target: nil)
        createItemWithDetailsAndSave(name: ITEM_NAME_TWO, description: nil, target: nil)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testRecordSingleActivityForFirstItem() {
        clickAddActivityButtonFor(cell: FIRST_CELL)
        
        assertActivityCountFor(cell: 0, is: "1")
        assertActivityCountFor(cell: 1, is: "0")
    }
    
    func testRecordSingleActivityForSecondItem() {
        clickAddActivityButtonFor(cell: SECOND_CELL)
        
        assertActivityCountFor(cell: 0, is: "0")
        assertActivityCountFor(cell: 1, is: "1")
    }
    
    func testRecordMultipleActivityForFirstItem() {
        clickAddActivityButtonFor(cell: FIRST_CELL)
        clickAddActivityButtonFor(cell: FIRST_CELL)
        clickAddActivityButtonFor(cell: FIRST_CELL)
        
        assertActivityCountFor(cell: 0, is: "3")
        assertActivityCountFor(cell: 1, is: "0")
    }

    func testRecordMultipleActivityForSecondItem() {
        clickAddActivityButtonFor(cell: SECOND_CELL)
        clickAddActivityButtonFor(cell: SECOND_CELL)
        clickAddActivityButtonFor(cell: SECOND_CELL)
        clickAddActivityButtonFor(cell: SECOND_CELL)
        
        assertActivityCountFor(cell: 0, is: "0")
        assertActivityCountFor(cell: 1, is: "4")
    }
    
    func testRecordMultipleActivityForBothItems() {
        clickAddActivityButtonFor(cell: FIRST_CELL)
        clickAddActivityButtonFor(cell: FIRST_CELL)
        clickAddActivityButtonFor(cell: FIRST_CELL)
        clickAddActivityButtonFor(cell: FIRST_CELL)
        clickAddActivityButtonFor(cell: FIRST_CELL)
        
        clickAddActivityButtonFor(cell: SECOND_CELL)
        clickAddActivityButtonFor(cell: SECOND_CELL)
        clickAddActivityButtonFor(cell: SECOND_CELL)
        
        assertActivityCountFor(cell: 0, is: "5")
        assertActivityCountFor(cell: 1, is: "3")
    }
}
