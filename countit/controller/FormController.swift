//
//  FormController.swift
//  countit
//
//  Created by David Grew on 08/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import Foundation

protocol FormController {
    
    func submitForm(_ Form: Form)
    
    func with(item: ItemDto)
    
    func cancelForm()
    
    func buttonPressed(_ button: NavBarButtonType)
}
