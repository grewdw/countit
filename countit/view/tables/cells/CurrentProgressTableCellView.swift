//
//  CurrentProgressTableCellView.swift
//  countit
//
//  Created by David Grew on 03/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

class CurrentProgressTableCellView: UITableViewCell {
    
    var name = UILabel()
    
    let CELL_SPACING_TOP: CGFloat = 10
    let CELL_SPACING_BOTTOM: CGFloat = -10
    
    convenience init(_ itemName: String) {
        self.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "currentProgressCell")
        initialiseNameField(itemName)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialiseNameField(_ itemName: String) {
        self.addSubview(name)
        name.text = itemName
        name.numberOfLines = 0
        name.textAlignment = .center
        
        name.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            name.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2/3),
            name.topAnchor.constraint(equalTo: self.topAnchor, constant: CELL_SPACING_TOP),
            name.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: CELL_SPACING_BOTTOM),
            name.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

