//
//  ButtonCell.swift
//  countit
//
//  Created by David Grew on 01/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class ButtonCell: UITableViewCell {
    
    let button = UIButton()
    let delegate: FormCellDelegate
    let buttonPressAction: () -> Void
    
    init(buttonText: String, delegate: FormCellDelegate, buttonPressAction: @escaping () -> Void, accessibilityIdentifier: String) {
        self.delegate = delegate
        self.buttonPressAction = buttonPressAction
        super.init(style: .value1, reuseIdentifier: "buttonCell")
        self.accessibilityIdentifier = accessibilityIdentifier
        self.addSubview(button)
        
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        format(button: button, text: buttonText)
        button.accessibilityIdentifier = AccessibilityIdentifiers.BUTTON_FIELD_BUTTON
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            button.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func format(button: UIButton, text: String) {
        let attributedString = NSAttributedString(
            string: text,
            attributes:[
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17),
                NSAttributedString.Key.foregroundColor: UIColor.red,
                NSAttributedString.Key.underlineStyle: 1.0
            ])
        button.setAttributedTitle(attributedString, for: .normal)
        button.titleLabel?.textAlignment = .center
    }
    
    @objc func buttonPressed() {
        buttonPressAction()
    }
}
