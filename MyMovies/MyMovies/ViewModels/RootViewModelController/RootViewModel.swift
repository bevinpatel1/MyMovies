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
class RootViewModel{
    let navigationStackActions = BehaviorSubject<NavigationStackAction>(value: .set(viewModels: [HomeViewModel()], animated: false))
}
