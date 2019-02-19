//
//  ProgressService.swift
//  countit
//
//  Created by David Grew on 18/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation

protocol ProgressService {
    
    func getItemsProgresss() -> [ItemProgressSummaryDto]
}
