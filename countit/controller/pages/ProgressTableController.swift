//
//  ProgressTableController.swift
//  countit
//
//  Created by David Grew on 08/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import Foundation
import CoreData

protocol ProgressTableController {
    
    func buttonPressed(_ button: NavBarButtonType)
    
    func recordActivityButtonPressedFor(item: ItemDetailsDto)
    
    func subtractActivityButtonPressedFor(item: ItemDetailsDto)
}
