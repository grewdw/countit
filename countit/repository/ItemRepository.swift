//
//  ItemRepository.swift
//  countit
//
//  Created by David Grew on 11/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import Foundation

protocol ItemRepository {
    
    func saveItem(itemDto: ItemDto) -> Bool
}
