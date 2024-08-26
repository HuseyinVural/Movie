//
//  ActionSendable.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import Foundation
import UIKit

/// `ActionSendable` is a protocol designed to standardize event communication between layers via an enum.
/// It ensures that actions are dispatched on the main thread, preserving UI thread safety and order.
///
/// - associatedtype ActionType: The type of actions that can be sent.
/// - observer: A closure that handles the action.
/// - sendAction(_ action: ActionType): Sends the action to the observer, ensuring it runs on the main thread.

public protocol ActionSendable {
    associatedtype ActionType
    
    var observer: ((ActionType) -> Void)? { get set }

    func sendAction(_ action: ActionType)
}

public extension ActionSendable {
    func sendAction(_ action: ActionType) {
        if Thread.isMainThread {
            observer?(action)
        } else {
            DispatchQueue.main.async {
                observer?(action)
            }
        }
    }
}
