//
//  APIRouter.swift
//  MyMovies
//
//  Created by MAC193 on 1/10/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter:URLRequestConvertible {
    
    case getHomeData(Parameters)
    case getMovieDetails(movieId: String, param: Parameters)
    
    
    func asURLRequest() throws -> URLRequest {
        
        var method: HTTPMethod {
            switch self {
            case .getHomeData, .getMovieDetails:
                return .get
            }
        }
        
        let params: ([String: Any]?) = {
            switch self {
            case .getHomeData(let param):
                return param
            case .getMovieDetails(_, let param):
                return param
            }
        }()
        
        let url: URL = {
            
            // Add base url for the request
            let baseURL:String = {
                return Environment.APIBasePath()
            }()
            let apiVersion: String? = {
                return Environment.APIVersionPath()
            }()
            // build up and return the URL for each endpoint
            let relativePath: String? = {
                switch self {
                case .getHomeData:
                    return "home"
                case .getMovieDetails(let id, _):
                    return "movie/\(id)"
                }
            }()
            
            
            var urlWithAPIVersion = baseURL
            
            if let apiVersion = apiVersion {
                urlWithAPIVersion = urlWithAPIVersion + apiVersion
            }
            
            var url = URL(string: urlWithAPIVersion)!
            if let relativePath = relativePath {
                url = url.appendingPathComponent(relativePath)
            }
            return url
        }()
        
        let encoding:ParameterEncoding = {
            return URLEncoding.default
        }()
        
        let headers:[String:String]? = {
            return nil
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        
        return try encoding.encode(urlRequest, with: params)
    }
}
