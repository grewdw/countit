//
//  DeleteItems.swift
//  countitUITests
//
//  Created by David Grew on 27/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import XCTest

class DeleteItems: XCTestCase {
    
    let ITEM_NAME_ONE = "TestItemNameOne"
    let ITEM_NAME_TWO = "TestItemNameTwo"
    
    let ITEM_DESCRIPTION_ONE = "TestItemDescriptionOne"
    let ITEM_DESCRIPTION_TWO = "TestItemDescriptionTwo"
    
    let ERROR_MESSAGE = "* Must provide a name"
    
    override func setUp() {
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launchArguments = ["test"]
        app.launch()
        
        app.navigationBars["COUNT IT"].buttons["Add"].tap()
        let nameField = app.otherElements["nameField"].textFields["fieldText"]
        let descriptionField = app.otherElements["descriptionField"].textFields["fieldText"]
        
        nameField.tap()
        nameField.typeText(ITEM_NAME_ONE)
        descriptionField.tap()
        descriptionField.typeText(ITEM_DESCRIPTION_ONE)
        app.navigationBars["ADD ITEM"].buttons["Save"].tap()
        
        app.navigationBars["COUNT IT"].buttons["Add"].tap()
        nameField.tap()
        nameField.typeText(ITEM_NAME_TWO)
        descriptionField.tap()
        descriptionField.typeText(ITEM_DESCRIPTION_TWO)
        app.navigationBars["ADD ITEM"].buttons["Save"].tap()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDeleteFirstItem() {
        
        let app = XCUIApplication()
        let itemTable = app.tables["ItemTable"]
        
        // delete item
        itemTable.cells["Cell0"].swipeLeft()
        itemTable.cells["Cell0"].buttons["Delete"].tap()
        
        // verify one item remains
        XCTAssertTrue(itemTable.cells.count == 1)
        itemTable.swipeDown()
        XCTAssertTrue(itemTable.cells.count == 1)
    }
    
    func testDeleteSecondItem() {
        
        let app = XCUIApplication()
        let itemTable = app.tables["ItemTable"]
        
        // delete item
        itemTable.cells["Cell1"].swipeLeft()
        itemTable.cells["Cell1"].buttons["Delete"].tap()
        
        // verify one item remains
        XCTAssertTrue(itemTable.cells.count == 1)
        itemTable.swipeDown()
        XCTAssertTrue(itemTable.cells.count == 1)
    }
    
    func testDeleteTwoItems() {
        
        let app = XCUIApplication()
        let itemTable = app.tables["ItemTable"]
        
        // delete first item
        itemTable.cells["Cell0"].swipeLeft()
        itemTable.cells["Cell0"].buttons["Delete"].tap()
        
        // delete second item
        itemTable.cells["Cell1"].swipeLeft()
        itemTable.cells["Cell1"].buttons["Delete"].tap()
        
        // verify no items remain
        XCTAssertTrue(itemTable.cells.count == 0)
        itemTable.swipeDown()
        XCTAssertTrue(itemTable.cells.count == 0)
    }
    
    func testCancelDelete() {
        
        let app = XCUIApplication()
        let itemTable = app.tables["ItemTable"]
        
        // initiate delete
        itemTable.cells["Cell0"].swipeLeft()
        
        // cancel delete
        itemTable.cells["Cell0"].swipeRight()
        
        // verify both items remain
        XCTAssertTrue(itemTable.cells.count == 2)
        itemTable.swipeDown()
        XCTAssertTrue(itemTable.cells.count == 2)
    }
}
