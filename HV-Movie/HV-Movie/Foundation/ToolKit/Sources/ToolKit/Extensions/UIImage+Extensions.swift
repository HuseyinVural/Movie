//
//  File.swift
//  
//
//  Created by Huseyin Vural on 25.08.2024.
//

import UIKit

public extension UIImage {
    /// Initializes a `UIImage` from an asset within your SPM module.
    ///
    /// - Parameters:
    ///   - name: The name of the image asset to load.
    ///   - bundle: The bundle containing the image asset. Defaults to `Bundle.module`.
    ///   - traitCollection: The trait collection to use when selecting the image variant. Defaults to `nil`.
    convenience init?(moduleName name: String, in bundle: Bundle? = nil, compatibleWith traitCollection: UITraitCollection? = nil) {
        self.init(named: name, in: bundle, compatibleWith: traitCollection)
    }
}
