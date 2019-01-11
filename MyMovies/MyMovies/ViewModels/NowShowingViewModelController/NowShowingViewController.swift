//
//  NowShowingViewController.swift
//  MyMovies
//
//  Created by MAC193 on 1/11/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import UIKit
import RxSwift

class NowShowingViewController: BaseViewController {
    var viewModel : NowShowingViewModel!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getMovies(pageNumber: 1)
    }
    override func setUI() {
        super.setUI()
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: MovieListTableCell.reuseIdentifier, bundle: Bundle.main),
                                forCellReuseIdentifier: MovieListTableCell.reuseIdentifier)
    }
    override func setEventBinding() {
        super.setEventBinding()
        viewModel.alertDialog.observeOn(MainScheduler.instance).subscribe(onNext: {[weak self] (title, message) in
            guard let `self` = self else {return}
            self.showAlertDialogue(title: title, message: message)
        }).disposed(by: disposeBag)
        viewModel.isLoading.distinctUntilChanged().drive(onNext: { [weak self] (isLoading) in
            guard let `self` = self else { return }
            self.hideActivityIndicator()
            if isLoading {
                self.showActivityIndicator()
            }
        }).disposed(by: disposeBag)
    }
    override func setDataBinding() {
        super.setDataBinding()
        viewModel.listMoviesObservable
            .bind(to: tableView.rx.items(cellIdentifier: MovieListTableCell.reuseIdentifier, cellType: MovieListTableCell.self)) { (row, element, cell) in
                cell.configure(movie: element)
            }.disposed(by: disposeBag)
    }
}
