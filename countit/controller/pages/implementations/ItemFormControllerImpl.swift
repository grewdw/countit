//
//  ItemFormControllerImpl.swift
//  countit
//
//  Created by David Grew on 28/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class ItemFormControllerImpl: FormBase {
    
    private let DEFAULT_NAME = ""
    private let DEFAULT_DESCRIPTION = ""
    private let DEFAULT_DIRECTION = TargetDirection.AT_LEAST.rawValue
    private let DEFAULT_TARGET_VALUE = ""
    private let DEFAULT_TIMEPERIOD = TargetTimePeriod.DAY.rawValue
    
    private let directionOptions = [TargetDirection.AT_LEAST.rawValue, TargetDirection.AT_MOST.rawValue]
    private let timePeriodOptions = [TargetTimePeriod.DAY.rawValue, TargetTimePeriod.WEEK.rawValue, TargetTimePeriod.MONTH.rawValue]
    
    private var selectedItem: ItemDetailsDto?
    
    private var selectingOption = false
    private var validForm = false { didSet{ self.navigationItem.rightBarButtonItem?.isEnabled = validForm }}
    
    let controllerResolver: ControllerResolver
    let itemService: ItemService
    
    init(_ controllerResolver: ControllerResolver, _ itemService: ItemService) {
        self.controllerResolver = controllerResolver
        self.itemService = itemService
        super.init(nibName: nil, bundle: nil)
        sections.updateValue([FormFields.NAME, FormFields.DESCRIPTION], forKey: 0)
        sections.updateValue([FormFields.DIRECTION, FormFields.TARGET_VALUE, FormFields.TIMEPERIOD], forKey: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !selectingOption {
            updateFieldValues()
            initialiseView()
            if selectedItem != nil {
                sections.updateValue([FormFields.SHOW_ACTIVITY], forKey: 2)
                sections.updateValue([FormFields.DELETE_ITEM], forKey: 3)
            }
        }
        else {
            selectingOption = false
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if !selectingOption {
            selectedItem = nil
            view = nil
            sections.removeValue(forKey: 2)
        }
    }
    
    func updateFieldValues() {
        fieldNameToValueMap.updateValue(selectedItem?.getName() ?? DEFAULT_NAME, forKey: FormFields.NAME)
        fieldNameToValueMap.updateValue(selectedItem?.getDescription() ?? DEFAULT_DESCRIPTION, forKey: FormFields.DESCRIPTION)
        fieldNameToValueMap.updateValue(selectedItem?.getDirection().rawValue ?? DEFAULT_DIRECTION, forKey: FormFields.DIRECTION)
        let value = selectedItem != nil ? String(selectedItem!.getValue()) : DEFAULT_TARGET_VALUE
        fieldNameToValueMap.updateValue(value, forKey: FormFields.TARGET_VALUE)
        fieldNameToValueMap.updateValue(selectedItem?.getTimePeriod().rawValue ?? DEFAULT_TIMEPERIOD, forKey: FormFields.TIMEPERIOD)
    }
    
    func initialiseView() {
        let formView = ItemFormView(frame: self.view.bounds, delegate: self, dataSource: self, formController: self)
        formView.initialiseNavBar(for: self)
        validateForm()
        self.view = formView
    }
    
    override func createCellFor(formField: String) -> UITableViewCell {
        switch formField {
        case FormFields.NAME:
            return TextEntryFormCell(placeholder: "Name", text: fieldNameToValueMap[FormFields.NAME] as? String,
                                     fieldName: FormFields.NAME, numeric: false, delegate: self,
                                     accessibilityIdentifier: AccessibilityIdentifiers.ITEM_FORM_NAME_FIELD)
        case FormFields.DESCRIPTION:
            return TextEntryFormCell(placeholder: "Description", text: fieldNameToValueMap[FormFields.DESCRIPTION] as? String,
                                     fieldName: FormFields.DESCRIPTION, numeric: false, delegate: self,
                                     accessibilityIdentifier: AccessibilityIdentifiers.ITEM_FORM_DESCRIPTION_FIELD)
        case FormFields.DIRECTION:
            return FormOptionDisplayCell(label: "Target", currentValue: fieldNameToValueMap[FormFields.DIRECTION] as! String,
                                         availableValues: directionOptions, fieldName: FormFields.DIRECTION,
                                         enabled: selectedItem == nil, delegate: self,
                                         accessibilityIdentifier: AccessibilityIdentifiers.ITEM_FORM_TARGET_DIRECTION_FIELD)
        case FormFields.TARGET_VALUE:
            return TextEntryFormCell(placeholder: "1", text: fieldNameToValueMap[FormFields.TARGET_VALUE] as? String,
                                     fieldName: FormFields.TARGET_VALUE, numeric: true, delegate: self,
                                     accessibilityIdentifier: AccessibilityIdentifiers.ITEM_FORM_TARGET_VALUE_FIELD)
        case FormFields.TIMEPERIOD:
            return FormOptionDisplayCell(label: "Every", currentValue: fieldNameToValueMap[FormFields.TIMEPERIOD]! as! String,
                                         availableValues: timePeriodOptions, fieldName: FormFields.TIMEPERIOD,
                                         enabled: selectedItem == nil, delegate: self,
                                         accessibilityIdentifier: AccessibilityIdentifiers.ITEM_FORM_TARGET_TIMEPERIOD_FIELD)
        case FormFields.SHOW_ACTIVITY:
            return ButtonCell(buttonText: "Show activity", destructive: false, delegate: self,
                              buttonPressAction: { () -> Void in self.transitionTo(cellController:
                                self.controllerResolver.getActivityHistoryController()
                                    .withItem(id: self.selectedItem!.getId()) as! UIViewController) },
                              accessibilityIdentifier: AccessibilityIdentifiers.ITEM_FORM_SHOW_ACTIVITY_BUTTON )
        case FormFields.DELETE_ITEM:
            return ButtonCell(buttonText: "Delete", destructive: true, delegate: self,
                              buttonPressAction: { self.deleteButtonPressed() },
                              accessibilityIdentifier: AccessibilityIdentifiers.ITEM_FORM_DELETE_BUTTON )
        default:
            return UITableViewCell()
        }
    }
}

extension ItemFormControllerImpl: ItemFormController {
    func submitForm() {
        let _ = itemService.saveItem(ItemUpdateDto(
            selectedItem?.getId(),
            fieldNameToValueMap[FormFields.NAME] as! String,
            fieldNameToValueMap[FormFields.DESCRIPTION] as! String,
            TargetDirection(rawValue: fieldNameToValueMap[FormFields.DIRECTION] as! String)!,
            Int(fieldNameToValueMap[FormFields.TARGET_VALUE] as! String) ?? 1,
            TargetTimePeriod(rawValue: fieldNameToValueMap[FormFields.TIMEPERIOD] as! String)!,
            selectedItem?.getListPosition()))
        controllerResolver.getPrimaryNavController().popViewController(animated: true)
    }
    
    func with(item: ItemDetailsDto) {
        selectedItem = item
    }
}

extension ItemFormControllerImpl: FormCellDelegate {
    func selectionChanged(to selection: Any, for fieldName: String) {
        fieldNameToValueMap.updateValue(selection, forKey: fieldName)
        if fieldName == FormFields.NAME || fieldName == FormFields.TARGET_VALUE {
            validateForm()
        }
    }
    
    func transitionTo(cellController: UIViewController) {
        selectingOption = true
        controllerResolver.getPrimaryNavController()
            .pushViewController(cellController, animated: true)
    }
    
    func validateForm() {
        validForm = fieldNameToValueMap[FormFields.NAME] as? String ?? "" != ""
            && Int(fieldNameToValueMap[FormFields.TARGET_VALUE] as? String ?? "") ?? 0 > 0
    }

    func deleteButtonPressed() {
        showConfirmationAlert()
    }
    
    private func showConfirmationAlert() {
        let alert = UIAlertController(title: "Delete", message: "Are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (UIAlertAction) -> Void in self.deleteItem() }))
        present(alert, animated: true, completion: nil)
    }
    
    private func deleteItem() {
        if let itemId = selectedItem?.getId() {
            let _ = itemService.delete(itemWithId: itemId)
        }
        controllerResolver.getPrimaryNavController().popViewController(animated: true)
    }
}

