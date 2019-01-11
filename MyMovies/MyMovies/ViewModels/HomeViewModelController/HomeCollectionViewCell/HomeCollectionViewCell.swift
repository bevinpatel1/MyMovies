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
    @IBOutlet private var posterImage   : UIImageView!
    @IBOutlet private var buyButton     : UIButton!
    @IBOutlet private var presaleLabel  : UILabel!
    
    func configure(movie: Movie){
        self.posterImage.downloadImageWithCaching(with: movie.posterPath ?? "")
        self.presaleLabel.isHidden = !(movie.presaleFlag ?? 0 == 1)
        self.clipsToBounds = false
    }
    override var isSelected: Bool{
        didSet{
            if isSelected{
                buyButton.superview?.backgroundColor = UIColor(displayP3Red: 31/255, green: 43/255, blue: 82/255, alpha: 1);
                buyButton.isHidden = false
            }else{
                buyButton.superview?.backgroundColor = UIColor.clear;
                buyButton.isHidden = true
            }
        }
    }
}
