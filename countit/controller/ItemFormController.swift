//
//  NewItemFormController.swift
//  countit
//
//  Created by David Grew on 05/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit
import Foundation

class ItemFormController: UIViewController {
    
    private var formView: NewItemFormView?
    
    private let itemService: ItemService
    private let controllerResolver: ControllerResolver
    private let viewResolver: ViewResolver
    
    init(_ controllerResolver: ControllerResolver, _ viewResolver: ViewResolver, _ itemService: ItemService) {
        self.controllerResolver = controllerResolver
        self.viewResolver = viewResolver
        self.itemService = itemService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        let newItemFormView = viewResolver.getNewItemFormView(frame: self.view.bounds)
        newItemFormView.initialiseNavBar(for: self)
        newItemFormView.formDelegate = self
        self.formView = newItemFormView
        self.view = newItemFormView
    }
}

extension ItemFormController: FormController {
    
    func submitForm(_ form: Form) {
        let itemForm = form as! NewItemForm
        if itemService.saveItem(ItemDto(itemForm.getId(), itemForm.getName()!, itemForm.getDescription())) {
            let navController = controllerResolver.get(ControllerType.PRIMARY_NAV_CONTROLLER) as? UINavigationController
            navController?.popViewController(animated: true)
            formView?.clearForm()
        }
    }
    
    func cancelForm() {
    }
    
    func buttonPressed(_ button: NavBarButtonType) {
    }
}
