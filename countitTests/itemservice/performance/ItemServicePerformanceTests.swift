//
//  ItemServicePerformanceTest.swift
//  countitTests
//
//  Created by David Grew on 28/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import XCTest
import CoreData
@testable import countit

class ItemServicePerformanceTests: XCTestCase {

    var context: NSManagedObjectContext?
    var itemRepository: ItemRepository?
    var clock: Clock?
    var target: ItemService?
    
    var items: [ItemSummaryDto]?
    var item: ItemDetailsDto?
    var updatedItem: ItemDetailsDto?
    var updatedTargetItem: ItemDetailsDto?
    var updatedTargetAndNameItem: ItemDetailsDto?
    var itemId: NSManagedObjectID?
    let newItem = ItemDetailsDto(nil, "newItem", nil, TargetDirection.AT_LEAST, 5, TargetTimePeriod.DAY, nil)
    
    let UPDATED_ITEM_NAME = "updatedItemName"
    
    var counter: Int = 0
    
    override func setUp() {
        let context = TestCoreDataConfig.getCoreDataContext()
        clock = Clock()
        let activityRepository = ActivityRepositoryImpl(context: context)
        let activityService = ActivityServiceImpl(activityRepository: activityRepository, clock: clock!)
        itemRepository = ItemRepositoryImpl(context: context)
        target = ItemServiceImpl(activityService: activityService, itemRepository: itemRepository!, clock: clock!)
        
        for count in 1...1000 {
            dataLoadItem(number: count)
        }
        
        updateTestVariables()
    }

    override func tearDown() {
        context = nil
        itemRepository = nil
        target = nil
        items = nil
        item = nil
        updatedItem = nil
        itemId = nil
    }

    func testGetItems() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false, for: {
            updateTestVariables()
            startMeasuring()
            items = target!.getItems()
            stopMeasuring()
        })
    }
    
    func testGetItem() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false, for: {
            updateTestVariables()
            startMeasuring()
            let _ = target!.getItem(id: item!.getId()!)
            stopMeasuring()
        })
    }
    
    func testUpdateItem() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false, for: {
            updateTestVariables()
            startMeasuring()
            let _ = target!.saveItem(updatedItem!)
            stopMeasuring()
        })
    }
    
    func testUpdateTarget() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false, for: {
            updateTestVariables()
            startMeasuring()
            let _ = target!.saveItem(updatedTargetItem!)
            stopMeasuring()
        })
    }
    
    func testUpdateTargetAndName() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false, for: {
            updateTestVariables()
            startMeasuring()
            let _ = target!.saveItem(updatedTargetAndNameItem!)
            stopMeasuring()
        })
    }
    
    func testDeleteItem() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false, for: {
            updateTestVariables()
            startMeasuring()
            let _ = target!.delete(itemWithId: itemId!)
            stopMeasuring()
        })
    }
    
    func testCreateItem() {
        self.measureMetrics([.wallClockTime], automaticallyStartMeasuring: false, for: {
            updateTestVariables()
            startMeasuring()
            let _ = target!.saveItem(newItem)
            stopMeasuring()
        })
    }
    
    private func dataLoadItem(number: Int) {
        let _ = target!.saveItem(ItemDetailsDto(nil, "item" + String(number), nil, .AT_LEAST, 5, .DAY, nil))
    }
    
    private func updateTestVariables() {
        items = target!.getItems()
        if let itemArray = items {
            item = itemArray[itemArray.count-1].getItemDetailsDto()
            updatedItem = ItemDetailsDto(item?.getId(), UPDATED_ITEM_NAME + String(counter), item?.getDescription(), (item?.getDirection())!, (item?.getValue())!, (item?.getTimePeriod())!, item?.getListPosition())
            updatedTargetItem = ItemDetailsDto(item?.getId(), item!.getName() + String(counter), item?.getDescription(), .AT_LEAST, 5 + counter, .DAY, item?.getListPosition())
            updatedTargetAndNameItem = ItemDetailsDto(item?.getId(), UPDATED_ITEM_NAME + String(counter), item?.getDescription(), .AT_LEAST, 5 + counter, .DAY, item?.getListPosition())
            itemId = item!.getId()
            counter += 1
        }
    }
}
