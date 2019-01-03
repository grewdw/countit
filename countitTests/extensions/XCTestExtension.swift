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
    
    func assert(item: ItemDto, hasName: String?, description: String?, listPosition: Int?) {
        
        XCTAssert(item.getName() == hasName)
        XCTAssert(item.getDescription() == description)
        XCTAssert(item.getListPosition() == listPosition)
    }
    
    func assertTargetFor(item: ItemDto, hasDirection direction: TargetDirection, value: Int, timePeriod: TargetTimePeriod) {
        let targetDto = item.getTargetDto()
        XCTAssert(targetDto.getDirection() == direction)
        XCTAssert(targetDto.getValue() == value)
        XCTAssert(targetDto.getTimePeriod() == timePeriod)
    }
}
