//
//  FormOptionSelectorController.swift
//  countit
//
//  Created by David Grew on 27/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class FormOptionSelectorController: UIViewController {
    
    let options: [String]
    var selectedOption: Int
    let delegate: FormCellDelegate
    let fieldName: String
    
    let FIRST_SECTION = 0
    
    init(options: [String], selectedOption: Int, delegate: FormCellDelegate, fieldName: String) {
        self.options = options
        self.selectedOption = selectedOption
        self.delegate = delegate
        self.fieldName = fieldName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let tableView = FormOptionSelectorView(frame: self.view.bounds, delegate: self, dataSource: self)
        tableView.initialiseNavBar(for: self)
        self.view = tableView
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        view = nil
    }
}

extension FormOptionSelectorController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return FormOptionSelectorCell(text: options[indexPath.row], selected: indexPath.row == selectedOption, accessibilityIdentifier: options[indexPath.row])
    }
}

extension FormOptionSelectorController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let tableView = self.view as? UITableView {
            let oldCell = tableView.cellForRow(at: IndexPath(row: selectedOption, section: FIRST_SECTION)) as? FormOptionSelectorCell
            let newCell = tableView.cellForRow(at: indexPath) as? FormOptionSelectorCell
            oldCell?.setSelected(to: false)
            newCell?.setSelected(to: true)
            selectedOption = indexPath.row
            if let cellText = newCell?.textLabel?.text {
                delegate.selectionChanged(to: cellText, for: fieldName)
            }
        }
    }
}


