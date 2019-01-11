//
//  MovieListViewController.swift
//  MyMovies
//
//  Created by MAC193 on 1/11/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import UIKit
import MXSegmentedControl

class MovieListViewController: BaseViewController {
    var viewModel : MovieListViewModel!
    
    @IBOutlet var segmentedControl: MXSegmentedControl!
    var pageViewController : UIPageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setUI() {
        super.setUI()
        segmentedControl.append(title: "Now Showing").set(title: #colorLiteral(red: 0.08598647267, green: 0.093843095, blue: 0.1104642078, alpha: 1), for: .selected)
        segmentedControl.append(title: "Comming Soon").set(title: #colorLiteral(red: 0.08598647267, green: 0.093843095, blue: 0.1104642078, alpha: 1), for: .selected)
        segmentedControl.indicator.lineView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    }
    override func setEventBinding() {
        super.setEventBinding()
        viewModel.pagerStackActions.subscribe(onNext: {[weak self] pagerStackAction in
            switch pagerStackAction{
            case .show(let viewModel,let direction,let animated):
                guard let viewController = viewController(forViewModel: viewModel) else { return }
                self?.pageViewController?.setViewControllers([viewController], direction: direction, animated: animated)
            }
        }).disposed(by: disposeBag)
    }
    override func setDataBinding() {
        super.setDataBinding()
    }
    @IBAction func onChangeSegment(_ sender: MXSegmentedControl) {
        switch sender.selectedIndex {
        case 0:
            self.viewModel.onNowShowing()
        default:
            self.viewModel.onComingSoon()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageController = segue.destination as? UIPageViewController{
            self.pageViewController = pageController;
        }
    }
}
