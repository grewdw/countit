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
    let ITEM_NAME_TWO = "testItemTwo"
    let ITEM_NAME_THREE = "testItemThree"
    let ITEM_NAME_FOUR = "testItemFour"
    
    let ITEM_DESCRIPTION_ONE = "testItemDescriptionOne"
    let ITEM_DESCRIPTION_TWO = "testItemDescriptionTwo"
    let ITEM_DESCRIPTION_THREE = "testItemDescriptionThree"
    let ITEM_DESCRIPTION_FOUR = "testItemDescriptionFour"
    
    let ITEM_TARGET_DIRECTION_ONE = TargetDirection.AT_MOST
    let ITEM_TARGET_DIRECTION_TWO = TargetDirection.AT_MOST
    let ITEM_TARGET_DIRECTION_THREE = TargetDirection.AT_LEAST
    let ITEM_TARGET_DIRECTION_FOUR = TargetDirection.AT_LEAST
    
    let ITEM_TARGET_VALUE_ONE = 5
    let ITEM_TARGET_VALUE_TWO = 10
    let ITEM_TARGET_VALUE_THREE = 15
    let ITEM_TARGET_VALUE_FOUR = 20
    
    let ITEM_TARGET_TIMEPERIOD_ONE = TargetTimePeriod.MONTH
    let ITEM_TARGET_TIMEPERIOD_TWO = TargetTimePeriod.WEEK
    let ITEM_TARGET_TIMEPERIOD_THREE = TargetTimePeriod.DAY
    let ITEM_TARGET_TIMEPERIOD_FOUR = TargetTimePeriod.MONTH
    
    let ITEM_NAME_ONE_NEW = "testItemOneNew"
    let ITEM_DESCRIPTION_ONE_NEW = "testItemDescriptionOneNew"
    let ITEM_TARGET_DIRECTION_ONE_NEW = TargetDirection.AT_LEAST
    let ITEM_TARGET_VALUE_ONE_NEW = 10
    let ITEM_TARGET_TIMEPERIOD_ONE_NEW = TargetTimePeriod.WEEK
    
    let LIST_POSITION_NEW = 10
    
    override func setUp() {
        target = CommonSteps.getItemService()
    }
    
    override func tearDown() {
        target = nil
    }
    
    func createTwoItems(withService service: ItemService) {
        createItemOne(withDescription: true, usingService: service)
        createItemTwo(usingService: service)
    }
    
    func createThreeItems(withService service: ItemService) {
        createItemOne(withDescription: true, usingService: service)
        createItemTwo(usingService: service)
        createItemThree(usingService: service)
    }
    
    func createItemOne(withDescription: Bool, usingService service: ItemService) {
        let item = ItemDetailsBuilder()
            .with(name: ITEM_NAME_ONE)
            .with(direction: ITEM_TARGET_DIRECTION_ONE)
            .with(value: ITEM_TARGET_VALUE_ONE)
            .with(timePeriod: ITEM_TARGET_TIMEPERIOD_ONE)
        let itemBuilt = withDescription ? item.with(description: ITEM_DESCRIPTION_ONE).build() : item.build()
        let _ = service.saveItem(itemBuilt)
    }
    
    func createItemTwo(usingService service: ItemService) {
        let item = ItemDetailsBuilder()
            .with(name: ITEM_NAME_TWO)
            .with(description: ITEM_DESCRIPTION_TWO)
            .with(direction: ITEM_TARGET_DIRECTION_TWO)
            .with(value: ITEM_TARGET_VALUE_TWO)
            .with(timePeriod: ITEM_TARGET_TIMEPERIOD_TWO)
            .build()
        let _ = service.saveItem(item)
    }
    
    func createItemThree(usingService service: ItemService) {
        let item = ItemDetailsBuilder()
            .with(name: ITEM_NAME_THREE)
            .with(description: ITEM_DESCRIPTION_THREE)
            .with(direction: ITEM_TARGET_DIRECTION_THREE)
            .with(value: ITEM_TARGET_VALUE_THREE)
            .with(timePeriod: ITEM_TARGET_TIMEPERIOD_THREE)
            .build()
        let _ = service.saveItem(item)
    }
}
