//
//  TextSelectorFieldView.swift
//  countit
//
//  Created by David Grew on 30/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

class TextSelectorFieldView: UIStackView {
    
    var textButtons: [String:UIButton] = [:]
    var selectedValue: String?
    
    init(frame: CGRect, textOptions: [String]) {
        super.init(frame: frame)
        
        self.axis = .horizontal
        self.distribution = .equalSpacing
        self.alignment = .center
        self.spacing = 5
        
        for option in 0...textOptions.count-1 {
            let newButton = UIButton()
            let text = textOptions[option]
            newButton.accessibilityIdentifier = text
            if option == 0 {
                selectedFormatFor(button: newButton, text: text)
                selectedValue = text
            }
            else {
                unselectedFormatFor(button: newButton, text: text)
            }
            newButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            textButtons.updateValue(newButton, forKey: text)
            self.addArrangedSubview(newButton)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelectedValue(to value: String) {
        if let selectedButton = textButtons[value] {
            selectedValue = value
            updateButtonsWith(selected: selectedButton)
        }
    }
    
    @objc func buttonPressed(sender: UIButton) {
        updateButtonsWith(selected: sender)
    }
    
    private func updateButtonsWith(selected: UIButton) {
        for button in textButtons.values {
            if button.isEqual(selected) {
                selectedValue = button.titleLabel?.text
                selectedFormatFor(button: button, text: button.titleLabel?.text)
            }
            else {
                unselectedFormatFor(button: button, text: button.titleLabel?.text)
            }
        }
    }
    
    private func selectedFormatFor(button: UIButton, text: String?) {
        let attributedString = NSAttributedString(
            string: text ?? "",
            attributes:[
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.underlineStyle: 1.0
            ])
        button.setAttributedTitle(attributedString, for: .normal)
    }
    
    private func unselectedFormatFor(button: UIButton, text: String?) {
        let attributedString = NSAttributedString(
            string: text ?? "",
            attributes:[
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                NSAttributedString.Key.foregroundColor: UIColor.gray,
                NSAttributedString.Key.underlineStyle: 0.0
            ])
        button.setAttributedTitle(attributedString, for: .normal)
    }
}
