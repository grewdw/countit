//
//  UserSettings.swif.swift
//  countit
//
//  Created by David Grew on 12/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation

class UserDefaultsImpl: Properties {
    
    private let INSTRUCTIONS_DISPLAYED = "instructionsDisplayed"
    
    private let userDefaults: UserDefaults
    
    init() {
        userDefaults = UserDefaults.standard
    }
    
    func getInstructionsDisplayed() -> Bool {
        return userDefaults.bool(forKey: INSTRUCTIONS_DISPLAYED)
    }
    
    func set(instructionsDisplayed: Bool) {
        userDefaults.set(instructionsDisplayed, forKey: INSTRUCTIONS_DISPLAYED)
    }
}
