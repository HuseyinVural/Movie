//
//  SearchView.swift
//  
//
//  Created by Huseyin Vural on 25.08.2024.
//

import UIKit
import StyleKit

class SearchView: XibView {
    @IBOutlet public weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyDefaultStyle()
    }
    
    
    public func setAttributedPlaceholder(_ text: String, color: UIColor) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color
        ]
        searchTextField.attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
    }
    
    private func applyDefaultStyle() {
        backgroundColor = .clear
        searchTextField.text = ""
        setAttributedPlaceholder("", color: DesignColors.focus.withAlphaComponent(0.5))
        searchTextField.font = DesignTypography.body(weight: .medium)
    }
}
