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

class UpdateItems: XCTestCase {
    
    var context: NSManagedObjectContext?
    var itemRepository: ItemRepository?
    var target: ItemService?
    
    let ITEM_NAME_ONE = "testItemOne"
    let ITEM_NAME_ONE_NEW = "testItemOneNew"
    
    let ITEM_NAME_TWO = "testItemTwo"
    let ITEM_NAME_THREE = "testItemThree"
    let ITEM_NAME_FOUR = "testItemFour"
    
    let ITEM_DESCRIPTION_ONE = "testItemDescriptionOne"
    let ITEM_DESCRIPTION_ONE_NEW = "testItemDescriptionOneNew"
    
    let ITEM_DESCRIPTION_TWO = "testItemDescriptionTwo"
    let ITEM_DESCRIPTION_THREE = "testItemDescriptionThree"
    let ITEM_DESCRIPTION_FOUR = "testItemDescriptionFour"
    
    var ITEM_ONE: ItemDto?
    
    override func setUp() {
        context = TestCoreDataConfig.getCoreDataContext()
        itemRepository = ItemRepositoryImpl(context: context!)
        target = ItemServiceImpl(itemRepository: itemRepository!)
        
        let itemOne = ItemDto(nil, ITEM_NAME_ONE, ITEM_DESCRIPTION_ONE, nil)
        let itemTwo = ItemDto(nil, ITEM_NAME_TWO, ITEM_DESCRIPTION_TWO, 0)
        let itemThree = ItemDto(nil, ITEM_NAME_THREE, ITEM_DESCRIPTION_THREE, nil)
        let _ = target!.saveItem(itemOne)
        let _ = target!.saveItem(itemTwo)
        let _ = target!.saveItem(itemThree)
        
        ITEM_ONE = target!.getItems()[0]
    }
    
    override func tearDown() {
        context = nil
        itemRepository = nil
        target = nil
    }
    
