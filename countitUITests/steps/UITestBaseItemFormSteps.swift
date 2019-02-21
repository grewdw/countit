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
    
    func enterNewItemDetailsToFormAndSave(name: String?, description: String?, targetDirection: String?, targetValue: String?, targetTimePeriod: String?) {
        updateForm(name: name, description: description, targetDirection: targetDirection, targetValue: targetValue, targetTimePeriod: targetTimePeriod)
    }
    
    func updateItemFormWithDetailsAndSave(name: String?, description: String?, targetDirection: String?, targetValue: String?, targetTimePeriod: String?) {
        updateForm(name: name, description: description, targetDirection: targetDirection, targetValue: targetValue, targetTimePeriod: targetTimePeriod)
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
    private func updateForm(name: String?, description: String?, targetDirection: String?, targetValue: String?, targetTimePeriod: String?) {
        if let nameUnwrapped = name {
            nameFieldText!.clearAndEnterText(newText: nameUnwrapped)
            nameFieldText!.typeText(RETURN_KEY)
        }
        if let descriptionUnwrapped = description {
            descriptionFieldText!.clearAndEnterText(newText: descriptionUnwrapped)
            descriptionFieldText!.typeText(RETURN_KEY)
        }
        if let targetDirectionUnwrapped = targetDirection {
            updateTargetDirection(to: targetDirectionUnwrapped)
        }
        if let targetValueUnwrapped = targetValue {
            targetValueFieldText!.clearAndEnterText(newText: targetValueUnwrapped)
            targetValueFieldText!.typeText(RETURN_KEY)
        }
        if let targetTimePeriodUnwrapped = targetTimePeriod {
            updateTargetTimePeriod(to: targetTimePeriodUnwrapped)
        }
        saveNewItemForm()
    }
    
    func updateTargetDirection(to direction: String) {
        clickOnTargetDirectionField()
        formSelectorTable?.cells[direction].tap()
        backButton?.tap()
    }
    
    func clickOnTargetDirectionField() {
        targetDirectionField?.tap()
    }
    
    func updateTargetTimePeriod(to timePeriod: String) {
        clickOnTargetTimePeriodField()
        formSelectorTable?.cells[timePeriod].tap()
        backButton?.tap()
    }
    
    func clickOnTargetTimePeriodField() {
        targetTimePeriodField?.tap()
    }
    
    func clickOnShowActivityButton() {
        showActivityButton?.tap()
    }
    
    func clickOnItemFormDeleteButton() {
        itemFormDeleteButton?.tap()
    }
    
    func confirmDeleteOfItem() {
        itemFormDeleteConfirmationAlert?.buttons["Delete"].tap()
    }
    
    func cancelDeleteOfItem() {
        itemFormDeleteConfirmationAlert?.buttons["Cancel"].tap()
    }
}
