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
}
