//
//  countitTests.swift
//  countitTests
//
//  Created by David Grew on 03/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import XCTest
import CoreData
@testable import countit

class CreateItems: ItemServiceContractTestBase {

    func testCreateNewItem() {
//        Given
        createItemOne(withDescription: true, usingService: target!)
        
//        When
        let items = target!.getItems()
        
//        Then
        XCTAssert(items.count == 1)
        assert(item: items[0], hasName: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, listPosition: 0)
        assertTargetFor(item: items[0], hasDirection: ITEM_TARGET_DIRECTION_ONE, value: ITEM_TARGET_VALUE_ONE, timePeriod: ITEM_TARGET_TIMEPERIOD_ONE)
    }
    
    func testCreateNewItemNoDescription() {
        //        Given
        createItemOne(withDescription: false, usingService: target!)
        
        //        When
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 1)
        assert(item: items[0], hasName: ITEM_NAME_ONE, description: nil, listPosition: 0)
        assertTargetFor(item: items[0], hasDirection: ITEM_TARGET_DIRECTION_ONE, value: ITEM_TARGET_VALUE_ONE, timePeriod: ITEM_TARGET_TIMEPERIOD_ONE)
    }

    func testCreateMultipleItems() {
        //        Given
        createThreeItems(withService: target!)
        
        //        When
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 3)
        assert(item: items[0], hasName: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, listPosition: 0)
        assertTargetFor(item: items[0], hasDirection: ITEM_TARGET_DIRECTION_ONE, value: ITEM_TARGET_VALUE_ONE, timePeriod: ITEM_TARGET_TIMEPERIOD_ONE)
        assert(item: items[1], hasName: ITEM_NAME_TWO, description: ITEM_DESCRIPTION_TWO, listPosition: 1)
        assertTargetFor(item: items[1], hasDirection: ITEM_TARGET_DIRECTION_TWO, value: ITEM_TARGET_VALUE_TWO, timePeriod: ITEM_TARGET_TIMEPERIOD_TWO)
        assert(item: items[2], hasName: ITEM_NAME_THREE, description: ITEM_DESCRIPTION_THREE, listPosition: 2)
        assertTargetFor(item: items[2], hasDirection: ITEM_TARGET_DIRECTION_THREE, value: ITEM_TARGET_VALUE_THREE, timePeriod: ITEM_TARGET_TIMEPERIOD_THREE)
    }

    func testCreateItems_ListPositionGivenAndOverwritten() {
        //        Given
        createTwoItems(withService: target!)
        let incorrectListPositionItem = ItemDetailsBuilder().with(name: ITEM_NAME_THREE).with(description: ITEM_DESCRIPTION_THREE).with(listPosition: 20).build()
        let _ = target!.saveItem(incorrectListPositionItem)
        
        //        When
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 3)
        assert(item: items[0], hasName: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, listPosition: 0)
        assertTargetFor(item: items[0], hasDirection: ITEM_TARGET_DIRECTION_ONE, value: ITEM_TARGET_VALUE_ONE, timePeriod: ITEM_TARGET_TIMEPERIOD_ONE)
        assert(item: items[1], hasName: ITEM_NAME_TWO, description: ITEM_DESCRIPTION_TWO, listPosition: 1)
        assertTargetFor(item: items[1], hasDirection: ITEM_TARGET_DIRECTION_TWO, value: ITEM_TARGET_VALUE_TWO, timePeriod: ITEM_TARGET_TIMEPERIOD_TWO)
        assert(item: items[2], hasName: ITEM_NAME_THREE, description: ITEM_DESCRIPTION_THREE, listPosition: 2)
    }
}
