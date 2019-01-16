//
//  UpdateItems.swift
//  countitTests
//
//  Created by David Grew on 23/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import XCTest
import CoreData
@testable import countit

class UpdateItems: ItemServiceContractTestBase {
    
    var ITEM_ONE_SUMMARY: ItemSummaryDto?
    var ITEM_ONE_DETAILS: ItemDetailsDto?
    
    override func setUp() {
        target = ServiceConfig(clock: clock).getItemService()
        
        createThreeItems(withService: target!)
        
        ITEM_ONE_SUMMARY = target!.getItems()[0]
        ITEM_ONE_DETAILS = target!.getItems()[0].getItemDetailsDto()
    }
    
    func testChangeName() {
        
        //        Given
        let updatedItem = ItemDetailsBuilder()
            .with(id: (ITEM_ONE_DETAILS?.getId())!)
            .with(name: ITEM_NAME_ONE_NEW)
            .with(description: (ITEM_ONE_DETAILS?.getDescription())!)
            .with(direction: (ITEM_ONE_DETAILS?.getDirection())!)
            .with(value: (ITEM_ONE_DETAILS?.getValue())!)
            .with(timePeriod: (ITEM_ONE_DETAILS?.getTimePeriod())!)
            .build()
        
        //        When
        let _ = target!.saveItem(updatedItem)
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 3)
        assert(item: items[0], hasName: ITEM_NAME_ONE_NEW, description: ITEM_DESCRIPTION_ONE, listPosition: 0)
        assertTargetFor(item: items[0], hasDirection: ITEM_TARGET_DIRECTION_ONE, value: ITEM_TARGET_VALUE_ONE, timePeriod: ITEM_TARGET_TIMEPERIOD_ONE)
    }
    
    func testChangeNameNoDescription() {
        
        //        Given
        let updatedItem = ItemDetailsBuilder()
            .with(id: (ITEM_ONE_DETAILS?.getId())!)
            .with(name: ITEM_NAME_ONE_NEW)
            .with(direction: (ITEM_ONE_DETAILS?.getDirection())!)
            .with(value: (ITEM_ONE_DETAILS?.getValue())!)
            .with(timePeriod: (ITEM_ONE_DETAILS?.getTimePeriod())!)
            .build()
        
        //        When
        let _ = target!.saveItem(updatedItem)
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 3)
        assert(item: items[0], hasName: ITEM_NAME_ONE_NEW, description: nil, listPosition: 0)
        assertTargetFor(item: items[0], hasDirection: ITEM_TARGET_DIRECTION_ONE, value: ITEM_TARGET_VALUE_ONE, timePeriod: ITEM_TARGET_TIMEPERIOD_ONE)
    }
    
    func testChangeDescription() {
        
        //        Given
        let updatedItem = ItemDetailsBuilder()
            .with(id: (ITEM_ONE_DETAILS?.getId())!)
            .with(name: (ITEM_ONE_DETAILS?.getName())!)
            .with(description: ITEM_DESCRIPTION_ONE_NEW)
            .with(direction: (ITEM_ONE_DETAILS?.getDirection())!)
            .with(value: (ITEM_ONE_DETAILS?.getValue())!)
            .with(timePeriod: (ITEM_ONE_DETAILS?.getTimePeriod())!)
            .build()
        
        //        When
        let _ = target!.saveItem(updatedItem)
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 3)
        assert(item: items[0], hasName: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE_NEW, listPosition: 0)
        assertTargetFor(item: items[0], hasDirection: ITEM_TARGET_DIRECTION_ONE, value: ITEM_TARGET_VALUE_ONE, timePeriod: ITEM_TARGET_TIMEPERIOD_ONE)
    }
    
    func testChangeTargetValueUpdates() {
        
        //        Given
        let updatedItem = ItemDetailsBuilder()
            .with(id: (ITEM_ONE_DETAILS?.getId())!)
            .with(name: (ITEM_ONE_DETAILS?.getName())!)
            .with(description: (ITEM_ONE_DETAILS?.getDescription())!)
            .with(direction: (ITEM_ONE_DETAILS?.getDirection())!)
            .with(value: ITEM_TARGET_VALUE_ONE_NEW)
            .with(timePeriod: (ITEM_ONE_DETAILS?.getTimePeriod())!)
            .build()
        
        //        When
        let _ = target!.saveItem(updatedItem)
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 3)
        assert(item: items[0], hasName: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, listPosition: 0)
        assertTargetFor(item: items[0], hasDirection: ITEM_TARGET_DIRECTION_ONE, value: ITEM_TARGET_VALUE_ONE_NEW, timePeriod: ITEM_TARGET_TIMEPERIOD_ONE)
    }
    
    func testChangeTargetTimePeriodDoesNotUpdateWithValueChange() {
        
        //        Given
        let updatedItem = ItemDetailsBuilder()
            .with(id: (ITEM_ONE_DETAILS?.getId())!)
            .with(name: (ITEM_ONE_DETAILS?.getName())!)
            .with(description: (ITEM_ONE_DETAILS?.getDescription())!)
            .with(direction: (ITEM_ONE_DETAILS?.getDirection())!)
            .with(value: ITEM_TARGET_VALUE_ONE_NEW)
            .with(timePeriod: ITEM_TARGET_TIMEPERIOD_ONE_NEW)
            .build()
        
        //        When
        let _ = target!.saveItem(updatedItem)
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 3)
        assert(item: items[0], hasName: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, listPosition: 0)
        assertTargetFor(item: items[0], hasDirection: ITEM_TARGET_DIRECTION_ONE, value: ITEM_TARGET_VALUE_ONE_NEW, timePeriod: ITEM_TARGET_TIMEPERIOD_ONE)
    }
    
    func testChangeTargetTimePeriodDoesNotUpdateWithoutValueChange() {
        
        //        Given
        let updatedItem = ItemDetailsBuilder()
            .with(id: (ITEM_ONE_DETAILS?.getId())!)
            .with(name: (ITEM_ONE_DETAILS?.getName())!)
            .with(description: (ITEM_ONE_DETAILS?.getDescription())!)
            .with(direction: (ITEM_ONE_DETAILS?.getDirection())!)
            .with(value: (ITEM_ONE_DETAILS?.getValue())!)
            .with(timePeriod: ITEM_TARGET_TIMEPERIOD_ONE_NEW)
            .build()
        
        //        When
        let _ = target!.saveItem(updatedItem)
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 3)
        assert(item: items[0], hasName: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, listPosition: 0)
        assertTargetFor(item: items[0], hasDirection: ITEM_TARGET_DIRECTION_ONE, value: ITEM_TARGET_VALUE_ONE, timePeriod: ITEM_TARGET_TIMEPERIOD_ONE)
    }
    
    func testChangeTargetDirectionDoesNotUpdateWithValueChange() {
        
        //        Given
        let updatedItem = ItemDetailsBuilder()
            .with(id: (ITEM_ONE_DETAILS?.getId())!)
            .with(name: (ITEM_ONE_DETAILS?.getName())!)
            .with(description: (ITEM_ONE_DETAILS?.getDescription())!)
            .with(direction: ITEM_TARGET_DIRECTION_ONE_NEW)
            .with(value: ITEM_TARGET_VALUE_ONE_NEW)
            .with(timePeriod: (ITEM_ONE_DETAILS?.getTimePeriod())!)
            .build()
        
        //        When
        let _ = target!.saveItem(updatedItem)
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 3)
        assert(item: items[0], hasName: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, listPosition: 0)
        assertTargetFor(item: items[0], hasDirection: ITEM_TARGET_DIRECTION_ONE, value: ITEM_TARGET_VALUE_ONE_NEW, timePeriod: ITEM_TARGET_TIMEPERIOD_ONE)
    }
    
    func testChangeTargetDirectionDoesNotUpdateWithoutValueChange() {
        
        //        Given
        let updatedItem = ItemDetailsBuilder()
            .with(id: (ITEM_ONE_DETAILS?.getId())!)
            .with(name: (ITEM_ONE_DETAILS?.getName())!)
            .with(description: (ITEM_ONE_DETAILS?.getDescription())!)
            .with(direction: ITEM_TARGET_DIRECTION_ONE_NEW)
            .with(value: (ITEM_ONE_DETAILS?.getValue())!)
            .with(timePeriod: (ITEM_ONE_DETAILS?.getTimePeriod())!)
            .build()
        
        //        When
        let _ = target!.saveItem(updatedItem)
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 3)
        assert(item: items[0], hasName: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, listPosition: 0)
        assertTargetFor(item: items[0], hasDirection: ITEM_TARGET_DIRECTION_ONE, value: ITEM_TARGET_VALUE_ONE, timePeriod: ITEM_TARGET_TIMEPERIOD_ONE)
    }
    
    func testChangeListPositionDoesNotUpdate() {
        
        //        Given
        let updatedItem = ItemDetailsBuilder()
            .with(id: (ITEM_ONE_DETAILS?.getId())!)
            .with(name: (ITEM_ONE_DETAILS?.getName())!)
            .with(description: (ITEM_ONE_DETAILS?.getDescription())!)
            .with(direction: (ITEM_ONE_DETAILS?.getDirection())!)
            .with(value: (ITEM_ONE_DETAILS?.getValue())!)
            .with(timePeriod: (ITEM_ONE_DETAILS?.getTimePeriod())!)
            .with(listPosition: LIST_POSITION_NEW)
            .build()
        
        //        When
        let _ = target!.saveItem(updatedItem)
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 3)
        assert(item: items[0], hasName: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, listPosition: 0)
    }
    
    func testPersistOrderChange() {
        
        //        Given
        var initialOrderItems = target!.getItems()
        initialOrderItems.swapAt(0, 2)
        initialOrderItems.swapAt(1, 2)
        
        //        When
        target!.persistTableOrder(for: initialOrderItems)
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 3)
        assert(item: items[0], hasName: ITEM_NAME_THREE, description: ITEM_DESCRIPTION_THREE, listPosition: 0)
        assert(item: items[1], hasName: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, listPosition: 1)
        assert(item: items[2], hasName: ITEM_NAME_TWO, description: ITEM_DESCRIPTION_TWO, listPosition: 2)
    }
    
    func testPersistOrderChange_includesNewItem() {
        //        Given
        var initialOrderItems = target!.getItems()
        let itemFour = ItemSummaryBuilder().with(name: ITEM_NAME_FOUR).with(description: ITEM_DESCRIPTION_FOUR).build()
        initialOrderItems.append(itemFour)
        initialOrderItems.swapAt(0, 2)
        initialOrderItems.swapAt(1, 2)
        
        //        When
        target!.persistTableOrder(for: initialOrderItems)
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 3)
        assert(item: items[0], hasName: ITEM_NAME_THREE, description: ITEM_DESCRIPTION_THREE, listPosition: 0)
        assert(item: items[1], hasName: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, listPosition: 1)
        assert(item: items[2], hasName: ITEM_NAME_TWO, description: ITEM_DESCRIPTION_TWO, listPosition: 2)
    }
    
    func testPersistOrderChangeWithEmptyArray() {
        
        //        Given
        let emptyItemArray: [ItemSummaryDto] = []
        
        //        When
        target!.persistTableOrder(for: emptyItemArray)
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 3)
        assert(item: items[0], hasName: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, listPosition: 0)
        assert(item: items[1], hasName: ITEM_NAME_TWO, description: ITEM_DESCRIPTION_TWO, listPosition: 1)
        assert(item: items[2], hasName: ITEM_NAME_THREE, description: ITEM_DESCRIPTION_THREE, listPosition: 2)
    }
    
    func testPersistOrderChangeSingleItemArray() {
        
        //        Given
        let singleItemArray: [ItemSummaryDto] = [ITEM_ONE_SUMMARY!]
        
        //        When
        target!.persistTableOrder(for: singleItemArray)
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 3)
        assert(item: items[0], hasName: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, listPosition: 0)
        assert(item: items[1], hasName: ITEM_NAME_TWO, description: ITEM_DESCRIPTION_TWO, listPosition: 1)
        assert(item: items[2], hasName: ITEM_NAME_THREE, description: ITEM_DESCRIPTION_THREE, listPosition: 2)
    }
}
