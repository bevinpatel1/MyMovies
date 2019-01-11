//
//  API.swift
//  MyMovies
//
//  Created by MAC193 on 1/10/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

class API {
    static let shared:API = {
        let instance = API()
        return instance
    }()
    init() {
    }
    func getHomeList(param: Parameters) -> Observable<APIResult<GetHomeResponse>> {
        return API.handleDataRequest(dataRequest: APIManager.shared.requestObservable(api: APIRouter.getHomeData(param))).map({ (response) -> APIResult<GetHomeResponse> in
            if (response ?? [:]).keys.contains("Error") {
                if (response ?? [:]).keys.contains("IsInternetOff") {
                    if let isInternetOff = response!["IsInternetOff"] as? Bool {
                        if isInternetOff {
                            return APIResult.failure(error: APICallError(critical: false, code: InternetConnectionErrorCode.offline.rawValue, reason: response!["Error"] as! String, message: response!["Error"] as! String))
                        }
                    }
                }
                return APIResult.failure(error: APICallError(critical: false, code: 1111, reason: response!["Error"] as! String, message: response!["Error"] as! String))
            }
            let apiResponse = GetHomeResponse(response: response)
            let (apiStatus, _) = (true, APICallError.init(status: .success))
            if apiStatus {
                return APIResult.success(value: apiResponse)
            }
        })
    }
    func getListData(param: Parameters) -> Observable<APIResult<GetMovieListResponse>> {
        return API.handleDataRequest(dataRequest: APIManager.shared.requestObservable(api: APIRouter.getListData(param))).map({ (response) -> APIResult<GetMovieListResponse> in
            if (response ?? [:]).keys.contains("Error"){
                if (response ?? [:]).keys.contains("IsInternetOff"){
                    if let isInternetOff = response!["IsInternetOff"] as? Bool{
                        if isInternetOff{
                            return APIResult.failure(error: APICallError(critical: false, code: InternetConnectionErrorCode.offline.rawValue, reason: response!["Error"] as! String, message: response!["Error"] as! String))
                        }
                    }
                }
                return APIResult.failure(error: APICallError(critical: false, code: 1111, reason: response!["Error"] as! String, message: response!["Error"] as! String))
            }
            let apiResponse = GetMovieListResponse(response: response)
            let (apiStatus, _) = (true,APICallError.init(status: .success))
            if apiStatus { return APIResult.success(value: apiResponse) }
        })
    }
    private static func handleDataRequest(dataRequest: Observable<DataRequest>) -> Observable<[String:Any]?> {

        if NetworkReachabilityManager()!.isReachable == false {
            return Observable<[String: Any]?>.create({ (observer) -> Disposable in
                observer.on(.next(["Error":NSLocalizedString("Unable to contact the server", comment: "") ,
                                   "IsInternetOff":true]))
                observer.on(.completed)
                return Disposables.create()
            })
        }
        return Observable<[String: Any]?>.create({ (observer) -> Disposable in
            dataRequest.observeOn(MainScheduler.instance).subscribe({ (event) in
                switch event {
                case .next(let e):
                    plog(e.debugDescription)
                    e.responseJSON(completionHandler: { (dataResponse) in
                        switch dataResponse.result {
                        case .success(let data):
                            guard var json = data as? [String:Any] else {
                                observer.onNext(nil)
                                return
                            }
                            json.updateValue(dataResponse.response!.statusCode, forKey: "status")
                            plog(json.keysToCamelCase)
                            
                            guard dataResponse.response!.statusCode == 200  else {
                                observer.onNext(["Error":json.keysToCamelCase["statusMessage"] ?? "",
                                                 "IsInternetOff":false])
                                return
                            }
                            observer.onNext(json.keysToCamelCase)
                        case .failure(let error):
                            plog(error)
                            let errorCode = (error as NSError).code
                            if errorCode == -1005 || errorCode == -1009 {
                                observer.onNext(["Error": NSLocalizedString("Unable to contact the server", comment: ""),
                                                 "IsInternetOff":true])
                            } else {
                                observer.onNext(["Error":error.localizedDescription,
                                                 "IsInternetOff":false])
                            }
                            observer.onCompleted()
                        }
                    })
                case .error(let error):
                    plog(error)
                    observer.onNext(["Error":error.localizedDescription])
                    observer.onNext(nil)
                    
                case .completed:
                    observer.onCompleted()
                }
            })
        })
    }
}
