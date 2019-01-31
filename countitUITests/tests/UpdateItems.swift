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
        
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, target: ITEM_TARGET_VALUE_TEN)
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testUpdateItemName() {
        select(FIRST_CELL)
        updateItemFormWithDetailsAndSave(name: ITEM_NAME_ONE_NEW, description: nil, target: nil)
        
        assertTable(cell: 0, is: ITEM_NAME_ONE_NEW)
        
        select(FIRST_CELL)
        assertItemForm(name: ITEM_NAME_ONE_NEW, description: ITEM_DESCRIPTION_ONE, target: ITEM_TARGET_VALUE_TEN)
    }
    
    func testUpdateItemDescription() {
        select(FIRST_CELL)
        updateItemFormWithDetailsAndSave(name: nil, description: ITEM_DESCRIPTION_ONE_NEW, target: nil)
        
        assertTable(cell: 0, is: ITEM_NAME_ONE)
        
        select(FIRST_CELL)
        assertItemForm(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE_NEW, target: ITEM_TARGET_VALUE_TEN)    }
    
    func testUpdateItemTargetValue() {
        select(FIRST_CELL)
        updateItemFormWithDetailsAndSave(name: nil, description: nil, target: ITEM_TARGET_VALUE_TWENTY)
        
        assertTable(cell: 0, is: ITEM_NAME_ONE)
        
        select(FIRST_CELL)
        assertItemForm(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, target: ITEM_TARGET_VALUE_TWENTY)
    }
    
    func testCannotSaveIfNameDeleted() {
        select(FIRST_CELL)
        clearFormFields(name: true, description: false, target: true)
        
        assertItemFormSaveButton(isEnabled: false)
    }
    
    func testChangeItemOrder() {
        createItemWithDetailsAndSave(name: ITEM_NAME_TWO, description: ITEM_DESCRIPTION_TWO, target: nil)
        
        moveItem(cell: FIRST_CELL, toCell: SECOND_CELL)
        
        assertTable(cell: 0, is: ITEM_NAME_TWO)
        assertTable(cell: 1, is: ITEM_NAME_ONE)    }
}
