//
//  File.swift
//  
//
//  Created by Huseyin Vural on 26.08.2024.
//

import Foundation

public extension String {
    func toReadableDate(inputFormat: String = "yyyy-MM-dd", to outputFormat: String = "dd MMM yyyy") -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        inputFormatter.locale = Locale.current

        guard let date = inputFormatter.date(from: self) else {
            return nil
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        inputFormatter.locale = Locale.current

        return outputFormatter.string(from: date)
    }
}
