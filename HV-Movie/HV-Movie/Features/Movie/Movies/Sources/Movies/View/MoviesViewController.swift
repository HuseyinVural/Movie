//
//  MoviesViewController.swift
//  
//
//  Created by Huseyin Vural on 25.08.2024.
//

import UIKit
import ToolKit

class MoviesViewController<VM: MoviesViewModelable>: BaseXibViewController<VM> {
    override func bindVieWModelObservers() {
        super.bindVieWModelObservers()
        
        viewModel.observer = { [weak self] action in
            guard let self else { return }
            
            switch action {
            case .refreshMoviesData:
                print("Refresh all data \(self)")
            }
        }
    }
}
