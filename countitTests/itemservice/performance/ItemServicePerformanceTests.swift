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
    let newItem = ItemDto(nil, "newItem", nil, nil)
    
    let UPDATED_ITEM_NAME = "updatedItemName"
    
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
        self.measure {
            
        }
        items = target!.getItems()
    }
    
    func testGetItem() {
        self.measure {
            let _ = target!.getItem(id: item!.getId()!)
        }
    }
    
    func testUpdateItem() {
        self.measure {
            let _ = target!.saveItem(updatedItem!)
        }
    }
    
    func testDeleteItem() {
        self.measure {
            let _ = target!.delete(itemWithId: itemId!)
        }
    }
    
    func testCreateItem() {
        self.measure {
            let _ = target!.saveItem(newItem)
        }
    }
    
    private func dataLoadItem(number: Int) {
        let _ = target!.saveItem(ItemDto(nil, "item" + String(number), nil, nil))
    }
    
    private func updateTestVariables() {
        items = target!.getItems()
        if let itemArray = items {
            item = itemArray[itemArray.count-1]
            updatedItem = ItemDto(item?.getId(), UPDATED_ITEM_NAME, item?.getDescription(), item?.getListPosition())
            itemId = item!.getId()
        }
    }
}
