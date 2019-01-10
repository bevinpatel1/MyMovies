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
import FSPagerView

class HomeViewController: BaseViewController{
    
    var viewModel : HomeViewModel!;
    
    @IBOutlet var searchBarButton: UIBarButtonItem!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var pagerView: FSPagerView!
    @IBOutlet var movieNameLabel: UILabel!
    @IBOutlet var movieTypeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getMovies();
    }
    override func setUI() {
        super.setUI();
        self.configureFSPager();
    }
    private func configureFSPager(){
        self.pagerView.register(UINib(nibName: HomeCollectionViewCell.reuseIdentifier, bundle:nil), forCellWithReuseIdentifier: HomeCollectionViewCell.reuseIdentifier)
        self.pagerView.isInfinite = true
        self.pagerView.automaticSlidingInterval = 3.0
        self.pagerView.itemSize = CGSize(width: 170, height: 260)
        
        self.pagerView.transformer = FSPagerViewTransformer(type:.linear)
        self.pagerView.transformer?.minimumScale = 0.9
    }
    override func setEventBinding() {
        super.setEventBinding();
        searchBarButton.rx.tap.bind(onNext: viewModel.search).disposed(by: disposeBag)
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
        super.setDataBinding();
        
        self.viewModel.movies.asObservable().observeOn(MainScheduler.instance).subscribe(onNext: {[weak self] _ in
            guard let `self` = self else {return}
            self.pagerView.reloadData()
            self.titleLabel.isHidden = self.viewModel.movies.value.count > 0 ? false : true;
            self.movieNameLabel.text = self.viewModel.movies.value.first?.title ?? ""
            self.movieTypeLabel.text = self.viewModel.movies.value.first?.genreString() ?? ""
        }).disposed(by: disposeBag)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension HomeViewController : FSPagerViewDelegate,FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return viewModel.movies.value.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.reuseIdentifier, at: index) as! HomeCollectionViewCell
        cell.configure(movie: viewModel.movies.value[index])
        return cell
    }
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        let page = pagerView.currentIndex
        self.movieNameLabel.text = self.viewModel.movies.value[Int(page)].title ?? ""
        self.movieTypeLabel.text = self.viewModel.movies.value[Int(page)].genreString()
    }
}
