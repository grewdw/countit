//
//  ItemSummaryDto.swift
//  countit
//
//  Created by David Grew on 07/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation

class ItemSummaryDto {
    
    private let itemDetailsDto: ItemDetailsDto
    private let activityCount: Int
    
    init(itemDetailsDto: ItemDetailsDto, activityCount: Int) {
        self.itemDetailsDto = itemDetailsDto
        self.activityCount = activityCount
    }
    
    func getItemDetailsDto() -> ItemDetailsDto {
        return itemDetailsDto
    }
    
    func getActivityCount() -> Int {
        return activityCount
    }
}
