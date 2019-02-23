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
    
    let AT_LEAST = "At least"
    let AT_MOST = "At most"
    let DAY = "Day"
    let WEEK = "Week"
    let MONTH = "Month"
    
    let ERROR_MESSAGE = "* Must provide a name"
    
    let FIRST_CELL = 0
    let SECOND_CELL = 1
    
    let RETURN_KEY = String(XCUIKeyboardKey.return.rawValue)
    let DELETE_KEY = String(XCUIKeyboardKey.delete.rawValue)

    var app: XCUIApplication?
    
    var itemTableAddButton: XCUIElement?
    var itemFormSaveButton: XCUIElement?
    var activityHistoryEditButton: XCUIElement?
    var activityHistoryDoneButton: XCUIElement?
    var backButton: XCUIElement?
    
    var nameField: XCUIElement?
    var nameFieldText: XCUIElement?
    
    var descriptionField: XCUIElement?
    var descriptionFieldText: XCUIElement?
    
    var targetDirectionField: XCUIElement?
    var targetDirectionFieldLabel: XCUIElement?
    
    var targetValueField: XCUIElement?
    var targetValueFieldText: XCUIElement?
    
    var targetTimePeriodField: XCUIElement?
    var targetTimePeriodFieldLabel: XCUIElement?
    
    var showActivityButton: XCUIElement?
    var itemFormDeleteButton: XCUIElement?
    var itemFormDeleteConfirmationAlert: XCUIElement?
    
    var emptyItemListCell: XCUIElement?
    
    var itemTable: XCUIElement?
    var itemForm: XCUIElement?
    var formSelectorTable: XCUIElement?
    var activityHistoryTable: XCUIElement?
    
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
        itemFormSaveButton = newApp.navigationBars[AI.NAVIGATION_BAR_ITEM_FORM].buttons[AI.NAVIGATION_BAR_BUTTON_DONE]
        activityHistoryEditButton = newApp.navigationBars[AI.NAVIGATION_BAR_ACTIVITY_HISTORY].buttons[AI.NAVIGATION_BAR_BUTTON_EDIT]
        activityHistoryDoneButton = newApp.navigationBars[AI.NAVIGATION_BAR_ACTIVITY_HISTORY].buttons[AI.NAVIGATION_BAR_BUTTON_DONE]
        backButton = newApp.navigationBars.buttons.element(boundBy: 0)
        nameField = newApp.tables[AI.ITEM_FORM_TABLE].cells[AI.ITEM_FORM_NAME_FIELD]
        nameFieldText = newApp.tables[AI.ITEM_FORM_TABLE].cells[AI.ITEM_FORM_NAME_FIELD].textFields[AI.TEXT_FIELD_TEXT]
        descriptionField = newApp.tables[AI.ITEM_FORM_TABLE].cells[AI.ITEM_FORM_DESCRIPTION_FIELD]
        descriptionFieldText = newApp.tables[AI.ITEM_FORM_TABLE].cells[AI.ITEM_FORM_DESCRIPTION_FIELD].textFields[AI.TEXT_FIELD_TEXT]
        targetDirectionField = newApp.tables[AI.ITEM_FORM_TABLE].cells[AI.ITEM_FORM_TARGET_DIRECTION_FIELD]
        targetDirectionFieldLabel = newApp.tables[AI.ITEM_FORM_TABLE].cells[AI.ITEM_FORM_TARGET_DIRECTION_FIELD].staticTexts[AI.OPTION_FIELD_TEXT]
        targetValueField = newApp.tables[AI.ITEM_FORM_TABLE].cells[AI.ITEM_FORM_TARGET_VALUE_FIELD]
        targetValueFieldText = newApp.tables[AI.ITEM_FORM_TABLE].cells[AI.ITEM_FORM_TARGET_VALUE_FIELD].textFields[AI.TEXT_FIELD_TEXT]
        targetTimePeriodField = newApp.tables[AI.ITEM_FORM_TABLE].cells[AI.ITEM_FORM_TARGET_TIMEPERIOD_FIELD]
        targetTimePeriodFieldLabel = newApp.tables[AI.ITEM_FORM_TABLE].cells[AI.ITEM_FORM_TARGET_TIMEPERIOD_FIELD].staticTexts[AI.OPTION_FIELD_TEXT]
        showActivityButton = newApp.tables[AI.ITEM_FORM_TABLE].cells[AI.ITEM_FORM_SHOW_ACTIVITY_BUTTON].buttons[AI.BUTTON_FIELD_BUTTON]
        itemFormDeleteButton = newApp.tables[AI.ITEM_FORM_TABLE].cells[AI.ITEM_FORM_DELETE_BUTTON].buttons[AI.BUTTON_FIELD_BUTTON]
        itemFormDeleteConfirmationAlert = newApp.alerts["Delete"]
        emptyItemListCell = newApp.tables[AI.ITEM_TABLE].cells[AI.EMPTY_ITEM_LIST_CELL]
        itemTable = newApp.tables[AI.ITEM_TABLE]
        itemForm = newApp.tables[AI.ITEM_FORM_TABLE]
        formSelectorTable = newApp.tables[AI.FORM_SELECTOR_TABLE]
        activityHistoryTable = newApp.tables[AI.ACTIVITY_HISTORY_TABLE]
        searchField = newApp.searchFields["Search items"]
    }
    
    func deinitialiseXCUIElements() {
        app = nil
        itemTableAddButton = nil
        itemFormSaveButton = nil
        nameField = nil
        descriptionField = nil
        targetDirectionField = nil
        targetValueField = nil
        targetTimePeriodField = nil
        itemTable = nil
        searchField = nil
    }
}
