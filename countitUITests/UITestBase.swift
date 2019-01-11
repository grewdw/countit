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
    
    override func tearDown() {
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
    
    func createItemWithDetailsAndSave(name: String?, description: String?, target: String?) {
        openItemForm()
        enterNewItemDetailsToFormAndSave(name: name, description: description, target: target)
    }
    
    func openItemForm() {
        itemTableAddButton!.tap()
    }
    
    func saveNewItemForm() {
        itemFormSaveButton!.tap()
    }
    
    func enterNewItemDetailsToFormAndSave(name: String?, description: String?, target: String?) {
        updateForm(name: name, description: description, target: target, existingItem: false)
    }
    
    func updateItemFormWithDetailsAndSave(name: String?, description: String?, target: String?) {
        updateForm(name: name, description: description, target: target, existingItem: true)
    }
    
    func updateForm(name: String?, description: String?, target: String?, existingItem: Bool) {
        let existingItemName = existingItem ? nameField?.value as? String : nil
        if let nameUnwrapped = name {
            nameField!.tap()
            nameField!.clearAndEnterText(newText: nameUnwrapped)
            nameField!.typeText(RETURN_KEY)
        }
        if let descriptionUnwrapped = description {
            descriptionField!.tap()
            descriptionField!.clearAndEnterText(newText: descriptionUnwrapped)
            descriptionField!.typeText(RETURN_KEY)
        }
        if let targetUnwrapped = target {
            targetField!.tap()
            targetField!.clearAndEnterText(newText: targetUnwrapped)
            targetField!.typeText(RETURN_KEY)
        }
        if existingItem {
            app!.navigationBars[existingItemName!.uppercased()].buttons[AI.NAVIGATION_BAR_BUTTON_SAVE].tap()
        }
        else {
            saveNewItemForm()
        }
    }
    
    func clearFormFields(name: Bool, description: Bool, target: Bool) {
        if name {
            nameField!.tap()
            nameField!.clearText()
        }
        if description {
            descriptionField!.tap()
            nameField!.clearText()
        }
        if target {
            targetField!.tap()
            nameField!.clearText()
        }
    }
    
    func select(_ cell: String) {
        itemTable!.cells[cell].buttons["More Info"].tap()
    }
    
    func moveItem(cell fromCell: String, toCell: String) {
        itemTable!.cells[fromCell].press(forDuration: 2, thenDragTo: itemTable!.cells[toCell])
    }
    
    func searchItemTableFor(string: String) {
        itemTable!.swipeDown()
        searchField!.tap()
        searchField!.typeText(string)
    }
    
    func addToItemTableSearchWith(string: String) {
        searchField!.typeText(string)
    }
    
    func deleteItemIn(cell: String) {
        initiateDeleteFor(cell: cell)
        itemTable!.cells[cell].buttons["Delete"].tap()
    }
    
    func initiateDeleteFor(cell: String) {
        itemTable!.cells[cell].swipeLeft()
    }
    
    func cancelDeletefor(cell: String) {
        itemTable!.cells[cell].swipeRight()
    }
    
    func clickAddActivityButtonFor(cell: String) {
        itemTable!.cells[cell].buttons[AI.PROGRESS_CELL_RECORD_ACTIVITY].tap()
    }
    
    func assertTable(cell cellNumber: Int, is itemName: String) {
        XCTAssertEqual(itemTable!.cells.element(boundBy: cellNumber).staticTexts[AI.PROGRESS_CELL_NAME].label, itemName, "item name not correct in cell")
    }
    
    func assertItemForm(name: String?, description: String?, target: String?) {
        if let nameUnwrapped = name {
            XCTAssertEqual(nameField!.value as? String, nameUnwrapped, "item name not correct on form")
        }
        if let descriptionUnwrapped = description {
            XCTAssertEqual(descriptionField!.value as? String, descriptionUnwrapped, "item description not correct on form")
        }
        if let targetUnwrapped = target {
            XCTAssertEqual(targetField!.value as? String, targetUnwrapped, "target value not correct in cell")
        }
    }
    
    func assertItemFormErrorIs(_ error: String) {
        XCTAssertEqual(nameFieldError!.label, error)
    }
    
    func assertTableCountIs(_ count: Int) {
        XCTAssertTrue(itemTable!.cells.count == count)
    }
    
    func assertActivityCountFor(cell: Int, is activityCount: String) {
        XCTAssertEqual(itemTable!.cells.element(boundBy: cell).staticTexts[AI.PROGRESS_CELL_ACTIVITY_COUNT].label, activityCount, "activityCount not correct")
    }
}
