//
//  SearchViewController.swift
//  MyMovies
//
//  Created by MAC193 on 1/10/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {

    var viewModel : SearchViewModel!;
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setUI() {
        super.setUI()
        searchBar.tintColor = UIColor.black;
        searchBar.barStyle = .blackTranslucent
        searchBar.showsCancelButton = true;
        searchBar.sizeToFit()
        self.navigationItem.titleView = searchBar
    }
}
