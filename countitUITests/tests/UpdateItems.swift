//
//  UpdateItems.swift
//  countitUITests
//
//  Created by David Grew on 27/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import XCTest

class UpdateItems: UITestBase {
    
    override func setUp() {
        super.setUp()
        
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, targetDirection: nil, targetValue: ITEM_TARGET_VALUE_TEN, targetTimePeriod: nil)
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testUpdateItemName() {
        select(FIRST_CELL)
        updateItemFormWithDetailsAndSave(name: ITEM_NAME_ONE_NEW, description: nil, targetDirection: nil, targetValue: nil, targetTimePeriod: nil)
        
        assertProgressTable(cell: 0, is: ITEM_NAME_ONE_NEW)
        
        select(FIRST_CELL)
        assertItemForm(name: ITEM_NAME_ONE_NEW, description: ITEM_DESCRIPTION_ONE, targetDirection: nil, targetValue: ITEM_TARGET_VALUE_TEN, targetTimePeriod: nil)
    }
    
    func testUpdateItemDescription() {
        select(FIRST_CELL)
        updateItemFormWithDetailsAndSave(name: nil, description: ITEM_DESCRIPTION_ONE_NEW, targetDirection: nil, targetValue: nil, targetTimePeriod: nil)
        
        assertProgressTable(cell: 0, is: ITEM_NAME_ONE)
        
        select(FIRST_CELL)
        assertItemForm(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE_NEW, targetDirection: nil, targetValue: ITEM_TARGET_VALUE_TEN, targetTimePeriod: nil)
    }
    
    func testUpdateItemTargetValue() {
        select(FIRST_CELL)
        updateItemFormWithDetailsAndSave(name: nil, description: nil, targetDirection: nil, targetValue: ITEM_TARGET_VALUE_TWENTY, targetTimePeriod: nil)
        
        assertProgressTable(cell: 0, is: ITEM_NAME_ONE)
        
        select(FIRST_CELL)
        assertItemForm(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, targetDirection: nil, targetValue: ITEM_TARGET_VALUE_TWENTY, targetTimePeriod: nil)
    }
    
    func testCannotUpdateTargetDirection() {
        select(FIRST_CELL)
        clickOnTargetDirectionField()
        assertItemForm(isDisplayed: true)
    }
    
    func testCannotUpdateTargetTimePeriod() {
        select(FIRST_CELL)
        clickOnTargetTimePeriodField()
        assertItemForm(isDisplayed: true)
    }
    
    func testCannotSaveIfNameDeleted() {
        select(FIRST_CELL)
        clearFormFields(name: true, description: false, target: false)
        
        assertItemFormSaveButton(isEnabled: false)
    }
    
    func testChangeItemOrder() {
        createItemWithDetailsAndSave(name: ITEM_NAME_TWO, description: ITEM_DESCRIPTION_TWO, targetDirection: nil, targetValue: nil, targetTimePeriod: nil)
        
        moveItem(cell: FIRST_CELL, toCell: SECOND_CELL)
        
        assertProgressTable(cell: 0, is: ITEM_NAME_TWO)
        assertProgressTable(cell: 1, is: ITEM_NAME_ONE)
    }
}
