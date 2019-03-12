//
//  UIButtonBuilder.swift
//  countit
//
//  Created by David Grew on 11/03/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import UIKit

class UIButtonBuilder {
    
    private var textColor: UIColor = UIColor.blue
    private var buttonText: String = ""
    private var accessibilityIdentifier: String = ""
    
    func with(destructive: Bool) -> UIButtonBuilder {
        textColor = destructive ? UIColor.red : UIColor.blue
        return self
    }
    
    func with(buttonText: String) -> UIButtonBuilder {
        self.buttonText = buttonText
        return self
    }
    
    func with(accessibilityIdentifier: String) -> UIButtonBuilder {
        self.accessibilityIdentifier = accessibilityIdentifier
        return self
    }
    
    func build() -> UIButton {
        let button = UIButton()
        button.accessibilityIdentifier = accessibilityIdentifier
        
        let attributedString = NSAttributedString(
            string: buttonText,
            attributes:[
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17),
                NSAttributedString.Key.foregroundColor: textColor,
                NSAttributedString.Key.underlineStyle: 1.0
            ])
        button.setAttributedTitle(attributedString, for: .normal)
        button.titleLabel?.textAlignment = .center
        
        return button
    }
}
