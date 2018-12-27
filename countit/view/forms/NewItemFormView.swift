//
//  NewItemFormView.swift
//  countit
//
//  Created by David Grew on 05/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

class NewItemFormView: UIScrollView {
    
    private let DEFAULT_FORM_TITLE = "ADD ITEM"
    
    var form: ItemForm? { didSet { updateForm() }}
    
    var formDelegate: FormController?
    var editable: Bool = false
  
    let nameField: TextFieldView
    let descriptionField: TextFieldView
    
    var fields: [ItemFormFields: TextFieldView] = [:]
    
    override init(frame: CGRect) {
       
        nameField = TextFieldViewBuilder(frame: .zero)
            .with(spacing: 10)
            .with(fieldName: "Name")
            .with(fieldText: "")
            .with(fieldTextPlaceholder: "Enter item name")
            .with(fieldErrorText: "* Must provide a name")
            .build()
        nameField.accessibilityIdentifier = "nameField"
        nameField.translatesAutoresizingMaskIntoConstraints = false
        fields.updateValue(nameField, forKey: ItemFormFields.NAME)
        
        descriptionField = TextFieldViewBuilder(frame: .zero)
            .with(spacing: 10)
            .with(fieldName: "Description")
            .with(fieldText: "")
            .with(fieldTextPlaceholder: "Enter item description")
            .build()
        descriptionField.accessibilityIdentifier = "descriptionField"
        descriptionField.translatesAutoresizingMaskIntoConstraints = false
        fields.updateValue(descriptionField, forKey: ItemFormFields.DESCRIPTION)
        
        super.init(frame: frame)
        
        nameField.fieldText.delegate = self
        
        self.backgroundColor = UIColor.white
        self.addSubview(nameField)
        self.addSubview(descriptionField)
        NSLayoutConstraint.activate([
            nameField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3/4),
            nameField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameField.centerYAnchor.constraint(equalTo: self.topAnchor, constant: frame.height / 10),
            descriptionField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3/4),
            descriptionField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionField.centerYAnchor.constraint(equalTo: nameField.bottomAnchor, constant: frame.height / 10),
        ])
        
        if form != nil {
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
            if formDelegate != nil {
                initialiseNavBar(for: formDelegate as! UIViewController)
            }
        }
        else {
            nameField.set(value: "")
            nameField.removeErrorMessage()
            descriptionField.set(value: "")
        }
    }
    
    func clearForm() {
        form = nil
    }
    
    private func getFormData() -> ItemForm {
        let id = form?.getId()
        let name = nameField.getValue()
        let description = descriptionField.getValue()
        let listPosition = form?.getListPosition()
        
        return ItemForm(id, name, description, listPosition)
    }
}

extension NewItemFormView: NavBarButtonDelegate {
    
    @objc func saveButtonPressed() {
        
        if let controller = formDelegate {
            let form = getFormData()
            if form.isValid() {
                controller.submitForm(getFormData())
            }
            else {
                let errors = form.getFieldErrors()
                for error in errors {
                    fields[error]?.displayErrorMessage()
                }
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
}
