//
//  UITestBaseRecordActivityFormSteps.swift
//  countitUITests
//
//  Created by David Grew on 17/03/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import XCTest

extension UITestBase {
    
    func updateRecordActivityFormWith(value: String?, note: String?) {
        if let valueUnwrapped = value {
            recordActivityValue?.clearAndEnterText(newText: valueUnwrapped)
        }
        if let noteUnwrapped = note {
            recordActivityNote?.clearAndEnterText(newText: noteUnwrapped)
        }
    }
    
    func clickSaveButtonOnRecordActivityForm() {
        recordActivitySaveButton?.tap()
    }
}
