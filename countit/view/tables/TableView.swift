//
//  TableView.swift
//  countit
//
//  Created by David Grew on 08/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import UIKit

protocol TableView {
    
    var tableDelegate: TableController? { get set }
    
    func initialiseNavBar(for controller: TableController)
}
