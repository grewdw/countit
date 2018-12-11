//
//  NewItemFormController.swift
//  countit
//
//  Created by David Grew on 05/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

class ItemFormController: UIViewController {
    
    private final let itemService: ItemService
    
    init(itemService: ItemService) {
        self.itemService = itemService
        super.init(nibName: nil, bundle: nil)
        self.view.addSubview(NewItemFormView(frame: self.view.bounds))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
