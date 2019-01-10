//
//  RootViewModel.swift
//  MyMovies
//
//  Created by MAC193 on 1/10/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import Foundation
import RxSwift

enum NavigationStackAction {
    case set(viewModels: [Any], animated: Bool)
    case push(viewModel: Any, animated: Bool)
    case pop(animated: Bool)
}
class RootViewModel : BaseViewModel{
    lazy var navigationStackActions = BehaviorSubject<NavigationStackAction>(value: .set(viewModels: [self.homeViewModel()], animated: false))

    private func homeViewModel() -> HomeViewModel {
        let loginViewModel = HomeViewModel()
        loginViewModel.events.subscribe(onNext: { [weak self] event in
            switch event {
            case .onSearch:
                self?.presentSearch()
                //self?.launchSearchScreen();
            }
        }).disposed(by: disposeBag)
        return loginViewModel
    }
    private func presentSearch(){
        let searchViewModel = SearchViewModel();
        self.navigationStackActions.onNext(NavigationStackAction.push(viewModel: searchViewModel, animated: true))
    }
    
}
