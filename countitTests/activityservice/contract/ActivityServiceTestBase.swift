//
//  ActivityServiceTestBase.swift
//  countitTests
//
//  Created by David Grew on 16/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import XCTest
@testable import countit
import CoreData

class ActivityServiceTestBase: XCTestCase {

    let ITEM_NAME = "itemName"
    let TARGET_DIRECTION = TargetDirection.AT_LEAST
    let TARGET_VALUE = 5
    let TARGET_TIME_PERIOD = TargetTimePeriod.WEEK
    
    let TODAY = "16-01-2019 10:00:00"
    
    let YESTERDAY = "15-01-2019 10:00:00"
    let TOMORROW = "17-01-2019 10:00:00"
    
    let LAST_WEEK = "09-01-2019 10:00:00"
    let NEXT_WEEK = "23-01-2019 10:00:00"
    
    let LAST_MONTH = "16-12-2018 10:00:00"
    let NEXT_MONTH = "16-02-2019 10:00:00"
    
    let ONE_SECOND_AFTER_DAY_START = "16-01-2019 00:00:01"
    let DAY_START_EXACT = "16-01-2019 00:00:00"
    let ONE_SECOND_BEFORE_DAY_START = "15-01-2019 23:59:59"
    let ONE_SECOND_AFTER_DAY_END = "17-01-2019 00:00:01"
    let DAY_END_EXACT = "17-01-2019 00:00:00"
    let ONE_SECOND_BEFORE_DAY_END = "16-01-2019 23:59:59"
    
    let ONE_SECOND_AFTER_WEEK_START = "13-01-2019 00:00:01"
    let WEEK_START_EXACT = "13-01-2019 00:00:00"
    let ONE_SECOND_BEFORE_WEEK_START = "12-01-2019 23:59:59"
    let ONE_SECOND_AFTER_WEEK_END = "20-01-2019 00:00:01"
    let WEEK_END_EXACT = "20-01-2019 00:00:00"
    let ONE_SECOND_BEFORE_WEEK_END = "19-01-2019 23:59:59"
    
    let ONE_SECOND_AFTER_MONTH_START = "01-01-2019 00:00:01"
    let MONTH_START_EXACT = "01-01-2019 00:00:00"
    let ONE_SECOND_BEFORE_MONTH_START = "31-12-2018 23:59:59"
    let ONE_SECOND_AFTER_MONTH_END = "01-02-2019 00:00:01"
    let MONTH_END_EXACT = "01-02-2019 00:00:00"
    let ONE_SECOND_BEFORE_MONTH_END = "31-01-2019 23:59:59"
    
    let clock = TestClock()
    var activityService: ActivityService?
    var itemService: ItemService?
    var item: ItemDetailsDto?
    
    override func setUp() {
        let serviceConfig = ServiceConfig(clock: clock)
        itemService = serviceConfig.getItemService()
        activityService = serviceConfig.getActivityService()
    }
    
    override func tearDown() {
        activityService = nil
        itemService = nil
        item = nil
    }

    func testDay_secondAfterDayStart() {
        runTestForTodayWith(timePeriod: .DAY, activityTimestamps: [ONE_SECOND_AFTER_DAY_START], expectedCount: 1)
    }
    
    func testDay_DayStartExact() {
        runTestForTodayWith(timePeriod: .DAY, activityTimestamps: [DAY_START_EXACT], expectedCount: 1)
    }
    
    func testDay_secondBeforeDayStart() {
        runTestForTodayWith(timePeriod: .DAY, activityTimestamps: [ONE_SECOND_BEFORE_DAY_START], expectedCount: 0)
        runTestFor(date: YESTERDAY, expectedCount: 1)
    }
    
    func testDay_secondAfterDayEnd() {
        runTestForTodayWith(timePeriod: .DAY, activityTimestamps: [ONE_SECOND_AFTER_DAY_END], expectedCount: 0)
        runTestFor(date: TOMORROW, expectedCount: 1)
    }
    
    func testDay_DayEndExact() {
        runTestForTodayWith(timePeriod: .DAY, activityTimestamps: [DAY_END_EXACT], expectedCount: 0)
        runTestFor(date: TOMORROW, expectedCount: 1)
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
        runTestFor(date: TOMORROW, expectedCount: 2)
        runTestFor(date: YESTERDAY, expectedCount: 1)
    }
    
    func testWeek_secondAfterWeekStart() {
        runTestForTodayWith(timePeriod: .WEEK, activityTimestamps: [ONE_SECOND_AFTER_WEEK_START], expectedCount: 1)
    }
    
    func testWeek_WeekStartExact() {
        runTestForTodayWith(timePeriod: .WEEK, activityTimestamps: [WEEK_START_EXACT], expectedCount: 1)
    }
    
