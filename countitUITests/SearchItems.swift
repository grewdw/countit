//
//  SearchItems.swift
//  countitUITests
//
//  Created by David Grew on 27/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import XCTest

class SearchItems: XCTestCase {
    
    let ITEM_NAME_A = "a"
    let ITEM_NAME_AB = "ab"
    let ITEM_NAME_ABC = "abc"
    
    override func setUp() {
        
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launchArguments = ["test"]
        app.launch()
        
        app.navigationBars["COUNT IT"].buttons["Add"].tap()
        let nameField = app.otherElements["nameField"].textFields["fieldText"]
        
        nameField.tap()
        nameField.typeText(ITEM_NAME_A)
        app.navigationBars["ADD ITEM"].buttons["Save"].tap()
        
        app.navigationBars["COUNT IT"].buttons["Add"].tap()
        nameField.tap()
        nameField.typeText(ITEM_NAME_AB)
        app.navigationBars["ADD ITEM"].buttons["Save"].tap()
        
        app.navigationBars["COUNT IT"].buttons["Add"].tap()
        nameField.tap()
        nameField.typeText(ITEM_NAME_ABC)
        app.navigationBars["ADD ITEM"].buttons["Save"].tap()
    }
    
    override func tearDown() {
    }

    func testDynamicSearchForItems() {
        
        let app = XCUIApplication()
        let itemTable = app.tables["ItemTable"]
        let searchField = app.searchFields["Search items"]
        
        itemTable.swipeDown()
        searchField.tap()
        searchField.typeText("a")
        
        XCTAssertTrue(itemTable.cells.count == 3)
        assertTable(cell: 0, is: ITEM_NAME_A)
        assertTable(cell: 1, is: ITEM_NAME_AB)
        assertTable(cell: 2, is: ITEM_NAME_ABC)
        
        searchField.typeText("b")
        
        XCTAssertTrue(itemTable.cells.count == 2)
        assertTable(cell: 0, is: ITEM_NAME_AB)
        assertTable(cell: 1, is: ITEM_NAME_ABC)
        
        searchField.typeText("c")
        
        XCTAssertTrue(itemTable.cells.count == 1)
        assertTable(cell: 0, is: ITEM_NAME_ABC)
        
        searchField.typeText(XCUIKeyboardKey.delete.rawValue)
        
        XCTAssertTrue(itemTable.cells.count == 2)
        assertTable(cell: 0, is: ITEM_NAME_AB)
        assertTable(cell: 1, is: ITEM_NAME_ABC)
        
        searchField.typeText(XCUIKeyboardKey.delete.rawValue)
        
        XCTAssertTrue(itemTable.cells.count == 3)
        assertTable(cell: 0, is: ITEM_NAME_A)
        assertTable(cell: 1, is: ITEM_NAME_AB)
        assertTable(cell: 2, is: ITEM_NAME_ABC)
    }
}
