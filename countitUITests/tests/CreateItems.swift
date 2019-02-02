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
        assertProgressTable(cell: 0, is: ITEM_NAME_ONE)
        
        select(FIRST_CELL)
        
        assertItemForm(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, targetDirection: AT_MOST, targetValue: ITEM_TARGET_VALUE_TEN, targetTimePeriod: MONTH)
    }
    
    func testCreateSingleItemTargetValueDefaultsToZero() {
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, targetDirection: nil, targetValue: nil, targetTimePeriod: nil)
        
        assertProgressTableCountIs(1)
        
        select(FIRST_CELL)
        
        assertItemForm(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, targetDirection: nil, targetValue: ITEM_TARGET_VALUE_ZERO, targetTimePeriod: nil)
    }
    
    func testCreateMultipleItems() {
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, targetDirection: nil, targetValue: nil, targetTimePeriod: nil)
        
        createItemWithDetailsAndSave(name: ITEM_NAME_TWO, description: ITEM_DESCRIPTION_TWO, targetDirection: nil, targetValue: nil, targetTimePeriod: nil)
        
        assertProgressTableCountIs(2)
        assertProgressTable(cell: 0, is: ITEM_NAME_ONE)
        assertProgressTable(cell: 1, is: ITEM_NAME_TWO)
    }
    
    func testCannotSaveWithoutItemName() {
        openItemForm()
        assertItemFormSaveButton(isEnabled: false)
        
        enterNewItemDetailsToFormAndSave(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, targetDirection: nil, targetValue: nil, targetTimePeriod: nil)
        
        assertProgressTableCountIs(1)
    }

}
