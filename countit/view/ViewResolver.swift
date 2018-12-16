//
//  ViewResolver.swift
//  countit
//
//  Created by David Grew on 16/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import Foundation
import UIKit

class ViewResolver {
    
    func getCurrentProgressTableView(frame: CGRect) -> CurrentProgressTableView {
        return CurrentProgressTableView(frame: frame)
    }
    
    func getNewItemFormView(frame: CGRect) -> NewItemFormView {
        return NewItemFormView(frame: frame)
    }
}
