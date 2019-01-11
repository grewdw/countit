//
//  XCTestExtension.swift
//  countitTests
//
//  Created by David Grew on 01/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import XCTest
import CoreData
@testable import countit

extension XCTestCase {
    
    func assert(item: ItemSummaryDto, hasName: String?, description: String?, listPosition: Int?) {
        
        XCTAssert(item.getItemDetailsDto().getName() == hasName)
        XCTAssert(item.getItemDetailsDto().getDescription() == description)
        XCTAssert(item.getItemDetailsDto().getListPosition() == listPosition)
    }
    
    func assertTargetFor(item: ItemSummaryDto, hasDirection direction: TargetDirection, value: Int, timePeriod: TargetTimePeriod) {
        XCTAssert(item.getItemDetailsDto().getDirection() == direction)
        XCTAssert(item.getItemDetailsDto().getValue() == value)
        XCTAssert(item.getItemDetailsDto().getTimePeriod() == timePeriod)
    }
}
