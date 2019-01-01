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
        let itemOne = ItemBuilder().with(name: ITEM_NAME_ONE).with(description: ITEM_DESCRIPTION_ONE).build()
        let _ = target!.saveItem(itemOne)
        
        let itemId = target!.getItems()[0].getId()!
        
        //        When
        let item = target!.getItem(id: itemId)
        
        //        Then
        XCTAssert(item!.getName() == ITEM_NAME_ONE)
        XCTAssert(item!.getDescription() == ITEM_DESCRIPTION_ONE)
    }
    
    func testGetSingleItemMultipleExist() {

        //        Given
        let itemOne = ItemBuilder().with(name: ITEM_NAME_ONE).with(description: ITEM_DESCRIPTION_ONE).build()
        let itemTwo = ItemBuilder().with(name: ITEM_NAME_TWO).with(description: ITEM_DESCRIPTION_TWO).build()
        let itemThree = ItemBuilder().with(name: ITEM_NAME_THREE).with(description: ITEM_DESCRIPTION_THREE).build()
        let _ = target!.saveItem(itemOne)
        let _ = target!.saveItem(itemTwo)
        let _ = target!.saveItem(itemThree)
        
        let itemId = target!.getItems()[1].getId()!
        
        //        When
        let item = target!.getItem(id: itemId)
        
        //        Then
        assert(item: item!, hasName: ITEM_NAME_TWO, description: ITEM_DESCRIPTION_TWO, listPosition: 1)
    }
    
    func testGetSingleItemNoneExist() {
        //        Given
        let itemOne = ItemBuilder().with(name: ITEM_NAME_ONE).with(description: ITEM_DESCRIPTION_ONE).build()
        let _ = target!.saveItem(itemOne)
        let itemId = target!.getItems()[0].getId()!
        let _ = target!.delete(itemWithId: itemId)
        
        //        When
        let item = target!.getItem(id: itemId)
        
        //        Then
        XCTAssert(item == nil)
    }
    
    func testGetMultipleItemsOneExists() {
        
        //        Given
        let itemOne = ItemBuilder().with(name: ITEM_NAME_ONE).with(description: ITEM_DESCRIPTION_ONE).build()
        let _ = target!.saveItem(itemOne)
        
        //        When
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 1)
        assert(item: items[0], hasName: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, listPosition: 0)
    }
    
    func testGetMultipleItemsMultipleExist() {
        
        //        Given
        let itemOne = ItemBuilder().with(name: ITEM_NAME_ONE).with(description: ITEM_DESCRIPTION_ONE).build()
        let itemTwo = ItemBuilder().with(name: ITEM_NAME_TWO).with(description: ITEM_DESCRIPTION_TWO).build()
        let itemThree = ItemBuilder().with(name: ITEM_NAME_THREE).with(description: ITEM_DESCRIPTION_THREE).build()
        let _ = target!.saveItem(itemOne)
        let _ = target!.saveItem(itemTwo)
        let _ = target!.saveItem(itemThree)
        
        //        When
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 3)
        assert(item: items[0], hasName: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, listPosition: 0)
        assert(item: items[1], hasName: ITEM_NAME_TWO, description: ITEM_DESCRIPTION_TWO, listPosition: 1)
        assert(item: items[2], hasName: ITEM_NAME_THREE, description: ITEM_DESCRIPTION_THREE, listPosition: 2)
    }

    func testGetItemsNoneExist() {
        
        //        When
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 0)
    }
}
