//
//  UpdateItems.swift
//  countitUITests
//
//  Created by David Grew on 27/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import XCTest

class UpdateItems: XCTestCase {
    
    let ITEM_NAME_ONE = "TestItemNameOne"
    let ITEM_NAME_ONE_UPPERCASE = "TESTITEMNAMEONE"
    let ITEM_NAME_ONE_NEW = "TestItemNameOneNew"
    let ITEM_NAME_TWO = "TestItemNameTwo"
    
    let ITEM_DESCRIPTION_ONE = "TestItemDescriptionOne"
    let ITEM_DESCRIPTION_ONE_NEW = "TestItemDescriptionOneNew"
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
    }
    
    override func tearDown() {
    }

    func testUpdateItemName() {
        
        let app = XCUIApplication()
        let itemTable = app.tables["ItemTable"]
        
        itemTable.cells["Cell0"].buttons["More Info"].tap()
        
        let nameField = app.otherElements["nameField"].textFields["fieldText"]
        let descriptionField = app.otherElements["descriptionField"].textFields["fieldText"]
        
        nameField.tap()
        nameField.clearAndEnterText(newText: ITEM_NAME_ONE_NEW)
        
        // verify name has been updated in item table
        app.navigationBars[ITEM_NAME_ONE_UPPERCASE].buttons["Save"].tap()
        XCTAssertEqual(itemTable.cells.element(boundBy: 0).staticTexts["itemName"].label, ITEM_NAME_ONE_NEW, "item name not correct in cell")
        
        // verify name has been updated on item form
        itemTable.cells["Cell0"].buttons["More Info"].tap()
        XCTAssertEqual(nameField.value as? String, ITEM_NAME_ONE_NEW, "item name not correct on form")
        XCTAssertEqual(descriptionField.value as? String, ITEM_DESCRIPTION_ONE, "item description not correct on form")
    }
    
    func testUpdateItemDescription() {
        
        let app = XCUIApplication()
        let itemTable = app.tables["ItemTable"]
        
        itemTable.cells["Cell0"].buttons["More Info"].tap()
        
        let nameField = app.otherElements["nameField"].textFields["fieldText"]
        let descriptionField = app.otherElements["descriptionField"].textFields["fieldText"]
        
        descriptionField.tap()
        descriptionField.clearAndEnterText(newText: ITEM_DESCRIPTION_ONE_NEW)
        
        // verify name has not changed in item table
        app.navigationBars[ITEM_NAME_ONE_UPPERCASE].buttons["Save"].tap()
        XCTAssertEqual(itemTable.cells.element(boundBy: 0).staticTexts["itemName"].label, ITEM_NAME_ONE, "item name not correct in cell")
        
        // verify description has been updated on item form
        itemTable.cells["Cell0"].buttons["More Info"].tap()
        XCTAssertEqual(nameField.value as? String, ITEM_NAME_ONE, "item name not correct on form")
        XCTAssertEqual(descriptionField.value as? String, ITEM_DESCRIPTION_ONE_NEW, "item description not correct on form")
    }
    
    func testCannotSaveIfNameDeleted() {
        
        let app = XCUIApplication()
        let itemTable = app.tables["ItemTable"]
        
        itemTable.cells["Cell0"].buttons["More Info"].tap()
        
        let nameField = app.otherElements["nameField"].textFields["fieldText"]
        
        nameField.tap()
        nameField.clearText()
        
        // verify nameField error message is shown
        let nameFieldError = app.otherElements["nameField"].staticTexts["fieldError"]
        XCTAssertEqual(nameFieldError.label, ERROR_MESSAGE)
    }
    
    func testChangeItemOrder() {
        
        let app = XCUIApplication()
        let nameField = app.otherElements["nameField"].textFields["fieldText"]
        let descriptionField = app.otherElements["descriptionField"].textFields["fieldText"]
        
        app.navigationBars["COUNT IT"].buttons["Add"].tap()
        nameField.tap()
        nameField.typeText(ITEM_NAME_TWO)
        descriptionField.tap()
        descriptionField.typeText(ITEM_DESCRIPTION_TWO)
        app.navigationBars["ADD ITEM"].buttons["Save"].tap()
        
        let itemTable = app.tables["ItemTable"]
        
        // move top cell to second
        itemTable.cells["Cell0"].press(forDuration: 2, thenDragTo: itemTable.cells["Cell1"])
        
        // verify cells have been reversed
        itemTable.cells.element(boundBy: 0)
        XCTAssertEqual(itemTable.cells.element(boundBy: 0).staticTexts["itemName"].label, ITEM_NAME_TWO, "item name not correct in cell")
        XCTAssertEqual(itemTable.cells.element(boundBy: 1).staticTexts["itemName"].label, ITEM_NAME_ONE, "item name not correct in cell")
    }
}
