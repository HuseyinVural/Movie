//
//  InfoBobbleView.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import UIKit
import StyleKit
import ToolKit

public class InfoBobbleView: XibView {
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet public weak var title: UILabel!

    public override func viewDidLoad() {
        super.viewDidLoad()
        backgroundColor = .clear
    }
    
    public func setInfoIconType(_ type: InfoType) {
        icon.image = UIImage(moduleName: type.image, in: .module)
    }
    
    public enum InfoType {
        case rank
        case date
        case vote
        
        var image: String {
            switch self {
            case .rank:
                return "badge"
            case .date:
                return "clock"
            case .vote:
                return "vote"
            }
        }
    }
}
