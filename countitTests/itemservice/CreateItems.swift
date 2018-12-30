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

class CreateItems: XCTestCase {

    var context: NSManagedObjectContext?
    var itemRepository: ItemRepository?
    var target: ItemService?
    
    let ITEM_NAME_ONE = "testItemOne"
    let ITEM_NAME_TWO = "testItemTwo"
    let ITEM_NAME_THREE = "testItemThree"
    
    let ITEM_DESCRIPTION_ONE = "testItemDescriptionOne"
    let ITEM_DESCRIPTION_TWO = "testItemDescriptionTwo"
    let ITEM_DESCRIPTION_THREE = "testItemDescriptionThree"
    
    let COUNT_TARGET_VALUE = 5
    
    override func setUp() {
        context = TestCoreDataConfig.getCoreDataContext()
        itemRepository = ItemRepositoryImpl(context: context!)
        target = ItemServiceImpl(itemRepository: itemRepository!)
    }

    override func tearDown() {
        context = nil
        itemRepository = nil
        target = nil
    }

    func testCreateNewItem() {
//        Given
        let item = ItemDto(nil, ITEM_NAME_ONE, ITEM_DESCRIPTION_ONE, CountTargetDto(direction: .AT_LEAST, value: COUNT_TARGET_VALUE, timePeriod: .DAY), nil)
        let _ = target!.saveItem(item)
        
//        When
        let items = target!.getItems()
        
//        Then
        XCTAssert(items.count == 1)
        XCTAssert(items[0].getName() == ITEM_NAME_ONE)
        XCTAssert(items[0].getDescription() == ITEM_DESCRIPTION_ONE)
        XCTAssert(items[0].getListPosition() == 0)
    }
    
    func testCreateNewItemNoDescription() {
        //        Given
        let item = ItemDto(nil, ITEM_NAME_ONE, nil, CountTargetDto(direction: .AT_LEAST, value: COUNT_TARGET_VALUE, timePeriod: .DAY), nil)
        let _ = target!.saveItem(item)
        
        //        When
        let items = target!.getItems()
        
        //        Then
        XCTAssert(items.count == 1)
        XCTAssert(items[0].getName() == ITEM_NAME_ONE)
        XCTAssert(items[0].getDescription() == nil)
        XCTAssert(items[0].getListPosition() == 0)
    }
    
    func testCreateMultipleItems() {
        //        Given
        let itemOne = ItemDto(nil, ITEM_NAME_ONE, ITEM_DESCRIPTION_ONE, CountTargetDto(direction: .AT_LEAST, value: COUNT_TARGET_VALUE, timePeriod: .DAY), nil)
        let itemTwo = ItemDto(nil, ITEM_NAME_TWO, ITEM_DESCRIPTION_TWO, CountTargetDto(direction: .AT_LEAST, value: COUNT_TARGET_VALUE, timePeriod: .DAY), nil)
        let itemThree = ItemDto(nil, ITEM_NAME_THREE, ITEM_DESCRIPTION_THREE, CountTargetDto(direction: .AT_LEAST, value: COUNT_TARGET_VALUE, timePeriod: .DAY), nil)
        let _ = target!.saveItem(itemOne)
        let _ = target!.saveItem(itemTwo)
        let _ = target!.saveItem(itemThree)
        
        //        When
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

    func testCreateItems_ListPositionGivenAndOverwritten() {
        //        Given
        let itemOne = ItemDto(nil, ITEM_NAME_ONE, ITEM_DESCRIPTION_ONE, CountTargetDto(direction: .AT_LEAST, value: COUNT_TARGET_VALUE, timePeriod: .DAY), nil)
        let itemTwo = ItemDto(nil, ITEM_NAME_TWO, ITEM_DESCRIPTION_TWO, CountTargetDto(direction: .AT_LEAST, value: COUNT_TARGET_VALUE, timePeriod: .DAY), 0)
        let itemThree = ItemDto(nil, ITEM_NAME_THREE, ITEM_DESCRIPTION_THREE, CountTargetDto(direction: .AT_LEAST, value: COUNT_TARGET_VALUE, timePeriod: .DAY), nil)
        let _ = target!.saveItem(itemOne)
        let _ = target!.saveItem(itemTwo)
        let _ = target!.saveItem(itemThree)
        
        //        When
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
