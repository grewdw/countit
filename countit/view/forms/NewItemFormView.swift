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
    
    override init(frame: CGRect) {
       
        nameField = TextFieldViewBuilder(frame: .zero)
            .withFieldName("Name")
            .withFieldText("")
            .withFieldTextPlaceholder("Enter item name")
            .build()
        nameField.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionField = TextFieldViewBuilder(frame: .zero)
            .withFieldName("Description")
            .withFieldText("")
            .withFieldTextPlaceholder("Enter item description")
            .build()
        descriptionField.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: frame)
        
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
            descriptionField.fieldText.text = itemForm.getDescription()
            if formDelegate != nil {
                initialiseNavBar(for: formDelegate!)
            }
        }
    }
    
    func clearForm() {
        nameField.fieldText.text = ""
        descriptionField.fieldText.text = ""
    }
    
    private func getFormData() -> ItemForm {
        let name = nameField.fieldText.text
        let description = descriptionField.fieldText.text
        
        if let itemId = form?.getId() {
            return ItemForm(itemId, name, description)
        }
        else {
            return ItemForm(name, description)
        }
    }
}

extension NewItemFormView: NavBarButtonDelegate {
    
    @objc func saveButtonPressed() {
        
        if let controller = formDelegate {
            controller.submitForm(getFormData())
        }
    }
}
