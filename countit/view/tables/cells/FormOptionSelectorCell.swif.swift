//
//  FormOptionSelectorCell.swif.swift
//  countit
//
//  Created by David Grew on 27/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class FormOptionSelectorCell: UITableViewCell {
    
    init(text: String, selected: Bool) {
        super.init(style: .value1, reuseIdentifier: "FormOptionSelectorCell")
        self.textLabel?.text = text
        self.selectionStyle = .none
        self.tintColor = UIColor.red
        setSelected(to: selected)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelected(to selected: Bool) {
        self.accessoryType = selected ? .checkmark : .none
    }
}
