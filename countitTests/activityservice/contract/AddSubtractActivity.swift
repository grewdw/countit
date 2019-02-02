//
//  AddSubtractActivity.swift
//  countitTests
//
//  Created by David Grew on 17/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import XCTest
@testable import countit

class AddSubtractActivity: ActivityServiceTestBase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testRecordActivity() {
        runTestWith(recordActivityDate: [TODAY], subtractActivityDate: nil, testDate: TODAY, TimePeriod: .DAY, expectedCount: 1)
    }
    
    func testSubtractActivity() {
        runTestWith(recordActivityDate: [TODAY], subtractActivityDate: [TODAY], testDate: TODAY, TimePeriod: .DAY, expectedCount: 0)
    }
    
    func testSubtractActivityLeavesRemaidner() {
        runTestWith(recordActivityDate: [TODAY, ONE_SECOND_AFTER_DAY_START], subtractActivityDate: [ONE_SECOND_BEFORE_DAY_END], testDate: TODAY, TimePeriod: .DAY, expectedCount: 1)
    }
    
    func testSubtractActivityDoesNotBecomeNegative_noRecordedActivity() {
        runTestWith(recordActivityDate: nil, subtractActivityDate: [TODAY], testDate: TODAY, TimePeriod: .DAY, expectedCount: 0)
    }
    
    func testSubtractActivityDoesNotBecomeNegative_noRecordedActivityInCurrentWindow_Day() {
        runTestWith(recordActivityDate: [YESTERDAY], subtractActivityDate: [TODAY], testDate: TODAY, TimePeriod: .DAY, expectedCount: 0)
    }
    
    func testSubtractActivityDoesNotBecomeNegative_noRecordedActivityInCurrentWindow_Week() {
        runTestWith(recordActivityDate: [LAST_WEEK], subtractActivityDate: [TODAY], testDate: TODAY, TimePeriod: .WEEK, expectedCount: 0)
    }
    
    func testSubtractActivityDoesNotBecomeNegative_noRecordedActivityInCurrentWindow_Month() {
        runTestWith(recordActivityDate: [LAST_MONTH], subtractActivityDate: [TODAY], testDate: TODAY, TimePeriod: .MONTH, expectedCount: 0)
    }
    
    func runTestWith(recordActivityDate: [String]?, subtractActivityDate: [String]?, testDate: String, TimePeriod: TargetTimePeriod, expectedCount: Int) {
        createItem(withTargetTimePeriod: TimePeriod)
        if let record = recordActivityDate {
            recordActivity(withTimestamps: record)
        }
        if let subtract = subtractActivityDate {
            subtractActivity(withTimestamps: subtract)
        }
        assertItemProgressCountAt(date: testDate, expectedCount: expectedCount)
    }
}
