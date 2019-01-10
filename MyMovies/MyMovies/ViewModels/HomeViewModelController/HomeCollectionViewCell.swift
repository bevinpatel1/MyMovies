//
//  HomeCollectionViewCell.swift
//  MyMovies
//
//  Created by MAC193 on 1/10/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "HomeCollectionViewCell"
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var buyButton: UIButton!
    
    var moview  : Movie?{
        didSet{
            
        }
    }
}
