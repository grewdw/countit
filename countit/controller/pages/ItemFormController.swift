//
//  ItemFormController.swift
//  countit
//
//  Created by David Grew on 08/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import Foundation

protocol ItemFormController: class {
    
    func submitForm()
    
    func with(item: ItemDetailsDto)
}
