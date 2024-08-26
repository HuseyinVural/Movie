//
//  CommonActions.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import Foundation

/// Action is shared on huge part of base controllers
public enum CommonActions {
    case loading(isHidden: Bool = true)
    case error(String)
    case closeKeyboard
}
