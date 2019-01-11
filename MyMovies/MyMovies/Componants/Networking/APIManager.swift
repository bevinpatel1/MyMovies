//
//  APIManager.swift
//  MyMovies
//
//  Created by MAC193 on 1/10/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire

class APIManager {
    
    static let shared:APIManager = {
        let instance = APIManager()
        return instance
    }()
    
    let sessionManager:SessionManager
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.urlCache = nil
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    func requestObservable(api:APIRouter) -> Observable<DataRequest> {
        return sessionManager.rx.request(urlRequest: api)
    }
}
