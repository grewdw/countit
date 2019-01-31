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
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, target: ITEM_TARGET_VALUE_TEN)
        
        assertTableCountIs(1)
        assertTable(cell: 0, is: ITEM_NAME_ONE)
        
        select(FIRST_CELL)
        
        assertItemForm(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, target: ITEM_TARGET_VALUE_TEN)
    }
    
    func testCreateSingleItemTargetValueDefaultsToZero() {
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, target: nil)
        
        assertTableCountIs(1)
        
        select(FIRST_CELL)
        
        assertItemForm(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, target: ITEM_TARGET_VALUE_ZERO)
    }
    
    func testCreateMultipleItems() {
        createItemWithDetailsAndSave(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, target: nil)
        
        createItemWithDetailsAndSave(name: ITEM_NAME_TWO, description: ITEM_DESCRIPTION_TWO, target: nil)
        
        assertTableCountIs(2)
        assertTable(cell: 0, is: ITEM_NAME_ONE)
        assertTable(cell: 1, is: ITEM_NAME_TWO)
    }
    
    func testCannotSaveWithoutItemName() {
        openItemForm()
        assertItemFormSaveButton(isEnabled: false)
        
        enterNewItemDetailsToFormAndSave(name: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, target: nil)
        
        assertTableCountIs(1)
    }

}
