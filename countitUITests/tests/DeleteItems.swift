//
//  DeleteItems.swift
//  countitUITests
//
//  Created by David Grew on 27/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import XCTest

class DeleteItems: UITestBase {
    
    override func setUp() {
        super.setUp()
        
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, targetDirection: nil, targetValue: nil, targetTimePeriod: nil)
        createItemWithDetailsAndSave(name: ITEM_NAME_TWO, description: ITEM_DESCRIPTION_TWO, targetDirection: nil, targetValue: nil, targetTimePeriod: nil)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDeleteFirstItem() {
        deleteItemIn(cell: FIRST_CELL)
        assertProgressTableCountIs(1)
    }
    
    func testDeleteSecondItem() {
        deleteItemIn(cell: SECOND_CELL)
        assertProgressTableCountIs(1)
    }
    
    func testDeleteTwoItems() {
        deleteItemIn(cell: SECOND_CELL)
        deleteItemIn(cell: FIRST_CELL)
        assertProgressTableCountIs(0)
    }
    
    func testCancelDelete() {
        initiateDeleteFor(cell: FIRST_CELL)
        cancelDeletefor(cell: FIRST_CELL)
        assertProgressTableCountIs(2)
    }
}
