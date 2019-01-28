//
//  NewItemFormView.swift
//  countit
//
//  Created by David Grew on 05/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

class NewItemFormView: UIScrollView {
    
    typealias AI = AccessibilityIdentifiers
    
    private let DEFAULT_FORM_TITLE = "ADD ITEM"
    
    var form: ItemForm?
    
    var formDelegate: FormController?
    var editable: Bool = false
  
    let nameField: TextFieldView
    let descriptionField: TextFieldView
    let targetFields: TargetFormView
    
    init(frame: CGRect, form: ItemForm?) {
       
        nameField = TextFieldViewBuilder(frame: .zero)
            .with(spacing: 10)
            .with(fieldName: "Name")
            .with(fieldText: "")
            .with(fieldTextPlaceholder: "Enter item name")
            .with(fieldErrorText: "* Must provide a name")
            .build()
        nameField.accessibilityIdentifier = AI.ITEM_FORM_NAME_FIELD
        nameField.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionField = TextFieldViewBuilder(frame: .zero)
            .with(spacing: 10)
            .with(fieldName: "Description")
            .with(fieldText: "")
            .with(fieldTextPlaceholder: "Enter item description")
            .build()
        descriptionField.accessibilityIdentifier = AI.ITEM_FORM_DESCRIPTION_FIELD
        descriptionField.translatesAutoresizingMaskIntoConstraints = false
        
        targetFields = TargetFormView(frame: .zero)
        targetFields.accessibilityIdentifier = AI.ITEM_FORM_TARGET_FIELDS
        targetFields.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: frame)
        
        nameField.fieldText.delegate = self
        descriptionField.fieldText.delegate = self
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing(_:))))
        self.keyboardDismissMode = .onDrag
        
        self.backgroundColor = UIColor.white
        self.addSubview(nameField)
        self.addSubview(descriptionField)
        self.addSubview(targetFields)
        NSLayoutConstraint.activate([
            nameField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3/4),
            nameField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameField.topAnchor.constraint(equalTo: self.topAnchor, constant: frame.height / 20),
            descriptionField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3/4),
            descriptionField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: frame.height / 20),
            targetFields.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3/4),
            targetFields.heightAnchor.constraint(equalToConstant: 200),
            targetFields.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            targetFields.topAnchor.constraint(equalTo: descriptionField.bottomAnchor, constant: frame.height / 20),
        ])
        
        if form != nil {
            self.form = form
            updateForm()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewItemFormView {
    
    func initialiseNavBar(for controller: UIViewController) {
        NavigationItemBuilder(for: controller)
            .with(title: form?.getName()?.uppercased() ?? DEFAULT_FORM_TITLE)
            .with(rightButton: .SAVE, forTarget: self)
            .build()
    }
    
    
    func getForm() -> Form {
        return getFormData()
    }
    
    func setForm(form: ItemForm) {
        self.form = form
    }
        
    func updateForm() {
        if let itemForm = form {
            nameField.set(value: itemForm.getName())
            nameField.removeErrorMessage()
            descriptionField.set(value: itemForm.getDescription())
            targetFields.setValuesTo(form: itemForm.getTargetForm())
            if formDelegate != nil {
                initialiseNavBar(for: formDelegate as! UIViewController)
            }
        }
        else {
            nameField.set(value: "")
            nameField.removeErrorMessage()
            descriptionField.set(value: "")
            targetFields.setValuesToDefault()
            if formDelegate != nil {
                initialiseNavBar(for: formDelegate as! UIViewController)
            }
        }
    }

    private func getFormData() -> ItemForm {
        let id = form?.getId()
        let name = nameField.getValue()
        let description = descriptionField.getValue()
        let countTargetForm = targetFields.getFormData()
        
        return ItemForm(id, name, description, countTargetForm)
    }
}

extension NewItemFormView: NavBarButtonDelegate {
    
    @objc func saveButtonPressed() {
        
        if let controller = formDelegate {
            let form = getFormData()
            if form.isValid() {
                controller.submitForm(getFormData())
            }

        }
    }
}

extension NewItemFormView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if nameField.displayingError {
            nameField.removeErrorMessage()
        }
        else if string == "" && range.location == 0 && range.length == 1 {
            nameField.displayErrorMessage()
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
