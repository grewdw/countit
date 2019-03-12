//
//  NewCount.swift
//  countit
//
//  Created by David Grew on 07/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import CoreData

class ActivityUpdateDto {
    
    private let item: ItemDetailsDto
    private let value: Int
    private let timestamp: Date?
    
    init(item: ItemDetailsDto, value: Int, timestamp: Date?) {
        self.item = item
        self.value = value
        self.timestamp = timestamp
    }
    
    func getItem() -> ItemDetailsDto {
        return item
    }
    
    func getValue() -> Int {
        return value
    }
    
    func getTimestamp() -> Date? {
        return timestamp
    }
}
