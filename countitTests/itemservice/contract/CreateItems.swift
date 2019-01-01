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
        let item = ItemBuilder().with(name: ITEM_NAME_ONE).with(description: ITEM_DESCRIPTION_ONE).build()
        let _ = target!.saveItem(item)
        
//        When
        let items = target!.getItems()
        
//        Then
        XCTAssert(items.count == 1)
        assert(item: items[0], hasName: ITEM_NAME_ONE, description: ITEM_DESCRIPTION_ONE, listPosition: 0)
    }
    
    func testCreateNewItemNoDescription() {
        //        Given
        let item = ItemBuilder().with(name: ITEM_NAME_ONE).build()
        let _ = target!.saveItem(item)
        
        //        When
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 1)
        assert(item: items[0], hasName: ITEM_NAME_ONE, description: nil, listPosition: 0)
    }
    
    func testCreateMultipleItems() {
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

    func testCreateItems_ListPositionGivenAndOverwritten() {
        //        Given
        let itemOne = ItemBuilder().with(name: ITEM_NAME_ONE).with(description: ITEM_DESCRIPTION_ONE).build()
        let itemTwo = ItemBuilder().with(name: ITEM_NAME_TWO).with(description: ITEM_DESCRIPTION_TWO).with(listPosition: 0).build()
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
}
