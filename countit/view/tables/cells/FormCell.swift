//
//  FormCell.swift
//  countit
//
//  Created by David Grew on 28/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation

protocol FormCell {
    
    func setValue(to value: String)
    
    func selected()
}
