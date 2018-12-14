//
//  NewItemNameFieldView.swift
//  countit
//
//  Created by David Grew on 05/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

class TextFieldView: UIStackView {
    
    let fieldName = UILabel()
    let fieldText = UITextField()
    
    init(frame: CGRect,
         _ axis: NSLayoutConstraint.Axis,
         _ distribution: UIStackView.Distribution,
         _ alignment: UIStackView.Alignment,
         _ spacing: CGFloat,
         _ fieldNameString: String?,
         _ fieldTextString: String?,
         _ fieldTextPlaceholder: String?) {
        
        super.init(frame: frame)
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        
        fieldName.text = fieldNameString
        fieldText.text = fieldTextString
        
        fieldName.backgroundColor = UIColor.green
        fieldText.backgroundColor = UIColor.red
        
        fieldText.placeholder = fieldTextPlaceholder
        
        self.addArrangedSubview(fieldName)
        self.addArrangedSubview(fieldText)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
