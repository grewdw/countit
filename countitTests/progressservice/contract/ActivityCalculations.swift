//
//  CalculateProgressTimings.swift
//  countitTests
//
//  Created by David Grew on 17/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import XCTest
@testable import countit

class ActivityCalculations: ProgressServiceTestBase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testDay_secondAfterDayStart() {
        runTestForTodayWith(timePeriod: .DAY, activityTimestamps: [ONE_SECOND_AFTER_DAY_START], expectedCount: 1)
    }
    
    func testDay_DayStartExact() {
        runTestForTodayWith(timePeriod: .DAY, activityTimestamps: [DAY_START_EXACT], expectedCount: 1)
    }
    
    func testDay_secondBeforeDayStart() {
        runTestForTodayWith(timePeriod: .DAY, activityTimestamps: [ONE_SECOND_BEFORE_DAY_START], expectedCount: 0)
        assertItemProgressCountAt(date: YESTERDAY, expectedCount: 1)
    }
    
    func testDay_secondAfterDayEnd() {
        runTestForTodayWith(timePeriod: .DAY, activityTimestamps: [ONE_SECOND_AFTER_DAY_END], expectedCount: 0)
        assertItemProgressCountAt(date: TOMORROW, expectedCount: 1)
    }
    
    func testDay_DayEndExact() {
        runTestForTodayWith(timePeriod: .DAY, activityTimestamps: [DAY_END_EXACT], expectedCount: 0)
        assertItemProgressCountAt(date: TOMORROW, expectedCount: 1)
    }
    
    func testDay_secondBeforeDayEnd() {
        runTestForTodayWith(timePeriod: .DAY, activityTimestamps: [ONE_SECOND_BEFORE_DAY_END], expectedCount: 1)
    }
    
    func testDay_multipleRecordsWithinDay() {
        runTestForTodayWith(timePeriod: .DAY, activityTimestamps: [ONE_SECOND_AFTER_DAY_START, DAY_START_EXACT, ONE_SECOND_BEFORE_DAY_END], expectedCount: 3)
    }
    
    func testDay_multipleRecordsNotAllWithinDay() {
        runTestForTodayWith(timePeriod: .DAY, activityTimestamps: [ONE_SECOND_AFTER_DAY_START, DAY_START_EXACT, ONE_SECOND_BEFORE_DAY_START, ONE_SECOND_BEFORE_DAY_END], expectedCount: 3)
    }
    
    func testDay_complextTest() {
        runTestForTodayWith(timePeriod: .DAY, activityTimestamps: getAllTimeStamps(), expectedCount: 3)
        self.assertItemProgressCountAt(date: TOMORROW, expectedCount: 2)
        self.assertItemProgressCountAt(date: YESTERDAY, expectedCount: 1)
    }
    
    func testWeek_secondAfterWeekStart() {
        runTestForTodayWith(timePeriod: .WEEK, activityTimestamps: [ONE_SECOND_AFTER_WEEK_START], expectedCount: 1)
    }
    
    func testWeek_WeekStartExact() {
        runTestForTodayWith(timePeriod: .WEEK, activityTimestamps: [WEEK_START_EXACT], expectedCount: 1)
    }
    
    func testWeek_secondBeforeWeekStart() {
        runTestForTodayWith(timePeriod: .WEEK, activityTimestamps: [ONE_SECOND_BEFORE_WEEK_START], expectedCount: 0)
        assertItemProgressCountAt(date: LAST_WEEK, expectedCount: 1)
    }
    
    func testWeek_secondAfterWeekEnd() {
        runTestForTodayWith(timePeriod: .WEEK, activityTimestamps: [ONE_SECOND_AFTER_WEEK_END], expectedCount: 0)
        assertItemProgressCountAt(date: NEXT_WEEK, expectedCount: 1)
    }
    
    func testWeek_WeekEndExact() {
        runTestForTodayWith(timePeriod: .WEEK, activityTimestamps: [WEEK_END_EXACT], expectedCount: 0)
        assertItemProgressCountAt(date: NEXT_WEEK, expectedCount: 1)
    }
    
    func testWeek_secondBeforeWeekEnd() {
        runTestForTodayWith(timePeriod: .WEEK, activityTimestamps: [ONE_SECOND_BEFORE_WEEK_END], expectedCount: 1)
    }
    
    func testWeek_multipleRecordsWithinWeek() {
        runTestForTodayWith(timePeriod: .WEEK, activityTimestamps: [ONE_SECOND_AFTER_WEEK_START, WEEK_START_EXACT, ONE_SECOND_BEFORE_WEEK_END], expectedCount: 3)
    }
    
    func testWeek_multipleRecordsNotAllWithinWeek() {
        runTestForTodayWith(timePeriod: .WEEK, activityTimestamps: [ONE_SECOND_AFTER_WEEK_START, WEEK_START_EXACT, ONE_SECOND_BEFORE_WEEK_START, ONE_SECOND_BEFORE_WEEK_END], expectedCount: 3)
    }
    
    func testWeek_complextTest() {
        runTestForTodayWith(timePeriod: .WEEK, activityTimestamps: getAllTimeStamps(), expectedCount: 9)
        assertItemProgressCountAt(date: NEXT_WEEK, expectedCount: 2)
        assertItemProgressCountAt(date: LAST_WEEK, expectedCount: 1)
    }
    
    func testMonth_secondAfterMonthStart() {
        runTestForTodayWith(timePeriod: .MONTH, activityTimestamps: [ONE_SECOND_AFTER_MONTH_START], expectedCount: 1)
    }
    
    func testMonth_MonthStartExact() {
        runTestForTodayWith(timePeriod: .MONTH, activityTimestamps: [MONTH_START_EXACT], expectedCount: 1)
    }
    
    func testMonth_secondBeforeMonthStart() {
        runTestForTodayWith(timePeriod: .MONTH, activityTimestamps: [ONE_SECOND_BEFORE_MONTH_START], expectedCount: 0)
        assertItemProgressCountAt(date: LAST_MONTH, expectedCount: 1)
    }
    
    func testMonth_secondAfterMonthEnd() {
        runTestForTodayWith(timePeriod: .MONTH, activityTimestamps: [ONE_SECOND_AFTER_MONTH_END], expectedCount: 0)
        assertItemProgressCountAt(date: NEXT_MONTH, expectedCount: 1)
    }
    
    func testMonth_MonthEndExact() {
        runTestForTodayWith(timePeriod: .MONTH, activityTimestamps: [MONTH_END_EXACT], expectedCount: 0)
        assertItemProgressCountAt(date: NEXT_MONTH, expectedCount: 1)
    }
    
    func testMonth_secondBeforeMonthEnd() {
        runTestForTodayWith(timePeriod: .MONTH, activityTimestamps: [ONE_SECOND_BEFORE_MONTH_END], expectedCount: 1)
    }
    
    func testMonth_multipleRecordsWithinMonth() {
        runTestForTodayWith(timePeriod: .MONTH, activityTimestamps: [ONE_SECOND_AFTER_MONTH_START, MONTH_START_EXACT, ONE_SECOND_BEFORE_MONTH_END], expectedCount: 3)
    }
    
    func testMonth_multipleRecordsNotAllWithinMonth() {
        runTestForTodayWith(timePeriod: .MONTH, activityTimestamps: [ONE_SECOND_AFTER_MONTH_START, MONTH_START_EXACT, ONE_SECOND_BEFORE_MONTH_START, ONE_SECOND_BEFORE_MONTH_END], expectedCount: 3)
    }
    
    func testMonth_complextTest() {
        runTestForTodayWith(timePeriod: .MONTH, activityTimestamps: getAllTimeStamps(), expectedCount: 15)
        assertItemProgressCountAt(date: NEXT_MONTH, expectedCount: 2)
        assertItemProgressCountAt(date: LAST_MONTH, expectedCount: 1)
    }
    
    private func runTestForTodayWith(timePeriod: TargetTimePeriod, activityTimestamps: [String], expectedCount: Int) {
        createItem(withTargetTimePeriod: timePeriod)
        recordActivity(withTimestamps: activityTimestamps)
        
        assertItemProgressCountAt(date: TODAY, expectedCount: expectedCount)
    }
}
