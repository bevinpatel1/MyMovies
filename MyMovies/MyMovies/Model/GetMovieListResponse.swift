//
//  GetMovieListResponse.swift
//  MyMovies
//
//  Created by MAC193 on 1/10/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import Foundation

class GetMovieListResponse: Codable {
    var results: [MovieList]?
    
    init(response: [String: Any]?) {
        guard let response = response else {
            return
        }
        if let moviesList = try? JSONSerialization.data(withJSONObject: response.keysToCamelCase, options: []) {
            if let movieResponse = try? JSONDecoder().decode(GetMovieListResponse.self, from: moviesList) {
                self.results = movieResponse.results
            }
        }
    }
}
