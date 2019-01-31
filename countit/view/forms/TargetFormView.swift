//
//  CountTargetFormView.swift
//  countit
//
//  Created by David Grew on 30/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

class TargetFormView: UIStackView {
    
    typealias AI = AccessibilityIdentifiers
    
    let title = UILabel()
    let direction = TextSelectorFieldView(frame: .zero, textOptions: ["At least", "At most"])
    var value = UITextField()
    let timePeriod = TextSelectorFieldView(frame: .zero, textOptions: ["Day", "Week", "Month"])
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.axis = .vertical
        self.distribution = .fillProportionally
        self.alignment = .center
        self.spacing = 10
        
        title.text = "Target"
        title.textAlignment = .left
        title.adjustsFontSizeToFitWidth = true
        title.font = UIFont.boldSystemFont(ofSize: 30)
        
        value.borderStyle = .roundedRect
        value.textAlignment = .center
        value.keyboardType = .numberPad
        value.placeholder = "0"
        
        title.translatesAutoresizingMaskIntoConstraints = false
        direction.translatesAutoresizingMaskIntoConstraints = false
        value.translatesAutoresizingMaskIntoConstraints = false
        timePeriod.translatesAutoresizingMaskIntoConstraints = false
        
        self.addArrangedSubview(title)
        self.addArrangedSubview(direction)
        self.addArrangedSubview(value)
        self.addArrangedSubview(timePeriod)
        
        NSLayoutConstraint.activate([
            title.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            direction.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            value.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            timePeriod.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
            ])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValuesTo(form: TargetForm) {
        direction.setSelectedValue(to: form.getDirection().rawValue)
        value.text = String(form.getValue())
        timePeriod.setSelectedValue(to: form.getTimePeriod().rawValue)
        direction.set(editable: false)
        timePeriod.set(editable: false)
    }
    
    func setValuesToDefault() {
        direction.setSelectedValue(to: TargetDirection.AT_LEAST.rawValue)
        value.text = ""
        timePeriod.setSelectedValue(to: TargetTimePeriod.DAY.rawValue)
    }
    
    func getFormData() -> TargetForm {
        return TargetForm(direction: getDirection(), value: Int(value.text!) ?? 0, timePeriod: getTimePeriod())
    }
    
    private func getDirection() -> TargetDirection {
        return TargetDirection(rawValue: direction.getSelectedValue() ?? "At least")!
    }
    
    private func getTimePeriod() -> TargetTimePeriod {
        return TargetTimePeriod(rawValue: timePeriod.getSelectedValue() ?? "Day")!
    }
}


