//
//  ItemFormControllerNew.swift
//  countit
//
//  Created by David Grew on 28/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class ItemFormControllerNew: UIViewController {
    
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
    let viewResolver: ViewResolver
    let itemService: ItemService
    
    init(_ controllerResolver: ControllerResolver, _ viewResolver: ViewResolver, _ itemService: ItemService) {
        self.controllerResolver = controllerResolver
        self.viewResolver = viewResolver
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
        }
        else {
            selectingOption = false
        }
        initialiseView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        view = nil
    }
    
    func updateFieldValues() {
        fieldNameToValueMap.updateValue(selectedItem?.getName() ?? DEFAULT_NAME, forKey: .NAME)
        fieldNameToValueMap.updateValue(selectedItem?.getDescription() ?? DEFAULT_DESCRIPTION, forKey: .DESCRIPTION)
        fieldNameToValueMap.updateValue(selectedItem?.getDirection().rawValue ?? DEFAULT_DIRECTION, forKey: .DIRECTION)
        fieldNameToValueMap.updateValue(String(selectedItem?.getValue() ?? 0) ?? DEFAULT_TARGET_VALUE, forKey: .TARGET_VALUE)
        fieldNameToValueMap.updateValue(selectedItem?.getTimePeriod().rawValue ?? DEFAULT_TIMEPERIOD, forKey: .TIMEPERIOD)
    }
    
    func initialiseView() {
        let formView = ItemFormView(frame: self.view.bounds, delegate: self, dataSource: self, formController: self)
        formView.initialiseNavBar(for: self)
        validForm = fieldNameToValueMap[.NAME] == "" ? false : true
        self.view = formView
    }
}

extension ItemFormControllerNew: UITableViewDataSource {
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
            return TextEntryFormCell(placeholder: "Name", text: fieldNameToValueMap[.NAME], fieldName: ItemFormField.NAME.rawValue, numeric: false, delegate: self)
        case .DESCRIPTION:
            return TextEntryFormCell(placeholder: "Description", text: fieldNameToValueMap[.DESCRIPTION], fieldName: ItemFormField.DESCRIPTION.rawValue, numeric: false, delegate: self)
        case .DIRECTION:
            return FormOptionDisplayCell(label: "Target", currentValue: fieldNameToValueMap[.DIRECTION]!, fieldName: ItemFormField.DIRECTION.rawValue)
        case .TARGET_VALUE:
            return TextEntryFormCell(placeholder: "0", text: fieldNameToValueMap[.TARGET_VALUE], fieldName: ItemFormField.TARGET_VALUE.rawValue, numeric: true, delegate: self)
        case .TIMEPERIOD:
            return FormOptionDisplayCell(label: "Every", currentValue: fieldNameToValueMap[.TIMEPERIOD]!, fieldName: ItemFormField.TIMEPERIOD.rawValue)
        }
    }
}

extension ItemFormControllerNew: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let field = indexPathToFieldMap[indexPath] {
            if field == ItemFormField.DIRECTION || field == ItemFormField.TIMEPERIOD {
                pushSelectorController(for: field)
            }
        }
    }
    
    private func pushSelectorController(for field: ItemFormField) {
        selectingOption = true
        let selectorController = field == ItemFormField.DIRECTION
            ? FormOptionSelectorController(options: directionOptions,
                                           selectedOption: directionOptions.firstIndex(of: fieldNameToValueMap[.DIRECTION]!) ?? 0,
                                           delegate: self,
                                           fieldName: ItemFormField.DIRECTION.rawValue)
            : FormOptionSelectorController(options: timePeriodOptions,
                                           selectedOption: timePeriodOptions.firstIndex(of: fieldNameToValueMap[.TIMEPERIOD]!) ?? 0,
                                           delegate: self,
                                           fieldName: ItemFormField.TIMEPERIOD.rawValue)
        let navController = controllerResolver.get(.PRIMARY_NAV_CONTROLLER) as? UINavigationController
        navController?.pushViewController(selectorController, animated: true)
    }
}

extension ItemFormControllerNew: FormController {
    func submitForm() {
        itemService.saveItem(ItemDetailsDto(selectedItem?.getId(),
            fieldNameToValueMap[.NAME]!,
            fieldNameToValueMap[.DESCRIPTION]!,
            TargetDirection(rawValue: fieldNameToValueMap[.DIRECTION]!)!,
            Int(fieldNameToValueMap[.TARGET_VALUE]!)!,
            TargetTimePeriod(rawValue: fieldNameToValueMap[.TIMEPERIOD]!)!,
            selectedItem?.getListPosition()))
        let navController = controllerResolver.get(.PRIMARY_NAV_CONTROLLER) as? UINavigationController
        navController?.popViewController(animated: true)
    }
    
    func with(item: ItemDetailsDto) {
        selectedItem = item
    }
}

extension ItemFormControllerNew: FormCellDelegate {
    func selectionChanged(to selection: String, for fieldName: String) {
        if let changedField = ItemFormField.init(rawValue: fieldName) {
            fieldNameToValueMap.updateValue(selection, forKey: changedField)
            if changedField == ItemFormField.NAME {
                validForm = selection != ""
            }
        }
    }
}

enum ItemFormField: String {
    
    case NAME = "name"
    case DESCRIPTION = "description"
    case DIRECTION = "direction"
    case TARGET_VALUE = "targetValue"
    case TIMEPERIOD = "timePeriod"
}
