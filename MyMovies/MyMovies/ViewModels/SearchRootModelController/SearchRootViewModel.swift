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
        return searchViewModel
    }
}
