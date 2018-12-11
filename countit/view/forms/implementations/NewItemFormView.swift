//
//  NewItemFormView.swift
//  countit
//
//  Created by David Grew on 05/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

class NewItemFormView: UIScrollView, FormView {
   
    typealias formType = NewItemForm
    
    var formDelegate: FormController?
    var editable: Bool = false
  
    let nameField: TextFieldView
    let descriptionField: TextFieldView
    
    override init(frame: CGRect) {
       
        nameField = TextFieldViewBuilder(frame: .zero)
            .withFieldName("Name")
            .withFieldText("").build()
        nameField.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionField = TextFieldViewBuilder(frame: .zero)
            .withFieldName("Description")
            .withFieldText("Enter description here").build()
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getForm() -> formType {
        return NewItemForm()
    }
    
    func updateForm(_ form: formType) {
        
    }
    
    func clearForm() {
        
    }
}
