//
//  MovieDetailViewController.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import UIKit
import ToolKit
import MVVMKit
import UiComponents
import StyleKit

final class MovieDetailViewController<VM: MovieDetailViewModelable>: BaseXibViewController<VM> {
    @IBOutlet private weak var pageName: UILabel!
    @IBOutlet private weak var popButton: ActionIconView!
    @IBOutlet private weak var favoriteButton: ActionIconView!
    @IBOutlet private weak var poster: UIImageView!
    @IBOutlet private weak var spotLabel: UILabel!
    @IBOutlet private weak var caption: UILabel!
    @IBOutlet private weak var categories: UILabel!
    @IBOutlet private weak var rank: InfoBobbleView!
    @IBOutlet private weak var date: InfoBobbleView!
    @IBOutlet private weak var country: InfoBobbleView!
    @IBOutlet private weak var overview: UITextView!
    
    override func bindVieWModelObservers() {
        super.bindVieWModelObservers()
        
        viewModel.observer = { [weak self] action in
            guard let self else { return }
            
            switch action {
            case .bindButtons:
                popButton.icon.image = UIImage(moduleName: "leftArrow", in: .module)
                favoriteButton.icon.image = UIImage(moduleName: "star", in: .module)
                
                favoriteButton.actionButton.addTarget(self, action: #selector(didTapFavButton), for: .touchUpInside)
                popButton.actionButton.addTarget(self, action: #selector(didTapPopButton), for: .touchUpInside)

                rank.setInfoIconType(.rank)
                date.setInfoIconType(.date)
            case .setDetail(let item):
                poster.setImage(from: item.imageURL)
                spotLabel.text = item.tagline
                caption.text = item.title
                categories.text = item.subtitle
                rank.title.text = item.rank
                date.title.text = item.releaseDate
                country.title.text = item.country
                overview.text = item.overview
            case .setFavoriteStatus(let isFavorite):
                favoriteButton.icon.tintColor = isFavorite ? DesignColors.highligh : DesignColors.focus
            case .setPageTitle(let title):
                pageName.text = title
            }
        }
    }
    
    @objc private func didTapFavButton(sender: UIButton!) {
        viewModel.didTapFavoriteButton()
    }
    
    @objc private func didTapPopButton(sender: UIButton!) {
        viewModel.didTapPopButton()
    }
}

