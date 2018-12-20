//
//  TextFieldViewBuilder.swift
//  countit
//
//  Created by David Grew on 05/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

class TextFieldViewBuilder {
    
    var frame: CGRect
    var axis: NSLayoutConstraint.Axis
    var distribution: UIStackView.Distribution
    var alignment: UIStackView.Alignment
    var spacing: CGFloat
    var fieldName: String?
    var fieldText: String?
    var fieldTextPlaceholder: String?
    var fieldErrorText: String?
    var textFieldDelegate: UITextFieldDelegate?
    
    init (frame: CGRect) {
        self.frame = frame
        self.axis = NSLayoutConstraint.Axis.vertical
        self.distribution = UIStackView.Distribution.fillProportionally
        self.alignment = UIStackView.Alignment.center
        self.spacing = 5
        self.fieldName = nil
        self.fieldText = nil
        self.fieldTextPlaceholder = nil
        self.fieldErrorText = nil
        self.textFieldDelegate = nil
    }
    
    func with(axis: NSLayoutConstraint.Axis) -> TextFieldViewBuilder {
        self.axis = axis
        return self
    }
    
    func with(distribution: UIStackView.Distribution) -> TextFieldViewBuilder {
        self.distribution = distribution
        return self
    }
    
    func with(alignment: UIStackView.Alignment) {
        self.alignment = alignment
    }
    
    func with(spacing: CGFloat) {
        self.spacing = spacing
    }
    
    func with(fieldName text: String) -> TextFieldViewBuilder {
        self.fieldName = text
        return self
    }
    
    func with(fieldText text: String) -> TextFieldViewBuilder {
        self.fieldText = text
        return self
    }
    
    func with(fieldTextPlaceholder text: String) -> TextFieldViewBuilder {
        self.fieldTextPlaceholder = text
        return self
    }
    
    func with(fieldErrorText text: String) -> TextFieldViewBuilder {
        self.fieldErrorText = text
        return self
    }
    
    func with(textFieldDelegate delegate: UITextFieldDelegate) -> TextFieldViewBuilder {
        self.textFieldDelegate = delegate
        return self
    }
    
    func build() -> TextFieldView {
        return TextFieldView(frame: frame, axis, distribution, alignment, spacing, fieldName, fieldText, fieldTextPlaceholder, fieldErrorText, textFieldDelegate)
    }
}
