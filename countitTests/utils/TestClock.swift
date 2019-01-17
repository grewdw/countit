//
//  TestClock.swift
//  countitTests
//
//  Created by David Grew on 16/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
@testable import countit

class TestClock: Clock {
    
    var date = Date()
    
    override func now() -> Date {
        return date
    }
    
    func set(date: Date) {
        self.date = date
    }
}
