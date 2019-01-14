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
            nameField!.clearText()
        }
        if description {
            nameField!.clearText()
        }
        if target {
            nameField!.clearText()
        }
    }
    
    // helper method for enterNewDetails & updateItemForm above
    func updateForm(name: String?, description: String?, target: String?, existingItem: Bool) {
        let existingItemName = existingItem ? nameField?.value as? String : nil
        if let nameUnwrapped = name {
            nameField!.clearAndEnterText(newText: nameUnwrapped)
            nameField!.typeText(RETURN_KEY)
        }
        if let descriptionUnwrapped = description {
            descriptionField!.clearAndEnterText(newText: descriptionUnwrapped)
            descriptionField!.typeText(RETURN_KEY)
        }
        if let targetUnwrapped = target {
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
}
