//
//  BaseViewModel.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import Foundation

public protocol BaseViewModelable: LifeCycleObservable, AnyObject {
    var baseAction: ((CommonActions) -> Void)? { get set }
}

open class BaseViewModel: BaseViewModelable {
    /// It contains shared actions
    public var baseAction: ((CommonActions) -> Void)?
    
    /// Can add default operation
    open func viewDidLoad() {}
    
    /// Can add default operation
    open func viewWillAppear() {}
    
    public init() {}
    
    public func sendAction(_ action: CommonActions) {
        if Thread.isMainThread {
            baseAction?(action)
        } else {
            DispatchQueue.main.async {
                self.baseAction?(action)
            }
        }
    }
}
