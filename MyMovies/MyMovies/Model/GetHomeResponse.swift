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
            if let homeResponse = try? JSONDecoder().decode(GetHomeResponse.self, from: homeData) {
                self.results = homeResponse.results
            }
        }
    }
}
