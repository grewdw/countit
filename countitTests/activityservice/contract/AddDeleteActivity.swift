//
//  AddSubtractActivity.swift
//  countitTests
//
//  Created by David Grew on 17/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import XCTest
@testable import countit

class AddDeleteActivity: ActivityServiceTestBase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testRecordActivity() {
        createItem(withTargetTimePeriod: .DAY)
        recordActivity(withTimestamps: [TODAY])
        assertNumberOfActivityRecords(is: 1)
    }
    
    func testRecordActivityWithCustomValue() {
        createItem(withTargetTimePeriod: .DAY)
        recordActivity(withValue: 4, withCustomTimestamps: [TODAY], withNote: nil)
        assertActivityRecordHas(value: 4, timestamp: TODAY, note: nil)
    }
    
    func testRecordActivityCustomTimestamp() {
        createItem(withTargetTimePeriod: .DAY)
        recordActivity(withValue: nil, withCustomTimestamps: [TODAY], withNote: nil)
        assertActivityRecordHas(value: 1, timestamp: TODAY, note: nil)
    }
    
    func testRecordActivityWithNote() {
        createItem(withTargetTimePeriod: .DAY)
        recordActivity(withValue: nil, withCustomTimestamps: [TODAY], withNote: "newNote")
        assertActivityRecordHas(value: 1, timestamp: TODAY, note: "newNote")
    }
    
    func testDeleteActivity() {
        createItem(withTargetTimePeriod: .DAY)
        recordActivity(withTimestamps: [LAST_WEEK, LAST_MONTH, YESTERDAY])
        assertNumberOfActivityRecords(is: 3)
        deleteActivity(number: 3)
        assertNumberOfActivityRecords(is: 2)
        deleteActivity(number: 2)
        assertNumberOfActivityRecords(is: 1)
        deleteActivity(number: 1)
        assertNumberOfActivityRecords(is: 0)
    }
}
