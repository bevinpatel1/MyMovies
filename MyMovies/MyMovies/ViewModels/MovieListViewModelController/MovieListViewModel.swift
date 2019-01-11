//
//  MovieListViewModel.swift
//  MyMovies
//
//  Created by MAC193 on 1/11/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MovieListViewModel: BaseViewModel {
    var nowShowingViewController : UIViewController?
    var comingSoonViewController : UIViewController?
    
    init(searchString : String, nowShowingViewController : UIViewController?, comingSoonViewController : UIViewController?) {
        super.init();
        self.nowShowingViewController = nowShowingViewController
        self.comingSoonViewController = comingSoonViewController
    }
}
