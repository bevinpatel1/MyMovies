//
//  HomeViewController.swift
//  MyMovies
//
//  Created by MAC193 on 1/10/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController {
    
    var viewModel : HomeViewModel!;
    
    @IBOutlet var searchBarButton: UIBarButtonItem!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBinding();
        self.setViews();
    }
    private func setBinding(){
        searchBarButton.rx.tap.bind(onNext: viewModel.search).disposed(by: disposeBag)
        viewModel.alertDialog.observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] (title, message) in
                guard let `self` = self else {return}
                self.showAlertDialogue(title: title, message: message)
            }).disposed(by: disposeBag)
        
        viewModel.isLoading
            .distinctUntilChanged()
            .drive(onNext: { [weak self] (isLoading) in
                guard let `self` = self else { return }
                self.hideActivityIndicator()
                if isLoading {
                    self.showActivityIndicator()
                }
            })
            .disposed(by: disposeBag)
    }
    private func setViews(){
        self.viewModel.getMovies();
        self.viewModel.movieTableData.bind(to: collectionView.rx.items(cellIdentifier: HomeCollectionViewCell.reuseIdentifier)){ (row, element, cell) in
            //cell code
            }.disposed(by: disposeBag)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
