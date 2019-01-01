//
//  TargetBuilder.swift
//  countitTests
//
//  Created by David Grew on 01/01/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import CoreData
@testable import countit

class TargetBuilder {
    
    private var direction: TargetDirection
    private var value: Int
    private var timePeriod: TargetTimePeriod
    
    init() {
        self.direction = .AT_LEAST
        self.value = 1
        self.timePeriod = .DAY
    }
    
    func with(direction: TargetDirection) -> TargetBuilder {
        self.direction = direction
        return self
    }
    
    func with(value: Int) -> TargetBuilder {
        self.value = value
        return self
    }
    
    func with(timePeriod: TargetTimePeriod) -> TargetBuilder {
        self.timePeriod = timePeriod
        return self
    }
    
    func build() -> TargetDto {
        return TargetDto(direction: direction, value: value, timePeriod: timePeriod)
    }
}
