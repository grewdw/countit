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
    
    private var notificationListeners: [Message:[(Message, Any?) -> Void]] = [:]
    
    init() {
        notificationCentre.addObserver(self, selector: #selector(notificationReceived(notification:)), name: NSNotification.Name(Message.ITEM_CREATED.rawValue), object: nil)
        notificationCentre.addObserver(self, selector: #selector(notificationReceived(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCentre.addObserver(self, selector: #selector(notificationReceived(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func subscribeTo(message: Message, withCallback callback: @escaping (Message, Any?) -> Void) {
        if var listenerArray = notificationListeners[message] {
            listenerArray.append(callback)
            notificationListeners.updateValue(listenerArray, forKey: message)
        }
        else {
            notificationListeners.updateValue([callback], forKey: message)
        }
    }
    
    func post(message: Message) {
        notificationCentre.post(name: NSNotification.Name(Message.ITEM_CREATED.rawValue), object: nil)
    }
    
    @objc private func notificationReceived(notification: NSNotification) {
        if let messageType = Message.init(rawValue: notification.name.rawValue) {
            switch messageType {
            case .ITEM_CREATED:
                notifylisteners(ofMessage: messageType)
            case .KEYBOARD_HIDE:
                notifylisteners(ofMessage: messageType)
            case .KEYBOARD_SHOW:
                guard let userInfo = notification.userInfo else { return }
                guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
                let keyboardFrame = keyboardSize.cgRectValue
                notifylisteners(ofMessage: messageType, withContent: keyboardFrame)
            }
        }
    }
    
    private func notifylisteners(ofMessage message: Message) {
        let callbacks = notificationListeners[message]
        for callback in callbacks! {
            callback(message, nil)
        }
    }
    
    private func notifylisteners(ofMessage message: Message, withContent content: Any?) {
        let callbacks = notificationListeners[message]
        for callback in callbacks! {
            callback(message, content)
        }
    }
}
