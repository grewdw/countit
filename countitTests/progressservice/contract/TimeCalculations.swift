//
//  TimeCalculations.swift
//  countitTests
//
//  Created by David Grew on 19/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import XCTest
import Foundation
@testable import countit

class TimeCalculations: ProgressServiceTestBase {
    
    func testDay_DayStart() {
        createItem(withTargetTimePeriod: .DAY)
        
        assertItemHas(overrallDuration: dateIntervalOf(start: DAY_START_EXACT, end: DAY_END_EXACT),
                      at: DAY_START_EXACT)
        assertItemHas(elapsedDuration: dateIntervalOf(start: DAY_START_EXACT, end: DAY_START_EXACT),
                      at: DAY_START_EXACT)
        assertItemHas(remainingDuration: dateIntervalOf(start: DAY_START_EXACT, end: DAY_END_EXACT),
                      at: DAY_START_EXACT)
    }
    
    func testDay_SecondAfterDayStart() {
        createItem(withTargetTimePeriod: .DAY)
        
        assertItemHas(overrallDuration: dateIntervalOf(start: DAY_START_EXACT, end: DAY_END_EXACT),
                      at: ONE_SECOND_AFTER_DAY_START)
        assertItemHas(elapsedDuration: dateIntervalOf(start: DAY_START_EXACT, end: ONE_SECOND_AFTER_DAY_START),
                      at: ONE_SECOND_AFTER_DAY_START)
        assertItemHas(remainingDuration: dateIntervalOf(start: ONE_SECOND_AFTER_DAY_START, end: DAY_END_EXACT),
                      at: ONE_SECOND_AFTER_DAY_START)
    }
    
    func testDay_SecondBeforeDayEnd() {
        createItem(withTargetTimePeriod: .DAY)
        
        assertItemHas(overrallDuration: dateIntervalOf(start: DAY_START_EXACT, end: DAY_END_EXACT),
                      at: ONE_SECOND_BEFORE_DAY_END)
        assertItemHas(elapsedDuration: dateIntervalOf(start: DAY_START_EXACT, end: ONE_SECOND_BEFORE_DAY_END),
                      at: ONE_SECOND_BEFORE_DAY_END)
        assertItemHas(remainingDuration: dateIntervalOf(start: ONE_SECOND_BEFORE_DAY_END, end: DAY_END_EXACT),
                      at: ONE_SECOND_BEFORE_DAY_END)
    }
    
    func testWeek_WeekStart() {
        createItem(withTargetTimePeriod: .WEEK)
        
        assertItemHas(overrallDuration: dateIntervalOf(start: WEEK_START_EXACT, end: WEEK_END_EXACT),
                      at: WEEK_START_EXACT)
        assertItemHas(elapsedDuration: dateIntervalOf(start: WEEK_START_EXACT, end: WEEK_START_EXACT),
                      at: WEEK_START_EXACT)
        assertItemHas(remainingDuration: dateIntervalOf(start: WEEK_START_EXACT, end: WEEK_END_EXACT),
                      at: WEEK_START_EXACT)
    }
    
    func testWeek_SecondAfterWeekStart() {
        createItem(withTargetTimePeriod: .WEEK)
        
        assertItemHas(overrallDuration: dateIntervalOf(start: WEEK_START_EXACT, end: WEEK_END_EXACT),
                      at: ONE_SECOND_AFTER_WEEK_START)
        assertItemHas(elapsedDuration: dateIntervalOf(start: WEEK_START_EXACT, end: ONE_SECOND_AFTER_WEEK_START),
                      at: ONE_SECOND_AFTER_WEEK_START)
        assertItemHas(remainingDuration: dateIntervalOf(start: ONE_SECOND_AFTER_WEEK_START, end: WEEK_END_EXACT),
                      at: ONE_SECOND_AFTER_WEEK_START)
    }
    
    func testWeek_SecondBeforeWeekEnd() {
        createItem(withTargetTimePeriod: .WEEK)
        
        assertItemHas(overrallDuration: dateIntervalOf(start: WEEK_START_EXACT, end: WEEK_END_EXACT),
                      at: ONE_SECOND_BEFORE_WEEK_END)
        assertItemHas(elapsedDuration: dateIntervalOf(start: WEEK_START_EXACT, end: ONE_SECOND_BEFORE_WEEK_END),
                      at: ONE_SECOND_BEFORE_WEEK_END)
        assertItemHas(remainingDuration: dateIntervalOf(start: ONE_SECOND_BEFORE_WEEK_END, end: WEEK_END_EXACT),
                      at: ONE_SECOND_BEFORE_WEEK_END)
    }
    
    func testWeek_MonthStart() {
        createItem(withTargetTimePeriod: .MONTH)
        
        assertItemHas(overrallDuration: dateIntervalOf(start: MONTH_START_EXACT, end: MONTH_END_EXACT),
                      at: MONTH_START_EXACT)
        assertItemHas(elapsedDuration: dateIntervalOf(start: MONTH_START_EXACT, end: MONTH_START_EXACT),
                      at: MONTH_START_EXACT)
        assertItemHas(remainingDuration: dateIntervalOf(start: MONTH_START_EXACT, end: MONTH_END_EXACT),
                      at: MONTH_START_EXACT)
    }
    
    func testWeek_SecondAfterMonthStart() {
        createItem(withTargetTimePeriod: .MONTH)
        
        assertItemHas(overrallDuration: dateIntervalOf(start: MONTH_START_EXACT, end: MONTH_END_EXACT),
                      at: ONE_SECOND_AFTER_MONTH_START)
        assertItemHas(elapsedDuration: dateIntervalOf(start: MONTH_START_EXACT, end: ONE_SECOND_AFTER_MONTH_START),
                      at: ONE_SECOND_AFTER_MONTH_START)
        assertItemHas(remainingDuration: dateIntervalOf(start: ONE_SECOND_AFTER_MONTH_START, end: MONTH_END_EXACT),
                      at: ONE_SECOND_AFTER_MONTH_START)
    }
    
    func testWeek_SecondBeforeMonthEnd() {
        createItem(withTargetTimePeriod: .MONTH)
        
        assertItemHas(overrallDuration: dateIntervalOf(start: MONTH_START_EXACT, end: MONTH_END_EXACT),
                      at: ONE_SECOND_BEFORE_MONTH_END)
        assertItemHas(elapsedDuration: dateIntervalOf(start: MONTH_START_EXACT, end: ONE_SECOND_BEFORE_MONTH_END),
                      at: ONE_SECOND_BEFORE_MONTH_END)
        assertItemHas(remainingDuration: dateIntervalOf(start: ONE_SECOND_BEFORE_MONTH_END, end: MONTH_END_EXACT),
                      at: ONE_SECOND_BEFORE_MONTH_END)
    }

    private func dateIntervalOf(start: String, end: String) -> DateInterval {
        return DateInterval(start: timeStampStringToDate(timestamp: start)!,
                            end: timeStampStringToDate(timestamp: end)!)
    }
}
