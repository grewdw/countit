//
//  SearchItems.swift
//  countitUITests
//
//  Created by David Grew on 27/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import XCTest

class UserInstructions: UITestBase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testAddTargetInstructionDisplayed() {
        assertProgressTableCountIs(1)
        assertEmptyTableCellIs(displayed: true)
        createItemWithDetailsAndSave(name: ITEM_NAME_A, description: nil, targetDirection: nil, targetValue: ITEM_TARGET_VALUE_TEN, targetTimePeriod: nil)
        assertProgressTableCountIs(1)
        assertEmptyTableCellIs(displayed: false)
    }
}
