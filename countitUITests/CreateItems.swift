//
//  countitUITests.swift
//  countitUITests
//
//  Created by David Grew on 03/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import XCTest

class CreateItems: XCTestCase {

    let ITEM_NAME_ONE = "TestItemNameOne"
    let ITEM_NAME_TWO = "TestItemNameTwo"
    
    let ITEM_DESCRIPTION_ONE = "TestItemDescriptionOne"
    let ITEM_DESCRIPTION_TWO = "TestItemDescriptionTwo"
    
    let ERROR_MESSAGE = "* Must provide a name"
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let application = XCUIApplication()
        application.launchArguments = ["test"]
        application.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreateSingleItem() {
        let app = XCUIApplication()
        app.navigationBars["COUNT IT"].buttons["Add"].tap()
        let nameField = app.otherElements["nameField"].textFields["fieldText"]
        let descriptionField = app.otherElements["descriptionField"].textFields["fieldText"]
        
        nameField.tap()
        nameField.typeText(ITEM_NAME_ONE)
        descriptionField.tap()
        descriptionField.typeText(ITEM_DESCRIPTION_ONE)
        
        app.navigationBars["ADD ITEM"].buttons["Save"].tap()
        
        let itemTable = app.tables["ItemTable"]
        
        XCTAssertTrue(itemTable.cells["Cell0"].exists, "item not found in item table")
        
        itemTable.cells["Cell0"].buttons["More Info"].tap()
        
        XCTAssertTrue(itemTable.cells.count == 1)
        XCTAssertEqual(nameField.value as? String, ITEM_NAME_ONE, "item name not correct in cell")
        XCTAssertEqual(descriptionField.value as? String, ITEM_DESCRIPTION_ONE, "item description not correct in cell")
    }
    
    func testCreateMultipleItems() {
        let app = XCUIApplication()
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
        
        let itemTable = app.tables["ItemTable"]
        
        XCTAssertTrue(itemTable.cells.count == 2)
        XCTAssertEqual(itemTable.cells["Cell0"].staticTexts["itemName"].label, ITEM_NAME_ONE)
        XCTAssertEqual(itemTable.cells["Cell1"].staticTexts["itemName"].label, ITEM_NAME_TWO)
    }
    
    func testCreateItemWithoutNameFails() {
        let app = XCUIApplication()
        app.navigationBars["COUNT IT"].buttons["Add"].tap()
        let nameField = app.otherElements["nameField"].textFields["fieldText"]
        let descriptionField = app.otherElements["descriptionField"].textFields["fieldText"]
        
        app.navigationBars["ADD ITEM"].buttons["Save"].tap()
        
        let nameFieldError = app.otherElements["nameField"].staticTexts["fieldError"]
        XCTAssertEqual(nameFieldError.label, ERROR_MESSAGE)
        
        nameField.tap()
        nameField.typeText(ITEM_NAME_ONE)
        descriptionField.tap()
        descriptionField.typeText(ITEM_DESCRIPTION_ONE)
        
        app.navigationBars["ADD ITEM"].buttons["Save"].tap()
        
        let itemTable = app.tables["ItemTable"]
        
        XCTAssertTrue(itemTable.cells.count == 1)
    }

}
