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
    
    private var formView: FormView?
    
    private let itemService: ItemService
    private let controllerResolver: ControllerResolver
    
    override func viewDidLoad() {
        let newItemFormView = NewItemFormView(frame: self.view.bounds)
        newItemFormView.initialiseNavBar(for: self)
        newItemFormView.formDelegate = self
        self.formView = newItemFormView
        self.view = newItemFormView
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

extension ItemFormController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        print("will show")
    }
}
