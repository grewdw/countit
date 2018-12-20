//
//  NewItemNameFieldView.swift
//  countit
//
//  Created by David Grew on 05/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

class TextFieldView: UIStackView, UITextFieldDelegate {
    
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
        
        fieldText.delegate = textFieldDelegate
        self.fieldErrorText = fieldErrorText
        
        fieldName.backgroundColor = UIColor.green
        
        fieldText.borderStyle = .roundedRect
        
        fieldText.placeholder = fieldTextPlaceholder
        
        self.addArrangedSubview(fieldName)
        self.addArrangedSubview(fieldText)
        self.addArrangedSubview(fieldError)
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
}
