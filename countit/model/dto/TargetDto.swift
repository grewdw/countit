//
//  CountTargetDto.swift
//  countit
//
//  Created by David Grew on 30/12/2018.
//  Copyright © 2018 David Grew. All rights reserved.
//

import Foundation

class TargetDto {
    
    private var direction: TargetDirection
    private var value: Int
    private var timePeriod: TargetTimePeriod
    
    init(direction: TargetDirection, value: Int, timePeriod: TargetTimePeriod) {
        self.direction = direction
        self.value = value
        self.timePeriod = timePeriod
    }
    
    init(targetForm: TargetForm) {
        self.direction = targetForm.getDirection()
        self.value = targetForm.getValue()
        self.timePeriod = targetForm.getTimePeriod()
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
