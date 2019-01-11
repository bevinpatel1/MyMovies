//
//  MovieListTableCell.swift
//  MyMovies
//
//  Created by MAC193 on 1/11/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import UIKit
import FloatRatingView

class MovieListTableCell: UITableViewCell {

    
    static let reuseIdentifier = "MovieListTableCell"
    @IBOutlet private weak var posterImageView  : UIImageView!
    @IBOutlet private weak var titleLabel       : UILabel!
    @IBOutlet private weak var ratingLabel      : UILabel!
    @IBOutlet private weak var certificateLabel : UILabel!
    @IBOutlet private weak var releaseLabel     : UILabel!
    @IBOutlet private weak var infoLabel        : UILabel!
    @IBOutlet private weak var ratingFlaotView  : FloatRatingView!
    
    func configure(movie: MovieList){
        self.posterImageView.downloadImageWithCaching(with: movie.posterPath ?? "")
        self.titleLabel.text = movie.title ?? ""
        self.ratingLabel.text = String(format: "%.2f", movie.rate ?? 0.0)
        self.certificateLabel.text = movie.ageCategory ?? ""
        self.releaseLabel.text = "\(movie.releaseDate)"
        self.infoLabel.text = movie.description ?? ""
        self.ratingFlaotView.rating = Double((movie.rate ?? Float(1.0)) / Float(2.0))
    }
}
