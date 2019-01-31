//
//  SearchItems.swift
//  countitUITests
//
//  Created by David Grew on 27/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import XCTest

class SearchItems: UITestBase {
    
    override func setUp() {
        super.setUp()
        
        createItemWithDetailsAndSave(name: ITEM_NAME_A, description: nil, targetDirection: nil, targetValue: nil, targetTimePeriod: nil)
        createItemWithDetailsAndSave(name: ITEM_NAME_AB, description: nil, targetDirection: nil, targetValue: nil, targetTimePeriod: nil)
        createItemWithDetailsAndSave(name: ITEM_NAME_ABC, description: nil, targetDirection: nil, targetValue: nil, targetTimePeriod: nil)
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testDynamicSearchForItems() {
        searchItemTableFor(string: "a")
        
        assertTableCountIs(3)
        assertTable(cell: 0, is: ITEM_NAME_A)
        assertTable(cell: 1, is: ITEM_NAME_AB)
        assertTable(cell: 2, is: ITEM_NAME_ABC)
        
        addToItemTableSearchWith(string: "b")
        
        assertTableCountIs(2)
        assertTable(cell: 0, is: ITEM_NAME_AB)
        assertTable(cell: 1, is: ITEM_NAME_ABC)
        
        addToItemTableSearchWith(string: "c")
        
        assertTableCountIs(1)
        assertTable(cell: 0, is: ITEM_NAME_ABC)
        
        addToItemTableSearchWith(string: DELETE_KEY)
        
        assertTableCountIs(2)
        assertTable(cell: 0, is: ITEM_NAME_AB)
        assertTable(cell: 1, is: ITEM_NAME_ABC)
        
        addToItemTableSearchWith(string: DELETE_KEY)
        
        assertTableCountIs(3)
        assertTable(cell: 0, is: ITEM_NAME_A)
        assertTable(cell: 1, is: ITEM_NAME_AB)
        assertTable(cell: 2, is: ITEM_NAME_ABC)
    }
}
