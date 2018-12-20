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
            .with(fieldName: "Name")
            .with(fieldText: "")
            .with(fieldTextPlaceholder: "Enter item name")
            .with(fieldErrorText: "Must provide a name")
            .build()
        nameField.translatesAutoresizingMaskIntoConstraints = false
        fields.updateValue(nameField, forKey: ItemFormFields.NAME)
        
        descriptionField = TextFieldViewBuilder(frame: .zero)
            .with(fieldName: "Description")
            .with(fieldText: "")
            .with(fieldTextPlaceholder: "Enter item description")
            .build()
        descriptionField.translatesAutoresizingMaskIntoConstraints = false
        fields.updateValue(descriptionField, forKey: ItemFormFields.DESCRIPTION)
        
        super.init(frame: frame)
        
        nameField.fieldText.delegate = self
        
        self.backgroundColor = UIColor.white
        self.addSubview(nameField)
        self.addSubview(descriptionField)
        NSLayoutConstraint.activate([
            nameField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
            nameField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameField.centerYAnchor.constraint(equalTo: self.topAnchor, constant: frame.height / 6),
            descriptionField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
            descriptionField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            descriptionField.centerYAnchor.constraint(equalTo: nameField.bottomAnchor, constant: frame.height / 6),
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
    
    func initialiseNavBar(for controller: FormController) {
        NavigationItemBuilder.setNavBar(title: form?.getName()?.uppercased() ?? DEFAULT_FORM_TITLE, leftButton: nil, leftButtonTarget: self, rightButton: NavBarButtonType.SAVE, rightButtonTarget: self, controller: controller as! UIViewController)
    }
    
    
    func getForm() -> Form {
        return getFormData()
    }
    
    func setForm(form: ItemForm) {
        self.form = form
    }
        
    func updateForm() {
        if let itemForm = form {
            nameField.fieldText.text = itemForm.getName()
            nameField.removeErrorMessage()
            descriptionField.fieldText.text = itemForm.getDescription()
            if formDelegate != nil {
                initialiseNavBar(for: formDelegate!)
            }
        }
        else {
            nameField.fieldText.text = ""
            nameField.removeErrorMessage()
            descriptionField.fieldText.text = ""
        }
    }
    
    func clearForm() {
        form = nil
    }
    
    private func getFormData() -> ItemForm {
        let id = form?.getId()
        let name = nameField.fieldText.text
        let description = descriptionField.fieldText.text
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
