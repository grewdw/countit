//
//  NewItemNameFieldView.swift
//  countit
//
//  Created by David Grew on 05/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

class TextFieldView: UIStackView, UITextFieldDelegate {
    
    typealias AI = AccessibilityIdentifiers
    
    let fieldName = UILabel()
    let fieldText = UITextField()
    let fieldError = UILabel()
    
    var fieldErrorText: String?
    var displayingError = false
    
    init(frame: CGRect,
         _ axis: NSLayoutConstraint.Axis,
         _ distribution: UIStackView.Distribution,
         _ alignment: UIStackView.Alignment,
         _ spacing: CGFloat,
         _ fieldNameString: String?,
         _ fieldTextString: String?,
         _ fieldTextPlaceholder: String?,
         _ fieldErrorText: String?,
         _ textFieldDelegate: UITextFieldDelegate?) {
        
        super.init(frame: frame)
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        
        fieldName.text = fieldNameString
        fieldText.text = fieldTextString
        
        fieldName.textAlignment = .left
        fieldName.adjustsFontSizeToFitWidth = true
        fieldName.font = UIFont.boldSystemFont(ofSize: 30)
        
        fieldText.borderStyle = .roundedRect
        fieldText.placeholder = fieldTextPlaceholder
        fieldText.delegate = textFieldDelegate
        
        fieldError.textColor = .red
        fieldError.textAlignment = .left
        fieldError.font = UIFont.italicSystemFont(ofSize: 12)
        self.fieldErrorText = fieldErrorText
        
        fieldName.translatesAutoresizingMaskIntoConstraints = false
        fieldText.translatesAutoresizingMaskIntoConstraints = false
        fieldError.translatesAutoresizingMaskIntoConstraints = false
        
        self.addArrangedSubview(fieldName)
        self.addArrangedSubview(fieldText)
        self.addArrangedSubview(fieldError)
        
        NSLayoutConstraint.activate([
            fieldName.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            fieldText.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            fieldError.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayErrorMessage() {
        fieldError.text = fieldErrorText ?? ""
        displayingError = true
    }
    
    func removeErrorMessage() {
        fieldError.text = ""
        displayingError = false
    }
    
    func getValue() -> String? {
        return fieldText.text
    }
    
    func set(value: String?) {
        fieldText.text = value
    }
}
