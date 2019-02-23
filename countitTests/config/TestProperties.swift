//
//  testProperties.swift
//  countitUITests
//
//  Created by David Grew on 23/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
@testable import countit

class TestProperties: Properties {
    
    private var instructionsDisplayed = false
    
    func getInstructionsDisplayed() -> Bool {
        return instructionsDisplayed
    }
    
    func set(instructionsDisplayed: Bool) {
        self.instructionsDisplayed = instructionsDisplayed
    }
}
