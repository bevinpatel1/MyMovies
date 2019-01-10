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
    case let viewModel as RootViewModel:
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RootViewController") as? RootViewController
        viewController?.viewModel = viewModel
        return viewController
    case let viewModel as HomeViewModel:
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        viewController?.viewModel = viewModel;
        return viewController;
    default:
        return nil
    }
}