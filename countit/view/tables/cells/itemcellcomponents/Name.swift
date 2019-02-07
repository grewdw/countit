//
//  NameRow.swift
//  countit
//
//  Created by David Grew on 05/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class Name: UILabel {
    
    init(name: String) {
        super.init(frame: CGRect())
//        text = name
//        font = UIFont.systemFont(ofSize: 18)
        attributedText = NSAttributedString(
            string: name,
            attributes:[
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.underlineStyle: 1.0
            ])
        textAlignment = .center
        numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

