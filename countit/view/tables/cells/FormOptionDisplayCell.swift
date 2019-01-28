//
//  FormOptionDisplayCell.swift
//  countit
//
//  Created by David Grew on 28/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class FormOptionDisplayCell: UITableViewCell {
    
    var fieldName: String
    
    init(label: String, currentValue: String, fieldName: String) {
        self.fieldName = fieldName
        super.init(style: .value1, reuseIdentifier: "FormOptionDisplayCell")
        
        textLabel?.text = label
        detailTextLabel?.text = currentValue
        accessoryType = .disclosureIndicator
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
}
