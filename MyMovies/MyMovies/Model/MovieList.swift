//
//  MovieList.swift
//  MyMovies
//
//  Created by MAC193 on 1/11/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import UIKit

class MovieList : Codable {
    
    var id          : String?
    var title       : String?
    var ageCategory : String?
    var rate        : Float?
    var releaseDate : Double?
    var posterPath  : String?
    var presaleFlag : Int?
    var genreIds    : [Genre]?
    var description : String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case ageCategory    = "age_category"
        case rate
        case releaseDate    = "release_date"
        case posterPath     = "poster_path"
        case presaleFlag    = "presale_flag"
        case genreIds       = "genre_ids"
        case description
    }
    func genreString()->String{
        if let genreIdsArray = genreIds{
            return genreIdsArray.map({$0.name ?? ""}).joined(separator: ", ")
        }
        else{
            return ""
        }
    }
}
