//
//  File.swift
//  
//
//  Created by Huseyin Vural on 25.08.2024.
//

import Foundation
import UIKit

// MARK: - Typography
/// `DesignTypography` manages all font styles used in the app.
/// Allows customization of font weights while providing consistent font sizes for different text styles.
public struct DesignTypography {

    /// Font style for titles
    public static func title(weight: UIFont.Weight = .bold) -> UIFont {
        return UIFont.systemFont(ofSize: 19, weight: weight)
    }
    
    /// Font style for subtitles
    public static func subtitle(weight: UIFont.Weight = .semibold) -> UIFont {
        return UIFont.systemFont(ofSize: 22, weight: weight)
    }
    
    /// Font style for body text
    public static func body(weight: UIFont.Weight = .regular) -> UIFont {
        return UIFont.systemFont(ofSize: 12, weight: weight)
    }
    
    /// Font style for captions
    public static func caption(weight: UIFont.Weight = .regular) -> UIFont {
        return UIFont.systemFont(ofSize: 20, weight: weight)
    }
}
