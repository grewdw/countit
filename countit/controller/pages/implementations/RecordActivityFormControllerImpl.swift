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
    
    init(controllerResolver: ControllerResolver, activityService: ActivityService, item: ItemDetailsDto, messageBroker: MessageBroker) {
        self.controllerResolver = controllerResolver
        self.activityService = activityService
        self.item = item
        super.init(nibName: nil, bundle: nil)
        sections.updateValue([FormFields.ACTIVITY_VALUE], forKey: 0)
        sections.updateValue([FormFields.ACTIVITY_DATE], forKey: 1)
        sections.updateValue([FormFields.ACTIVITY_NOTE], forKey: 2)
        sections.updateValue([FormFields.RECORD_ACTIVITY], forKey: 3)
        
        messageBroker.subscribeTo(message: .KEYBOARD_HIDE, for: self)
        messageBroker.subscribeTo(message: .KEYBOARD_SHOW, for: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let formView = RecordActivityFormView(
            frame: view.bounds, delegate: self, dataSource: self, recordActivityFormController: self)
        formView.initialiseNavBar(for: self)
        self.view = formView
    }
    
    override func createCellFor(formField: String) -> UITableViewCell {
        switch formField {
        case FormFields.ACTIVITY_VALUE:
            return TextEntryFormCell(placeholder: "0", text: fieldNameToValueMap[FormFields.ACTIVITY_VALUE] as? String,
                                     fieldName: FormFields.ACTIVITY_VALUE, numeric: true, delegate: self,
                                     accessibilityIdentifier: AccessibilityIdentifiers.RECORD_ACTIVITY_FORM_VALUE)
        case FormFields.ACTIVITY_DATE:
            return DatePickerCell(delegate: self, fieldName: FormFields.ACTIVITY_DATE,
                                  accessibilityIdentifier: AccessibilityIdentifiers.RECORD_ACTIVITY_FORM_DATE)
        case FormFields.ACTIVITY_NOTE:
            return TextEntryFormCell(placeholder: "Add a note", text: fieldNameToValueMap[FormFields.ACTIVITY_NOTE] as? String,
                                     fieldName: FormFields.ACTIVITY_NOTE, numeric: false, delegate: self,
                                     accessibilityIdentifier: AccessibilityIdentifiers.RECORD_ACTIVITY_FORM_NOTE)
        case FormFields.RECORD_ACTIVITY:
            return ButtonCell(buttonText: "Save", destructive: false, enabled: false, delegate: self,
                              buttonPressAction: { () -> Void in self.recordActivity() },
                              accessibilityIdentifier: AccessibilityIdentifiers.RECORD_ACTIVITY_FORM_SAVE_BUTTON )
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Record activity"
        case 1:
            return "Activity time"
        default:
            return nil
        }
    }
}

extension RecordActivityFormControllerImpl: FormCellDelegate {
    
    func selectionChanged(to selection: Any, for fieldName: String) {
        if fieldName == FormFields.ACTIVITY_VALUE {
            let tableView = self.view as? UITableView
            let buttonCell = tableView?.cellForRow(at: fieldToIndexPathMap[FormFields.RECORD_ACTIVITY]!) as? ButtonCell
            
            if Int(selection as? String ?? "0") ?? 0 > 0 {
                buttonCell?.setEnabled(to: true)
            }
            else {
                buttonCell?.setEnabled(to: false)
            }
        }
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
                 timestamp: fieldNameToValueMap[FormFields.ACTIVITY_DATE] as? Date,
                 note: fieldNameToValueMap[FormFields.ACTIVITY_NOTE] as? String))
            controllerResolver.getPrimaryNavController().popViewController(animated: true)
        }
    }
}

extension RecordActivityFormControllerImpl: MessageListener {
    
    func received(message: Message, content: Any?) {
        if message == .KEYBOARD_HIDE {
            expandAfterKeyboard()
        }
        if message == .KEYBOARD_SHOW {
            guard let keyboardFrame = content as? CGRect else { return }
            shrinkBeforeKeyboard(keyboardFrame: keyboardFrame)
        }
    }
}
