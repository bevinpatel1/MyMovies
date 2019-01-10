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
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 170, height: 260)
        flowLayout.sectionInset  = UIEdgeInsets(top: 0, left: (Screen.width-170) / 2 , bottom: 0, right: (Screen.width-170) / 2 )
        flowLayout.scrollDirection = .horizontal;
        flowLayout.minimumLineSpacing  = 40
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
        
        self.viewModel.getMovies();
        self.viewModel.movieTableData.bind(to: collectionView.rx.items(cellIdentifier: HomeCollectionViewCell.reuseIdentifier,
                                                                       cellType: HomeCollectionViewCell.self)){ (row, element, cell) in
                                                                        cell.moview = element;
            }.disposed(by: disposeBag)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
