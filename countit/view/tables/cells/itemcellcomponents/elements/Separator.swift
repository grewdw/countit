//
//  Separator.swift
//  countit
//
//  Created by David Grew on 09/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class Separator: UIView {
    
    init(width: CGFloat) {
        super.init(frame: CGRect())
        layer.borderWidth = width
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
