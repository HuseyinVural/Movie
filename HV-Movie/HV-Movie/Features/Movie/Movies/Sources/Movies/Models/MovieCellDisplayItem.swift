//
//  MovieCellDisplayItem.swift
//
//
//  Created by Huseyin Vural on 25.08.2024.
//

import Foundation

/// `MovieCellDisplayItem or OtherDisplayItem` are  plain object designed for presenting movie data in the UI.
/// It serves as a simple data transfer object (DTO), formatting and holding only the
/// necessary information needed by the UI. This object is typically created by a more
/// complex model responsible for processing and preparing the data.
struct MovieCellDisplayItem {
    let id: Int
    let title: String
    let rank: String
    let releaseDate: String
    let overview: String
    let imageURL: URL?
    let moreTile: String
}
