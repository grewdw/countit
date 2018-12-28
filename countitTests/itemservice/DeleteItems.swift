//
//  DeleteItems.swift
//  countitTests
//
//  Created by David Grew on 23/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import XCTest
import CoreData
@testable import countit

class DeleteItems: XCTestCase {
    
    var context: NSManagedObjectContext?
    var itemRepository: ItemRepository?
    var target: ItemService?
    
    let ITEM_NAME_ONE = "testItemOne"
    let ITEM_NAME_TWO = "testItemTwo"
    
    let ITEM_DESCRIPTION_ONE = "testItemDescriptionOne"
    let ITEM_DESCRIPTION_TWO = "testItemDescriptionTwo"
    
    var ITEM_ID_ONE: NSManagedObjectID?
    var ITEM_ID_TWO: NSManagedObjectID?
    
    override func setUp() {
        context = TestCoreDataConfig.getCoreDataContext()
        itemRepository = ItemRepositoryImpl(context: context!)
        target = ItemServiceImpl(itemRepository: itemRepository!)
        
        let itemOne = ItemDto(nil, ITEM_NAME_ONE, ITEM_DESCRIPTION_ONE, nil)
        let itemTwo = ItemDto(nil, ITEM_NAME_TWO, ITEM_DESCRIPTION_TWO, 0)
        let _ = target!.saveItem(itemOne)
        let _ = target!.saveItem(itemTwo)
        
        let items = target!.getItems()
        ITEM_ID_ONE = items[0].getId()
        ITEM_ID_TWO = items[1].getId()
    }
    
    override func tearDown() {
        context = nil
        itemRepository = nil
        target = nil
    }
    
    func testDeleteOneItem() {
        //        Given
        let deleteSuccessful = target!.delete(itemWithId: ITEM_ID_ONE!)
        
        //        When
        let items = target!.getItems()
        
        //        Then
        XCTAssert(deleteSuccessful)
        XCTAssert(items.count == 1)
        XCTAssert(items[0].getName() == ITEM_NAME_TWO)
        XCTAssert(items[0].getDescription() == ITEM_DESCRIPTION_TWO)
    }
    
    func testDeleteTwoItems() {
        //        Given
        let deleteOneSuccessful = target!.delete(itemWithId: ITEM_ID_ONE!)
        let deleteTwoSuccessful = target!.delete(itemWithId: ITEM_ID_TWO!)
        
        //        When
        let items = target!.getItems()
        
        //        Then
        XCTAssert(deleteOneSuccessful && deleteTwoSuccessful)
        XCTAssert(items.count == 0)
    }
    
    func testDeleteItemWhichDoesNotExistDoesNotError() {
        //        Given
        let deleteSuccessful = target!.delete(itemWithId: ITEM_ID_ONE!)
        
        //        When
        let secondDeleteSuccessful = target!.delete(itemWithId: ITEM_ID_ONE!)
        
        //        Then
        XCTAssert(deleteSuccessful && secondDeleteSuccessful)
    }
}
