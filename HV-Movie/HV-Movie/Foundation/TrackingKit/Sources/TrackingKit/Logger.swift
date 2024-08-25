//
//  Logger.swift
//
//
//  Created by Huseyin Vural on 26.08.2024.
//

import Foundation

public protocol ErrorLoggable {
    /// Logs the given error along with additional information.
    ///
    /// - Parameters:
    ///   - error: The error to be logged.
    ///   - additionalInfo: Additional information to be included in the log.
    ///
    /// This tool provides a simple abstraction for a basic logging system.
    /// However, it is not linked to any comprehensive tool for this trial project.
    /// Behind this system, a basic logging library is intended to run its operations.
    func log(_ error: Error, with additionalInfo: [String: String])
}

/// This tool is positioned here as a simple exit for tracking tools. For an advanced solution, it is necessary to develop analytical processes with a similar interface.
open class Logger: ErrorLoggable {
    public init() {}
    
    public func log(_ error: Error, with additionalInfo: [String: String]) {
        var modifiedInfo = additionalInfo
        modifiedInfo["Error Description"] = error.localizedDescription
        debugPrint("Detail: \(error), info: \(additionalInfo)")
    }
}
