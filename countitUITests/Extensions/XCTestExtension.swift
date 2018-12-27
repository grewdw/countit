//
//  File.swift
//  countitUITests
//
//  Created by David Grew on 27/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func assertTable(cell cellNumber: Int, is itemName: String) {
        let app = XCUIApplication()
        let itemTable = app.tables["ItemTable"]
        XCTAssertEqual(itemTable.cells.element(boundBy: cellNumber).staticTexts["itemName"].label, itemName, "item name not correct in cell")
    }
}
