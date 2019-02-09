//
//  ItemFormControllerImpl.swift
//  countit
//
//  Created by David Grew on 28/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class ItemFormControllerImpl: UIViewController {
    
    private let DEFAULT_NAME = ""
    private let DEFAULT_DESCRIPTION = ""
    private let DEFAULT_DIRECTION = TargetDirection.AT_LEAST.rawValue
    private let DEFAULT_TARGET_VALUE = ""
    private let DEFAULT_TIMEPERIOD = TargetTimePeriod.DAY.rawValue
    
    private var sections: [Int : [ItemFormField]] = [:]
    private var fieldToIndexPathMap: [ItemFormField : IndexPath] = [:]
    private var indexPathToFieldMap: [IndexPath : ItemFormField] = [:]
    private var fieldNameToValueMap: [ItemFormField : String] = [:]
    
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
        sections.updateValue([ItemFormField.NAME, ItemFormField.DESCRIPTION], forKey: 0)
        sections.updateValue([ItemFormField.DIRECTION, ItemFormField.TARGET_VALUE, ItemFormField.TIMEPERIOD], forKey: 1)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !selectingOption {
            updateFieldValues()
            initialiseView()
            if selectedItem != nil {
                sections.updateValue([ItemFormField.SHOW_ACTIVITY], forKey: 2)
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
        fieldNameToValueMap.updateValue(selectedItem?.getName() ?? DEFAULT_NAME, forKey: .NAME)
        fieldNameToValueMap.updateValue(selectedItem?.getDescription() ?? DEFAULT_DESCRIPTION, forKey: .DESCRIPTION)
        fieldNameToValueMap.updateValue(selectedItem?.getDirection().rawValue ?? DEFAULT_DIRECTION, forKey: .DIRECTION)
        let value = selectedItem != nil ? String(selectedItem!.getValue()) : DEFAULT_TARGET_VALUE
        fieldNameToValueMap.updateValue(value, forKey: .TARGET_VALUE)
        fieldNameToValueMap.updateValue(selectedItem?.getTimePeriod().rawValue ?? DEFAULT_TIMEPERIOD, forKey: .TIMEPERIOD)
    }
    
    func initialiseView() {
        let formView = ItemFormView(frame: self.view.bounds, delegate: self, dataSource: self, formController: self)
        formView.initialiseNavBar(for: self)
        validForm = fieldNameToValueMap[.NAME] == "" ? false : true
        self.view = formView
    }
}

extension ItemFormControllerImpl: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let formField: ItemFormField = sections[indexPath.section]![indexPath.row]
        fieldToIndexPathMap.updateValue(indexPath, forKey: formField)
        indexPathToFieldMap.updateValue(formField, forKey: indexPath)
        return createCellFor(formField: formField)
    }
    
    private func createCellFor(formField: ItemFormField) -> UITableViewCell {
        switch formField {
        case .NAME:
            return TextEntryFormCell(placeholder: "Name", text: fieldNameToValueMap[.NAME],
                                     fieldName: ItemFormField.NAME.rawValue, numeric: false, delegate: self,
                                     accessibilityIdentifier: AccessibilityIdentifiers.ITEM_FORM_NAME_FIELD)
        case .DESCRIPTION:
            return TextEntryFormCell(placeholder: "Description", text: fieldNameToValueMap[.DESCRIPTION],
                                     fieldName: ItemFormField.DESCRIPTION.rawValue, numeric: false, delegate: self,
                                     accessibilityIdentifier: AccessibilityIdentifiers.ITEM_FORM_DESCRIPTION_FIELD)
        case .DIRECTION:
            return FormOptionDisplayCell(label: "Target", currentValue: fieldNameToValueMap[.DIRECTION]!,
                                         availableValues: directionOptions, fieldName: ItemFormField.DIRECTION.rawValue,
                                         enabled: selectedItem == nil, delegate: self,
                                         accessibilityIdentifier: AccessibilityIdentifiers.ITEM_FORM_TARGET_DIRECTION_FIELD)
        case .TARGET_VALUE:
            return TextEntryFormCell(placeholder: "0", text: fieldNameToValueMap[.TARGET_VALUE],
                                     fieldName: ItemFormField.TARGET_VALUE.rawValue, numeric: true, delegate: self,
                                     accessibilityIdentifier: AccessibilityIdentifiers.ITEM_FORM_TARGET_VALUE_FIELD)
        case .TIMEPERIOD:
            return FormOptionDisplayCell(label: "Every", currentValue: fieldNameToValueMap[.TIMEPERIOD]!,
                                         availableValues: timePeriodOptions, fieldName: ItemFormField.TIMEPERIOD.rawValue,
                                         enabled: selectedItem == nil, delegate: self,
                                         accessibilityIdentifier: AccessibilityIdentifiers.ITEM_FORM_TARGET_TIMEPERIOD_FIELD)
        case .SHOW_ACTIVITY:
            return ButtonCell(buttonText: "Show activity", delegate: self,
                              buttonPressAction: { () -> Void in                                self.transitionTo(cellController: self.controllerResolver.getActivityHistoryController()
                                .withItem(id: self.selectedItem!.getId()!) as! UIViewController) },
                              accessibilityIdentifier: AccessibilityIdentifiers.ITEM_FORM_SHOW_ACTIVITY_BUTTON )
        }
    }
}

extension ItemFormControllerImpl: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tableView = view as? UITableView
        let cell = tableView?.cellForRow(at: indexPath) as? FormCell
        cell?.selected()
    }
}

extension ItemFormControllerImpl: ItemFormController {
    func submitForm() {
        let _ = itemService.saveItem(ItemDetailsDto(
            selectedItem?.getId(),
            fieldNameToValueMap[.NAME]!,
            fieldNameToValueMap[.DESCRIPTION]!,
            TargetDirection(rawValue: fieldNameToValueMap[.DIRECTION]!)!,
            Int(fieldNameToValueMap[.TARGET_VALUE]!) ?? 0,
            TargetTimePeriod(rawValue: fieldNameToValueMap[.TIMEPERIOD]!)!,
            selectedItem?.getListPosition()))
        controllerResolver.getPrimaryNavController().popViewController(animated: true)
    }
    
    func with(item: ItemDetailsDto) {
        selectedItem = item
    }
}

extension ItemFormControllerImpl: FormCellDelegate {
    func selectionChanged(to selection: String, for fieldName: String) {
        if let changedField = ItemFormField.init(rawValue: fieldName) {
            fieldNameToValueMap.updateValue(selection, forKey: changedField)
            if changedField == ItemFormField.NAME {
                validForm = selection != ""
            }
        }
    }
    
    func transitionTo(cellController: UIViewController) {
        selectingOption = true
        controllerResolver.getPrimaryNavController()
            .pushViewController(cellController, animated: true)
    }
}

enum ItemFormField: String {
    
    case NAME = "name"
    case DESCRIPTION = "description"
    case DIRECTION = "direction"
    case TARGET_VALUE = "targetValue"
    case TIMEPERIOD = "timePeriod"
    case SHOW_ACTIVITY = "showActivity"
}
