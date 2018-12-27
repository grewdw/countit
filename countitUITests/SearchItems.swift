//
//  SearchItems.swift
//  countitUITests
//
//  Created by David Grew on 27/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import XCTest

class SearchItems: XCTestCase {
    
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
    }

}
