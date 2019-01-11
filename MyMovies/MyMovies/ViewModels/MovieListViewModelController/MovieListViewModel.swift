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

enum PagerStackAction {
    case show(viewModels : Any,direction : UIPageViewController.NavigationDirection, animated: Bool)
}
class MovieListViewModel: BaseViewModel {
    var pagerStackActions = BehaviorSubject<PagerStackAction>(value: .show(viewModels : NowShowingViewModel(),direction : UIPageViewController.NavigationDirection.forward, animated: false))
    override init() {
        super.init();
    }
    func onNowShowing(){
        self.pagerStackActions.onNext(.show(viewModels: NowShowingViewModel(), direction: .reverse, animated: true))
    }
    func onComingSoon(){
        self.pagerStackActions.onNext(.show(viewModels: ComingSoonViewModel(), direction: .forward, animated: true))
    }
}
