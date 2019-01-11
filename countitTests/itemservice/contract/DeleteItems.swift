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

class DeleteItems: ItemServiceContractTestBase {
    
    var ITEM_ID_ONE: NSManagedObjectID?
    var ITEM_ID_TWO: NSManagedObjectID?
    
    override func setUp() {
        target = CommonSteps.getItemService()
        
        createTwoItems(withService: target!)
        
        let items = target!.getItems()
        ITEM_ID_ONE = items[0].getItemDetailsDto().getId()
        ITEM_ID_TWO = items[1].getItemDetailsDto().getId()
    }
    
    func testDeleteOneItem() {
        //        Given
        let deleteSuccessful = target!.delete(itemWithId: ITEM_ID_ONE!)
        
        //        When
        let items = target!.getItems()
        
        //        Then
        XCTAssert(deleteSuccessful)
        assert(item: items[0], hasName: ITEM_NAME_TWO, description: ITEM_DESCRIPTION_TWO, listPosition: 1)
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
