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
    
    func assert(item: ItemDetailsDto, hasName: String?, description: String?, listPosition: Int?) {
        
        XCTAssert(item.getName() == hasName)
        XCTAssert(item.getDescription() == description)
        XCTAssert(item.getListPosition() == listPosition)
    }
    
    func assertTargetFor(item: ItemDetailsDto, hasDirection direction: TargetDirection, value: Int, timePeriod: TargetTimePeriod) {
        XCTAssert(item.getDirection() == direction)
        XCTAssert(item.getValue() == value)
        XCTAssert(item.getTimePeriod() == timePeriod)
    }
}
