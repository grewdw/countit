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
        name.textAlignment = NSTextAlignment.center
        name.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0, enableInsets: true)
    }
}

