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
    
    func createItemWithDetailsAndSave(name: String?, description: String?, target: String?) {
        openItemForm()
        enterNewItemDetailsToFormAndSave(name: name, description: description, target: target)
    }
    
    func openItemForm() {
        itemTableAddButton!.tap()
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
}
