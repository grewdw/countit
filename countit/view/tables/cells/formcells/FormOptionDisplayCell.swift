//
//  FormOptionDisplayCell.swift
//  countit
//
//  Created by David Grew on 28/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class FormOptionDisplayCell: UITableViewCell {
    
    private let availableValues: [String]
    private var fieldName: String
    private let enabled: Bool
    private weak var delegate: FormCellDelegate?
    
    init(label: String, currentValue: String, availableValues: [String], fieldName: String, enabled: Bool, delegate: FormCellDelegate, accessibilityIdentifier: String) {
        self.availableValues = availableValues
        self.fieldName = fieldName
        self.enabled = enabled
        self.delegate = delegate
        super.init(style: .value1, reuseIdentifier: "FormOptionDisplayCell")
        
        self.accessibilityIdentifier = accessibilityIdentifier
        textLabel?.text = label
        detailTextLabel?.text = currentValue
        detailTextLabel?.accessibilityIdentifier = AccessibilityIdentifiers.OPTION_FIELD_TEXT
        accessoryType = enabled ? .disclosureIndicator : .none
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FormOptionDisplayCell: FormCell {
    func setValue(to value: String) {
        textLabel?.text = value
    }
    
    func selected() {
        if enabled {
            let selectorController = FormOptionSelectorController(options: availableValues,
                                         selectedOption: availableValues.firstIndex(of: textLabel?.text ?? "") ?? 0,
                                         delegate: self,
                                         fieldName: fieldName + "selector")
            delegate?.transitionTo(cellController: selectorController)
        }
    }
}

extension FormOptionDisplayCell: FormCellDelegate {
    func selectionChanged(to selection: Any, for fieldName: String) {
        detailTextLabel?.text = selection as? String
        delegate?.selectionChanged(to: selection, for: self.fieldName)
    }
    
    func transitionTo(cellController: UIViewController) {
    }
    
    func wasSelected(fieldName: String) {
    }
}
