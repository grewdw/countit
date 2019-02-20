//
//  UITestBaseItemTableSteps.swift
//  countitUITests
//
//  Created by David Grew on 14/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import XCTest

extension UITestBase {
    
    func createItemWithDetailsAndSave(name: String?, description: String?, targetDirection: String?, targetValue: String?, targetTimePeriod: String?) {
        openItemForm()
        enterNewItemDetailsToFormAndSave(name: name, description: description, targetDirection: targetDirection, targetValue: targetValue, targetTimePeriod: targetTimePeriod)
    }
    
    func openItemForm() {
        itemTableAddButton!.tap()
    }
    
    func select(_ cell: Int) {
        itemTable!.cells.element(boundBy: cell).buttons[AI.ITEM_CELL_MOREINFO_BUTTON].tap()
    }
    
    func moveItem(cell fromCell: Int, toCell: Int) {
        itemTable!.cells.element(boundBy: fromCell).press(forDuration: 2, thenDragTo: itemTable!.cells.element(boundBy: toCell))
    }
    
    func searchItemTableFor(string: String) {
        itemTable!.swipeDown()
        searchField!.tap()
        searchField!.typeText(string)
    }
    
    func addToItemTableSearchWith(string: String) {
        searchField!.typeText(string)
    }
    
    func deleteItemIn(cell: Int) {
        initiateDeleteFor(cell: cell)
        itemTable!.cells.element(boundBy: cell).buttons["Delete"].tap()
    }
    
    func initiateDeleteFor(cell: Int) {
        itemTable!.cells.element(boundBy: cell).swipeLeft()
    }
    
    func cancelDeletefor(cell: Int) {
        itemTable!.cells.element(boundBy: cell).swipeRight()
    }
    
    func clickPlusOneButtonFor(cell: Int) {
        itemTable!.cells.element(boundBy: cell).buttons[AI.ITEM_CELL_PLUSONE_BUTTON].tap()
    }
    
    func clickActivityHistoryButtonFor(cell: Int) {
        itemTable!.cells.element(boundBy: cell).buttons[AI.ITEM_CELL_ACTIVITY_HISTORY_BUTTON].tap()
    }
}
