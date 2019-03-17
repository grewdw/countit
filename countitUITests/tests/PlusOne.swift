//
//  RecordActivity.swift
//  countitUITests
//
//  Created by David Grew on 10/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import XCTest

class PlusOne: UITestBase {

    override func setUp() {
        super.setUp()
        
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: nil, targetDirection: nil, targetValue: ITEM_TARGET_VALUE_TEN, targetTimePeriod: nil)
        createItemWithDetailsAndSave(name: ITEM_NAME_TWO, description: nil, targetDirection: nil, targetValue: ITEM_TARGET_VALUE_TWENTY, targetTimePeriod: nil)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testPlusOneSingleForFirstItem() {
        clickPlusOneButtonFor(cell: FIRST_CELL)
        
        clickProgressButtonFor(cell: FIRST_CELL)
        clickProgressButtonFor(cell: SECOND_CELL)
        
        assertProgressFor(cell: 0, isPercentage: "10%", withCount: "1 of 10")
        assertProgressFor(cell: 1, isPercentage: "0%", withCount: "0 of 20")
    }
    
    func testPlusOneSingleForSecondItem() {
        clickPlusOneButtonFor(cell: SECOND_CELL)
        
        clickProgressButtonFor(cell: FIRST_CELL)
        clickProgressButtonFor(cell: SECOND_CELL)
        
        assertProgressFor(cell: 0, isPercentage: "0%", withCount: "0 of 10")
        assertProgressFor(cell: 1, isPercentage: "5%", withCount: "1 of 20")
    }
    
    func testPlusOneMultiForFirstItem() {
        clickPlusOneButtonFor(cell: FIRST_CELL)
        clickPlusOneButtonFor(cell: FIRST_CELL)
        clickPlusOneButtonFor(cell: FIRST_CELL)
        
        clickProgressButtonFor(cell: FIRST_CELL)
        clickProgressButtonFor(cell: SECOND_CELL)
        
        assertProgressFor(cell: 0, isPercentage: "30%", withCount: "3 of 10")
        assertProgressFor(cell: 1, isPercentage: "0%", withCount: "0 of 20")
    }

    func testPlusOneMultiForSecondItem() {
        clickPlusOneButtonFor(cell: SECOND_CELL)
        clickPlusOneButtonFor(cell: SECOND_CELL)
        clickPlusOneButtonFor(cell: SECOND_CELL)
        clickPlusOneButtonFor(cell: SECOND_CELL)
        
        clickProgressButtonFor(cell: FIRST_CELL)
        clickProgressButtonFor(cell: SECOND_CELL)
        
        assertProgressFor(cell: 0, isPercentage: "0%", withCount: "0 of 10")
        assertProgressFor(cell: 1, isPercentage: "20%", withCount: "4 of 20")
    }
    
    func testPlusOneMultiForBothItems() {
        clickPlusOneButtonFor(cell: FIRST_CELL)
        clickPlusOneButtonFor(cell: FIRST_CELL)
        clickPlusOneButtonFor(cell: FIRST_CELL)
        clickPlusOneButtonFor(cell: FIRST_CELL)
        clickPlusOneButtonFor(cell: FIRST_CELL)
        
        clickPlusOneButtonFor(cell: SECOND_CELL)
        clickPlusOneButtonFor(cell: SECOND_CELL)
        clickPlusOneButtonFor(cell: SECOND_CELL)
        clickPlusOneButtonFor(cell: SECOND_CELL)
        
        clickProgressButtonFor(cell: FIRST_CELL)
        clickProgressButtonFor(cell: SECOND_CELL)
        
        assertProgressFor(cell: 0, isPercentage: "50%", withCount: "5 of 10")
        assertProgressFor(cell: 1, isPercentage: "20%", withCount: "4 of 20")
    }
}
