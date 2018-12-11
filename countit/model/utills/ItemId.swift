//
//  ItemId.swift
//  countit
//
//  Created by David Grew on 11/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import Foundation

class ItemId {
    
    var id: Int32
    
    init (id: Int32) {
        self.id = id
    }
    
    func get() -> Int32 {
        return id
    }
}
