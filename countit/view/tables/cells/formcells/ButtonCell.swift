//
//  ButtonCell.swift
//  countit
//
//  Created by David Grew on 01/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class ButtonCell: UITableViewCell {
    
    var button: UIButton?
    let delegate: FormCellDelegate
    let buttonPressAction: () -> Void
    
    init(buttonText: String, destructive: Bool, delegate: FormCellDelegate, buttonPressAction: @escaping () -> Void, accessibilityIdentifier: String) {
        self.delegate = delegate
        self.buttonPressAction = buttonPressAction
        super.init(style: .value1, reuseIdentifier: "buttonCell")
        self.accessibilityIdentifier = accessibilityIdentifier
        
        button = UIButtonBuilder().with(destructive: destructive).with(buttonText: buttonText)
            .with(accessibilityIdentifier: AccessibilityIdentifiers.BUTTON_FIELD_BUTTON).build()
        
        button!.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button!.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(button!)
        
        NSLayoutConstraint.activate([
            button!.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            button!.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            button!.centerYAnchor.constraint(equalTo: centerYAnchor),
            button!.centerXAnchor.constraint(equalTo: centerXAnchor),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonPressed() {
        buttonPressAction()
    }
}
