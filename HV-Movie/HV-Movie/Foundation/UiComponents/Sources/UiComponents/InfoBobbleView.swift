//
//  InfoBobbleView.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import UIKit
import StyleKit

public class InfoBobbleView: XibView {
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet public weak var title: UILabel!

    public override func viewDidLoad() {
        super.viewDidLoad()
        backgroundColor = .clear
    }
    
    public func setInfoIconType(_ type: InfoType) {
        icon.image = UIImage(named: type.image)
        
    }
    
    public enum InfoType {
        case rank
        case date
        
        var image: String {
            switch self {
            case .rank:
                return "badge"
            case .date:
                return "clock"
            }
        }
    }
}
