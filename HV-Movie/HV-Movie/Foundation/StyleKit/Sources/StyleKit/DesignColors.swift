//
//  DesignColors.swift
//  
//
//  Created by Huseyin Vural on 25.08.2024.
//

import Foundation
import UIKit

// MARK: - Color Palette
/// `DesignColors` provides a centralized place to manage all colors used in the app.
/// The colors adapt automatically to the current system theme (light or dark mode).
public struct DesignColors {
    
    /// Background color used for main backgrounds.
    public static var background: UIColor {
        return UIColor.color(named: "BackgroundColor")!
    }
    
    /// Secondary color used for secondary elements like borders or secondary text.
    public static var secondary: UIColor {
        return UIColor.color(named: "SecondaryColor")!
    }
    
    /// Focus color used for elements that need to grab user attention.
    public static var focus: UIColor {
        return UIColor.color(named: "FocusColor")!
    }
    
    /// Text color used for primary text content.
    public static var text: UIColor {
        return UIColor.color(named: "TextColor")!
    }
    
    /// Spot color used for highlighting specific UI elements or important actions.
    public static var spot: UIColor {
        return UIColor.color(named: "SpotColor")!
    }
    
    /// Positive color used for success messages, confirmations, or positive actions.
    public static var positive: UIColor {
        return UIColor.color(named: "PositiveColor")!
    }
    
    /// Highlight text or icons
    public static var highligh: UIColor {
        return UIColor.color(named: "HighlightColor")!
    }
    
}

public extension UIColor {
    static func color(named name: String, bundle: Bundle? = nil) -> UIColor? {
        return UIColor(named: name, in: bundle ?? .module, compatibleWith: nil)
    }
}
