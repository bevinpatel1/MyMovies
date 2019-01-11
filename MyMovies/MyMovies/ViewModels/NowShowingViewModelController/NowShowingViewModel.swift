//
//  NowShowingViewModel.swift
//  MyMovies
//
//  Created by MAC193 on 1/11/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class NowShowingViewModel: BaseViewModel {
    
    var listMoviesObservable    : Observable<[MovieList]>
    var listMoviesVariable      : Variable<[MovieList]> = Variable([])
    
    override init() {
        self.listMoviesObservable = listMoviesVariable.asObservable()
        super.init();
    }
    func getMovies(pageNumber : Int = 1) {
        let parameter = [:] as [String : Any]
        
        API.shared.getListData(param: parameter)
            .trackActivity(pageNumber==1 ? isLoading : ActivityIndicator())
            .observeOn(SerialDispatchQueueScheduler(qos: .default))
            .subscribe {[weak self] (event) in
                guard let `self` = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success(let response):
                        self.listMoviesVariable.value = response.results ?? [];
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
