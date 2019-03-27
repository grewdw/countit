//
//  MessageBrokerNcImpl.swift
//  countit
//
//  Created by David Grew on 22/02/2019.
//  Copyright © 2019 David Grew. All rights reserved.
//

import Foundation
import UIKit

class MessageBrokerNcImpl: MessageBroker {
    
    private let notificationCentre = NotificationCenter.default
    
    private var notificationListeners: [Message:[MessageListener]] = [:]
    
    init() {
        notificationCentre.addObserver(self, selector: #selector(notificationReceived(notification:)), name: NSNotification.Name(Message.ITEM_CREATED.rawValue), object: nil)
        notificationCentre.addObserver(self, selector: #selector(notificationReceived(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCentre.addObserver(self, selector: #selector(notificationReceived(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func subscribeTo(message: Message, for listener: MessageListener) {
        if var listenerArray = notificationListeners[message] {
            listenerArray.append(listener)
            notificationListeners.updateValue(listenerArray, forKey: message)
        }
        else {
            notificationListeners.updateValue([listener], forKey: message)
        }
    }
    
    func post(message: Message) {
        notificationCentre.post(name: NSNotification.Name(Message.ITEM_CREATED.rawValue), object: nil)
    }
    
    @objc private func notificationReceived(notification: NSNotification) {
        if let messageType = Message.init(rawValue: notification.name.rawValue) {
            switch messageType {
            case .ITEM_CREATED:
                notify(listeners: notificationListeners[messageType], ofMessage: messageType)
            case .KEYBOARD_HIDE:
                notify(listeners: notificationListeners[messageType], ofMessage: messageType)
            case .KEYBOARD_SHOW:
                guard let userInfo = notification.userInfo else { return }
                guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
                let keyboardFrame = keyboardSize.cgRectValue
                notify(listeners: notificationListeners[messageType], ofMessage: messageType, withContent: keyboardFrame)
            }
            
            notify(listeners: notificationListeners[messageType], ofMessage: messageType)
        }
    }
    
    private func notify(listeners: [MessageListener]?, ofMessage message: Message) {
        if let listenerArray = listeners {
            for listener in listenerArray {
                listener.received(message: message, content: nil)
            }
        }
    }
    
    private func notify(listeners: [MessageListener]?, ofMessage message: Message, withContent content: Any?) {
        if let listenerArray = listeners {
            for listener in listenerArray {
                listener.received(message: message, content: content)
            }
        }
    }
}
