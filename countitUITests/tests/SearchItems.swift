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
        
        assertProgressTableCountIs(3)
        assertProgressTable(cell: 0, is: ITEM_NAME_A)
        assertProgressTable(cell: 1, is: ITEM_NAME_AB)
        assertProgressTable(cell: 2, is: ITEM_NAME_ABC)
        
        addToItemTableSearchWith(string: "b")
        
        assertProgressTableCountIs(2)
        assertProgressTable(cell: 0, is: ITEM_NAME_AB)
        assertProgressTable(cell: 1, is: ITEM_NAME_ABC)
        
        addToItemTableSearchWith(string: "c")
        
        assertProgressTableCountIs(1)
        assertProgressTable(cell: 0, is: ITEM_NAME_ABC)
        
        addToItemTableSearchWith(string: DELETE_KEY)
        
        assertProgressTableCountIs(2)
        assertProgressTable(cell: 0, is: ITEM_NAME_AB)
        assertProgressTable(cell: 1, is: ITEM_NAME_ABC)
        
        addToItemTableSearchWith(string: DELETE_KEY)
        
        assertProgressTableCountIs(3)
        assertProgressTable(cell: 0, is: ITEM_NAME_A)
        assertProgressTable(cell: 1, is: ITEM_NAME_AB)
        assertProgressTable(cell: 2, is: ITEM_NAME_ABC)
    }
}
