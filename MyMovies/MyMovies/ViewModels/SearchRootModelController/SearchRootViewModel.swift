//
//  SearchRootViewModel.swift
//  MyMovies
//
//  Created by MAC193 on 1/10/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import Foundation
import RxSwift
class SearchRootViewModel : BaseViewModel{
    lazy var navigationStackActions = BehaviorSubject<NavigationStackAction>(value: .set(viewModels: [self.searchViewModel()], animated: false))

    private func searchViewModel() -> SearchViewModel {
        let searchViewModel = SearchViewModel()
        searchViewModel.events.subscribe(onNext: { [weak self] event in
            switch event {
            case .onMovieList(let searchString):
                self?.showMovieList(searchString: searchString)
            case .onDismiss:
                self?.navigationStackActions.onNext(NavigationStackAction.dismiss(animated: true))
            }
        }).disposed(by: disposeBag)
        return searchViewModel
    }
    private func showMovieList(searchString : String){
        self.navigationStackActions.onNext(NavigationStackAction.push(viewModel: MovieListViewModel(searchString:searchString ,
                                                                                                    nowShowingViewController: self.nowShowingList(searchString: searchString),
                                                                                                    comingSoonViewController: self.comingSoonList(searchString: searchString)), animated: true))
    }
    private func nowShowingList(searchString : String)->UIViewController?{
        return viewController(forViewModel: NowShowingViewModel(searchString: searchString))
    }
    private func comingSoonList(searchString : String)->UIViewController?{
        return viewController(forViewModel: NowShowingViewModel(searchString: searchString))
    }
}
