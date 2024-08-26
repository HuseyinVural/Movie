//
//  ActionIconView.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import UIKit
import StyleKit
import ToolKit

public class ActionIconView: XibView {
    @IBOutlet public weak var icon: UIImageView!
    @IBOutlet public weak var actionButton: UIButton!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        backgroundColor = .clear
    }
}
