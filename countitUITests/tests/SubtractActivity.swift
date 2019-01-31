//
//  SubtractActivity.swift
//  countitUITests
//
//  Created by David Grew on 17/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import XCTest

class SubtractActivity: UITestBase {

    override func setUp() {
        super.setUp()
        
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: nil, targetDirection: nil, targetValue: nil, targetTimePeriod: nil)
        createItemWithDetailsAndSave(name: ITEM_NAME_TWO, description: nil, targetDirection: nil, targetValue: nil, targetTimePeriod: nil)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testCannotSubtractWhenCountIsZero_ItemOne() {
        clickSubtractActivityButtonFor(cell: FIRST_CELL)
        
        assertActivityCountFor(cell: 0, is: 0)
        assertActivityCountFor(cell: 1, is: 0)
    }
    
    func testCanSubtractWhenCountIsOne_ItemOne() {
        clickAddActivityButtonFor(cell: FIRST_CELL)
        clickSubtractActivityButtonFor(cell: FIRST_CELL)
        
        assertActivityCountFor(cell: 0, is: 0)
        assertActivityCountFor(cell: 1, is: 0)
    }

    func testCanSubtractMultipleWhenCountIsMoreThanOne_ItemOne() {
        clickAddActivityButtonFor(cell: FIRST_CELL)
        clickAddActivityButtonFor(cell: FIRST_CELL)
        clickAddActivityButtonFor(cell: FIRST_CELL)
        clickAddActivityButtonFor(cell: FIRST_CELL)
        
        clickSubtractActivityButtonFor(cell: FIRST_CELL)
        
        assertActivityCountFor(cell: 0, is: 3)
        assertActivityCountFor(cell: 1, is: 0)
        
        clickSubtractActivityButtonFor(cell: FIRST_CELL)
        
        assertActivityCountFor(cell: 0, is: 2)
        assertActivityCountFor(cell: 1, is: 0)
        
        clickSubtractActivityButtonFor(cell: FIRST_CELL)
        
        assertActivityCountFor(cell: 0, is: 1)
        assertActivityCountFor(cell: 1, is: 0)
        
        clickSubtractActivityButtonFor(cell: FIRST_CELL)
        
        assertActivityCountFor(cell: 0, is: 0)
        assertActivityCountFor(cell: 1, is: 0)
        
        clickSubtractActivityButtonFor(cell: FIRST_CELL)
        
        assertActivityCountFor(cell: 0, is: 0)
        assertActivityCountFor(cell: 1, is: 0)
    }
    
    func testCannotSubtractWhenCountIsZero_ItemTwo() {
        clickSubtractActivityButtonFor(cell: SECOND_CELL)
        
        assertActivityCountFor(cell: 0, is: 0)
        assertActivityCountFor(cell: 1, is: 0)
    }
    
    func testCanSubtractWhenCountIsOne_ItemTwo() {
        clickAddActivityButtonFor(cell: SECOND_CELL)
        clickSubtractActivityButtonFor(cell: SECOND_CELL)
        
        assertActivityCountFor(cell: 0, is: 0)
        assertActivityCountFor(cell: 1, is: 0)
    }
    
    func testCanSubtractMultipleWhenCountIsMoreThanOne_ItemTwo() {
        clickAddActivityButtonFor(cell: SECOND_CELL)
        clickAddActivityButtonFor(cell: SECOND_CELL)
        clickAddActivityButtonFor(cell: SECOND_CELL)
        clickAddActivityButtonFor(cell: SECOND_CELL)
        
        clickSubtractActivityButtonFor(cell: SECOND_CELL)
        
        assertActivityCountFor(cell: 0, is: 0)
        assertActivityCountFor(cell: 1, is: 3)
        
        clickSubtractActivityButtonFor(cell: SECOND_CELL)
        
        assertActivityCountFor(cell: 0, is: 0)
        assertActivityCountFor(cell: 1, is: 2)
        
        clickSubtractActivityButtonFor(cell: SECOND_CELL)
    
        assertActivityCountFor(cell: 0, is: 0)
        assertActivityCountFor(cell: 1, is: 1)
        
        clickSubtractActivityButtonFor(cell: SECOND_CELL)
        
        assertActivityCountFor(cell: 0, is: 0)
        assertActivityCountFor(cell: 1, is: 0)
        
        clickSubtractActivityButtonFor(cell: SECOND_CELL)
        
        assertActivityCountFor(cell: 0, is: 0)
        assertActivityCountFor(cell: 1, is: 0)
    }
}
