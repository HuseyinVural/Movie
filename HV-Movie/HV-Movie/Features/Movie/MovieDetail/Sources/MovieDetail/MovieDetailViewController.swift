//
//  MovieDetailViewController.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import UIKit
import ToolKit

final class MovieDetailViewController<VM: MovieDetailViewModelable>: BaseXibViewController<VM> {
    override func bindVieWModelObservers() {
        super.bindVieWModelObservers()
        
        viewModel.observer = { [weak self] action in
            guard let self else { return }
            
            switch action {
            case .setData:
                print("Set data \(self)")
            }
        }
    }
}

