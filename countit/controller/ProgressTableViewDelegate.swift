//
//  TableController.swift
//  countit
//
//  Created by David Grew on 08/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import Foundation
import CoreData

protocol ProgressTableViewDelegate {
    
    func buttonPressed(_ button: NavBarButtonType)
    
    func recordActivityButtonPressedFor(item: NSManagedObjectID)
}
