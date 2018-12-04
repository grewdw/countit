//
//  CurrentProgressController.swift
//  countit
//
//  Created by David Grew on 03/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

class CurrentProgressController: UITableViewController {
    
    let items: [String] = ["item1", "item2", "item3"]
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = "COUNT IT"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return CurrentProgressTableCellView(items[indexPath.row])
    }
}
