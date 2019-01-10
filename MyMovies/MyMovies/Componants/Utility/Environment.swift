//
//  Environment.swift
//  MyMovies
//
//  Created by MAC193 on 1/10/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import Foundation

enum Server {
    case developement
    case staging
    case production
}
class Environment {
    static let server:Server    =   .developement
    static let debug:Bool       =   true
    
    class func APIBasePath() -> String {
        switch self.server {
            case .developement:
                return "https://easy-mock.com/"
            case .staging:
                return "https://easy-mock.com/"
            case .production:
                return "https://easy-mock.com/"
        }
    }
    
    class func APIVersionPath() -> String {
        switch self.server {
        case .developement:
            return "mock/5c19c6ff64b4573fc81a61f3/movieapp"
        case .staging:
            return "mock/5c19c6ff64b4573fc81a61f3/movieapp"
        case .production:
            return "mock/5c19c6ff64b4573fc81a61f3/movieapp"
        }
    }
}
