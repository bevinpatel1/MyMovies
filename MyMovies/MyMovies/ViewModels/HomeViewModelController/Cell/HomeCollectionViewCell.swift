//
//  HomeCollectionViewCell.swift
//  MyMovies
//
//  Created by MAC193 on 1/10/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import UIKit
import FSPagerView

class HomeCollectionViewCell: FSPagerViewCell {
    static let reuseIdentifier = "HomeCollectionViewCell"
    @IBOutlet var posterImage   : UIImageView!
    @IBOutlet var presaleLabel  : UILabel!
    
    func configure(movie: Movie){
        self.posterImage.downloadImageWithCaching(with: movie.posterPath ?? "")
        self.presaleLabel.isHidden = !(movie.presaleFlag ?? 0 == 1)
    }
}
