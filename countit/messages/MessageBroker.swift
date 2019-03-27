//
//  MessageBroker.swift
//  countit
//
//  Created by David Grew on 22/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation

protocol MessageBroker {
    
    func subscribeTo(message: Message, withCallback callback: @escaping (Message, Any?) -> Void)
        
    func post(message: Message)
}
