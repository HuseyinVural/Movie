//
//  XibView.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import Foundation
import UIKit

open class XibView: UIView {
    @IBOutlet var contentView: UIView!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func viewDidLoad() {}
    
    private func commonInit() {
        let nibName = String(describing: type(of: self))
        let bundle = Bundle.module
        bundle.loadNibNamed(nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewDidLoad()
    }
}
