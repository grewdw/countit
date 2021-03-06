//
//  UserInstructionServiceImpl.swift
//  countit
//
//  Created by David Grew on 22/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation

class UserInstructionServiceImpl: UserInstructionService {
    
    private let messageBroker: MessageBroker
    private let properties: Properties
    
    init(messageBroker: MessageBroker, properties: Properties) {
        self.messageBroker = messageBroker
        self.properties = properties
        messageBroker.subscribeTo(message: .ITEM_CREATED, withCallback:
            { [weak self] (message: Message, content: Any?) -> Void in self?.received(message: message, content: content) })
    }
}

extension UserInstructionServiceImpl: MessageListener {
    
    func received(message: Message, content: Any?) {
        if message == .ITEM_CREATED {
            properties.set(instructionsDisplayed: true)
        }
    }
}
