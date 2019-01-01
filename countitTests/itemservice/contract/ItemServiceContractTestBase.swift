//
//  ItemServiceContractTestBase.swift
//  countitTests
//
//  Created by David Grew on 01/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import XCTest
@testable import countit

class ItemServiceContractTestBase: XCTestCase {
    
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
    
    let LIST_POSITION_NEW = 10
    
    override func setUp() {
        target = CommonSteps.getItemService()
    }
    
    override func tearDown() {
        target = nil
    }
    
}
