//
//  TextEntryFormCell.swift
//  countit
//
//  Created by David Grew on 28/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class TextEntryFormCell: UITableViewCell {
    
    var fieldName: String
    var textBox = UITextField()
    
    init(placeholder: String?, text: String?, fieldName: String, numeric: Bool) {
        self.fieldName = fieldName
        textBox.placeholder = placeholder
        textBox.text = text
        
        if numeric {
            textBox.keyboardType = .numberPad
        }
        
        super.init(style: .value1, reuseIdentifier: "TextEntryFormCell")
        
        selectionStyle = .none
        
        self.addSubview(textBox)
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
}
