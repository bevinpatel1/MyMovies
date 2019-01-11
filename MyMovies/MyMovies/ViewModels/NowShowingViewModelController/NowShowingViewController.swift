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
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getMovies(pageNumber: self.viewModel.pageNumber)
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
        tableView.rx
            .willDisplayCell.filter({[weak self] (cell, indexPath) in
                guard let `self` = self else { return false }
                return (indexPath.row + 1) == self.tableView.numberOfRows(inSection: indexPath.section) - 3
            }).throttle(1.0, scheduler: MainScheduler.instance).map({ event -> Void in
                return Void()
            })
            .bind(to: self.viewModel.loadMoreCall)
            .disposed(by: disposeBag)
    }
}
