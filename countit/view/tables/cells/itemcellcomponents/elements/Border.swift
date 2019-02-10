//
//  border.swift
//  countit
//
//  Created by David Grew on 05/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

class Border: UIView {
    
    private let CORNER_RADIUS: CGFloat = 10
    
    init() {
        super.init(frame: CGRect())
        backgroundColor = .white
        layer.cornerRadius = CORNER_RADIUS
        layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
