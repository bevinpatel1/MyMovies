//
//  Utils.swift
//  MyMovies
//
//  Created by MAC193 on 1/10/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import Foundation
import UIKit

func viewController(forViewModel viewModel: Any) -> UIViewController? {
    switch viewModel {
    case let viewModel as AppRootViewModel:
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppRootViewController") as? AppRootViewController
        viewController?.viewModel = viewModel
        return viewController
    case let viewModel as HomeViewModel:
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        viewController?.viewModel = viewModel;
        return viewController;
    case let viewModel as SearchRootViewModel:
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchRootViewController") as? SearchRootViewController
        viewController?.viewModel = viewModel;
        return viewController;
    case let viewModel as SearchViewModel:
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        viewController?.viewModel = viewModel;
        return viewController;
    default:
        return nil
    }
}
