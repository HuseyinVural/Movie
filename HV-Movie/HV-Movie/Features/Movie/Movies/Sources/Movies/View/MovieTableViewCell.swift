//
//  MovieTableViewCell.swift
//  
//
//  Created by Huseyin Vural on 25.08.2024.
//

import UIKit
import UiComponents
import ToolKit

final class MovieTableViewCell: UITableViewCell {
    @IBOutlet private weak var poster: UIImageView!
    @IBOutlet private weak var caption: UILabel!
    @IBOutlet private weak var rank: InfoBobbleView!
    @IBOutlet private weak var publishDate: InfoBobbleView!
    @IBOutlet private weak var overview: UILabel!
    @IBOutlet weak var showDetailLabel: UILabel!
    private var displayItem: MovieCellDisplayItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        poster.cancelImageLoad(from: displayItem?.imageURL)
    }

    func configure(with item: MovieCellDisplayItem) {
        rank.setInfoIconType(.rank)
        publishDate.setInfoIconType(.date)
        displayItem = item
        poster.setImage(from: item.imageURL)
        caption.text = item.title
        rank.title.text = item.rank
        publishDate.title.text = item.releaseDate
        overview.text = item.overview
        showDetailLabel.text = item.moreTile
    }
}
