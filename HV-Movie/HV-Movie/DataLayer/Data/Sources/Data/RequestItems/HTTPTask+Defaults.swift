//
//  File.swift
//  
//
//  Created by Huseyin Vural on 24.08.2024.
//

import Foundation
import NetworkInterface
import ToolKit


extension HTTPTask {
    var baseURL: URL {
        return DependencyContainer.shared.resolve(EnvManageable.self).current.apiURL(.v3)
    }
    
    /// I am not adding more here as there is no language switching option at the moment. I have added it to be open for expansion.
    var defaultParameters: [String: Any]? {
        let currentLocale = Locale.current
        let languageCode = currentLocale.languageCode ?? "en"
        let regionCode = currentLocale.regionCode ?? "US"
        let localeIdentifier = "\(languageCode)-\(regionCode)"
        
        return ["language": localeIdentifier, "api_key": "fd2b04342048fa2d5f728561866ad52a"]
    }
    
    var authorization: AuthorizationType {
        return .none
    }
}

