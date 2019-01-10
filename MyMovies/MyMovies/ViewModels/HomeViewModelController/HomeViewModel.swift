//
//  HomeViewModel.swift
//  MyMovies
//
//  Created by MAC193 on 1/10/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import Foundation
import RxSwift

class HomeViewModel : BaseViewModel{

    var movieTableData: Observable<[Movie]>
    var movies: Variable<[Movie]> = Variable([])
    
    override init() {
        self.movieTableData = movies.asObservable()
        super.init();
    }
    
    func search(){
        print("Seach On RX");
    }
    func getMovies(nextPage: Int = 1) {
        let parameter = [:] as [String : Any]
        
        API.shared.getHomeList(param: parameter)
            .trackActivity(nextPage == 1 ? isLoading : ActivityIndicator())
            .observeOn(SerialDispatchQueueScheduler(qos: .default))
            .subscribe {[weak self] (event) in
                guard let `self` = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success(let response):
                        self.movies.value = response.results ?? [];
                    case .failure(let error):
                        if error.code == InternetConnectionErrorCode.offline.rawValue {
                            self.alertDialog.onNext((NSLocalizedString("Network error", comment: ""), error.message))
                        } else {
                            self.alertDialog.onNext(("Error", error.message))
                        }
                    }
                default:
                    break
                }
            }.disposed(by: disposeBag)
    }
}
