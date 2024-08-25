//
//  Texts.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import Foundation
import LocalizationKit

public extension Texts {
    enum Search: String, KeyLocalizable {
        public var lookPath: Bundle {
            return .module
        }
        
        case placeholder = "state.placeholder"
    }
}
