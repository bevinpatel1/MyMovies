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
    
    let searchString            : String!
    var pageNumber              : NSInteger = 1
    var listMoviesObservable    : Observable<[MovieList]>
    var listMoviesVariable      : Variable<[MovieList]>  = Variable([])
    var loadMoreCall            : PublishSubject<Void>   = PublishSubject<Void>()
    
    init(searchString : String) {
        self.searchString = searchString;
        self.listMoviesObservable = listMoviesVariable.asObservable()
        super.init();
        
        self.loadMoreCall.asObservable().subscribe(onNext:{[weak self] _ in
            guard let `self` = self else {return}
            self.getMovies(pageNumber: self.pageNumber)
        }).disposed(by: disposeBag)
    }
    func getMovies(pageNumber : NSInteger) {
        let parameter = ["keyword":searchString ?? "", "type":"nowshowing", "offset":pageNumber] as [String : Any]
        
        API.shared.getListData(param: parameter)
            .trackActivity(pageNumber==1 ? isLoading : ActivityIndicator())
            .observeOn(SerialDispatchQueueScheduler(qos: .default))
            .subscribe {[weak self] (event) in
                guard let `self` = self else { return }
                switch event {
                case .next(let result):
                    switch result {
                    case .success(let response):
                        self.pageNumber += 1
                        self.listMoviesVariable.value.append(contentsOf: response.results ?? []);
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
