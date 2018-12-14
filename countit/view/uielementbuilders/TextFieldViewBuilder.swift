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
    
    init (frame: CGRect) {
        self.frame = frame
        self.axis = NSLayoutConstraint.Axis.vertical
        self.distribution = UIStackView.Distribution.fillProportionally
        self.alignment = UIStackView.Alignment.center
        self.spacing = 5
        self.fieldName = nil
        self.fieldText = nil
        self.fieldTextPlaceholder = nil
    }
    
    func withAxis(_ axis: NSLayoutConstraint.Axis) -> TextFieldViewBuilder {
        self.axis = axis
        return self
    }
    
    func withDistribution(_ distribution: UIStackView.Distribution) -> TextFieldViewBuilder {
        self.distribution = distribution
        return self
    }
    
    func withAlignment(_ alignment: UIStackView.Alignment) {
        self.alignment = alignment
    }
    
    func withSpacing(_ spacing: CGFloat) {
        self.spacing = spacing
    }
    
    func withFieldName(_ fieldName: String) -> TextFieldViewBuilder {
        self.fieldName = fieldName
        return self
    }
    
    func withFieldText(_ fieldText: String) -> TextFieldViewBuilder {
        self.fieldText = fieldText
        return self
    }
    
    func withFieldTextPlaceholder(_ fieldTextPlaceholder: String) -> TextFieldViewBuilder {
        self.fieldTextPlaceholder = fieldTextPlaceholder
        return self
    }
    
    func build() -> TextFieldView {
        return TextFieldView(frame: frame, axis, distribution, alignment, spacing, fieldName, fieldText, fieldTextPlaceholder)
    }
}
