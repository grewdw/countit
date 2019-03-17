//
//  FormBase.swift
//  countit
//
//  Created by David Grew on 12/03/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import UIKit

class FormBase: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var sections: [Int : [String]] = [:]
    var fieldToIndexPathMap: [String : IndexPath] = [:]
    var indexPathToFieldMap: [IndexPath : String] = [:]
    var fieldNameToValueMap: [String : Any] = [:]

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let formField: String = sections[indexPath.section]![indexPath.row]
        fieldToIndexPathMap.updateValue(indexPath, forKey: formField)
        indexPathToFieldMap.updateValue(formField, forKey: indexPath)
        return createCellFor(formField: formField)
    }
    
    func createCellFor(formField: String) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tableView = view as? UITableView
        for entry in indexPathToFieldMap {
            let cell = tableView?.cellForRow(at: entry.key)
            if entry.key != indexPath {
                cell?.endEditing(true)
            }
            else {
                let formCell = cell as? FormCell
                formCell?.selected()
            }
        }
    }
}
