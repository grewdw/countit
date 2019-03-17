//
//  ButtonCell.swift
//  countit
//
//  Created by David Grew on 01/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class ButtonCell: UITableViewCell {
    
    private var button: UIButton?
    private let delegate: FormCellDelegate
    private let buttonPressAction: () -> Void
    
    private var enabled: Bool
    private let destructive: Bool
    
    init(buttonText: String, destructive: Bool, enabled: Bool, delegate: FormCellDelegate, buttonPressAction: @escaping () -> Void, accessibilityIdentifier: String) {
        self.delegate = delegate
        self.buttonPressAction = buttonPressAction
        self.destructive = destructive
        self.enabled = enabled
        super.init(style: .value1, reuseIdentifier: "buttonCell")
        self.accessibilityIdentifier = accessibilityIdentifier
        
        let textColor = !enabled ? UIColor.gray : destructive ? UIColor.red : UIColor.blue
        
        button = UIButtonBuilder().with(textColor: textColor).with(buttonText: buttonText)
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
        if enabled {
            buttonPressAction()
        }
    }
    
    func setEnabled(to newStatus: Bool) {
        if !newStatus {
            button?.titleLabel?.textColor = UIColor.gray
        }
        else {
            button?.titleLabel?.textColor = destructive ? UIColor.red : UIColor.blue
        }
        enabled = newStatus
    }
}