    func testChangeName() {
        
        //        Given
        let updatedItem = ItemDto(ITEM_ONE?.getId(), ITEM_NAME_ONE_NEW, ITEM_ONE?.getDescription(), nil)
        
        //        When
        let _ = target!.saveItem(updatedItem)
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 3)
        XCTAssert(items[0].getName() == ITEM_NAME_ONE_NEW)
        XCTAssert(items[0].getDescription() == ITEM_DESCRIPTION_ONE)
        XCTAssert(items[0].getListPosition() == 0)
    }
    
    func testChangeNameNoDescription() {
        
        //        Given
        let updatedItem = ItemDto(ITEM_ONE?.getId(), ITEM_NAME_ONE_NEW, nil, nil)
        
        //        When
        let _ = target!.saveItem(updatedItem)
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 3)
        XCTAssert(items[0].getName() == ITEM_NAME_ONE_NEW)
        XCTAssert(items[0].getDescription() == nil)
        XCTAssert(items[0].getListPosition() == 0)
    }
    
    func testChangeDescription() {
        
        //        Given
        let updatedItem = ItemDto(ITEM_ONE?.getId(), ITEM_NAME_ONE, ITEM_DESCRIPTION_ONE_NEW, nil)
        
        //        When
        let _ = target!.saveItem(updatedItem)
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 3)
        XCTAssert(items[0].getName() == ITEM_NAME_ONE)
        XCTAssert(items[0].getDescription() == ITEM_DESCRIPTION_ONE_NEW)
        XCTAssert(items[0].getListPosition() == 0)
    }
    
    func testChangeListPositionDoesNotUpdate() {
        
        //        Given
        let updatedItem = ItemDto(ITEM_ONE?.getId(), ITEM_NAME_ONE, ITEM_DESCRIPTION_ONE, 3)
        
        //        When
        let _ = target!.saveItem(updatedItem)
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 3)
        XCTAssert(items[0].getName() == ITEM_NAME_ONE)
        XCTAssert(items[0].getDescription() == ITEM_DESCRIPTION_ONE)
        XCTAssert(items[0].getListPosition() == 0)
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
        XCTAssert(items[0].getName() == ITEM_NAME_THREE)
        XCTAssert(items[0].getDescription() == ITEM_DESCRIPTION_THREE)
        XCTAssert(items[0].getListPosition() == 0)
        
        XCTAssert(items[1].getName() == ITEM_NAME_ONE)
        XCTAssert(items[1].getDescription() == ITEM_DESCRIPTION_ONE)
        XCTAssert(items[1].getListPosition() == 1)
        
        XCTAssert(items[2].getName() == ITEM_NAME_TWO)
        XCTAssert(items[2].getDescription() == ITEM_DESCRIPTION_TWO)
        XCTAssert(items[2].getListPosition() == 2)
    }
    
    func testPersistOrderChange_includesNewItem() {
        //        Given
        var initialOrderItems = target!.getItems()
        let itemFour = ItemDto(nil, ITEM_NAME_FOUR, ITEM_DESCRIPTION_FOUR, nil)
        initialOrderItems.append(itemFour)
        initialOrderItems.swapAt(0, 2)
        initialOrderItems.swapAt(1, 2)
        
        //        When
        target!.persistTableOrder(for: initialOrderItems)
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 3)
        XCTAssert(items[0].getName() == ITEM_NAME_THREE)
        XCTAssert(items[0].getDescription() == ITEM_DESCRIPTION_THREE)
        XCTAssert(items[0].getListPosition() == 0)
        
        XCTAssert(items[1].getName() == ITEM_NAME_ONE)
        XCTAssert(items[1].getDescription() == ITEM_DESCRIPTION_ONE)
        XCTAssert(items[1].getListPosition() == 1)
        
        XCTAssert(items[2].getName() == ITEM_NAME_TWO)
        XCTAssert(items[2].getDescription() == ITEM_DESCRIPTION_TWO)
        XCTAssert(items[2].getListPosition() == 2)
    }
    
    func testPersistOrderChangeWithEmptyArray() {
        
        //        Given
        let emptyItemArray: [ItemDto] = []
        
        //        When
        target!.persistTableOrder(for: emptyItemArray)
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 3)
        XCTAssert(items[0].getName() == ITEM_NAME_ONE)
        XCTAssert(items[0].getDescription() == ITEM_DESCRIPTION_ONE)
        XCTAssert(items[0].getListPosition() == 0)
        
        XCTAssert(items[1].getName() == ITEM_NAME_TWO)
        XCTAssert(items[1].getDescription() == ITEM_DESCRIPTION_TWO)
        XCTAssert(items[1].getListPosition() == 1)
        
        XCTAssert(items[2].getName() == ITEM_NAME_THREE)
        XCTAssert(items[2].getDescription() == ITEM_DESCRIPTION_THREE)
        XCTAssert(items[2].getListPosition() == 2)
    }
    
    func testPersistOrderChangeSingleItemArray() {
        
        //        Given
        let singleItemArray: [ItemDto] = [ITEM_ONE!]
        
        //        When
        target!.persistTableOrder(for: singleItemArray)
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 3)
        XCTAssert(items[0].getName() == ITEM_NAME_ONE)
        XCTAssert(items[0].getDescription() == ITEM_DESCRIPTION_ONE)
        XCTAssert(items[0].getListPosition() == 0)
        
        XCTAssert(items[1].getName() == ITEM_NAME_TWO)
        XCTAssert(items[1].getDescription() == ITEM_DESCRIPTION_TWO)
        XCTAssert(items[1].getListPosition() == 1)
        
        XCTAssert(items[2].getName() == ITEM_NAME_THREE)
        XCTAssert(items[2].getDescription() == ITEM_DESCRIPTION_THREE)
        XCTAssert(items[2].getListPosition() == 2)
    }
}
