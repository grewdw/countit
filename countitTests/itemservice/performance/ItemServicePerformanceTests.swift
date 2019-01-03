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
    var target: ItemService?
    
    var items: [ItemDto]?
    var item: ItemDto?
    var updatedItem: ItemDto?
    var itemId: NSManagedObjectID?
    let countTarget = TargetDto(direction: TargetDirection.AT_LEAST, value: 5, timePeriod: TargetTimePeriod.DAY)
    let newItem = ItemDto(nil, "newItem", nil, TargetDto(direction: TargetDirection.AT_LEAST, value: 5, timePeriod: TargetTimePeriod.DAY), nil)
    
    let UPDATED_ITEM_NAME = "updatedItemName"
    
    var counter: Int = 0
    
    override func setUp() {
        context = TestCoreDataConfig.getCoreDataContext()
        itemRepository = ItemRepositoryImpl(context: context!)
        target = ItemServiceImpl(itemRepository: itemRepository!)
        
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
        let _ = target!.saveItem(ItemDto(nil, "item" + String(number), nil, countTarget, nil))
    }
    
    private func updateTestVariables() {
        items = target!.getItems()
        if let itemArray = items {
            item = itemArray[itemArray.count-1]
            updatedItem = ItemDto(item?.getId(), UPDATED_ITEM_NAME + String(counter), item?.getDescription(), item?.getTargetDto() ?? countTarget, item?.getListPosition())
            itemId = item!.getId()
            counter += 1
        }
    }
}
