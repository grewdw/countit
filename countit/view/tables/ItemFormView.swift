//
//  ItemFormView.swift
//  countit
//
//  Created by David Grew on 28/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class ItemFormView: UITableView {
    
    private weak var formController: ItemFormController?
    
    init(frame: CGRect, delegate: UITableViewDelegate, dataSource: UITableViewDataSource, formController: ItemFormController) {
        self.formController = formController
        super.init(frame: frame, style: .grouped)
        self.delegate = delegate
        self.dataSource = dataSource
        self.accessibilityIdentifier = AccessibilityIdentifiers.ITEM_FORM_TABLE
        keyboardDismissMode = .onDrag
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ItemFormView: NavBarButtonDelegate {
    
    func initialiseNavBar(for controller: UIViewController) {
        NavigationItemBuilder(for: controller)
            .with(rightButton: .DONE, forTarget: self)
            .with(title: "itemForm")
            .build()
    }
    
    @objc func doneButtonPressed() {
        formController?.submitForm()
    }
}
