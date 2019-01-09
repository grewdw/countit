//
//  ReadItems.swift
//  countitTests
//
//  Created by David Grew on 23/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import XCTest
import CoreData
@testable import countit

class ReadItems: ItemServiceContractTestBase {

    func testGetSingleItemOneExists() {
        
        //        Given
        createItemOne(withDescription: true, usingService: target!)
        
        let itemId = target!.getItems()[0].getItemDetailsDto().getId()!
        
        //        When
        let item = target!.getItem(id: itemId)
        
        //        Then
        assert(item: item!, hasName: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, listPosition: 0)
        assertTargetFor(item: item!, hasDirection: ITEM_TARGET_DIRECTION_ONE, value: ITEM_TARGET_VALUE_ONE, timePeriod: ITEM_TARGET_TIMEPERIOD_ONE)
    }
    
    func testGetSingleItemMultipleExist() {

        //        Given
        createThreeItems(withService: target!)
        
        let itemId = target!.getItems()[1].getItemDetailsDto().getId()!
        
        //        When
        let item = target!.getItem(id: itemId)
        
        //        Then
        assert(item: item!, hasName: ITEM_NAME_TWO, description: ITEM_DESCRIPTION_TWO, listPosition: 1)
        assertTargetFor(item: item!, hasDirection: ITEM_TARGET_DIRECTION_TWO, value: ITEM_TARGET_VALUE_TWO, timePeriod: ITEM_TARGET_TIMEPERIOD_TWO)
    }
    
    func testGetSingleItemNoneExist() {
        //        Given
        createItemOne(withDescription: true, usingService: target!)
        let itemId = target!.getItems()[0].getItemDetailsDto().getId()!
        let _ = target!.delete(itemWithId: itemId)
        
        //        When
        let item = target!.getItem(id: itemId)
        
        //        Then
        XCTAssert(item == nil)
    }
    
    func testGetMultipleItemsOneExists() {
        
        //        Given
        createItemOne(withDescription: true, usingService: target!)
        
        //        When
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 1)
        assert(item: items[0], hasName: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, listPosition: 0)
        assertTargetFor(item: items[0], hasDirection: ITEM_TARGET_DIRECTION_ONE, value: ITEM_TARGET_VALUE_ONE, timePeriod: ITEM_TARGET_TIMEPERIOD_ONE)
    }
    
    func testGetMultipleItemsMultipleExist() {
        
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

    func testGetItemsNoneExist() {
        
        //        When
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 0)
    }
}
