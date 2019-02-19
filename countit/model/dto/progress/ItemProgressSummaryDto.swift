//
//  ItemSummaryDto.swift
//  countit
//
//  Created by David Grew on 07/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation

class ItemProgressSummaryDto {
    
    private let itemDetailsDto: ItemDetailsDto
    private let activityPeriodSummaryDto: ActivityPeriodSummaryDto
    
    init(itemDetailsDto: ItemDetailsDto, periodSummary: ActivityPeriodSummaryDto) {
        self.itemDetailsDto = itemDetailsDto
        self.activityPeriodSummaryDto = periodSummary
    }
    
    func getItemDetailsDto() -> ItemDetailsDto {
        return itemDetailsDto
    }
    
    func getActivityPeriodSummaryDto() -> ActivityPeriodSummaryDto {
        return activityPeriodSummaryDto
    }
}
