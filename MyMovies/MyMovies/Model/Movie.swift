//
//  Movie.swift
//  MyMovies
//
//  Created by MAC193 on 1/11/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import UIKit

class Movie : Codable {
    
    var id          : String?
    var title       : String?
    var ageCategory : String?
    var rate        : Float?
    var releaseDate : Double?
    var posterPath  : String?
    var presaleFlag : Int?
    var genreIds    : [Genre]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case ageCategory    = "age_category"
        case rate
        case releaseDate    = "release_date"
        case posterPath     = "poster_path"
        case presaleFlag    = "presale_flag"
        case genreIds       = "genre_ids"
    }
    func formatedGenre()->String{
        if let genreIdsArray = genreIds{
            return genreIdsArray.map({$0.name ?? ""}).joined(separator: ", ")
        }
        else{
            return ""
        }
    }
    var formatedDate: String{
        let date = Date.init(timeIntervalSince1970: TimeInterval.init(releaseDate ?? 0))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: date)
    }
}
