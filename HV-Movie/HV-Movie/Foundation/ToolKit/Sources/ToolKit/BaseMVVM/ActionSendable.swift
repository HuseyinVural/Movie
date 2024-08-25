//
//  ActionSendable.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import Foundation
import UIKit

public protocol ActionSendable {
    associatedtype ActionType
    
    var observer: ((ActionType) -> Void)? { get set }

    func sendAction(_ action: ActionType)
}

public extension ActionSendable {
    func sendAction(_ action: ActionType) {
        @Sendable
        func execute() {
            guard let observer else {
                return
            }
            observer(action)
        }
        
        if Thread.isMainThread {
            execute()
        } else {
            Task {
                await MainActor.run {
                    execute()
                }
            }
        }
    }
}
