//
//  DatePickerCell.swift
//  countit
//
//  Created by David Grew on 12/03/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import UIKit

class DatePickerCell: UITableViewCell {

    private let datePicker = UIDatePicker()
    
    private weak var delegate: FormCellDelegate?
    private let fieldName: String
    
    init(delegate: FormCellDelegate, fieldName: String, accessibilityIdentifier: String) {
        self.delegate = delegate
        self.fieldName = fieldName
        super.init(style: .default, reuseIdentifier: "datePickerCell")
        
        self.accessibilityIdentifier = accessibilityIdentifier
        
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        self.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: topAnchor),
            datePicker.bottomAnchor.constraint(equalTo: bottomAnchor),
            datePicker.leftAnchor.constraint(equalTo: leftAnchor),
            datePicker.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dateChanged() {
        delegate?.selectionChanged(to: datePicker.date, for: fieldName)
    }
}