    func testWeek_secondBeforeWeekStart() {
        runTestForTodayWith(timePeriod: .WEEK, activityTimestamps: [ONE_SECOND_BEFORE_WEEK_START], expectedCount: 0)
        runTestFor(date: LAST_WEEK, expectedCount: 1)
    }
    
    func testWeek_secondAfterWeekEnd() {
        runTestForTodayWith(timePeriod: .WEEK, activityTimestamps: [ONE_SECOND_AFTER_WEEK_END], expectedCount: 0)
        runTestFor(date: NEXT_WEEK, expectedCount: 1)
    }
    
    func testWeek_WeekEndExact() {
        runTestForTodayWith(timePeriod: .WEEK, activityTimestamps: [WEEK_END_EXACT], expectedCount: 0)
        runTestFor(date: NEXT_WEEK, expectedCount: 1)
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
        runTestFor(date: NEXT_WEEK, expectedCount: 2)
        runTestFor(date: LAST_WEEK, expectedCount: 1)
    }
    
    func testMonth_secondAfterMonthStart() {
        runTestForTodayWith(timePeriod: .MONTH, activityTimestamps: [ONE_SECOND_AFTER_MONTH_START], expectedCount: 1)
    }
    
    func testMonth_MonthStartExact() {
        runTestForTodayWith(timePeriod: .MONTH, activityTimestamps: [MONTH_START_EXACT], expectedCount: 1)
    }
    
    func testMonth_secondBeforeMonthStart() {
        runTestForTodayWith(timePeriod: .MONTH, activityTimestamps: [ONE_SECOND_BEFORE_MONTH_START], expectedCount: 0)
        runTestFor(date: LAST_MONTH, expectedCount: 1)
    }
    
    func testMonth_secondAfterMonthEnd() {
        runTestForTodayWith(timePeriod: .MONTH, activityTimestamps: [ONE_SECOND_AFTER_MONTH_END], expectedCount: 0)
        runTestFor(date: NEXT_MONTH, expectedCount: 1)
    }
    
    func testMonth_MonthEndExact() {
        runTestForTodayWith(timePeriod: .MONTH, activityTimestamps: [MONTH_END_EXACT], expectedCount: 0)
        runTestFor(date: NEXT_MONTH, expectedCount: 1)
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
        runTestFor(date: NEXT_MONTH, expectedCount: 2)
        runTestFor(date: LAST_MONTH, expectedCount: 1)
    }
    
    private func runTestForTodayWith(timePeriod: TargetTimePeriod, activityTimestamps: [String], expectedCount: Int) {
        createItem(withTargetTimePeriod: timePeriod)
        recordActivity(withTimestamps: activityTimestamps)
        
        runTestFor(date: TODAY, expectedCount: expectedCount)
    }
    
    private func runTestFor(date: String, expectedCount: Int) {
        clock.set(date: timeStampStringToDate(timestamp: date)!)
        let itemSummary = activityService!.getCurrentTargetProgressFor(item: item!)
        
        XCTAssertEqual(itemSummary.getActivityCount(), expectedCount)
    }

    private func createItem(withTargetTimePeriod timePeriod: TargetTimePeriod) {
        let newItem = ItemDetailsDto(nil, ITEM_NAME, nil, TARGET_DIRECTION, TARGET_VALUE, timePeriod, nil)
        _ = itemService!.saveItem(newItem)
        item = itemService!.getItems()[0].getItemDetailsDto()
    }
    
    private func recordActivity(withTimestamps timestamps: [String]) {
        for timestamp in timestamps {
            if let date = timeStampStringToDate(timestamp: timestamp) {
                clock.set(date: date)
                let _ = activityService?.record(activityUpdate: ActivityUpdateDto(item: item!, value: 1))
            }
        }
    }
    
    private func timeStampStringToDate(timestamp: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        return dateFormatter.date(from: timestamp)
    }
    
    private func getAllTimeStamps() -> [String] {
        return [ONE_SECOND_AFTER_DAY_START,
                DAY_START_EXACT,
                ONE_SECOND_BEFORE_DAY_START,
                ONE_SECOND_AFTER_DAY_END,
                DAY_END_EXACT,
                ONE_SECOND_BEFORE_DAY_END,
                ONE_SECOND_AFTER_WEEK_START,
                WEEK_START_EXACT,
                ONE_SECOND_BEFORE_WEEK_START,
                ONE_SECOND_AFTER_WEEK_END,
                WEEK_END_EXACT,
                ONE_SECOND_BEFORE_WEEK_END,
                ONE_SECOND_AFTER_MONTH_START,
                MONTH_START_EXACT,
                ONE_SECOND_BEFORE_MONTH_START,
                ONE_SECOND_AFTER_MONTH_END,
                MONTH_END_EXACT,
                ONE_SECOND_BEFORE_MONTH_END]
    }
}
