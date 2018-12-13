//
//  ItemDto.swift
//  countit
//
//  Created by David Grew on 11/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import Foundation

class ItemDto {
    
    let id: ItemId?
    let name: String
    let description: String?
    
    init(_ id: ItemId?, _ name: String, _ description: String?) {
        self.id = id
        self.name = name
        self.description = description
    }
}
