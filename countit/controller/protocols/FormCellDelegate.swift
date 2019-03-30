//
//  FormCellDelegate.swift
//  countit
//
//  Created by David Grew on 28/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import UIKit

protocol FormCellDelegate: class {
    
    func wasSelected(fieldName: String)
    
    func selectionChanged(to selection: Any, for fieldName: String)
    
    func transitionTo(cellController: UIViewController)
}
