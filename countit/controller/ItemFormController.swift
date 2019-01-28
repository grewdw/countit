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
    
    private var selectedItem: ItemDetailsDto?
    
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
        instantiateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        instantiateView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        selectedItem = nil
        view = nil
    }
    
    private func instantiateView() {
        let form = selectedItem != nil ? ItemForm(selectedItem!) : nil
        let newItemFormView = viewResolver.getNewItemFormView(frame: self.view.bounds, form: form)
        newItemFormView.initialiseNavBar(for: self)
        newItemFormView.formDelegate = self
        self.formView = newItemFormView
        self.view = newItemFormView
    }
}

extension ItemFormController: FormController {
    
    func submitForm() {
        
    }
    
    func with(item: ItemDetailsDto) {
        selectedItem = item
    }
}
