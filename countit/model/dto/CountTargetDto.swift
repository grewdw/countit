//
//  CountTargetDto.swift
//  countit
//
//  Created by David Grew on 30/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import Foundation

class CountTargetDto {
    
    private var direction: TargetDirection
    private var value: Int
    private var timePeriod: TargetTimePeriod
    
    init(direction: TargetDirection, value: Int, timePeriod: TargetTimePeriod) {
        self.direction = direction
        self.value = value
        self.timePeriod = timePeriod
    }
    
    init(countTargetForm: CountTargetForm) {
        self.direction = countTargetForm.getDirection()
        self.value = countTargetForm.getValue()
        self.timePeriod = countTargetForm.getTimePeriod()
    }
    
    func getDirection() -> TargetDirection {
        return direction
    }
    
    func getValue() -> Int {
        return value
    }
    
    func getTimePeriod() -> TargetTimePeriod {
        return timePeriod
    }
}
