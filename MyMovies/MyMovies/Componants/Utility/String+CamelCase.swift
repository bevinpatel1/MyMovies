//
//  String+CamelCase.swift
//  MyMovies
//
//  Created by MAC193 on 1/10/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import Foundation
import UIKit

extension String {
    /// Underscore string to lowerCamelCase.
    var underscoreToCamelCase: String {
        
        let underscore = CharacterSet(charactersIn: "_")
        var items: [String] = self.components(separatedBy: underscore)
        
        var start: String = items.first ?? ""
        let first = String(start.characters.prefix(1)).lowercased()
        let other = String(start.characters.dropFirst())
        start =  first + other
        
        items.remove(at: 0)
        
        let camelCased: String =  items.reduce(start) { (result, i) -> String in
            result + i.capitalized
        }
        return camelCased
    }
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
