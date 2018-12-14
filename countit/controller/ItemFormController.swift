//
//  NewItemFormController.swift
//  countit
//
//  Created by David Grew on 05/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

class ItemFormController: UIViewController {
    
    private let itemService: ItemService
    private let controllerResolver: ControllerResolver
    
    override func viewDidLoad() {
        let newItemFormView = NewItemFormView(frame: self.view.bounds)
        newItemFormView.initialiseNavBar(for: self)
        newItemFormView.formDelegate = self
        self.view.addSubview(newItemFormView)
    }
    
    init(_ controllerResolver: ControllerResolver, _ itemService: ItemService) {
        self.controllerResolver = controllerResolver
        self.itemService = itemService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ItemFormController: FormController {
    
    func submitForm(_ form: Form) {
        if let itemForm = validateForm(form: form) {
            itemService.saveItem(ItemDto(itemForm.getId(), itemForm.getName()!, itemForm.getDescription()))
        }
    }
    
    private func validateForm(form: Form) -> NewItemForm? {
        if let itemForm = form as? NewItemForm {
            return itemForm.isValid() ? itemForm : nil
        }
        else {
            return nil
        }
    }
    
    func cancelForm() {
    }
    
    func buttonPressed(_ button: NavBarButtonType) {
    }
}
