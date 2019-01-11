//
//  AppRootViewModel.swift
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
    case present(viewModel: Any, animated : Bool)
    case dismiss(animated : Bool)
}
class AppRootViewModel : BaseViewModel{
    lazy var navigationStackActions = BehaviorSubject<NavigationStackAction>(value: .set(viewModels: [self.homeViewModel()], animated: false))

    override init() {
        super.init()
    }
    private func homeViewModel() -> HomeViewModel {
        let loginViewModel = HomeViewModel()
        loginViewModel.events.subscribe(onNext: { [weak self] event in
            switch event {
            case .onSearch:
                self?.presentSearch()
            }
        }).disposed(by: disposeBag)
        return loginViewModel
    }
    private func presentSearch(){
        self.navigationStackActions.onNext(NavigationStackAction.present(viewModel: SearchRootViewModel(), animated: true))
    }
}
