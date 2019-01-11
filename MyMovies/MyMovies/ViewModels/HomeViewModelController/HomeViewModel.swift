//
//  HomeViewModel.swift
//  MyMovies
//
//  Created by MAC193 on 1/10/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import Foundation
import RxSwift

enum HomeEvent {
    case onSearch
}

class HomeViewModel : BaseViewModel{

    var homeMoviesObservable : Observable<[Movie]>
    var homeMoviesVariable   : Variable<[Movie]> = Variable([])
    let events = PublishSubject<HomeEvent>()
    
    override init() {
        self.homeMoviesObservable = homeMoviesVariable.asObservable()
        super.init()
    }
    func search(){
        events.onNext(.onSearch)
    }
    func getHomeData() {
        let parameter = [:] as [String : Any]
        
        API.shared.getHomeList(param: parameter)
            .trackActivity(isLoading)
            .observeOn(SerialDispatchQueueScheduler(qos: .default))
            .subscribe {[weak self] (event) in
                guard let `self` = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success(let response):
                        self.homeMoviesVariable.value = response.results ?? []
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
