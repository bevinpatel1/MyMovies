//
//  NowShowingViewController.swift
//  MyMovies
//
//  Created by MAC193 on 1/11/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import UIKit

class NowShowingViewController: BaseViewController {
    var viewModel : NowShowingViewModel!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getMovies(pageNumber: 0)
    }
    override func setUI() {
        super.setUI()
        self.tableView.register(UINib(nibName: MovieListTableCell.reuseIdentifier, bundle: Bundle.main),
                                forCellReuseIdentifier: MovieListTableCell.reuseIdentifier)
    }
    override func setEventBinding() {
        super.setEventBinding()
    }
    override func setDataBinding() {
        super.setDataBinding()
        viewModel.listMoviesObservable
            .bind(to: tableView.rx.items(cellIdentifier: MovieListTableCell.reuseIdentifier, cellType: MovieListTableCell.self)) { (row, element, cell) in
                cell.configure(movie: element)
            }.disposed(by: disposeBag)
    }
}
