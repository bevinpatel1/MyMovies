//
//  SearchViewController.swift
//  MyMovies
//
//  Created by MAC193 on 1/10/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: BaseViewController {

    var viewModel : SearchViewModel!;
    let searchBar = UISearchBar()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setUI() {
        super.setUI()
        searchBar.tintColor = UIColor.black
        searchBar.barStyle = .blackTranslucent
        searchBar.showsCancelButton = true
        searchBar.sizeToFit()
        searchBar.becomeFirstResponder();
        self.navigationItem.titleView = searchBar
    }
    override func setEventBinding() {
        searchBar.rx.cancelButtonClicked.subscribe(onNext: {
            self.searchBar.resignFirstResponder();
        }).disposed(by: disposeBag)
        
        self.searchBar.rx.searchButtonClicked.bind(onNext: viewModel.serchTap).disposed(by: disposeBag);
        self.searchBar.rx.text.orEmpty.bind(to: viewModel.searchString).disposed(by: disposeBag)
    }
    override func setDataBinding() {
        viewModel.searchTableData
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = element.title ?? ""
            }
            .disposed(by: disposeBag)
    }
}
