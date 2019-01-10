//
//  GetHomeResponse.swift
//  MyMovies
//
//  Created by MAC193 on 1/10/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import Foundation

class GetHomeResponse: Codable {
    var results: [Movie]?
    
    init(response: [String: Any]?) {
        guard let response = response else {
            return
        }
        if let homeData = try? JSONSerialization.data(withJSONObject: response.keysToCamelCase, options: []) {
            if let movieResponse = try? JSONDecoder().decode(GetHomeResponse.self, from: homeData) {
                self.results = movieResponse.results
            }
        }
    }
}
class Movie: Codable {

    var id          : String?
    var title       : String?
    var ageCategory : String?
    var rate        : Float?
    var releaseDate : Double?
    var posterPath  : String?
    var presaleFlag : Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case ageCategory    = "age_category"
        case rate
        case releaseDate    = "release_date"
        case posterPath     = "poster_path"
        case presaleFlag    = "presale_flag"
    }
}
