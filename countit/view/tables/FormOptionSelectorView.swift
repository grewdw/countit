//
//  FormOptionSelectorView.swift
//  countit
//
//  Created by David Grew on 27/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class FormOptionSelectorView: UITableView {
    
    typealias c = Colours
    
    init(frame: CGRect, delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        super.init(frame: frame, style: .grouped)
        self.delegate = delegate
        self.dataSource = dataSource
        self.tableFooterView = UIView()
        self.backgroundColor = c.TABLE_BACKGROUND
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialiseNavBar(for controller: UIViewController) {
        NavigationItemBuilder(for: controller).build()
    }
}
