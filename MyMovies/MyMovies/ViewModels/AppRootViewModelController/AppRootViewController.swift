//
//  AppRootViewController.swift
//  MyMovies
//
//  Created by MAC193 on 1/10/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import UIKit
import RxSwift

class AppRootViewController: UINavigationController {
    private let disposeBag = DisposeBag()
    var viewModel: AppRootViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.navigationStackActions.subscribe(onNext: { [weak self] navigationStackAction in
            switch navigationStackAction {
                case .set(let viewModels, let animated):
                    let viewControllers = viewModels.compactMap { viewController(forViewModel: $0) }
                    self?.setViewControllers(viewControllers, animated: animated)
                    
                case .push(let viewModel, let animated):
                    guard let viewController = viewController(forViewModel: viewModel) else { return }
                    self?.pushViewController(viewController, animated: animated)
                    
                case .pop(let animated):
                    _ = self?.popViewController(animated: animated)
                
                case .present(let viewModel, let animated):
                    guard let viewController = viewController(forViewModel: viewModel) else { return }
                    self?.present(viewController, animated: animated)
                
                case .dismiss(let animated):
                    self?.dismiss(animated: animated)
                }
        }).disposed(by: disposeBag)
    }
}
