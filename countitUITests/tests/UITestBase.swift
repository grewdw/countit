//
//  UITestBase.swift
//  countitUITests
//
//  Created by David Grew on 10/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import XCTest
@testable import countit

class UITestBase: XCTestCase {

    typealias AI = AccessibilityIdentifiers
    
    let ITEM_NAME_A = "a"
    let ITEM_NAME_AB = "ab"
    let ITEM_NAME_ABC = "abc"
    
    let ITEM_NAME_ONE = "TestItemNameOne"
    let ITEM_NAME_ONE_UPPERCASE = "TESTITEMNAMEONE"
    let ITEM_NAME_ONE_NEW = "TestItemNameOneNew"
    let ITEM_NAME_TWO = "TestItemNameTwo"
    
    let ITEM_DESCRIPTION_ONE = "TestItemDescriptionOne"
    let ITEM_DESCRIPTION_ONE_NEW = "TestItemDescriptionOneNew"
    let ITEM_DESCRIPTION_TWO = "TestItemDescriptionTwo"
    
    let ITEM_TARGET_VALUE_ZERO = "0"
    let ITEM_TARGET_VALUE_TEN = "10"
    let ITEM_TARGET_VALUE_TWENTY = "20"
    
    let ERROR_MESSAGE = "* Must provide a name"
    
    let FIRST_CELL = "Cell0"
    let SECOND_CELL = "Cell1"
    
    let RETURN_KEY = String(XCUIKeyboardKey.return.rawValue)
    let DELETE_KEY = String(XCUIKeyboardKey.delete.rawValue)

    var app: XCUIApplication?
    
    var itemTableAddButton: XCUIElement?
    var itemFormSaveButton: XCUIElement?
    
    var nameField: XCUIElement?
    var nameFieldError: XCUIElement?
    var descriptionField: XCUIElement?
    var targetField: XCUIElement?
    
    var itemTable: XCUIElement?
    
    var searchField: XCUIElement?
    
    override func setUp() {
        continueAfterFailure = false
        
        let newApp = XCUIApplication()
        newApp.launchArguments = ["test"]
        newApp.launch()
        initialiseXCUIElementsFor(newApp: newApp)
    }
    
    override func tearDown() {
        deinitialiseXCUIElements()
    }
    
    func initialiseXCUIElementsFor(newApp: XCUIApplication) {
        app = newApp
        itemTableAddButton = newApp.navigationBars[AI.NAVIGATION_BAR_ITEM_TABLE].buttons[AI.NAVIGATION_BAR_BUTTON_ADD]
        itemFormSaveButton = newApp.navigationBars[AI.NAVIGATION_BAR_ADD_ITEM].buttons[AI.NAVIGATION_BAR_BUTTON_SAVE]
        nameField = newApp.otherElements[AI.ITEM_FORM_NAME_FIELD].textFields[AI.TEXT_FIELD_TEXT]
        nameFieldError = newApp.otherElements[AI.ITEM_FORM_NAME_FIELD].staticTexts[AI.TEXT_FIELD_ERROR]
        descriptionField = newApp.otherElements[AI.ITEM_FORM_DESCRIPTION_FIELD].textFields[AI.TEXT_FIELD_TEXT]
        targetField = newApp.textFields[AI.TARGET_FORM_VALUE_FIELD]
        itemTable = newApp.tables[AI.ITEM_TABLE]
        searchField = newApp.searchFields["Search items"]
    }
    
    func deinitialiseXCUIElements() {
        app = nil
        itemTableAddButton = nil
        itemFormSaveButton = nil
        nameField = nil
        nameFieldError = nil
        descriptionField = nil
        targetField = nil
        itemTable = nil
        searchField = nil
    }
}
