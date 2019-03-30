//
//  TextEntryFormCell.swift
//  countit
//
//  Created by David Grew on 28/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class TextEntryFormCell: UITableViewCell {
    
    private var fieldName: String
    private var textBox = UITextField()
    private weak var delegate: FormCellDelegate?
    
    init(placeholder: String?, text: String?, fieldName: String, numeric: Bool, delegate: FormCellDelegate, accessibilityIdentifier: String) {
        self.fieldName = fieldName
        self.delegate = delegate
        textBox.placeholder = placeholder
        textBox.text = text
        
        if numeric {
            textBox.keyboardType = .numberPad
        }
        
        super.init(style: .value1, reuseIdentifier: "TextEntryFormCell")
        
        self.accessibilityIdentifier = accessibilityIdentifier
        selectionStyle = .none
        
        self.addSubview(textBox)
        textBox.delegate = self
        textBox.accessibilityIdentifier = AccessibilityIdentifiers.TEXT_FIELD_TEXT
        textBox.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textBox.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            textBox.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            textBox.centerYAnchor.constraint(equalTo: centerYAnchor),
            textBox.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TextEntryFormCell: FormCell {
    func setValue(to value: String) {
        textBox.text = value
    }
    
    func selected() {
    }
}

extension TextEntryFormCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let currentText = textBox.text {
            var textArray = Array(currentText)
            var newText = [Character]()
            if textArray.count != 0 {
                for charPos in 0...textArray.count - 1 {
                    if charPos < range.location || charPos >= range.location + range.length {
                        newText.append(textArray[charPos])
                    }
                }
            }
            if range.location == textArray.count && string != "" {
                newText.append(contentsOf: Array(string))
            }
            delegate?.selectionChanged(to: String(newText), for: fieldName)
            return true
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.wasSelected(fieldName: fieldName)
    }
}
