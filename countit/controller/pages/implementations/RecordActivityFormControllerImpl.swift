//
//  RecordActivityControllerImpl.swift
//  countit
//
//  Created by David Grew on 12/03/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class RecordActivityFormControllerImpl: FormBase {
    
    private let controllerResolver: ControllerResolver
    private let activityService: ActivityService
    
    private let item: ItemDetailsDto
    
    init(controllerResolver: ControllerResolver, activityService: ActivityService, item: ItemDetailsDto) {
        self.controllerResolver = controllerResolver
        self.activityService = activityService
        self.item = item
        super.init(nibName: nil, bundle: nil)
        sections.updateValue([FormFields.ACTIVITY_VALUE, FormFields.ACTIVITY_DATE, FormFields.RECORD_ACTIVITY], forKey: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let tableView = RecordActivityFormView(
            frame: view.bounds, delegate: self, dataSource: self, recordActivityFormController: self)
        tableView.initialiseNavBar(for: self)
        self.view = tableView
    }
    
    override func createCellFor(formField: String) -> UITableViewCell {
        switch formField {
        case FormFields.ACTIVITY_VALUE:
            return TextEntryFormCell(placeholder: "1", text: fieldNameToValueMap[FormFields.ACTIVITY_VALUE] as? String,
                                     fieldName: FormFields.ACTIVITY_VALUE, numeric: true, delegate: self,
                                     accessibilityIdentifier: AccessibilityIdentifiers.ITEM_FORM_TARGET_VALUE_FIELD)
        case FormFields.ACTIVITY_DATE:
            return DatePickerCell(delegate: self, fieldName: FormFields.ACTIVITY_DATE)
        case FormFields.RECORD_ACTIVITY:
            return ButtonCell(buttonText: "Save", destructive: false, delegate: self,
                              buttonPressAction: { () -> Void in self.recordActivity() },
                              accessibilityIdentifier: AccessibilityIdentifiers.ITEM_FORM_SHOW_ACTIVITY_BUTTON )
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Record activity"
    }
}

extension RecordActivityFormControllerImpl: FormCellDelegate {
    
    func selectionChanged(to selection: Any, for fieldName: String) {
        fieldNameToValueMap.updateValue(selection, forKey: fieldName)
    }
    
    func transitionTo(cellController: UIViewController) {
    }
}

extension RecordActivityFormControllerImpl: RecordActivityFormController {
    
    func recordActivity() {
        if Int(fieldNameToValueMap[FormFields.ACTIVITY_VALUE] as? String ?? "0") ?? 0 > 0 {
            let _ = activityService.record(activityUpdate: ActivityUpdateDto(item: item,
                 value: Int(fieldNameToValueMap[FormFields.ACTIVITY_VALUE] as! String)!,
                 timestamp: fieldNameToValueMap[FormFields.ACTIVITY_DATE] as? Date))
            controllerResolver.getPrimaryNavController().popViewController(animated: true)
        }
    }
}
