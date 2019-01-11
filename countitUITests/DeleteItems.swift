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
        
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, target: nil)
        createItemWithDetailsAndSave(name: ITEM_NAME_TWO, description: ITEM_DESCRIPTION_TWO, target: nil)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDeleteFirstItem() {
        deleteItemIn(cell: FIRST_CELL)
        assertTableCountIs(1)
    }
    
    func testDeleteSecondItem() {
        deleteItemIn(cell: SECOND_CELL)
        assertTableCountIs(1)
    }
    
    func testDeleteTwoItems() {
        deleteItemIn(cell: FIRST_CELL)
        deleteItemIn(cell: SECOND_CELL)
        assertTableCountIs(0)
    }
    
    func testCancelDelete() {
        initiateDeleteFor(cell: FIRST_CELL)
        cancelDeletefor(cell: FIRST_CELL)
        assertTableCountIs(2)
    }
}
