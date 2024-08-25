//
//  EnvManager.swift
//
//
//  Created by Huseyin Vural on 24.08.2024.
//

import Foundation

public protocol EnvManageable {
    var current: Environments { get }
    func setCurrentEnv(_ env: Environments)
}

public class EnvManager: EnvManageable {
    public var current: Environments = .dev
    
    public init(current: Environments = .dev) {
        self.current = current
    }
    
    public func setCurrentEnv(_ env: Environments) {
        current = env
    }
}
