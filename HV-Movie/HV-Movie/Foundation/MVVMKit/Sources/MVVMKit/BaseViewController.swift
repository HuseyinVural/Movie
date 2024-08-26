//
//  File.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import UIKit
import Foundation

open class BaseXibViewController<VM: BaseViewModelable>: UIViewController {
    public var viewModel: VM
    
    public init(viewModel: VM, nibName: String? = nil, bundle: Bundle? = nil) {
        self.viewModel = viewModel
        let nibName = nibName ?? String(describing: type(of: self)).components(separatedBy: "<").first!
        let bundle = bundle ?? Bundle(for: type(of: self))
        
        super.init(nibName: nibName, bundle: bundle)
        bindVieWModelObservers()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("Not supported by Storyboard")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    open func bindVieWModelObservers() {
        viewModel.baseAction = { [weak self] action in
            self?.handleBaseAction(action)
        }
    }
    
    private func handleBaseAction(_ action: CommonActions) {
        switch action {
        case .loading:
            #warning("Add Loading")
        case .error(let message):
            #warning("Add Error Presentation")
        case .closeKeyboard:
            view.endEditing(true)
        }
    }
}
