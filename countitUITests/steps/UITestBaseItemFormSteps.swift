//
//  UITestBaseItemFormSteps.swift
//  countitUITests
//
//  Created by David Grew on 14/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import XCTest

extension UITestBase {
    
    func saveNewItemForm() {
        itemFormSaveButton!.tap()
    }
    
    func enterNewItemDetailsToFormAndSave(name: String?, description: String?, target: String?) {
        updateForm(name: name, description: description, target: target, existingItem: false)
    }
    
    func updateItemFormWithDetailsAndSave(name: String?, description: String?, target: String?) {
        updateForm(name: name, description: description, target: target, existingItem: true)
    }
    
    func clearFormFields(name: Bool, description: Bool, target: Bool) {
        if name {
            nameFieldText!.clearText()
        }
        if description {
            nameFieldText!.clearText()
        }
        if target {
            nameFieldText!.clearText()
        }
    }
    
    // helper method for enterNewDetails & updateItemForm above
    func updateForm(name: String?, description: String?, target: String?, existingItem: Bool) {
        if let nameUnwrapped = name {
            nameFieldText!.clearAndEnterText(newText: nameUnwrapped)
            nameFieldText!.typeText(RETURN_KEY)
        }
        if let descriptionUnwrapped = description {
            descriptionFieldText!.clearAndEnterText(newText: descriptionUnwrapped)
            descriptionFieldText!.typeText(RETURN_KEY)
        }
        if let targetUnwrapped = target {
            targetValueFieldText!.clearAndEnterText(newText: targetUnwrapped)
            targetValueFieldText!.typeText(RETURN_KEY)
        }
        saveNewItemForm()
    }
}
