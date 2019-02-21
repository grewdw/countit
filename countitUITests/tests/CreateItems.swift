//
//  countitUITests.swift
//  countitUITests
//
//  Created by David Grew on 03/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import XCTest

class CreateItems: UITestBase {
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testCreateSingleItem() {
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, targetDirection: AT_MOST, targetValue: ITEM_TARGET_VALUE_TEN, targetTimePeriod: MONTH)
        
        assertProgressTableCountIs(1)
        assertProgressTable(cell: 0, is: ITEM_NAME_ONE, withTarget: "At most 10 a month")
        
        select(FIRST_CELL)
        
        assertItemForm(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, targetDirection: AT_MOST, targetValue: ITEM_TARGET_VALUE_TEN, targetTimePeriod: MONTH)
    }

    func testCreateMultipleItems() {
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, targetDirection: AT_MOST, targetValue: ITEM_TARGET_VALUE_TEN, targetTimePeriod: WEEK)
        
        createItemWithDetailsAndSave(name: ITEM_NAME_TWO, description: ITEM_DESCRIPTION_TWO, targetDirection: AT_LEAST, targetValue: ITEM_TARGET_VALUE_TWENTY, targetTimePeriod: MONTH)
        
        assertProgressTableCountIs(2)
        assertProgressTable(cell: 0, is: ITEM_NAME_ONE, withTarget: "At most 10 a week")
        assertProgressTable(cell: 1, is: ITEM_NAME_TWO, withTarget:  "At least 20 a month")
    }
    
    func testCannotSaveWithoutItemName() {
        openItemForm()
        enterNewItemDetailsToFormAndSave(name: nil, description: ITEM_DESCRIPTION_ONE, targetDirection: nil, targetValue: ITEM_TARGET_VALUE_TEN, targetTimePeriod: nil)
        assertItemFormSaveButton(isEnabled: false)
        
        enterNewItemDetailsToFormAndSave(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, targetDirection: nil, targetValue: nil, targetTimePeriod: nil)
        
        assertProgressTableCountIs(1)
    }
    
    func testCannotSaveWithoutTargetValue() {
        openItemForm()
        enterNewItemDetailsToFormAndSave(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, targetDirection: nil, targetValue: nil, targetTimePeriod: nil)
        assertItemFormSaveButton(isEnabled: false)
        
        enterNewItemDetailsToFormAndSave(name: nil, description: nil, targetDirection: nil, targetValue: ITEM_TARGET_VALUE_TEN, targetTimePeriod: nil)
        
        assertProgressTableCountIs(1)
    }
    
    func testCannotSaveWithTargetValueOfZero() {
        openItemForm()
        enterNewItemDetailsToFormAndSave(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, targetDirection: nil, targetValue: ITEM_TARGET_VALUE_ZERO, targetTimePeriod: nil)
        assertItemFormSaveButton(isEnabled: false)
        
        enterNewItemDetailsToFormAndSave(name: nil, description: ITEM_DESCRIPTION_ONE, targetDirection: nil, targetValue: ITEM_TARGET_VALUE_TEN, targetTimePeriod: nil)
        
        assertProgressTableCountIs(1)
    }

}
